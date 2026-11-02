-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HapticService = game:GetService("HapticService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Variables = require(Library.Variables)
local Functions = require(Library.Functions)
local v1 = Random.new()
local v2 = 0

function t.Create(p1, p2, p3, p4, p5, p6) --[[ Create | Line: 16 | Upvalues: GuiService (copy), v2 (ref), Functions (copy), Players (copy), v1 (copy), Variables (copy), HapticService (copy), RunService (copy) ]]
	if GuiService.ReducedMotionEnabled then
		return
	end

	if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
		return
	end

	v2 = v2 + 1

	local v12 = v2
	local v22 = p1 or 1
	local v3 = p2 or 1
	local v4 = p3 or 0
	local v5 = if p4 == true then true else false

	if p5 then
		local v6 = Functions.Distance(Players.LocalPlayer, p5.Origin)

		if v6 and p5.MaxDistance < v6 then
		elseif v6 and p5.RollOffDistance < v6 then
			local v8 = p5.MaxDistance - p5.RollOffDistance

			if v8 == 0 then
				v8 = 0.001
			end

			local v9 = math.clamp((v6 - p5.RollOffDistance) / v8, 0, 1)

			if not (v9 >= 1) then
				v3 = v3 * (1 - v9)
			end
		end
	end

	task.spawn(function() --[[ Line: 55 | Upvalues: v2 (ref), v12 (copy), v22 (copy), v4 (copy), v5 (copy), v1 (ref), v3 (ref), p6 (copy), Variables (ref), HapticService (ref), RunService (ref) ]]
		local v13 = os.clock()
		local v23 = os.clock()
		local CurrentCamera = workspace.CurrentCamera
		local v32 = Vector3.new()
		local v42 = nil

		while v2 == v12 and os.clock() - v13 <= v22 do
			local v52
			local v6 = (os.clock() - v13) / v22

			if not v42 or v4 / 10 <= os.clock() - v23 then
				local v7 = os.clock()

				v52 = v5 and math.sin(v6 * math.pi) or math.sin((0.5 + v6 / 2) * math.pi)
				v23 = v7

				local v11 = Vector3.new(v1:NextNumber(-v52, v52) * v52 * v3, v1:NextNumber(-v52, v52) * v52 * v3, v1:NextNumber(-v52, v52) * v52 * v3)

				if not p6 and (Variables.Console or Variables.Mobile) and HapticService:IsVibrationSupported(Enum.UserInputType.Gamepad1) then
					HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, math.min(v3, 1) * v52)
				end

				v42 = v11
			end

			CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(-v32) * CFrame.new(v42)
			RunService.RenderStepped:Wait()
			v32 = v42
		end

		CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(-v32)

		if p6 or not (Variables.Console or Variables.Mobile) or not HapticService:IsVibrationSupported(Enum.UserInputType.Gamepad1) then
			return
		end

		HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
	end)
end

return t