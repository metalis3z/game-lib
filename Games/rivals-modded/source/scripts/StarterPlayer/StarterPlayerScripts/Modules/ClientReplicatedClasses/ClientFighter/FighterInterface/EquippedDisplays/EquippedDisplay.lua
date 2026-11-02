-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local InfiniteParticles = require(Players.LocalPlayer.PlayerScripts.Modules.InfiniteParticles);
require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local EquippedDisplay = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquippedDisplay");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 17
    -- upvalues: u1 (copy), EquippedDisplay (copy), InfiniteParticles (copy)
    local v4 = setmetatable({}, u1);
    v4.EquippedDisplays = p2;
    v4.ClientItem = p3;
    v4.Frame = EquippedDisplay:Clone();
    v4.Container = v4.Frame:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.WeaponFrame = v4.Container:WaitForChild("Weapon");
    v4.WeaponIcon = v4.WeaponFrame:WaitForChild("Icon");
    v4.DetailsFrame = v4.Container:WaitForChild("Details");
    v4.NameContainer = v4.DetailsFrame:WaitForChild("NameContainer");
    v4.ItemNameText = v4.NameContainer:WaitForChild("Title");
    v4.AmmoContainer = v4.DetailsFrame:WaitForChild("AmmoContainer");
    v4.AmmoLayout = v4.AmmoContainer:WaitForChild("Layout");
    v4.AmmoFrame = v4.AmmoContainer:WaitForChild("Ammo");
    v4.AmmoText = v4.AmmoFrame:WaitForChild("Title");
    v4.AmmoReserveFrame = v4.AmmoContainer:WaitForChild("Reserve");
    v4.AmmoReserveText = v4.AmmoReserveFrame:WaitForChild("Title");
    v4.AmmoIconFrame = v4.AmmoContainer:WaitForChild("Icon");
    v4.AmmoIcon = v4.AmmoIconFrame:WaitForChild("Icon");
    v4._connections = {};
    v4._infinite_particles = InfiniteParticles.new(v4.AmmoText, v4.AmmoReserveText);
    v4:_Init();

    return v4;
end;

function u1.UpdateParent(u5) -- Line: 51
    -- upvalues: PlayerDataController (copy)
    task.defer(pcall, function() -- Line: 52
        -- upvalues: PlayerDataController (ref), u5 (copy)
        local v6 = PlayerDataController:GetSetting("Equipped Weapon Display") == "Legacy";
        local v7;

        if PlayerDataController:GetSetting("Equipped Weapon Display") == "Bottom Left" then
            v7 = true;
        elseif v6 then
            v7 = PlayerDataController:GetSetting("Hotbar Display") == "Bottom Left";
        else
            v7 = v6;
        end;

        u5.WeaponFrame.Visible = PlayerDataController:GetSetting("Equipped Weapon Icon");
        u5.AmmoContainer.Visible = PlayerDataController:GetSetting("Equipped Weapon Ammo");
        u5.DetailsFrame.LayoutOrder = v7 and 2 or 0;
        u5.AmmoContainer.AnchorPoint = v7 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
        u5.AmmoContainer.Position = v7 and UDim2.new(0.075, 0, 0.28, 0) or UDim2.new(0.925, 0, 0.28, 0);
        u5.NameContainer.AnchorPoint = v7 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
        u5.NameContainer.Position = v7 and UDim2.new(0.05, 0, 0.75, 0) or UDim2.new(0.95, 0, 0.75, 0);
        u5.ItemNameText.AnchorPoint = v7 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
        u5.ItemNameText.Position = v7 and UDim2.new(0, 0, 0.5, 0) or UDim2.new(1, 0, 0.5, 0);
        u5.ItemNameText.TextXAlignment = v7 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right;
        u5.AmmoLayout.HorizontalAlignment = v7 and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right;
        u5.Layout.HorizontalAlignment = v7 and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right;
        u5.Frame.Parent = v6 and u5.EquippedDisplays.FighterInterface.Hotbar.EquippedDisplayFrame or (v7 and u5.EquippedDisplays.FighterInterface.BottomLeft.Container or u5.EquippedDisplays.FighterInterface.BottomRight.Container);
        u5:_UpdateSize();
    end);
end;

function u1.UpdateVisibility(p8) -- Line: 74
    -- upvalues: PlayerDataController (copy)
    local Frame = p8.Frame;
    local v9 = p8.ClientItem:IsMainItem() and PlayerDataController:GetSetting("Equipped Weapon Display") ~= "Disabled";
    Frame.Visible = v9;
end;

