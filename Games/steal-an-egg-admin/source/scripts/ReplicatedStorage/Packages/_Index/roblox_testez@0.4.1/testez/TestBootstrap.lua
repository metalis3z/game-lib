-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestPlanner = require(script.Parent.TestPlanner)
local TestRunner = require(script.Parent.TestRunner)
local TextReporter = require(script.Parent.Reporters.TextReporter)
local v1 = {}

local function stripSpecSuffix(v2) -- line 10
    return (v2:gsub("%.spec$", ""))
end

local function isSpecScript(v3) -- line 13
    return v3:IsA("ModuleScript") and v3.Name:match("%.spec$")
end

local function getPath(v4, v5) -- line 20
    local v6 = v5 or game
    local v7 = {}
    local v8 = if v4.Name == "init.spec" then v4.Parent else v4
    while v8 ~= nil do
        if v8 == v6 then
            break
        end
        local v9 = v8.Name:gsub("%.spec$", "")
        table.insert(v7, v9)
        v8 = v8.Parent
    end
    local v10 = v6.Name:gsub("%.spec$", "")
    table.insert(v7, v10)
    return v7
end

local function toStringPath(v11) -- line 41
    local v12 = ""
    local v13 = true
    for v14, v15 in ipairs(v11) do
        if v13 then
            v12 = v15
            v13 = false
        else
            v12 = v15 .. " " .. v12
        end
    end
    return v12
end

function v1.getModulesImpl(v16, v17, v18, v19) -- line 54 | captures: getPath
    if not v18 then
        local v20 = {}
    end
    local v21 = v19 or v17
    if not (v21:IsA("ModuleScript") and v21.Name:match("%.spec$")) then
        return
    end
    local v22 = require(v21)
    local v23 = getPath(v21, v17)
    local v24 = ""
    local v25 = true
    for v26, v27 in ipairs(v23) do
        if v25 then
            v24 = v27
            v25 = false
        else
            v24 = v27 .. " " .. v24
        end
    end
    local v28 = {
        method = v22,
        path = v23,
        pathStringForSorting = v24:lower()
    }
    table.insert(v22, v28)
end

function v1.getModules(v29, v30) -- line 81
    local v31 = {}
    v29:getModulesImpl(v30, v31)
    for v32, v33 in ipairs(v30:GetDescendants()) do
        v29:getModulesImpl(v30, v31, v33)
    end
    return v31
end

function v1.run(v34, v35, v36, v37) -- line 89 | captures: TestPlanner, TestRunner, TextReporter
    local v38 = v36 or TextReporter
    local v39 = v37 or {}
    local v40 = v39.showTimingInfo or false
    local testNamePattern = v39.testNamePattern
    local v41 = v39.extraEnvironment or {}
    if type(v35) ~= "table" then
        local v42 = ("Bad argument #1 to TestBootstrap:run. Expected table, got %s"):format((typeof(v35)))
        error(v42, 2)
    end
    local v43 = tick()
    local v44 = {}
    for v45, v46 in ipairs(v35) do
        local v47 = v34:getModules(v46)
        for v48, v49 in ipairs(v47) do
            table.insert(v44, v49)
        end
    end
    local v50 = tick()
    local v51 = TestPlanner.createPlan(v44, testNamePattern, v41)
    local v52 = tick()
    local v53 = TestRunner.runPlan(v51)
    local v54 = tick()
    v38.report(v53)
    if v40 then
        local v55 = {}
        local v56 = ("Took %f seconds to locate test modules"):format(v50 - v43)
        local v57 = ("Took %f seconds to create test plan"):format(v52 - v50)
        local v58 = ("Took %f seconds to run tests"):format(v54 - v52)
        v55[1] = v56
        v55[2] = v57
        v55[3] = v58
        v55[4] = ("Took %f seconds to report tests"):format(tick() - v54)
        print(table.concat(v55, "\n"))
    end
    return v53
end

return v1
