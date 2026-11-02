-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(134, 255, 180);
local Color3_fromRGB_ret2 = Color3.fromRGB(89, 171, 123);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._started = 0;
    v3._lightnings = {};
    v3._fade_parts = {};
    v3._gradient = {};
    v3._gradient_2 = {};
    v3._next_strike = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 32
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    p4._started = p4._started + p5;
    local _started = p4._started;

    for _, v in p4._gradient do
        local v6 = _started / 2.25 % v.StudsPerTileU;

        if v.Face == Enum.NormalId.Top or v.Face == Enum.NormalId.Front then
            v6 = -v6;
        end;

        v.OffsetStudsU = v6;
    end;

    for _, v in p4._gradient_2 do
        local v7 = -(_started / 2.25) % v.StudsPerTileU;

        if v.Face == Enum.NormalId.Top or v.Face == Enum.NormalId.Front then
            v7 = -v7;
        end;

        v.OffsetStudsU = v7;
    end;

    if _started < p4._next_strike then
        return;
    end;

    p4._next_strike = _started + Random.new():NextNumber(0.6, 1.7);

    for _, v in p4._lightnings do
        v.Transparency = 0.01;
        local v8 = TweenService:Create(v, TweenInfo_new_ret, {
            Transparency = 1
        });
        v8:Play();
        table.insert(p4._tweens, v8);
    end;

    for _, v in p4._fade_parts do
        v.Color = Color3_fromRGB_ret;
        local v9 = TweenService:Create(v, TweenInfo_new_ret, {
            Color = Color3_fromRGB_ret2
        });
        v9:Play();
        table.insert(p4._tweens, v9);
    end;
end;

function u1._Setup(p10) -- Line: 76
    if p10.Object:IsA("BasePart") and (p10.Object:FindFirstChild("Lightning") and p10.Object:FindFirstChild("Gradient2")) then
        table.insert(p10._fade_parts, p10.Object);
    end;

    for _, v in pairs(p10.ExtraObjects) do
        if v.Name == "Lightning" then
            table.insert(p10._lightnings, v);
        elseif v:IsA("Texture") and v.Name == "Gradient" then
            table.insert(p10._gradient, v);
        elseif v:IsA("Texture") and v.Name == "Gradient2" then
            table.insert(p10._gradient_2, v);
        end;
    end;
end;

function u1._Init(p11) -- Line: 91
    p11:_Setup();
end;

return u1;