-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local v1 = script.Parent
local MedusaHeadRemote = script.Parent.MedusaHeadRemote
local v2 = 0
local v3 = nil
local v4 = nil
local v5 = nil
local Ring = ReplicatedStorage.Assets.Extra.Ring
local Attack = script:FindFirstChild("Attack")
local Idle = script:FindFirstChild("Idle")
local Scream = v1.Handle.Scream
local v6 = nil
local GetPlayerFromTool = require(ReplicatedStorage.Library.Functions.GetPlayerFromTool)
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)

local function getAnimator(p1) --[[ getAnimator | Line: 31 ]]
	local Character = p1.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	return if v1 then v1:FindFirstChildOfClass("Animator") or nil else nil
end

local function playIdle(p1) --[[ playIdle | Line: 37 | Upvalues: v6 (ref), Idle (copy) ]]
	if v6 then
		return
	end

	if not Idle then
		return
	end

	local Character = p1.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
	local v2

	if v1 then
		local Animator = v1:FindFirstChildOfClass("Animator")

		v2 = if Animator then Animator else nil
	else
		v2 = nil
	end

	if v2 then
		v6 = v2:LoadAnimation(Idle)
		v6.Looped = true
		v6:Play()
	end
end

local function playHitAnimation(p1) --[[ playHitAnimation | Line: 56 | Upvalues: Attack (copy) ]]
	if not Attack then
		return
	end

	local Character = p1.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
	local v2

	if v1 then
		local Animator = v1:FindFirstChildOfClass("Animator")

		v2 = if Animator then Animator else nil
	else
		v2 = nil
	end

	if v2 then
		local v3 = v2:LoadAnimation(Attack)

		v3.Looped = false
		v3.Priority = Enum.AnimationPriority.Action
		v3:Play()
	end
end

local function stopIdle() --[[ stopIdle | Line: 72 | Upvalues: v6 (ref) ]]
	if v6 then
		pcall(function() --[[ Line: 77 | Upvalues: v6 (ref) ]]
			v6:Stop()
			v6:Destroy()
		end)
		v6 = nil
	end
end

local function updateRadiusIndicatorPosition() --[[ updateRadiusIndicatorPosition | Line: 85 | Upvalues: v3 (ref), v5 (ref) ]]
	if not v3 then
		return
	end

	local v1 = v5 and v5.Character
	local v2 = if v1 then v1.PrimaryPart else v1

	if v2 then
		v3.CFrame = CFrame.new(v2.Position + Vector3.new(0, -3.1, 0))
	end
end

local function disconnectRadiusUpdater() --[[ disconnectRadiusUpdater | Line: 99 | Upvalues: v4 (ref) ]]
	if not v4 then
		return
	end

	v4:Disconnect()
	v4 = nil
end

local function removeRadiusIndicator() --[[ removeRadiusIndicator | Line: 106 | Upvalues: v3 (ref), v4 (ref), TweenService (copy) ]]
	if not v3 then
		return
	end

	local v1 = v3

	v3 = nil

	local v2

	if not v4 then
		v2 = TweenService:Create(v1, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Transparency = 1,
			Size = Vector3.new(0, 0.5, 0)
		})
		v2.Completed:Connect(function() --[[ Line: 121 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end)
		v2:Play()

		return
	end

	v4:Disconnect()
	v4 = nil
	v2 = TweenService:Create(v1, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Transparency = 1,
		Size = Vector3.new(0, 0.5, 0)
	})
	v2.Completed:Connect(function() --[[ Line: 121 | Upvalues: v1 (copy) ]]
		v1:Destroy()
	end)
	v2:Play()
end

local function createRadiusIndicator() --[[ createRadiusIndicator | Line: 128 | Upvalues: v3 (ref), Ring (copy), v5 (ref), v4 (ref), RunService (copy), updateRadiusIndicatorPosition (copy), TweenService (copy) ]]
	if v3 then
		return
	end

	assert(Ring, "[MedusaHead] Ring template missing")

	local MedusaRadiusIndicator = Ring:Clone()

	MedusaRadiusIndicator.Name = "MedusaRadiusIndicator"
	MedusaRadiusIndicator.Size = Vector3.new(0, 0.5, 0)
	MedusaRadiusIndicator.Material = Enum.Material.Neon
	MedusaRadiusIndicator.BrickColor = BrickColor.new("Really red")
	MedusaRadiusIndicator.CanCollide = false
	MedusaRadiusIndicator.Anchored = true
	MedusaRadiusIndicator.Transparency = 1
	MedusaRadiusIndicator.Parent = workspace
	v3 = MedusaRadiusIndicator

	if MedusaRadiusIndicator then
		local v2 = v5 and v5.Character
		local v32 = if v2 then v2.PrimaryPart else v2

		if v32 then
			MedusaRadiusIndicator.CFrame = CFrame.new(v32.Position + Vector3.new(0, -3.1, 0))
		end
	end

	v4 = RunService.Heartbeat:Connect(updateRadiusIndicatorPosition)
	TweenService:Create(MedusaRadiusIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Transparency = 0.3,
		Size = Vector3.new(40, 0.5, 40)
	}):Play()
