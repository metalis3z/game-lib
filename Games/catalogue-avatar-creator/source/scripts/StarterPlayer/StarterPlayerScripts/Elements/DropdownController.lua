-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Modules = require(script.Parent.Parent.Modules);
local SoundController = require(Modules.Controllers.SoundController);
local ThemeController = require(Modules.Controllers.ThemeController);
game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local reference = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Viewport"):WaitForChild("reference");
local u1 = Color3.fromHex("3d3f45");
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local u2 = {};

local function addDropdown(p3) -- Line: 29
    -- upvalues: u2 (copy)
    table.insert(u2, p3);
end;

for _, v in CollectionService:GetTagged("dropdown") do
    table.insert(u2, v);
end;

CollectionService:GetInstanceAddedSignal("dropdown"):Connect(addDropdown);
CollectionService:GetInstanceRemovedSignal("dropdown"):Connect(function(p4) -- Line: 38
    -- upvalues: u2 (copy)
    for i, v in u2 do
        if v == p4 then
            table.remove(u2, i);

            return;
        end;
    end;
end);
local v5 = {};
local u6 = {};
u6.__index = u6;

local function normalizeAlphaOnClone(p7) -- Line: 52
    for _, descendant in p7:GetDescendants() do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            descendant.TextTransparency = 0;
        elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
            descendant.ImageTransparency = 0;
        elseif descendant:IsA("UIStroke") then
            descendant.Transparency = 0;
        end;
    end;

    if p7:IsA("TextLabel") or p7:IsA("TextButton") then
        p7.TextTransparency = 0;

        return;
    end;

    if p7:IsA("ImageLabel") or p7:IsA("ImageButton") then
        p7.ImageTransparency = 0;
    end;
end;

local function clearChoices(p8, p9, p10) -- Line: 69
    for _, child in p8:GetChildren() do
        if child ~= p9 and (child:IsA("GuiObject") and child:GetAttribute("DynamicChoice")) then
            child:Destroy();
        end;
    end;
end;

local function makeChoiceButton(p11, p12, p13, u14) -- Line: 77
    -- upvalues: normalizeAlphaOnClone (copy), ThemeController (copy), u1 (copy), SoundController (copy)
    local u15 = p11:Clone();
    u15.Name = "choice_" .. p13;
    u15.Visible = true;
    u15.AutoButtonColor = false;
    u15.Text = p12;
    u15:SetAttribute("DynamicChoice", true);
    normalizeAlphaOnClone(u15);
    u15.MouseEnter:Connect(function() -- Line: 86
        -- upvalues: u15 (copy), ThemeController (ref), u1 (ref)
        u15.BackgroundColor3 = ThemeController.GetColor(u1);
    end);
    u15.MouseLeave:Connect(function() -- Line: 89
        -- upvalues: u15 (copy), ThemeController (ref)
        u15.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39));
    end);
    u15.MouseButton1Click:Connect(function() -- Line: 92
        -- upvalues: SoundController (ref), u14 (copy)
        SoundController.PlaySound("CLICK");

        if u14 then
            u14();
        end;
    end);

    return u15;
end;

local function makeDivider(p16, p17) -- Line: 102
    -- upvalues: normalizeAlphaOnClone (copy)
    local v18 = p16:Clone();
    v18.Visible = true;
    v18.Name = "divider";
    v18:SetAttribute("DynamicChoice", true);

    if p17 ~= nil and v18:IsA("GuiObject") then
        v18.LayoutOrder = p17;
    end;

    normalizeAlphaOnClone(v18);

    return v18;
end;

