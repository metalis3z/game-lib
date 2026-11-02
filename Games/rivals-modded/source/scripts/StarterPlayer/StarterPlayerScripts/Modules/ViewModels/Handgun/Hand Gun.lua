-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Handgun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Handgun);
local u1 = setmetatable({}, Handgun);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Handgun (copy), u1 (copy)
    local v2 = Handgun.new(...);
    local v3 = setmetatable(v2, u1);
    v3._domain_expansion_hash = 0;
    v3._domain_expansion_cc = nil;
    v3._domain_expansion_sound = nil;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 27
    -- upvalues: Handgun (copy)
    p4._domain_expansion_hash = p4._domain_expansion_hash + 1;

    if p4._domain_expansion_cc then
        p4._domain_expansion_cc:Destroy();
        p4._domain_expansion_cc = nil;
    end;

    if p4._domain_expansion_sound then
        p4._domain_expansion_sound:Destroy();
        p4._domain_expansion_sound = nil;
    end;

    Handgun.Destroy(p4);
end;

function u1._DomainExpansion(u5) -- Line: 47
    -- upvalues: Lighting (copy), Utility (copy)
    if u5._destroyed or not u5.ClientItem.ClientFighter:Get("IsSpectating") then
        return;
    end;

    u5._domain_expansion_hash = u5._domain_expansion_hash + 1;

    if u5._domain_expansion_cc then
        u5._domain_expansion_cc:Destroy();
        u5._domain_expansion_cc = nil;
    end;

    if u5._domain_expansion_sound then
        u5._domain_expansion_sound:Destroy();
        u5._domain_expansion_sound = nil;
    end;

    u5._domain_expansion_cc = Instance.new("ColorCorrectionEffect");
    u5._domain_expansion_cc.Brightness = -0.5;
    u5._domain_expansion_cc.Contrast = 2;
    u5._domain_expansion_cc.Saturation = -3;
    u5._domain_expansion_cc.Parent = Lighting;
    u5._domain_expansion_sound = Utility:CreateSound("rbxassetid://83352422371729", 1.25, 1.1, script, true, 20);
    local _domain_expansion_hash = u5._domain_expansion_hash;
    task.delay(15, function() -- Line: 74
        -- upvalues: u5 (copy), Utility (ref), _domain_expansion_hash (copy)
        local u6 = u5._domain_expansion_sound and u5._domain_expansion_sound.Volume;
        Utility:RenderstepForLoop(1, 0, -0.04, function(p7) -- Line: 77
            -- upvalues: _domain_expansion_hash (ref), u5 (ref), u6 (copy)
            if _domain_expansion_hash ~= u5._domain_expansion_hash then
                return true;
            end;

            local v8 = p7 ^ 4;
            u5._domain_expansion_cc.Saturation = -3 * v8;
            u5._domain_expansion_cc.Contrast = 2 * v8;
            u5._domain_expansion_cc.Brightness = -0.5 * v8;

            if u5._domain_expansion_sound then
                u5._domain_expansion_sound.Volume = u6 * p7;
            end;
        end);

        if _domain_expansion_hash ~= u5._domain_expansion_hash then
            return;
        end;

        u5._domain_expansion_cc:Destroy();
        u5._domain_expansion_cc = nil;

        if u5._domain_expansion_sound then
            u5._domain_expansion_sound:Destroy();
            u5._domain_expansion_sound = nil;
        end;
    end);
end;

function u1._Init(u9) -- Line: 107
    u9.AnimationPlayed:Connect(function(p10) -- Line: 108
        -- upvalues: u9 (copy)
        if p10 == "RareInspect" then
            task.delay(0.6, u9._DomainExpansion, u9);
        end;
    end);
end;

return u1;