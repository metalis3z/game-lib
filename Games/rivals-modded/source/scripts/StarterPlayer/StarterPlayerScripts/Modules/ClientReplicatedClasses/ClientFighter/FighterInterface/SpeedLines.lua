-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.SpeedLinesThin = v3.FighterInterface.Frame:WaitForChild("SpeedLinesThin");
    v3.SpeedLinesThick = v3.FighterInterface.Frame:WaitForChild("SpeedLinesThick");
    v3._next_speedlines_update = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6) -- Line: 22
    local v7 = p4.FighterInterface.ClientFighter.Entity and (p4.FighterInterface.ClientFighter.Entity:GetBoost("Speed") or 0) or 0;
    local v8 = v7 > 0;
    p4.SpeedLinesThin.Visible = v8;
    p4.SpeedLinesThick.Visible = v8;

    if not v8 or tick() < p4._next_speedlines_update then
        return;
    end;

    p4._next_speedlines_update = tick() + 0.03;
    local math_sqrt_ret = math.sqrt(p4.FighterInterface.Frame.AbsoluteSize.X ^ 2 + p4.FighterInterface.Frame.AbsoluteSize.Y ^ 2);
    local v9 = p6.MoveSpeed <= 1 and 1 or 1 - math.clamp(v7, 0, 1) * 1;
    local math_min_ret = math.min(0.9, v9);
    p4.SpeedLinesThin.Rotation = (p4.SpeedLinesThin.Rotation + (math.random() - 0.5) * 72) % 360;
    p4.SpeedLinesThin.Size = UDim2.new(0, math_sqrt_ret, 0, math_sqrt_ret);
    p4.SpeedLinesThick.Rotation = (p4.SpeedLinesThick.Rotation + (math.random() - 0.5) * 72) % 360;
    p4.SpeedLinesThick.Size = p4.SpeedLinesThin.Size;
    p4.SpeedLinesThin.ImageTransparency = math_min_ret;
    p4.SpeedLinesThick.ImageTransparency = math_min_ret;
end;

function u1.Destroy(p10) -- Line: 48
end;

function u1._Init(p11) -- Line: 56
end;

return u1;