

local v1 = {}
local u2 = _G.HDAdminMain
local u3 = Enum.UserInputType.MouseMovement
local u4 = Enum.UserInputType.MouseButton1
local u5 = Enum.UserInputType.Touch
u2.chatting = false
u2.userInputService.TextBoxFocused:connect(function()

	u2.chatting = true
end)
u2.userInputService.TextBoxFocusReleased:connect(function()

	u2.chatting = false
end)
local u6 = game:GetService("TextChatService"):FindFirstChildOfClass("ChatInputBarConfiguration")
if u6 then
	u6:GetPropertyChangedSignal("IsFocused"):Connect(function()

		u2.chatting = u6.IsFocused
	end)
end
local v7 = { u2.gui.MainFrame }
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = nil
local function u15(p12, p13) 

	local v14 = p12.Position - u9
	p13.Position = UDim2.new(u10.X.Scale, u10.X.Offset + v14.X, u10.Y.Scale, u10.Y.Offset + v14.Y)
	if p13.AbsolutePosition.Y < -80 then
		p13.Position = p13.Position + UDim2.new(0, 0, 0, -p13.AbsolutePosition.Y)
	end
	if u11 then
		u2.gui.MainFrame.Position = p13.Position
	end
end
function v1.MakeFrameDraggable(_, u16) 

	local v17 = u16.DragBar
	(v17:FindFirstChild("Drag") or v17).InputBegan:Connect(function(u18)

		if u18.UserInputType == u4 or u18.UserInputType == u5 then
			u8 = u16
			u9 = u18.Position
			u10 = u16.Position
			u11 = u16:GetAttribute("AlsoDragMainFrame")
			u18.Changed:Connect(function()

				if u18.UserInputState == Enum.UserInputState.End then
					u8 = nil
				end
			end)
		end
	end)
end
local u19 = u8
for _, v20 in pairs(v7) do
	v1:MakeFrameDraggable(v20)
end
local u21 = { "laserEyes" }
local function u24(p22) 

	u2.lastHitPosition = p22
	for _, v23 in pairs(u21) do
		u2:GetModule("cf"):ActivateClientCommand(v23)
	end
end
u2.userInputService.InputChanged:Connect(function(p25, p26)

	if (p25.UserInputType == u3 or p25.UserInputType == u5) and ((not p26 or u19) and (u2.mouseDown and ((u2.lastHitPosition - p25.Position).magnitude < 150 or u2.device ~= "Mobile"))) then
		if u19 then
			u15(p25, u19)
		end
		u24(p25.Position)
	end
end)
local u27 = u2.gui.CmdBar
local u28 = u27.SearchFrame.TextBox
local u29 = {
	[Enum.KeyCode.Left] = true,
	[Enum.KeyCode.Right] = true,
	[Enum.KeyCode.Up] = true,
	[Enum.KeyCode.Down] = true
}
local u30 = {
	[Enum.KeyCode.Left] = "Left",
	[Enum.KeyCode.Right] = "Right",
	[Enum.KeyCode.Up] = "Forwards",
	[Enum.KeyCode.Down] = "Backwards",
	[Enum.KeyCode.A] = "Left",
	[Enum.KeyCode.D] = "Right",
	[Enum.KeyCode.W] = "Forwards",
	[Enum.KeyCode.S] = "Backwards",
	[Enum.KeyCode.Space] = "Up",
	[Enum.KeyCode.R] = "Up",
	[Enum.KeyCode.Q] = "Down",
	[Enum.KeyCode.LeftControl] = "Down",
	[Enum.KeyCode.F] = "Down"
}
u2.movementKeysPressed = {}
u2.userInputService.InputBegan:Connect(function(p31, p32)

	if (p31.UserInputType == u4 or p31.UserInputType == u5) and ((not p32 or u19) and not u2.mouseDown) then
		u2.mouseDown = true
		u24(p31.Position)
	elseif not u2.chatting or u27.Visible and #u28.Text < 2 then
		local v33 = u30[p31.KeyCode]
		if v33 then
			local v34 = u2.movementKeysPressed
			table.insert(v34, v33)
		elseif p31.KeyCode == Enum.KeyCode.E then
			for v35, _ in pairs(u2.commandSpeeds) do
				if u2.commandsActive[v35] then
					u2:GetModule("cf"):EndCommand(v35)
				else
					u2:GetModule("cf"):ActivateClientCommand(v35)
				end
			end
		elseif p31.KeyCode == Enum.KeyCode.Quote or p31.KeyCode == Enum.KeyCode.Semicolon then
			u2:GetModule("CmdBar"):ToggleBar(p31.KeyCode)
		end
	end
	if u29[p31.KeyCode] then
		u2:GetModule("CmdBar"):PressedArrowKey(p31.KeyCode)
	end
end)
u2.userInputService.InputEnded:Connect(function(p36, _)

	local v37 = u30[p36.KeyCode]
	if p36.UserInputType == u4 or p36.UserInputType == u5 then
		u2.mouseDown = false
	elseif v37 then
		for v38, v39 in pairs(u2.movementKeysPressed) do
			if v39 == v37 then
				table.remove(u2.movementKeysPressed, v38)
			end
		end
	end
end)
local v40 = (u2.player.Character or u2.player.CharacterAdded:Wait()):WaitForChild("Humanoid")
local v41 = u2:GetModule("Events")
if u2.device ~= "Computer" then
	v41:New("DoubleJumped", v40).Event:Connect(function()

		for v42, _ in pairs(u2.commandSpeeds) do
			if u2.commandsActive[v42] then
				u2:GetModule("cf"):EndCommand(v42)
			else
				u2:GetModule("cf"):ActivateClientCommand(v42)
			end
		end
	end)
end
return v1