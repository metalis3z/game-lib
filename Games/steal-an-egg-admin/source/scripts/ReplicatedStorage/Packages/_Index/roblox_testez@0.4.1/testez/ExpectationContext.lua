-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Expectation = require(script.Parent.Expectation)
local checkMatcherNameCollisions = Expectation.checkMatcherNameCollisions

local function copy(v1) -- line 8
    local v2 = {}
    for v3, v4 in pairs(v1) do
        v2[v3] = v4
    end
    return v2
end

local v5 = {}

v5.__index = v5

function v5.new(v6) -- line 17 | captures: v5
    local v7 = {}
    if v6 then
        local v8 = {}
        for v9, v10 in pairs(v6._extensions) do
            v8[v9] = v10
        end
        v7._extensions = v8 or {}
    else
        v7._extensions = {}
    end
    return (setmetatable(v7, v5))
end

function v5.startExpectationChain(v11, ...) -- line 35 | captures: Expectation
    return Expectation.new(...):extend(v11._extensions)
end

function v5.extend(v12, v13) -- line 38 | captures: checkMatcherNameCollisions
    local function v14(v15, ...)
        assert(v15, ...)
    end

    local function v16(v17, ...)
        assert(v17, ...)
    end

    for v18, v19 in pairs(v13) do
        v14(v12._extensions[v18] == nil, string.format("Cannot reassign %q in expect.extend", v18))
        v16(checkMatcherNameCollisions(v18), string.format("Cannot overwrite matcher %q; it already exists", v18))
        v12._extensions[v18] = v19
    end
end

return v5
