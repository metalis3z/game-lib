-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = { "rbxassetid://112448109089773", "rbxassetid://85215887790060" };
local u2 = setmetatable({}, WrapGroupObject);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: WrapGroupObject (copy), u2 (copy)
    local v3 = WrapGroupObject.new(...);
    local v4 = setmetatable(v3, u2);
    v4._textures1 = {};
    v4._textures2 = {};
    v4._texture_index = 0;
    v4._next_tick = 0;
    v4:_Init();

    return v4;
end;

function u2.Update(p5, p6) -- Line: 27
    -- upvalues: u1 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow < p5._next_tick then
        return;
    end;

    p5._next_tick = ServerTimeNow + 0.15;
    p5._texture_index = p5._texture_index + 1;
    local v7 = p5._texture_index % 2 + 1;
    local v8 = 3 - v7;

    for _, v in pairs(p5._textures1) do
        v.Texture = u1[v7];
    end;

    for _, v in pairs(p5._textures2) do
        v.Texture = u1[v8];
    end;
end;

function u2._Setup(p9) -- Line: 53
    for _, v in pairs(p9.ExtraObjects) do
        if v.Name == "Scribbles" then
            table.insert(p9._textures1, v);
        elseif v.Name == "Scribbles2" then
            table.insert(p9._textures2, v);
        end;
    end;
end;

function u2._Init(p10) -- Line: 63
    p10:_Setup();
end;

return u2;