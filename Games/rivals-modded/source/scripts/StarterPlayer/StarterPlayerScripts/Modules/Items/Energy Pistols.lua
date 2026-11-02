-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local EnergyTracerEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("EnergyTracerEffect");
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._ImpactMarker(p4, p5) -- Line: 28
end;

function u1._Tracers(p6, p7) -- Line: 32
    -- upvalues: EnergyTracerEffect (copy), Gun (copy)
    return Gun._Tracers(p6, p7, {
        PlayFlyBySound = function(p8, p9) -- Line: 36, Name: PlayFlyBySound
        end,

        Template = EnergyTracerEffect,

        InitCallback = function(p10, p11) -- Line: 40, Name: InitCallback
            for _, descendant in pairs(p10:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Width1 = 0;
                end;
            end;
        end
    });
end;

function u1._Init(p12) -- Line: 52
end;

return u1;