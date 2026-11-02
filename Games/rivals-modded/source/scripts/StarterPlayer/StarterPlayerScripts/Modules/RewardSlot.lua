-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local CosmeticSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local RewardBubble = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RewardBubble");
local RewardSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RewardSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 22
    -- upvalues: u1 (copy), CosmeticLibrary (copy), RewardSlot (copy)
    local v5 = setmetatable({}, u1);
    v5.RewardData = p2;
    v5.CosmeticInfo = CosmeticLibrary.Cosmetics[v5.RewardData.Name];
    v5.RewardInfo = CosmeticLibrary.Rewards[v5.RewardData.Name];
    v5.Frame = RewardSlot:Clone();
    v5.CosmeticSlot = nil;
    v5._ignore_button_effects = p3;
    v5._is_locked = p4;
    v5._key_slot_frame = nil;
    v5._bubble_hash = 0;
    v5._bubble_frame = nil;
    v5._bubble_reward_slot = nil;
    v5._bubble_connections = {};
    v5._bubble_auto_close_delay = nil;
    v5._on_click_callback = nil;
    v5:_Init();

    return v5;
end;

function u1.GetRewardBubbleTitle(p6) -- Line: 50
    -- upvalues: Utility (copy), CosmeticLibrary (copy)
    local v7 = p6.RewardData.Quantity or 1;
    local v8 = p6.RewardInfo and p6.RewardInfo.BubbleTitle;

    if not v8 then
        if p6.RewardInfo and p6.RewardInfo.Type == "Weapon" then
            if p6:_IsUnreleasedWeapon() then
                return "COMING SOON";
            end;

            v8 = p6.RewardInfo.DisplayName or (p6.RewardInfo and (p6.RewardInfo.PrioritizeNameOverQuantity and v7 == 1) and p6.RewardInfo.DisplayName or p6.RewardInfo and "×" .. Utility:PrettyNumber(v7) .. " " .. (v7 ~= 1 and p6.RewardInfo.DisplayNamePlural or p6.RewardInfo.DisplayName) or p6.RewardData.Name .. " " .. CosmeticLibrary.Cosmetics[p6.RewardData.Name].Type);
        else
            v8 = p6.RewardInfo and (p6.RewardInfo.PrioritizeNameOverQuantity and v7 == 1) and p6.RewardInfo.DisplayName or p6.RewardInfo and "×" .. Utility:PrettyNumber(v7) .. " " .. (v7 ~= 1 and p6.RewardInfo.DisplayNamePlural or p6.RewardInfo.DisplayName) or p6.RewardData.Name .. " " .. CosmeticLibrary.Cosmetics[p6.RewardData.Name].Type;
        end;
    end;

    return v8;
end;

function u1.GetRewardBubbleDescription(p9) -- Line: 60
    -- upvalues: Utility (copy), ShopLibrary (copy), ItemLibrary (copy)
    local v10 = p9.RewardInfo and p9.RewardInfo.BubbleDescription or p9.RewardInfo and p9.RewardInfo.Type == "Lootbox" and (p9.RewardData.Weapon and (p9.RewardData.Weapon ~= "IsRandom" and p9.RewardData.Weapon ~= "IsUniversal") and "Contains special items for " .. p9.RewardData.Weapon .. "!" or p9.RewardInfo.LootboxDescription) or p9.RewardInfo and p9.RewardInfo.Type == "Weapon" and (p9:_IsUnreleasedWeapon() and "in " .. Utility:TimeFormat2(ShopLibrary:GetTimeUntilWeaponRelease(p9.RewardData.Name)) .. "!" or ItemLibrary.Items[p9.RewardData.Name].Status .. " Weapon");

    if not v10 then
        if p9.RewardData.Weapon == "IsUniversal" then
            return "Given to all weapons forever!";
        end;

        if p9.RewardData.Weapon == "IsRandom" then
            return "Given to a random weapon!";
        end;

        v10 = p9.RewardData.Weapon and "Given to " .. p9.RewardData.Weapon .. "!" or (p9.CosmeticInfo and p9.CosmeticInfo.Description or "???");
    end;

    return v10;
end;

function u1.SetParent(p11, p12) -- Line: 71
    p11.Frame.Parent = p12;
end;

