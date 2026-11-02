-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = { "rbxassetid://76762297951095", "rbxassetid://104650396345178", "rbxassetid://128067608046117" };
local u2 = setmetatable({}, WrapGroupObject);
u2.__index = u2;

function u2.new(...) -- Line: 16
    -- upvalues: WrapGroupObject (copy), u2 (copy)
    local v3 = WrapGroupObject.new(...);
    local v4 = setmetatable(v3, u2);
    v4._static = {};
    v4._static_dark = {};
    v4._elapsed = 0;
    v4._last_texture = 1;
    v4:_Init();

    return v4;
end;

function u2.Update(p5, p6) -- Line: 33
    -- upvalues: u1 (copy)
    p5._elapsed = p5._elapsed + p6;
    local v7 = workspace:GetServerTimeNow() * 10;
    local v8 = math.sin(v7) / 10 + 0.1;
    local v9 = u1[p5._last_texture];

    if p5._elapsed >= 0.04 then
        p5._elapsed = 0;
        local v10 = p5._last_texture + 1;
        local v11 = #u1 < v10 and 1 or v10;
        v9 = u1[v11];
        p5._last_texture = v11;
    end;

    for _, v in pairs(p5._static) do
        v.OffsetStudsU = Random.new():NextInteger(-1, 1) / 250;
        v.OffsetStudsV = Random.new():NextInteger(-1, 1) / 250;
        v.Texture = v9;
        v.Transparency = v8;
    end;

    for _, v in pairs(p5._static_dark) do
        v.OffsetStudsU = Random.new():NextInteger(-1, 1) / 250;
        v.OffsetStudsV = Random.new():NextInteger(-1, 1) / 250;
        v.Texture = v9;
        v.Transparency = v8 / 1.25 + 0.35;
    end;
end;

function u2._Setup(p12) -- Line: 70
    for _, v in pairs(p12.ExtraObjects) do
        if v.Name == "Static" then
            table.insert(p12._static, v);
        elseif v.Name == "StaticDark" then
            table.insert(p12._static_dark, v);
        end;
    end;
end;

function u2._Init(p13) -- Line: 80
    p13:_Setup();
end;

return u2;