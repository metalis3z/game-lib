-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = { "rbxassetid://138393431257124", "rbxassetid://107051054528784", "rbxassetid://125054446055112", "rbxassetid://110582063087757", "rbxassetid://119507229017142", "rbxassetid://97696327350095", "rbxassetid://108305398626234", "rbxassetid://107586098443052", "rbxassetid://102752148910886", "rbxassetid://96190250840477", "rbxassetid://83191963862467", "rbxassetid://101078325262094" };
local u2 = setmetatable({}, WrapGroupObject);
u2.__index = u2;

function u2.new(...) -- Line: 24
    -- upvalues: WrapGroupObject (copy), u2 (copy)
    local v3 = WrapGroupObject.new(...);
    local v4 = setmetatable(v3, u2);
    v4._arrows1 = {};
    v4._arrows2 = {};
    v4._snowflakes = {};
    v4._frame = 0;
    v4._next_update = 0;
    v4:_Init();

    return v4;
end;

function u2.Update(p5, p6) -- Line: 42
    -- upvalues: u1 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    for _, v in pairs(p5._arrows1) do
        v.OffsetStudsU = -(ServerTimeNow * 2 % v.StudsPerTileU);
    end;

    for _, v in pairs(p5._arrows2) do
        v.OffsetStudsU = ServerTimeNow * 2 % v.StudsPerTileU;
    end;

    if tick() < p5._next_update then
        return;
    end;

    p5._next_update = tick() + 0.03;
    p5._frame = p5._frame % #u1 + 1;

    for _, v in pairs(p5._snowflakes) do
        v.Texture = u1[p5._frame];
    end;
end;

function u2._Setup(p7) -- Line: 69
    for _, v in pairs(p7.ExtraObjects) do
        if v.Name == "TopArrows" then
            table.insert(p7._arrows1, v);
        elseif v.Name == "BottomArrows" then
            table.insert(p7._arrows2, v);
        elseif v.Name == "Snowflake" then
            table.insert(p7._snowflakes, v);
        end;
    end;
end;

function u2._Init(p8) -- Line: 81
    p8:_Setup();
end;

return u2;