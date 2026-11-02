-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TestEnum = require(script.Parent.TestEnum)
local v1 = {}

v1[TestEnum.TestStatus.Success] = "+"
v1[TestEnum.TestStatus.Failure] = "-"
v1[TestEnum.TestStatus.Skipped] = "~"

local v2 = {}

v2.__index = v2

function v2.new(v3) -- line 13 | captures: v2
    local v4 = {
        successCount = 0,
        failureCount = 0,
        skippedCount = 0,
        planNode = v3,
        children = {},
        errors = {}
    }
    setmetatable(v4, v2)
    return v4
end

local function createNode(v5) -- line 25
    return {
        planNode = v5,
        children = {},
        errors = {}
    }
end

v2.createNode = createNode

local function visitAllNodes(v6, v7, v9) -- line 28
    for v10, v11 in ipairs((v9 or v6).children) do
        v7(v11)
        v6:visitAllNodes(v7, v11)
    end
end

v2.visitAllNodes = visitAllNodes

function v2.visualize(v12, v13, v14) -- line 34 | captures: TestEnum, v1
    local v15 = v14 or 0
    local v16 = {}
    for v17, v18 in ipairs((v13 or v12).children) do
        if v18.planNode.type == TestEnum.NodeType.It then
            local v19 = v1[v18.status] or "?"
            local v20 = ("%s[%s] %s"):format((" "):rep(3 * v15), v19, v18.planNode.phrase)
            if v18.messages and #v18.messages > 0 then
                v20 ..= "\n " .. (" "):rep(3 * v15) .. table.concat(v18.messages, "\n " .. (" "):rep(3 * v15))
            end
            table.insert(v16, v20)
        else
            local v21 = ("%s%s"):format((" "):rep(3 * v15), v18.planNode.phrase or "")
            if v18.status then
                v21 ..= (" (%s)"):format(v18.status)
            end
            table.insert(v16, v21)
            if #v18.children > 0 then
                local v22 = v8:visualize(v18, v15 + 1)
                table.insert(v16, v22)
            end
        end
    end
    return table.concat(v16, "\n")
end

return v2
