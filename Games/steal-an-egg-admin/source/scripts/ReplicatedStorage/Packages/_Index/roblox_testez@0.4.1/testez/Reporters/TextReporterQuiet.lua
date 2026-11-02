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
local v4

function v4(v5, v6, v7) -- line 15 | captures: v4, TestEnum, v1, v2
    local v8 = v6 or {}
    local v9 = v7 or 0
    if v5.status ~= TestEnum.TestStatus.Skipped then
        local v10
        if v5.status == TestEnum.TestStatus.Success then
        else
            local v11 = v2[v5.status] or "?"
            v10 = ("%s[%s] %s"):format(v1:rep(v9), v11, v5.planNode.phrase)
        end
        table.insert(v8, v10)
        for v12, v13 in ipairs(v5.children) do
            v4(v13, v8, v9 + 1)
        end
    end
    return v8
end

local function reportRoot(v14) -- line 37 | captures: v4
    local v15 = {}
    for v16, v17 in ipairs(v14.children) do
        v4(v17, v15, 0)
    end
    return v15
end

local function report(v18) -- line 44 | captures: reportRoot
    local v19 = reportRoot(v18)
    return table.concat(v19, "\n")
end

function v3.report(v20) -- line 48 | captures: TestService, reportRoot
    local v21 = {}
    local v22 = reportRoot(v20)
    local v23 = table.concat(v22, "\n")
    v21[1] = "Test results:"
    v21[2] = v23
    v21[3] = ("%d passed, %d failed, %d skipped"):format(v20.successCount, v20.failureCount, v20.skippedCount)
    print(table.concat(v21, "\n"))
    if v20.failureCount > 0 then
        print(("%d test nodes reported failures."):format(v20.failureCount))
    end
    if not (#v20.errors > 0) then
        return
    end
    print("Errors reported by tests:")
    print("")
    for v24, v25 in ipairs(v20.errors) do
        TestService:Error(v25)
        print("")
    end
end

return v3
