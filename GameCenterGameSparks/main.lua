-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local idVerify = require( "plugin.idVerifySig" )
local gameNetwork = require( "gameNetwork" )
local json = require ( "json" );


local gameCenterAuthentication
local availabilityCallback
local connectToGameSpark
local signatureListerner
local initCallback
local onSystemEvent


--
-- Gamespark functions
--

local gameSparkApiKey = ""
local gameSparkApiSecret = ""
local playerId = ""
local alias = ""

gameCenterAuthentication = function(url, salt, signature, timeStamp)
    local requestBuilder = gs.getRequestBuilder()
    local gameCenterConnectRequest = requestBuilder.createGameCenterConnectRequest()

    gameCenterConnectRequest:setPublicKeyUrl(url)
    gameCenterConnectRequest:setSalt(salt)
    gameCenterConnectRequest:setSignature(signature)
    gameCenterConnectRequest:setDisplayName(alias)
    gameCenterConnectRequest:setExternalPlayerId(playerId)
    gameCenterConnectRequest:setTimestamp(timeStamp)

    gameCenterConnectRequest:send(function(response)
        local json = require "json"
        print("Auth Request Response:", json.prettify(response))
    end)
end

availabilityCallback = function(event)
    print("availability:", event)

    if event == true then
        idVerify.init( signatureListerner )
        gameNetwork.init( "gamecenter", initCallback ) 
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

-- 
-- Signature Plugin function
--
signatureListerner = function( event )
    print(json.prettify(event))

    if event.isError == false then
        gameCenterAuthentication(event.keyURL, event.salt, event.signature, event.timestamp);
    end

end

--
-- GameCenter Function
--
initCallback = function( event )
    print(json.prettify(event))

    if event.type == "showSignIn" then
        
    elseif event.type == "init" then
        gameNetwork.request("loadLocalPlayer" , { listener=initCallback })
       
    elseif event.type == "loadLocalPlayer" then
        playerId = event.data.playerID
        alias = event.data.alias

        idVerify.getSignature()

    end
end

--
-- Other
--
onSystemEvent = function( event )
    if event.type == "applicationStart" then
        connectToGameSpark()
    end
end

Runtime:addEventListener( "system", onSystemEvent )





