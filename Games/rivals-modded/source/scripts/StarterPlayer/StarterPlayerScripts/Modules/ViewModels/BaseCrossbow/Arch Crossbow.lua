-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ViewModelParticlesLogic = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModelParticlesLogic);
local BaseCrossbow = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseCrossbow);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(8, 255, 152));
local u1 = setmetatable({}, BaseCrossbow);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: BaseCrossbow (copy), u1 (copy), ViewModelParticlesLogic (copy)
    local v2 = BaseCrossbow.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ShouldPlayReloadAnimationInstantly = true;
    v3._particles_logic = ViewModelParticlesLogic.new(v3);
    v3._is_empty = nil;
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 28
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.Unequip(p5, ...) -- Line: 32
    -- upvalues: BaseCrossbow (copy)
    p5._particles_logic:CancelEffect();
    BaseCrossbow.Unequip(p5, ...);
end;

function u1.Destroy(p6) -- Line: 37
    -- upvalues: BaseCrossbow (copy)
    p6._particles_logic:Destroy();
    BaseCrossbow.Destroy(p6);
end;

function u1._UpdateDefaultAnimationsFromAmmo(p7) -- Line: 46
    local v8 = p7.ClientItem:Get("Ammo");
    p7.ClientItem:Get("AmmoReserve");
    local v9 = v8 <= 0;

    if v9 == p7._is_empty then
        return;
    end;

    p7._is_empty = v9;
    p7:ChangeInspectAnimation("Inspect" .. (p7._is_empty and "Empty" or ""));
end;

function u1._Init(u10) -- Line: 59
    u10.Equipped:Connect(function(p11) -- Line: 60
        -- upvalues: u10 (copy)
        u10._particles_logic:PlayEffect(0, p11 and 0 or 0.7);
    end);
    u10.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 64
        -- upvalues: u10 (copy)
        u10:_UpdateDefaultAnimationsFromAmmo();
    end);
    u10.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 68
        -- upvalues: u10 (copy)
        u10:_UpdateDefaultAnimationsFromAmmo();
    end);
    u10:_UpdateDefaultAnimationsFromAmmo();
    u10:_RegisterAmmoVisual(u10.ItemModel:WaitForChild("Arrow"):WaitForChild("MeshPart"));
    u10:_RegisterAmmoVisual(u10.ItemModel:WaitForChild("Arrow"):WaitForChild("MeshPart"):WaitForChild("Attachment"):WaitForChild("arrow"));
end;

return u1;