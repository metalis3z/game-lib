-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Spring = require(ReplicatedStorage.Modules.Spring);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local InfiniteParticles = require(Players.LocalPlayer.PlayerScripts.Modules.InfiniteParticles);
local HotbarCooldownSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("HotbarCooldownSlot");
local HotbarSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("HotbarSlot");
local u1 = { "EquipPrimary", "EquipSecondary", "EquipMelee", "EquipUtility" };
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(127, 0, 0);
local u2 = {};
u2.__index = u2;

function u2.new(p3, p4) -- Line: 22
    -- upvalues: u2 (copy), Signal (copy), HotbarSlot (copy), Spring (copy), InfiniteParticles (copy)
    local v5 = setmetatable({}, u2);
    v5.Clicked = Signal.new();
    v5.CooldownsChanged = Signal.new();
    v5.Hotbar = p3;
    v5.ClientItem = p4;
    v5.Frame = HotbarSlot:Clone();
    v5.Background = v5.Frame:WaitForChild("Background");
    v5.Button = v5.Frame:WaitForChild("Button");
    v5.Icon = v5.Frame:WaitForChild("Icon");
    v5.CooldownsFrame = v5.Frame:WaitForChild("Cooldowns");
    v5.MouseKeyboardInputKeybind = v5.Frame:WaitForChild("Inputs"):WaitForChild("MouseKeyboard"):WaitForChild("Keybind");
    v5.AmmoFrame = v5.Frame:WaitForChild("Ammo");
    v5.AmmoTitle = v5.AmmoFrame:WaitForChild("Title");
    v5.AmmoIcon = v5.AmmoFrame:WaitForChild("Icon");
    v5._connections = {};
    v5._item_slot_rotation_spring = Spring.new(0, 1, 20);
    v5._item_slot_position_spring = Spring.new(0, 0.75, 20);
    v5._item_slot_color_spring = Spring.new(0, 1, 10);
    v5._infinite_particles = InfiniteParticles.new(v5.AmmoTitle);
    v5._num_cooldowns_active = 0;
    v5:_Init();

    return v5;
end;

function u2.GetNumCooldownsActive(p6) -- Line: 56
    return p6._num_cooldowns_active;
end;

function u2.EquipEffect(p7) -- Line: 60
    p7._item_slot_position_spring.Velocity = -10;
end;

function u2.RollEffect(p8) -- Line: 64
    p8._item_slot_position_spring.Velocity = -40;
    local _item_slot_rotation_spring = p8._item_slot_rotation_spring;
    _item_slot_rotation_spring.Target = _item_slot_rotation_spring.Target + 360;
end;

function u2.UpdateAmmo(p9) -- Line: 69
    -- upvalues: PlayerDataController (copy)
    local AmmoVariables, v10, v11, v12 = p9.ClientItem:GetAmmoVariables();
    local Setting = PlayerDataController:GetSetting("Hotbar Slot Ammo");
    local v13 = AmmoVariables and AmmoVariables <= 0 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255);
    local v14 = v12 and "∞" or (v10 or "");
    local v15 = v10 and v10 <= 0 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255);
    p9.AmmoFrame.Visible = AmmoVariables and Setting;
    p9.AmmoTitle.Text = string.format("<font color=\"%s\">%s</font>", AmmoVariables and AmmoVariables <= 0 and "rgb(255,50,50)" or "rgb(255,255,255)", v11 and "∞" or (AmmoVariables or "")) .. (v14 == "" and "" or string.format("<font size=\"8\" color=\"%s\"> %s</font>", v10 and v10 <= 0 and "rgb(255,50,50)" or "rgb(255,255,255)", v14));

    if v10 then
        v13 = v15 or v13;
    end;

    p9.AmmoIcon.ImageColor3 = v13;
    p9._infinite_particles:SetActive(v11, v12);
end;

function u2.UpdateVisuals(p16) -- Line: 88
    -- upvalues: u1 (copy)
    local v17 = p16.ClientItem:IsMainItem();
    local v18 = p16.ClientItem:Get("ItemIndex");
    local v19 = p16.ClientItem.ClientFighter.IsLocalPlayer and u1[v18];
    p16.Frame.ZIndex = v17 and 999 or v18;
    p16.Frame.LayoutOrder = v18;
    p16.Frame.Size = v17 and UDim2.new(1, 0, 1, 0) or UDim2.new(0.75, 0, 0.75, 0);
    local v20;

    if v18 % 2 == 0 then
        v20 = v17 and "rbxassetid://13220167337" or "rbxassetid://13188242287";
    else
        v20 = v17 and "rbxassetid://13220167472" or "rbxassetid://13188242420";
    end;

    p16.Background.Image = v20;
    p16.Background.ImageTransparency = v17 and 0 or 0.7;
    p16.MouseKeyboardInputKeybind.Visible = false;
    p16.MouseKeyboardInputKeybind:SetAttribute("InputName", v19);
