-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local TweenInfo_new_ret = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._glyphs = { {}, {} };
    v3._elapsed = 0;
    v3._elapsed2 = 0;
    v3._number_value = Instance.new("NumberValue");
    v3._jitter_u = 0;
    v3._jitter_v = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 30
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    p4._elapsed = p4._elapsed + p5 / 5;
    p4._elapsed2 = p4._elapsed2 + p5;

    if p4._elapsed2 >= 2 then
        p4._elapsed2 = 0;
        p4._number_value.Value = 0.05;
        local v6 = TweenService:Create(p4._number_value, TweenInfo_new_ret, {
            Value = 0
        });
        v6:Play();
        table.insert(p4._tweens, v6);
    end;

    for _, v in pairs(p4._glyphs[1]) do
        v.OffsetStudsU = -(p4._elapsed % v.StudsPerTileU) + p4._jitter_u;
        v.OffsetStudsV = -(p4._elapsed % v.StudsPerTileV) + p4._jitter_v;
        v.Transparency = 0.55 + p4._number_value.Value * 2;
    end;

    for _, v in pairs(p4._glyphs[2]) do
        v.OffsetStudsU = p4._elapsed % v.StudsPerTileU + p4._jitter_u;
        v.OffsetStudsV = p4._elapsed % v.StudsPerTileV + p4._jitter_v;
        v.Transparency = 0.55 + p4._number_value.Value * 2;
    end;
end;

function u1.Destroy(p7) -- Line: 55
    -- upvalues: WrapGroupObject (copy)
    p7._number_value:Destroy();
    WrapGroupObject.Destroy(p7);
end;

function u1._Setup(p8) -- Line: 64
    for _, v in pairs(p8.ExtraObjects) do
        if v.Name == "Glyphs1" then
            table.insert(p8._glyphs[1], v);
        elseif v.Name == "Glyphs2" then
            table.insert(p8._glyphs[2], v);
        end;
    end;
end;

function u1._Init(u9) -- Line: 74
    u9._number_value:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 75
        -- upvalues: u9 (copy)
        u9._jitter_u = Random.new():NextNumber(-u9._number_value.Value, u9._number_value.Value);
        u9._jitter_v = Random.new():NextNumber(-u9._number_value.Value, u9._number_value.Value);
    end);
    u9:_Setup();
end;

return u1;