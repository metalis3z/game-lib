-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local StaticCharacterModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticCharacterModel);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel);
local CFrame_new_ret = CFrame.new(0, 0, 30);
local u1 = CFrame.new(0, -6, -6) * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.Angles(0.17453292519943295, 0, 0);
local u2 = CFrame.new(0, 0, -6) * CFrame.Angles(0, 2.356194490192345, 0) * CFrame.Angles(0.3490658503988659, 0, 0);
local u3 = CFrame.new(0, -10, -10) * CFrame.Angles(0, 2.356194490192345, 0) * CFrame.Angles(-0.7853981633974483, 0, 0);
local u4 = CFrame.new(0, 0, -10) * CFrame.Angles(0, 3.490658503988659, 0);
local u5 = {};
u5.__index = u5;

function u5.new(p6) -- Line: 22
    -- upvalues: u5 (copy), Signal (copy), Spring (copy)
    local v7 = setmetatable({}, u5);
    v7.CharmAttachmentVisibleChanged = Signal.new();
    v7.Equipment = p6;
    v7._last_generate_state = nil;
    v7._last_offset_state = nil;
    v7._static_viewmodel = nil;
    v7._static_charactermodel = nil;
    v7._last_equip_sound = nil;
    v7._offset_alpha_spring = Spring.new(1, 0.875, 10);
    v7:_Init();

    return v7;
end;

function u5.GetBoundingBox(p8) -- Line: 45
    if p8._static_viewmodel then
        return p8._static_viewmodel:GetBoundingBox();
    end;
end;

function u5.GetCharmPivotAttachment(p9) -- Line: 51
    local v10 = p9._static_viewmodel and p9._static_viewmodel:GetCharmPivotAttachment();

    return v10;
end;

function u5.Update(p11, p12) -- Line: 55
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    p11:_UpdateStaticModel(p12, p11._static_viewmodel, u1, u2);
    p11:_UpdateStaticModel(p12, p11._static_charactermodel, u3, u4);
end;

function u5.OnOpen(p13) -- Line: 60
    p13:_Generate();
end;

function u5.OnCustomizingStateChanged(p14) -- Line: 64
    p14:_Generate();
    p14:_UpdateViewModel();
end;

function u5.OnStateChanged(p15) -- Line: 69
    p15:_CheckOffsetAnimation();
    p15:_Generate();
end;

function u5._GetSelectedCosmeticOverride(p16, p17) -- Line: 78
    -- upvalues: CosmeticLibrary (copy), PlayerDataController (copy), Utility (copy)
    local SelectedCosmetic = p16.Equipment:GetSelectedCosmetic();
    local v18 = CosmeticLibrary.Cosmetics[SelectedCosmetic];

    if v18 and v18.Type == p17 then
        local CosmeticInverted = p16.Equipment.EquipmentState.CosmeticInverted;
        local WeaponData = PlayerDataController:GetWeaponData(p16.Equipment:GetSelectedWeapon());

        if WeaponData then
            WeaponData = WeaponData[p17];
        end;

        local v19 = Utility:CloneTable(WeaponData or {});
        v19.Name = SelectedCosmetic;

        if p17 ~= "Wrap" or CosmeticInverted == nil then
            CosmeticInverted = v19.Inverted;
        end;

        v19.Inverted = CosmeticInverted;

        return v19;
    end;
end;

function u5._GetViewModelName(p20) -- Line: 97
    -- upvalues: PlayerDataController (copy)
    local SelectedWeapon = p20.Equipment:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);
    local v21 = p20:_GetSelectedCosmeticOverride("Skin");
    local v22 = v21 and v21.Name;

    if v22 then
        SelectedWeapon = v22;
    elseif WeaponData and (WeaponData.Skin and WeaponData.Skin.Name ~= "RANDOM_COSMETIC") then
        SelectedWeapon = WeaponData.Skin.Name or SelectedWeapon;
    end;

    return SelectedWeapon;
end;

function u5._CheckOffsetAnimation(p23) -- Line: 108
    local StateID = p23.Equipment:GetStateID(true);

    if StateID == p23._last_offset_state then
        return;
    end;

    p23._last_offset_state = StateID;
    p23._offset_alpha_spring.Value = 0;
end;

function u5._UpdateStaticModel(p24, p25, p26, p27, p28) -- Line: 119
    -- upvalues: CFrame_new_ret (copy)
    if not p26 then
        return;
    end;

    local v29 = p27:Lerp(p28, p24._offset_alpha_spring.Value);
    local v30 = p24.Equipment.Scene:GetCFrame() * CFrame_new_ret * v29;
    local CustomizingType = p24.Equipment:GetCustomizingType();
    p26:PivotTo(CFrame.new(v30.Position) * p24.Equipment.SpinControls:GetCFrame() * v30.Rotation + ((CustomizingType == "Finisher" and true or CustomizingType == "Emote") and Vector3.new(0, -25, 0) or Vector3.new(0, 0, 0)));
    p26:Update(p25);
