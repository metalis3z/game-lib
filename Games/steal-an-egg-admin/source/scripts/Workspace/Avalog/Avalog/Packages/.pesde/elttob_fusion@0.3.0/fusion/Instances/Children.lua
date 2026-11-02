-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local Observer = require(Parent.Graph.Observer)
local peek = require(Parent.State.peek)
local castToState = require(Parent.State.castToState)
local doCleanup = require(Parent.Memory.doCleanup)
local v1 = {
    type = "SpecialKey",
    kind = "Children",
    stage = "descendants"
}

function v1.apply(v2, v3, v4, v5) -- line 28 | captures: External, Observer, peek, castToState, doCleanup
    local v6 = v4
    local v7 = {}
    local v8 = {}
    local v9 = {}
    local v10 = {}
    local updateChildren

    local function updateChildren_2() -- line 44 | captures: v6, v7, v8, v9, v10, v5, updateChildren, External, Observer, peek, castToState, doCleanup
        local v11 = v7
        local v12 = v8
        v8 = v11
        v7 = v12
        local v13 = v9
        local v14 = v10
        v10 = v13
        v9 = v14
        local processChild

        local function processChild_2(v15, v16) -- line 48 | captures: processChild, v7, v8, v9, v10, v5, updateChildren, External, Observer, peek, castToState
            local v17 = typeof(v15)
            if v17 == "Instance" then
                v7[v15] = true
                if v8[v15] == nil then
                    v15.Parent = v5
                else
                    v8[v15] = nil
                end
            elseif castToState(v15) then
                local v18 = peek(v15)
                if v18 ~= nil then
                    processChild(v18, v16)
                end
                local v19 = v10[v15]
                if v19 == nil then
                    v19 = {}
                    Observer(v19, v15):onChange(updateChildren)
                else
                    v10[v15] = nil
                end
                v9[v15] = v19
            elseif v17 == "table" then
                for v20, v21 in pairs(v15) do
                    local v22 = typeof(v20)
                    local v23
                    if v22 == "string" then
                        v23 = v20
                    elseif v22 == "number" then
                        if v16 == nil then
                        else
                            v23 = v16 .. "_" .. v20
                        end
                    end
                    processChild(v21, v23)
                end
            else
                External.logWarn("unrecognisedChildType", v17)
            end
        end

        processChild = processChild_2
        if v6 ~= nil then
            processChild_2(v6)
        end
        for v24 in pairs(v8) do
            v24.Parent = nil
        end
        table.clear(v8)
        for v25, v26 in pairs(v10) do
            doCleanup(v26)
        end
        table.clear(v10)
    end

    updateChildren = updateChildren_2

    local function v27() -- line 140 | captures: v6, updateChildren_2
        v6 = nil
        updateChildren_2()
    end

    table.insert(v3, v27)
    updateChildren_2()
end

return v1
