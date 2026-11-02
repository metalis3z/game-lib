-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TableUtil = require(script.Parent.TableUtil)
local DeepEquals = require(script.DeepEquals)

local function CopyIfTable(v1) -- line 4 | captures: TableUtil
    if typeof(v1) == "table" then
        return TableUtil.Copy(v1, true)
    end
    return v1
end

local function Equals(v2, v3) -- line 12 | captures: DeepEquals
    if not (typeof(v2) == "table" and typeof(v3) == "table") then
        return v2 == v3
    end
    return DeepEquals(v2, v3)
end

local function ProcessObserver(v4, v5, v6, v7) -- line 20 | captures: DeepEquals
    if v4.Specifier == nil then
        v4.Callback(v5, v6)
    else
        local v8 = v4.Specifier(v5)
        local v9 = v4.Specifier(v6)
        if not v7 then
            local v10
            if typeof(v8) == "table" and typeof(v9) == "table" then
                v10 = DeepEquals(v8, v9)
            else
                v10 = v8 == v9
            end
            if v10 then
                return
            end
        end
        v4.Callback(v8, v9)
    end
end

local function NewStator(v11, v12) -- line 34 | captures: CopyIfTable, ProcessObserver
    local v13 = {
        Value = v11,
        Updaters = v12,
        Observers = {}
    }

    function v13.Observe(v14, v15, v16) -- line 41 | captures: v13, ProcessObserver
        local v17 = v13:Get()
        local v18 = {
            Callback = v15,
            Specifier = v16
        }
        local Observers = v13.Observers
        table.insert(Observers, v18)
        ProcessObserver(v18, v17, v17)
        return function() -- line 52 | captures: v18, v13
            local v19 = table.find(v13.Observers, v18)
            if v19 ~= nil then
                table.remove(v13.Observers, v19)
            end
        end
    end

    function v13.Update(v20, v21) -- line 60 | captures: v13, CopyIfTable, ProcessObserver
        local v22 = v13:Get()
        local v23 = v21(CopyIfTable(v22))
        v13.Value = v23
        for v24, v25 in ipairs(v13.Observers) do
            ProcessObserver(v25, v22, v23)
        end
    end

    function v13.Get(v26) -- line 71 | captures: v13, CopyIfTable
        return CopyIfTable(v13.Value)
    end

    return v13
end

return NewStator
