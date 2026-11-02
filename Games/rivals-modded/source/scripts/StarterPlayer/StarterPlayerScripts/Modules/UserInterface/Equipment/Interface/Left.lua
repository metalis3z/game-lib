-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local EquipmentButtonSlot = require(Players.LocalPlayer.PlayerScripts.Modules.EquipmentButtonSlot);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local EquipmentQuickActionButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentQuickActionButton");
local EquipmentUnlockMeBubble = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentUnlockMeBubble");
local EquipmentClassSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentClassSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 26
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Interface = p2;
    v3.Frame = v3.Interface.Frame:WaitForChild("Left");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.List = v3.Frame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.TopBufferFrame = v3.Container:WaitForChild("TopBuffer");
    v3._generate_deferred = false;
    v3._cleanup = {};
    v3._weapon_slots = {};
    v3._career_slot = nil;
    v3._unlock_me_bubbles = {};
    v3._previous_canvas_position = nil;
    v3:_Init();

    return v3;
end;

function u1.SetVisible(p4, p5) -- Line: 53
    p4.Frame:TweenPosition(p5 and UDim2.new(0, 0, 0.5, 0) or UDim2.new(-0.375, 0, 0.5, 0), "Out", "Quint", 0.25, true);
end;

function u1.ScrollTo(u6, u7, p8) -- Line: 57
    -- upvalues: UILibrary (copy), TweenService (copy)
    task.delay(p8 or 0, function() -- Line: 58
        -- upvalues: u6 (copy), u7 (copy), UILibrary (ref), TweenService (ref)
        local math_min_ret = math.min(u6.List.AbsoluteCanvasSize.Y, u7.AbsolutePosition.Y + UILibrary.MainGui.AbsolutePosition.Y * 2 - u6.Container.AbsolutePosition.Y);
        TweenService:Create(u6.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(0, math_min_ret)
        }):Play();
    end);
end;

function u1.OnStateChanged(p9) -- Line: 64
    p9:_UpdateActive();
    p9:_UpdateUnlockMeBubbles();
end;

function u1.OnOpen(p10) -- Line: 69
    p10:_GenerateDeferred();
end;

function u1.Update(p11, p12) -- Line: 73
    for _, v in pairs(p11._unlock_me_bubbles) do
        local Y = v.Bubble.AbsoluteSize.Y;
        local v13 = v.Bubble.Parent.AbsoluteSize.Y - v.Bubble.AbsoluteSize.Y;
        local math_clamp_ret = math.clamp(v.WeaponSlot.Frame.AbsolutePosition.Y + v.WeaponSlot.Frame.AbsoluteSize.Y / 2 - v.Bubble.Parent.AbsolutePosition.Y, Y, v13);
        v.Bubble.Position = UDim2.new(0.7, 0, 0, math_clamp_ret);
        local Arrow = v.Bubble.Button.Arrow;
        local v14;

        if v13 <= math_clamp_ret then
            v14 = UDim2.new(0.5, 0, 1, -2);
        elseif math_clamp_ret <= Y then
            v14 = UDim2.new(0.5, 0, 0, 2);
        else
            v14 = UDim2.new(0, 2, 0.5, 0);
        end;

        Arrow.Position = v14;
    end;
end;

function u1._Update(u15) -- Line: 90
    if u15.Interface.Equipment:IsCustomizing() then
        return;
    end;

    task.defer(function() -- Line: 95
        -- upvalues: u15 (copy)
        u15.TopBufferFrame.Size = UDim2.new(1, 0, 0, (math.max(u15.List.AbsoluteSize.Y * 0.375, u15.List.AbsoluteSize.Y - (u15.Layout.AbsoluteContentSize.Y - u15.TopBufferFrame.AbsoluteSize.Y))));
        u15.List.CanvasSize = UDim2.new(0, 0, 0, u15.Layout.AbsoluteContentSize.Y);
        u15.Background.Size = UDim2.new(0.7, 0, 0, u15.Background.AbsolutePosition.Y + u15.Background.AbsoluteSize.Y - (u15.TopBufferFrame.AbsolutePosition.Y + u15.TopBufferFrame.AbsoluteSize.Y));
    end);
end;

