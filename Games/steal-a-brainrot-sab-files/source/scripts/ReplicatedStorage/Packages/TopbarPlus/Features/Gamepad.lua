

local l_GamepadService_0 = game:GetService("GamepadService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_DPadUp_0 = Enum.KeyCode.DPadUp;
local l_Gamepad_0 = Enum.PreferredInput.Gamepad;
local v5 = {};
local v6 = nil;
v5.start = function(v7)
    v6 = v7;
    v6.highlightKey = if v6.highlightKey ~= nil then v6.highlightKey else l_DPadUp_0;
    v6.highlightIcon = false;
    task.delay(1, function()
        local l_iconsDictionary_0 = v6.iconsDictionary;
        local function _()
            local l_SelectedObject_0 = l_GuiService_0.SelectedObject;
            local v10 = l_SelectedObject_0 and l_SelectedObject_0:GetAttribute("CorrespondingIconUID");
            return v10 and l_iconsDictionary_0[v10];
        end;
        local v12 = nil;
        local v13 = l_DPadUp_0 ~= v6.highlightKey;
        local v14 = l_DPadUp_0 ~= v6.highlightKey;
        local v15 = require(script.Parent.Parent.Elements.Selection);
        local function v20()
            local l_SelectedObject_1 = l_GuiService_0.SelectedObject;
            local v17 = l_SelectedObject_1 and l_SelectedObject_1:GetAttribute("CorrespondingIconUID");
            local v18 = v17 and l_iconsDictionary_0[v17];
            l_SelectedObject_1 = l_UserInputService_0.PreferredInput == l_Gamepad_0;
            if v18 then
                if l_SelectedObject_1 then
                    v17 = v18:getInstance("ClickRegion");
                    local l_selection_0 = v18.selection;
                    if not l_selection_0 then
                        l_selection_0 = v18.janitor:add(v15(v6));
                        l_selection_0:SetAttribute("IgnoreVisibilityUpdater", true);
                        l_selection_0.Parent = v18.widget;
                        v18.selection = l_selection_0;
                        v18:refreshAppearance(l_selection_0);
                    end;
                    v17.SelectionImageObject = l_selection_0.Selection;
                end;
                if v12 and v12 ~= v18 then
                    v12:setIndicator();
                end;
                v17 = if not l_SelectedObject_1 or v14 or v18.parentIconUID then nil else Enum.KeyCode.ButtonB;
                v12 = v18;
                v6.lastHighlightedIcon = v18;
                v18:setIndicator(v17);
                return;
            else
                v17 = if not l_SelectedObject_1 or v13 then nil else v6.highlightKey;
                if not v12 then
                    v12 = v5.getIconToHighlight();
                end;
                if v17 == v6.highlightKey then
                    v13 = true;
                end;
                if v12 then
                    v12:setIndicator(v17);
                end;
                return;
            end;
        end;
        l_GuiService_0:GetPropertyChangedSignal("SelectedObject"):Connect(v20);
        local function v21()
            if not (l_UserInputService_0.PreferredInput == l_Gamepad_0) then
                v13 = false;
                v14 = false;
            end;
            v20();
        end;
        l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(v21);
        if not (l_UserInputService_0.PreferredInput == l_Gamepad_0) then
            v13 = false;
            v14 = false;
        end;
        v20();
        l_UserInputService_0.InputBegan:Connect(function(v22, _)
            if v22.UserInputType == Enum.UserInputType.MouseButton1 then
                local l_SelectedObject_2 = l_GuiService_0.SelectedObject;
                local v25 = l_SelectedObject_2 and l_SelectedObject_2:GetAttribute("CorrespondingIconUID");
                if v25 and l_iconsDictionary_0[v25] then
                    l_GuiService_0.SelectedObject = nil;
                end;
                return;
            elseif v22.KeyCode ~= v6.highlightKey then
                return;
            else
                local v26 = v5.getIconToHighlight();
                if v26 then
                    if l_GamepadService_0.GamepadCursorEnabled then
                        task.wait(0.2);
                        l_GamepadService_0:DisableGamepadCursor();
                    end;
                    l_GuiService_0.SelectedObject = v26:getInstance("ClickRegion");
                end;
                return;
            end;
        end);
    end);
end;
v5.getIconToHighlight = function()
    local l_iconsDictionary_1 = v6.iconsDictionary;
    local v28 = v6.highlightIcon or v6.lastHighlightedIcon;
    if not v28 then
        local v29 = nil;
        for _, v31 in pairs(l_iconsDictionary_1) do
            if not v31.parentIconUID then
                local l_X_0 = v31.widget.AbsolutePosition.X;
                if not v29 or l_X_0 < v29 then
                    v28 = v31;
                    v29 = v28.widget.AbsolutePosition.X;
                end;
            end;
        end;
    end;
    return v28;
end;
v5.registerButton = function(v33)
    local v34 = false;
    v33.InputBegan:Connect(function(_)
        v34 = true;
        task.wait();
        task.wait();
        v34 = false;
    end);
    local v40 = l_UserInputService_0.InputBegan:Connect(function(v36)
        task.wait();
        if v36.KeyCode == Enum.KeyCode.ButtonA and v34 then
            task.wait(0.2);
            l_GamepadService_0:DisableGamepadCursor();
            l_GuiService_0.SelectedObject = v33;
            return;
        else
            local v37 = l_GuiService_0.SelectedObject == v33;
            local v38 = {
                "ButtonB", 
                "ButtonSelect"
            };
            local l_Name_0 = v36.KeyCode.Name;
            if table.find(v38, l_Name_0) and v37 and (l_Name_0 ~= "ButtonSelect" or l_GamepadService_0.GamepadCursorEnabled) then
                l_GuiService_0.SelectedObject = nil;
            end;
            return;
        end;
    end);
    v33.Destroying:Once(function()
        v40:Disconnect();
    end);
end;
return v5;