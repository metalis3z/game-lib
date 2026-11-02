local module = {}



-- << RETRIEVE MAIN FRAMEWORK >>
local main = _G.HDAdminMain



-- << MAIN VARIABLES >>
function module:SetupMainVariables(location)
	main.hdAdminGroup = {
		Id = 4676369;
		Info = {};
	}
	main.hdAdminGroupInfo = {}
	
	main.settingsBanRecords = {}
	main.alphabet = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
	main.UserIdsFromName = {}
	main.UsernamesFromUserId = {}
	main.validSettings = {"Theme", "NoticeSoundId", "NoticeVolume", "NoticePitch", "ErrorSoundId", "ErrorVolume", "ErrorPitch", "AlertSoundId", "AlertVolume", "AlertPitch", "Prefix"}
	main.commandInfoToShowOnClient = {"Name", "Contributors", "Prefixes", "Rank", "Aliases", "Tags", "Description", "Args", "Loopable"}
	main.products = {
		Donor = 5745895;
		OldDonor = 2649766;
	}
	main.materials = {"Plastic", "Wood", "Concrete", "CorrodedMetal", "DiamondPlate", "Foil", "Grass", "Ice", "Marble", "Granite", "Brick", "Pebble", "Sand", "Fabric", "SmoothPlastic", "Metal", "WoodPlanks", "Cobblestone", "Neon", "Glass",}
	main.rankTypes = {
		["Auto"] = 4;
		["Perm"] = 3;
		["Server"] = 2;
		["Temp"] = 1;
	}
	
	if location == "Server" then
		
		main.pd = {}
		main.sd = {}
		main.permissions = {
			specificUsers = {};
			gamepasses = {};
			assets = {};
			groups = {};
			friends = 0;
			freeAdmin = 0;
			vipServerOwner = 0;
			vipServerPlayer = 0;
			owner = true
		}
		
		main.commandInfo = {}
		main.commandRanks = {}
		main.infoOnAllCommands = {
			Contributors = {};	--table
			Tags = {};			--table
			Prefixes = {};		--dictionary
			Aliases = {};		--dictionary
		}
	
		main.morphNames = {}
		main.toolNames = {}
		
		main.commands = {}
		main.playersRanked = {}
		main.playersUnranked = {}
		main.settings.UniversalPrefix = "!";
		main.serverAdmins = {}
		main.owner = {}
		main.ownerId = game.CreatorId
		if game.CreatorType == Enum.CreatorType.Group then
			local success, ownerInfo
			for i = 1, 10 do
				success, ownerInfo = pcall(function() return main.groupService:GetGroupInfoAsync(game.CreatorId).Owner end)
				if success then
					break
				end
				task.wait(1)
			end
			if success then
				main.ownerId = ownerInfo.Id
				main.ownerName = ownerInfo.Name
			end
		end
		local success, gameInfoOrWarning = pcall(function()
			return main.marketplaceService:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
		end)
		local gameInfo = {
			Name = "GameNameFailedToLoad"
		}
		if success then
			gameInfo = gameInfoOrWarning
		end
		main.gameInfo = gameInfo
		main.gameName = gameInfo.Name
		main.listOfTools = {}
		main.ranksAllowedToJoin = 0
		main.permissionToReplyToPrivateMessage = {}
		main.logs = {
			command = {};
			chat = {};
		}
		main.isStudio = main.runService:IsStudio()
		main.serverBans = {}
		main.blacklistedVipServerCommands = {}
		main.banned = {}
		main.commandBlocks = {}
		
		--Collisions
		for i = 1,3 do
			pcall(function() main.physicsService:RegisterCollisionGroup("Group"..i) end)
		end
		main.physicsService:CollisionGroupSetCollidable("Group1", "Group2", false)
		
		
	elseif location == "Client" then
		
		main.qualifiers = {"me", "all", "others", "random", "admins", "nonAdmins", "friends", "nonFriends", "NBC", "BC", "TBC", "OBC", "R6", "R15", "rthro", "nonRthro"}
		main.colors = {}
		main.topbarEnabled = true
		main.blur = Instance.new("BlurEffect", main.camera)
		main.blur.Size = 0
		
		main.commandMenus = {}
		main.commandsToDisableCompletely = {laserEyes=true}
		main.commandsActive = {}
		main.commandsAllowedToUse = {}
		main.commandsWithMenus = {
			["Type1"] = {
				["laserEyes"] = {"Info", "Press and hold to activate."};
				["fly"] = {"Input", "Speed"};
				["fly2"] = {"Input", "Speed"};
				["noclip"] = {"Input", "Speed"};
				["noclip2"] = {"Input", "Speed"};
			};
			["Type2"] = {
				["cmdbar2"] = {};
			};
			["Type3"] = {
				["bubbleChat"] = {};
			};
		}
		main.commandSpeeds = {
			fly = 50;
			fly2 = 50;
			noclip = 100;
			noclip2 = 25;
		}
		for commandName, defaultSpeed in pairs(main.commandSpeeds) do
			local setting = main.settings.CommandLimits[commandName]
			if setting then
				local limit = setting.Limit
				if defaultSpeed > limit then
					 main.commandSpeeds[commandName] = limit
				end
			end
		end
		
		main.infoFramesViewed = {
			Speed = true;
		}

	end
	
	table.sort(main.settings.Ranks, function(a,b) return a[1] < b[1] end)
	
end



return module