function u1._UpdateUnlockMeBubbles(u16) -- Line: 102
    -- upvalues: PlayerDataController (copy), EquipmentUnlockMeBubble (copy), ButtonEffect (copy)
    for _, v in pairs(u16._unlock_me_bubbles) do
        v.Bubble:Destroy();
    end;

    u16._unlock_me_bubbles = {};

    if not u16.Interface.Equipment.IsOpen or u16.Interface.Equipment:IsUnlocking() then
        return;
    end;

    local SelectedWeapon = u16.Interface.Equipment:GetSelectedWeapon();

    for i in pairs(PlayerDataController:Get("FreeWeaponUnlockCheck")) do
        if i ~= SelectedWeapon and not PlayerDataController:GetWeaponData(i) then
            local u17 = u16._weapon_slots[i];

            if u17 then
                local v18 = EquipmentUnlockMeBubble:Clone();
                v18.Parent = u16.Frame;
                table.insert(u16._unlock_me_bubbles, {
                    Bubble = v18,
                    WeaponSlot = u17
                });
                ButtonEffect:Add(v18.Button);
                v18.Button.MouseButton1Click:Connect(function() -- Line: 131
                    -- upvalues: u16 (copy), u17 (copy), i (copy)
                    u16:ScrollTo(u17.Frame);
                    u16.Interface.Equipment:SelectWeapon(i);
                end);
            end;
        end;
    end;
end;

function u1._UpdateActive(p19) -- Line: 138
    local v20 = p19.Interface.Equipment:IsCareerPageOpen();
    local SelectedWeapon = p19.Interface.Equipment:GetSelectedWeapon();

    if p19._career_slot then
        p19._career_slot:SetActive(v20);
    end;

    for i, v in pairs(p19._weapon_slots) do
        v:SetActive(i == SelectedWeapon);
    end;
end;

function u1._GetOrder(p21) -- Line: 151
    -- upvalues: PlayerDataController (copy), ShopLibrary (copy), CONSTANTS (copy), ItemLibrary (copy), Utility (copy)
    local UnlockedWeapons = PlayerDataController:GetUnlockedWeapons(true);
    local FavoritedWeapons = PlayerDataController:GetFavoritedWeapons();
    local v22 = {};
    local v23 = {};

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_REVEAL_TIME_OFFSET, ShopLibrary.OwnableWeaponsAlphabetized)) do
        table.insert(v22, v);

        if ShopLibrary:GetTimeUntilWeaponRelease(v) > 0 then
            v23[v] = true;
        end;
    end;

    table.sort(v22, function(p24, p25) -- Line: 167
        -- upvalues: FavoritedWeapons (copy), UnlockedWeapons (copy), ItemLibrary (ref), Utility (ref)
        local v26 = FavoritedWeapons[p24];

        if v26 ~= FavoritedWeapons[p25] then
            return v26;
        end;

        local v27 = UnlockedWeapons[p24];

        if v27 ~= UnlockedWeapons[p25] then
            return v27;
        end;

        local Slot = ItemLibrary.Classes[ItemLibrary.Items[p24].Class].Slot;
        local Slot2 = ItemLibrary.Classes[ItemLibrary.Items[p25].Class].Slot;

        if Slot ~= Slot2 then
            return Slot < Slot2;
        end;

        local Value = ItemLibrary.Statuses[ItemLibrary.Items[p24].Status].Value;
        local Value2 = ItemLibrary.Statuses[ItemLibrary.Items[p25].Status].Value;

        if Value == Value2 then
            return Utility:StringLessThan(p24, p25);
        end;

        return Value < Value2;
    end);

    return v22, UnlockedWeapons, FavoritedWeapons, v23;
end;

