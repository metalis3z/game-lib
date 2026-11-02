local module = {}

local Network = require(game:GetService("ReplicatedStorage").Modules.Network)
local AchievementUtil = require(game.ReplicatedStorage.Modules.AchievementUtil)
local Util = require(game.ReplicatedStorage.Modules.Util)
local Sounds = require(game.ReplicatedStorage.Modules.Sounds)
local Actors = require(game.ReplicatedStorage.Modules.Actors)
local ServerUtil = require(game.ServerScriptService.Server.Modules.ServerUtil)
local safecall = ServerUtil.SafeCall
local GlobalConfig = require(game.ServerStorage.AeternusConfig)

local DeviceTypes = {
	"PC",
	"Mobile",
	"Console"
}

module.Start = function()
	
	Network:SetConnection("SetDevice", "REMOTE_EVENT", function(Player : Player, Type)
		if not table.find(DeviceTypes, Type) then return end
		Player:SetAttribute("Device", Type)
	end)
	
	if not workspace:GetAttribute("ServerType") then
		local serverType = game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0 and "VIP" or "Standard"
		workspace:SetAttribute("ServerType", serverType)
		if serverType == "VIP" then
			workspace:SetAttribute("ServerOwnerID", game.PrivateServerOwnerId)
		end
	end
	
	local maps = game.ServerStorage.Assets.Maps:GetChildren()
	local currentMaps = {}
	for _, map in pairs(maps) do
		local config = map:FindFirstChild("Config")
		if not config then warn(`[MISCHANDLER] {map.Name} does not have a config`) continue end
		local success, config = safecall(require, config)
		if not success then continue end
		if config.Variants then
			for variant in pairs(config.Variants) do
				table.insert(currentMaps, map.Name.."/"..variant)
			end
		else
			table.insert(currentMaps, map.Name)
		end
	end
	workspace:SetAttribute("MapNames", table.concat(currentMaps, "|"))
	
	Network:SetConnection("PlayerLoaded", "REMOTE_EVENT", function(Player : Player)
		Player:SetAttribute("Loaded",true)
		AchievementUtil:IncrementAchievementProgress(Player, "Welcome")
		if workspace:GetAttribute("Testing") then
			Player.Character.PrimaryPart.CFrame = workspace.StudioAssets.studiooo.SpawnLocation.CFrame
		end
	end)

	Network:SetConnection("UpdateSettings", "REMOTE_EVENT", function(Player : Player, Setting, Value, ...)
		print(Player,Setting,Value,...)
		
		
		if (not Setting) or (not Player.PlayerData.Settings:IsAncestorOf(Setting)) then return end

		if Value==nil then
			local parent = Setting.Parent
			if not parent:IsA("Folder") then return end

			local settingType = parent.Name
			local settingName = Setting.Name
			local defaultFolder = game.ServerScriptService.Server.Systems.Data.PlayerData.Template.Settings
			local typeFolder = defaultFolder:FindFirstChild(settingType)
			if not typeFolder then return end

			local defaultSetting = typeFolder:FindFirstChild(settingName)
			if not defaultSetting then return end

			Value = defaultSetting.Value
		end

		if typeof(Setting.Value) ~= typeof(Value) then
			return
		end
		if (Setting:GetAttribute("MaxValue") or Setting:GetAttribute("MinValue")) and (Value > Setting:GetAttribute("MaxValue") or Value < Setting:GetAttribute("MinValue")) then
			return
		end
		if Setting.Parent.Name == "Keybinds" and (not Enum.KeyCode[Value]) then
			return
		end
		if Setting:GetAttribute("Options") and (not table.find(string.split(Setting:GetAttribute("Options"), "|"), Value)) then
			return
		end

		Setting.Value = Value
	end)
	
	Network:SetConnection("SurvivorRequest", "REMOTE_FUNCTION", function(Player : Player, RequestedChar: Model, Requested : string)
		local Actor = Actors.CurrentActors[Player]
		if not Actor then return end
		local RequestedActor = Actors.CurrentActors[game.Players:GetPlayerFromCharacter(RequestedChar)]
		if typeof(Requested) ~= "string" then return end
		if (not RequestedActor) and (not RequestedActor.Rig) or (not RequestedActor.Rig.Parent) or (not RequestedActor.Rig:FindFirstChildOfClass("Humanoid")) or RequestedActor.Rig:FindFirstChildOfClass("Humanoid").Health <= 0 or (not RequestedActor.Config) or (not RequestedActor.Config.Requests) or (not RequestedActor.Config.Requests[Requested]) or (not RequestedActor.Cooldowns) then
			return "Whatever you're trying to do here, don't."
		end

		local Request = RequestedActor.Config.Requests[Requested]
		local Ability = Request.AbilityName
		local Changed = false

		if RequestedChar:GetAttribute("Requested_"..Ability) then
			return "Please wait before requesting again."
		end
		if type(RequestedActor.Cooldowns[Ability]) == "number" and (RequestedActor.Cooldowns[Request.AbilityName] - workspace:GetServerTimeNow()) > 0 then
			return RequestedActor.Config.DisplayName.." has that ability on cooldown for "..math.ceil(RequestedActor.Cooldowns[Request.AbilityName] - workspace:GetServerTimeNow()).."s."
		end

		RequestedChar:SetAttribute("Requested_"..Ability,Player.Name)
		Actors:CreateChatInteraction(Player.Character,`Requests/{Requested}`,RequestedChar)
		Network:FireClientConnection(game.Players:GetPlayerFromCharacter(RequestedChar) , "SurvivorRequested", "REMOTE_EVENT", Player, Requested)

		RequestedChar.AttributeChanged:Connect(function(attr)
			if attr == "Requested_"..Ability then
				Changed = true
			end
		end)

		task.delay(10,function()
			if (not Changed) and RequestedChar.Parent then
				RequestedChar:SetAttribute("Requested_"..Ability,nil)
			end
		end)
	end)
	
	Network:SetConnection("UpdateLogToLatest", "REMOTE_EVENT", function(Player : Player)
		if GlobalConfig.UpdateLogOnce == false then return end
		local plrData = Player:FindFirstChild("PlayerData")
		if not plrData then return end
		local LastSeenLog = plrData:FindFirstChild("Misc") and plrData.Misc.LastSeenLog
		if not LastSeenLog then return end
		if LastSeenLog.Value == game.ReplicatedStorage.Assets.Changelogs:GetAttribute("LatestLog") then return end
		LastSeenLog.Value = game.ReplicatedStorage.Assets.Changelogs:GetAttribute("LatestLog")
	end)
	
	task.delay(5, function()
		game:GetService("MessagingService"):SubscribeAsync("GlobalMessages", function(info)
			local data = string.split(info.Data, "||")
			local msg = data[1]
			local sender = data[2]
			Network:FireAllClientConnection("SendAnnouncement", "REMOTE_EVENT", msg, (("From: %*"):format(sender)));
		end)
	end)
	
	local Info = game.ReplicatedStorage.VersionInfo
	Info.PlaceVersion.Value = game.PlaceVersion
	Info.Updated.Value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Updated
end

return module