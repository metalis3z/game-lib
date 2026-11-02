-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local u2 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local u3 = setmetatable({}, Ragdoll);
u3.__index = u3;

function u3.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u3 (copy), HttpService (copy)
    local v4 = Ragdoll.new(...);
    local v5 = setmetatable(v4, u3);
    v5._fov_offset_key = HttpService:GenerateGUID(false);
    v5:_Init();

    return v5;
end;

function u3.PlayClient(u6, p7) -- Line: 29
    -- upvalues: Ragdoll (copy), u1 (copy), Lighting (copy), Utility (copy), u2 (copy)
    Ragdoll.PlayClient(u6, p7);

    if not p7 then
        local Fighter = u1:GetFighter(u6._eliminator);

        if not (Fighter and Fighter:Get("IsSpectating")) then
            return;
        end;
    end;

    u6:CreateSound("rbxassetid://74603473314180", 1.25, 0.95 + 0.1 * math.random(), script, true, 10);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    table.insert(u6._destroy_these, ColorCorrectionEffect);
    Utility:RenderstepForLoop(0, 100, 2, function(p8) -- Line: 46
        -- upvalues: u6 (copy), ColorCorrectionEffect (copy), u2 (ref)
        if u6._destroyed then
            return true;
        end;

        local v9 = p8 / 100;
        local v10;

        if v9 < 0.5 then
            v10 = 16 * v9 ^ 5;
        else
            v10 = 1 - (-2 * v9 + 2) ^ 5 / 2;
        end;

        local v11 = 1 - v10;
        ColorCorrectionEffect.Brightness = 0.25 * v11;
        ColorCorrectionEffect.Contrast = 0.5 * v11;
        ColorCorrectionEffect.Saturation = 1 * v11;
        u2:SetExternalFOVOffset(u6._fov_offset_key, 10 * v11);
    end);
    ColorCorrectionEffect:Destroy();
    u2:SetExternalFOVOffset(u6._fov_offset_key, 0);
end;

function u3.Destroy(p12) -- Line: 65
    -- upvalues: u2 (copy), Ragdoll (copy)
    if u2 then
        u2:SetExternalFOVOffset(p12._fov_offset_key, 0);
    end;

    Ragdoll.Destroy(p12);
end;

function u3._Init(p13) -- Line: 77
end;

return u3;