function u1.SetInteractable(p13, p14) -- Line: 75
    p13.Frame.Reward.Interactable = p14;

    if p13.CosmeticSlot then
        p13.CosmeticSlot:SetInteractable(p14);
    end;
end;

function u1.SetWeapon(p15, p16) -- Line: 83
    -- upvalues: ItemLibrary (copy), WeaponStatusHandler (copy)
    if p15.CosmeticSlot then
        return p15.CosmeticSlot:SetWeapon(p16);
    end;

    if p16 == "IsRandom" and (p15.RewardInfo and p15.RewardInfo.Type == "Lootbox") then
        p16 = nil;
    end;

    if not p16 then
        p15.Frame.Reward.Weapon.Visible = false;

        return;
    end;

    local v17 = ItemLibrary.Items[p16];
    local v18 = ItemLibrary.ViewModels[p16];
    local v19 = p16 == "IsUniversal" and true or p16 == "IsRandom";
    local v20;

    if p16 == "IsUniversal" then
        v20 = ItemLibrary.UNIVERSAL_WEAPON_ICON;
    elseif p16 == "IsRandom" then
        v20 = ItemLibrary.RANDOM_WEAPON_ICON;
    else
        v20 = not v18 and "" or (v18.ImageCentered or v18.Image);
    end;

    p15.Frame.Reward.Weapon.Visible = true;
    p15.Frame.Reward.Weapon.Container.IconCanvas.Icon.Image = v20;
    p15.Frame.Reward.Weapon.Container.IconCanvas.Icon.ImageTransparency = v19 and 0.25 or 0;
    p15.Frame.Reward.Weapon.Container.IconCanvas.Icon.Size = v19 and UDim2.new(0.7, 0, 0.7, 0) or UDim2.new(4, 0, 4, 0);
    WeaponStatusHandler:ApplyItemStatusToBackground(p15.Frame.Reward.Weapon.Container.Background, p15.Frame.Reward.Weapon.Container.Outline.UIStroke, v17 and v17.Status or "Standard");
end;

function u1.OnClick(p21, p22) -- Line: 112
    p21._on_click_callback = p22;
end;

function u1.HideWeaponVisual(p23) -- Line: 116
    p23.Frame.Reward.Weapon.Visible = false;

    if p23.CosmeticSlot then
        p23.CosmeticSlot.Frame.Button.Weapon.Visible = false;
    end;
end;

function u1.HideBackground(p24) -- Line: 124
    if p24.CosmeticSlot then
        p24.CosmeticSlot:HideBackground();
    end;
end;

function u1.ZoomOutViewportFrame(p25) -- Line: 130
    if p25.CosmeticSlot then
        p25.CosmeticSlot:ZoomOutViewportFrame();
    end;
end;

function u1.UseHighResolutionImage(p26) -- Line: 136
    if p26.RewardInfo then
        p26.Frame.Reward.Icon.Image = p26.RewardInfo.ImageHighResolution or p26.RewardInfo.Image;
    end;

    if p26.CosmeticSlot then
        p26.CosmeticSlot:UseHighResolutionImage();
    end;
end;

function u1.SetNameText(p27, p28) -- Line: 146
    p27.Frame.Reward.Title.Text = p28;

    if p27.CosmeticSlot then
        p27.CosmeticSlot.Frame.Button.Title.Text = p28;
    end;
end;

function u1.LockedImage(p29) -- Line: 154
    p29.Frame.Reward.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
    p29.Frame.Reward.Icon.ImageTransparency = 0.5;

    if p29.CosmeticSlot then
        p29.CosmeticSlot.Frame.Button.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
        p29.CosmeticSlot.Frame.Button.Icon.ImageTransparency = 0.5;
    end;
end;

function u1.InvertNameText(p30) -- Line: 164
    if p30.RewardInfo and p30.RewardInfo.Type == "Weapon" then
        p30.Frame.Reward.Title.Visible = false;

        return;
    end;

    p30.Frame.Reward.Title.TextColor3 = Color3.fromRGB(0, 0, 0);
    p30.Frame.Reward.Title.UIStroke.Enabled = false;
end;

function u1.SetBubbleAutoCloseDelay(p31, p32) -- Line: 173
    p31._bubble_auto_close_delay = p32;
