-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function _merge1(v1, v2, v3) -- line 6
    if v2.Left then
        v2.Right = _merge(v1, v2.Right, v3)
        if v2.Left.Npl < v2.Right.Npl then
            local Left = v2.Left
            v2.Left = v2.Right
            v2.Right = Left
        end
        v2.Npl = v2.Right.Npl + 1
    else
        v2.Left = v3
    end
    return v2
end

function _merge(v4, v5, v6) -- line 21
    if v5 then
        if v6 then
            if v4(v5.Value, v6.Value) < 0 then
                return _merge1(v4, v5, v6)
            end
            return _merge1(v4, v6, v5)
        end
        return v5
    end
    return v6
end

local v7 = {}
local v8 = table.freeze({ __index = v7 })

function v7.Merge(v9, v10) -- line 36
    if v9.Root ~= v10.Root then
        v9.Root = _merge(v9.Comparator, v9.Root, v10.Root)
        v10.Root = nil
    end
end

function v7.Insert(v11, v12) -- line 42
    v11.Root = _merge(v11.Comparator, {
        Npl = 0,
        Value = v12
    }, v11.Root)
end

function v7.Min(v13) -- line 45
    local Root = v13.Root
    assert(Root)
    return v13.Root.Value
end

function v7.TryMin(v14) -- line 49
    if v14.Root then
        return true, v14.Root.Value
    end
    return false, nil
end

function v7.Pop(v15) -- line 55
    local Root = v15.Root
    assert(Root)
    v15.Root = _merge(v15.Comparator, v15.Root.Left, v15.Root.Right)
    return v15.Root.Value
end

function v7.TryPop(v16) -- line 60
    if v16.Root then
        v16.Root = _merge(v16.Comparator, v16.Root.Left, v16.Root.Right)
        return true, v16.Root.Value
    end
    return false, nil
end

function v7.PopFast(v17) -- line 67
    v17.Root = _merge(v17.Comparator, v17.Root.Left, v17.Root.Right)
end

function v7.Empty(v18) -- line 70
    return v18.Root == nil
end

function v7.Clear(v19) -- line 74
    v19.Root = nil
end

table.freeze(v7)
local v20 = {
    Compare = function(v21, v22) -- Compare | line 79
        if v21 < v22 then
            return -1
        end
        if v22 < v21 then
            return 1
        end
        return 0
    end
}

function v20.new(v23, v24) -- line 89 | captures: v8
    local v25 = type(v23) == "function"
    assert(v25)
    local v26 = { Comparator = v23 }
    return (setmetatable(v26, v8))
end

return table.freeze(v20)