task.spawn(function() -- Line: 178
    -- upvalues: reference (copy), u2 (copy), StarterGui (copy), GuiService (copy)
    local v19 = nil;

    for _ = 1, 1 do
        local AbsoluteSize = reference.AbsoluteSize;

        if AbsoluteSize ~= v19 then
            task.spawn(function() -- Line: 116, Name: resize
                -- upvalues: u2 (ref), StarterGui (ref), GuiService (ref)
                for i = 1, #u2 do
                    local v20 = u2[i];

                    if v20:IsDescendantOf(StarterGui) ~= true then
                        local Boundary = v20:FindFirstChild("Boundary");
                        local Parent = v20.Parent;
                        v20.AutomaticSize = Enum.AutomaticSize.Y;
                        v20.AutomaticCanvasSize = Enum.AutomaticSize.None;
                        v20.Size = UDim2.new(1, 1, 0, 0.3);
                        local AbsoluteSize2 = Parent.AbsoluteSize;
                        local _ = AbsoluteSize2.X;
                        local Y = AbsoluteSize2.Y;
                        local v21 = UDim2.new(1, 0, 0, Y / 2.5);
                        local v22 = UDim2.new(1, 0, 0, Y / 5);
                        local v23 = UDim2.new(1, 0, 0, Y / 1.05);
                        local v24 = nil;

                        for _, child in v20:GetChildren() do
                            if child:IsA("GuiButton") then
                                child.Size = v23;
                            elseif child.Name == "topBuffer" then
                                child.Size = v21;
                            elseif child.Name == "bottomBuffer" then
                                child.Size = v22;

                                if Boundary and (v24 == nil or child.AbsolutePosition.Y < v24) then
                                    v24 = child.AbsolutePosition.Y;
                                end;
                            end;
                        end;

                        if Boundary then
                            local Value = Boundary.Value;

                            if Value == nil then
                                return warn("Boundary is nil");
                            end;

                            local _ = GuiService:GetGuiInset().Y;
                            local v25 = Value.AbsolutePosition.Y + Value.AbsoluteSize.Y - 8;
                            local Y2 = v20.AbsolutePosition.Y;

                            if v25 < v24 then
                                local v26 = math.max(0, v25 - Y2);
                                v20.AutomaticSize = Enum.AutomaticSize.None;
                                v20.AutomaticCanvasSize = Enum.AutomaticSize.Y;
                                v20.Size = UDim2.new(1, 1, 0, v26);
                            end;
                        end;
                    end;
                end;
            end);
        end;

        task.wait(0.25);
        v19 = AbsoluteSize;
    end;
end);
reference:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 114, Name: resizeDropdowns
    -- upvalues: u2 (copy), StarterGui (copy), GuiService (copy)
    task.spawn(function() -- Line: 116, Name: resize
        -- upvalues: u2 (ref), StarterGui (ref), GuiService (ref)
        for i = 1, #u2 do
            local v27 = u2[i];

            if v27:IsDescendantOf(StarterGui) ~= true then
                local Boundary = v27:FindFirstChild("Boundary");
                local Parent = v27.Parent;
                v27.AutomaticSize = Enum.AutomaticSize.Y;
                v27.AutomaticCanvasSize = Enum.AutomaticSize.None;
                v27.Size = UDim2.new(1, 1, 0, 0.3);
                local AbsoluteSize = Parent.AbsoluteSize;
                local _ = AbsoluteSize.X;
                local Y = AbsoluteSize.Y;
                local v28 = UDim2.new(1, 0, 0, Y / 2.5);
                local v29 = UDim2.new(1, 0, 0, Y / 5);
                local v30 = UDim2.new(1, 0, 0, Y / 1.05);
                local v31 = nil;

                for _, child in v27:GetChildren() do
                    if child:IsA("GuiButton") then
                        child.Size = v30;
                    elseif child.Name == "topBuffer" then
                        child.Size = v28;
                    elseif child.Name == "bottomBuffer" then
                        child.Size = v29;

                        if Boundary and (v31 == nil or child.AbsolutePosition.Y < v31) then
                            v31 = child.AbsolutePosition.Y;
                        end;
                    end;
                end;

                if Boundary then
                    local Value = Boundary.Value;

                    if Value == nil then
                        return warn("Boundary is nil");
                    end;

                    local _ = GuiService:GetGuiInset().Y;
                    local v32 = Value.AbsolutePosition.Y + Value.AbsoluteSize.Y - 8;
                    local Y2 = v27.AbsolutePosition.Y;

                    if v32 < v31 then
                        local v33 = math.max(0, v32 - Y2);
                        v27.AutomaticSize = Enum.AutomaticSize.None;
                        v27.AutomaticCanvasSize = Enum.AutomaticSize.Y;
                        v27.Size = UDim2.new(1, 1, 0, v33);
                    end;
                end;
            end;
        end;
    end);
