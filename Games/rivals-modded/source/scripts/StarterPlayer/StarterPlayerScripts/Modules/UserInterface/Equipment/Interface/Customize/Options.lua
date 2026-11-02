-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Customize = p2;
    v3.Frame = v3.Customize.BottomContainer:WaitForChild("Options");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3:_Init();

    return v3;
end;

function u1.OnCustomizingStateChanged(p4) -- Line: 29
    p4:_Update();
end;

function u1.OnStateChanged(p5) -- Line: 33
    p5:_Update();
end;

function u1._UpdateBackground(p6) -- Line: 41
    p6.Background.Size = UDim2.new(0, p6.Layout.AbsoluteContentSize.X, 1, 0);
    p6.Background.Visible = p6.Layout.AbsoluteContentSize.X > 1;
end;

function u1._OnOptionClicked(p7, p8, p9) -- Line: 46
    -- upvalues: ButtonEffect (copy)
    local Button = p7.Container:WaitForChild(p8):WaitForChild("Container"):WaitForChild("Button");
    Button.MouseButton1Click:Connect(p9);
    ButtonEffect:Add(Button);
end;

function u1._SetOption(p10, p11, p12, p13) -- Line: 52
    local v14 = p10.Container:WaitForChild(p11);
    local Button = v14:WaitForChild("Container"):WaitForChild("Button");
    local Empty = Button:WaitForChild("Empty");
    local Filled = Button:WaitForChild("Filled");
    v14.Visible = p12;
    Filled.Visible = p13;
    Empty.Visible = not p13;
end;

function u1._Update(p15) -- Line: 63
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy)
    if not p15.Customize.Interface.Equipment.IsOpen then
        return;
    end;

    local SelectedWeapon = p15.Customize.Interface.Equipment:GetSelectedWeapon();
    local SelectedCosmetic = p15.Customize.Interface.Equipment:GetSelectedCosmetic();
    local CustomizingType = p15.Customize.Interface.Equipment:GetCustomizingType();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);
    local v16;

    if WeaponData then
        if SelectedCosmetic then
            v16 = CosmeticLibrary:OwnsCosmetic(PlayerDataController:Get("CosmeticInventory"), SelectedCosmetic, SelectedWeapon);
        else
            v16 = SelectedCosmetic;
        end;
    else
        v16 = WeaponData;
    end;

    local v17 = PlayerDataController:Get("FavoritedCosmetics");
    local v18 = not SelectedCosmetic and CustomizingType and "NONE_COSMETIC" or SelectedCosmetic;
    local v19 = v16 or v18 == "NONE_COSMETIC";
    local v20 = v19 and v17[SelectedWeapon] and v17[SelectedWeapon][CosmeticLibrary:GetNoneSpecificCosmeticName(v18, CustomizingType)];
    p15:_SetOption("Favorited", v19, v20);
    local v21;

    if CustomizingType == "Wrap" then
        if SelectedCosmetic then
            v21 = SelectedCosmetic ~= "RANDOM_COSMETIC";
        else
            v21 = SelectedCosmetic;
        end;
    else
        v21 = false;
    end;

    local v22;

    if p15.Customize.Interface.Equipment.EquipmentState.CosmeticInverted == nil then
        v22 = WeaponData and WeaponData.Wrap and WeaponData.Wrap.Inverted;
    else
        v22 = p15.Customize.Interface.Equipment.EquipmentState.CosmeticInverted;
    end;

    p15:_SetOption("Inverted", v21, v22);
    local v23 = SelectedCosmetic == "RANDOM_COSMETIC";
    p15:_SetOption("OnlyUseFavorites", v23, v23 and (WeaponData and WeaponData[CustomizingType]) and WeaponData[CustomizingType].OnlyUseFavorites);
end;

function u1._Init(u24) -- Line: 90
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy), ReplicatedStorage (copy)
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 91
        -- upvalues: u24 (copy)
        u24:_UpdateBackground();
    end);
    u24:_OnOptionClicked("Favorited", function() -- Line: 95
        -- upvalues: u24 (copy), PlayerDataController (ref), CosmeticLibrary (ref), ReplicatedStorage (ref)
        local SelectedWeapon = u24.Customize.Interface.Equipment:GetSelectedWeapon();
        local SelectedCosmetic = u24.Customize.Interface.Equipment:GetSelectedCosmetic();
        local CustomizingType = u24.Customize.Interface.Equipment:GetCustomizingType();
        local v25 = PlayerDataController:Get("FavoritedCosmetics");
        local v26 = SelectedCosmetic or "NONE_COSMETIC";
        local v27 = v25[SelectedWeapon] and v25[SelectedWeapon][CosmeticLibrary:GetNoneSpecificCosmeticName(v26, CustomizingType)];
        local v28;

        if v26 == "NONE_COSMETIC" then
            v28 = u24.Customize.Interface.Equipment:GetCustomizingType();
        else
            v28 = nil;
        end;

        ReplicatedStorage.Remotes.Data.FavoriteCosmetic:FireServer(SelectedWeapon, v26, not v27, v28);
    end);
    u24:_OnOptionClicked("Inverted", function() -- Line: 109
        -- upvalues: u24 (copy), PlayerDataController (ref), CosmeticLibrary (ref), ReplicatedStorage (ref)
        local SelectedWeapon = u24.Customize.Interface.Equipment:GetSelectedWeapon();
        local SelectedCosmetic = u24.Customize.Interface.Equipment:GetSelectedCosmetic();
        local CustomizingType = u24.Customize.Interface.Equipment:GetCustomizingType();
        local CosmeticInverted = u24.Customize.Interface.Equipment.EquipmentState.CosmeticInverted;
        local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

        if WeaponData then
            if SelectedCosmetic then
                SelectedCosmetic = CosmeticLibrary:OwnsCosmetic(PlayerDataController:Get("CosmeticInventory"), SelectedCosmetic, SelectedWeapon);
            end;
        else
            SelectedCosmetic = WeaponData;
        end;

        if CosmeticInverted == nil then
            CosmeticInverted = WeaponData and WeaponData.Wrap and WeaponData.Wrap.Inverted;
        end;

        local v29 = not CosmeticInverted;
        u24.Customize.Interface.Equipment.EquipmentState:SetCosmeticInvertedState(v29);

        if SelectedCosmetic then
            ReplicatedStorage.Remotes.Data.EquipCosmetic:FireServer(SelectedWeapon, CustomizingType, WeaponData.Wrap.Name, {
                IsInverted = v29
            });
        end;
    end);
    u24:_OnOptionClicked("OnlyUseFavorites", function() -- Line: 127
        -- upvalues: u24 (copy), PlayerDataController (ref), ReplicatedStorage (ref)
        local SelectedWeapon = u24.Customize.Interface.Equipment:GetSelectedWeapon();
        local CustomizingType = u24.Customize.Interface.Equipment:GetCustomizingType();
        local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);
        ReplicatedStorage.Remotes.Data.EquipCosmetic:FireServer(SelectedWeapon, CustomizingType, WeaponData[CustomizingType].Name, {
            OnlyUseFavorites = not WeaponData[CustomizingType].OnlyUseFavorites
        });
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 138
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    PlayerDataController:GetDataChangedSignal("CosmeticInventory"):Connect(function() -- Line: 142
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    PlayerDataController:GetDataChangedSignal("FavoritedCosmetics"):Connect(function() -- Line: 146
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24:_UpdateBackground();
end;

return u1;