--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	license =
    {
        google =
        {
            key ="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1/kVfOp6aPF2hgcWu2J0rycwDssTYURELvte/T52viMXnM1K96VmbC1sk110vnMNTpsMElRMyOzqvy5KkyLZ2VTMiuOReZPXhGsz5ocFO8AsiEiKWoNqXPI7XHOmB15jSac6qc0ulD17MIEPOaZvH8teOa/PsK/0u3rt0WrwLzOjdk98Vp62Xf7wlybOGl5EM6B/RG2GdVoCAcJE8KSj7MhzSD9tkTNZGVh7anByEbYsmoqsc3UP1FnHS0EjrzOfQnWVGPL/BITnM54FIpE5N2MIEyjEZ8gI+qv6SaIkEagdGBIcGGmOjcrxE2yZ9j8kLvuFp/wD7+orO6C0lGkFsQIDAQAB",
            policy = "serverManaged"
        },
    },
	content =
	{
		width = 320,
		height = 480, 
		scale = "letterbox",
		fps = 60,
		
		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		--]]
	},
}
