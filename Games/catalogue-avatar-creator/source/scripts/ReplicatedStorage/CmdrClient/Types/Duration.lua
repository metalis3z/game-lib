-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);
local u1 = {
    Years = 31556926,
    Months = 2629744,
    Weeks = 604800,
    Days = 86400,
    Hours = 3600,
    Minutes = 60,
    Seconds = 1
};
local v2 = {};

for i, _ in pairs(u1) do
    table.insert(v2, i);
end;

local u3 = Util.MakeFuzzyFinder(v2);

local function bestUnitMatch(p4) -- Line: 20
    -- upvalues: u3 (copy)
    local v5 = u3(p4);

    if #v5 == 0 then
        return nil;
    end;

    if #v5 == 1 then
        return v5[1];
    end;

    local v6 = p4:lower();

    for _, v in ipairs(v5) do
        if v:lower():sub(1, #v6) == v6 then
            return v;
        end;
    end;

    return v5[1];
end;

local function stringToSecondDuration(p7) -- Line: 36
    -- upvalues: bestUnitMatch (copy), u1 (copy)
    if p7 == nil or p7 == "" then
        return nil;
    end;

    local v8 = tonumber(p7);

    if v8 and v8 == 0 then
        return 0, 0, true;
    end;

    local v9 = p7:gsub("-?%d+%a+", ""):match("-?%d+");

    if v9 then
        return nil, tonumber(v9), true;
    end;

    local v10 = nil;
    local v11 = nil;

    for i in p7:gmatch("-?%d+%a+") do
        local v12;
        v11, v12 = i:match("(-?%d+)(%a+)");
        local v13 = bestUnitMatch(v12);

        if not v13 then
            return nil, tonumber(v11);
        end;

        v10 = (v10 == nil and 0 or v10) + (v12:lower() == "m" and 60 or u1[v13]) * tonumber(v11);
    end;

    if v10 == nil then
        return nil;
    end;

    return v10, tonumber(v11);
end;

local function mapUnits(p14, p15, p16, p17) -- Line: 75
    local v18 = p17 or 1;
    local v19 = {};

    for i, v in pairs(p14) do
        if p16 == 1 then
            v19[i] = p15 .. v:sub(v18, #v - 1);
        else
            v19[i] = p15 .. v:sub(v18);
        end;
    end;

    return v19;
end;

local u32 = {
    Transform = function(p20) -- Line: 89, Name: Transform
        -- upvalues: stringToSecondDuration (copy)
        return p20, stringToSecondDuration(p20);
    end,

    Validate = function(p21, p22) -- Line: 93, Name: Validate
        return p22 ~= nil;
    end,

    Autocomplete = function(p23, p24, p25, p26, p27) -- Line: 97, Name: Autocomplete
        -- upvalues: u3 (copy), mapUnits (copy)
        local v28 = {};

        if not (p26 or p27) then
            if p24 ~= nil then
                local v29 = p23:match("^.*-?%d+(%a+)%s?$");
                v28 = mapUnits(u3(v29), p23, p25, #v29 + 1);
                table.sort(v28);
            end;

            return v28;
        end;

        if p26 == true then
            p27 = u3("") or p27;
        end;

        if p26 == true then
            return mapUnits(p27, p23, p25);
        end;

        return mapUnits(p27, p23, p23:match("^.*(%a+)$"):len() + 1);
    end,

    Parse = function(p30, p31) -- Line: 121, Name: Parse
        return p31;
    end
};

return function(p33) -- Line: 126
    -- upvalues: u32 (copy), Util (copy)
    p33:RegisterType("duration", u32);
    p33:RegisterType("durations", Util.MakeListableType(u32));
end;