end;

function u1.CloseBubble(p33) -- Line: 177
    -- upvalues: RunService (copy)
    p33._bubble_hash = p33._bubble_hash + 1;

    for _, v in pairs(p33._bubble_connections) do
        v:Disconnect();
    end;

    p33._bubble_connections = {};
    p33._open_bubble_upwards = nil;

    if p33._bubble_frame then
        p33._bubble_frame:Destroy();
        p33._bubble_frame = nil;
    end;

    if p33._bubble_reward_slot then
        p33._bubble_reward_slot:Destroy();
        p33._bubble_reward_slot = nil;
    end;

    RunService:UnbindFromRenderStep("RewardSlotOpenBubble");
end;

function u1.OpenBubble(u34, p35, p36) -- Line: 200
    -- upvalues: RewardBubble (copy), UILibrary (copy), u1 (copy), ItemLibrary (copy), WeaponStatusHandler (copy), GuiService (copy), UserInputService (copy), Players (copy), RunService (copy)
    u34:CloseBubble();
    u34._open_bubble_upwards = p35;
    u34._bubble_hash = u34._bubble_hash + 1;
    local _bubble_hash = u34._bubble_hash;
    local v37 = p36 or 1;
    local UDim2_new_ret = UDim2.new(RewardBubble.Size.X.Scale * v37, RewardBubble.Size.X.Offset * v37, RewardBubble.Size.Y.Scale * v37, RewardBubble.Size.Y.Offset * v37);
    local UDim2_new_ret2 = UDim2.new(UDim2_new_ret.X.Scale / 2, UDim2_new_ret.X.Offset / 2, UDim2_new_ret.Y.Scale / 2, UDim2_new_ret.Y.Offset / 2);
    u34._bubble_frame = RewardBubble:Clone();
    u34._bubble_frame.Title.Text = u34:GetRewardBubbleTitle();
    u34._bubble_frame.Description.Text = u34:GetRewardBubbleDescription();
    u34._bubble_frame.Size = UDim2_new_ret2;
    u34._bubble_frame.Parent = UILibrary:GetTo("MainFrame");
    u34._bubble_frame:TweenSize(UDim2_new_ret, "Out", "Back", 0.25, true);
    u34._bubble_reward_slot = u1.new(u34.RewardData, true);
    u34._bubble_reward_slot:OnClick(function() -- Line: 219
    end);
    u34._bubble_reward_slot:InvertNameText();
    u34._bubble_reward_slot:SetParent(u34._bubble_frame.Reward);

    if u34:_IsUnreleasedWeapon() then
        u34._bubble_reward_slot:LockedImage();
    end;

    if u34.RewardInfo and u34.RewardInfo.Type == "Weapon" then
        local v38 = ItemLibrary.Items[u34.RewardInfo.DisplayName] and ItemLibrary.Items[u34.RewardInfo.DisplayName].Status;
        WeaponStatusHandler:ApplyItemStatusToText(u34._bubble_frame.Title, v38);
        WeaponStatusHandler:ApplyItemStatusToText(u34._bubble_frame.Description, v38);
    elseif u34.RewardData and u34.RewardData.Weapon then
        WeaponStatusHandler:ApplyItemStatusToText(u34._bubble_frame.Description, ItemLibrary.Items[u34.RewardData.Weapon] and ItemLibrary.Items[u34.RewardData.Weapon].Status);
    elseif u34.RewardInfo and u34.RewardInfo.NameStatus then
        WeaponStatusHandler:ApplyItemStatusToText(u34._bubble_frame.Title, u34.RewardInfo.NameStatus);
    end;

    local _bubble_connections = u34._bubble_connections;
    local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("MenuIsOpen");
    table.insert(_bubble_connections, PropertyChangedSignal:Connect(function() -- Line: 237
        -- upvalues: GuiService (ref), u34 (copy)
        if GuiService.MenuIsOpen then
            u34:CloseBubble();
        end;
    end));
    table.insert(u34._bubble_connections, UserInputService.InputBegan:Connect(function(p39) -- Line: 243
        -- upvalues: u34 (copy)
        if p39.UserInputType == Enum.UserInputType.MouseButton1 or (p39.KeyCode == Enum.KeyCode.Return or (p39.UserInputType == Enum.UserInputType.Touch or (p39.KeyCode == Enum.KeyCode.ButtonA or p39.KeyCode == Enum.KeyCode.ButtonB))) then
            u34:CloseBubble();
        end;
    end));
    table.insert(u34._bubble_connections, u34.Frame.AncestryChanged:Connect(function() -- Line: 249
        -- upvalues: u34 (copy), Players (ref)
        if not (u34.Frame:IsDescendantOf(workspace) or (not Players.LocalPlayer:FindFirstChild("PlayerGui") or u34.Frame:IsDescendantOf(Players.LocalPlayer.PlayerGui))) then
            u34:CloseBubble();
        end;
    end));
    local _bubble_connections2 = u34._bubble_connections;
    local PropertyChangedSignal2 = u34.Frame:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(_bubble_connections2, PropertyChangedSignal2:Connect(function() -- Line: 255
        -- upvalues: u34 (copy)
        u34:_UpdateBubblePosition();
    end));
    local _bubble_connections3 = u34._bubble_connections;
    local PropertyChangedSignal3 = u34.Frame:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(_bubble_connections3, PropertyChangedSignal3:Connect(function() -- Line: 259
        -- upvalues: u34 (copy)
        u34:_UpdateBubblePosition();
    end));
    RunService:BindToRenderStep("RewardSlotOpenBubble", Enum.RenderPriority.Camera.Value - 1, function() -- Line: 263
        -- upvalues: u34 (copy)
        u34:_UpdateBubblePosition();
    end);
    u34:_UpdateBubblePosition();

    if u34._bubble_auto_close_delay then
        task.delay(u34._bubble_auto_close_delay, function() -- Line: 270
            -- upvalues: u34 (copy), _bubble_hash (copy), UDim2_new_ret2 (copy)
            if u34._bubble_hash ~= _bubble_hash then
                return;
            end;

            u34._bubble_frame:TweenSize(UDim2_new_ret2, "In", "Quint", 0.25, true);
            wait(0.25);

            if u34._bubble_hash ~= _bubble_hash then
                return;
            end;

            u34:CloseBubble();
        end);
    end;
