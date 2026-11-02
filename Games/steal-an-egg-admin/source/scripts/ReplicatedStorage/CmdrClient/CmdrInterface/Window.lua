-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = {
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.Touch
}
local v2 = { Valid = true }
local Frame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame")
local Line = Frame:WaitForChild("Line")
local Entry = Frame:WaitForChild("Entry")

Line.Parent = nil

function v2.UpdateLabel(v3) -- line 18 | captures: LocalPlayer, Entry
    Entry.TextLabel.Text = LocalPlayer.Name .. "@" .. v3.Cmdr.PlaceName .. "$"
end

function v2.GetLabel(v4) -- line 21 | captures: Entry
    return Entry.TextLabel.Text
end

function v2.UpdateWindowHeight(v5) -- line 24 | captures: Frame
    local v6 = Frame.UIListLayout.AbsoluteContentSize.Y + Frame.UIPadding.PaddingTop.Offset + Frame.UIPadding.PaddingBottom.Offset
    Frame.Size = UDim2.new(Frame.Size.X.Scale, Frame.Size.X.Offset, 0, (math.clamp(v6, 0, 300)))
    Frame.CanvasPosition = Vector2.new(0, v6)
end

function v2.AddLine(v7, v8, v9) -- line 29 | captures: v2, Frame, Line
    local v10 = v9 or {}
    local v11 = tostring(v8)
    if typeof(v10) == "Color3" then
        v10 = { Color = v10 }
    end
    if #v11 == 0 then
        v2:UpdateWindowHeight()
    else
        local v12 = v7.Cmdr.Util.EmulateTabstops(v11 or "nil", 8)
        local v13 = Line:Clone()
        v13.Text = v12
        v13.TextColor3 = v10.Color or v13.TextColor3
        v13.RichText = v10.RichText or false
        v13.Parent = Frame
    end
end

function v2.IsVisible(v14) -- line 54 | captures: Frame
    return Frame.Visible
end

function v2.SetVisible(v15, v16) -- line 57 | captures: UserInputService, TextChatService, Frame, Entry
    Frame.Visible = v16
    if v16 then
        v15.PreviousChatWindowConfigurationEnabled = TextChatService.ChatWindowConfiguration.Enabled
        v15.PreviousChatInputBarConfigurationEnabled = TextChatService.ChatInputBarConfiguration.Enabled
        TextChatService.ChatWindowConfiguration.Enabled = false
        TextChatService.ChatInputBarConfiguration.Enabled = false
        Entry.TextBox:CaptureFocus()
        v15:SetEntryText("")
        if v15.Cmdr.ActivationUnlocksMouse then
            v15.PreviousMouseBehavior = UserInputService.MouseBehavior
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    else
        local v17 = if v15.PreviousChatWindowConfigurationEnabled == nil then true else v15.PreviousChatWindowConfigurationEnabled
        TextChatService.ChatWindowConfiguration.Enabled = v17
        local v18 = if v15.PreviousChatInputBarConfigurationEnabled == nil then true else v15.PreviousChatInputBarConfigurationEnabled
        TextChatService.ChatInputBarConfiguration.Enabled = v18
        Entry.TextBox:ReleaseFocus()
        v15.AutoComplete:Hide()
        if v15.PreviousMouseBehavior then
            UserInputService.MouseBehavior = v15.PreviousMouseBehavior
            v15.PreviousMouseBehavior = nil
        end
    end
end

local function Hide(v19) -- line 93
    return v19:SetVisible(false)
end

v2.Hide = Hide

local function Show(v20) -- line 96
    return v20:SetVisible(true)
end

v2.Show = Show

function v2.SetEntryText(v21, v22) -- line 99 | captures: v2, Entry
    Entry.TextBox.Text = v22
    if not v21:IsVisible() then
        return
    end
    Entry.TextBox:CaptureFocus()
    Entry.TextBox.CursorPosition = #v22 + 1
    v2:UpdateWindowHeight()
end

function v2.GetEntryText(v23) -- line 107 | captures: Entry
    return Entry.TextBox.Text:gsub("\t", "")
end

function v2.SetIsValidInput(v24, v25, v26) -- line 110 | captures: Entry
    Entry.TextBox.TextColor3 = v25 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
    v24.Valid = v25
    v24._errorText = v26
end

function v2.HideInvalidState(v27) -- line 125 | captures: Entry
    Entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end

function v2.LoseFocus(v28, v29) -- line 128 | captures: GuiService, Frame, Entry
    local Text = Entry.TextBox.Text
    v28:ClearHistoryState()
    if Frame.Visible then
        if not GuiService.MenuIsOpen then
            Entry.TextBox:CaptureFocus()
        end
    elseif GuiService.MenuIsOpen and Frame.Visible then
        v28:Hide()
    end
    if not (v29 and v28.Valid) then
        if v29 then
            v28:AddLine(v28._errorText, Color3.fromRGB(255, 153, 153))
        end
    else
        wait()
        v28:SetEntryText("")
        v28.ProcessEntry(Text)
    end
end

