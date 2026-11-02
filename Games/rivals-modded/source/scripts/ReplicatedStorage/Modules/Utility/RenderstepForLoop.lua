-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

return function(p1, p2, p3, p4, p5, p6) -- Line: 6
    -- upvalues: RunService (copy)
    local v7 = typeof(p1) == "number";
    local v8 = "Argument 1 invalid, expected a number, got " .. tostring(p1);
    assert(v7, v8);
    local v9 = typeof(p2) == "number";
    local v10 = "Argument 2 invalid, expected a number, got " .. tostring(p2);
    assert(v9, v10);
    local v11 = typeof(p3) == "number" and true or typeof(p3) == "function";
    local v12 = "Argument 3 invalid, expected a number or function, got " .. tostring(p3);
    assert(v11, v12);
    local v13 = typeof(p4) == "function";
    local v14 = "Argument 4 invalid, expected a function, got " .. tostring(p4);
    assert(v13, v14);
    local v15 = not p5 or typeof(p5) == "boolean";
    local v16 = "Argument 5 invalid, expected a boolean or nil, got " .. tostring(p5);
    assert(v15, v16);
    local v17 = not p6 or typeof(p6) == "number";
    local v18 = "Argument 6 invalid, expected a number or nil, got " .. tostring(p6);
    assert(v17, v18);
    local v19 = typeof(p3) == "function";
    local v20 = p6 or 1;

    while true do
        local v21;

        if v19 then
            v21 = p3() or p3;
        else
            v21 = p3;
        end;

        if v21 > 0 and p2 < p1 or v21 < 0 and p1 < p2 then
            if not p5 then
                p4(p2);
            end;

            return;
        end;

        if p4(p1) then
            return;
        end;

        local v22 = tick();

        for i = 1, v20 do
            RunService.Heartbeat:Wait();
            local _ = i;
        end;

        p1 = p1 + v21 * (tick() - v22) * 60 / v20;
    end;
end;