end);

function v5.UpdateDropdowns() -- Line: 197
    -- upvalues: u2 (copy), StarterGui (copy), GuiService (copy)
    task.spawn(function() -- Line: 116, Name: resize
        -- upvalues: u2 (ref), StarterGui (ref), GuiService (ref)
        for i = 1, #u2 do
            local v34 = u2[i];

            if v34:IsDescendantOf(StarterGui) ~= true then
                local Boundary = v34:FindFirstChild("Boundary");
                local Parent = v34.Parent;
                v34.AutomaticSize = Enum.AutomaticSize.Y;
                v34.AutomaticCanvasSize = Enum.AutomaticSize.None;
                v34.Size = UDim2.new(1, 1, 0, 0.3);
                local AbsoluteSize = Parent.AbsoluteSize;
                local _ = AbsoluteSize.X;
                local Y = AbsoluteSize.Y;
                local v35 = UDim2.new(1, 0, 0, Y / 2.5);
                local v36 = UDim2.new(1, 0, 0, Y / 5);
                local v37 = UDim2.new(1, 0, 0, Y / 1.05);
                local v38 = nil;

                for _, child in v34:GetChildren() do
                    if child:IsA("GuiButton") then
                        child.Size = v37;
                    elseif child.Name == "topBuffer" then
                        child.Size = v35;
                    elseif child.Name == "bottomBuffer" then
                        child.Size = v36;

                        if Boundary and (v38 == nil or child.AbsolutePosition.Y < v38) then
                            v38 = child.AbsolutePosition.Y;
                        end;
                    end;
                end;

                if Boundary then
                    local Value = Boundary.Value;

                    if Value == nil then
                        return warn("Boundary is nil");
                    end;

                    local _ = GuiService:GetGuiInset().Y;
                    local v39 = Value.AbsolutePosition.Y + Value.AbsoluteSize.Y - 8;
                    local Y2 = v34.AbsolutePosition.Y;

                    if v39 < v38 then
                        local v40 = math.max(0, v39 - Y2);
                        v34.AutomaticSize = Enum.AutomaticSize.None;
                        v34.AutomaticCanvasSize = Enum.AutomaticSize.Y;
                        v34.Size = UDim2.new(1, 1, 0, v40);
                    end;
                end;
            end;
        end;
    end);
end;

function u6._setLabel(p41, p42) -- Line: 201
    if p41.label and p41.label:IsA("TextLabel") then
        p41.label.Text = p42 or "";
    end;
end;

