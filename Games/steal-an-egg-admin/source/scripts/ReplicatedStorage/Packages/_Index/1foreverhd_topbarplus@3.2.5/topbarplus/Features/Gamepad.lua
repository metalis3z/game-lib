-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local DPadUp = Enum.KeyCode.DPadUp
local v1 = {}
local v2

function v1.start(v3) -- line 12 | captures: v2, GamepadService, UserInputService, GuiService, DPadUp, v1
    v2 = v3
    local v4 = if v2.highlightKey == nil then DPadUp else v2.highlightKey
    v2.highlightKey = v4
    v2.highlightIcon = false
    task.delay(1, function() -- line 22 | captures: v2, GamepadService, UserInputService, GuiService, DPadUp, v1
        local iconsDictionary = v2.iconsDictionary

        local function getIconFromSelectedObject() -- line 24 | captures: iconsDictionary, GuiService
            local SelectedObject = GuiService.SelectedObject
            local v5 = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
            return v5 and iconsDictionary[v5]
        end

        local v6
        local v7 = DPadUp ~= v2.highlightKey
        local v8 = DPadUp ~= v2.highlightKey
        local Selection = require(script.Parent.Parent.Elements.Selection)

        local function updateSelectedObject() -- line 40 | captures: v6, v7, v8, iconsDictionary, Selection, v2, UserInputService, GuiService, v1
            local SelectedObject = GuiService.SelectedObject
            local v9 = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
            local v10 = v9 and iconsDictionary[v9]
            local GamepadEnabled = UserInputService.GamepadEnabled
            if v10 then
                if GamepadEnabled then
                    local ClickRegion = v10:getInstance("ClickRegion")
                    local selection = v10.selection
                    if not selection then
                        selection = v10.janitor:add(Selection(v2))
                        selection:SetAttribute("IgnoreVisibilityUpdater", true)
                        selection.Parent = v10.widget
                        v10.selection = selection
                        v10:refreshAppearance(selection)
                    end
                    ClickRegion.SelectionImageObject = selection.Selection
                end
                if v6 and v6 ~= v10 then
                    v6:setIndicator()
                end
                local ButtonB
                if GamepadEnabled then
                    if v8 or v10.parentIconUID then
                    else
                        ButtonB = Enum.KeyCode.ButtonB
                    end
                end
                v6 = v10
                v2.lastHighlightedIcon = v10
                v10:setIndicator(ButtonB)
            else
                local highlightKey
                if GamepadEnabled then
                    if v7 then
                    else
                        highlightKey = v2.highlightKey
                    end
                end
                v6 = v6 or v1.getIconToHighlight()
                if highlightKey == v2.highlightKey then
                    v7 = true
                end
                if v6 then
                    v6:setIndicator(highlightKey)
                end
            end
        end

        GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject)
        local Gamepad = Enum.PreferredInput.Gamepad
        UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- line 103 | captures: v7, v8, updateSelectedObject, Gamepad, UserInputService
            if UserInputService.PreferredInput ~= Gamepad then
                v7 = false
                v8 = false
            end
            updateSelectedObject()
        end)
        if UserInputService.PreferredInput == Gamepad then
        end
        updateSelectedObject()
        UserInputService.InputBegan:Connect(function(v11, v12) -- line 113 | captures: iconsDictionary, v2, GamepadService, GuiService, v1
            if v11.UserInputType == Enum.UserInputType.MouseButton1 then
                local SelectedObject = GuiService.SelectedObject
                local v13 = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
                if v13 and iconsDictionary[v13] then
                    GuiService.SelectedObject = nil
                end
            elseif v11.KeyCode == v2.highlightKey then
                local v14 = v1.getIconToHighlight()
                if v14 then
                    if GamepadService.GamepadCursorEnabled then
                        task.wait(0.2)
                        GamepadService:DisableGamepadCursor()
                    end
                    local ClickRegion = v14:getInstance("ClickRegion")
                    GuiService.SelectedObject = ClickRegion
                end
            end
        end)
    end)
end

function v1.getIconToHighlight() -- line 144 | captures: v2
    local v15 = v2.highlightIcon or v2.lastHighlightedIcon
    if not v15 then
        local X
        for v16, v17 in pairs(v2.iconsDictionary) do
            if not v17.parentIconUID then
                if X then
                    if X <= v17.widget.AbsolutePosition.X then
                    end
                else
                    X = v17.widget.AbsolutePosition.X
                end
            end
        end
    end
    return v15
end

function v1.registerButton(v18) -- line 162 | captures: GamepadService, UserInputService, GuiService
    local v19 = false
    v18.InputBegan:Connect(function(v20) -- line 164 | captures: v19
        v19 = true
        task.wait()
        task.wait()
        v19 = false
    end)
    local v21 = UserInputService.InputBegan:Connect(function(v22) -- line 170 | captures: v19, v18, GamepadService, GuiService
        task.wait()
        if v22.KeyCode == Enum.KeyCode.ButtonA then
            if v19 then
                task.wait(0.2)
                GamepadService:DisableGamepadCursor()
                GuiService.SelectedObject = v18
            end
        else
            local v23 = GuiService.SelectedObject == v18
            local v24 = { "ButtonB", "ButtonSelect" }
            local Name = v22.KeyCode.Name
            if table.find(v24, Name) and v23 then
                if Name == "ButtonSelect" then
                    if GamepadService.GamepadCursorEnabled then
                        GuiService.SelectedObject = nil
                    end
                else
                    GuiService.SelectedObject = nil
                end
            end
        end
    end)
    v18.Destroying:Once(function() -- line 191 | captures: v21
        v21:Disconnect()
    end)
end

return v1
