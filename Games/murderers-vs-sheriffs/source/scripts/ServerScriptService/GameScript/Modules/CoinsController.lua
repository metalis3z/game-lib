--!nocheck
export type CoinInfo = {
	Current: number,
	Max: number,
}

export type RewardInfo = {
	Prize: string,
	Type: string,
	Amount: number,
}

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local Constants = require(script.Constants)
local DataService = require(ServerScriptService.GameScript.DataModule)
local Trove = require(ServerStorage:WaitForChild("Trove"))

local CoinSystem = {}
CoinSystem.__index = CoinSystem

function CoinSystem.new(PlayerProfiles: {}, CurrentMap: Model)
	local self = setmetatable({}, CoinSystem)

	self.Trove = Trove.new()
	self.Map = CurrentMap
	self.SpawnTimer = 0
	self.SpawnDelay = Constants.SpawnDelay
	self.MaxOnField = Constants.MaxCoinAmount
	self.Spawned = 0
	local CustomLimits = {
		Player1 = 1000,
		Player2 = 1000,
		Player3 = 3,
	}
	self.Data = {}
	for name, _ in pairs(PlayerProfiles) do
		local player = game.Players:FindFirstChild(name)
		if player then
			self.Data[name] = {}
			for id, settings in pairs(Constants.Data) do
				local limit
				if CustomLimits[name] then
					limit = CustomLimits[name]
				else
					limit = player:GetAttribute("Elite") and settings.Max.Elite or settings.Max.Default
				end
				self.Data[name][id] = { Current = 0, Max = limit } :: CoinInfo
			end
		end
	end


	local MapRoot = ServerStorage.Database.Maps:FindFirstChild(CurrentMap.Name)
	self.Areas = MapRoot and MapRoot:FindFirstChild("CoinAreas") and MapRoot.CoinAreas:GetChildren() or {}

	self.Container = Instance.new("Model")
	self.Container.Name = "CoinContainer"
	self.Container.Parent = CurrentMap

	self:Initialize()
	return self
end

function CoinSystem:Initialize()

	if Constants.SpawnEnabled == false then return end
	if game.ReplicatedStorage.Remotes.Gameplay.RoundState.CurrentGamemode.Value == "SnowballFight" then return end
	for name, data in pairs(self.Data) do
		local player = game.Players:FindFirstChild(name)
		if player then
			ReplicatedStorage.Remotes.Gameplay.CoinsStarted:FireClient(player, data)
		end
	end

	self.Trove:Connect(RunService.Heartbeat, function()
		if os.clock() - self.SpawnTimer >= self.SpawnDelay and self:HasRoomToSpawn() then
			self.SpawnTimer = os.clock()
			self:Spawn()
		end
	end)
end

function CoinSystem:HasRoomToSpawn()
	return #self.Container:GetChildren() < self.MaxOnField
end

function CoinSystem:CanPickup(player: Player, id: string)
	local info = self.Data[player.Name] and self.Data[player.Name][id]
	return info and info.Current < info.Max
end

function CoinSystem:RandomCoinType()
	local total = 0
	for _, v in pairs(Constants.Data) do
		total += v.Chances
	end

	local pick = math.random(1, total)
	local current = 0

	for id, info in pairs(Constants.Data) do
		current += info.Chances
		if pick <= current then
			return id
		end
	end

	return next(Constants.Data)
end

function CoinSystem:RandomSpawnPosition()
	local area = self.Areas[math.random(1, #self.Areas)]
	if not area then return end
	if not self.Areas then return end
	local offset = Vector3.new(
		math.random(-area.Size.X / 2, area.Size.X / 2),
		0.5,
		math.random(-area.Size.Z / 2, area.Size.Z / 2)
	)
	return area.CFrame:ToWorldSpace(CFrame.new(offset))
end

function CoinSystem:CreateCoin()
	local coinId = self:RandomCoinType()
	local config = Constants.Data[coinId]
	local spawnCFrame = self:RandomSpawnPosition()

	local coinBase = Constants.Server_Part:Clone()
	local sound = config.Sound:Clone()
	local model = config.Model

	local visual
	if config.RandomSpawn then
		local choices = model:GetChildren()
		if #choices == 0 then return end
		visual = choices[math.random(1, #choices)]:Clone()
	else
		visual = model:Clone()
	end

	visual.Name = "CoinVisual"
	visual.Anchored = false
	visual.CanCollide = false

	local spawnCF = CFrame.new(spawnCFrame.Position) * CFrame.Angles(visual.CFrame:ToEulerAnglesXYZ())
	visual.CFrame = spawnCF
	coinBase.CFrame = spawnCF

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = visual
	weld.Part1 = coinBase
	weld.Parent = coinBase

	visual.Parent = coinBase
	sound.Name = "Sound"
	sound.Parent = coinBase

	coinBase:SetAttribute("CoinName", coinId)
	coinBase:SetAttribute("CoinID", coinId)
	coinBase:AddTag("CoinVisual")
	coinBase.Parent = self.Container

	self.Spawned += 1
	return coinBase
end

function CoinSystem:Spawn()
	local coin = self:CreateCoin()
	if not coin then return end

	self.Trove:Connect(coin.Touched, function(hit: BasePart)
		local char = hit.Parent
		local player = game.Players:GetPlayerFromCharacter(char) or (char and game.Players:GetPlayerFromCharacter(char.Parent))
		if player and not coin:GetAttribute("Collected") and self:CanPickup(player, coin:GetAttribute("CoinName")) then
			coin:SetAttribute("Collected", true)
			coin.Sound:Play()
			self:HandlePickup(player, coin:GetAttribute("CoinName"))
		end
	end)
end

function CoinSystem:HandlePickup(player: Player, id: string)
	local entry = self.Data[player.Name][id]
	entry.Current += 1
	local full = entry.Current >= entry.Max

	ReplicatedStorage.Remotes.Gameplay.CoinCollected:FireClient(player, id, entry.Current, entry.Max)

	local rewards = Constants.Data[id].Reward
	if not rewards then return end

	for _, reward: RewardInfo in ipairs(rewards) do
		if reward.Type == "Currency" then
			DataService.Give(player, reward.Prize or "Coins", reward.Amount or 1)
		elseif reward.Type == "Weapons" or reward.Type == "Pets" or reward.Type == "Materials" then
			DataService.GiveItem(player, reward.Prize or "whiteout", reward.Amount or 1, reward.Type)
		else
			DataService.GiveOther(player, reward.Prize, reward.Type)
		end
	end
	ReplicatedStorage.Insight.CoinCollected:Fire(player)

end

function CoinSystem:Destroy()
	self.Trove:Destroy()
	table.clear(self)
end

return CoinSystem
