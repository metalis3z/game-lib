-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Binding = require(script.Parent.Binding)
local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local SingleEventManager = require(script.Parent.SingleEventManager)
local getDefaultInstanceProperty = require(script.Parent.getDefaultInstanceProperty)
local Ref = require(script.Parent.PropMarkers.Ref)
local Type = require(script.Parent.Type)
local internalAssert = require(script.Parent.internalAssert)
local v1 = require(script.Parent.GlobalConfig).get()

local function identity(...) -- line 32
    return ...
end

local function applyRef(v2, v3) -- line 36 | captures: Binding, Type
    if v2 ~= nil then
        if typeof(v2) == "function" then
            v2(v3)
        elseif Type.of(v2) == Type.Binding then
            Binding.update(v2, v3)
        else
            error(("Invalid ref: Expected type Binding but got %s"):format((typeof(v2))))
        end
    end
end

local function setRobloxInstanceProperty(v4, v5, v6) -- line 53 | captures: getDefaultInstanceProperty
    local v7
    if v6 == nil then
        local ClassName = v4.ClassName
        local v8
        v8, v7 = getDefaultInstanceProperty(ClassName, v5)
    else
        v7 = v6
    end
    v4[v5] = v7
end

local function removeBinding(v9, v10) -- line 66
    v9.bindings[v10]()
    v9.bindings[v10] = nil
end

local function attachBinding(v11, v12, v13) -- line 72 | captures: Binding, getDefaultInstanceProperty, identity
    local function updateBoundProperty(v14) -- line 73 | captures: v11, v12, getDefaultInstanceProperty, identity
        local v15, v16 = xpcall(function() -- line 74 | captures: v14, v11, v12, getDefaultInstanceProperty
            local hostObject = v11.hostObject
            local v17 = v14
            if v14 == nil then
                local ClassName = hostObject.ClassName
                local v18
                v18, v17 = getDefaultInstanceProperty(ClassName, v12)
            end
            hostObject[v12] = v17
        end, identity)
        if v15 then
            return
        end
        local source = v11.currentElement.source
        if source == nil then
            source = "<enable element tracebacks>"
        end
        local v19 = ("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v16, source)
        error(v19, 0)
    end

    if v11.bindings == nil then
        v11.bindings = {}
    end
    v11.bindings[v12] = Binding.subscribe(v13, updateBoundProperty)
    updateBoundProperty(v13:getValue())
end

local function detachAllBindings(v20) -- line 99
    if v20.bindings ~= nil then
        for v21, v22 in pairs(v20.bindings) do
            v22()
        end
    end
end

local function applyProp(v23, v24, v25, v26) -- line 107 | captures: Children, SingleEventManager, getDefaultInstanceProperty, Ref, Type, attachBinding
    if not (v25 ~= v26) or v24 == Ref or v24 == Children then
        return
    end
    local v27 = Type.of(v24)
    if v27 ~= Type.HostEvent and v27 ~= Type.HostChangeEvent then
        local v28 = Type.of(v25) == Type.Binding
        if Type.of(v26) == Type.Binding then
            v23.bindings[v24]()
            v23.bindings[v24] = nil
        end
        if v28 then
            attachBinding(v23, v24, v25)
        else
            local hostObject = v23.hostObject
            local v29
            if v25 == nil then
                local ClassName = hostObject.ClassName
                local v30
                v30, v29 = getDefaultInstanceProperty(ClassName, v24)
            else
                v29 = v25
            end
            hostObject[v24] = v29
        end
    else
        if v23.eventManager == nil then
            v23.eventManager = SingleEventManager.new(v23.hostObject)
        end
        local name = v24.name
        if v27 == Type.HostChangeEvent then
            v23.eventManager:connectPropertyChange(name, v25)
        else
            v23.eventManager:connectEvent(name, v25)
        end
    end
end

local function applyProps(v31, v32) -- line 149 | captures: applyProp
    for v33, v34 in pairs(v32) do
        applyProp(v31, v33, v34, nil)
    end
end

local function updateProps(v35, v36, v37) -- line 155 | captures: applyProp
    for v38, v39 in pairs(v37) do
        local v40 = v36[v38]
        applyProp(v35, v38, v39, v40)
    end
    for v41, v42 in pairs(v36) do
        if v37[v41] == nil then
            applyProp(v35, v41, nil, v42)
        end
    end
end

local v43 = {
    isHostObject = function(v44) -- isHostObject | line 175
        return typeof(v44) == "Instance"
    end
}

function v43.mountHostNode(v45, v46) -- line 179 | captures: Children, ElementKind, Ref, internalAssert, v1, identity, applyRef, applyProps
    local currentElement = v46.currentElement
    local hostParent = v46.hostParent
    local hostKey = v46.hostKey
    if v1.internalTypeChecks then
        local v47 = ElementKind.of(currentElement) == ElementKind.Host
        internalAssert(v47, "Element at given node is not a host Element")
    end
    if v1.typeChecks then
        local v48 = currentElement.props.Name == nil
        assert(v48, "Name can not be specified as a prop to a host component in Roact.")
        local v49 = currentElement.props.Parent == nil
        assert(v49, "Parent can not be specified as a prop to a host component in Roact.")
    end
    local v50 = Instance.new(currentElement.component)
    v46.hostObject = v50
    local v51, v52 = xpcall(function() -- line 195 | captures: v46, currentElement, applyProps
        applyProps(v46, currentElement.props)
    end, identity)
    if not v51 then
        local source = currentElement.source
        if source == nil then
            source = "<enable element tracebacks>"
        end
        local v53 = ("Error applying props:\n\t%s\nIn element:\n%s\n"):format(v52, source)
        error(v53, 0)
    end
    v50.Name = tostring(hostKey)
    local v54 = currentElement.props[Children]
    if v54 ~= nil then
        v45.updateVirtualNodeWithChildren(v46, v46.hostObject, v54)
    end
    v50.Parent = hostParent
    v46.hostObject = v50
    applyRef(currentElement.props[Ref], v50)
    if v46.eventManager ~= nil then
        v46.eventManager:resume()
    end
end

function v43.unmountHostNode(v55, v56) -- line 228 | captures: Ref, applyRef
    local currentElement = v56.currentElement
    applyRef(currentElement.props[Ref], nil)
    for v57, v58 in pairs(v56.children) do
        v55.unmountVirtualNode(v58)
    end
    if v56.bindings ~= nil then
        for v59, v60 in pairs(v56.bindings) do
            v60()
        end
    end
    v56.hostObject:Destroy()
end

function v43.updateHostNode(v61, v62, v63) -- line 242 | captures: Children, Ref, identity, applyRef, updateProps
    local props = v62.currentElement.props
    local props_2 = v63.props
    if v62.eventManager ~= nil then
        v62.eventManager:suspend()
    end
    if props[Ref] ~= props_2[Ref] then
        applyRef(props[Ref], nil)
        applyRef(props_2[Ref], v62.hostObject)
    end
    local v64, v65 = xpcall(function() -- line 256 | captures: v62, props, props_2, updateProps
        updateProps(v62, props, props_2)
    end, identity)
    if not v64 then
        local source = v63.source
        if source == nil then
            source = "<enable element tracebacks>"
        end
        local v66 = ("Error updating props:\n\t%s\nIn element:\n%s\n"):format(v65, source)
        error(v66, 0)
    end
    local v67 = v63.props[Children]
    if not (v67 == nil and props[Children] == nil) then
        v61.updateVirtualNodeWithChildren(v62, v62.hostObject, v67)
    end
    if v62.eventManager ~= nil then
        v62.eventManager:resume()
    end
    return v62
end

return v43
