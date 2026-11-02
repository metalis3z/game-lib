-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local ThrowingTableRemote = v1:WaitForChild("ThrowingTableRemote")
local anim = require(ReplicatedStorage.Directory.Animations.Pipeline):GetAndSerializeAnimation("rbxassetid://97423136474278").anim
local v2 = 0
local v3 = false

local function getAnimator() --[[ getAnimator | Line: 21 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	return if v1 then v1:FindFirstChildOfClass("Animator") or nil else nil
end

local function palyThrowAnim() --[[ palyThrowAnim | Line: 27 | Upvalues: LocalPlayer (copy), anim (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
	local v2

	if v1 then
		local Animator = v1:FindFirstChildOfClass("Animator")

		v2 = if Animator then Animator else nil
	else
		v2 = nil
	end

	if v2 then
		local v3 = v2:LoadAnimation(anim)

		v3.Priority = Enum.AnimationPriority.Action
		v3:Play()
	end
end

local function onActivated() --[[ onActivated | Line: 38 | Upvalues: v3 (ref), ToolGameplayGuard (copy), v1 (copy), LocalPlayer (copy), v2 (ref), anim (copy), ThrowingTableRemote (copy) ]]
	if v3 then
		return
	end

	if not ToolGameplayGuard.CanActivateLocal(v1) then
		warn("cannot activate")

		return
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not (Humanoid and (Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso"))) then
		return
	end

	if Humanoid.Health <= 0 then
		return
	end

	local v22 = tick()

	if v22 - v2 < 8 then
		return
	end

	v3 = true
	v2 = v22
	warn("rage table activated")

	local Character2 = LocalPlayer.Character
	local v32 = if Character2 then Character2:FindFirstChildOfClass("Humanoid") else Character2
	local v4

	if v32 then
		local Animator = v32:FindFirstChildOfClass("Animator")

		v4 = if Animator then Animator else nil
	else
		v4 = nil
	end

	if v4 then
		local v5 = v4:LoadAnimation(anim)

		v5.Priority = Enum.AnimationPriority.Action
		v5:Play()
	end

	ThrowingTableRemote:FireServer()
	task.wait(0.5)
	v3 = false
end

v1.Activated:Connect(onActivated)