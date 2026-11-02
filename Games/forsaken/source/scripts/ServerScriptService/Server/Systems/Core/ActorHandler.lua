local module = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Network = require(ReplicatedStorage.Modules.Network)
local Actors = require(ReplicatedStorage.Modules.Actors)
local ServerUtil = require(game.ServerScriptService.Server.Modules.ServerUtil)
local safecall = ServerUtil.SafeCall

local Rigs = game:GetService("ServerStorage").Assets.Rigs
-- i know rigs in the real forsaken are first stored in replicatedstorage, shut up, its easier and safer this way.

local QueryHitboxType = "Pivot"

Network:SetConnection('UseActorAbility', 'REMOTE_EVENT', function(Player: Player, Name : string)
	print(Name)
	local Actor = Actors.CurrentActors[Player]
	local Config = Actor.Config
	local Behavior = Actor.CustomBehavior or Actor.Behavior
	local Abilities = Behavior.Abilities
	if not Actor:CanUseAbility(Name) then
		return
	end
	local Ability = Abilities[Name]
	local Charges = Ability.CurrentCharges
	local Time = tonumber(Config and typeof(Config) == "table" and Config.Cooldown or typeof(Ability.Cooldown) == "function" and Ability.Cooldown(Actor, Name) or Ability.Cooldown or Config[`{Name}Cooldown`] or Actor[("%*Cooldown"):format(Name)]) or 0;
	if workspace:GetAttribute('CooldownsDisabled') then
		Time = 0
	end
	if Charges then
		Charges-=1
		if not workspace:GetAttribute('ChargesDisabled') then
			Actor:IncrementCharges(Name, -1, 1e999);
		end
		Network:FireClientConnection(Player, "UpdateAbilityCharges", "REMOTE_EVENT", Name, Charges);
	end
	Actor:SetCooldownOf(Name, Time)
	if Ability  then
		local result = Ability.Callback(Actor)
		Network:FireClientConnection(Player, 'UseActorAbility', 'REMOTE_EVENT', Name, result)
	else
		Network:FireClientConnection(Player, 'UseActorAbility', 'REMOTE_EVENT', Name)
	end
	
	if Player.Character and Player.Character:GetAttribute("Requested_"..Name) then
		local requester = Player.Character:GetAttribute("Requested_"..Name)
		if game.Players:FindFirstChild(requester) then
			Actors:CreateChatInteraction(game.Players[requester].Character, "Thanks/Thanks", Player.Character)
			Player.Character:SetAttribute("cRequested_"..Name, nil)
		end
	end
end)

function module.Start()
	pcall(function()
		for i, v in ipairs(game:GetDescendants()) do
			if v:IsA("Shirt") and v:FindFirstChild("BACKUP_ID") then
				v.ShirtTemplate = v:FindFirstChild("BACKUP_ID").Value
			elseif v:IsA("Pants") and v:FindFirstChild("BACKUP_ID") then
				v.PantsTemplate = v:FindFirstChild("BACKUP_ID").Value
			end
		end
	end)
	
	for _, config in pairs(ReplicatedStorage.Assets:GetDescendants()) do
		if config.Name == "Config" and config:IsA("ModuleScript") and config:FindFirstAncestor("Survivors") or config:FindFirstAncestor("Killers") then
			local rigType = config.Parent.Parent.Name == "Killers" and "Killers" or config.Parent.Parent.Name == "Survivors" and "Survivors" or config.Parent.Parent.Parent.Parent.Name == "Skins" and "Skins"
			if not rigType then
				continue
			end
			local actorType
			local actorName
			local skinName
			if rigType == "Skins" then
				actorType = config.Parent.Parent.Parent.Name
				actorName = config.Parent.Parent.Name
				skinName = config.Parent.Name
			else
				actorType = config.Parent.Parent.Name
				actorName = config.Parent.Name
			end
			local rig = Rigs:FindFirstChild(actorType) and Rigs[actorType]:FindFirstChild(actorName) and Rigs[actorType][actorName]:FindFirstChild(skinName or "Default")
			if not rig then
				warn("[ACTORHANDLER] NO RIG FOUND FOR "..config.Parent:GetFullName())
			end
			local success, result = pcall(function()
				require(config).Rig = rig
			end)
			if not success then
				warn("[ACTORHANDLER] "..config.Parent.Name..":", result)
			end
		end
	end
end

return module