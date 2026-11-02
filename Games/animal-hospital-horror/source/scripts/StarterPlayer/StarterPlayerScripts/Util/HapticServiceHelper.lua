local t = {}
local UserInputService = game:GetService("UserInputService")
local HapticService = game:GetService("HapticService")
local v1 = false
local v2 = if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) and HapticService:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large) then true else false

if HapticService:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large) then
	v1 = true
end

function t.SetDeviceVibration(p1) --[[ SetDeviceVibration | Line: 19 | Upvalues: v2 (ref), v1 (ref), HapticService (copy) ]]
	if not (v2 or v1) then
		return
	end

	HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, p1 or 0)
end
function t.VibrateDevice(p1, p2) --[[ VibrateDevice | Line: 25 | Upvalues: v2 (ref), v1 (ref), HapticService (copy) ]]
	local v12 = p2 or 1

	task.spawn(function() --[[ Line: 27 | Upvalues: v2 (ref), v1 (ref), HapticService (ref), v12 (ref), p1 (copy) ]]
		if not (v2 or v1) then
			return
		end

		HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, v12)
		task.wait(p1 or 0.2)
		HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
	end)
end

return t