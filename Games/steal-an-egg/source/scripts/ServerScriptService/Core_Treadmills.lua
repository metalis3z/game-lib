--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = require(script.Parent.Core_Network)
local TreadmillDirectory = require(ReplicatedStorage.Directory.Treadmills)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)

local Treadmills = {}
local Data
local Plots
local active: {[Player]: any} = {}
local jumpConnections: {[Player]: RBXScriptConnection} = {}
local revision = 0
local slowToggle: {[Player]: boolean} = {}
local SLOW_WALK_SPEED = 16

local function configForLevel(level)
	return TreadmillDirectory.GetByUpgradeLevel(math.max(1, tonumber(level) or 1))
end

local function Meowww(player : Player, status : boolean)
	local feee = workspace:WaitForChild("Plots")
	for _, plot in ipairs(feee:GetChildren()) do
		local plotart = plot:GetAttribute("OwnerUserId")
		if plotart == player.UserId then
			if status == true then
				local hrp : Part = player.Character:WaitForChild("HumanoidRootPart")
				hrp.Anchored = true
				hrp.CFrame = plot.TreadmillSpawn.CFrame
				task.wait(0.2)
				hrp.Anchored = false
				plot.lol.CanCollide = true
			elseif status == false then
				plot.lol.CanCollide = false
			end
		end
	end
end

local function applyWalkSpeed(player: Player)
	local profile = Data.Get(player)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not profile or not humanoid then
		return
	end
	local power = math.max(10, tonumber(profile.SpeedPower) or 10)
	local baseWalkSpeed = TreadmillUtil.SpeedPowerToWalkSpeed(power)
	local trailMultiplier = TreadmillUtil.ResolveEquippedTrailWalkSpeedMultiplier(profile)
	local finalWalkSpeed = baseWalkSpeed * trailMultiplier

	player:SetAttribute("BaseWalkSpeed", baseWalkSpeed)
	player:SetAttribute("TrailSpeedMultiplier", trailMultiplier)

	if active[player] then
		humanoid.WalkSpeed = 0
		player:SetAttribute("CurrentWalkSpeed", 0)
		return
	end

	local walkSpeed = slowToggle[player] and math.min(finalWalkSpeed, SLOW_WALK_SPEED) or finalWalkSpeed
	humanoid.WalkSpeed = walkSpeed
	player:SetAttribute("CurrentWalkSpeed", walkSpeed)
end

local function setActive(player: Player, enabled: boolean)
	if enabled then
		local profile = Data.Get(player)
		if not profile then
			return false, "Your data is still loading."
		end
		if (tonumber(profile.BaseUpgradeLevel) or 0) <= 0 then
			return false, "Upgrade your base once to unlock the treadmill."
		end
		if active[player] then
			return true
		end
		local config = configForLevel(profile.TreadmillUpgradeLevel)
		if not config then
			return false, "Treadmill configuration is missing."
		end
		local multiplier = math.max(1, tonumber(config.SpeedMultiplier) or 1)
		active[player] = {
			Id = config._id,
			Multiplier = multiplier,
			Accumulator = 0,
			NextAwardAt = workspace:GetServerTimeNow() + 0.25,
		}
		applyWalkSpeed(player)
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if root and root:IsA("BasePart") then
			root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
		end
		Meowww(player, true)
		revision += 1
		Network.FireClient("Treadmills: ActiveTreadmillChanged", player, config._id, multiplier, active[player].NextAwardAt, profile.TreadmillMediaFeedState or {})
		Network.FireAll("Treadmills: ActiveRenderStateChanged", player, true, revision)
		return true
	end

	if not active[player] then
		return true
	end
	Meowww(player, false)
	active[player] = nil
	applyWalkSpeed(player)
	revision += 1
	Network.FireClient("Treadmills: ActiveTreadmillChanged", player, nil, 1, workspace:GetServerTimeNow(), {})
	Network.FireAll("Treadmills: ActiveRenderStateChanged", player, false, revision)
	return true
end

function Treadmills.CanPurchaseUpgrade(player: Player, treadmillId: any)
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	local nextLevel = (tonumber(profile.TreadmillUpgradeLevel) or 1) + 1
	local target = configForLevel(nextLevel)
	if not target then
		return false, "Your treadmill is fully upgraded."
	end
	if treadmillId ~= nil and treadmillId ~= target._id then
		return false, "That is not the next treadmill upgrade."
	end
	return true, target._id
end

function Treadmills.UpgradeForProduct(player: Player, treadmillId: any)
	local allowed, targetOrMessage = Treadmills.CanPurchaseUpgrade(player, treadmillId)
	if not allowed then
		return false, targetOrMessage
	end
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	setActive(player, false)
	Data.Update(player, {
		TreadmillUpgradeLevel = (tonumber(profile.TreadmillUpgradeLevel) or 1) + 1,
	})
	return true, targetOrMessage
end

function Treadmills.RefreshWalkSpeed(player: Player)
	applyWalkSpeed(player)
end