end;

function u5._PlayEquipSound(u31) -- Line: 140
    -- upvalues: Utility (copy), SoundLibrary (copy)
    task.defer(function() -- Line: 142
        -- upvalues: u31 (copy), Utility (ref), SoundLibrary (ref)
        if not (u31.Equipment.IsOpen and u31.Equipment.Camera:IsOpenEffectDone()) then
            return;
        end;

        if u31._last_equip_sound then
            u31._last_equip_sound:Destroy();
            u31._last_equip_sound = nil;
        end;

        u31._last_equip_sound = Utility:CreateSound(SoundLibrary.EquipSounds[math.random(#SoundLibrary.EquipSounds)], 0.5, 0.9 + 0.2 * math.random(), script, true, 5);
    end);
end;

function u5._UpdateViewModel(p32) -- Line: 156
    -- upvalues: PlayerDataController (copy)
    if not (p32._static_viewmodel and p32.Equipment.IsOpen) then
        return;
    end;

    local WeaponData = PlayerDataController:GetWeaponData(p32._static_viewmodel.WeaponName);
    local v33 = p32:_GetSelectedCosmeticOverride("Charm");
    local v34 = p32:_GetSelectedCosmeticOverride("Wrap");
    p32._static_viewmodel:SetLocked(not WeaponData);

    if not v33 then
        if WeaponData and (WeaponData.Charm and WeaponData.Charm.Name ~= "RANDOM_COSMETIC") then
            v33 = WeaponData.Charm or nil;
        else
            v33 = nil;
        end;
    end;

    p32._static_viewmodel:SetCharm(v33);

    if not v34 then
        if WeaponData and (WeaponData.Wrap and WeaponData.Wrap.Name ~= "RANDOM_COSMETIC") then
            v34 = WeaponData.Wrap or nil;
        else
            v34 = nil;
        end;
    end;

    p32._static_viewmodel:SetWrap(v34);
end;

function u5._GenerateViewModel(p35) -- Line: 170
    -- upvalues: StaticViewModel (copy)
    if p35._static_viewmodel then
        p35._static_viewmodel:Destroy();
        p35._static_viewmodel = nil;
    end;

    local v36 = p35:_GetViewModelName();

    if not (v36 and p35.Equipment.IsOpen) then
        return;
    end;

    p35._static_viewmodel = StaticViewModel.new(v36);
    p35._static_viewmodel:DeleteAnimationContextSubModels("ShowInEquipment");
    p35._static_viewmodel:SetParent(workspace);
    p35:_UpdateForcedVisibleCharmAttachment();
    p35:_UpdateViewModel();
    p35:_PlayEquipSound();
end;

function u5._GenerateCharacterModel(p37) -- Line: 191
    -- upvalues: StaticCharacterModel (copy), Players (copy)
    if p37._static_charactermodel then
        p37._static_charactermodel:Destroy();
        p37._static_charactermodel = nil;
    end;

    if not (p37.Equipment:IsCareerPageOpen() and p37.Equipment.IsOpen) then
        return;
    end;

    p37._static_charactermodel = StaticCharacterModel.new(Players.LocalPlayer.UserId);
    p37._static_charactermodel:SetParent(workspace);
    p37:_PlayEquipSound();
end;

function u5._Generate(p38) -- Line: 207
    if not p38.Equipment.IsOpen then
        if p38._static_viewmodel then
            p38._static_viewmodel:Destroy();
            p38._static_viewmodel = nil;
        end;

        if p38._static_charactermodel then
            p38._static_charactermodel:Destroy();
            p38._static_charactermodel = nil;
        end;

        p38._last_generate_state = nil;

        return;
    end;

    local v39 = p38:_GetViewModelName();
    local v40 = p38.Equipment:GetStateID(true) .. tostring(v39);

    if v40 == p38._last_generate_state then
        return;
    end;

    p38._last_generate_state = v40;
    p38:_GenerateViewModel();
    p38:_GenerateCharacterModel();
    p38:Update(0);
end;

function u5._UpdateForcedVisibleCharmAttachment(p41) -- Line: 237
    if not p41._static_viewmodel then
        return;
    end;

    p41._static_viewmodel:ForceCharmAttachmentModelVisible(p41.Equipment:GetCustomizingType() == "Charm");
    p41.CharmAttachmentVisibleChanged:Fire();
end;

function u5._Init(u42) -- Line: 246
    -- upvalues: PlayerDataController (copy)
    u42.Equipment.CustomizingChanged:Connect(function() -- Line: 247
        -- upvalues: u42 (copy)
        u42:_UpdateForcedVisibleCharmAttachment();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 251
        -- upvalues: u42 (copy)
        u42:_Generate();
        u42:_UpdateViewModel();
    end);
    u42:_Generate();
    u42:_UpdateForcedVisibleCharmAttachment();
end;

return u5;