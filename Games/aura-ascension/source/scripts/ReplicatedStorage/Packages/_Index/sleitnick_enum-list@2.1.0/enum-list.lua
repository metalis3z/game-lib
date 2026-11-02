-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = newproxy();
local v1 = newproxy();
local function _(v2, v3, v4) --[[ Line: 23 ]] --[[ Name: CreateEnumItem ]]
    local v5 = {
        Name = v2, 
        Value = v3, 
        EnumType = v4
    };
    table.freeze(v5);
    return v5;
end;
local v7 = {};
v7.__index = v7;
v7.new = function(v8, v9) --[[ Line: 57 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy), v1 (copy), v7 (copy)
    assert(type(v8) == "string", "Name string required");
    assert(type(v9) == "table", "Enums table required");
    local v10 = {
        [v0] = {}, 
        [v1] = v8
    };
    for v11, v12 in ipairs(v9) do
        assert(type(v12) == "string", "Enum name must be a string");
        local v13 = {
            Name = v12, 
            Value = v11, 
            EnumType = v10
        };
        table.freeze(v13);
        local l_v13_0 = v13;
        v10[v12] = l_v13_0;
        table.insert(v10[v0], l_v13_0);
    end;
    return table.freeze((setmetatable(v10, v7)));
end;
v7.BelongsTo = function(v15, v16) --[[ Line: 77 ]] --[[ Name: BelongsTo ]]
    local v17 = false;
    if type(v16) == "table" then
        v17 = v16.EnumType == v15;
    end;
    return v17;
end;
v7.GetEnumItems = function(v18) --[[ Line: 86 ]] --[[ Name: GetEnumItems ]]
    -- upvalues: v0 (copy)
    return v18[v0];
end;
v7.GetName = function(v19) --[[ Line: 95 ]] --[[ Name: GetName ]]
    -- upvalues: v1 (copy)
    return v19[v1];
end;
return v7;