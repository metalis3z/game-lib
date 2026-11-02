-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Symbol = require(script.Parent.Symbol)
local createFragment = require(script.Parent.createFragment)
local createSignal = require(script.Parent.createSignal)
local Children = require(script.Parent.PropMarkers.Children)
local Component = require(script.Parent.Component)

local function createContextEntry(v1) -- line 10 | captures: createSignal
    return {
        value = v1,
        onUpdate = createSignal()
    }
end

local function createProvider(v2) -- line 17 | captures: createFragment, createSignal, Children, Component
    local Provider = Component:extend("Provider")

    function Provider.init(v3, v4) -- line 20 | captures: v2, createSignal
        v3.contextEntry = {
            value = v4.value,
            onUpdate = createSignal()
        }
        v3:__addContext(v2.key, v3.contextEntry)
    end

    function Provider.willUpdate(v5, v6) -- line 25
        if v6.value ~= v5.props.value then
            v5.contextEntry.value = v6.value
        end
    end

    function Provider.didUpdate(v7, v8) -- line 36
        if v8.value ~= v7.props.value then
            v7.contextEntry.onUpdate:fire(v7.props.value)
        end
    end

    function Provider.render(v9) -- line 51 | captures: createFragment, Children
        return createFragment(v9.props[Children])
    end

    return Provider
end

local function createConsumer(v10) -- line 58 | captures: Component
    local Consumer = Component:extend("Consumer")

    function Consumer.validateProps(v11) -- line 61
        local render = v11.render
        if type(render) == "function" then
            return true
        end
        return false, "Consumer expects a `render` function"
    end

    function Consumer.init(v12, v13) -- line 69 | captures: v10
        v12.contextEntry = v12:__getContext(v10.key)
    end

    function Consumer.render(v14) -- line 75 | captures: v10
        local v15 = if v14.contextEntry == nil then v10.defaultValue else v14.contextEntry.value
        return v14.props.render(v15)
    end

    function Consumer.didUpdate(v16) -- line 90
        if v16.contextEntry ~= nil then
            v16.lastValue = v16.contextEntry.value
        end
    end

    function Consumer.didMount(v17) -- line 99
        if v17.contextEntry ~= nil then
            local onUpdate = v17.contextEntry.onUpdate
            v17.disconnect = onUpdate:subscribe(function(v18) -- line 110 | captures: v17
                if v18 ~= v17.lastValue then
                    v17:setState({})
                end
            end)
        end
    end

    function Consumer.willUnmount(v19) -- line 119
        if v19.disconnect ~= nil then
            v19.disconnect()
        end
    end

    return Consumer
end

local v20 = {}

v20.__index = v20

function v20.new(v21) -- line 131 | captures: Symbol, v20
    local v22 = {
        defaultValue = v21,
        key = Symbol.named("ContextKey")
    }
    return (setmetatable(v22, v20))
end

local function __tostring(v23) -- line 138
    return "RoactContext"
end

v20.__tostring = __tostring

local function createContext(v24) -- line 142 | captures: createProvider, createConsumer, v20
    local v25 = v20.new(v24)
    return {
        Provider = createProvider(v25),
        Consumer = createConsumer(v25)
    }
end

return createContext