end;

function u1.Destroy(p40) -- Line: 288
    p40:CloseBubble();
    p40.Frame:Destroy();

    if p40.CosmeticSlot then
        p40.CosmeticSlot:Destroy();
    end;
end;

function u1._IsUnreleasedWeapon(p41) -- Line: 301
    -- upvalues: ShopLibrary (copy)
    local RewardInfo = p41.RewardInfo;

    if RewardInfo then
        if p41.RewardInfo.Type == "Weapon" then
            RewardInfo = not table.find(ShopLibrary:GetReleasedOwnableWeapons(), p41.RewardData.Name);
        else
            RewardInfo = false;
        end;
    end;

    return RewardInfo;
end;

function u1._OnClick(p42) -- Line: 305
    if p42._on_click_callback then
        return p42._on_click_callback();
    end;

    p42:OpenBubble();
end;

function u1._GetLayerCollector(p43) -- Line: 313
    local Parent = p43.Frame.Parent;

    while Parent and not Parent:IsA("LayerCollector") do
        Parent = Parent.Parent;
    end;

    return Parent;
end;

function u1._UpdateBubblePosition(p44) -- Line: 323
    -- upvalues: UILibrary (copy)
    if not p44._bubble_frame.Parent then
        return;
    end;

    local v45 = p44:_GetLayerCollector();
    local v46;

    if v45 then
        v46 = v45:IsA("SurfaceGui");
    else
        v46 = v45;
    end;

    local v47, v48;

    if v46 then
        local v49 = v45.Adornee or v45.Parent;

        if v49:IsA("BasePart") then
            local v50 = workspace.CurrentCamera:WorldToScreenPoint(v49.Position);

            if v50.Z < 0 then
                v47 = -p44._bubble_frame.AbsoluteSize * 10;
            else
                v47 = UILibrary:ScreenPointToPosition(v50);
            end;
        else
            v47 = Vector2.new();
        end;

        v48 = Vector2.new();
    else
        v47 = p44.Frame.AbsolutePosition;
        v48 = p44.Frame.AbsoluteSize;
    end;

    local v51 = v47 - p44._bubble_frame.Parent.AbsolutePosition;
    local v52;

    if p44._open_bubble_upwards == true then
        v52 = false;
    else
        v52 = p44._open_bubble_upwards == false and true or v51.Y + v48.Y / 2 < p44._bubble_frame.Parent.AbsoluteSize.Y / 2;
    end;

    p44._bubble_frame.Position = UDim2.new(0, math.clamp(v51.X + v48.X / 2, p44._bubble_frame.AbsoluteSize.X / 2 + 10, p44._bubble_frame.Parent.AbsoluteSize.X - p44._bubble_frame.AbsoluteSize.X / 2 - 10), v46 and 0 or (v52 and 0.02 or -0.02), v51.Y + (not v52 and 0 or v48.Y));
    local _bubble_frame = p44._bubble_frame;
    local v53;

    if v52 then
        v53 = Vector2.new(0.5, 0);
    else
        v53 = Vector2.new(0.5, 1);
    end;

    _bubble_frame.AnchorPoint = v53;
    p44._bubble_frame.Arrow.Position = UDim2.new(0, math.clamp(v51.X + v48.X / 2 - (p44._bubble_frame.AbsolutePosition.X - p44._bubble_frame.Parent.AbsolutePosition.X), p44._bubble_frame.Arrow.AbsoluteSize.X * 0.875 + 10, p44._bubble_frame.AbsoluteSize.X - p44._bubble_frame.Arrow.AbsoluteSize.X * 0.875 - 10), v52 and 0 or 1, v52 and 2 or -2);
