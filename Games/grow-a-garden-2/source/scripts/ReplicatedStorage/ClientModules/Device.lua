--credit to leon games studio
game:GetService("ReplicatedStorage")

local UserInputService = game:GetService("UserInputService")
local t = {
	DeviceChanged = require(script.Parent.Signal).new(),
	GetCurrentDevice = function(p1) --[[ GetCurrentDevice | Line: 13 | Upvalues: UserInputService (copy) ]]
		local v1 = UserInputService:GetLastInputType()

		if v1 == Enum.UserInputType.Touch then
			return "Touch"
		end

		if v1 == Enum.UserInputType.Keyboard or string.find(v1.Name, "Mouse", 1, true) then
			return "PC"
		end

		if string.find(v1.Name, "Gamepad", 1, true) then
			return "Gamepad"
		end

		return "PC"
	end
}

function t.Observe(p1, p2) --[[ Observe | Line: 26 | Upvalues: t (copy) ]]
	local v1 = t.DeviceChanged:Connect(function() --[[ Line: 27 | Upvalues: p2 (copy), t (ref) ]]
		task.spawn(p2, t:GetCurrentDevice())
	end)

	task.spawn(p2, t:GetCurrentDevice())

	return function() --[[ Line: 33 | Upvalues: v1 (copy) ]]
		v1:Disconnect()
	end
end
function t.Start(p1) --[[ Start | Line: 38 | Upvalues: t (copy), UserInputService (copy) ]]
	local v1 = nil

	local function updateInput() --[[ updateInput | Line: 40 | Upvalues: t (ref), v1 (ref) ]]
		local v12 = t:GetCurrentDevice()

		if v12 ~= v1 then
			v1 = v12
			t.DeviceChanged:Fire(v12)
		end
	end

	UserInputService.LastInputTypeChanged:Connect(updateInput)

	local v2 = t:GetCurrentDevice()

	if v2 ~= v1 then
		v1 = v2
		t.DeviceChanged:Fire(v2)
	end
end
task.spawn(t.Start, t)

return t