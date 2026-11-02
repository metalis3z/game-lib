-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestEnum = require(script.Parent.TestEnum)
local TestResults = require(script.Parent.TestResults)
local Context = require(script.Parent.Context)
local ExpectationContext = require(script.Parent.ExpectationContext)
local v1 = {}

v1.__index = v1

function v1.new(v2) -- line 12 | captures: TestResults, v1
    local v3 = {
        hasFocusNodes = false,
        results = TestResults.new(v2),
        nodeStack = {},
        contextStack = {},
        expectationContextStack = {}
    }
    setmetatable(v3, v1)
    return v3
end

function v1.calculateTotals(v4) -- line 23 | captures: TestEnum
    local results = v4.results
    results.successCount = 0
    results.failureCount = 0
    results.skippedCount = 0
    results:visitAllNodes(function(v5) -- line 28 | captures: results, TestEnum
        local status = v5.status
        if v5.planNode.type == TestEnum.NodeType.It then
            if status == TestEnum.TestStatus.Success then
                results.successCount += 1
            elseif status == TestEnum.TestStatus.Failure then
                results.failureCount += 1
            elseif status == TestEnum.TestStatus.Skipped then
                results.skippedCount += 1
            end
        end
    end)
end

local function gatherErrors(v6) -- line 46
    local results = v6.results
    results.errors = {}
    results:visitAllNodes(function(v7) -- line 49 | captures: results
        if #v7.errors > 0 then
            for v8, v9 in ipairs(v7.errors) do
                local errors = results.errors
                table.insert(errors, v9)
            end
        end
    end)
end

v1.gatherErrors = gatherErrors

local function finalize(v10) -- line 58
    if #v10.nodeStack ~= 0 then
        error("Cannot finalize TestResults with nodes still on the stack!", 2)
    end
    v10:calculateTotals()
    v10:gatherErrors()
    return v10.results
end

v1.finalize = finalize

function v1.pushNode(v11, v12) -- line 66 | captures: TestResults, Context, ExpectationContext
    local v13 = TestResults.createNode(v12)
    local children = (v11.nodeStack[#v11.nodeStack] or v11.results).children
    table.insert(children, v13)
    local nodeStack = v11.nodeStack
    table.insert(nodeStack, v13)
    local v14 = v11.contextStack[#v11.contextStack]
    local contextStack = v11.contextStack
    local v15 = Context.new(v14)
    table.insert(contextStack, v15)
    local v16 = v11.expectationContextStack[#v11.expectationContextStack]
    local expectationContextStack = v11.expectationContextStack
    local v17 = ExpectationContext.new(v16)
    table.insert(expectationContextStack, v17)
end

local function popNode(v18) -- line 79
    local v19 = #v18.nodeStack > 0
    assert(v19, "Tried to pop from an empty node stack!")
    table.remove(v18.nodeStack, #v18.nodeStack)
    table.remove(v18.contextStack, #v18.contextStack)
    table.remove(v18.expectationContextStack, #v18.expectationContextStack)
end

v1.popNode = popNode

local function getContext(v20) -- line 87
    local v21 = #v20.contextStack > 0
    assert(v21, "Tried to get context from an empty stack!")
    return v20.contextStack[#v20.contextStack]
end

v1.getContext = getContext

local function getExpectationContext(v22) -- line 93
    local v23 = #v22.expectationContextStack > 0
    assert(v23, "Tried to get expectationContext from an empty stack!")
    return v22.expectationContextStack[#v22.expectationContextStack]
end

v1.getExpectationContext = getExpectationContext

function v1.shouldSkip(v24) -- line 99 | captures: TestEnum
    if v24.hasFocusNodes then
        local v25 = #v24.nodeStack
        for v26 = v25, 1, -1 do
            local v27 = v24.nodeStack[v26]
            if v27.planNode.modifier == TestEnum.NodeModifier.Skip then
                return true
            end
            if v27.planNode.modifier == TestEnum.NodeModifier.Focus then
                return false
            end
        end
        return true
    end
    local v28 = #v24.nodeStack
    for v29 = v28, 1, -1 do
        if v24.nodeStack[v29].planNode.modifier == TestEnum.NodeModifier.Skip then
            return true
        end
    end
    return false
end

function v1.setSuccess(v30) -- line 124 | captures: TestEnum
    local v31 = #v30.nodeStack > 0
    assert(v31, "Attempting to set success status on empty stack")
    v30.nodeStack[#v30.nodeStack].status = TestEnum.TestStatus.Success
end

function v1.setSkipped(v32) -- line 131 | captures: TestEnum
    local v33 = #v32.nodeStack > 0
    assert(v33, "Attempting to set skipped status on empty stack")
    v32.nodeStack[#v32.nodeStack].status = TestEnum.TestStatus.Skipped
end

function v1.setError(v34, v35) -- line 138 | captures: TestEnum
    local v36 = #v34.nodeStack > 0
    assert(v36, "Attempting to set error status on empty stack")
    local v37 = v34.nodeStack[#v34.nodeStack]
    v37.status = TestEnum.TestStatus.Failure
    local errors = v37.errors
    table.insert(errors, v35)
end

function v1.addDummyError(v38, v39, v40) -- line 146 | captures: TestEnum
    v38:pushNode({
        type = TestEnum.NodeType.It,
        phrase = v39
    })
    v38:setError(v40)
    v38:popNode()
    v38.nodeStack[#v38.nodeStack].status = TestEnum.TestStatus.Failure
end

function v1.setStatusFromChildren(v41) -- line 153 | captures: TestEnum
    local v42 = #v41.nodeStack > 0
    assert(v42, "Attempting to set status from children on empty stack")
    local v43 = v41.nodeStack[#v41.nodeStack]
    local v44, v45 = true, TestEnum.TestStatus.Success
    for v46, v47 in ipairs(v43.children) do
        if v47.status ~= TestEnum.TestStatus.Skipped then
            if v47.status == TestEnum.TestStatus.Failure then
                v44, v45 = false, TestEnum.TestStatus.Failure
            else
                v44 = false
            end
        end
    end
    if v44 then
        v45 = TestEnum.TestStatus.Skipped
    end
    v43.status = v45
end

return v1
