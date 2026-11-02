-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._gradient1 = {};
    v3._gradient2 = {};
    v3._solid = {};
    v3._vfx = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 30
    local v6 = workspace:GetServerTimeNow() / 2;
    local v7 = v6 / 4;
    local v8 = (v7 - 0.1) % 1;
    local v9 = (v7 + 0.1) % 1;

    for _, v in pairs(p4._gradient1) do
        v.OffsetStudsU = v6 % v.StudsPerTileU;
    end;

    for _, v in pairs(p4._gradient2) do
        v.OffsetStudsU = -(v6 % v.StudsPerTileU);
    end;

    for _, v in pairs(p4._solid) do
        local Color3_fromHSV_ret = Color3.fromHSV((v7 + v:GetAttribute("Offset")) % 1, 1, 1);
        v.Color3 = Color3.fromRGB(Color3_fromHSV_ret.R * 255 * 1.5686274509803921, Color3_fromHSV_ret.G * 255 * 1.5686274509803921, Color3_fromHSV_ret.B * 255 * 1.5686274509803921);
    end;

    for _, v in pairs(p4._vfx) do
        v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHSV(v8, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(v9, 1, 1)) });
    end;
end;

function u1._GetOffset(p10, p11) -- Line: 66
    local Size = p11.Parent.Size;

    return (Vector3.FromNormalId(p11.Face) * Size).Magnitude / 4 / 2;
end;

function u1._Setup(p12) -- Line: 76
    for _, v in pairs(p12.ExtraObjects) do
        if v.Name == "Gradient1" then
            table.insert(p12._gradient1, v);
        elseif v.Name == "Gradient2" then
            table.insert(p12._gradient2, v);
        elseif v.Name == "SolidBack" or v.Name == "SolidFront" then
            v:SetAttribute("Offset", p12:_GetOffset(v));
            table.insert(p12._solid, v);
        end;
    end;

    if p12.Object:IsA("ParticleEmitter") or (p12.Object:IsA("Beam") or p12.Object:IsA("Trail")) then
        table.insert(p12._vfx, p12.Object);
    end;
end;

function u1._Init(p13) -- Line: 93
    p13:_Setup();
end;

return u1;