-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._overlays = {};
    v3._overlays2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 23
    local ServerTimeNow = workspace:GetServerTimeNow();

    for _, v in pairs(p4._overlays) do
        local v6 = ServerTimeNow / 15;
        local v7 = v6 % v.StudsPerTileV;
        v.OffsetStudsU = v6 % v.StudsPerTileU;
        v.OffsetStudsV = v7;
        v.Transparency = math.sin(ServerTimeNow * 1.25) / 7 + 0.25;
    end;

    for _, v in pairs(p4._overlays2) do
        local v8 = (math.sin(ServerTimeNow / 2.5) / 1.2 + 2) / 6 + 2;
        v.StudsPerTileU = v8;
        v.StudsPerTileV = v8;
    end;
end;

function u1._Setup(p9) -- Line: 51
    for _, v in pairs(p9.ExtraObjects) do
        if v.Name == "WeirdPaintOverlay" then
            table.insert(p9._overlays, v);
        elseif v.Name == "WeirdPaintOverlay2" then
            table.insert(p9._overlays2, v);
        end;
    end;
end;

function u1._Init(p10) -- Line: 61
    p10:_Setup();
end;

return u1;