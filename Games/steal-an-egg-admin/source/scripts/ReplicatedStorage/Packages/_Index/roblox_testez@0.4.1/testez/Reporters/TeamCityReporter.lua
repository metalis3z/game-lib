-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local v1 = {}

local function teamCityEscape(v2) -- line 10
    local v3 = string.gsub(v2, "([]|'[])", "|%1")
    local v4 = string.gsub(v3, "\r", "|r")
    return (string.gsub(v4, "\n", "|n"))
end

local function teamCityEnterSuite(v5) -- line 15
    local v6 = string.gsub(v5, "([]|'[])", "|%1")
    local v7 = string.gsub(v6, "\r", "|r")
    return string.format("##teamcity[testSuiteStarted name='%s']", (string.gsub(v7, "\n", "|n")))
end

local function teamCityLeaveSuite(v8) -- line 20
    local v9 = string.gsub(v8, "([]|'[])", "|%1")
    local v10 = string.gsub(v9, "\r", "|r")
    return string.format("##teamcity[testSuiteFinished name='%s']", (string.gsub(v10, "\n", "|n")))
end

local function teamCityEnterCase(v11) -- line 25
    local v12 = string.gsub(v11, "([]|'[])", "|%1")
    local v13 = string.gsub(v12, "\r", "|r")
    return string.format("##teamcity[testStarted name='%s']", (string.gsub(v13, "\n", "|n")))
end

local function teamCityLeaveCase(v14) -- line 30
    local v15 = string.gsub(v14, "([]|'[])", "|%1")
    local v16 = string.gsub(v15, "\r", "|r")
    return string.format("##teamcity[testFinished name='%s']", (string.gsub(v16, "\n", "|n")))
end

local function teamCityFailCase(v17, v18) -- line 35
    local v19 = string.gsub(v17, "([]|'[])", "|%1")
    local v20 = string.gsub(v19, "\r", "|r")
    local v21 = string.gsub(v20, "\n", "|n")
    local v22 = string.gsub(v18, "([]|'[])", "|%1")
    local v23 = string.gsub(v22, "\r", "|r")
    return string.format("##teamcity[testFailed name='%s' message='%s']", v21, (string.gsub(v23, "\n", "|n")))
end

local v24

function v24(v25, v26, v27) -- line 43 | captures: v24, TestEnum, teamCityEnterSuite, teamCityLeaveSuite, teamCityEnterCase, teamCityLeaveCase, teamCityFailCase
    local function v28(v29, ...)
        table.insert(v29, ...)
    end

    local function v30(v31, ...)
        table.insert(v31, ...)
    end

    local function v32(v33, ...)
        table.insert(v33, ...)
    end

    local function v34(v35, ...)
        table.insert(v35, ...)
    end

    local function v36(v37, ...)
        table.insert(v37, ...)
    end

    local v38 = v26 or {}
    if v25.status == TestEnum.TestStatus.Skipped then
        return v38
    end
    if v25.planNode.type == TestEnum.NodeType.Describe then
        v28(v38, teamCityEnterSuite(v25.planNode.phrase))
        for v39, v40 in ipairs(v25.children) do
            v24(v40, v38, (v27 or 0) + 1)
        end
        v30(v38, teamCityLeaveSuite(v25.planNode.phrase))
    else
        v32(v38, teamCityEnterCase(v25.planNode.phrase))
        if v25.status == TestEnum.TestStatus.Failure then
            v34(v38, teamCityFailCase(v25.planNode.phrase, table.concat(v25.errors, "\n")))
        end
        v36(v38, teamCityLeaveCase(v25.planNode.phrase))
    end
end

local function reportRoot(v41) -- line 66 | captures: v24
    local v42 = {}
    for v43, v44 in ipairs(v41.children) do
        v24(v44, v42, 0)
    end
    return v42
end

local function report(v45) -- line 73 | captures: reportRoot
    local v46 = reportRoot(v45)
    return table.concat(v46, "\n")
end

function v1.report(v47) -- line 77 | captures: TestService, reportRoot
    local v48 = {}
    local v49 = reportRoot(v47)
    local v50 = table.concat(v49, "\n")
    v48[1] = "Test results:"
    v48[2] = v50
    v48[3] = ("%d passed, %d failed, %d skipped"):format(v47.successCount, v47.failureCount, v47.skippedCount)
    print(table.concat(v48, "\n"))
    if v47.failureCount > 0 then
        print(("%d test nodes reported failures."):format(v47.failureCount))
    end
    if not (#v47.errors > 0) then
        return
    end
    print("Errors reported by tests:")
    print("")
    for v51, v52 in ipairs(v47.errors) do
        TestService:Error(v52)
        print("")
    end
end

return v1
