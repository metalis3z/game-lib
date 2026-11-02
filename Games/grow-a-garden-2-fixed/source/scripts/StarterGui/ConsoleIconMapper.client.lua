--credit to quartz games studio

local UserInputService = game:GetService("UserInputService")
local t = {
	Xbox = {
		[Enum.KeyCode.ButtonL1] = "rbxassetid://136548126200637",
		[Enum.KeyCode.ButtonB] = "rbxassetid://139491087647709"
	},
	Dualshock = {
		[Enum.KeyCode.ButtonL1] = "rbxassetid://72027978183124",
		[Enum.KeyCode.ButtonB] = "rbxassetid://129014551061551"
	}
}
local v1 = "Unknown"
local v2 = nil
local v3 = nil

local function GetInstances() --[[ GetInstances | Line: 18 | Upvalues: v3 (ref) ]]
	if v3 then
		return v3
	end

	v3 = script.Parent:QueryDescendants("ImageLabel.ConsoleKeycodeImage, ImageButton.ConsoleKeycodeImage")

	return v3
end

script.Parent.DescendantAdded:Connect(function() --[[ Line: 26 | Upvalues: v3 (ref) ]]
	v3 = nil
end)
script.Parent.DescendantRemoving:Connect(function() --[[ Line: 27 | Upvalues: v3 (ref) ]]
	v3 = nil
end)

local function UpdateDevice(p1) --[[ UpdateDevice | Line: 29 | Upvalues: v1 (ref), v2 (ref), UserInputService (copy), v3 (ref), t (copy) ]]
	local v12 = v1
	local v22 = v2

	if p1 == Enum.UserInputType.Touch then
		v1 = "Mobile"
		v2 = nil
	elseif p1 == Enum.UserInputType.Gamepad1 then
		v1 = "Gamepad"
		v2 = if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA):find("Cross", 1, true) then "Dualshock" else "Xbox"
	elseif p1 == Enum.UserInputType.MouseMovement or (p1 == Enum.UserInputType.MouseButton1 or p1 == Enum.UserInputType.Keyboard) then
		v1 = "PC"
		v2 = nil
	end

	if v12 == v1 and v22 == v2 then
		return
	end

	local v4 = v1 == "Gamepad"

	if not v3 then
		v3 = script.Parent:QueryDescendants("ImageLabel.ConsoleKeycodeImage, ImageButton.ConsoleKeycodeImage")
	end

	for v5, v6 in v3 do
		v6.Visible = v4

		if v4 then
			local v7 = v6:GetAttribute("Keycode")

			if v7 then
				local v8 = t[v2][Enum.KeyCode:FromName(v7)]

				if v8 then
					v6.Image = v8
				end
			end
		end
	end
end

UserInputService.LastInputTypeChanged:Connect(UpdateDevice)