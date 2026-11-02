-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._waves = {};
    v3._waves_foam = {};
    v3._waves_shade1 = {};
    v3._waves_shade2 = {};
    v3._caustics1 = {};
    v3._caustics2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 28
    -- upvalues: u1 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v6 = ServerTimeNow / 7.5;
    local v7 = math.sin(v6 * 24) / 3 + 0.5;
    local math_clamp_ret = math.clamp(v7, 0, 1);
    local v8 = math.sin((v6 + 3.5342917352885173) * 24) / 3 + 0.5;
    local math_clamp_ret2 = math.clamp(v8, 0, 1);

    for _, v in pairs(p4._waves) do
        u1:_MoveTexture(v, 0, 0, 0, ServerTimeNow);
    end;

    for _, v in pairs(p4._waves_foam) do
        u1:_MoveTexture(v, 0, 0, 0.05, ServerTimeNow);
    end;

    for _, v in pairs(p4._waves_shade1) do
        u1:_MoveTexture(v, 0.01, 0.6, 0, ServerTimeNow);
    end;

    for _, v in pairs(p4._waves_shade2) do
        u1:_MoveTexture(v, 0.035, 0.9, 0, ServerTimeNow);
    end;

    for _, v in pairs(p4._caustics1) do
        v.Transparency = math_clamp_ret;
    end;

    for _, v in pairs(p4._caustics2) do
        v.Transparency = math_clamp_ret2;
    end;
end;

function u1._MoveTexture(p9, p10, p11, p12, p13, p14) -- Line: 64
    local v15 = p14 / 1.5;
    local StudsPerTileV = p10.StudsPerTileV;
    p10.OffsetStudsU = -(v15 / 10 - p11) % p10.StudsPerTileU;
    p10.OffsetStudsV = (math.sin(v15 - p12) / 6 + 0.2) % StudsPerTileV + (p13 - 0.1);
end;

function u1._Setup(p16) -- Line: 75
    for _, v in pairs(p16.ExtraObjects) do
        if v.Name == "Waves" or v.Name == "WavesCaustics" then
            table.insert(p16._waves, v);
        elseif v.Name == "WavesFoam" then
            table.insert(p16._waves_foam, v);
        elseif v.Name == "WavesShade1" then
            table.insert(p16._waves_shade1, v);
        elseif v.Name == "WavesShade2" then
            table.insert(p16._waves_shade2, v);
        elseif v.Name == "Caustics" then
            table.insert(p16._caustics1, v);
        elseif v.Name == "Caustics2" then
            table.insert(p16._caustics2, v);
        end;
    end;
end;

function u1._Init(p17) -- Line: 93
    p17:_Setup();
end;

return u1;