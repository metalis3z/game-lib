-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("GuiService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TextChatService")
local v4 = game:GetService("Players")
local v5 = game:GetService("ReplicatedStorage")
local v6 = game:GetService("StarterPlayer")
local v_u_7 = v4.LocalPlayer
local v_u_8 = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch }
local v_u_9 = require(v6.StarterPlayerScripts.Controllers.PermissionController)
local v_u_10 = require(v5.Registries.PermissionRegistries.PermissionNodesEnumsType)
local v_u_11 = {
	["Valid"] = true,
	["AutoComplete"] = nil,
	["ProcessEntry"] = nil,
	["OnTextChanged"] = nil,
	["Cmdr"] = nil,
	["HistoryState"] = nil
}
local v_u_12 = v_u_7:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame")
local v_u_13 = v_u_12:WaitForChild("Line")
local v_u_14 = v_u_12:WaitForChild("Entry")
v_u_13.Parent = nil
function v_u_11.UpdateLabel(p15)
	-- upvalues: (copy) v_u_14, (copy) v_u_7
	v_u_14.TextLabel.Text = v_u_7.Name .. "@" .. p15.Cmdr.PlaceName .. "$"
end
function v_u_11.GetLabel(_)
	-- upvalues: (copy) v_u_14
	return v_u_14.TextLabel.Text
end
function v_u_11.UpdateWindowHeight(_)
	-- upvalues: (copy) v_u_12
	local v16 = v_u_12.UIListLayout.AbsoluteContentSize.Y + v_u_12.UIPadding.PaddingTop.Offset + v_u_12.UIPadding.PaddingBottom.Offset
	v_u_12.Size = UDim2.new(v_u_12.Size.X.Scale, v_u_12.Size.X.Offset, 0, (math.clamp(v16, 0, 300)))
	v_u_12.CanvasPosition = Vector2.new(0, v16)
end
function v_u_11.AddLine(p17, p18, p19)
	-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_12
	local v20 = p19 or {}
	local v21 = tostring(p18)
	local v22 = typeof(v20) == "Color3" and {
		["Color"] = v20
	} or v20
	if #v21 == 0 then
		v_u_11:UpdateWindowHeight()
	else
		local v23 = p17.Cmdr.Util.EmulateTabstops(v21 or "nil", 8)
		local v24 = v_u_13:Clone()
		v24.Text = v23
		v24.TextColor3 = v22.Color or v24.TextColor3
		v24.RichText = v22.RichText or false
		v24.Parent = v_u_12
	end
end
function v_u_11.IsVisible(_)
	-- upvalues: (copy) v_u_12
	return v_u_12.Visible
end
function v_u_11.SetVisible(p25, p26)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_14, (copy) v_u_2
	v_u_12.Visible = p26
	if p26 then
		p25.PreviousChatWindowConfigurationEnabled = v_u_3.ChatWindowConfiguration.Enabled
		p25.PreviousChatInputBarConfigurationEnabled = v_u_3.ChatInputBarConfiguration.Enabled
		v_u_3.ChatWindowConfiguration.Enabled = false
		v_u_3.ChatInputBarConfiguration.Enabled = false
		v_u_14.TextBox:CaptureFocus()
		p25:SetEntryText("")
		if p25.Cmdr.ActivationUnlocksMouse then
			p25.PreviousMouseBehavior = v_u_2.MouseBehavior
			v_u_2.MouseBehavior = Enum.MouseBehavior.Default
			return
		end
	else
		v_u_3.ChatWindowConfiguration.Enabled = p25.PreviousChatWindowConfigurationEnabled == nil and true or p25.PreviousChatWindowConfigurationEnabled
		v_u_3.ChatInputBarConfiguration.Enabled = p25.PreviousChatInputBarConfigurationEnabled == nil and true or p25.PreviousChatInputBarConfigurationEnabled
		v_u_14.TextBox:ReleaseFocus()
		p25.AutoComplete:Hide()
		if p25.PreviousMouseBehavior then
			v_u_2.MouseBehavior = p25.PreviousMouseBehavior
			p25.PreviousMouseBehavior = nil
		end
	end
end
function v_u_11.Hide(p27)
	return p27:SetVisible(false)
end
function v_u_11.Show(p28)
	return p28:SetVisible(true)
end
function v_u_11.SetEntryText(p29, p30)
	-- upvalues: (copy) v_u_14, (copy) v_u_11
	v_u_14.TextBox.Text = p30
	if p29:IsVisible() then
		v_u_14.TextBox:CaptureFocus()
		v_u_14.TextBox.CursorPosition = #p30 + 1
		v_u_11:UpdateWindowHeight()
	end
end
function v_u_11.GetEntryText(_)
	-- upvalues: (copy) v_u_14
	return v_u_14.TextBox.Text:gsub("\t", "")
end
function v_u_11.SetIsValidInput(p31, p32, p33)
	-- upvalues: (copy) v_u_14
	v_u_14.TextBox.TextColor3 = p32 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
	p31.Valid = p32
	p31._errorText = p33
end
function v_u_11.HideInvalidState(_)
	-- upvalues: (copy) v_u_14
	v_u_14.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end
function v_u_11.LoseFocus(p34, p35)
	-- upvalues: (copy) v_u_14, (copy) v_u_12, (copy) v_u_1
	local v36 = v_u_14.TextBox.Text
	p34:ClearHistoryState()
	if v_u_12.Visible and not v_u_1.MenuIsOpen then
		v_u_14.TextBox:CaptureFocus()
	elseif v_u_1.MenuIsOpen and v_u_12.Visible then
		p34:Hide()
	end
	if p35 and p34.Valid then
		wait()
		p34:SetEntryText("")
		p34.ProcessEntry(v36)
	elseif p35 then
		p34:AddLine(p34._errorText, Color3.fromRGB(255, 153, 153))
	end
