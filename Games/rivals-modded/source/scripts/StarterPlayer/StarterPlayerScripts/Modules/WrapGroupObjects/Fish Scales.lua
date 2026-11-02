-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 21
end;

function u1._Evaluate(p6, p7) -- Line: 29
    local v8 = DateTime.now().UnixTimestamp / 86400;
    local math_floor_ret = math.floor(v8);
    local v9 = Random.new(math_floor_ret):NextNumber(0, 0.92);

    if p7:IsA("BasePart") then
        local _, v10, v11 = p7.Color:ToHSV();
        p7.Color = Color3.fromHSV(v9, v10, v11);

        return;
    end;

    if not (p7:IsA("ParticleEmitter") or (p7:IsA("Beam") or p7:IsA("Trail"))) then
        if p7:IsA("RopeConstraint") or p7:IsA("RodConstraint") then
            local _, v12, v13 = p7.Color.Color:ToHSV();
            local Color3_fromHSV_ret = Color3.fromHSV(v9, v12, v13);
            p7.Color = BrickColor.new(Color3_fromHSV_ret);
        end;

        return;
    end;

    local _, v14, v15 = p7.Color.Keypoints[1].Value:ToHSV();
    local Color3_fromHSV_ret = Color3.fromHSV(v9, v14, v15);
    p7.Color = ColorSequence.new(Color3_fromHSV_ret);
end;

function u1._Setup(p16) -- Line: 48
    p16:_Evaluate(p16.Object);

    for _, v in p16.ExtraObjects do
        p16:_Evaluate(v);
    end;
end;

function u1._Init(p17) -- Line: 55
    p17:_Setup();
end;

return u1;