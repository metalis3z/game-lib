local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local RateLimiter = require(script.Parent.Parent.Core.RateLimiter)
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local MathUtility = require(ReplicatedStorage:WaitForChild("Math Utility"))
local ChestService = {}
ChestService.__index = ChestService

function ChestService.new()
	return setmetatable({
		RateLimiter = RateLimiter.new(),
		ChestHitbox = nil,
	}, ChestService)
end

function ChestService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.PlayerService = registry:Get("PlayerService")
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.PassiveAuraService = registry:Get("PassiveAuraService")
	self.RemoteBinder:BindFunction("ChestService", "GetState", function(player)
		return self:GetState(player)
	end)
	self.RemoteBinder:BindFunction("ChestService", "RequestSync", function(player)
		return self:RequestSync(player)
	end)
	self.RemoteBinder:BindFunction("ChestService", "RequestClaim", function(player)
		return self:RequestClaim(player)
	end)
end

function ChestService:Start()
	local chest = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Chest")
	self.ChestHitbox = chest and chest:FindFirstChild("Hitbox")
	self.DataService.ProfileLoaded.Event:Connect(function(player)
		self:PushState(player)
	end)
	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		if self.DataService:GetProfile(player) then
			self:PushState(player)
		end
	end
end

function ChestService:_getProfile(player)
	return self.DataService:GetProfile(player) or self.DataService:WaitForProfile(player, 10)
end

function ChestService:_playerIsNearChest(player)
	if not self.ChestHitbox or not self.ChestHitbox:IsA("BasePart") then
		return false
	end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then
		return false
	end
	local maxDistance = 25
	return (root.Position - self.ChestHitbox.Position).Magnitude <= maxDistance
end

function ChestService:_buildRewardState(player)
	local inGroup = false
	local ok, result = pcall(function()
		return player:IsInGroup(Shared.GroupId)
	end)
	if ok then
		inGroup = result == true
	end
	local auraReward = GameConfig.Chest.BaseAuraReward * (inGroup and GameConfig.Chest.BonusGroupMultiplier or 1)
	local rebirthReward = inGroup and GameConfig.Chest.BonusRebirthReward or 0
	return inGroup, auraReward, rebirthReward
end

function ChestService:GetState(player)
	local profile = self:_getProfile(player)
	if not profile then
		return nil
	end
	local inGroup, auraReward, rebirthReward = self:_buildRewardState(player)
	local nextClaimAt = profile.Cooldowns.ChestClaimAt or 0
	local remaining = math.max(0, nextClaimAt - os.time())
	return {
		OnCooldown = remaining > 0,
		NextClaimAt = nextClaimAt,
		Remaining = remaining,
		InGroup = inGroup,
		Rewards = {
			Aura = auraReward,
			Rebirths = rebirthReward,
		},
	}
end

function ChestService:PushState(player)
	self.RemoteBinder:FireClient("ChestService", "CooldownSynced", player, self:GetState(player))
end

function ChestService:RequestSync(player)
	local state = self:GetState(player)
	self:PushState(player)
	return state
end

function ChestService:RequestClaim(player)
	local allowed = self.RateLimiter:Allow(player, "RequestClaim", GameConfig.RateLimits.ChestClaim)
	if not allowed then
		return false, { Reason = "RateLimited" }
	end

	local profile = self:_getProfile(player)
	if not profile then
		return false, { Reason = "ProfileNotReady" }
	end

	if not self:_playerIsNearChest(player) then
		return false, { Reason = "NotNearChest" }
	end

	local inGroup, auraReward, rebirthReward = self:_buildRewardState(player)
	if not inGroup then
		return false, { Reason = "NotInGroup" }
	end

	local remaining = math.max(0, (profile.Cooldowns.ChestClaimAt or 0) - os.time())
	if remaining > 0 then
		return false, {
			Reason = "Cooldown",
			Remaining = remaining,
		}
	end

	self.PlayerService:AddAura(player, auraReward, "Chest")
	self.DataService:Mutate(player, function(data)
		data.Cooldowns.ChestClaimAt = os.time() + GameConfig.Chest.CooldownSeconds
		data.Stats.TotalChestClaims += 1
		data.Stats.Rebirths = MathUtility.Add(data.Stats.Rebirths or 0, rebirthReward) or (data.Stats.Rebirths or 0)
		data.Progression.Tutorial.ClaimedFirstChest = true
	end)

	local hugeBoostEndsAt = self.PassiveAuraService:TriggerFastTickBoost(player, "GroupReward", 5)
	self.PlayerService:SyncReplicatedState(player)
	self:PushState(player)

	return true, {
		Cooldown = GameConfig.Chest.CooldownSeconds,
		Remaining = GameConfig.Chest.CooldownSeconds,
		InGroup = true,
		auraReward = auraReward,
		rebirthReward = rebirthReward,
		HugeBoostEndsAt = hugeBoostEndsAt,
	}
end

return ChestService
