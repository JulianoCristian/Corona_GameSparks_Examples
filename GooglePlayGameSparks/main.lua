-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local gpgs = require( "plugin.gpgs" )

local googlePlayServicesListerner
local googleAuthentication
local googlePlayServicesListerner
local availabilityCallback
local onSystemEvent
local googleCode = ""

local gameSparkApiKey = "xxx"
local gameSparkApiSecret = "xxx"
local googleClientId = "xxx"

googleAuthentication = function(code)
    local requestBuilder = gs.getRequestBuilder()
    local googlePlayConnectRequest = requestBuilder.createGooglePlusConnectRequest()

    googlePlayConnectRequest:setCode(code)

    googlePlayConnectRequest:send(function(response)
        local json = require "json"
        print("Auth Request Response:", json.prettify(response))
    
    end)
end

availabilityCallback = function(event)
    print("availability:", event)

    if event == true then
        gpgs.enableDebug()
        gpgs.init( googlePlayServicesListerner )   
    end
end

connectToGameSpark = function()
    local GS = require("plugin.gamesparks")
    gs = createGS()
    gs.setApiKey(gameSparkApiKey) -- Use your apiKey
    gs.setApiSecret(gameSparkApiSecret) -- Use your api secret
    gs.setAvailabilityCallback(availabilityCallback)

    gs.connect()
end

googlePlayServicesListerner = function(event)
    local json = require( "json" )
    print("+++Google Play Event:", json.prettify(event))
    
    if event.isError == false then
        if event.name == "init" then
            gpgs.login( {userInitiated = true, listener = googlePlayServicesListerner} )

        elseif event.name == "login" and event.phase == "logged in" then
            gpgs.getServerAuthCode( {serverId=googleClientId, listener = googlePlayServicesListerner} )

        elseif event.name == "getServerAuthCode" then 
            googleCode = event.code
            googleAuthentication(event.code)
                
        end
    end
end


onSystemEvent = function( event )
    if event.type == "applicationStart" then
        connectToGameSpark()
    end
end

Runtime:addEventListener( "system", onSystemEvent )





