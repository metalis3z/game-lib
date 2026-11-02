-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local UnlockedCosmeticWeaponSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("UnlockedCosmeticWeaponSlot");
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: Prompt (copy), u1 (copy), CosmeticLibrary (copy)
    local v3 = Prompt.new(script.Name);
    local v4 = setmetatable(v3, u1);
    v4.CloseButton = v4.PromptFrame:WaitForChild("Close");
    v4.TitleText = v4.PromptFrame:WaitForChild("Title");
    v4.List = v4.PromptFrame:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4._cosmetic_name = p2;
    v4._cosmetic_info = CosmeticLibrary.Cosmetics[v4._cosmetic_name];
    v4._slots = {};
    v4:_Init();

    return v4;
end;

function u1._IsEquipped(p5, p6) -- Line: 46
    -- upvalues: PlayerDataController (copy)
    local WeaponData = PlayerDataController:GetWeaponData(p6);

    return WeaponData and WeaponData[p5._cosmetic_info.Type] and WeaponData[p5._cosmetic_info.Type].Name == p5._cosmetic_name;
end;

function u1._UpdateEquipped(p7) -- Line: 53
    for i, v in pairs(p7._slots) do
        v.Button.Equipped.Visible = p7:_IsEquipped(i);
    end;
end;

function u1._Setup(u8) -- Line: 59
    -- upvalues: PlayerDataController (copy), ShopLibrary (copy), CONSTANTS (copy), ItemLibrary (copy), CosmeticLibrary (copy), UnlockedCosmeticWeaponSlot (copy), ButtonEffect (copy), WeaponStatusHandler (copy), ReplicatedStorage (copy)
    u8.TitleText.Text = u8._cosmetic_name .. " " .. u8._cosmetic_info.Type;
    local v9 = PlayerDataController:Get("CosmeticInventory");

    for i, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET, ShopLibrary.OwnableWeaponsAlphabetized)) do
        local v10 = ItemLibrary.Items[v];

        if u8._cosmetic_info.Type ~= "Finisher" or v10.CanEliminate then
            local WeaponData = PlayerDataController:GetWeaponData(v);
            local u11 = CosmeticLibrary:OwnsCosmetic(v9, u8._cosmetic_name, v);
            local u12 = UnlockedCosmeticWeaponSlot:Clone();
            u12.LayoutOrder = i + (u11 and 0 or 999999);
            u12.Button.Icon.Image = v10.Image;
            u12.Button.Icon.ImageColor3 = not WeaponData and Color3.fromRGB(32, 32, 32) or (not u11 and Color3.fromRGB(32, 32, 32) or Color3.fromRGB(255, 255, 255));
            u12.Button.Title.Visible = WeaponData ~= nil;
            u12.Button.Title.Text = v;
            u12.Button.Title.TextTransparency = u11 and 0 or 0.875;
            u12.Button.Locked.Visible = not WeaponData;
            u12.ZIndex = WeaponData and (u11 and 2 or 1) or 0;
            u12.Parent = u8.Container;
            u8._slots[v] = u12;
            ButtonEffect:Add(u12.Button);
            WeaponStatusHandler:ApplyItemStatusToText(u12.Button.Title, ItemLibrary.Items[v].Status);
            u12.Button.MouseButton1Click:Connect(function() -- Line: 88
                -- upvalues: u11 (copy), ReplicatedStorage (ref), v (copy), u8 (copy), PlayerDataController (ref)
                if not u11 then
                    return;
                end;

                local EquipCosmetic = ReplicatedStorage.Remotes.Data.EquipCosmetic;
                local Type = u8._cosmetic_info.Type;
                local v13;

                if u8:_IsEquipped(v) then
                    v13 = nil;
                else
                    v13 = u8._cosmetic_name;
                end;

                EquipCosmetic:FireServer(v, Type, v13);
                PlayerDataController:SilenceCosmeticNotification(u8._cosmetic_name, v);
            end);
            local u14 = false;
            u12.Button.MouseEnter:Connect(function() -- Line: 99, Name: hover
                -- upvalues: u14 (ref), u12 (copy)
                if u14 then
                    return;
                end;

                u14 = true;
                local v15 = u12;
                v15.ZIndex = v15.ZIndex + 10;
            end);
            u12.Button.MouseLeave:Connect(function() -- Line: 110, Name: unhover
                -- upvalues: u14 (ref), u12 (copy)
                if not u14 then
                    return;
                end;

                u14 = false;
                local v16 = u12;
                v16.ZIndex = v16.ZIndex - 10;
            end);
        end;
    end;
end;

function u1._Init(u17) -- Line: 123
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u17.CloseButton.MouseButton1Click:Connect(function() -- Line: 124
        -- upvalues: u17 (copy)
        u17:CloseRequest();
    end);
    u17.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 128
        -- upvalues: u17 (copy)
        u17.List.CanvasSize = UDim2.new(0, 0, 0, u17.Layout.AbsoluteContentSize.Y);
    end);
    local _connections = u17._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("WeaponInventory");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 132
        -- upvalues: u17 (copy)
        u17:_UpdateEquipped();
    end));
    u17:_Setup();
    u17:_UpdateEquipped();
    ButtonEffect:Add(u17.CloseButton);
end;

return u1;