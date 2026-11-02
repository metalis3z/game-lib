local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local PhysService = game:GetService("PhysicsService")
local PlayerGroup = PhysService:RegisterCollisionGroup("p")
PhysService:CollisionGroupSetCollidable("p","p",false)
local Items = game.ServerScriptService:FindFirstChild("Assets")
local Assets = game.ServerStorage:FindFirstChild("Assets")
local Server = script.Parent
local Data = require(Server.Data)
local GetStatsModule = require(Server.Parent.Functions.GetRealStats)
local bags = require(game.ReplicatedStorage.Modules.Equipment.Bags).Bags
local MarketPlace = game:GetService("MarketplaceService")

local Equipment = {}

function NoCollide(model)
	spawn(function()
		model:WaitForChild("Humanoid")
		model:WaitForChild("HumanoidRootPart")
		model:WaitForChild("Head")
		for k,v in pairs(model:GetChildren()) do
			if v:IsA"BasePart" then
				v.CollisionGroup = "p"
				--PhysService:SetPartCollisionGroup(v,"p")
			end
		end
	end)
end

function GetGamepasses(Player, PData)
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 49998955) then
		game.ReplicatedStorage.Remotes.Boost:Fire(Player, "x2 Convert Rate Pass", 1)
	end
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 50000061) then
		game.ReplicatedStorage.Remotes.Boost:Fire(Player, "x2 Pollen from Bees Pass", 1)
	end
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 50000000) then
		game.ReplicatedStorage.Remotes.Boost:Fire(Player, "x2 Pollen from Tools Pass", 1)
	end
end

function GetPermBoosts(Player, PData)
	local BearsWithBoost = {
		["Plush Bear"] = "Plush Boost",
		["Resin Bear"] = "Resin Aura",
		["Master Bear"] = "Master Boost",
	}

	for i,v in pairs(BearsWithBoost) do
		if PData.QuestsGivers[i].TotalQuests > 0 then
			PData.Boosts[v] = nil
			game.ReplicatedStorage.Remotes.Boost:Fire(Player, v, PData.QuestsGivers[i].TotalQuests)
		end
	end
end
local function PlatformDist(Hive, HRP)
	if (HRP.Position - Hive.Position).Magnitude <= 10 then
		return true
	else
		return false
	end
end

function Equipment.StartTimers(Player: Player)
	local PData = Data:Get(Player)
	task.defer(function()
		while Player do task.wait(1)
			PData.Badges.Playtime.Amount += 1
			PData.Vars.PlaytimeOnServer += 1

			if PData.AllStats.Health < 100 then
				PData.AllStats.Health += 1
				if PData.AllStats.Health > 100 then
					PData.AllStats.Health = 100
				end
				game.ReplicatedStorage.Remotes.DataUpdated:FireClient(Player, {"AllStats", "Health", PData.AllStats["Health"]})
			end

			for i,v in pairs(PData.Cooldowns) do
				if v then
					if v - os.time() <= 0 then
						PData.Cooldowns[i] = nil
					end
				end
			end

			for Name, Boost in PData.Boosts do
				if Boost.Time - os.time() <= 0 then
					PData.Boosts[Name] = nil
				end
			end

			if PData.Vars.Making and PData.Vars.Hive ~= "" and not PlatformDist(workspace.Hives[PData.Vars.Hive].Pad.Circle, Player.Character.HumanoidRootPart) then
				PData.Vars.Making = false
			end
			local Character = Player.Character or Player.CharacterAdded:Wait()
			Character.Humanoid.WalkSpeed = 24 * (PData.AllStats["Player Movespeed"] / 100)
			--Player:WaitForChild('Character'):WaitForChild('Humanoid').WalkSpeed = 24 * (PData.AllStats["Player Movespeed"] / 100)
			Character.Humanoid.JumpHeight = 8.2 * (PData.AllStats["Jump Power"] / 100)

			GetStatsModule.GetRealStats(Player, PData)
			game.ReplicatedStorage:FindFirstChild("Remotes").DataUpdated:FireClient(Player, {"Boosts", PData.Boosts})
			game.ReplicatedStorage:FindFirstChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
			game.ReplicatedStorage:FindFirstChild("Remotes").DataUpdated:FireClient(Player, {"Vars", PData.Vars})
			game.ReplicatedStorage:FindFirstChild("Remotes").DataUpdated:FireClient(Player, {"Badges", "Playtime", PData.Badges.Playtime})
		end
	end)
end

local LoadedItems = {
	["Bag"] = true,
	["Tool"] = true,
	["Boot"] = true,
	["Belt"] = true,
	["Glove"] = true,
	["Hat"] = true,
	["RGuard"] = true,
	["LGuard"] = true,
}

