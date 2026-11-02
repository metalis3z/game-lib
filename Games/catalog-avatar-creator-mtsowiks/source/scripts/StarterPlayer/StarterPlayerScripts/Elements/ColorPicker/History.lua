-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 4
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._currentIndex = 0;
    v2.Records = {};

    return v2;
end;

function u1.WriteHistory(p3, p4) -- Line: 12
    p3._currentIndex = p3._currentIndex + 1;

    if p3._currentIndex < #p3.Records then
        for i = p3._currentIndex + 1, #p3.Records do
            p3.Records[i] = nil;
        end;
    end;

    p3.Records[p3._currentIndex] = p4;
end;

function u1.GetRecord(p5, p6) -- Line: 23
    return p5.Records[p6 or p5._currentIndex];
end;

function u1.IncrementHistory(p7, p8) -- Line: 27
    if p7._currentIndex > 1 or p8 >= 0 then
        p7._currentIndex = math.clamp(p7._currentIndex + p8, 1, #p7.Records);

        return p7.Records[p7._currentIndex];
    end;
end;

function u1.ClearHistory(p9) -- Line: 34
    p9.Records = {};
    p9._currentIndex = 0;
end;

function u1.Destroy(p10) -- Line: 39
    p10:ClearHistory();
end;

return u1;