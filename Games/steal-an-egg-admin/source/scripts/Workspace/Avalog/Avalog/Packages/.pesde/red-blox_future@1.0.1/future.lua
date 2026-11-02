-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Spawn = require(script.Parent.Spawn)

local function IsComplete(v1) -- line 20
    return v1.ValueList ~= nil
end

local function IsPending(v2) -- line 24
    return v2.ValueList == nil
end

local function Expect(v3, v4) -- line 28
    local ValueList = v3.ValueList
    assert(ValueList, v4)
    local ValueList_2 = v3.ValueList
    return table.unpack(ValueList_2)
end

local function Unwrap(v5) -- line 34
    return v5:Expect("Attempt to unwrap pending future!")
end

local function UnwrapOr(v6, ...) -- line 38
    if v6.ValueList then
        local ValueList = v6.ValueList
        return table.unpack(ValueList)
    end
    return ...
end

local function UnwrapOrElse(v7, v8) -- line 46
    if v7.ValueList then
        local ValueList = v7.ValueList
        return table.unpack(ValueList)
    end
    return v8()
end

local function After(v9, v10) -- line 54 | captures: Spawn
    if v9.ValueList then
        local ValueList = v9.ValueList
        Spawn(v10, table.unpack(ValueList))
    else
        local AfterList = v9.AfterList
        table.insert(AfterList, v10)
    end
end

local function Await(v11) -- line 62
    local function v12(v13, ...)
        table.insert(v13, ...)
    end

    if v11.ValueList then
        local ValueList = v11.ValueList
        return table.unpack(ValueList)
    end
    v12(v11.YieldList, coroutine.running())
    return coroutine.yield()
end

local function Future(v14, ...) -- line 72 | captures: Spawn, IsComplete, IsPending, Expect, Unwrap, UnwrapOr, UnwrapOrElse, After, Await
    local v15 = {
        ValueList = nil,
        AfterList = {},
        YieldList = {},
        IsComplete = IsComplete,
        IsPending = IsPending,
        Expect = Expect,
        Unwrap = Unwrap,
        UnwrapOr = UnwrapOr,
        UnwrapOrElse = UnwrapOrElse,
        After = After,
        Await = Await
    }
    Spawn(function(v16, v17, ...) -- line 90 | captures: Spawn
        local v18 = { v17(...) }
        v16.ValueList = v18
        for v19, v20 in v16.YieldList do
            task.spawn(v20, table.unpack(v18))
        end
        for v21, v22 in v16.AfterList do
            Spawn(v22, table.unpack(v18))
        end
    end, v15, v14, ...)
    return v15
end

return {
    new = Future,
    Try = function(v23, ...) -- Try | line 106 | captures: Future
        return Future(pcall, v23, ...)
    end
}
