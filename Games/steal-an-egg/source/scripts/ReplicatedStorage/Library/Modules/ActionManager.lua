-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InputCategorizer = require(script.Parent.InputCategorizer)
local InputMetadata = require(script.InputMetadata)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Instances = script.Instances
local ActionGui = Instances.ActionGui
local t = {
	KeyboardAndMouse = "KeyboardAndMouse",
	Gamepad = "Gamepad",
	Touch = "Touch",
	Unknown = "Unknown"
}
local t2 = {
	_initialized = false,
	InputCategory = t,
	_bindings = {}
}

function t2.bindAction(p1, p2, p3, p4, p5) --[[ bindAction | Line: 43 | Upvalues: t2 (copy), Instances (copy), ActionGui (copy), InputCategorizer (copy), ContextActionService (copy) ]]
	if t2._bindings[p1] then
		warn(string.format("\'%s\' is already bound!", p1))
	else
		local t = {
			connections = {},
			keyboardAndMouseInput = p3,
			gamepadInput = p4
		}
		local v1 = Instances.ActionFrame:Clone()

		v1.ContentFrame.ActionLabel.Text = p1
		v1.LayoutOrder = p5 or 0
		v1.Parent = ActionGui.ListFrame
		t.frame = v1
		t2._updateInputDisplay(t, InputCategorizer.getLastInputCategory())

		local function f2(...) --[[ Line: 72 | Upvalues: p1 (copy), v1 (copy), p2 (copy) ]]
			local v12, v2 = ...

			if v12 == p1 and v2 == Enum.UserInputState.Begin then
				v1.ContentFrame.ActionLabel.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
				v1.ContentFrame.ActionLabel.TextColor3 = Color3.new(0/255, 0/255, 0/255)
			elseif v12 == p1 and v2 == Enum.UserInputState.End then
				v1.ContentFrame.ActionLabel.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
				v1.ContentFrame.ActionLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			end

			p2(...)
		end

		table.insert(t.connections, v1.TouchButton.InputBegan:Connect(function(p12) --[[ Line: 91 | Upvalues: f2 (copy), p1 (copy) ]]
			if p12.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			f2(p1, Enum.UserInputState.Begin, p12)
		end))
		table.insert(t.connections, v1.TouchButton.InputEnded:Connect(function(p12) --[[ Line: 100 | Upvalues: f2 (copy), p1 (copy) ]]
			if p12.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			f2(p1, Enum.UserInputState.End, p12)
		end))
		ContextActionService:BindAction(p1, f2, false, p3, p4)
		t2._bindings[p1] = t
	end
end
function t2.unbindAction(p1) --[[ unbindAction | Line: 113 | Upvalues: t2 (copy), ContextActionService (copy) ]]
	local v1 = t2._bindings[p1]

	if v1 then
		for v2, v3 in v1.connections do
			v3:Disconnect()
		end

		v1.frame:Destroy()
		t2._bindings[p1] = nil
	end

	ContextActionService:UnbindAction(p1)
end
function t2._updateInputDisplay(p1, p2) --[[ _updateInputDisplay | Line: 129 | Upvalues: t (copy), t2 (copy) ]]
	local ButtonDisplayFrame = p1.frame.ContentFrame.InputFrame:FindFirstChild("ButtonDisplayFrame")

	if ButtonDisplayFrame then
		ButtonDisplayFrame:Destroy()
	end

	local v1 = nil

	if p2 == t.KeyboardAndMouse then
		v1 = t2._getButtonDisplayForInput(p1.keyboardAndMouseInput)
	elseif p2 == t.Gamepad then
		v1 = t2._getButtonDisplayForInput(p1.gamepadInput)
	elseif p2 == t.Touch then
		v1 = t2._getButtonDisplayForInput(Enum.UserInputType.Touch)
	end

	v1.Parent = p1.frame.ContentFrame.InputFrame
	p1.frame.TouchButton.Visible = p2 == t.Touch