function u6._buildChoices(u43) -- Line: 207
    -- upvalues: clearChoices (copy), makeChoiceButton (copy), normalizeAlphaOnClone (copy)
    if not (u43.dropFrame and u43.choiceTemplate) then
        return;
    end;

    clearChoices(u43.dropFrame, u43.choiceTemplate, u43.dividerTemplate);
    local getChoices = u43.getChoices;

    if typeof(getChoices) == "function" then
        getChoices = getChoices();
    end;

    for _, v in getChoices or {} do
        local u44 = tostring(v.key or "");
        local u45 = tostring(v.text or u44);
        local v46 = makeChoiceButton(u43.choiceTemplate, u45, u44, function() -- Line: 223
            -- upvalues: u43 (copy), u44 (copy), u45 (copy)
            local currentChoice = u43.currentChoice;
            u43.currentChoice = u44;

            if typeof(u43.onSelect) == "function" and u43.onSelect(u44, u45) == false then
                u43.currentChoice = currentChoice;

                return;
            end;

            if u43.reflectSelectionOnLabel then
                u43:_setLabel(u45);
            end;

            u43:SetVisible(false, "choose");
        end);

        if typeof(v.layoutOrder) == "number" and v46:IsA("GuiObject") then
            v46.LayoutOrder = v.layoutOrder;
        end;

        v46.Parent = u43.dropFrame;

        if v.addDividerAfter == true and u43.dividerTemplate then
            local dividerTemplate = u43.dividerTemplate;
            local v47;

            if typeof(v.layoutOrder) == "number" then
                v47 = v.layoutOrder + 1 or nil;
            else
                v47 = nil;
            end;

            local v48 = dividerTemplate:Clone();
            v48.Visible = true;
            v48.Name = "divider";
            v48:SetAttribute("DynamicChoice", true);

            if v47 ~= nil and v48:IsA("GuiObject") then
                v48.LayoutOrder = v47;
            end;

            normalizeAlphaOnClone(v48);
            v48.Parent = u43.dropFrame;
        end;
    end;
end;

function u6.SetVisible(u49, p50, p51) -- Line: 264
    -- upvalues: OutsideClickDetector (copy), u2 (copy), StarterGui (copy), GuiService (copy)
    if not u49.dropFrame then
        return;
    end;

    if u49.dropFrame.Visible == p50 then
        if u49._onVisible then
            u49._onVisible(p50, p51);
        end;

        return;
    end;

    u49.dropFrame.Visible = p50;

    if p50 then
        if u49._outsideConn then
            u49._outsideConn:Disconnect();
            u49._outsideConn = nil;
        end;

        u49._outsideConn = OutsideClickDetector({ u49.dropFrame }, function() -- Line: 281
            -- upvalues: u49 (copy)
            u49:SetVisible(false, "outside");
        end, {
            include = { u49.toggleButton }
        });
    elseif u49._outsideConn then
        u49._outsideConn:Disconnect();
        u49._outsideConn = nil;
    end;

    task.spawn(function() -- Line: 116, Name: resize
        -- upvalues: u2 (ref), StarterGui (ref), GuiService (ref)
        for i = 1, #u2 do
            local v52 = u2[i];

            if v52:IsDescendantOf(StarterGui) ~= true then
                local Boundary = v52:FindFirstChild("Boundary");
                local Parent = v52.Parent;
                v52.AutomaticSize = Enum.AutomaticSize.Y;
                v52.AutomaticCanvasSize = Enum.AutomaticSize.None;
                v52.Size = UDim2.new(1, 1, 0, 0.3);
                local AbsoluteSize = Parent.AbsoluteSize;
                local _ = AbsoluteSize.X;
                local Y = AbsoluteSize.Y;
                local v53 = UDim2.new(1, 0, 0, Y / 2.5);
                local v54 = UDim2.new(1, 0, 0, Y / 5);
                local v55 = UDim2.new(1, 0, 0, Y / 1.05);
                local v56 = nil;

                for _, child in v52:GetChildren() do
                    if child:IsA("GuiButton") then
                        child.Size = v55;
                    elseif child.Name == "topBuffer" then
                        child.Size = v53;
                    elseif child.Name == "bottomBuffer" then
                        child.Size = v54;

                        if Boundary and (v56 == nil or child.AbsolutePosition.Y < v56) then
                            v56 = child.AbsolutePosition.Y;
                        end;
                    end;
                end;

                if Boundary then
                    local Value = Boundary.Value;

                    if Value == nil then
                        return warn("Boundary is nil");
                    end;

                    local _ = GuiService:GetGuiInset().Y;
                    local v57 = Value.AbsolutePosition.Y + Value.AbsoluteSize.Y - 8;
                    local Y2 = v52.AbsolutePosition.Y;

                    if v57 < v56 then
                        local v58 = math.max(0, v57 - Y2);
                        v52.AutomaticSize = Enum.AutomaticSize.None;
                        v52.AutomaticCanvasSize = Enum.AutomaticSize.Y;
                        v52.Size = UDim2.new(1, 1, 0, v58);
                    end;
                end;
            end;
        end;
    end);

    if u49._onVisible then
        u49._onVisible(p50, p51);
    end;
