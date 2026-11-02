

local v0 = table.freeze({});
local function v2(v1)
    return getmetatable(v1) == v0;
end;
local function v6(v3, v4)
    local v5 = {
        priority = v4 or 1, 
        callback = v3
    };
    setmetatable(v5, v0);
    return table.freeze(v5);
end;
return function()
    return v6, v2;
end;