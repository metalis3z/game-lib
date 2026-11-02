local Players = game:GetService("Players")

local PassiveAuraConfig = require(script.Parent.Parent.Config.PassiveAuraConfig)

local PassiveAuraService = {}
PassiveAuraService.__index = PassiveAuraService

function PassiveAuraService.new()
	return setmetatable({
		FastTickEndsAt = {},
	}, PassiveAuraService)
end

function PassiveAuraService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.PlayerService = registry:Get("PlayerService")
	self.TrainingAreasService = registry:Get("TrainingAreasService")
end

function PassiveAuraService:Start()
	self.DataService.ProfileReleased.Event:Connect(function(player)
		self.FastTickEndsAt[player] = nil
		if player.Parent then
			player:SetAttribute("HugeBoostEndsAt", 0)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		self.FastTickEndsAt[player] = nil
		if player.Parent then
			player:SetAttribute("HugeBoostEndsAt", 0)
		end
	end)

	task.spawn(function()
		while true do
			task.wait(PassiveAuraConfig.TickSeconds)
			self:_runStandardTick()
		end
	end)

	task.spawn(function()
		while true do
			task.wait(PassiveAuraConfig.FastTickSeconds)
			self:_runFastTick()
		end
	end)
end

function PassiveAuraService:GetBaseRewardForPlayer(player)
	local rankIndex = self.PlayerService:GetCurrentRankIndex(player)
	return PassiveAuraConfig.GetRewardForRank(rankIndex), rankIndex
end

function PassiveAuraService:GetRewardForPlayer(player)
	local baseReward = self:GetBaseRewardForPlayer(player)
	if baseReward <= 0 then
		return 0
	end
	local areaMultiplier = self.TrainingAreasService:GetPassiveMultiplier(player)
	local kothMultiplier = self.TrainingAreasService:GetKOTHMultiplier(player)
	return math.max(1, math.floor(baseReward * math.max(1, tonumber(areaMultiplier) or 1) * math.max(1, tonumber(kothMultiplier) or 1)))
end

function PassiveAuraService:IsHugeBoostActive(player)
	return (self.FastTickEndsAt[player] or 0) > os.clock()
end

function PassiveAuraService:GetHugeBoostEndsAt(player)
	return self.FastTickEndsAt[player] or 0
end

function PassiveAuraService:TriggerFastTickBoost(player, boostKind, durationSeconds)
	local duration = PassiveAuraConfig.GetBoostDuration(boostKind, durationSeconds)
	local currentEndsAt = self.FastTickEndsAt[player] or 0
	local boostedEndsAt = math.max(currentEndsAt, os.clock()) + duration
	-- Assumption: repeated boosts extend the active window instead of spawning parallel tick loops.
	self.FastTickEndsAt[player] = boostedEndsAt
	local replicatedEndsAt = os.time() + math.max(0, math.ceil(boostedEndsAt - os.clock()))
	player:SetAttribute("HugeBoostEndsAt", replicatedEndsAt)
	return replicatedEndsAt
end

function PassiveAuraService:TriggerHugeBoost(player)
	return self:TriggerFastTickBoost(player, "Rebirth")
end

function PassiveAuraService:_shouldSkipStandardTick(player)
	if self:IsHugeBoostActive(player) then
		return true
	end
	if player:GetAttribute("IsAFK") == true then
		return true
	end
	if PassiveAuraConfig.SkipWhileTraining then
		local currentArea = self.TrainingAreasService:GetCurrentAreaName(player)
		if currentArea ~= "" then
			return true
		end
	end
	return false
end

function PassiveAuraService:_award(player, source)
	local baseReward = self:GetBaseRewardForPlayer(player)
	if baseReward <= 0 then
		return 0
	end

	local areaName = self.TrainingAreasService:GetCurrentAreaName(player)
	local passiveReward = self:GetRewardForPlayer(player)
	local displayMultiplier = math.max(1, tonumber(self.TrainingAreasService:GetCurrentAreaBoost(player)) or 1)
	local kothMultiplier = math.max(1, tonumber(self.TrainingAreasService:GetKOTHMultiplier(player)) or 1)
	local awarded = self.PlayerService:AddAura(player, passiveReward, source, areaName ~= "" and {
		AreaName = areaName,
	} or nil)
	if awarded > 0 then
		self.TrainingAreasService:PushAuraTickFeedback(
			player,
			awarded,
			areaName ~= "" and areaName or "Passive",
			displayMultiplier * kothMultiplier,
			source
		)
		if player:GetAttribute("PassiveAuraPerTick") ~= passiveReward then
			player:SetAttribute("PassiveAuraPerTick", passiveReward)
		end
	end
	return awarded
end

function PassiveAuraService:_runStandardTick()
	for _, player in ipairs(Players:GetPlayers()) do
		if self.DataService:GetProfile(player) and not self:_shouldSkipStandardTick(player) then
			self:_award(player, "Passive")
		end
	end
end

function PassiveAuraService:_runFastTick()
	local now = os.clock()
	for _, player in ipairs(Players:GetPlayers()) do
		local endsAt = self.FastTickEndsAt[player]
		if endsAt then
			if endsAt <= now then
				self.FastTickEndsAt[player] = nil
				player:SetAttribute("HugeBoostEndsAt", 0)
			elseif self.DataService:GetProfile(player) and player:GetAttribute("IsAFK") ~= true then
				self:_award(player, "HugeBoost")
			end
		end
	end
end

return PassiveAuraService