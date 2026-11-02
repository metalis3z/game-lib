-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ItemInterface = p2;
    v3.SpeedLinesThin = v3.ItemInterface.Frame:WaitForChild("SpeedLinesThin");
    v3.SpeedLinesThick = v3.ItemInterface.Frame:WaitForChild("SpeedLinesThick");
    v3._destroyed = false;
    v3._speed_lines_end = 0;
    v3._next_speedlines_update = 0;
    v3:_Init();

    return v3;
end;

function u1.Create(p4, p5) -- Line: 26
    local v6;

    if p5 == -1 then
        v6 = 0;
    else
        local _speed_lines_end = p4._speed_lines_end;
        local v7 = tick() + p5;
        v6 = math.max(_speed_lines_end, v7);
    end;

    p4._speed_lines_end = v6;
end;

function u1.Update(p8, p9, p10, p11) -- Line: 30
    local v12 = tick() < p8._speed_lines_end;
    p8.SpeedLinesThin.Visible = v12;
    p8.SpeedLinesThick.Visible = v12;

    if not v12 or tick() < p8._next_speedlines_update then
        return;
    end;

    p8._next_speedlines_update = tick() + 0.03;
    local v13 = p8.ItemInterface.Frame.AbsoluteSize.X / p8.ItemInterface.Frame.AbsoluteSize.Y;
    p8.SpeedLinesThin.Rotation = (p8.SpeedLinesThin.Rotation + (math.random() - 0.5) * 72) % 360;
    p8.SpeedLinesThin.Size = UDim2.new(v13, 0, v13, 0);
    p8.SpeedLinesThick.Rotation = (p8.SpeedLinesThick.Rotation + (math.random() - 0.5) * 72) % 360;
    p8.SpeedLinesThick.Size = p8.SpeedLinesThin.Size;
end;

function u1.Destroy(p14) -- Line: 51
    p14._destroyed = true;
end;

function u1._Init(p15) -- Line: 59
end;

return u1;