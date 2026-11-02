-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui;
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "BackpackGui";
ScreenGui.ResetOnSpawn = false;
ScreenGui.Parent = PlayerGui;
local u1 = {
    OpenClose = nil,
    IsHotbarVisible = false,
    IsOpen = false,
    StateChanged = Instance.new("BindableEvent"),
    ModuleName = "Backpack",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true
};
local u2 = 60;
local Size14 = Enum.FontSize.Size14;
local u3 = 0.5 * GuiService.PreferredTransparency;
local u4 = Color3.new(0.12156862745098039, 0.12156862745098039, 0.12156862745098039);
local u5 = Color3.new(0.19215686274509805, 0.19215686274509805, 0.19215686274509805);
local u6 = Color3.new(0.35294117647058826, 0.5568627450980392, 0.9137254901960784);
local u7 = 0.5 * GuiService.PreferredTransparency;
local u8 = Color3.new(1, 1, 1);
UDim2.fromOffset(14, 9);
local _ = Enum.KeyCode.Backquote.Value;
local u9 = Color3.new(0, 0.6352941176470588, 1);
local u10 = "Search";
local v11 = Color3.new(0.37, 0.37, 0.37);
local u12 = 0.15 * GuiService.PreferredTransparency;
local Value = Enum.KeyCode.Zero.Value;
local Value2 = Enum.KeyCode.Backspace.Value;
local u13 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local StarterGui = game:GetService("StarterGui");
local ContextActionService = game:GetService("ContextActionService");
local VRService = game:GetService("VRService");
local GamepadService = game:GetService("GamepadService");
local u14 = GuiService:IsTenFootInterface();

local function Create(u15) -- Line: 110
    return function(p16) -- Line: 111
        -- upvalues: u15 (copy)
        local v17 = Instance.new(u15);
        local v18 = nil;

        for i, v in p16 do
            if type(i) == "number" then
                v.Parent = v17;
            elseif i == "Parent" then
                v18 = v;
            else
                v17[i] = v;
            end;
        end;

        if v18 then
            v17.Parent = v18;
        end;

        return v17;
    end;
end;

pcall(function() -- Line: 131
    -- upvalues: u10 (ref)
    local LocalizationService = game:GetService("LocalizationService");
    u10 = LocalizationService:GetCorescriptLocalizations()[1]:GetString(LocalizationService.RobloxLocaleId, "BACKPACK_SEARCH");
end);

if u14 then
    Size14 = Enum.FontSize.Size24;
    u2 = 100;
end;

local u19 = false;
local v20 = UserInputService.TouchEnabled and workspace.CurrentCamera.ViewportSize.X < 1024;
local LocalPlayer = Players.LocalPlayer;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = {};
local u32 = nil;
local u33 = {};
local u34 = {};
local u35 = {};
local u36 = 0;
local u37 = nil;
local u38 = false;
local u39 = false;
local u40 = false;
local v41 = {};
local u42 = {};
local u43 = false;
local u44 = 0;
local u45 = v20 and 3 or 10;
local u46 = v20 and 2 or 4;
local u47 = nil;
local u48 = "BindableEvent";
u1.BackpackEmpty = (function(p49) -- Line: 111
    -- upvalues: u48 (copy)
    local v50 = Instance.new(u48);
    local v51 = nil;

    for i, v in p49 do
        if type(i) == "number" then
            v.Parent = v50;
        elseif i == "Parent" then
            v51 = v;
        else
            v50[i] = v;
        end;
    end;

    if v51 then
        v50.Parent = v51;
    end;

    return v50;
end)({
    Name = "BackpackEmpty"
});
local u52 = "BindableEvent";
u1.BackpackItemAdded = (function(p53) -- Line: 111
    -- upvalues: u52 (copy)
    local v54 = Instance.new(u52);
    local v55 = nil;

    for i, v in p53 do
        if type(i) == "number" then
            v.Parent = v54;
        elseif i == "Parent" then
            v55 = v;
        else
            v54[i] = v;
        end;
    end;

    if v55 then
        v54.Parent = v55;
    end;

    return v54;
end)({
    Name = "BackpackAdded"
});
local u56 = "BindableEvent";
u1.BackpackItemRemoved = (function(p57) -- Line: 111
    -- upvalues: u56 (copy)
    local v58 = Instance.new(u56);
    local v59 = nil;

    for i, v in p57 do
        if type(i) == "number" then
            v.Parent = v58;
        elseif i == "Parent" then
            v59 = v;
        else
            v58[i] = v;
        end;
    end;

    if v59 then
        v58.Parent = v59;
    end;

    return v58;
end)({
    Name = "BackpackRemoved"
});

local function NewGui(p60, p61) -- Line: 200
    -- upvalues: Size14 (ref)
    local v62 = Instance.new(p60);
    v62.Name = p61;
    v62.BackgroundColor3 = Color3.new(0, 0, 0);
    v62.BackgroundTransparency = 1;
    v62.BorderColor3 = Color3.new(0, 0, 0);
    v62.BorderSizePixel = 0;
    v62.Size = UDim2.fromScale(1, 1);

    if p60:match("Text") then
        v62.TextColor3 = Color3.new(1, 1, 1);
        v62.Text = "";
        v62.Font = Enum.Font.SourceSans;
        v62.FontSize = Size14;
        v62.TextWrapped = true;

        if p60 == "TextButton" then
            v62.Font = Enum.Font.SourceSansBold;
            v62.BorderSizePixel = 1;
        end;
    end;

    return v62;
end;

local function FindLowestEmpty() -- Line: 222
    -- upvalues: u45 (ref), u31 (copy)
    for i = 1, u45 do
        local v63 = u31[i];

        if not v63.Tool then
            return v63;
        end;
    end;

    return nil;
end;

function u1.IsInventoryEmpty() -- Line: 232
    -- upvalues: u45 (ref), u31 (copy)
    for i = u45 + 1, #u31 do
        local v64 = u31[i];

        if v64 and v64.Tool then
            return false;
        end;
    end;

    return true;
end;

local function UseGazeSelection() -- Line: 244
    return false;
end;

local function AdjustHotbarFrames() -- Line: 248
    -- upvalues: u24 (ref), u45 (ref), u36 (ref), u31 (copy), u23 (ref), u1 (copy)
    local Visible = u24.Visible;
    local v65 = Visible and u45 or u36;
    local v66 = v65 >= 1;
    local v67 = 0;

    for i = 1, u45 do
        local v68 = u31[i];

        if v68.Tool or Visible then
            v67 = v67 + 1;
            v68:Readjust(v67, v65);
            v68.Frame.Visible = true;
        else
            v68.Frame.Visible = false;
        end;
    end;

    local v69 = not Visible;

    if v69 then
        if v66 then
            v69 = v66;
        else
            local v70 = true;

            for i = u45 + 1, #u31 do
                local v71 = u31[i];

                if v71 and v71.Tool then
                    v70 = false;
                    break;
                end;
            end;

            v69 = not v70;
        end;
    end;

    u23.Visible = v69;
    u23.Position = UDim2.new(0.5, -15, 0.88, v66 and -110 or -50);
    u1.IsHotbarVisible = v66;
end;