function u1._Generate(u28) -- Line: 203
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy), EquipmentQuickActionButton (copy), ButtonEffect (copy), ItemLibrary (copy), EquipmentClassSlot (copy), Utility (copy), CONSTANTS (copy), Players (copy), EquipmentButtonSlot (copy), ShopLibrary (copy)
    for _, v in pairs(u28._weapon_slots) do
        v:Destroy();
    end;

    for _, v in pairs(u28._cleanup) do
        v:Destroy();
    end;

    u28._weapon_slots = {};
    u28._cleanup = {};

    if u28._career_slot then
        u28._career_slot:Destroy();
        u28._career_slot = nil;
    end;

    u28._previous_canvas_position = u28._previous_canvas_position or u28.List.CanvasPosition;

    if not u28.Interface.Equipment.IsOpen or u28.Interface.Equipment:IsCustomizing() then
        return;
    end;

    local v29 = PlayerDataController:Get("CosmeticNotifications");
    local u30 = CosmeticLibrary:CountNotifications(v29);
    local v31 = CosmeticLibrary:CountNotificationsByCosmeticType(v29, "Emote");
    local v32, v33, v34, v35 = u28:_GetOrder();
    local u36 = {};
    local u37 = {};

    local function create_quick_action_button_slot(p38, p39, p40, p41) -- Line: 239
        -- upvalues: u36 (copy), u37 (copy), EquipmentQuickActionButton (ref), ButtonEffect (ref)
        local ___career = u36.___career;

        if not ___career or u37[p38] then
            return;
        end;

        local v42 = EquipmentQuickActionButton:Clone();
        v42.LayoutOrder = p39;
        v42.Icon.Image = p40;
        v42.Parent = ___career.Container.QuickActions.Container;
        ButtonEffect:Add(v42);
        v42.MouseButton1Click:Connect(p41);
        u37[p38] = v42;
    end;

    local function get_class_slot(p43, p44, p45, p46, p47) -- Line: 255
        -- upvalues: u36 (copy), ItemLibrary (ref), EquipmentClassSlot (ref), u28 (copy), u30 (copy), Utility (ref), ButtonEffect (ref), PlayerDataController (ref), create_quick_action_button_slot (copy), CosmeticLibrary (ref)
        if not u36[p43] then
            local v48 = ItemLibrary.Classes[p43];
            local v49 = p44 or (v48 and (v48.Slot or -999999) or -999999);
            local v50 = p45 or (v48 and (v48.Name or "") or "");
            local v51 = p46 or (v48 and (v48.ImageDiagonalLeft or "") or "");
            local v52 = p47 or (v48 and v48.ImageDiagonalRight or "");
            local u53 = EquipmentClassSlot:Clone();
            u53.Container.Footer.Visible = false;
            u53.Container.QuickActions.Visible = false;
            u53.Container.DismissNotifications.Visible = false;
            local v54;

            if v50 then
                v54 = v50 ~= "";
            else
                v54 = v50;
            end;

            u53.Container.Header.Visible = v54;
            u53.Container.Header.Title.Left.Image = v51;
            u53.Container.Header.Title.Right.Image = v52;
            u53.Container.Header.Title.Text = v50;
            u53.LayoutOrder = v49;
            u53.ZIndex = u53.LayoutOrder;
            u53.Parent = u28.Container;
            table.insert(u28._cleanup, u53);
            u36[p43] = u53;
            local Header = u53.Container.Header;
            local Layout = u53.Container.Layout;
            local Title = u53.Container.Header.Title;
            local Left = u53.Container.Header.Title.Left;
            local Right = u53.Container.Header.Title.Right;

            local function update() -- Line: 285
                -- upvalues: u53 (copy), Layout (copy), Left (copy), Title (copy), Right (copy)
                u53.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
                Left.Position = UDim2.new(0.5, -Title.TextBounds.X / 2, 0.5, 0);
                Right.Position = UDim2.new(0.5, Title.TextBounds.X / 2, 0.5, 0);
            end;

            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update);
            Header:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
            Title:GetPropertyChangedSignal("TextBounds"):Connect(update);
            update();

            if p43 == "___career" then
                u53.Container.QuickActions.Visible = true;
                u53.Container.DismissNotifications.Visible = u30 > 0;
                u53.Container.DismissNotifications.Button.Title.Text = string.format("Dismiss <font weight=\"800\">%s</font> Notification%s", Utility:PrettyNumber(u30), u30 == 1 and "" or "s");
                ButtonEffect:Add(u53.Container.DismissNotifications.Button, nil, {
                    HoverRatio = UDim2.new(0, 10, 0, 10),
                    ReleaseRatio = UDim2.new(0, 10, 0, 10)
                });
                u53.Container.DismissNotifications.Button.MouseButton1Click:Connect(function() -- Line: 303
                    -- upvalues: PlayerDataController (ref)
                    PlayerDataController:SilenceCosmeticNotification(nil, nil);
                end);
                create_quick_action_button_slot("___career", -1, CosmeticLibrary.Types.Emote.Image, function() -- Line: 307
                    -- upvalues: u28 (ref)
                    u28.Interface.Equipment:StartCustomizing("Emote");
                end);
            end;
        end;

        return u36[p43].Container;
    end;

    local string_format_ret = string.format(CONSTANTS.HEADSHOT_IMAGE, Players.LocalPlayer.UserId);
    local v55 = get_class_slot("___career", -3);
    u28._career_slot = EquipmentButtonSlot.new("___career", -999998, true, "Career", string_format_ret, nil, v31);
    u28._career_slot:SetCareerIcon();
    u28._career_slot:SetParent(v55);
    u28._career_slot.Button.MouseButton1Click:Connect(function() -- Line: 324
        -- upvalues: u28 (copy)
        u28.Interface.Equipment:OpenCareerPage(true);
    end);
    local u56 = {};
    local v57 = false;

    for i, v in pairs(v32) do
        local u58 = ItemLibrary.Items[v];
        local u59 = ItemLibrary.Classes[u58.Class];
        local WeaponData = PlayerDataController:GetWeaponData(v);
        local v60 = v33[v];
        local v61 = not v60 and v35[v];
        local v62 = v34[v];
        local v63 = v61 and "___comingsoon" or (v62 and "___favorited" or u58.Class);
        local v64;

        if v61 then
            v64 = get_class_slot(v63, -2, "Coming Soon", "rbxassetid://18195730712", "rbxassetid://18195730712");
        elseif v62 then
            v64 = get_class_slot(v63, -1);
        else
            v64 = get_class_slot(v63);
        end;

        local v65 = WeaponData and ItemLibrary:GetViewModelImageFromWeaponData(WeaponData) or (ItemLibrary:GetViewModelImage(v) or "");
        local v66;

        if v60 then
            v66 = CosmeticLibrary:CountNotificationsByWeapon(v29, v);
        else
            v66 = v60;
        end;

        local v67 = EquipmentButtonSlot.new(v, i, v60, v61 and "???" or v, v65, u58.Status, v66);
        v67:SetParent(v64);
        u28._weapon_slots[v] = v67;
        u56[v63] = u56[v63] or {};
        table.insert(u56[v63], v67);
        v67.Button.MouseButton1Click:Connect(function() -- Line: 354
            -- upvalues: u28 (copy), v (copy)
            u28.Interface.Equipment:SelectWeapon(v);
        end);
        create_quick_action_button_slot(u58.Class, u59.Slot, u59.ImageDiagonalRight, function() -- Line: 359
            -- upvalues: u56 (copy), u58 (copy), CONSTANTS (ref), u59 (copy), u28 (copy)
            local v68;

            if u56[u58.Class] then
                v68 = u56[u58.Class][1].Name;
            else
                v68 = CONSTANTS.DEFAULT_WEAPONS[u59.Slot];
            end;

            u28.Interface.Equipment:SelectWeapon(v68);
            u28:ScrollTo(u28._weapon_slots[v68].Frame);
        end);
        v57 = v57 or v61;
    end;

    local v69 = #ShopLibrary.OwnableWeapons - #v32;
    local ___comingsoon = u36.___comingsoon;

    if ___comingsoon then
        if v57 then
            v57 = v69 > 0;
        end;

        ___comingsoon.Container.Footer.Visible = v57;
        ___comingsoon.Container.Footer.Title.Text = "+" .. v69 .. " more weapon" .. (v69 == 1 and "" or "s") .. "!";
    end;

    u28.List.CanvasPosition = u28._previous_canvas_position or u28.List.CanvasPosition;
    u28._previous_canvas_position = nil;
    u28:_UpdateActive();
    u28:_UpdateUnlockMeBubbles();