end
function v_u_11.TraverseHistory(p37, p38)
	local v39 = p37.Cmdr.Dispatcher:GetHistory()
	if p37.HistoryState == nil then
		p37.HistoryState = {
			["Position"] = #v39 + 1,
			["InitialText"] = p37:GetEntryText()
		}
	end
	local v40 = p37.HistoryState
	local v41 = p37.HistoryState.Position + p38
	local v42 = #v39 + 1
	v40.Position = math.clamp(v41, 1, v42)
	p37:SetEntryText(p37.HistoryState.Position == #v39 + 1 and p37.HistoryState.InitialText or v39[p37.HistoryState.Position])
end
function v_u_11.ClearHistoryState(p43)
	p43.HistoryState = nil
end
function v_u_11.SelectVertical(p44, p45)
	if p44.AutoComplete:IsVisible() and not p44.HistoryState then
		p44.AutoComplete:Select(p45)
	else
		p44:TraverseHistory(p45)
	end
end
local v_u_46 = 0
local v_u_47 = 0
function v_u_11.BeginInput(p48, p49, p50)
	-- upvalues: (copy) v_u_1, (copy) v_u_9, (copy) v_u_7, (copy) v_u_10, (ref) v_u_46, (ref) v_u_47, (copy) v_u_8, (copy) v_u_12
	if v_u_1.MenuIsOpen then
		p48:Hide()
	end
	if p50 and p48:IsVisible() == false then
		return
	elseif p48.Cmdr.ActivationKeys[p49.KeyCode] and v_u_9:HasPermissionNode(v_u_7, v_u_10.VIEW_COMMAND_BAR_PERMISSION) then
		if p48.Cmdr.MashToEnable and not p48.Cmdr.Enabled then
			if tick() - v_u_46 < 1 then
				if v_u_47 >= 5 then
					return p48.Cmdr:SetEnabled(true)
				end
				v_u_47 = v_u_47 + 1
			else
				v_u_47 = 1
			end
			v_u_46 = tick()
		elseif p48.Cmdr.Enabled then
			p48:SetVisible(not p48:IsVisible())
			wait()
			p48:SetEntryText("")
			if v_u_1.MenuIsOpen then
				p48:Hide()
			end
		end
	elseif p48.Cmdr.Enabled == false or not p48:IsVisible() then
		if p48:IsVisible() then
			p48:Hide()
		end
	elseif p48.Cmdr.HideOnLostFocus and table.find(v_u_8, p49.UserInputType) then
		local v51 = p49.Position
		local v52 = v_u_12.AbsolutePosition
		local v53 = v_u_12.AbsoluteSize
		if v51.X < v52.X or (v51.X > v52.X + v53.X or (v51.Y < v52.Y or v51.Y > v52.Y + v53.Y)) then
			p48:Hide()
			return
		end
	else
		if p49.KeyCode == Enum.KeyCode.Down then
			p48:SelectVertical(1)
			return
		end
		if p49.KeyCode == Enum.KeyCode.Up then
			p48:SelectVertical(-1)
			return
		end
		if p49.KeyCode == Enum.KeyCode.Return then
			wait()
			p48:SetEntryText(p48:GetEntryText():gsub("\n", ""):gsub("\r", ""))
			return
		end
		if p49.KeyCode == Enum.KeyCode.Tab then
			local v54 = p48.AutoComplete:GetSelectedItem()
			local v55 = p48:GetEntryText()
			if v54 and not (v55:sub(#v55, #v55):match("%s") and p48.AutoComplete.LastItem) then
				local v56 = v54[2]
				local v57 = p48.AutoComplete.Command
				local v58, v59
				if v57 then
					local v60 = p48.AutoComplete.Arg
					v58 = v57.Alias
					if p48.AutoComplete.NumArgs == #v57.ArgumentDefinitions then
						v59 = false
					else
						v59 = p48.AutoComplete.IsPartial == false
					end
					local v61 = v57.Arguments
					for v62 = 1, #v61 do
						local v63 = v61[v62]
						local v64 = v63.RawSegments
						if v63 == v60 then
							v64[#v64] = v56
						end
						local v65 = v63.Prefix .. table.concat(v64, ",")
						if v65:find(" ") or v65 == "" then
							v65 = ("%q"):format(v65)
						end
						v58 = ("%s %s"):format(v58, v65)
						if v63 == v60 then
							break
						end
					end
				else
					v58 = v56
					v59 = true
				end
				wait()
				p48:SetEntryText(v58 .. (v59 and " " or ""))
			else
				wait()
				p48:SetEntryText(p48:GetEntryText())
			end
		end
		p48:ClearHistoryState()
	end
end
v_u_14.TextBox.FocusLost:Connect(function(p66)
	-- upvalues: (copy) v_u_11
	return v_u_11:LoseFocus(p66)
end)
v_u_2.InputBegan:Connect(function(p67, p68)
	-- upvalues: (copy) v_u_11
	return v_u_11:BeginInput(p67, p68)
end)
v_u_14.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_12, (copy) v_u_14, (copy) v_u_11
	v_u_12.CanvasPosition = Vector2.new(0, v_u_12.AbsoluteCanvasSize.Y)
	if v_u_14.TextBox.Text:match("\t") then
		v_u_14.TextBox.Text = v_u_14.TextBox.Text:gsub("\t", "")
	elseif v_u_11.OnTextChanged then
		return v_u_11.OnTextChanged(v_u_14.TextBox.Text)
	end
end)
v_u_12.ChildAdded:Connect(function()
	-- upvalues: (copy) v_u_11
	task.defer(v_u_11.UpdateWindowHeight)
end)
return v_u_11
