-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestEnum = require(script.Parent.TestEnum)
local Expectation = require(script.Parent.Expectation)

local function newEnvironment(v1, v2) -- line 8 | captures: TestEnum, Expectation
    local v3 = {}
    if v2 then
        if type(v2) ~= "table" then
            local v4 = ("Bad argument #2 to newEnvironment. Expected table, got %s"):format((typeof(v2)))
            error(v4, 2)
        end
        for v5, v7 in pairs(v2) do
            v3[v5] = v7
        end
    end

    local function addChild(v8, v9, v10, v11) -- line 20 | captures: v1, TestEnum
        local v12 = v1:addChild(v8, v10, v11)
        v12.callback = v9
        if v10 == TestEnum.NodeType.Describe then
            v12:expand()
        end
        return v12
    end

    function v3.describeFOCUS(v13, v14) -- line 28 | captures: addChild, TestEnum
        addChild(v13, v14, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Focus)
    end

    function v3.describeSKIP(v15, v16) -- line 31 | captures: addChild, TestEnum
        addChild(v15, v16, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Skip)
    end

    function v3.describe(v17, v18, v19) -- line 34 | captures: addChild, TestEnum
        addChild(v17, v18, TestEnum.NodeType.Describe, TestEnum.NodeModifier.None)
    end

    function v3.itFOCUS(v20, v21) -- line 37 | captures: addChild, TestEnum
        addChild(v20, v21, TestEnum.NodeType.It, TestEnum.NodeModifier.Focus)
    end

    function v3.itSKIP(v22, v23) -- line 40 | captures: addChild, TestEnum
        addChild(v22, v23, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip)
    end

    function v3.itFIXME(v24, v25) -- line 43 | captures: addChild, TestEnum
        local v26 = addChild(v24, v25, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip)
        warn("FIXME: broken test", v26:getFullName())
    end

    function v3.it(v27, v28, v29) -- line 47 | captures: addChild, TestEnum
        addChild(v27, v28, TestEnum.NodeType.It, TestEnum.NodeModifier.None)
    end

    local v30 = 0
    local v31 = {}
    v31[TestEnum.NodeType.BeforeAll] = "beforeAll"
    v31[TestEnum.NodeType.AfterAll] = "afterAll"
    v31[TestEnum.NodeType.BeforeEach] = "beforeEach"
    v31[TestEnum.NodeType.AfterEach] = "afterEach"
    for v32, v33 in pairs(v31) do
        local v34 = v33
        local v35 = v32

        v3[v33] = function(v36) -- line 57 | captures: v30, addChild, v34, v35, TestEnum
            local v37 = v30
            local v38 = v34 .. "_" .. tostring(v37)
            addChild(v38, v36, v35, TestEnum.NodeModifier.None)
            v30 += 1
        end
    end

    function v3.FIXME(v39) -- line 63 | captures: v1, TestEnum
        local v40 = v1:getFullName()
        warn("FIXME: broken test", v40, v39 or "")
        v1.modifier = TestEnum.NodeModifier.Skip
    end

    function v3.FOCUS() -- line 68 | captures: v1, TestEnum
        v1.modifier = TestEnum.NodeModifier.Focus
    end

    function v3.SKIP() -- line 71 | captures: v1, TestEnum
        v1.modifier = TestEnum.NodeModifier.Skip
    end

    function v3.HACK_NO_XPCALL() -- line 74
        warn("HACK_NO_XPCALL is deprecated. It is now safe to yield in an xpcall, so this is no longer necessary. It can be safely deleted.")
    end

    v3.fit = v3.itFOCUS
    v3.xit = v3.itSKIP
    v3.fdescribe = v3.describeFOCUS
    v3.xdescribe = v3.describeSKIP
    local v41 = {
        extend = function(...) -- extend | line 82
            error("Cannot call \"expect.extend\" from within a \"describe\" node.")
        end
    }
    local v42 = {
        __call = function(v43, ...) -- __call | line 86 | captures: Expectation
            return Expectation.new(...)
        end
    }
    v3.expect = setmetatable(v41, v42)
    return v3
end

local v44 = {}

v44.__index = v44

