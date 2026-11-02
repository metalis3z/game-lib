-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local createSignal = require(script.Parent.createSignal)
local Symbol = require(script.Parent.Symbol)
local Type = require(script.Parent.Type)
local v1 = require(script.Parent.GlobalConfig).get()
local BindingImpl = Symbol.named("BindingImpl")
local v2 = {}
local v3 = {}

function v3.getValue(v4) -- line 13 | captures: v2
    return v2.getValue(v4)
end

function v3.map(v5, v6) -- line 17 | captures: v2
    return v2.map(v5, v6)
end

local v7 = {
    __index = v3,
    __tostring = function(v8) -- __tostring | line 23
        local function v9(...)
            return (tostring(...))
        end

        return string.format("RoactBinding(%s)", (v9(v8:getValue())))
    end
}

function v2.update(v10, v11) -- line 28 | captures: BindingImpl
    return v10[BindingImpl].update(v11)
end

function v2.subscribe(v12, v13) -- line 32 | captures: BindingImpl
    return v12[BindingImpl].subscribe(v13)
end

function v2.getValue(v14) -- line 36 | captures: BindingImpl
    return v14[BindingImpl].getValue()
end

function v2.create(v15) -- line 40 | captures: createSignal, Type, BindingImpl, v7
    local v16 = {
        value = v15,
        changeSignal = createSignal()
    }

    function v16.subscribe(v17) -- line 46 | captures: v16
        return v16.changeSignal:subscribe(v17)
    end

    function v16.update(v18) -- line 50 | captures: v16
        v16.value = v18
        v16.changeSignal:fire(v18)
    end

    function v16.getValue() -- line 55 | captures: v16
        return v16.value
    end

    local v19 = {}
    v19[Type] = Type.Binding
    v19[BindingImpl] = v16
    return setmetatable(v19, v7), v16.update
end

function v2.map(v20, v21) -- line 65 | captures: Type, v1, BindingImpl, v2, v7
    if v1.typeChecks then
        local v22 = Type.of(v20) == Type.Binding
        assert(v22, "Expected arg #1 to be a binding")
        local v23 = typeof(v21) == "function"
        assert(v23, "Expected arg #1 to be a function")
    end
    local v24 = {}

    function v24.subscribe(v25) -- line 73 | captures: v20, v21, v2
        return v2.subscribe(v20, function(v26) -- line 74 | captures: v25, v21
            v25(v21(v26))
        end)
    end

    function v24.update(v27) -- line 79
        error("Bindings created by Binding:map(fn) cannot be updated directly", 2)
    end

    function v24.getValue() -- line 83 | captures: v20, v21
        return v21(v20:getValue())
    end

    local v28 = {}
    v28[Type] = Type.Binding
    v28[BindingImpl] = v24
    return (setmetatable(v28, v7))
end

function v2.join(v29) -- line 93 | captures: Type, v1, BindingImpl, v2, v7
    if v1.typeChecks then
        local v30 = typeof(v29) == "table"
        assert(v30, "Expected arg #1 to be of type table")
        for v31, v32 in pairs(v29) do
            if Type.of(v32) ~= Type.Binding then
                local v33 = ("Expected arg #1 to contain only bindings, but key %q had a non-binding value"):format((tostring(v31)))
                error(v33, 2)
            end
        end
    end
    local v34 = {}

    local function getValue() -- line 111 | captures: v29
        local v35 = {}
        for v36, v37 in pairs(v29) do
            v35[v36] = v37:getValue()
        end
        return v35
    end

    function v34.subscribe(v38) -- line 121 | captures: v29, getValue, v2
        local v39 = {}
        local v40 = v39
        for v41, v42 in pairs(v29) do
            local subscribe = v2.subscribe
            v39[v41] = subscribe(v42, function(v43) -- line 125 | captures: v38, getValue
                v38((getValue()))
            end)
        end
        return function() -- line 130 | captures: v40
            if v40 ~= nil then
                for v44, v45 in pairs(v40) do
                    v45()
                end
                v40 = nil
            end
        end
    end

    function v34.update(v46) -- line 143
        error("Bindings created by joinBindings(...) cannot be updated directly", 2)
    end

    function v34.getValue() -- line 147 | captures: getValue
        return (getValue())
    end

    local v47 = {}
    v47[Type] = Type.Binding
    v47[BindingImpl] = v34
    return (setmetatable(v47, v7))
end

return v2
