-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {
    Storage = {}
};

local function Sweep() -- Line: 9
    -- upvalues: u1 (copy)
    local v2 = os.clock();

    for _, v in pairs(u1.Storage) do
        for i, v3 in pairs(v) do
            if v3.expiry < v2 then
                v[i] = nil;
            end;
        end;
    end;
end;

task.spawn(function() -- Line: 21
    -- upvalues: Sweep (copy)
    while true do
        task.wait(5);
        Sweep();
    end;
end);

function u1.Set(p3, p4, p5, p6) -- Line: 29
    -- upvalues: u1 (copy)
    if not u1.Storage[p3] then
        u1.Storage[p3] = {};
    end;

    local v7;

    if p6 then
        local v8 = tonumber(p6);

        if not v8 then
            error(string.format("Cache.Set: TTL must be a number or nil, got %s (%s)", type(p6), (tostring(p6))), 2);
        end;

        v7 = os.clock() + v8;
    else
        v7 = (1 / 0);
    end;

    u1.Storage[p3][p4] = {
        data = p5,
        expiry = v7
    };
end;

function u1.Get(p9, p10) -- Line: 51
    -- upvalues: u1 (copy)
    local v11 = u1.Storage[p9];

    if not v11 then
        return nil;
    end;

    local v12 = v11[p10];

    if not v12 then
        return nil;
    end;

    if os.clock() <= v12.expiry then
        return v12.data;
    end;

    v11[p10] = nil;

    return nil;
end;

function u1.GetOrFetch(p13, p14, p15, p16) -- Line: 67
    -- upvalues: u1 (copy)
    local v17 = u1.Get(p13, p14);

    if v17 ~= nil then
        return v17;
    end;

    local v18 = p16();

    if v18 ~= nil then
        u1.Set(p13, p14, v18, p15);
    end;

    return v18;
end;

function u1.GetOrFetchWithTimeout(u19, u20, u21, u22, p23) -- Line: 84
    -- upvalues: u1 (copy)
    local v24 = u1.Get(u19, u20);

    if v24 ~= nil then
        return v24;
    end;

    local u25 = nil;
    local u26 = false;
    task.spawn(function() -- Line: 93
        -- upvalues: u22 (copy), u1 (ref), u19 (copy), u20 (copy), u21 (copy), u25 (ref), u26 (ref)
        local v27 = u22();

        if v27 ~= nil then
            u1.Set(u19, u20, v27, u21);
        end;

        u25 = v27;
        u26 = true;
    end);
    local v28 = 0;

    while not u26 and v28 < (p23 or 8) do
        task.wait(0.1);
        v28 = v28 + 0.1;
    end;

    return u25;
end;

return u1;