end;

function u1._Setup(u54) -- Line: 373
    -- upvalues: CosmeticSlot (copy), ItemLibrary (copy), Utility (copy), WeaponStatusHandler (copy), ButtonEffect (copy)
    if u54.CosmeticInfo then
        u54.CosmeticSlot = CosmeticSlot.new(u54.RewardData.Name, u54._is_locked, u54._ignore_button_effects);
        u54.CosmeticSlot:SetQuantity(u54.RewardData.Quantity);
        u54.CosmeticSlot.Frame.Parent = u54.Frame;
        u54.CosmeticSlot.Frame.Button.MouseButton1Click:Connect(function() -- Line: 379
            -- upvalues: u54 (copy)
            u54:_OnClick();
        end);
    elseif u54.RewardInfo then
        local v55 = ItemLibrary.Items[u54.RewardData.Name];
        local v56;

        if u54.RewardInfo.Type == "Weapon" then
            v56 = true;
        else
            v56 = u54.RewardInfo.PrioritizeNameOverQuantity and (u54.RewardData.Quantity or 1) == 1;
        end;

        u54.Frame.Reward.Visible = true;
        u54.Frame.Reward.Title.Text = v56 and u54.RewardInfo.DisplayName or "×" .. Utility:PrettyNumber(u54.RewardData.Quantity or 1);
        u54.Frame.Reward.Title.Size = v56 and UDim2.new(0.9, 0, 0.2, 0) or UDim2.new(0.9, 0, 0.4, 0);
        u54.Frame.Reward.Icon.Image = u54.RewardInfo.Image;
        u54.Frame.Reward.Icon.Size = UDim2.new(u54.RewardInfo.ImageScale, 0, u54.RewardInfo.ImageScale, 0);
        local NameStatus = u54.RewardInfo.NameStatus;

        if NameStatus then
            v55 = NameStatus;
        elseif v55 then
            v55 = v55.Status;
        end;

        WeaponStatusHandler:ApplyItemStatusToText(u54.Frame.Reward.Title, v55);
        u54.Frame.Reward.MouseButton1Click:Connect(function() -- Line: 394
            -- upvalues: u54 (copy)
            u54:_OnClick();
        end);

        if not u54._ignore_button_effects then
            ButtonEffect:Add(u54.Frame.Reward);
        end;
    else
        warn("reward_data = {");

        for i, v in pairs(u54.RewardData) do
            warn("\t", i, v);
        end;

        warn("}");
        assert(false, u54.RewardData.Name);
    end;

    u54:SetWeapon(u54.RewardData.Weapon);
end;

function u1._Init(p57) -- Line: 414
    p57:_Setup();
end;

return u1;