-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestEnum = require(script.Parent.TestEnum)
local TestSession = require(script.Parent.TestSession)
local LifecycleHooks = require(script.Parent.LifecycleHooks)
local v1 = {
    environment = {}
}

local function wrapExpectContextWithPublicApi(v2) -- line 12
    local v3 = {}

    function v3.extend(...) -- line 14 | captures: v2
        v2:extend(...)
    end

    local v4 = {}

    function v4.__call(v5, ...) -- line 19 | captures: v2
        return v2:startExpectationChain(...)
    end

    return (setmetatable(v3, v4))
end

function v1.runPlan(v6) -- line 25 | captures: TestEnum, TestSession, LifecycleHooks, v1
    local v7 = TestSession.new(v6)
    local v8 = LifecycleHooks.new()
    v7.hasFocusNodes = #v6:findNodes(function(v9) -- line 28 | captures: TestEnum
        return v9.modifier == TestEnum.NodeModifier.Focus
    end) >
    0
    v1.runPlanNode(v7, v6, v8)
    return v7:finalize()
end

function v1.runPlanNode(v10, v11, v12) -- line 41 | captures: TestEnum, v1, wrapExpectContextWithPublicApi
    local function runCallback(v13, v14) -- line 43 | captures: v10, v1, wrapExpectContextWithPublicApi
        local v15 = true
        local v16
        _G.__TESTEZ_RUNNING_TEST__ = true
        local v17 = v14 or ""
        local v18 = getfenv(v13)
        for v19, v20 in pairs(v1.environment) do
            v18[v19] = v20
        end

        function v18.fail(v21) -- line 53 | captures: v15, v16, v17
            local v22 = if v21 == nil then "fail() was called." else v21
            v15 = false
            local v23 = tostring(v22)
            v16 = v17 .. debug.traceback(v23, 2)
        end

        v18.expect = wrapExpectContextWithPublicApi(v10:getExpectationContext())
        local v24 = v10:getContext()
        local v25, v26 = xpcall(function() -- line 66 | captures: v13, v24
            v13(v24)
        end, function(v27) -- line 68 | captures: v17
            local v28 = tostring(v27)
            return v17 .. debug.traceback(v28, 2)
        end)
        if not v25 then
            v15 = false
            v16 = v26
        end
        _G.__TESTEZ_RUNNING_TEST__ = nil
        return v15, v16
    end

    local function runNode(v29) -- line 79 | captures: v12, runCallback
        for v30, v31 in ipairs(v12:getBeforeEachHooks()) do
            local v32, v33 = runCallback(v31, "beforeEach hook: ")
            if not v32 then
                return false, v33
            end
        end
        local v34, v35 = runCallback(v29.callback)
        for v36, v37 in ipairs(v12:getAfterEachHooks()) do
            local v38, v39 = runCallback(v37, "afterEach hook: ")
            if not v38 then
                if v34 then
                    return false, v39
                end
                return false, v35 .. "\nWhile cleaning up the failed test another error was found:\n" .. v39
            end
        end
        if v34 then
            return true, nil
        end
        return false, v35
    end

    v12:pushHooksFrom(v11)
    local v40 = false
    for v41, v42 in ipairs(v12:getBeforeAllHooks()) do
        local v43, v44 = runCallback(v42, "beforeAll hook: ")
        if not v43 then
            v10:addDummyError("beforeAll", v44)
            v40 = true
        end
    end
    local v45
    if v40 then
    else
        v45 = v10
        for v46, v47 in ipairs(v11.children) do
            if v47.type == TestEnum.NodeType.It then
                v10:pushNode(v47)
                if v10:shouldSkip() then
                    v10:setSkipped()
                else
                    local v48, v49 = runNode(v47)
                    if v48 then
                        v10:setSuccess()
                    else
                        v10:setError(v49)
                    end
                end
                v10:popNode()
            elseif v47.type == TestEnum.NodeType.Describe then
                v10:pushNode(v47)
                v1.runPlanNode(v10, v47, v12)
                if v47.loadError then
                    v10:setError("Error during planning: " .. v47.loadError)
                else
                    v10:setStatusFromChildren()
                end
                v10:popNode()
            end
            v45 = v10
        end
    end
    for v50, v51 in ipairs(v12:getAfterAllHooks()) do
        local v52, v53 = runCallback(v51, "afterAll hook: ")
        if not v52 then
            v45:addDummyError("afterAll", v53)
        end
    end
    v12:popHooks()
end

return v1
