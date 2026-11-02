--Written by LeitrisArcade
--PUT ME IN SERVERSCRIPTSERVICE

--SETTINGS--------------------------------------------------------------------------------------------------------------------------------------------------
whitelist				= {"Builderman","LeitrisArcade"} --Add/Edit names on whitelist with commas and quotation marks (you don't have to put your own name)
kickMessage				= "You were kicked because you're not on the whitelist!" --Message that is displayed to kicked players
blockCamera				= true --Block kicked player's camera? (true/false)
notify					= true --Notify players when a player is kicked? (true/false)
notificationDuration	= 5 --Duration of notification in seconds
notifySound				= true --Play a sound when a player is kicked? (true/false)
notificationSoundId		= 261072074 --ID of notification sound
notificationVolume		= 1 --How loud the notification sound is (0-1)
printToOutput			= true --Print to the server output whenever someone is kicked? (true/false)
------------------------------------------------------------------------------------------------------------------------------------------------------------

local module = {}
module.GetSettings	= function()
	return({whitelist,kickMessage,blockCamera,notify,notificationDuration,notifySound,notificationSoundId,notificationVolume,printToOutput})
end
return module