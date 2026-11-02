-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local Touch = Enum.UserInputType.Touch
local Keyboard = Enum.UserInputType.Keyboard
local v1 = nil
local t = {}

v1 = {
	Current = "MouseKeyboard",
	Observe = function(p1) --[[ Observe | Line: 83 | Upvalues: t (copy), v1 (ref) ]]
		if not table.find(t, p1) then
			local v12

			v12 = t
			table.insert(t, p1)
			task.spawn(p1, v1.Current)

			return function() --[[ Line: 91 | Upvalues: t (ref), p1 (copy) ]]
				local v1 = table.find(t, p1)

				if not v1 then
					return
				end

				local v2 = #t

				t[v1] = t[v2]
				t[v2] = nil
			end
		end

		error("function already subscribed", 2)
	end
}

local function SetPreferred(p1) --[[ SetPreferred | Line: 101 | Upvalues: v1 (ref), t (copy) ]]
	if p1 == v1.Current then
		return
	end

	v1.Current = p1

	for v12, v2 in t do
		task.spawn(v2, p1)
	end
end

local function DeterminePreferred(p1) --[[ DeterminePreferred | Line: 112 | Upvalues: Touch (copy), SetPreferred (copy), Keyboard (copy) ]]
	if p1 == Touch then
		SetPreferred("Touch")

		return
	end

	if p1 == Keyboard then
		SetPreferred("MouseKeyboard")

		return
	end

	if string.sub(p1.Name, 1, 5) == "Mouse" then
		SetPreferred("MouseKeyboard")

		return
	end

	if string.sub(p1.Name, 1, 7) ~= "Gamepad" then
		return
	end

	SetPreferred("Gamepad")
end

local v2 = UserInputService:GetLastInputType()

if v2 == Touch then
	SetPreferred("Touch")
elseif v2 == Keyboard or string.sub(v2.Name, 1, 5) == "Mouse" then
	SetPreferred("MouseKeyboard")
elseif string.sub(v2.Name, 1, 7) == "Gamepad" then
	SetPreferred("Gamepad")
end

UserInputService.LastInputTypeChanged:Connect(DeterminePreferred)

return v1