local function UpdateScrollingFrameCanvasSize() -- Line: 270
    -- upvalues: u26 (ref), u2 (ref), u27 (ref)
    local v72 = math.floor(u26.AbsoluteSize.X / (u2 + 5));
    local v73 = (#u27:GetChildren() - 1) / v72;
    local v74 = math.ceil(v73) * (u2 + 5) + 5;
    u26.CanvasSize = UDim2.fromOffset(0, v74);
end;

local function AdjustInventoryFrames() -- Line: 277
    -- upvalues: u45 (ref), u31 (copy), u26 (ref), u2 (ref), u27 (ref)
    for i = u45 + 1, #u31 do
        local v75 = u31[i];
        v75.Frame.LayoutOrder = v75.Index;
        v75.Frame.Visible = v75.Tool ~= nil;
    end;

    local v76 = math.floor(u26.AbsoluteSize.X / (u2 + 5));
    local v77 = (#u27:GetChildren() - 1) / v76;
    local v78 = math.ceil(v77) * (u2 + 5) + 5;
    u26.CanvasSize = UDim2.fromOffset(0, v78);
end;

local function UpdateBackpackLayout() -- Line: 286
    -- upvalues: u22 (ref), u45 (ref), u2 (ref), u24 (ref), u46 (copy), u26 (ref), AdjustHotbarFrames (copy), AdjustInventoryFrames (copy)
    u22.Size = UDim2.new(0, 5 + u45 * (u2 + 5), 0, u2 + 5 + 5);
    u22.Position = UDim2.new(0.5, -u22.Size.X.Offset / 2, 0.88, -u22.Size.Y.Offset);
    u24.Size = UDim2.new(0, u22.Size.X.Offset, 0, u22.Size.Y.Offset * u46 + 40);
    u24.Position = UDim2.new(0.5, -u24.Size.X.Offset / 2, 0.88, u22.Position.Y.Offset - u24.Size.Y.Offset);
    u26.Size = UDim2.new(1, u26.ScrollBarThickness + 1, 1, -40);
    u26.Position = UDim2.fromOffset(0, 40);
    AdjustHotbarFrames();
    AdjustInventoryFrames();
end;

local function Clamp(p79, p80, p81) -- Line: 313
    local v82 = math.max(p79, p81);

    return math.min(p80, v82);
end;

local function CheckBounds(p83, p84, p85) -- Line: 317
    local AbsolutePosition = p83.AbsolutePosition;
    local AbsoluteSize = p83.AbsoluteSize;
    local v86;

    if AbsolutePosition.X < p84 and (p84 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p85) then
        v86 = p85 <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v86 = false;
    end;

    return v86;
end;

local function GetOffset(p87, p88) -- Line: 323
    return (p87.AbsolutePosition + p87.AbsoluteSize / 2 - p88).magnitude;
end;

local function DisableActiveHopper() -- Line: 328
    -- upvalues: u37 (ref), u33 (copy)
    u37:ToggleSelect();
    u33[u37]:UpdateEquipView();
    u37 = nil;
end;

local function UnequipAllTools() -- Line: 334
    -- upvalues: u29 (ref), u37 (ref), u33 (copy)
    if u29 then
        u29:UnequipTools();

        if u37 then
            u37:ToggleSelect();
            u33[u37]:UpdateEquipView();
            u37 = nil;
        end;
    end;
end;

local function EquipNewTool(p89) -- Line: 343
    -- upvalues: u29 (ref), u37 (ref), u33 (copy), u28 (ref)
    if u29 then
        u29:UnequipTools();

        if u37 then
            u37:ToggleSelect();
            u33[u37]:UpdateEquipView();
            u37 = nil;
        end;
    end;

    if not p89:IsA("HopperBin") then
        p89.Parent = u28;

        return;
    end;

    p89:ToggleSelect();
    u33[p89]:UpdateEquipView();
    u37 = p89;
end;

local function IsEquipped(p90) -- Line: 355
    -- upvalues: u28 (ref)
    if p90 then
        p90 = p90:IsA("HopperBin") and p90.Active or p90.Parent == u28;
    end;

    return p90;
end;

local function MakeSlot(p91, p92) -- Line: 359
    -- upvalues: u31 (copy), u7 (ref), u5 (copy), u4 (copy), u22 (ref), u2 (ref), u45 (ref), u24 (ref), u36 (ref), u19 (ref), ContextActionService (copy), u33 (copy), u32 (ref), u28 (ref), u47 (ref), NewGui (copy), u6 (copy), u35 (copy), u26 (ref), u27 (ref), u29 (ref), u37 (ref), u30 (ref), u8 (copy), MakeSlot (copy), u40 (ref), u34 (copy), Value (copy)
    local v93 = p92 or #u31 + 1;
    local u94 = {
        Tool = nil,
        Index = v93,
        Frame = nil
    };
    local u95 = nil;
    local u96 = nil;
    local u97 = nil;
    local u98 = nil;
    local u99 = nil;
    local u100 = nil;
    local u101 = nil;
    local u102 = nil;

    local function UpdateSlotFading() -- Line: 384
        -- upvalues: u95 (ref), u7 (ref), u5 (ref), u4 (ref)
        u95.SelectionImageObject = nil;
        u95.BackgroundTransparency = u95.Draggable and 0 or u7;
        u95.BackgroundColor3 = u95.Draggable and u5 or u4;
    end;

    function u94.Readjust(p103, p104, p105) -- Line: 390
        -- upvalues: u22 (ref), u2 (ref), u95 (ref)
        u95.Position = UDim2.fromOffset(u22.Size.X.Offset / 2 - u2 / 2 + (u2 + 5) * (p104 - (p105 / 2 + 0.5)), 5);
    end;

    function u94.Fill(p106, u107) -- Line: 398
        -- upvalues: u97 (ref), u98 (ref), u101 (ref), u99 (ref), u45 (ref), u24 (ref), u95 (ref), u36 (ref), u19 (ref), ContextActionService (ref), u33 (ref), u32 (ref), u31 (ref)
        if not u107 then
            return p106:Clear();
        end;

        p106.Tool = u107;

        local function assignToolData() -- Line: 405
            -- upvalues: u107 (copy), u97 (ref), u98 (ref), u101 (ref)
            local TextureId = u107.TextureId;
            u97.Image = TextureId;

            if TextureId == "" then
                u98.Visible = true;
            else
                u98.Visible = false;
            end;

            u98.Text = u107.Name;

            if u101 and u107:IsA("Tool") then
                u101.Text = u107.ToolTip;
                local v108 = u101.TextBounds.X + 6;
                u101.Size = UDim2.fromOffset(v108, 16);
                u101.Position = UDim2.new(0.5, -v108 / 2, 0, -25);
            end;
        end;

        assignToolData();

        if u99 then
            u99:disconnect();
            u99 = nil;
        end;

        u99 = u107.Changed:connect(function(p109) -- Line: 431
            -- upvalues: assignToolData (copy)
            if p109 == "TextureId" or (p109 == "Name" or p109 == "ToolTip") then
                assignToolData();
            end;
        end);
        local v110 = p106.Index <= u45;

        if not v110 or u24.Visible then
            u95.Draggable = true;
        end;

        p106:UpdateEquipView();

        if v110 then
            u36 = u36 + 1;

            if u36 >= 1 and not u19 then
                u19 = true;
                ContextActionService:BindAction("BackpackHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            end;
        end;

        u33[u107] = p106;
        local v111;

        for i = 1, u45 do
            v111 = u31[i];

            if not v111.Tool then
                break;
            end;
        end;

        u32 = v111;
    end;

    function u94.Clear(p112) -- Line: 470
        -- upvalues: u99 (ref), u97 (ref), u98 (ref), u101 (ref), u95 (ref), u45 (ref), u36 (ref), u19 (ref), ContextActionService (ref), u33 (ref), u32 (ref), u31 (ref)
        if not p112.Tool then
            return;
        end;

        if u99 then
            u99:disconnect();
            u99 = nil;
        end;

        u97.Image = "";
        u98.Text = "";

        if u101 then
            u101.Text = "";
            u101.Visible = false;
        end;

        u95.Draggable = false;
        p112:UpdateEquipView(true);

        if p112.Index <= u45 then
            u36 = u36 - 1;

            if u36 < 1 then
                u19 = false;
                ContextActionService:UnbindAction("BackpackHotbarEquip");
            end;
        end;

        u33[p112.Tool] = nil;
        p112.Tool = nil;
        local v113;

        for i = 1, u45 do
            v113 = u31[i];

            if not v113.Tool then
                break;
            end;
        end;

        u32 = v113;
    end;

    function u94.UpdateEquipView(p114, p115) -- Line: 503
        -- upvalues: u28 (ref), u47 (ref), u94 (copy), u100 (ref), NewGui (ref), u95 (ref), u6 (ref), u7 (ref), u5 (ref), u4 (ref)
        if p115 then
            if u100 then
                u100.Parent = nil;
            end;
        else
            local Tool = p114.Tool;

            if Tool then
                Tool = Tool:IsA("HopperBin") and Tool.Active or Tool.Parent == u28;
            end;

            if Tool then
                u47 = u94;

                if not u100 then
                    u100 = NewGui("Frame", "Equipped");
                    u100.ZIndex = u95.ZIndex;

                    for _, v in { { 0.1, 1, 0, 0 }, { 0.8, 0.1, 0.1, 0 }, { 0.1, 1, 0.9, 0 }, { 0.8, 0.1, 0.1, 0.9 } } do
                        local v116 = NewGui("Frame", "Edge");
                        v116.BackgroundTransparency = 0;
                        v116.BackgroundColor3 = u6;
                        v116.Size = UDim2.fromScale(v[1], v[2]);
                        v116.Position = UDim2.fromScale(v[3], v[4]);
                        v116.ZIndex = u100.ZIndex;
                        v116.Parent = u100;
                    end;
                end;

                u100.Parent = u95;
            elseif u100 then
                u100.Parent = nil;
            end;
        end;

        u95.SelectionImageObject = nil;
        u95.BackgroundTransparency = u95.Draggable and 0 or u7;
        u95.BackgroundColor3 = u95.Draggable and u5 or u4;
    end;

    function u94.IsEquipped(p117) -- Line: 535
        -- upvalues: u28 (ref)
        local Tool = p117.Tool;

        if Tool then
            Tool = Tool:IsA("HopperBin") and Tool.Active or Tool.Parent == u28;
        end;

        return Tool;
    end;

    function u94.Delete(p118) -- Line: 539
        -- upvalues: u35 (ref), u95 (ref), u31 (ref), u26 (ref), u2 (ref), u27 (ref)
        u35[u95] = nil;
        u95:Destroy();
        table.remove(u31, p118.Index);

        for i = p118.Index, #u31 do
            u31[i]:SlideBack();
        end;

        local v119 = math.floor(u26.AbsoluteSize.X / (u2 + 5));
        local v120 = (#u27:GetChildren() - 1) / v119;
        local v121 = math.ceil(v120) * (u2 + 5) + 5;
        u26.CanvasSize = UDim2.fromOffset(0, v121);
    end;

    function u94.Swap(p122, p123) -- Line: 553
        local Tool = p122.Tool;
        local Tool2 = p123.Tool;
        p122:Clear();

        if Tool2 then
            p123:Clear();
            p122:Fill(Tool2);
        end;

        if Tool then
            p123:Fill(Tool);

            return;
        end;

        p123:Clear();
    end;

    function u94.SlideBack(p124) -- Line: 567
        -- upvalues: u95 (ref)
        p124.Index = p124.Index - 1;
        u95.Name = p124.Index;
        u95.LayoutOrder = p124.Index;
    end;

    function u94.TurnNumber(p125, p126) -- Line: 573
        -- upvalues: u102 (ref)
        if u102 then
            u102.Visible = p126;
        end;
    end;

    function u94.SetClickability(p127, p128) -- Line: 579
        -- upvalues: u95 (ref), u7 (ref), u5 (ref), u4 (ref)
        if p127.Tool then
            u95.Draggable = not p128;
            u95.SelectionImageObject = nil;
            u95.BackgroundTransparency = u95.Draggable and 0 or u7;
            u95.BackgroundColor3 = u95.Draggable and u5 or u4;
        end;
    end;

    function u94.CheckTerms(p129, p130) -- Line: 586
        -- upvalues: u98 (ref), u101 (ref)
        local u131 = 0;

        local function checkEm(p132, p133) -- Line: 588
            -- upvalues: u131 (ref)
            local _, v134 = p132:lower():gsub(p133, "");
            u131 = u131 + v134;
        end;

        local Tool = p129.Tool;

        if Tool then
            for i in p130 do
                local _, v135 = u98.Text:lower():gsub(i, "");
                u131 = u131 + v135;

                if Tool:IsA("Tool") then
                    local _, v136 = (u101 and u101.Text or ""):lower():gsub(i, "");
                    u131 = u131 + v136;
                end;
            end;
        end;

        return u131;
    end;

    function u94.Select(p137, p138) -- Line: 606
        -- upvalues: u94 (copy), u28 (ref), u29 (ref), u37 (ref), u33 (ref), u30 (ref)
        if p138 then
            return;
        end;

        local Tool = u94.Tool;

        if Tool then
            local v139;

            if Tool then
                v139 = Tool:IsA("HopperBin") and Tool.Active or Tool.Parent == u28;
            else
                v139 = Tool;
            end;

            if v139 then
                if u29 then
                    u29:UnequipTools();

                    if u37 then
                        u37:ToggleSelect();
                        u33[u37]:UpdateEquipView();
                        u37 = nil;
                    end;
                end;
            elseif Tool.Parent == u30 then
                if u29 then
                    u29:UnequipTools();

                    if u37 then
                        u37:ToggleSelect();
                        u33[u37]:UpdateEquipView();
                        u37 = nil;
                    end;
                end;

                if Tool:IsA("HopperBin") then
                    Tool:ToggleSelect();
                    u33[Tool]:UpdateEquipView();
                    u37 = Tool;

                    return;
                end;

                Tool.Parent = u28;
            end;
        end;
    end;

    u95 = NewGui("TextButton", v93);
    u95.BackgroundColor3 = u4;
    u95.BorderColor3 = u8;
    u95.Text = "";
    u95.AutoButtonColor = false;
    u95.BorderSizePixel = 0;
    u95.Size = UDim2.fromOffset(u2, u2);
    u95.Active = true;
    u95.Draggable = false;
    u95.BackgroundTransparency = u7;
    u95.MouseButton1Click:connect(function() -- Line: 633
        -- upvalues: u94 (copy)
        changeSlot(u94);
    end);
    u94.Frame = u95;
    local v140 = NewGui("Frame", "SelectionObjectClipper");
    v140.Visible = false;
    v140.Parent = u95;
    local v141 = NewGui("ImageLabel", "Selector");
    v141.Size = UDim2.fromScale(1, 1);
    v141.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
    v141.ScaleType = Enum.ScaleType.Slice;
    v141.SliceCenter = Rect.new(12, 12, 52, 52);
    v141.Parent = v140;
    u97 = NewGui("ImageLabel", "Icon");
    u97.Size = UDim2.fromScale(0.8, 0.8);
    u97.Position = UDim2.fromScale(0.1, 0.1);
    u97.Parent = u95;
    u98 = NewGui("TextLabel", "ToolName");
    u98.Size = UDim2.new(1, -2, 1, -2);
    u98.Position = UDim2.fromOffset(1, 1);
    u98.Parent = u95;
    u94.Frame.LayoutOrder = u94.Index;

    if v93 <= u45 then
        u101 = NewGui("TextLabel", "ToolTip");
        u101.TextWrapped = false;
        u101.TextYAlignment = Enum.TextYAlignment.Top;
        u101.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4);
        u101.BackgroundTransparency = 0;
        u101.Visible = false;
        u101.Parent = u95;
        u95.MouseEnter:connect(function() -- Line: 672
            -- upvalues: u101 (ref)
            if u101.Text ~= "" then
                u101.Visible = true;
            end;
        end);
        u95.MouseLeave:connect(function() -- Line: 677
            -- upvalues: u101 (ref)
            u101.Visible = false;
        end);

        function u94.MoveToInventory(p142) -- Line: 681
            -- upvalues: u94 (copy), u45 (ref), MakeSlot (ref), u27 (ref), u28 (ref), u29 (ref), u37 (ref), u33 (ref), u40 (ref), u24 (ref)
            if u94.Index <= u45 then
                local Tool = u94.Tool;
                p142:Clear();
                local v143 = MakeSlot(u27);
                v143:Fill(Tool);

                if Tool then
                    Tool = Tool:IsA("HopperBin") and Tool.Active or Tool.Parent == u28;
                end;

                if Tool and u29 then
                    u29:UnequipTools();

                    if u37 then
                        u37:ToggleSelect();
                        u33[u37]:UpdateEquipView();
                        u37 = nil;
                    end;
                end;

                if u40 then
                    v143.Frame.Visible = false;
                    v143.Parent = u24;
                end;
            end;
        end;

        if v93 < 10 or v93 == u45 then
            local v144 = v93 < 10 and (v93 or 0) or 0;
            u102 = NewGui("TextLabel", "Number");
            u102.Text = v144;
            u102.Size = UDim2.fromScale(0.15, 0.15);
            u102.Visible = false;
            u102.Parent = u95;

            u34[Value + v144] = function(p145) -- Line: 707
                -- upvalues: u94 (copy)
                u94:Select(p145);
            end;
        end;
    end;

    local Position = u95.Position;
    local u146 = 0;
    local u147 = nil;
    u95.DragBegin:connect(function(p148) -- Line: 718
        -- upvalues: u35 (ref), u95 (ref), Position (ref), u97 (ref), u98 (ref), u102 (ref), u100 (ref), u147 (ref), u27 (ref), u24 (ref), u96 (ref), NewGui (ref)
        u35[u95] = true;
        Position = p148;
        u95.BorderSizePixel = 2;
        u95.ZIndex = 2;
        u97.ZIndex = 2;
        u98.ZIndex = 2;
        u95.Parent.ZIndex = 2;

        if u102 then
            u102.ZIndex = 2;
        end;

        if u100 then
            u100.ZIndex = 2;

            for _, child in u100:GetChildren() do
                child.ZIndex = 2;
            end;
        end;

        u147 = u95.Parent;

        if u147 == u27 then
            local _ = u95.AbsolutePosition;
            local v149 = UDim2.new(0, u95.AbsolutePosition.X - u24.AbsolutePosition.X, 0, u95.AbsolutePosition.Y - u24.AbsolutePosition.Y);
            u95.Parent = u24;
            u95.Position = v149;
            u96 = NewGui("Frame", "FakeSlot");
            u96.LayoutOrder = u95.LayoutOrder;
            u96.Size = u95.Size;
            u96.BackgroundTransparency = 1;
            u96.Parent = u27;
        end;
    end);
    u95.DragStopped:connect(function(p150, p151) -- Line: 760
        -- upvalues: u96 (ref), u95 (ref), Position (ref), u147 (ref), u97 (ref), u98 (ref), u102 (ref), u100 (ref), u35 (ref), u94 (copy), u24 (ref), u45 (ref), u146 (ref), u32 (ref), u22 (ref), u31 (ref), u28 (ref), u29 (ref), u37 (ref), u33 (ref), u40 (ref)
        if u96 then
            u96:Destroy();
        end;

        local v152 = tick();
        u95.Position = Position;
        u95.Parent = u147;
        u95.BorderSizePixel = 0;
        u95.ZIndex = 1;
        u97.ZIndex = 1;
        u98.ZIndex = 1;
        u147.ZIndex = 1;

        if u102 then
            u102.ZIndex = 1;
        end;

        if u100 then
            u100.ZIndex = 1;

            for _, child in u100:GetChildren() do
                child.ZIndex = 1;
            end;
        end;

        u35[u95] = nil;

        if not u94.Tool then
            return;
        end;

        local v153 = u24;
        local AbsolutePosition = v153.AbsolutePosition;
        local AbsoluteSize = v153.AbsoluteSize;
        local v154;

        if AbsolutePosition.X < p150 and (p150 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p151) then
            v154 = p151 <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v154 = false;
        end;

        if v154 then
            if u94.Index <= u45 then
                u94:MoveToInventory();
            end;

            if u45 < u94.Index and v152 - u146 < 0.5 then
                if u32 then
                    local Tool = u94.Tool;
                    u94:Clear();
                    u32:Fill(Tool);
                    u94:Delete();
                    v152 = 0;
                else
                    v152 = 0;
                end;
            end;
        else
            local v155 = u22;
            local AbsolutePosition2 = v155.AbsolutePosition;
            local AbsoluteSize2 = v155.AbsoluteSize;
            local v156;

            if AbsolutePosition2.X < p150 and (p150 <= AbsolutePosition2.X + AbsoluteSize2.X and AbsolutePosition2.Y < p151) then
                v156 = p151 <= AbsolutePosition2.Y + AbsoluteSize2.Y;
            else
                v156 = false;
            end;

            if v156 then
                local v157 = { (1 / 0), nil };

                for i = 1, u45 do
                    local v158 = u31[i];
                    local Frame = v158.Frame;
                    local v159 = Vector2.new(p150, p151);
                    local magnitude = (Frame.AbsolutePosition + Frame.AbsoluteSize / 2 - v159).magnitude;

                    if magnitude < v157[1] then
                        v157 = { magnitude, v158 };
                    end;
                end;

                local v160 = v157[2];

                if v160 ~= u94 then
                    u94:Swap(v160);

                    if u45 < u94.Index then
                        local Tool = u94.Tool;

                        if Tool then
                            if Tool then
                                Tool = Tool:IsA("HopperBin") and Tool.Active or Tool.Parent == u28;
                            end;

                            if Tool and u29 then
                                u29:UnequipTools();

                                if u37 then
                                    u37:ToggleSelect();
                                    u33[u37]:UpdateEquipView();
                                    u37 = nil;
                                end;
                            end;

                            if u40 then
                                u94.Frame.Visible = false;
                                u94.Frame.Parent = u24;
                            end;
                        else
                            u94:Delete();
                        end;
                    end;
                end;
            elseif u94.Index <= u45 then
                u94:MoveToInventory();
            end;
        end;

        u146 = v152;
    end);
    u95.Parent = p91;
    u31[v93] = u94;

    if u45 < v93 then
        local v161 = math.floor(u26.AbsoluteSize.X / (u2 + 5));
        local v162 = (#u27:GetChildren() - 1) / v161;
        local v163 = math.ceil(v162) * (u2 + 5) + 5;
        u26.CanvasSize = UDim2.fromOffset(0, v163);

        if u24.Visible and not u40 then
            u26.CanvasPosition = Vector2.new(0, (math.max(0, u26.CanvasSize.Y.Offset - u26.AbsoluteSize.Y)));
        end;
    end;

    return u94;
end;

local function SetNumberOfHotbarSlots(p164) -- Line: 869
    -- upvalues: u45 (ref), u31 (copy), MakeSlot (copy), u22 (ref), u32 (ref), u36 (ref), UpdateBackpackLayout (copy)
    if u45 ~= p164 then
        local v165 = u45;

        if p164 < v165 then
            for i = v165, p164 + 1, -1 do
                local v166 = u31[i];

                if v166 then
                    v166:MoveToInventory();
                    v166:Delete();
                end;
            end;

            for i = v165, p164 + 1, -1 do
                local v167 = u31[i];

                if not v167.Tool then
                    v167:Delete();
                end;
            end;
        else
            for i = v165, p164 do
                u45 = i;

                if u31[i] then
                    local _ = u31[i];
                    local Tool = u31[i].Tool;
                    local v168 = MakeSlot(u22, i);

                    if Tool then
                        v168:Fill(Tool);
                    elseif not u32 then
                        u32 = v168;
                    end;
                else
                    local v169 = MakeSlot(u22, i);
                    v169.Frame.Visible = false;

                    if not u32 then
                        u32 = v169;
                    end;
                end;
            end;
        end;

        u45 = p164;
        u36 = 0;

        for i = 1, u45 do
            if u31[i] and u31[i].Tool then
                u36 = u36 + 1;
            end;
        end;

        UpdateBackpackLayout();
    end;
end;

local function OnChildAdded(p170) -- Line: 931
    -- upvalues: u28 (ref), u29 (ref), u44 (ref), u37 (ref), u33 (copy), u38 (ref), LocalPlayer (ref), u32 (ref), MakeSlot (copy), u27 (ref), u31 (copy), u30 (ref), AdjustHotbarFrames (copy), u45 (ref), u24 (ref), u1 (copy)
    if not (p170:IsA("Tool") or p170:IsA("HopperBin")) then
        if p170:IsA("Humanoid") and p170.Parent == u28 then
            u29 = p170;
        end;

        return;
    end;

    if p170.Parent == u28 then
        u44 = tick();
    end;

    if u37 and p170.Parent == u28 then
        u37:ToggleSelect();
        u33[u37]:UpdateEquipView();
        u37 = nil;
    end;

    if not u38 and (p170.Parent == u28 and not u33[p170]) then
        local StarterGear = LocalPlayer:FindFirstChild("StarterGear");

        if StarterGear and StarterGear:FindFirstChild(p170.Name) then
            u38 = true;

            for i = (u32 or MakeSlot(u27)).Index, 1, -1 do
                local v171 = u31[i];
                local v172 = i - 1;

                if v172 > 0 then
                    u31[v172]:Swap(v171);
                else
                    v171:Fill(p170);
                end;
            end;

            for _, child in u28:GetChildren() do
                if child:IsA("Tool") and child ~= p170 then
                    child.Parent = u30;
                end;
            end;

            AdjustHotbarFrames();

            return;
        end;
    end;

    local v173 = u33[p170];

    if v173 then
        v173:UpdateEquipView();
    else
        local v174 = u32 or MakeSlot(u27);
        v174:Fill(p170);

        if v174.Index <= u45 and not u24.Visible then
            AdjustHotbarFrames();
        end;

        if p170:IsA("HopperBin") and p170.Active then
            if u29 then
                u29:UnequipTools();

                if u37 then
                    u37:ToggleSelect();
                    u33[u37]:UpdateEquipView();
                    u37 = nil;
                end;
            end;

            u37 = p170;
        end;
    end;

    u1.BackpackItemAdded:Fire();
end;

local function OnChildRemoved(p175) -- Line: 998
    -- upvalues: u44 (ref), u28 (ref), u30 (ref), u33 (copy), u45 (ref), u24 (ref), AdjustHotbarFrames (copy), u37 (ref), u1 (copy), u31 (copy)
    if not (p175:IsA("Tool") or p175:IsA("HopperBin")) then
        return;
    end;

    u44 = tick();
    local Parent = p175.Parent;

    if Parent == u28 or Parent == u30 then
        return;
    end;

    local v176 = u33[p175];

    if v176 then
        v176:Clear();

        if u45 < v176.Index then
            v176:Delete();
        elseif not u24.Visible then
            AdjustHotbarFrames();
        end;
    end;

    if p175 == u37 then
        u37 = nil;
    end;

    u1.BackpackItemRemoved:Fire();
    local v177 = true;

    for i = u45 + 1, #u31 do
        local v178 = u31[i];

        if v178 and v178.Tool then
            v177 = false;
            break;
        end;
    end;

    if v177 then
        u1.BackpackEmpty:Fire();
    end;
end;

local function OnCharacterAdded(p179) -- Line: 1032
    -- upvalues: u31 (copy), u45 (ref), u37 (ref), u42 (ref), u28 (ref), OnChildRemoved (copy), OnChildAdded (copy), u30 (ref), LocalPlayer (ref), AdjustHotbarFrames (copy)
    for i = #u31, 1, -1 do
        local v180 = u31[i];

        if v180.Tool then
            v180:Clear();
        end;

        if u45 < i then
            v180:Delete();
        end;
    end;

    u37 = nil;

    for _, v in u42 do
        v:disconnect();
    end;

    u42 = {};
    u28 = p179;
    table.insert(u42, p179.ChildRemoved:connect(OnChildRemoved));
    table.insert(u42, p179.ChildAdded:connect(OnChildAdded));

    for _, child in p179:GetChildren() do
        OnChildAdded(child);
    end;

    u30 = LocalPlayer:WaitForChild("Backpack");
    table.insert(u42, u30.ChildRemoved:connect(OnChildRemoved));
    table.insert(u42, u30.ChildAdded:connect(OnChildAdded));

    for _, child in u30:GetChildren() do
        OnChildAdded(child);
    end;

    AdjustHotbarFrames();
end;

local function OnInputBegan(p181, p182) -- Line: 1071
    -- upvalues: u39 (ref), u34 (copy), u24 (ref), u1 (copy)
    local v183 = p181.UserInputType == Enum.UserInputType.Keyboard and not u39 and u34[p181.KeyCode.Value];

    if v183 then
        v183(p182);
    end;

    local UserInputType = p181.UserInputType;

    if not p182 and (UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch) and u24.Visible then
        u1.OpenClose();
    end;
end;

local function OnUISChanged(p184) -- Line: 1094
    -- upvalues: UserInputService (copy), VRService (copy), u45 (ref), u31 (copy)
    if p184 == "KeyboardEnabled" or p184 == "VREnabled" then
        local v185 = UserInputService.KeyboardEnabled and not VRService.VREnabled;

        for i = 1, u45 do
            u31[i]:TurnNumber(v185);
        end;
    end;
end;

local u186 = nil;
local u187 = nil;

local function u188() -- Line: 1106
end;

local u189 = Vector2.new(0, 0);

function unbindAllGamepadEquipActions()
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("BackpackHasGamepadFocus");
    ContextActionService:UnbindAction("BackpackCloseInventory");
end;

local function setHotbarVisibility(p190, p191) -- Line: 1117
    -- upvalues: u45 (ref), u31 (copy)
    for i = 1, u45 do
        local v192 = u31[i];

        if v192 and (v192.Frame and (p191 or v192.Tool)) then
            v192.Frame.Visible = p190;
        end;
    end;
end;

local function getInputDirection(p193) -- Line: 1126
    -- upvalues: u189 (ref)
    local v194 = p193.UserInputState == Enum.UserInputState.End and -1 or 1;

    if p193.KeyCode == Enum.KeyCode.Thumbstick1 then
        local magnitude = p193.Position.magnitude;

        if magnitude > 0.98 then
            u189 = Vector2.new(p193.Position.x / magnitude, -p193.Position.y / magnitude);
        else
            u189 = Vector2.new(0, 0);
        end;
    elseif p193.KeyCode == Enum.KeyCode.DPadLeft then
        u189 = Vector2.new(u189.x - v194 * 1, u189.y);
    elseif p193.KeyCode == Enum.KeyCode.DPadRight then
        u189 = Vector2.new(u189.x + v194 * 1, u189.y);
    elseif p193.KeyCode == Enum.KeyCode.DPadUp then
        u189 = Vector2.new(u189.x, u189.y - v194 * 1);
    elseif p193.KeyCode == Enum.KeyCode.DPadDown then
        u189 = Vector2.new(u189.x, u189.y + v194 * 1);
    else
        u189 = Vector2.new(0, 0);
    end;

    return u189;
end;

local function _(p195, p196, p197) -- Line: 1157
    -- upvalues: getInputDirection (copy), u45 (ref), u31 (copy), u29 (ref), u37 (ref), u33 (copy)
    local v198 = getInputDirection(p197);

    if v198 == Vector2.new(0, 0) then
        return;
    end;

    local v199 = math.atan2(v198.y, v198.x) - -1.5707963267948966;

    if v199 < 0 then
        v199 = v199 + 6.283185307179586;
    end;

    local v200 = math.floor(v199 / 0.7853981633974483 + 1 + 0.5);
    local v201 = u45 < v200 and 1 or v200;

    if v201 > 0 then
        local v202 = u31[v201];

        if v202 and (v202.Tool and not v202:IsEquipped()) then
            v202:Select();
        end;
    elseif u29 then
        u29:UnequipTools();

        if u37 then
            u37:ToggleSelect();
            u33[u37]:UpdateEquipView();
            u37 = nil;
        end;
    end;
end;

function changeToolFunc(p203, p204, u205)
    -- upvalues: u186 (ref), u187 (ref), u29 (ref), u37 (ref), u33 (copy), u45 (ref), u31 (copy), u47 (ref)
    if p204 ~= Enum.UserInputState.Begin then
        return;
    end;

    if u186 and (u186.KeyCode == Enum.KeyCode.ButtonR1 and u205.KeyCode == Enum.KeyCode.ButtonL1 or u186.KeyCode == Enum.KeyCode.ButtonL1 and u205.KeyCode == Enum.KeyCode.ButtonR1) and tick() - u187 <= 0.06 then
        if u29 then
            u29:UnequipTools();

            if u37 then
                u37:ToggleSelect();
                u33[u37]:UpdateEquipView();
                u37 = nil;
            end;
        end;

        u186 = u205;
        u187 = tick();

        return;
    end;

    u186 = u205;
    u187 = tick();
    delay(0.06, function() -- Line: 1215
        -- upvalues: u186 (ref), u205 (copy), u45 (ref), u31 (ref), u29 (ref), u37 (ref), u33 (ref), u47 (ref)
        if u186 ~= u205 then
            return;
        end;

        local v206 = u205.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1;

        for i = 1, u45 do
            if u31[i]:IsEquipped() then
                local v207 = v206 + i;
                local v208 = false;

                if u45 < v207 then
                    v207 = 1;
                    v208 = true;
                elseif v207 < 1 then
                    v207 = u45;
                    v208 = true;
                end;

                local v209 = v207;

                while not u31[v207].Tool do
                    v207 = v207 + v206;

                    if v207 == v209 then
                        return;
                    end;

                    if u45 < v207 then
                        v207 = 1;
                        v208 = true;
                    elseif v207 < 1 then
                        v207 = u45;
                        v208 = true;
                    end;
                end;

                if not v208 then
                    u31[v207]:Select();

                    return;
                end;

                if u29 then
                    u29:UnequipTools();

                    if u37 then
                        u37:ToggleSelect();
                        u33[u37]:UpdateEquipView();
                        u37 = nil;
                    end;
                end;

                u47 = nil;

                return;
            end;
        end;

        if u47 and u47.Tool then
            u47:Select();

            return;
        end;

        for i = v206 == -1 and (u45 or 1) or 1, v206 == -1 and 1 or u45, v206 do
            if u31[i].Tool then
                u31[i]:Select();

                return;
            end;
        end;
    end);
end;

function getGamepadSwapSlot()
    -- upvalues: u31 (copy)
    for i = 1, #u31 do
        if u31[i].Frame.BorderSizePixel > 0 then
            return u31[i];
        end;
    end;
end;

function changeSlot(u210)
    -- upvalues: GamepadService (copy), GuiService (copy), u25 (ref), u45 (ref)
    if u210.Frame == GuiService.SelectedObject and not GamepadService.GamepadCursorEnabled then
        local v211 = getGamepadSwapSlot();

        if not v211 then
            local Size = u210.Frame.Size;
            local Position = u210.Frame.Position;
            u210.Frame:TweenSizeAndPosition(Size + UDim2.fromOffset(10, 10), Position - UDim2.fromOffset(5, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() -- Line: 1326
                -- upvalues: u210 (copy), Size (copy), Position (copy)
                u210.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true);
            end);
            u210.Frame.BorderSizePixel = 3;
            u25.SelectionImageObject.Visible = true;

            return;
        end;

        v211.Frame.BorderSizePixel = 0;

        if v211 ~= u210 then
            u210:Swap(v211);
            u25.SelectionImageObject.Visible = false;

            if u45 < u210.Index and not u210.Tool then
                if GuiService.SelectedObject == u210.Frame then
                    GuiService.SelectedObject = v211.Frame;
                end;

                u210:Delete();
            end;

            if u45 < v211.Index and not v211.Tool then
                if GuiService.SelectedObject == v211.Frame then
                    GuiService.SelectedObject = u210.Frame;
                end;

                v211:Delete();
            end;
        end;
    else
        u210:Select();
        u25.SelectionImageObject.Visible = false;
    end;
end;

function enableGamepadInventoryControl()
    -- upvalues: u24 (ref), u1 (copy), ContextActionService (copy), u188 (copy), GuiService (copy), u22 (ref)
    local function v216(p212, p213, p214) -- Line: 1347
        -- upvalues: u24 (ref), u1 (ref)
        if p213 ~= Enum.UserInputState.Begin then
            return;
        end;

        if getGamepadSwapSlot() then
            local v215 = getGamepadSwapSlot();

            if v215 then
                v215.Frame.BorderSizePixel = 0;
            end;
        elseif u24.Visible then
            u1.OpenClose();
        end;
    end;

    ContextActionService:BindAction("BackpackHasGamepadFocus", u188, false, Enum.UserInputType.Gamepad1);
    ContextActionService:BindAction("BackpackCloseInventory", v216, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart);

    if true then
        GuiService.SelectedObject = u22:FindFirstChild("1");
    end;
end;

function disableGamepadInventoryControl()
    -- upvalues: u45 (ref), u31 (copy), GuiService (copy), u21 (ref)
    unbindAllGamepadEquipActions();

    for i = 1, u45 do
        local v217 = u31[i];

        if v217 and v217.Frame then
            v217.Frame.BorderSizePixel = 0;
        end;
    end;

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u21) then
        GuiService.SelectedObject = nil;
    end;
end;

local function bindBackpackHotbarAction() -- Line: 1396
    -- upvalues: u19 (ref), ContextActionService (copy)
    if not u19 then
        u19 = true;
        ContextActionService:BindAction("BackpackHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;
end;

local function unbindBackpackHotbarAction() -- Line: 1411
    -- upvalues: u19 (ref), ContextActionService (copy)
    disableGamepadInventoryControl();
    u19 = false;
    ContextActionService:UnbindAction("BackpackHotbarEquip");
end;

function gamepadDisconnected()
    -- upvalues: VRService (copy), u43 (ref)
    if not VRService.VREnabled then
        u43 = false;
        disableGamepadInventoryControl();
    end;
end;

function gamepadConnected()
    -- upvalues: VRService (copy), u43 (ref), GuiService (copy), u21 (ref), u36 (ref), u19 (ref), ContextActionService (copy), u24 (ref)
    if not VRService.VREnabled then
        u43 = true;
        GuiService:AddSelectionParent("BackpackSelection", u21);

        if u36 >= 1 and not u19 then
            u19 = true;
            ContextActionService:BindAction("BackpackHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
        end;

        if u24.Visible then
            enableGamepadInventoryControl();
        end;
    end;
end;

local function MakeVRRoundButton(p218, p219) -- Line: 1475
    -- upvalues: NewGui (copy)
    local v220 = NewGui("ImageButton", p218);
    v220.Size = UDim2.fromOffset(40, 40);
    v220.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png";
    local v221 = NewGui("ImageLabel", "Icon");
    v221.Size = UDim2.fromScale(0.5, 0.5);
    v221.Position = UDim2.fromScale(0.25, 0.25);
    v221.Image = p219;
    v221.Parent = v220;
    local v222 = NewGui("ImageLabel", "Selection");
    v222.Size = UDim2.fromScale(0.9, 0.9);
    v222.Position = UDim2.fromScale(0.05, 0.05);
    v222.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png";
    v220.SelectionImageObject = v222;

    return v220, v221, v222;
end;

u21 = NewGui("Frame", "Backpack");

if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
    u21.Parent = ScreenGui;
end;

u22 = NewGui("Frame", "Hotbar");
u22.Parent = u21;

for i = 1, u45 do
    local v223 = MakeSlot(u22, i);
    v223.Frame.Visible = false;

    if not u32 then
        u32 = v223;
    end;
end;

u23 = NewGui("ImageButton", "OpenInventory");
u23.Size = UDim2.fromOffset(30, 30);
u23.Image = "rbxasset://textures/ui/Backpack/ScrollUpArrow.png";
u23.MouseButton1Click:connect(function() -- Line: 1525
    -- upvalues: u1 (copy)
    u1.OpenClose();
end);
u23.SelectionGained:connect(function() -- Line: 1528
    -- upvalues: u23 (ref), u9 (copy)
    u23.ImageColor3 = u9;
end);
u23.SelectionLost:connect(function() -- Line: 1531
    -- upvalues: u23 (ref)
    u23.ImageColor3 = Color3.new(1, 1, 1);
end);
local v224 = NewGui("Frame", "Selection");
v224.Visible = false;
u23.SelectionImageObject = v224;
local v225 = MakeVRRoundButton("CloseInventory", "rbxasset://textures/ui/Keyboard/close_button_icon.png");
v225.Position = UDim2.fromOffset(0, -50);
v225.MouseButton1Click:connect(function() -- Line: 1541
    -- upvalues: u24 (ref), u1 (copy)
    if u24.Visible then
        u1.OpenClose();
    end;
end);
LeftBumperButton = NewGui("ImageLabel", "LeftBumper");
LeftBumperButton.Size = UDim2.fromOffset(40, 40);
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2);
RightBumperButton = NewGui("ImageLabel", "RightBumper");
RightBumperButton.Size = UDim2.fromOffset(40, 40);
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2);
u24 = NewGui("Frame", "Inventory");
u24.BackgroundTransparency = u3;
u24.BackgroundColor3 = u4;
u24.Active = true;
u24.Visible = false;
u24.Parent = u21;
u25 = NewGui("TextButton", "VRInventorySelector");
u25.Position = UDim2.new(0, 0, 0, 0);
u25.Size = UDim2.fromScale(1, 1);
u25.BackgroundTransparency = 1;
u25.Text = "";
u25.Parent = u24;
local v226 = NewGui("ImageLabel", "Selector");
v226.Size = UDim2.fromScale(1, 1);
v226.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
v226.ScaleType = Enum.ScaleType.Slice;
v226.SliceCenter = Rect.new(12, 12, 52, 52);
v226.Visible = false;
u25.SelectionImageObject = v226;
u26 = NewGui("ScrollingFrame", "ScrollingFrame");
u26.Selectable = false;
u26.CanvasSize = UDim2.new(0, 0, 0, 0);
u26.Parent = u24;
u27 = NewGui("Frame", "UIGridFrame");
u27.Selectable = false;
u27.Size = UDim2.new(1, -10, 1, 0);
u27.Position = UDim2.fromOffset(5, 0);
u27.Parent = u26;
local UIGridLayout = Instance.new("UIGridLayout");
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIGridLayout.CellSize = UDim2.fromOffset(u2, u2);
UIGridLayout.CellPadding = UDim2.fromOffset(5, 5);
UIGridLayout.Parent = u27;
local u227 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u227.Size = UDim2.fromOffset(34, 34);
u227.Position = UDim2.new(0.5, -u227.Size.X.Offset / 2, 0, 43);
u227.Icon.Position = u227.Icon.Position - UDim2.fromOffset(0, 2);
u227.MouseButton1Click:connect(function() -- Line: 1601
    -- upvalues: u26 (ref), u2 (ref)
    local new = Vector2.new;
    local X = u26.CanvasPosition.X;
    local v228 = u26.CanvasSize.Y.Offset - u26.AbsoluteWindowSize.Y;
    local v229 = math.max(0, u26.CanvasPosition.Y - (u2 + 5));
    u26.CanvasPosition = new(X, (math.min(v228, v229)));
end);
local u230 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u230.Rotation = 180;
u230.Icon.Position = u230.Icon.Position - UDim2.fromOffset(0, 2);
u230.Size = UDim2.fromOffset(34, 34);
u230.Position = UDim2.new(0.5, -u230.Size.X.Offset / 2, 1, -u230.Size.Y.Offset - 3);
u230.MouseButton1Click:connect(function() -- Line: 1618
    -- upvalues: u26 (ref), u2 (ref)
    local new = Vector2.new;
    local X = u26.CanvasPosition.X;
    local v231 = u26.CanvasSize.Y.Offset - u26.AbsoluteWindowSize.Y;
    local v232 = math.max(0, u26.CanvasPosition.Y + (u2 + 5));
    u26.CanvasPosition = new(X, (math.min(v231, v232)));
end);
u26.Changed:connect(function(p233) -- Line: 1629
    -- upvalues: u26 (ref), u227 (ref), u230 (ref)
    if p233 == "AbsoluteWindowSize" or (p233 == "CanvasPosition" or p233 == "CanvasSize") then
        local v234 = u26.CanvasPosition.Y < u26.CanvasSize.Y.Offset - u26.AbsoluteWindowSize.Y;
        u227.Visible = u26.CanvasPosition.Y ~= 0;
        u230.Visible = v234;
    end;
end);
UpdateBackpackLayout();
local u235 = "Frame";
local u239 = (function(p236) -- Line: 111
    -- upvalues: u235 (copy)
    local v237 = Instance.new(u235);
    local v238 = nil;

    for i, v in p236 do
        if type(i) == "number" then
            v.Parent = v237;
        elseif i == "Parent" then
            v238 = v;
        else
            v237[i] = v;
        end;
    end;

    if v238 then
        v237.Parent = v238;
    end;

    return v237;
end)({
    Name = "GamepadHintsFrame",
    BackgroundTransparency = 1,
    Visible = false,
    Size = UDim2.fromOffset(u22.Size.X.Offset, u14 and 95 or 60),
    Parent = u21
});

local function addGamepadHint(p240, p241, p242) -- Line: 1652
    -- upvalues: u239 (copy), u14 (copy)
    local u243 = "Frame";
    local v247 = (function(p244) -- Line: 111
        -- upvalues: u243 (copy)
        local v245 = Instance.new(u243);
        local v246 = nil;

        for i, v in p244 do
            if type(i) == "number" then
                v.Parent = v245;
            elseif i == "Parent" then
                v246 = v;
            else
                v245[i] = v;
            end;
        end;

        if v246 then
            v245.Parent = v246;
        end;

        return v245;
    end)({
        Name = "HintFrame",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -5),
        Position = UDim2.new(0, 0, 0, 0),
        Parent = u239
    });
    local u248 = "ImageLabel";

    local function v252(p249) -- Line: 111
        -- upvalues: u248 (copy)
        local v250 = Instance.new(u248);
        local v251 = nil;

        for i, v in p249 do
            if type(i) == "number" then
                v.Parent = v250;
            elseif i == "Parent" then
                v251 = v;
            else
                v250[i] = v;
            end;
        end;

        if v251 then
            v250.Parent = v251;
        end;

        return v250;
    end;

    local v253 = {
        Name = "HintImage",
        BackgroundTransparency = 1,
        Size = u14 and UDim2.fromOffset(90, 90) or UDim2.fromOffset(60, 60)
    };

    if u14 then
        p240 = p241 or p240;
    end;

    v253.Image = p240;
    v253.Parent = v247;
    v252(v253);
    local u254 = "TextLabel";
    local v258 = (function(p255) -- Line: 111
        -- upvalues: u254 (copy)
        local v256 = Instance.new(u254);
        local v257 = nil;

        for i, v in p255 do
            if type(i) == "number" then
                v.Parent = v256;
            elseif i == "Parent" then
                v257 = v;
            else
                v256[i] = v;
            end;
        end;

        if v257 then
            v256.Parent = v257;
        end;

        return v256;
    end)({
        Name = "HintText",
        BackgroundTransparency = 1,
        TextWrapped = true,
        Position = UDim2.fromOffset(u14 and 100 or 70, 0),
        Size = UDim2.new(1, -(u14 and 100 or 70), 1, 0),
        Font = Enum.Font.SourceSansBold,
        FontSize = u14 and Enum.FontSize.Size36 or Enum.FontSize.Size24,
        Text = p242,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = v247
    });
    Instance.new("UITextSizeConstraint", v258).MaxTextSize = v258.TextSize;
end;

local function resizeGamepadHintsFrame() -- Line: 1686
    -- upvalues: u239 (copy), u22 (ref), u14 (copy), u24 (ref)
    u239.Size = UDim2.new(u22.Size.X.Scale, u22.Size.X.Offset, 0, u14 and 95 or 60);
    u239.Position = UDim2.new(u22.Position.X.Scale, u22.Position.X.Offset, u24.Position.Y.Scale, u24.Position.Y.Offset - u239.Size.Y.Offset);
    local v259 = u239:GetChildren();
    local v260 = 0;

    for i = 1, #v259 do
        v259[i].Size = UDim2.new(1, 0, 1, -5);
        v259[i].Position = UDim2.new(0, 0, 0, 0);
        v260 = v260 + (v259[i].HintText.Position.X.Offset + v259[i].HintText.TextBounds.X);
    end;

    local v261 = (u239.AbsoluteSize.X - v260) / (#v259 - 1);

    for i = 1, #v259 do
        v259[i].Position = i == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v259[i - 1].Position.X.Offset + v259[i - 1].Size.X.Offset + v261, 0, 0);
        v259[i].Size = UDim2.new(0, v259[i].HintText.Position.X.Offset + v259[i].HintText.TextBounds.X, 1, -5);
    end;
end;

addGamepadHint(
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png",
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonX@2x.png",
    "Remove From Hotbar"
);
addGamepadHint(
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png",
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonA@2x.png",
    "Select/Swap"
);
addGamepadHint(
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png",
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonB@2x.png",
    "Close Backpack"
);
local u262 = NewGui("Frame", "Search");
u262.BackgroundColor3 = v11;
u262.BackgroundTransparency = u12;
u262.Size = UDim2.fromOffset(190, 30);
u262.Position = UDim2.new(1, -u262.Size.X.Offset - 5, 0, 5);
u262.Parent = u24;
local u263 = NewGui("TextBox", "TextBox");
u263.Text = u10;
u263.ClearTextOnFocus = false;
u263.FontSize = Enum.FontSize.Size24;
u263.TextXAlignment = Enum.TextXAlignment.Left;
u263.Size = u262.Size - UDim2.fromOffset(0, 0);
u263.Position = UDim2.fromOffset(0, 0);
u263.Parent = u262;
local u264 = NewGui("TextButton", "X");
u264.Text = "x";
u264.TextColor3 = u6;
u264.FontSize = Enum.FontSize.Size24;
u264.TextYAlignment = Enum.TextYAlignment.Bottom;
u264.BackgroundColor3 = v11;
u264.BackgroundTransparency = 0;
u264.Size = UDim2.new(0, u262.Size.Y.Offset - 10, 0, u262.Size.Y.Offset - 10);
u264.Position = UDim2.new(1, -u264.Size.X.Offset - 10, 0.5, -u264.Size.Y.Offset / 2);
u264.ZIndex = 0;
u264.Visible = false;
u264.BorderSizePixel = 0;
u264.Parent = u262;

local function search() -- Line: 1775
    -- upvalues: u263 (copy), u45 (ref), u31 (copy), u24 (ref), u40 (ref), u27 (ref), u26 (ref), u2 (ref), u264 (copy)
    local v265 = {};

    for i in u263.Text:gmatch("%S+") do
        v265[i:lower()] = true;
    end;

    local v266 = {};

    for i = u45 + 1, #u31 do
        local v267 = u31[i];
        local v268 = { v267, (v267:CheckTerms(v265)) };
        table.insert(v266, v268);
        v267.Frame.Visible = false;
        v267.Frame.Parent = u24;
    end;

    table.sort(v266, function(p269, p270) -- Line: 1790
        return p269[2] > p270[2];
    end);
    u40 = true;
    local v271 = 0;

    for _, v in v266 do
        local v272 = v[1];

        if v[2] > 0 then
            v272.Frame.Visible = true;
            v272.Frame.Parent = u27;
            v272.Frame.LayoutOrder = u45 + v271;
            v271 = v271 + 1;
        end;
    end;

    u26.CanvasPosition = Vector2.new(0, 0);
    local v273 = math.floor(u26.AbsoluteSize.X / (u2 + 5));
    local v274 = (#u27:GetChildren() - 1) / v273;
    local v275 = math.ceil(v274) * (u2 + 5) + 5;
    u26.CanvasSize = UDim2.fromOffset(0, v275);
    u264.ZIndex = 3;
end;

local function clearResults() -- Line: 1812
    -- upvalues: u264 (copy), u40 (ref), u45 (ref), u31 (copy), u27 (ref), u26 (ref), u2 (ref)
    if u264.ZIndex > 0 then
        u40 = false;

        for i = u45 + 1, #u31 do
            local v276 = u31[i];
            v276.Frame.LayoutOrder = v276.Index;
            v276.Frame.Parent = u27;
            v276.Frame.Visible = true;
        end;

        u264.ZIndex = 0;
    end;

    local v277 = math.floor(u26.AbsoluteSize.X / (u2 + 5));
    local v278 = (#u27:GetChildren() - 1) / v277;
    local v279 = math.ceil(v278) * (u2 + 5) + 5;
    u26.CanvasSize = UDim2.fromOffset(0, v279);
end;

local function reset() -- Line: 1826
    -- upvalues: clearResults (copy), u263 (copy), u10 (ref)
    clearResults();
    u263.Text = u10;
end;

local function onChanged(p280) -- Line: 1831
    -- upvalues: u263 (copy), clearResults (copy), u10 (ref), search (copy), u264 (copy)
    if p280 == "Text" then
        local Text = u263.Text;

        if Text == "" then
            clearResults();
        elseif Text ~= u10 then
            search();
        end;

        local v281;

        if Text == "" then
            v281 = false;
        else
            v281 = Text ~= u10;
        end;

        u264.Visible = v281;
    end;
end;

local function focusLost(p282) -- Line: 1849
    -- upvalues: search (copy), u263 (copy), u10 (ref)
    if p282 then
        search();

        return;
    end;

    if u263.Text == "" then
        u263.Text = u10;
    end;
end;

u263.Focused:connect(function() -- Line: 1843, Name: onFocused
    -- upvalues: u263 (copy), u10 (ref)
    if u263.Text == u10 then
        u263.Text = "";
    end;
end);
u264.MouseButton1Click:connect(reset);
u263.Changed:connect(onChanged);
u263.FocusLost:connect(focusLost);
u1.StateChanged.Event:connect(function(p283) -- Line: 1863
    -- upvalues: u264 (copy), clearResults (copy), u263 (copy), u10 (ref)
    u264.Modal = p283;

    if not p283 then
        clearResults();
        u263.Text = u10;
    end;
end);

u34[Enum.KeyCode.Escape.Value] = function(p284) -- Line: 1870
    -- upvalues: clearResults (copy), u263 (copy), u10 (ref), u24 (ref), u1 (copy)
    if not p284 then
        if u24.Visible then
            u1.OpenClose();
        end;

        return;
    end;

    clearResults();
    u263.Text = u10;
end;

UserInputService.LastInputTypeChanged:connect(function(p285) -- Line: 1878, Name: detectGamepad
    -- upvalues: VRService (copy), u262 (copy)
    if p285 == Enum.UserInputType.Gamepad1 and not VRService.VREnabled then
        u262.Visible = false;

        return;
    end;

    u262.Visible = true;
end);

local function u289(p286, p287, p288) -- Line: 1889
    -- upvalues: GuiService (copy), u45 (ref), u31 (copy)
    if p287 ~= Enum.UserInputState.Begin then
        return;
    end;

    if not GuiService.SelectedObject then
        return;
    end;

    for i = 1, u45 do
        if u31[i].Frame == GuiService.SelectedObject and u31[i].Tool then
            u31[i]:MoveToInventory();

            return;
        end;
    end;
end;

local function openClose() -- Line: 1905
    -- upvalues: u35 (copy), u24 (ref), AdjustHotbarFrames (copy), u22 (ref), u45 (ref), u31 (copy), u43 (ref), u13 (copy), UserInputService (copy), resizeGamepadHintsFrame (copy), u239 (copy), ContextActionService (copy), u289 (copy), u1 (copy)
    if not next(u35) then
        u24.Visible = not u24.Visible;
        local Visible = u24.Visible;
        AdjustHotbarFrames();
        u22.Active = not u22.Active;

        for i = 1, u45 do
            u31[i]:SetClickability(not Visible);
        end;
    end;

    if u24.Visible then
        if u43 then
            if u13[UserInputService:GetLastInputType()] then
                resizeGamepadHintsFrame();
                u239.Visible = true;
            end;

            enableGamepadInventoryControl();
        end;
    else
        if u43 then
            u239.Visible = false;
        end;

        disableGamepadInventoryControl();
    end;

    if u24.Visible then
        ContextActionService:BindAction("BackpackRemoveSlot", u289, false, Enum.KeyCode.ButtonX);
    else
        ContextActionService:UnbindAction("BackpackRemoveSlot");
    end;

    u1.IsOpen = u24.Visible;
    u1.StateChanged:Fire(u24.Visible);
end;

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
u1.OpenClose = openClose;

while not LocalPlayer do
    wait();
    LocalPlayer = Players.LocalPlayer;
end;

LocalPlayer.CharacterAdded:connect(OnCharacterAdded);

if LocalPlayer.Character then
    OnCharacterAdded(LocalPlayer.Character);
end;

for i = 0, 9 do
    local v290 = tostring(i);
    table.insert(v41, v290);
end;

table.insert(v41, "`");
UserInputService.InputBegan:connect(OnInputBegan);
UserInputService.TextBoxFocused:connect(function() -- Line: 1979
    -- upvalues: u39 (ref)
    u39 = true;
end);
UserInputService.TextBoxFocusReleased:connect(function() -- Line: 1982
    -- upvalues: u39 (ref)
    u39 = false;
end);

u34[Value2] = function() -- Line: 1987
    -- upvalues: u37 (ref), u29 (ref), u33 (copy)
    if u37 and u29 then
        u29:UnequipTools();

        if u37 then
            u37:ToggleSelect();
            u33[u37]:UpdateEquipView();
            u37 = nil;
        end;
    end;
end;

UserInputService.Changed:connect(OnUISChanged);
local v291 = UserInputService.KeyboardEnabled and not VRService.VREnabled;

for i = 1, u45 do
    u31[i]:TurnNumber(v291);
end;

if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected();
end;

UserInputService.GamepadConnected:connect(function(p292) -- Line: 2001
    if p292 == Enum.UserInputType.Gamepad1 then
        gamepadConnected();
    end;
end);
UserInputService.GamepadDisconnected:connect(function(p293) -- Line: 2006
    if p293 == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected();
    end;
end);
GuiService.MenuOpened:Connect(function() -- Line: 2027
    -- upvalues: u1 (copy)
    if u1.IsOpen then
        u1.OpenClose();
    end;
end);

local function OnPreferredTransparencyChanged() -- Line: 2044
    -- upvalues: GuiService (copy), u3 (ref), u24 (ref), u7 (ref), u31 (copy), u12 (ref), u262 (copy)
    local PreferredTransparency = GuiService.PreferredTransparency;
    u3 = 0.5 * GuiService.PreferredTransparency;
    u24.BackgroundTransparency = u3;
    u7 = 0.5 * PreferredTransparency;

    for _, v in u31 do
        v.Frame.BackgroundTransparency = u7;
    end;

    u12 = 0.15 * GuiService.PreferredTransparency;
    u262.BackgroundTransparency = u12;
end;

GuiService:GetPropertyChangedSignal("PreferredTransparency"):connect(OnPreferredTransparencyChanged);
script.Parent.Parent.SetEnabled.Event:Connect(function(p294) -- Line: 2060
    -- upvalues: u1 (copy)
    if not p294 and u1.IsOpen then
        u1.OpenClose();
    end;
end);

return u1;