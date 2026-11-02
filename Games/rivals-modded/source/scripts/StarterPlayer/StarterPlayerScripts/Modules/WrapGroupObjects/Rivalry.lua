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
    v3._moving_textures = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 22
    local v6 = workspace:GetServerTimeNow() / 7;

    for i, v in pairs(p4._moving_textures) do
        local v7 = p4:_GetCameraOffset() / v;
        i.OffsetStudsU = v7.Z + v6 % i.StudsPerTileU;
        i.OffsetStudsV = v7.Y + v6 % i.StudsPerTileV;
    end;
end;

function u1._GetCameraOffset(p8) -- Line: 37
    return p8.Object.Position - (workspace.CurrentCamera.CFrame * workspace.CurrentCamera.Focus).Position;
end;

function u1._Setup(p9) -- Line: 41
    for _, v in pairs(p9.ExtraObjects) do
        if v:IsA("Texture") then
            p9._moving_textures[v] = v.Name == "RibbonTexture2" and 800 or 1300;
        end;
    end;
end;

function u1._Init(p10) -- Line: 51
    p10:_Setup();
end;

return u1;