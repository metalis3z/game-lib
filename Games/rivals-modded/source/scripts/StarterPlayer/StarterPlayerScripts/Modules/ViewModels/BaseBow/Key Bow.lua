-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseBow = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseBow);
local u1 = {
    Color3.fromRGB(191, 191, 191),
    Color3.fromRGB(250, 228, 116),
    Color3.fromRGB(248, 214, 44),
    Color3.fromRGB(229, 192, 6)
};
local u2 = setmetatable({}, BaseBow);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: BaseBow (copy), u2 (copy)
    local v3 = BaseBow.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.GetChargeColor(p5, p6) -- Line: 22
    -- upvalues: u1 (copy)
    return u1[p6];
end;

function u2.PlayChargeSound(p7, p8) -- Line: 26
    -- upvalues: BaseBow (copy)
    BaseBow.PlayChargeSound(p7, p8);
    p7:CreateSound("rbxassetid://90757583550672", 0.5, 1.25 + 0.25 * p8, true, 5);
    p7:CreateSound("rbxassetid://90757583550672", 0.125, 1, true, 5);
end;

function u2._UpdateAmmoContext(p9) -- Line: 36
    local v10 = p9.ClientItem:Get("Ammo") <= 0;

    if v10 == p9._is_empty then
        return;
    end;

    p9._is_empty = v10;
    p9:ChangeInspectAnimation(p9._is_empty and "InspectEmpty" or "Inspect");
    p9.Animator:ChangeRareInspectAnimation(p9._is_empty and "nil" or "RareInspect");
end;

function u2._Init(u11) -- Line: 49
    u11.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 50
        -- upvalues: u11 (copy)
        u11:_UpdateAmmoContext();
    end);
    u11.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 54
        -- upvalues: u11 (copy)
        u11:_UpdateAmmoContext();
    end);
    u11:_UpdateAmmoContext();
    u11:_RegisterAmmoVisual(u11.ItemModel:WaitForChild("Arrow"):WaitForChild("Stick"));
end;

return u2;