end

local function onActivated() --[[ onActivated | Line: 158 | Upvalues: ToolGameplayGuard (copy), v1 (copy), GetPlayerFromTool (copy), v2 (ref), Attack (copy), MedusaHeadRemote (copy), Scream (copy) ]]
	if not ToolGameplayGuard.CanActivateLocal(v1) then
		warn("cannot activate")

		return
	end

	local v12 = GetPlayerFromTool(v1)

	if not v12 then
		return
	end

	local v22 = tick()

	if v22 - v2 < 30 then
		if not Attack then
			return
		end

		local Character = v12.Character
		local v3 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
		local v4

		if v3 then
			local Animator = v3:FindFirstChildOfClass("Animator")

			v4 = if Animator then Animator else nil
		else
			v4 = nil
		end

		if v4 then
			local v5 = v4:LoadAnimation(Attack)

			v5.Looped = false
			v5.Priority = Enum.AnimationPriority.Action
			v5:Play()
		end
	else
		v2 = v22
		MedusaHeadRemote:FireServer()
		Scream:Play()

		if not Attack then
			return
		end

		local Character = v12.Character
		local v6 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
		local v7

		if v6 then
			local Animator = v6:FindFirstChildOfClass("Animator")

			v7 = if Animator then Animator else nil
		else
			v7 = nil
		end

		if v7 then
			local v8 = v7:LoadAnimation(Attack)

			v8.Looped = false
			v8.Priority = Enum.AnimationPriority.Action
			v8:Play()
		end
	end
end

local function onEquipped() --[[ onEquipped | Line: 182 | Upvalues: GetPlayerFromTool (copy), v1 (copy), v5 (ref), v6 (ref), Idle (copy), createRadiusIndicator (copy) ]]
	local v12 = GetPlayerFromTool(v1)

	if not v12 then
		return
	end

	v5 = v12

	if not v6 and Idle then
		local Character = v12.Character
		local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
		local v3

		if v2 then
			local Animator = v2:FindFirstChildOfClass("Animator")

			v3 = if Animator then Animator else nil
		else
			v3 = nil
		end

		if v3 then
			v6 = v3:LoadAnimation(Idle)
			v6.Looped = true
			v6:Play()
		end
	end

	createRadiusIndicator()
end

local function onUnequipped() --[[ onUnequipped | Line: 191 | Upvalues: v6 (ref), v5 (ref), removeRadiusIndicator (copy) ]]
	if not v6 then
		v5 = nil
		removeRadiusIndicator()

		return
	end

	pcall(function() --[[ Line: 77 | Upvalues: v6 (ref) ]]
		v6:Stop()
		v6:Destroy()
	end)
	v6 = nil
	v5 = nil
	removeRadiusIndicator()
end

v1.Activated:Connect(onActivated)
v1.Equipped:Connect(onEquipped)
v1.Unequipped:Connect(onUnequipped)
v1.Destroying:Connect(function() --[[ Line: 201 | Upvalues: v6 (ref), v5 (ref), removeRadiusIndicator (copy) ]]
	if not v6 then
		v5 = nil
		removeRadiusIndicator()

		return
	end

	pcall(function() --[[ Line: 77 | Upvalues: v6 (ref) ]]
		v6:Stop()
		v6:Destroy()
	end)
	v6 = nil
	v5 = nil
	removeRadiusIndicator()
end)