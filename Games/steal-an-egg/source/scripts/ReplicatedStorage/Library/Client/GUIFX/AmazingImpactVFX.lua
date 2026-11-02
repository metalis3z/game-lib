-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Library.Audio)
local Flash = require(ReplicatedStorage.Library.Client.GUIFX.Flash)
local Functions = require(ReplicatedStorage.Library.Functions)
local t = {
	BIG_SUSPENSE_SFX = { "rbxassetid://117036144605831" },
	TICK_SFX = { "rbxassetid://87230100487320" }
}
local DepthOfField = script.DepthOfField
local CurrentCamera = workspace.CurrentCamera
local FieldOfView = CurrentCamera.FieldOfView

return function(p1) --[[ Line: 41 | Upvalues: Audio (copy), t (copy), DepthOfField (copy), Lighting (copy), Functions (copy), TweenService (copy), CurrentCamera (copy), Flash (copy), FieldOfView (copy) ]]
	local v1 = if p1 and p1.PlayBlur ~= nil then p1.PlayBlur else true
	local v2 = if p1 and p1.PlayFlash ~= nil then p1.PlayFlash else true
	local v3 = if p1 and p1.PlaySuspenseSound ~= nil then p1.PlaySuspenseSound else true
	local v4 = if p1 and p1.PlayTickSound ~= nil then p1.PlayTickSound else true
	local v5 = if p1 and p1.Duration ~= nil then p1.Duration else nil
	local v6 = if p1 and p1.SpeedMultiplier ~= nil then p1.SpeedMultiplier else 1

	assert(if v6 > 0 then true else false, "AmazingImpactVFX speed multiplier must be positive")

	if v5 ~= nil then
		assert(v5 > 0, "AmazingImpactVFX duration must be positive")
	end

	local v9 = if v5 == nil then 1.75 * (1 / v6) else v5 * 0.9210526315789475
	local v10 = if v5 == nil then 0.15 * (1 / v6) else v5 * 0.07894736842105263
	local v11 = v9 / 1.75
	local v12 = if v3 then Audio.Play(t.BIG_SUSPENSE_SFX, script, v6, 3.5) else nil
	local v13 = if v1 then DepthOfField:Clone() else nil

	if v13 ~= nil then
		v13.Parent = Lighting
	end

	task.delay(math.min(v9, if v12 == nil then 1.1 * v11 else v12.TimeLength / v6 + 1.1 * v11), function() --[[ Line: 81 | Upvalues: Functions (ref) ]]
		Functions.Vibrate(0.25, nil, Enum.VibrationMotor.Small)
		Functions.Vibrate(1, nil, Enum.VibrationMotor.Large)
	end)
	TweenService:Create(CurrentCamera, TweenInfo.new(v9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		FieldOfView = 120
	}):Play()

	if v2 then
		Flash(v9, 0.1 * v11, Color3.new(255/255, 255/255, 255/255), 0.2)
	end

	local v16 = script.Hyperspace:Clone()
	local Size = v16.Size
	local v17 = Size + Vector3.new(80, 40, 0)
	local Lines = v16:FindFirstChild("Lines")

	assert(if Lines == nil then false else Lines:IsA("ParticleEmitter"), "AmazingImpactVFX.Hyperspace.Lines must be a ParticleEmitter")
	v16.Parent = workspace:WaitForChild("__DEBRIS")

	local v19 = 120 - FieldOfView
	local v20 = 0
	local v21 = nil

	v21 = Functions.BindToRenderStep("AmazingImpactVFX", Enum.RenderPriority.Camera.Value + 1, function(p1) --[[ Line: 113 | Upvalues: v16 (copy), v21 (ref), v20 (ref), CurrentCamera (ref), FieldOfView (ref), v19 (copy), Size (copy), v17 (copy), v11 (copy), Lines (copy) ]]
		if v16.Parent then
			v20 = v20 + p1

			local v2 = Size:Lerp(v17, (math.clamp((CurrentCamera.FieldOfView - FieldOfView) / v19, 0, 1)))

			v16.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * 50, CurrentCamera.CFrame.Position)
			v16.Size = v2

			if not (0.0025 * v11 < v20) then
				return
			end

			v20 = 0
			Lines:Emit(1)
		else
			local v4 = v21

			if v4 == nil then
				return
			end

			v21 = nil
			v4()
		end
	end)
	task.wait(v9)
	Functions.AddDebris(v16, 1)

	if v13 ~= nil then
		Functions.AddDebris(v13, 0.2 * v11)
	end

	if v2 then
		Flash(0, 0.25 * v11, Color3.new(255/255, 255/255, 255/255), 0)
	end

	TweenService:Create(CurrentCamera, TweenInfo.new(v10, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		FieldOfView = FieldOfView
	}):Play()

	if v4 then
		Audio.Play(t.TICK_SFX, script, 1, 2.5)
	end

	task.wait(v10)

	if v12 ~= nil and (v12.Parent ~= nil and v12.IsPlaying) then
		v12:Stop()
	end

	local v22 = v21

	if v22 ~= nil then
		v21 = nil
		v22()
	end
end