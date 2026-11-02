-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("RunService")
local Promise = require(script.Parent.Parent.Parent.Promise)
local v1 = {
    Error = {
        Unparented = "Unparented",
        ParentChanged = "ParentChanged"
    }
}

local function PromiseWatchAncestry(v2, v3) -- line 11 | captures: Promise, v1
    local v4 = {}
    local v5 = Promise.fromEvent(v2.AncestryChanged, function(v6, v7) -- line 13
        return v7 == nil
    end)
    v4[1] = v3
    v4[2] = v5:andThen(function() -- line 18 | captures: Promise, v1
        return Promise.reject(v1.Error.Unparented)
    end)
    return Promise.race(v4)
end

function v1.Child(v8, v9, v10) -- line 23 | captures: Promise, PromiseWatchAncestry
    local v11 = v8:FindFirstChild(v9)
    if v11 then
        return Promise.resolve(v11)
    end
    local v12 = Promise.fromEvent(v8.ChildAdded, function(v13) -- line 28 | captures: v9
        return v13.Name == v9
    end)
    return PromiseWatchAncestry(v8, v12:timeout(v10 or 120))
end

function v1.ChildWhichIsA(v14, v15, v16) -- line 34 | captures: Promise, PromiseWatchAncestry
    local v17 = v14:FindFirstChildWhichIsA(v15)
    if v17 then
        return Promise.resolve(v17)
    end
    local v18 = Promise.fromEvent(v14.ChildAdded, function(v19) -- line 39 | captures: v15
        return v19:IsA(v15)
    end)
    return PromiseWatchAncestry(v14, v18:timeout(v16 or 120))
end

function v1.Children(v20, v21, v22) -- line 44 | captures: Promise, v1
    local v23 = table.create(#v21)
    for v24, v25 in ipairs(v21) do
        v23[v24] = v1.Child(v20, v25, v22)
    end
    return Promise.all(v23):andThen(function(v26) -- line 49 | captures: v20, Promise, v1
        for v27, v28 in ipairs(v26) do
            if v28.Parent ~= v20 then
                return Promise.reject(v1.Error.ParentChanged)
            end
        end
        return v26
    end)
end

function v1.Descendant(v29, v30, v31) -- line 58 | captures: Promise, PromiseWatchAncestry
    local v32 = v29:FindFirstChild(v30, true)
    if v32 then
        return Promise.resolve(v32)
    end
    local v33 = Promise.fromEvent(v29.DescendantAdded, function(v34) -- line 63 | captures: v30
        return v34.Name == v30
    end)
    return PromiseWatchAncestry(v29, v33:timeout(v31 or 120))
end

function v1.Descendants(v35, v36, v37) -- line 69 | captures: Promise, v1
    local v38 = table.create(#v36)
    for v39, v40 in ipairs(v36) do
        v38[v39] = v1.Descendant(v35, v40, v37)
    end
    return Promise.all(v38):andThen(function(v41) -- line 74 | captures: v35, Promise, v1
        for v42, v43 in ipairs(v41) do
            if not v43:IsDescendantOf(v35) then
                return Promise.reject(v1.Error.ParentChanged)
            end
        end
        return v41
    end)
end

function v1.PrimaryPart(v44, v45) -- line 83 | captures: Promise, PromiseWatchAncestry
    local PrimaryPart = v44.PrimaryPart
    local PrimaryPart_2 = PrimaryPart
    if PrimaryPart then
        return Promise.resolve(PrimaryPart)
    end
    local PrimaryPart_3 = v44:GetPropertyChangedSignal("PrimaryPart")
    local v46 = Promise.fromEvent(PrimaryPart_3, function() -- line 89 | captures: PrimaryPart_2, v44
        PrimaryPart_2 = v44.PrimaryPart
        return PrimaryPart_2 ~= nil
    end):andThen(function() -- line 94 | captures: PrimaryPart_2
        return PrimaryPart_2
    end)
    return PromiseWatchAncestry(v44, v46:timeout(v45 or 120))
end

function v1.ObjectValue(v47, v48) -- line 99 | captures: Promise, PromiseWatchAncestry
    local Value = v47.Value
    local v49 = Value
    if Value then
        return Promise.resolve(Value)
    end
    local v50 = Promise.fromEvent(v47.Changed, function(v51) -- line 104 | captures: v49
        v49 = v51
        return v49 ~= nil
    end):andThen(function() -- line 109 | captures: v49
        return v49
    end)
    return PromiseWatchAncestry(v47, v50:timeout(v48 or 120))
end

function v1.Custom(v52, v53) -- line 114 | captures: Promise
    local v54 = v52()
    if v54 == nil then
        return Promise.new(function(v55, v56, v57) -- line 119
            v57(function() -- line 121
                (nil):Disconnect()
            end)
        end):timeout(v53 or 120)
    end
    return Promise.resolve(v54)
end

return v1