end;

function u1._GenerateDeferred(u70) -- Line: 387
    if u70._generate_deferred then
        return;
    end;

    u70._generate_deferred = true;
    task.defer(function() -- Line: 394
        -- upvalues: u70 (copy)
        u70._generate_deferred = false;
        u70:_Generate();
    end);
end;

function u1._Setup(p71) -- Line: 400
    p71.Frame.Visible = true;
end;

function u1._Init(u72) -- Line: 404
    -- upvalues: PlayerDataController (copy)
    u72.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 405
        -- upvalues: u72 (copy)
        u72:_Update();
    end);
    u72.Background:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 409
        -- upvalues: u72 (copy)
        u72:_Update();
    end);
    u72.Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 413
        -- upvalues: u72 (copy)
        u72:_Update();
    end);
    u72.TopBufferFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 417
        -- upvalues: u72 (copy)
        u72:_Update();
    end);
    u72.TopBufferFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 421
        -- upvalues: u72 (copy)
        u72:_Update();
    end);
    u72.Interface.Equipment.UnlockingChanged:Connect(function() -- Line: 425
        -- upvalues: u72 (copy)
        u72:_UpdateUnlockMeBubbles();
    end);
    u72.Interface.Equipment.CustomizingChanged:Connect(function() -- Line: 429
        -- upvalues: u72 (copy)
        u72:_GenerateDeferred();
    end);
    PlayerDataController:GetDataChangedSignal("FreeWeaponUnlockCheck"):Connect(function() -- Line: 433
        -- upvalues: u72 (copy)
        u72:_UpdateUnlockMeBubbles();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 437
        -- upvalues: u72 (copy)
        u72:_GenerateDeferred();
    end);
    PlayerDataController:GetDataChangedSignal("CosmeticNotifications"):Connect(function() -- Line: 441
        -- upvalues: u72 (copy)
        u72:_GenerateDeferred();
    end);
    PlayerDataController.StatisticsUpdated:Connect(function() -- Line: 445
        -- upvalues: u72 (copy)
        u72:_GenerateDeferred();
    end);
    u72:_Setup();
    u72:_Update();
    u72:_GenerateDeferred();
end;

return u1;