function Treadmills.Init(dataService, plotService)
	Data = dataService
	Plots = plotService

	Network.BindFunction("Treadmills: RequestActiveRenderSnapshot", function()
		local userIds = {}
		for player in pairs(active) do
			if player.Parent == Players then
				table.insert(userIds, player.UserId)
			end
		end
		return userIds, revision
	end)
	Network.BindFunction("Treadmills: RequestEquipStatic", function(player)
		return setActive(player, true)
	end)
	Network.BindFunction("Treadmills: RequestUnequip", function(player)
		return setActive(player, false)
	end)
	Network.BindFunction("Treadmills: RequestUpgrade", function(player, treadmillId)
		local profile = Data.Get(player)
		if not profile then
			return false, "Your data is still loading."
		end
		local nextLevel = (tonumber(profile.TreadmillUpgradeLevel) or 1) + 1
		local target = configForLevel(nextLevel)
		if not target then
			return false, "Your treadmill is fully upgraded."
		end
		if treadmillId ~= nil and treadmillId ~= target._id then
			return false, "That is not the next treadmill upgrade."
		end
		local price = math.max(0, tonumber(target.Price) or 0)
		local money = tonumber(profile.Money) or 0
		if money < price then
			return false, "You need more money."
		end
		setActive(player, false)
		Data.Update(player, {
			Money = money - price,
			TreadmillUpgradeLevel = nextLevel,
		})
		return true
	end)
	
	Network.BindFunction("Treadmills: RequestGetSlowToggleState", function(player)
		local profile = Data.Get(player)
		if not profile then
			return false, 16
		end
		local power = math.max(10, tonumber(profile.SpeedPower) or 10)
		local baseWalkSpeed = TreadmillUtil.SpeedPowerToWalkSpeed(power)
		local trailMultiplier = TreadmillUtil.ResolveEquippedTrailWalkSpeedMultiplier(profile)
		return slowToggle[player] == true, baseWalkSpeed * trailMultiplier
	end)

	Network.BindFunction("Treadmills: RequestSetSlowToggleEnabled", function(player, enabled)
		slowToggle[player] = enabled and true or false
		applyWalkSpeed(player)
		local profile = Data.Get(player)
		local power = profile and math.max(10, tonumber(profile.SpeedPower) or 10) or 10
		local baseWalkSpeed = TreadmillUtil.SpeedPowerToWalkSpeed(power)
		local trailMultiplier = profile and TreadmillUtil.ResolveEquippedTrailWalkSpeedMultiplier(profile) or 1
		return slowToggle[player], baseWalkSpeed * trailMultiplier
	end)

	local function onCharacter(player)
		task.wait(0.2)
		if jumpConnections[player] then
			jumpConnections[player]:Disconnect()
			jumpConnections[player] = nil
		end
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		if active[player] then
			setActive(player, false)
		else
			applyWalkSpeed(player)
		end
		jumpConnections[player] = humanoid.Jumping:Connect(function(isJumping)
			if isJumping and active[player] then
				setActive(player, false)
			end
		end)
	end
	Data.Loaded.Event:Connect(function(player)
		player.CharacterAdded:Connect(function()
			onCharacter(player)
		end)
		onCharacter(player)
	end)
	Data.Changed.Event:Connect(function(player, changes, removals)
		if changes.SpeedPower ~= nil
			or changes.EquippedTrail ~= nil
			or changes.TrailInventory ~= nil
			or (removals and removals.EquippedTrail)
		then
			applyWalkSpeed(player)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		if jumpConnections[player] then
			jumpConnections[player]:Disconnect()
			jumpConnections[player] = nil
		end
		if active[player] then
			active[player] = nil
			revision += 1
			Network.FireAll("Treadmills: ActiveRenderStateChanged", player, false, revision)
		end
	end)
	
	task.spawn(function()
		while task.wait(0.25) do
			for player, state in pairs(active) do
				local profile = Data.Get(player)
				if not profile or not player.Parent then
					active[player] = nil
					continue
				end
				local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.WalkSpeed ~= 0 then
					humanoid.WalkSpeed = 0
				end
				local current = math.max(10, tonumber(profile.SpeedPower) or 10)
				local boostMultiplier = TreadmillUtil.ResolveAdditiveSpeedStepMultiplier(
					TreadmillUtil.ResolveSpeedBoostSpeedStepMultiplier(profile),
					TreadmillUtil.ResolveTemporarySpeedBoostSpeedStepMultiplier(profile, workspace:GetServerTimeNow())
				)
				local gain = math.max(1, math.floor((1 + math.log10(current)) * state.Multiplier * boostMultiplier))
				state.Accumulator += gain
				state.NextAwardAt = workspace:GetServerTimeNow() + 0.25
				Network.FireClient("Treadmills: SpeedGain", player, gain, "Treadmill")
				if state.Accumulator >= 4 then
					Data.Update(player, {SpeedPower = current + state.Accumulator})
					state.Accumulator = 0
				end
			end
		end
	end)
end

return Treadmills