end;

function u6.SetVisibleCallback(p59, p60) -- Line: 301
    p59._onVisible = p60;
end;

function u6.RebuildChoices(p61) -- Line: 305
    p61:_buildChoices();
end;

function u6.SetCurrentChoice(p62, p63, p64, p65) -- Line: 309
    p62.currentChoice = p63;

    if p64 == nil then
        local getChoices = p62.getChoices;

        if typeof(getChoices) == "function" then
            getChoices = getChoices();
        end;

        if getChoices then
            for _, v in getChoices do
                if tostring(v.key) == p63 then
                    p64 = v.text or tostring(v.key);
                    break;
                end;
            end;
        end;
    end;

    if not p65 and typeof(p62.onSelect) == "function" then
        p62.onSelect(p63, p64);
    end;

    if p62.reflectSelectionOnLabel then
        p62:_setLabel(p64 or p63);
    end;
end;

function u6.Close(p66, p67) -- Line: 336
    p66:SetVisible(false, p67 or "Close()");
end;

function u6.Destroy(p68) -- Line: 340
    -- upvalues: clearChoices (copy)
    p68:Close("Destroy()");

    if p68._toggleConn then
        p68._toggleConn:Disconnect();
        p68._toggleConn = nil;
    end;

    clearChoices(p68.dropFrame, p68.choiceTemplate, p68.dividerTemplate);
end;

local function connectToggle(u69) -- Line: 349
    -- upvalues: CollectionService (copy)
    if not u69.toggleButton then
        return;
    end;

    CollectionService:AddTag(u69.toggleButton, "UIEffectSoundOnly");
    u69._toggleConn = u69.toggleButton.MouseButton1Click:Connect(function() -- Line: 352
        -- upvalues: u69 (copy)
        if u69.toggleButton.Parent:GetAttribute("Visible") ~= nil and u69.toggleButton.Parent:GetAttribute("Visible") ~= true then
            return;
        end;

        u69:SetVisible(not u69.dropFrame.Visible, "toggle");
    end);
end;

function v5.new(p70) -- Line: 361
    -- upvalues: u6 (copy), CollectionService (copy)
    assert(p70 and p70.dropFrame and p70.choiceTemplate, "DropdownController.new: dropFrame and choiceTemplate are required");
    local u71 = setmetatable({}, u6);
    u71.toggleButton = p70.toggleButton;
    u71.label = p70.label;
    u71.dropFrame = p70.dropFrame;
    u71.choiceTemplate = p70.choiceTemplate;
    u71.getChoices = p70.getChoices;
    u71.onSelect = p70.onSelect;
    u71.reflectSelectionOnLabel = p70.reflectSelectionOnLabel == true;
    u71.dividerTemplate = p70.dividerTemplate;
    u71.currentChoice = nil;
    u71._onVisible = nil;
    u71._outsideConn = nil;
    u71.dropFrame.Visible = false;
    u71.choiceTemplate.Visible = false;

    if u71.dividerTemplate and u71.dividerTemplate:IsA("GuiObject") then
        u71.dividerTemplate.Visible = false;
    end;

    u71:RebuildChoices();

    if not u71.toggleButton then
        return u71;
    end;

    CollectionService:AddTag(u71.toggleButton, "UIEffectSoundOnly");
    u71._toggleConn = u71.toggleButton.MouseButton1Click:Connect(function() -- Line: 352
        -- upvalues: u71 (copy)
        if u71.toggleButton.Parent:GetAttribute("Visible") ~= nil and u71.toggleButton.Parent:GetAttribute("Visible") ~= true then
            return;
        end;

        u71:SetVisible(not u71.dropFrame.Visible, "toggle");
    end);

    return u71;
end;

return v5;