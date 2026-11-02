-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local v1 = (" "):rep(3)
local v2 = {}

v2[TestEnum.TestStatus.Success] = "+"
v2[TestEnum.TestStatus.Failure] = "-"
v2[TestEnum.TestStatus.Skipped] = "~"

local v3 = {}

local function compareNodes(v4, v5) -- line 15
    return v4.planNode.phrase:lower() < v5.planNode.phrase:lower()
end

local v6

function v6(v7, v8, v9) -- line 20 | captures: v6, TestEnum, v1, v2, compareNodes
    local v10 = v8 or {}
    local v11 = v9 or 0
    if v7.status ~= TestEnum.TestStatus.Skipped then
        local v12
        if v7.status then
            local v13 = v2[v7.status] or "?"
            v12 = ("%s[%s] %s"):format(v1:rep(v11), v13, v7.planNode.phrase)
        else
            v12 = ("%s%s"):format(v1:rep(v11), v7.planNode.phrase)
        end
        table.insert(v10, v12)
        table.sort(v7.children, compareNodes)
        for v14, v15 in ipairs(v7.children) do
            v6(v15, v10, v11 + 1)
        end
    end
    return v10
end

local function reportRoot(v16) -- line 45 | captures: v6, compareNodes
    local v17 = {}
    table.sort(v16.children, compareNodes)
    for v18, v19 in ipairs(v16.children) do
        v6(v19, v17, 0)
    end
    return v17
end

local function report(v20) -- line 53 | captures: reportRoot
    local v21 = reportRoot(v20)
    return table.concat(v21, "\n")
end

function v3.report(v22) -- line 57 | captures: TestService, reportRoot
    local v23 = {}
    local v24 = reportRoot(v22)
    local v25 = table.concat(v24, "\n")
    v23[1] = "Test results:"
    v23[2] = v25
    v23[3] = ("%d passed, %d failed, %d skipped"):format(v22.successCount, v22.failureCount, v22.skippedCount)
    print(table.concat(v23, "\n"))
    if v22.failureCount > 0 then
        print(("%d test nodes reported failures."):format(v22.failureCount))
    end
    if not (#v22.errors > 0) then
        return
    end
    print("Errors reported by tests:")
    print("")
    for v26, v27 in ipairs(v22.errors) do
        TestService:Error(v27)
        print("")
    end
end

return v3