end;

function u2.UpdateVisibility(p21) -- Line: 102
    -- upvalues: ControlsController (copy)
    p21.Frame.Visible = ControlsController.CurrentControls ~= "Touch" and true or not p21.Hotbar.FighterInterface.ClientFighter.IsLocalPlayer;
end;

function u2.Update(p22, p23, p24) -- Line: 106
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    p22.Icon.Rotation = p22._item_slot_rotation_spring.Value;
    p22.Icon.Position = UDim2.new(0.5, 0, 0.5 + p22._item_slot_position_spring.Value, 0);
    p22.Icon.ImageColor3 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, 1 - (1 - p22._item_slot_color_spring.Value) ^ 2);
    p22._infinite_particles:Update(p23);
end;

function u2.Destroy(p25) -- Line: 114
    p25._infinite_particles:Destroy();

    for _, v in pairs(p25._connections) do
        v:Disconnect();
    end;

    p25.CooldownsChanged:Destroy();
    p25.Clicked:Destroy();
    p25.Frame:Destroy();
end;

function u2._EquipFailedEffect(p26) -- Line: 130
    p26._item_slot_position_spring.Value = 0.25;
    p26._item_slot_color_spring.Value = 1;
    p26.Hotbar.FighterInterface:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
end;

function u2._CooldownEffect(u27, p28) -- Line: 136
    -- upvalues: HotbarCooldownSlot (copy), BetterDebris (copy), TweenService (copy)
    if p28.IsReversed then
        return;
    end;

    local Variables, v29, v30 = p28.GetVariables();
    local v31 = HotbarCooldownSlot:Clone();
    v31.Icon.Image = p28.Image;
    v31.Bar.Bar.Size = UDim2.new(v29, 0, 1.5, 0);
    v31.Parent = u27.CooldownsFrame;
    table.insert(p28.Cleanup, v31);
    BetterDebris:AddItem(v31, Variables);
    TweenService:Create(v31.Bar.Bar, TweenInfo.new(Variables, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        Size = UDim2.new(v30, 0, 1.5, 0)
    }):Play();
    u27._num_cooldowns_active = u27._num_cooldowns_active + 1;
    u27.CooldownsChanged:Fire();
    task.delay(Variables, function() -- Line: 155
        -- upvalues: u27 (copy)
        local v32 = u27;
        v32._num_cooldowns_active = v32._num_cooldowns_active - 1;
        u27.CooldownsChanged:Fire();
    end);
end;

function u2._Setup(p33) -- Line: 161
    -- upvalues: ItemLibrary (copy)
    p33.Frame.Name = p33.ClientItem.Name;
    p33.Icon.Image = p33.ClientItem.ViewModel:GetImage();
    p33.AmmoIcon.Image = p33.ClientItem.Info.AmmoType and ItemLibrary.Ammos[p33.ClientItem.Info.AmmoType].Image or "";
end;

function u2._Init(u34) -- Line: 167
    u34.Button.MouseButton1Click:Connect(function() -- Line: 168
        -- upvalues: u34 (copy)
        u34.Clicked:Fire();
    end);
    local _connections = u34._connections;
    local DataChangedSignal = u34.ClientItem:GetDataChangedSignal("Ammo");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 172
        -- upvalues: u34 (copy)
        u34:UpdateAmmo();
    end));
    local _connections2 = u34._connections;
    local DataChangedSignal2 = u34.ClientItem:GetDataChangedSignal("AmmoReserve");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 176
        -- upvalues: u34 (copy)
        u34:UpdateAmmo();
    end));
    local _connections3 = u34._connections;
    local DataChangedSignal3 = u34.ClientItem:GetDataChangedSignal("ItemIndex");
    table.insert(_connections3, DataChangedSignal3:Connect(function() -- Line: 180
        -- upvalues: u34 (copy)
        u34:UpdateVisuals();
    end));
    table.insert(u34._connections, u34.ClientItem.EquipFailedEffect:Connect(function(p35) -- Line: 184
        -- upvalues: u34 (copy)
        u34:_EquipFailedEffect();
    end));
    table.insert(u34._connections, u34.ClientItem.Cooldowns.CooldownAdded:Connect(function(p36) -- Line: 188
        -- upvalues: u34 (copy)
        u34:_CooldownEffect(p36);
    end));

    for _, v in pairs(u34.ClientItem.Cooldowns.Cooldowns) do
        task.spawn(u34._CooldownEffect, u34, v);
    end;

    u34:_Setup();
    u34:UpdateVisuals();
    u34:UpdateVisibility();
    u34:UpdateAmmo();
end;

return u2;