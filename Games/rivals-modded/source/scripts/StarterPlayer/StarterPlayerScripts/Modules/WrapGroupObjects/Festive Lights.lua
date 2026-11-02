-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._last_remainder = nil;
    v3._textures = { {}, {}, {} };
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 25
    local v6 = tick() * 1;
    local v7 = math.floor(v6) % #p4._textures + 1;

    if v7 == p4._last_remainder then
        return;
    end;

    p4._last_remainder = v7;

    for i, v in pairs(p4._textures) do
        local v8 = i == p4._last_remainder and 0 or 1;

        for _, v2 in pairs(v) do
            v2.Transparency = v8;
        end;
    end;
end;

function u1._Setup(p9) -- Line: 47
    for _, v in pairs(p9.ExtraObjects) do
        if v.Name == "SolidRed" or v.Name == "RedLightsInner" then
            table.insert(p9._textures[1], v);
        elseif v.Name == "SolidYellow" or v.Name == "YellowLightsInner" then
            table.insert(p9._textures[2], v);
        elseif v.Name == "SolidGreen" or v.Name == "GreenLightsInner" then
            table.insert(p9._textures[3], v);
        end;
    end;
end;

function u1._Init(p10) -- Line: 59
    p10:_Setup();
end;

return u1;