-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HapticService = game:GetService("HapticService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local list = {
	Enum.UserInputType.Touch,
	Enum.UserInputType.Gamepad1,
	Enum.UserInputType.Gamepad2,
	Enum.UserInputType.Gamepad3,
	Enum.UserInputType.Gamepad4,
	Enum.UserInputType.Gamepad5,
	Enum.UserInputType.Gamepad6,
	Enum.UserInputType.Gamepad7,
	Enum.UserInputType.Gamepad8,
	Enum.UserInputType.Accelerometer,
	Enum.UserInputType.Gyro
}
local t = {}
local t2 = {}

for i, v in ipairs(list) do
	t[v] = true
end

return function(p1, p2, p3, p4) --[[ Line: 28 | Upvalues: Asserts (copy), HapticService (copy), list (copy), UserInputService (copy), t (copy), t2 (copy) ]]
	Asserts.number(p1)
	assert(if p1 == p1 then true else false, "strength is not NaN")
	assert(if p1 > 0 then if p1 <= 1 then true else false else false, "strength must be between 0 (exclusive) and 1 (inclusive)")

	if p2 ~= nil then
		assert(if type(p2) == "number" then if p2 >= 0 then true else false else false, "holdDuration must be a non-negative number")
	end

	if p3 == nil then
		p3 = Enum.VibrationMotor.Small
	else
		assert(if typeof(p3) == "EnumItem" then if p3.EnumType == Enum.VibrationMotor then true else false else false, "motorType must be an Enum.VibrationMotor")
	end

	assert(p3, "luau")

	if p4 ~= nil then
		assert(if typeof(p4) == "EnumItem" then if p4.EnumType == Enum.UserInputType then true else false else false, "inputType must be an Enum.UserInputType")
	end

	if p4 then
		local _ = not HapticService:IsVibrationSupported(p4, p3)
	else
		for i, v in ipairs(list) do
			if HapticService:IsVibrationSupported(v, p3) then
				p4 = v

				break
			end
		end
	end

	if p4 then
		local v6 = p2 or 0
		local v7 = UserInputService:GetLastInputType()

		if t[v7] then
			local v8 = 0

			if v7.Name:find("^Gamepad") then
				v8 = math.max(v8, 0.15)
			end

			local v9 = string.format("%d/%d", p3.Value, p4.Value)

			if not t2[v9] then
				t2[v9] = true
				task.spawn(function() --[[ Line: 92 | Upvalues: HapticService (ref), p4 (ref), p3 (ref), p1 (copy), v8 (ref), v6 (copy), t2 (ref), v9 (copy) ]]
					HapticService:SetMotor(p4, p3, p1)
					task.wait(v8)
					task.wait(v6)
					HapticService:SetMotor(p4, p3, 0)
					task.wait(v8 * 0.5)
					t2[v9] = nil
				end)
			end
		end
	end
end