function v44.new(v45, v46, v47, v48) -- line 94 | captures: TestEnum, newEnvironment, v44
    local v49 = {
        plan = v45,
        phrase = v46,
        type = v47,
        modifier = v48 or TestEnum.NodeModifier.None,
        children = {}
    }
    v49.environment = newEnvironment(v49, v45.extraEnvironment)
    return (setmetatable(v49, v44))
end

local function getModifier(v50, v51, v52) -- line 109 | captures: TestEnum
    if v51 then
        if v52 == nil then
            if v50:match(v51) then
                return TestEnum.NodeModifier.Focus
            end
            return TestEnum.NodeModifier.Skip
        end
        if v52 == TestEnum.NodeModifier.None then
            if v50:match(v51) then
                return TestEnum.NodeModifier.Focus
            end
            return TestEnum.NodeModifier.Skip
        end
    end
    return v52
end

function v44.addChild(v53, v54, v55, v56) -- line 127 | captures: TestEnum, v44, getModifier
    if v55 == TestEnum.NodeType.It then
        for v57, v58 in pairs(v53.children) do
            if v58.phrase == v54 then
                error("Duplicate it block found: " .. v58:getFullName())
            end
        end
    end
    local v59 = v53:getFullName()
    local v60 = getModifier(v59 .. " " .. v54, v53.plan.testNamePattern, v56)
    local v61 = v44.new(v53.plan, v54, v55, v60)
    v61.parent = v53
    local children = v53.children
    table.insert(children, v61)
    return v61
end

function v44.getFullName(v62) -- line 142
    if v62.parent then
        local v63 = v62.parent:getFullName()
        if v63 then
            return v63 .. " " .. v62.phrase
        end
    end
    return v62.phrase
end

function v44.expand(v64) -- line 152
    local v65 = getfenv(v64.callback)
    local v66 = {}
    local v67 = { __index = v65 }
    local v68 = setmetatable(v66, v67)
    for v69, v70 in pairs(v64.environment) do
        v68[v69] = v70
    end
    v68.script = v65.script
    setfenv(v64.callback, v68)
    local v71, v72 = xpcall(v64.callback, function(v73) -- line 161
        local v74 = tostring(v73)
        return debug.traceback(v74, 2)
    end)
    if not v71 then
        v64.loadError = v72
    end
end

local v75 = {}

v75.__index = v75

function v75.new(v76, v77) -- line 171 | captures: v75
    local v78 = {
        children = {},
        testNamePattern = v76,
        extraEnvironment = v77
    }
    return (setmetatable(v78, v75))
end

function v75.addChild(v79, v80, v81, v82) -- line 175 | captures: v44, getModifier
    local v83 = getModifier(v80, v79.testNamePattern, v82)
    local v84 = v44.new(v79, v80, v81, v83)
    local children = v79.children
    table.insert(children, v84)
    return v84
end

function v75.addRoot(v85, v86, v87) -- line 181 | captures: TestEnum
    local v88 = #v86
    local v89 = v85
    for v90 = v88, 1, -1 do
        local v91
        for v92, v93 in ipairs(v89.children) do
            if v93.phrase == v6[v90] then
                v91 = v93
                break
            end
            v91 = nil
        end
        if v91 == nil then
            v89 = v89:addChild(v6[v90], TestEnum.NodeType.Describe)
        else
            v89 = v91
        end
    end
    v89.callback = nil
    v89:expand()
end

function v75.visitAllNodes(v94, v95, v96, v97) -- line 202
    local v98 = v97 or 0
    for v99, v100 in ipairs((v96 or v94).children) do
        v95(v100, v98)
        v94:visitAllNodes(v95, v100, v98 + 1)
    end
end

function v75.visualize(v101) -- line 209
    local v102 = {}
    v101:visitAllNodes(function(v103, v104) -- line 211 | captures: v102
        local v105 = (" "):rep(3 * v104) .. v103.phrase
        table.insert(v102, v105)
    end)
    return table.concat(v102, "\n")
end

function v75.findNodes(v106, v107) -- line 217
    local v108 = {}
    v106:visitAllNodes(function(v109) -- line 219 | captures: v107, v108
        if v107(v109) then
            table.insert(v108, v109)
        end
    end)
    return v108
end

return v75
