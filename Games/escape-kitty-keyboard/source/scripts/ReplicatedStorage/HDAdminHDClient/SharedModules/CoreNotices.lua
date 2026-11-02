

local v1 = {}
local u2 = _G.HDAdminMain
function v1.GetNotice(_, p3) 

	return ({
		["WelcomeRank"] = {
			u2.hdAdminCoreName,
			"Your rank is \'%s\'! Click to view the commands.",
			{ "ShowSpecificPage", "Commands", "Commands" }
		},
		["WelcomeBooster"] = {
			u2.hdAdminCoreName,
			"Your\'re a Booster! Click to view Booster Commands.",
			{ "OpenCommands", "Booster" }
		},
		["SetRank"] = { u2.hdAdminCoreName, "You\'ve been %sed to \'%s\'!" },
		["UnlockRank"] = { u2.hdAdminCoreName, "You\'ve unlocked the rank \'%s\'!" },
		["UnRank"] = { u2.hdAdminCoreName, "You\'ve been unranked!" },
		["UnRankFrom"] = { u2.hdAdminCoreName, "You\'ve been permUnranked from \'%s\'!" },
		["DisabledByOwner"] = { u2.hdAdminCoreName, "This command has been disabled by the game owner." },
		["ParserInvalidCommandRank"] = { u2.hdAdminCoreName, "\'%s\' is not a valid command! Try \'%srank plr %s\' instead." },
		["ParserInvalidCommandNormal"] = { u2.hdAdminCoreName, "\'%s\' is not a valid command!", "" },
		["ParserInvalidPrefix"] = { u2.hdAdminCoreName, "Invalid prefix! Try \'%s%s\' instead." },
		["ParserInvalidVipServer"] = { u2.hdAdminCoreName, "You cannot use \'%s\' in VIP Servers." },
		["ParserInvalidBooster"] = { u2.hdAdminCoreName, "You must be a Booster to use that command!" },
		["ParserInvalidLoop"] = { u2.hdAdminCoreName, "You do not have permission to use Loop commands!" },
		["ParserInvalidRank"] = { u2.hdAdminCoreName, "You do not have permission to use \'%s\'" },
		["ParserBuyRank"] = { u2.hdAdminCoreName, "Buy \'%s\' to unlock this command permanently" },
		["ParserCommandBlock"] = { u2.hdAdminCoreName, "Commands are temporarily disabled.\'" },
		["ParserInvalidRigType"] = { u2.hdAdminCoreName, "%s must be %s to use that command." },
		["ParserPlayerRankBlocked"] = { u2.hdAdminCoreName, "You do not have the permissions to use \'%s\' on %s!" },
		["ParserSpeakerRank"] = { u2.hdAdminCoreName, "You %sed %s to \'%s\'" },
		["ParserSpeakerUnrank"] = { u2.hdAdminCoreName, "You unranked %s" },
		["ParserPlrPunished"] = { u2.hdAdminCoreName, "%s must be unpunished to use that command." },
		["ReceivedPM"] = { u2.hdAdminCoreName, "You have a message from %s! Click to open." },
		["RemovePermRank"] = { u2.hdAdminCoreName, "Successfully unranked %s!" },
		["BroadcastSuccessful"] = { u2.hdAdminCoreName, "Broadcast successful! Your announcement will appear shortly." },
		["BroadcastFailed"] = { u2.hdAdminCoreName, "Broadcast failed to send." },
		["InformPrefix"] = { u2.hdAdminCoreName, "The server prefix is \'%s\'" },
		["GetSoundSuccess"] = { u2.hdAdminCoreName, "The ID of the sound playing is: %s" },
		["GetSoundFail"] = { u2.hdAdminCoreName, "No sound is playing!" },
		["UnderControl"] = { u2.hdAdminCoreName, "You\'re being controlled by %s!" },
		["ClickToTeleport"] = { "Teleport", "Click to teleport to \'%s\' [%s]" },
		["BanSuccess"] = {
			u2.hdAdminCoreName,
			"Successfully banned %s! Click to view the Banland.",
			{ "ShowSpecificPage", "Moderation", "Banland" }
		},
		["UnBanSuccess"] = { u2.hdAdminCoreName, "Successfully unbanned %s!" },
		["QualifierLimitToSelf"] = { u2.hdAdminCoreName, "\'%ss\' can only use commands on theirself!" },
		["QualifierLimitToOnePerson"] = { u2.hdAdminCoreName, "\'%ss\' can only use commands on one person at a time!" },
		["ScaleLimit"] = { u2.hdAdminCoreName, "The ScaleLimit is %s for ranks below \'%s\'" },
		["RequestsLimit"] = { u2.hdAdminCoreName, "You\'re sending requests too fast!" },
		["AlertFail"] = { u2.hdAdminCoreName, "Alert failed to send." },
		["PollFail"] = { u2.hdAdminCoreName, "Poll failed to send." },
		["GearBlacklist"] = { u2.hdAdminCoreName, "Cannot insert gear: %s. This item has been blacklisted." },
		["BanFailLength"] = { u2.hdAdminCoreName, "%sBan Length must be greater than 0!" },
		["BanFailVIPServer"] = { u2.hdAdminCoreName, "%s\'permBan\' is prohibited on VIP Servers!" },
		["BanFailAllServers"] = { u2.hdAdminCoreName, "You do not have permission to ban players from \'all servers\'." },
		["BanFailAlreadyBanned"] = { u2.hdAdminCoreName, "%splayer has already been banned!" },
		["BanFailRobloxRejected"] = { u2.hdAdminCoreName, "%s%s" },
		["BanFailPermission"] = { u2.hdAdminCoreName, "You do not have permission to ban %s" },
		["BanFailDataNotFound"] = { u2.hdAdminCoreName, "%sData not found." },
		["RestoreDefaultSettings"] = { "Settings", "Successfully restored all settings to default!" },
		["CommandBarLocked"] = { u2.hdAdminCoreName, "You do not have permission to use the commandBar%s! Rank required: \'%s\'" },
		["FollowFail"] = { u2.hdAdminCoreName, "Failed to teleport. %s is not in-game." },
		["SaveMap1"] = { u2.hdAdminCoreName, "Saving a copy of the map..." },
		["SaveMap2"] = { u2.hdAdminCoreName, "Map successfully saved!" },
		["CommandLimit"] = { u2.hdAdminCoreName, "The %s limit is %s for ranks below \'%s\'" },
		["CommandLimitPerMinute"] = { u2.hdAdminCoreName, "Sending commands too fast! CommandLimitPerMinute exceeded." },
		["template"] = { u2.hdAdminCoreName, "" }
	})[p3]
end
return v1