function Equipment.Load(Player)
	local PData = Data:Get(Player)
	local Character = Player.Character
	local StarterGui = game.ReplicatedStorage.StarterGui
	
	_G.owners = {
		[3797367313] = true, -- олег
		[1912490] = true, -- онет iбанiй
		[2205916357] = true -- дима докс сват спортики
	};
	_G.admins = {
		[4741296327] = true, -- нCOCK
		[3547173204] = true, -- андрюха
		[655777561] = true -- кублион (сигма вроде бы)
	};
	_G.developers = {
		[2061281838] = true, -- печенька
		[2556582565] = true --гризлик
	};
	_G.managers = {
	};
	_G.moderators = {
	};

	if(_G.owners[Player.UserId]) then
		PData.IStats.Rank = "OWNER"
	elseif(_G.admins[Player.UserId]) then
		PData.IStats.Rank = "ADMIN"
	elseif(_G.developers[Player.UserId]) then
		PData.IStats.Rank = "DEVELOPER"
	elseif(_G.managers[Player.UserId]) then
		PData.IStats.Rank = "MANAGER"
	elseif(_G.moderators[Player.UserId]) then
		PData.IStats.Rank = "MODERATOR"
	end

	for _index, Gui in StarterGui:GetChildren() do
		Gui:Clone().Parent = Player.PlayerGui
	end
	if not workspace.PlayersE:FindFirstChild(Player.Name) then
		local PlrE = Instance.new("Folder")
		PlrE.Name = Player.Name
		PlrE.Parent = workspace.PlayersE
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local TokensF = Instance.new("Folder")
		TokensF.Name = "Tokens"
		TokensF.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local BeesF = Instance.new("Folder")
		BeesF.Name = "Bees"
		BeesF.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local EEeesF = Instance.new("Folder")
		EEeesF.Name = "Effects"
		EEeesF.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
		local Totems = Instance.new("Folder")
		Totems.Name = "Totems"
		Totems.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local PlayerHydrants = Instance.new("Folder")
		PlayerHydrants.Name = "Hydrants"
		PlayerHydrants.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	Equipment:EquipItem(Player, "Bag")
	Equipment:EquipItem(Player, "Tool")
	Equipment:EquipItem(Player, "Boot")
	Equipment:EquipItem(Player, "Belt")
	Equipment:EquipItem(Player, "Glove")
	Equipment:EquipItem(Player, "Hat")
	Equipment:EquipItem(Player, "RGuard")
	Equipment:EquipItem(Player, "LGuard")
	if not PData.IStats["Tutorial"] then
		PData.Inventory["Basic Egg"] += 1
		game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
	end
	if PData.Boosts ~= {} then
		for BoostName, Info in pairs(PData.Boosts) do
			if Info == BoostName then
				PData.Boosts[BoostName] = nil
			end
		end
	end
	if PData.IStats.Rank ~= "Player" then
		for _, object in game.ServerStorage.Developer.Button:GetChildren() do
			object:Clone().Parent = Player.PlayerGui.UI.Btns
		end

		for _, object2 in game.ServerStorage.Developer.Tab:GetChildren() do
			object2:Clone().Parent = Player.PlayerGui.UI.Tabs
		end
	end

	--if PData.Equipment.Hydrant ~= "" then
	--	PData.Inventory["Hydrant Builder"] = 1
	--	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
	--end

	--for _, Bee in pairs(PData.Bees) do
	--	if Bee.BeeName ~= "" then
	--		Bee.ELimit = math.round(require(game.ReplicatedStorage.Bees[Bee.BeeName]).Energy + (Bee.Level*Bee.Level/1.5))
	--	end
	--end

	for i,v in pairs(PData.Inventory) do
		if v < 0 then
			v = 0
		end
	end

	Character.Humanoid.WalkSpeed = 24 * (PData.AllStats["Player Movespeed"] / 100)
	Character.Humanoid.JumpHeight = 7.2 * (PData.AllStats["Jump Power"] / 100)
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Boosts", PData.Boosts})

	if PData.IStats.Banned then
		Player:Kick("Banned. Join our Discord Server and contact the developers.")
	end

	require(script.Parent.Parent.Functions.GetCapacity).GetCapacity(Player)
	GetGamepasses(Player, PData)
	NoCollide(Character)
	
	GetStatsModule.GetRealStats(Player, PData)
end

function Equipment:EquipItem(Player, Type)
	local PData = Data:Get(Player)
	local Character = Player.Character
	local Humanoid = Character:WaitForChild("Humanoid")

	if PData.Equipment[Type] then
		local Item = PData.Equipment[Type]
		local ItemObject

		if Item ~= "" then
			if Type == "Boot" then
				for i = 1, 2 do
					ItemObject = Items:WaitForChild(Type.."s")[Item .. (i == 1 and "L" or "R")]:Clone()
					Humanoid:AddAccessory(ItemObject)
					ItemObject.Name = Type
				end
			elseif Type == "Glove" then
				for i = 1, 2 do
					ItemObject = Items:WaitForChild(Type.."s")[Item .. (i == 1 and "L" or "R")]:Clone()
					Humanoid:AddAccessory(ItemObject)
					ItemObject.Name = Type
				end
			else
				ItemObject = Items:WaitForChild(Type.."s")[Item]:Clone()
				if ItemObject:IsA("Accessory") then
					Humanoid:AddAccessory(ItemObject)
					ItemObject.Name = Type

					if Type == "Bag" then
						Assets.BagScript:Clone().Parent = ItemObject
					end
				elseif ItemObject:IsA("Tool") then
					local CollectorScripts = Assets.CollectorScripts:Clone()
					CollectorScripts.Parent = ItemObject
					ItemObject.Parent = Character
					ItemObject.Name = "Tool"
				else
					ItemObject.Parent = Character
				end
			end
		end
	end
end

return Equipment