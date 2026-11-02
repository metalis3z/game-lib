-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestEnum = require(script.Parent.TestEnum)
local v1 = {}

v1.__index = v1

function v1.new() -- line 9 | captures: v1
    local v2 = {
        _stack = {}
    }
    return (setmetatable(v2, v1))
end

function v1.getBeforeEachHooks(v3) -- line 13 | captures: TestEnum
    local BeforeEach = TestEnum.NodeType.BeforeEach
    local v4 = {}
    for v5, v6 in ipairs(v3._stack) do
        for v7, v8 in ipairs(v6[BeforeEach]) do
            table.insert(v4, v8)
        end
    end
    return v4
end

function v1.getAfterEachHooks(v9) -- line 23 | captures: TestEnum
    local AfterEach = TestEnum.NodeType.AfterEach
    local v10 = {}
    for v11, v12 in ipairs(v9._stack) do
        for v13, v14 in ipairs(v12[AfterEach]) do
            table.insert(v10, 1, v14)
        end
    end
    return v10
end

local function popHooks(v15) -- line 33
    table.remove(v15._stack, #v15._stack)
end

v1.popHooks = popHooks

function v1.pushHooksFrom(v16, v17) -- line 36 | captures: TestEnum
    local v18 = v17 ~= nil
    assert(v18)
    local _stack = v16._stack
    local v19 = {}
    v19[TestEnum.NodeType.BeforeAll] = v16:_getHooksOfType(v17.children, TestEnum.NodeType.BeforeAll)
    v19[TestEnum.NodeType.AfterAll] = v16:_getHooksOfType(v17.children, TestEnum.NodeType.AfterAll)
    v19[TestEnum.NodeType.BeforeEach] = v16:_getHooksOfType(v17.children, TestEnum.NodeType.BeforeEach)
    v19[TestEnum.NodeType.AfterEach] = v16:_getHooksOfType(v17.children, TestEnum.NodeType.AfterEach)
    table.insert(_stack, v19)
end

function v1.getBeforeAllHooks(v20) -- line 47 | captures: TestEnum
    return v20._stack[#v20._stack][TestEnum.NodeType.BeforeAll]
end

function v1.getAfterAllHooks(v21) -- line 50 | captures: TestEnum
    return v21._stack[#v21._stack][TestEnum.NodeType.AfterAll]
end

local function _getHooksOfType(v22, v23, v24) -- line 53
    local v25 = {}
    for v26, v27 in ipairs(v23) do
        if v27.type == v24 then
            local callback = v27.callback
            table.insert(v25, callback)
        end
    end
    return v25
end

v1._getHooksOfType = _getHooksOfType
return v1
