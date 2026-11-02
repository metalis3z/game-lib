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
    v3:_Init();

    return v3;
end;

function u1._Brighten(p4, p5) -- Line: 26
    local v6, v7, v8 = p5:ToHSV();

    return v8 < (v7 > 0.5 and 0.1 or 0.35) and p5 and p5 or Color3.fromHSV(v6, v7, (math.max(0.75, v8)));
end;

function u1._Setup(p9) -- Line: 33
    if p9.Object:IsA("BasePart") then
        p9.Object.Color = p9:_Brighten(p9.Object.Color);

        return;
    end;

    if p9.Object:IsA("Beam") or (p9.Object:IsA("Trail") or p9.Object:IsA("ParticleEmitter")) then
        local v10 = {};

        for _, v in pairs(p9.Object.Color.Keypoints) do
            table.insert(v10, ColorSequenceKeypoint.new(v.Time, p9:_Brighten(v.Value)));
        end;

        p9.Object.Color = ColorSequence.new(v10);
    end;
end;

function u1._Init(p11) -- Line: 47
    p11:_Setup();
end;

return u1;