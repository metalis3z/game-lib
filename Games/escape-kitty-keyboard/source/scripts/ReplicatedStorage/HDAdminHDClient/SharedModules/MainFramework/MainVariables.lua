

local v1 = {}
local u2 = _G.HDAdminMain
function v1.SetupMainVariables(_, p3) 

	u2.hdAdminGroup = {
		["Id"] = 4676369,
		["Info"] = {}
	}
	u2.hdAdminGroupInfo = {}
	u2.settingsBanRecords = {}
	u2.alphabet = {
		"a",
		"b",
		"c",
		"d",
		"e",
		"f",
		"g",
		"h",
		"i",
		"j",
		"k",
		"l",
		"m",
		"n",
		"o",
		"p",
		"q",
		"r",
		"s",
		"t",
		"u",
		"v",
		"w",
		"x",
		"y",
		"z"
	}
	u2.UserIdsFromName = {}
	u2.UsernamesFromUserId = {}
	u2.validSettings = {
		"AppTheme",
		"NoticeSoundId",
		"NoticeVolume",
		"NoticePitch",
		"ErrorSoundId",
		"ErrorVolume",
		"ErrorPitch",
		"Alert2SoundId",
		"AlertVolume",
		"AlertPitch",
		"Prefix"
	}
	u2.commandInfoToShowOnClient = {
		"Name",
		"Contributors",
		"Prefixes",
		"Rank",
		"Aliases",
		"UndoAliases",
		"Tags",
		"Description",
		"Args",
		"Loopable",
		"IsBooster",
		"IgnoreDisplay",
		"CanUndo",
		"Groups",
		"DisabledByOwner",
		"Override",
		"EmoteId",
		"SortRandomToTop"
	}
	u2.productCooldown = 60
	u2.products = {
		["Booster"] = 1007884962,
		["LaserEyes"] = 1007746205,
		["Donor"] = 5745895
	}
	u2.accessories = {
		["Booster"] = 91265843061691,
		["Booster2"] = 78104307094868
	}
	u2.materials = {
		"Plastic",
		"Wood",
		"Concrete",
		"CorrodedMetal",
		"DiamondPlate",
		"Foil",
		"Grass",
		"Ice",
		"Marble",
		"Granite",
		"Brick",
		"Pebble",
		"Sand",
		"Fabric",
		"SmoothPlastic",
		"Metal",
		"WoodPlanks",
		"Cobblestone",
		"Neon",
		"Glass"
	}
	u2.rankTypes = {
		["Auto"] = 4,
		["Perm"] = 3,
		["Server"] = 2,
		["Temp"] = 1
	}
	if p3 == "Server" then
		u2.pd = {}
		u2.sd = {}
		u2.permissions = {
			["friends"] = 0,
			["freeAdmin"] = 0,
			["vipServerOwner"] = 0,
			["vipServerPlayer"] = 0,
			["owner"] = true,
			["specificUsers"] = {},
			["gamepasses"] = {},
			["assets"] = {},
			["groups"] = {}
		}
		u2.commandInfo = {}
		u2.commandRanks = {}
		u2.infoOnAllCommands = {
			["Contributors"] = {},
			["Tags"] = {},
			["Prefixes"] = {},
			["Aliases"] = {},
			["UndoAliases"] = {},
			["ChatCommands"] = {},
			["Override"] = {}
		}
		u2.morphNames = {}
		u2.toolNames = {}
		u2.commands = {}
		u2.playersRanked = {}
		u2.playersUnranked = {}
		u2.settings.UniversalPrefix = "!"
		u2.settings.ChatPrefix = "/"
		u2.serverAdmins = {}
		u2.owner = {}
		u2.ownerId = game.CreatorId
		u2.isGroupGame = false
		if game.CreatorType == Enum.CreatorType.Group then
			local v4 = nil
			local v5 = nil
			for _ = 1, 10 do
				v4, v5 = pcall(function()

					return u2.groupService:GetGroupInfoAsync(game.CreatorId).Owner
				end)
				if v4 then
					break
				end
				task.wait(1)
			end
			if v4 then
				u2.ownerId = v5.Id
				u2.ownerName = v5.Name
				u2.isGroupGame = true
			end
		end
		local v6, v7 = pcall(function()

			return u2.marketplaceService:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
		end)
		local v8 = not v6 and {
			["Name"] = "GameNameFailedToLoad"
		} or v7
		u2.gameInfo = v8
		u2.gameName = v8.Name
		u2.listOfTools = {}
		u2.ranksAllowedToJoin = 0
		u2.permissionToReplyToPrivateMessage = {}
		u2.logs = {
			["command"] = {},
			["chat"] = {}
		}
		u2.isStudio = u2.runService:IsStudio()
		u2.serverBans = {}
		u2.blacklistedVipServerCommands = {}
		u2.banned = {}
		u2.commandBlocks = {}
		for u9 = 1, 3 do
			pcall(function()

				u2.physicsService:RegisterCollisionGroup("Group" .. u9)
			end)
		end
		u2.physicsService:CollisionGroupSetCollidable("Group1", "Group2", false)
	elseif p3 == "Client" then
		u2.qualifiers = {
			"me",
			"all",
			"others",
			"random",
			"admins",
			"nonAdmins",
			"friends",
			"nonFriends",
			"NBC",
			"BC",
			"TBC",
			"OBC",
			"R6",
			"R15",
			"rthro",
			"nonRthro"
		}
		u2.colors = {}
		u2.topbarEnabled = true
		u2.blur = Instance.new("BlurEffect", u2.camera)
		u2.blur.Size = 0
		u2.commandMenus = {}
		u2.commandsToDisableCompletely = {
			["laserEyes"] = true,
			["dance"] = true
		}
		u2.commandsActive = {}
		u2.commandsAllowedToUse = {}
		u2.commandsWithMenus = {
			["Type1"] = {
				["laserEyes"] = { "Info", "Press and hold to activate." },
				["fly"] = { "Input", "Speed" },
				["fly2"] = { "Input", "Speed" },
				["noclip"] = { "Input", "Speed" },
				["noclip2"] = { "Input", "Speed" }
			},
			["Type2"] = {
				["cmdbar2"] = {}
			},
			["Type3"] = {
				["chatHijacker"] = {}
			},
			["Type17"] = {
				["dance"] = { "Input", "Speed" }
			}
		}
		u2.commandSpeeds = {
			["fly"] = 50,
			["fly2"] = 50,
			["noclip"] = 100,
			["noclip2"] = 25,
			["dance"] = 1
		}
		for v10, v11 in pairs(u2.commandSpeeds) do
			local v12 = u2.settings.CommandLimits[v10]
			if v12 then
				local v13 = v12.Limit
				if v13 < v11 then
					u2.commandSpeeds[v10] = v13
				end
			end
		end
		u2.infoFramesViewed = {
			["Speed"] = true
		}
	end
	table.sort(u2.settings.Ranks, function(p14, p15)
		return p14[1] < p15[1]
	end)
end
return v1