local function TraverseHistory(v30, v31) -- line 148
    local v32 = v30.Cmdr.Dispatcher:GetHistory()
    if v30.HistoryState == nil then
        v30.HistoryState = {
            Position = #v32 + 1,
            InitialText = v30:GetEntryText()
        }
    end
    local HistoryState = v30.HistoryState
    local v33 = v30.HistoryState.Position + v31
    local v34 = #v32 + 1
    HistoryState.Position = math.clamp(v33, 1, v34)
    v30:SetEntryText(v30.HistoryState.Position == #v32 + 1 and v30.HistoryState.InitialText or v32[v30.HistoryState.Position])
end

v2.TraverseHistory = TraverseHistory

local function ClearHistoryState(v35) -- line 165
    v35.HistoryState = nil
end

v2.ClearHistoryState = ClearHistoryState

local function SelectVertical(v36, v37) -- line 168
    if v36.AutoComplete:IsVisible() then
        if v36.HistoryState then
            v36:TraverseHistory(v37)
        else
            v36.AutoComplete:Select(v37)
        end
    else
        v36:TraverseHistory(v37)
    end
end

v2.SelectVertical = SelectVertical

local v38 = 0
local v39 = 0

function v2.BeginInput(v40, v41, v42) -- line 181 | captures: v38, v39, GuiService, v1, Frame
    if GuiService.MenuIsOpen then
        v40:Hide()
    end
    if v42 then
        if v40:IsVisible() == false then
        end
    elseif v40.Cmdr.ActivationKeys[v41.KeyCode] then
        if not v40.Cmdr.MashToEnable or v40.Cmdr.Enabled then
            if v40.Cmdr.Enabled then
                v40:SetVisible(not v40:IsVisible())
                wait()
                v40:SetEntryText("")
                if GuiService.MenuIsOpen then
                    v40:Hide()
                end
            end
        else
            if tick() - v38 >= 1 then
                v39 = 1
            else
                if v39 >= 5 then
                    return v40.Cmdr:SetEnabled(true)
                end
                v39 += 1
            end
            v38 = tick()
        end
    elseif v40.Cmdr.Enabled == false then
        if v40:IsVisible() then
            v40:Hide()
        end
    elseif v40:IsVisible() then
        if v40.Cmdr.HideOnLostFocus then
            if table.find(v1, v41.UserInputType) then
                local Position = v41.Position
                local AbsolutePosition = Frame.AbsolutePosition
                local AbsoluteSize = Frame.AbsoluteSize
                if not (Position.X < AbsolutePosition.X) and not (AbsolutePosition.X + AbsoluteSize.X < Position.X) and not (Position.Y < AbsolutePosition.Y) then
                    local v43 = AbsolutePosition.Y + AbsoluteSize.Y
                    if not (Position.Y <= v43) then
                        v40:Hide()
                    end
                else
                    v40:Hide()
                end
            end
        elseif v41.KeyCode == Enum.KeyCode.Down then
            v40:SelectVertical(1)
        elseif v41.KeyCode == Enum.KeyCode.Up then
            v40:SelectVertical(-1)
        elseif v41.KeyCode == Enum.KeyCode.Return then
            wait()
            v40:SetEntryText(v40:GetEntryText():gsub("\n", ""):gsub("\r", ""))
        elseif v41.KeyCode == Enum.KeyCode.Tab then
            local v44 = v40.AutoComplete:GetSelectedItem()
            local v45 = v40:GetEntryText()
            if v44 then
                if v45:sub(#v45, #v45):match("%s") then
                    if v40.AutoComplete.LastItem then
                        wait()
                        v40:SetEntryText(v40:GetEntryText())
                    end
                else
                    local v46 = v44[2]
                    local Command = v40.AutoComplete.Command
                    local Alias, v47
                    if Command then
                        local Arg = v40.AutoComplete.Arg
                        Alias = Command.Alias
                        if v40.AutoComplete.NumArgs == #Command.ArgumentDefinitions then
                            v47 = false
                        else
                            v47 = v40.AutoComplete.IsPartial == false
                        end
                        local Arguments = Command.Arguments
                        local v48 = #Arguments
                        for v49 = 1, v48 do
                            local v50 = Arguments[v49]
                            local RawSegments = v50.RawSegments
                            if v50 == Arg then
                                RawSegments[#RawSegments] = v46
                            end
                            local v51 = v50.Prefix .. table.concat(RawSegments, ",")
                            if v51:find(" ") then
                                v51 = ("%q"):format(v51)
                            end
                            Alias = ("%s %s"):format(Alias, v51)
                            if v50 == Arg then
                                wait()
                                local v52 = if v47 then " " else "";
                                (nil):SetEntryText(Alias .. v52)
                                return
                            end
                        end
                    else
                        v47 = true
                        Alias = v46
                    end
                    wait()
                    local v53 = if v47 then " " else "";
                    (nil):SetEntryText(Alias .. v53)
                end
            else
                wait()
                v40:SetEntryText(v40:GetEntryText())
            end
        else
            v40:ClearHistoryState()
        end
    elseif v40:IsVisible() then
        v40:Hide()
    end
end

Entry.TextBox.FocusLost:Connect(function(v54) -- line 326 | captures: v2
    return v2:LoseFocus(v54)
end)
UserInputService.InputBegan:Connect(function(v55, v56) -- line 329 | captures: v2
    return v2:BeginInput(v55, v56)
end)
Entry.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- line 333 | captures: v2, Frame, Entry
    Frame.CanvasPosition = Vector2.new(0, Frame.AbsoluteCanvasSize.Y)
    if Entry.TextBox.Text:match("\t") then
        Entry.TextBox.Text = Entry.TextBox.Text:gsub("\t", "")
    elseif v2.OnTextChanged then
        return v2.OnTextChanged(Entry.TextBox.Text)
    end
end)
Frame.ChildAdded:Connect(function() -- line 343 | captures: v2
    task.defer(v2.UpdateWindowHeight)
end)
return v2
