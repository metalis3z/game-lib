-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientDuel = p2;
    v3._cc = Instance.new("ColorCorrectionEffect");
    v3._red_light_hash = 0;
    v3._jingle_sfx = nil;
    v3:_Init();

    return v3;
end;

function u1.RedLight(u4, p5, p6) -- Line: 28
    -- upvalues: Lighting (copy), RunService (copy), Utility (copy)
    u4._red_light_hash = u4._red_light_hash + 1;
    local _red_light_hash = u4._red_light_hash;
    u4._cc.Contrast = 0;
    u4._cc.Saturation = 0;
    u4._cc.TintColor = Color3.fromRGB(255, 255, 255);
    u4._cc.Parent = Lighting;
    local v7 = tick();

    while tick() < v7 + p5 do
        local v8 = (tick() - v7) / p5;
        local v9 = math.clamp(v8, 0, 1) ^ 4;
        u4._cc.Contrast = 0;
        u4._cc.Saturation = 0;
        u4._cc.TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(255, 127, 127), v9);
        RunService.RenderStepped:Wait();

        if _red_light_hash ~= u4._red_light_hash then
            return;
        end;
    end;

    u4._cc.Contrast = 0;
    u4._cc.Saturation = 0;
    u4._cc.TintColor = Color3.fromRGB(255, 0, 0);
    u4.ClientDuel.DuelInterface:CreateSound("rbxassetid://115599786018668", 0.5, 0.875, script, true, 5);
    local v10 = tick();
    Utility:RenderstepForLoop(0, 100, 4, function(p11) -- Line: 62
        -- upvalues: _red_light_hash (copy), u4 (copy)
        if _red_light_hash ~= u4._red_light_hash then
            return true;
        end;

        local v12 = (p11 / 100) ^ 2;
        u4._cc.Contrast = 1 + -1 * v12;
        u4._cc.Saturation = 1 + -1 * v12;
        u4._cc.Brightness = 0.25 + -0.25 * v12;
    end);
    wait(p6 - (tick() - v10));

    if _red_light_hash ~= u4._red_light_hash then
        return;
    end;

    u4._cc.Parent = nil;
end;

function u1.GreenLight(u13, p14, p15, p16) -- Line: 83
    -- upvalues: Lighting (copy), Utility (copy)
    u13._red_light_hash = u13._red_light_hash + 1;
    local _red_light_hash = u13._red_light_hash;

    if not p14 then
        u13._cc.Parent = nil;

        return;
    end;

    u13.ClientDuel.DuelInterface:CreateSound("rbxassetid://115599786018668", 0.25, 2, script, true, 5);
    u13._jingle_sfx = u13.ClientDuel.DuelInterface:CreateSound("rbxassetid://81396691367613", 0.25, 5 / p14, script, true, 10);
    u13._cc.Contrast = 1;
    u13._cc.Saturation = 0.5;
    u13._cc.TintColor = Color3.fromRGB(100, 255, 50);
    local v17;

    if p16 then
        v17 = nil;
    else
        v17 = Lighting or nil;
    end;

    u13._cc.Parent = v17;
    local v18 = tick();
    wait(0.25);
    Utility:RenderstepForLoop(0, 100, 4, function(p19) -- Line: 104
        -- upvalues: _red_light_hash (copy), u13 (copy)
        if _red_light_hash ~= u13._red_light_hash then
            return true;
        end;

        local v20 = 1 - (1 - p19 / 100) ^ 2;
        u13._cc.Contrast = 1 + -1 * v20;
        u13._cc.Saturation = 0.5 + -0.5 * v20;
        u13._cc.TintColor = Color3.fromRGB(100, 255, 50):Lerp(Color3.fromRGB(255, 255, 255), v20);
    end);

    if _red_light_hash ~= u13._red_light_hash then
        return;
    end;

    u13._cc.Parent = nil;
    u13:RedLight(p14 - (tick() - v18), p15);
end;

function u1.Stop(p21) -- Line: 124
    if p21._jingle_sfx then
        p21._jingle_sfx:Destroy();
        p21._jingle_sfx = nil;
    end;
end;

function u1.Elimination(p22) -- Line: 131
    p22.ClientDuel.DuelInterface:CreateSound("rbxassetid://13270206222", 1, 1.25 + 0.5 * math.random(), script, true, 5);
    p22.ClientDuel.DuelInterface:CreateSound("rbxassetid://13270206087", 1, 1.25 + 0.5 * math.random(), script, true, 5);
end;

function u1.Destroy(p23) -- Line: 136
    p23._red_light_hash = p23._red_light_hash + 1;
    p23._cc:Destroy();
end;

function u1._Init(u24) -- Line: 145
    u24.ClientDuel:GetDataChangedSignal("IsSpectating"):Connect(function() -- Line: 146
        -- upvalues: u24 (copy)
        if not u24.ClientDuel:Get("IsSpectating") then
            u24._cc.Parent = nil;
        end;
    end);
end;

return u1;