--credit to leon games studio
local t = {}
local LocalPlayer = game:GetService("Players").LocalPlayer
local ButtonMash = LocalPlayer.PlayerGui:WaitForChild("ButtonMash")
local Button = ButtonMash.Button
local Frame = Button.ProgressBar.Frame
local v1 = false

function t.Disable() --[[ Disable | Line: 15 | Upvalues: v1 (ref) ]]
	v1 = false
end
function t.Start(p1, p2) --[[ Start | Line: 19 | Upvalues: v1 (ref), ButtonMash (copy), Frame (copy), Button (copy), LocalPlayer (copy) ]]
	if v1 then
		return
	end

	v1 = true
	ButtonMash.Enabled = true
	Frame.Size = UDim2.fromScale(0, 1)

	local v12 = 0

	task.spawn(function() --[[ Line: 35 | Upvalues: v1 (ref), p2 (copy), v12 (ref), Frame (ref) ]]
		while v1 do
			task.wait(p2 or 0.5)
			v12 = math.clamp(v12 - 0.1, 0, 1)
			Frame.Size = UDim2.fromScale(v12, 1)
		end
	end)

	local v2 = nil

	local function ButtonMash2() --[[ ButtonMash | Line: 45 | Upvalues: v12 (ref), p1 (copy), Frame (ref), v1 (ref), v2 (ref) ]]
		v12 = math.min(v12 + p1, 1)
		Frame.Size = UDim2.fromScale(v12, 1)

		if v12 ~= 1 then
			return
		end

		v1 = false
		v2 = "Success"
	end

	local t = {}
	local InputBegan = game:GetService("UserInputService").InputBegan

	local function f3(p12, p2) --[[ Line: 58 | Upvalues: Button (ref), v12 (ref), p1 (copy), Frame (ref), v1 (ref), v2 (ref) ]]
		if p2 or p12.KeyCode ~= Enum.KeyCode.Space and p12.KeyCode ~= Enum.KeyCode.ButtonA then
			return
		end

		if p12.KeyCode == Enum.KeyCode.ButtonA then
			Button.HoverOver.Visible = true
			task.delay(0.1, function() --[[ Line: 64 | Upvalues: Button (ref) ]]
				Button.HoverOver.Visible = false
			end)
		end

		v12 = math.min(v12 + p1, 1)
		Frame.Size = UDim2.fromScale(v12, 1)

		if v12 ~= 1 then
			return
		end

		v1 = false
		v2 = "Success"
	end

	table.insert(t, InputBegan:Connect(f3))

	local MouseButton1Down = Button.MouseButton1Down

	local function f4() --[[ Line: 73 | Upvalues: v12 (ref), p1 (copy), Frame (ref), v1 (ref), v2 (ref) ]]
		v12 = math.min(v12 + p1, 1)
		Frame.Size = UDim2.fromScale(v12, 1)

		if v12 ~= 1 then
			return
		end

		v1 = false
		v2 = "Success"
	end

	table.insert(t, MouseButton1Down:Connect(f4))

	local function f5() --[[ Line: 77 | Upvalues: v2 (ref) ]]
		v2 = false
	end

	table.insert(t, LocalPlayer.CharacterAdded:Connect(f5))

	local function updateInput() --[[ updateInput | Line: 83 | Upvalues: Button (ref) ]]
		local v1 = if game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Touch then "PRESS ME" elseif game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1 and game:GetService("GuiService"):IsTenFootInterface() then "ButtonA" else "SPACE"

		if v1 == "ButtonA" then
			Button.TextGroup.Visible = false
			Button.GamepadIcon.Visible = true
			Button.GamepadIcon.Image = game:GetService("UserInputService"):GetImageForKeyCode(Enum.KeyCode.ButtonA)
		else
			Button.GamepadIcon.Visible = false
			Button.TextGroup.Visible = true
		end

		Button.TextGroup.TextLabel.Text = v1
		Button.TextGroup.TextLabel.TextLabel.Text = v1
	end

	updateInput()

	local LastInputTypeChanged = game:GetService("UserInputService").LastInputTypeChanged

	table.insert(t, LastInputTypeChanged:Connect(updateInput))

	repeat
		task.wait()
	until v2 or not v1

	if not v2 then
		v2 = false
	end

	for v6, v7 in t do
		v7:Disconnect()
	end

	ButtonMash.Enabled = false

	return v2
end

return t