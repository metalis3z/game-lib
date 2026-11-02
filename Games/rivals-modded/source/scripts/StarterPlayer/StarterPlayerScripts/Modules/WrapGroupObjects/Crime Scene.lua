-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._tape1 = {};
    v3._tape2 = {};
    v3._glowred = {};
    v3._glowblue = {};
    v3._vfx = {};
    v3._elapsed = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 30
    p4._elapsed = p4._elapsed + p5;
    local ServerTimeNow = workspace:GetServerTimeNow();

    for _, v in pairs(p4._tape1) do
        local v6 = ServerTimeNow / 5;
        local v7 = v6 % v.StudsPerTileV;
        v.OffsetStudsU = -(v6 % v.StudsPerTileU);
        v.OffsetStudsV = v7;
    end;

    for _, v in pairs(p4._tape2) do
        local v8 = ServerTimeNow / 5;
        local v9 = v8 % v.StudsPerTileV;
        v.OffsetStudsU = v8 % v.StudsPerTileU + 0.5;
        v.OffsetStudsV = v9;
    end;

    for _, v in pairs(p4._vfx) do
        local v10 = p4._elapsed % 2;

        if v10 > 1 then
            v10 = 2 - v10;
        end;

        v.Color = ColorSequence.new(Color3.fromRGB(50, 62, 255):Lerp(Color3.fromRGB(255, 47, 47), v10));
    end;
end;

function u1._Setup(p11) -- Line: 66
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    for _, v in pairs(p11.ExtraObjects) do
        if v.Name == "PoliceTape1" then
            table.insert(p11._tape1, v);
        elseif v.Name == "PoliceTape2" then
            table.insert(p11._tape2, v);
        elseif v.Name == "GlowRed" then
            table.insert(p11._glowred, v);
        elseif v.Name == "GlowBlue" then
            table.insert(p11._glowblue, v);
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            table.insert(p11._vfx, v);
        end;
    end;

    if p11.Object:IsA("ParticleEmitter") or (p11.Object:IsA("Beam") or p11.Object:IsA("Trail")) then
        table.insert(p11._vfx, p11.Object);
    end;

    p11._elapsed = workspace:GetServerTimeNow();

    for _, v in pairs(p11._glowred) do
        local v12 = TweenService:Create(v, TweenInfo_new_ret, {
            Color3 = Color3.fromRGB(50, 62, 225)
        });
        v12:Play();
        table.insert(p11._tweens, v12);
    end;

    for _, v in pairs(p11._glowblue) do
        local v13 = TweenService:Create(v, TweenInfo_new_ret, {
            Color3 = Color3.fromRGB(225, 47, 47)
        });
        v13:Play();
        table.insert(p11._tweens, v13);
    end;
end;

function u1._Init(p14) -- Line: 102
    p14:_Setup();
end;

return u1;