end
function t2._getButtonDisplayForInput(p1) --[[ _getButtonDisplayForInput | Line: 152 | Upvalues: Instances (copy), UserInputService (copy), InputMetadata (copy) ]]
	local v1 = Instances.ButtonDisplayFrame:Clone()
	local v2 = if p1.EnumType == Enum.KeyCode then UserInputService:GetImageForKeyCode(p1) else nil

	if p1 == Enum.UserInputType.Touch then
		Instances.TouchImageLabel:Clone().Parent = v1

		return v1
	end

	if v2 and v2 ~= "" then
		local v4 = Instances.GamepadImageLabel:Clone()

		v4.Image = v2
		v4.Parent = v1

		return v1
	end

	if InputMetadata.MouseButtonImage[p1] then
		local v5 = Instances.MouseImageLabel:Clone()

		v5.Image = InputMetadata.MouseButtonImage[p1]
		v5.Parent = v1

		return v1
	end

	Instances.KeyboardBorderImage:Clone().Parent = v1

	local v6 = UserInputService:GetStringForKeyCode(p1)
	local v7 = InputMetadata.KeyboardButtonImage[p1] or InputMetadata.KeyboardButtonIconMapping[v6]

	if not v7 then
		local v8 = InputMetadata.KeyCodeToTextMapping[p1]

		if v8 then
			v6 = v8
		end
	end

	if v7 then
		local v9 = Instances.KeyboardImageLabel:Clone()

		v9.Image = v7
		v9.Parent = v1

		return v1
	end

	if v6 and v6 ~= "" then
		local v10 = Instances.KeyboardTextLabel:Clone()

		v10.Text = v6
		v10.TextSize = InputMetadata.KeyCodeToFontSize[p1] or InputMetadata.DefaultFontSize
		v10.Parent = v1
	end

	return v1
end
function t2._getCategoryOfInputType(p1) --[[ _getCategoryOfInputType | Line: 208 | Upvalues: t (copy) ]]
	if string.find(p1.Name, "Gamepad") then
		return t.Gamepad
	end

	if p1 == Enum.UserInputType.Keyboard or string.find(p1.Name, "Mouse") then
		return t.KeyboardAndMouse
	end

	if p1 == Enum.UserInputType.Touch then
		return t.Touch
	end

	return t.Unknown
end
function t2._getDefaultInputCategory() --[[ _getDefaultInputCategory | Line: 221 | Upvalues: UserInputService (copy), t (copy) ]]
	if UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
		return t.KeyboardAndMouse
	end

	if UserInputService.TouchEnabled then
		return t.Touch
	end

	if UserInputService.GamepadEnabled then
		return t.Gamepad
	end

	return t.Unknown
end
function t2._updatePositionAndScale() --[[ _updatePositionAndScale | Line: 234 | Upvalues: PlayerGui (copy), ActionGui (copy), InputCategorizer (copy), t (copy) ]]
	local v1 = PlayerGui:FindFirstChild("TouchGui") ~= nil
	local v2 = if math.min(ActionGui.AbsoluteSize.X, ActionGui.AbsoluteSize.Y) < 500 then true else false
	local sum = 40

	if v1 and InputCategorizer.getLastInputCategory() == t.Touch then
		sum = sum + (if v2 then 100 else 240)
	end

	ActionGui.ListFrame.UIScale.Scale = if v2 then 0.85 else 1
	ActionGui.ListFrame.Position = UDim2.new(1, -40, 1, -sum)
end
function t2._initialize() --[[ _initialize | Line: 252 | Upvalues: t2 (copy), RunService (copy), PlayerGui (copy), InputCategorizer (copy), ActionGui (copy) ]]
	local v1 = not t2._initialized

	assert(v1, "ActionManager already initialized!")
	assert(RunService:IsClient(), "ActionManager can only be used on the client!")
	PlayerGui.ChildAdded:Connect(function(p1) --[[ Line: 257 | Upvalues: t2 (ref) ]]
		if p1.Name ~= "TouchGui" then
			return
		end

		t2._updatePositionAndScale()
	end)
	PlayerGui.ChildRemoved:Connect(function(p1) --[[ Line: 263 | Upvalues: t2 (ref) ]]
		if p1.Name ~= "TouchGui" then
			return
		end

		t2._updatePositionAndScale()
	end)
	InputCategorizer.lastInputCategoryChanged:Connect(function(p1) --[[ Line: 270 | Upvalues: t2 (ref) ]]
		for v1, v2 in t2._bindings do
			t2._updateInputDisplay(v2, p1)
		end
	end)
	ActionGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(t2._updatePositionAndScale)
	InputCategorizer.lastInputCategoryChanged:Connect(t2._updatePositionAndScale)
	ActionGui.Parent = PlayerGui
	t2._updatePositionAndScale()
	t2._initialized = true
end
t2._initialize()

return t2