function u1.UpdateAmmo(p10) -- Line: 78
    local AmmoVariables, v11, v12, v13 = p10.ClientItem:GetAmmoVariables();
    local v14 = p10.ClientItem:IsMainItem();
    p10.AmmoReserveText.Text = v11 and (v13 and "∞" or (AmmoVariables and (" " .. v11 or "") or "")) or "";
    p10.AmmoReserveText.TextColor3 = v11 and v11 <= 0 and Color3.fromRGB(255, 50, 50) or (v14 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0));
    p10.AmmoText.Text = v12 and "∞" or (AmmoVariables or "");
    p10.AmmoText.TextColor3 = AmmoVariables and AmmoVariables <= 0 and Color3.fromRGB(255, 50, 50) or (v14 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0));
    p10.AmmoIcon.Visible = AmmoVariables ~= nil;
    p10.AmmoIcon.ImageColor3 = v11 and p10.AmmoReserveText.TextColor3 or p10.AmmoText.TextColor3;
    p10.AmmoIcon.ImageTransparency = v11 and p10.AmmoReserveText.TextTransparency or p10.AmmoText.TextTransparency;
    p10._infinite_particles:SetActive(v12, v13);
    p10:_UpdateSize();
end;

function u1.UpdateVisuals(p15) -- Line: 99
    local v16 = p15.ClientItem:IsMainItem();
    p15.ItemNameText.TextColor3 = v16 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    p15.ItemNameText.TextTransparency = v16 and 0 or 0.7;
    p15.AmmoText.TextTransparency = v16 and 0 or 0.7;
    p15.AmmoReserveText.TextTransparency = v16 and 0 or 0.7;
    p15:UpdateAmmo();
    p15:UpdateVisibility();
    p15:_UpdateSize();
end;

function u1.Update(p17, p18, p19) -- Line: 113
    p17._infinite_particles:Update(p18);
end;

function u1.Destroy(p20) -- Line: 117
    p20._infinite_particles:Destroy();

    for _, v in pairs(p20._connections) do
        v:Disconnect();
    end;

    p20.Frame:Destroy();
end;

function u1._UpdateSize(p21) -- Line: 131
    -- upvalues: PlayerDataController (copy)
    local v22 = PlayerDataController:GetSetting("Equipped Weapon Display") == "Legacy" and 1 or 0.275;
    local v23 = p21.ClientItem:IsMainItem() and 1 or 0.5;
    p21.Frame.Size = UDim2.new(v22 * v23, 0, v22 * v23 * (p21.AmmoIcon.Visible and 1 or 0.5), 0);
end;

function u1._UpdateLayouts(p24) -- Line: 139
    p24.AmmoFrame.Size = UDim2.new(0, p24.AmmoText.TextBounds.X, 1, 0);
    p24.AmmoReserveFrame.Size = UDim2.new(0, p24.AmmoReserveText.TextBounds.X, 1, 0);
end;

function u1._Setup(p25) -- Line: 144
    -- upvalues: ItemLibrary (copy), WeaponStatusHandler (copy)
    p25.WeaponIcon.Image = p25.ClientItem.ViewModel:GetImage();
    p25.AmmoIcon.Image = p25.ClientItem.Info.AmmoType and (ItemLibrary.Ammos[p25.ClientItem.Info.AmmoType].Image or "") or "";
    p25.ItemNameText.Text = p25.ClientItem.Name;
    p25.NameContainer.ClipsDescendants = false;
    WeaponStatusHandler:ApplyItemStatusToText(p25.ItemNameText, p25.ClientItem.Info.Status);
end;

function u1._Init(u26) -- Line: 156
    u26.AmmoText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 157
        -- upvalues: u26 (copy)
        u26:_UpdateLayouts();
    end);
    u26.AmmoReserveText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 161
        -- upvalues: u26 (copy)
        u26:_UpdateLayouts();
    end);
    local _connections = u26._connections;
    local DataChangedSignal = u26.ClientItem:GetDataChangedSignal("Ammo");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 165
        -- upvalues: u26 (copy)
        u26:UpdateAmmo();
    end));
    local _connections2 = u26._connections;
    local DataChangedSignal2 = u26.ClientItem:GetDataChangedSignal("AmmoReserve");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 169
        -- upvalues: u26 (copy)
        u26:UpdateAmmo();
    end));
    table.insert(u26._connections, u26.ClientItem.EquippedChanged:Connect(function() -- Line: 173
        -- upvalues: u26 (copy)
        u26:UpdateVisuals();
    end));
    u26:_Setup();
    u26:_UpdateLayouts();
    u26:UpdateAmmo();
    u26:UpdateVisuals();
    u26:UpdateVisibility();
    u26:UpdateParent();
end;

return u1;