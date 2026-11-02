-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local assign = require(script.Parent.assign)
local ComponentLifecyclePhase = require(script.Parent.ComponentLifecyclePhase)
local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)
local invalidSetStateMessages = require(script.Parent.invalidSetStateMessages)
local internalAssert = require(script.Parent.internalAssert)
local v1 = require(script.Parent.GlobalConfig).get()
local InternalData = Symbol.named("InternalData")
local v2 = {
    __tostring = function(v3) -- __tostring | line 29
        return v3.__componentName
    end
}
local v4 = {}
setmetatable(v4, v2)
v4[Type] = Type.StatefulComponentClass
v4.__index = v4
v4.__componentName = "Component"

function v4.extend(v5, v6) -- line 45 | captures: Type, v1, v2
    if v1.typeChecks then
        local v7 = Type.of(v5) == Type.StatefulComponentClass
        assert(v7, "Invalid `self` argument to `extend`.")
        local v8 = typeof(v6) == "string"
        assert(v8, "Component class name must be a string")
    end
    local v9 = {}
    for v10, v11 in pairs(v5) do
        if v10 ~= "extend" then
            v9[v10] = v11
        end
    end
    v9[Type] = Type.StatefulComponentClass
    v9.__index = v9
    v9.__componentName = v6
    setmetatable(v9, v2)
    return v9
end

function v4.__getDerivedState(v12, v13, v14) -- line 71 | captures: Type, internalAssert, v1, InternalData
    if v1.internalTypeChecks then
        local v15 = Type.of(v12) == Type.StatefulComponentInstance
        internalAssert(v15, "Invalid use of `__getDerivedState`")
    end
    local componentClass = v12[InternalData].componentClass
    local v16, v17
    if componentClass.getDerivedStateFromProps == nil then
        v17 = true
    else
        v16 = componentClass.getDerivedStateFromProps(v13, v14)
        if v16 == nil then
            v17 = true
        else
            if v1.typeChecks then
                local v18 = typeof(v16) == "table"
                local v19 = "getDerivedStateFromProps must return a table!"
                assert(v18, v19)
            end
            v17 = false
        end
    end
    if not v17 then
        return v16
    end
    return nil
end

function v4.setState(v20, v21) -- line 94 | captures: assign, ComponentLifecyclePhase, Type, invalidSetStateMessages, v1, InternalData
    if v1.typeChecks then
        local v22 = Type.of(v20) == Type.StatefulComponentInstance
        assert(v22, "Invalid `self` argument to `extend`.")
    end
    local v23 = v20[InternalData]
    local lifecyclePhase = v23.lifecyclePhase
    if not (lifecyclePhase ~= ComponentLifecyclePhase.ShouldUpdate and lifecyclePhase ~= ComponentLifecyclePhase.WillUpdate and lifecyclePhase ~= ComponentLifecyclePhase.Render and lifecyclePhase ~= ComponentLifecyclePhase.WillUnmount) then
        local v24 = invalidSetStateMessages[v23.lifecyclePhase]
        local componentClass = v23.componentClass
        local v25 = v24:format((tostring(componentClass)))
        error(v25, 2)
    end
    local pendingState = v23.pendingState
    local v26
    if typeof(v21) == "function" then
        v26 = v21(pendingState or v20.state, v20.props)
        if v26 == nil then
            return
        end
    elseif typeof(v21) == "table" then
        v26 = v21
    else
        error("Invalid argument to setState, expected function or table", 2)
    end
    local v27
    if pendingState == nil then
        v27 = assign({}, v20.state, v26)
    else
        v27 = assign(pendingState, v26)
    end
    if lifecyclePhase == ComponentLifecyclePhase.Init then
        local v28 = v20:__getDerivedState(v20.props, v27)
        v20.state = assign(v27, v28)
    elseif lifecyclePhase ~= ComponentLifecyclePhase.DidMount and lifecyclePhase ~= ComponentLifecyclePhase.DidUpdate and lifecyclePhase ~= ComponentLifecyclePhase.ReconcileChildren then
        if lifecyclePhase == ComponentLifecyclePhase.Idle then
            v20:__update(nil, v27)
        else
            local default = invalidSetStateMessages.default
            local componentClass = v23.componentClass
            local v29 = default:format((tostring(componentClass)))
            error(v29, 2)
        end
    else
        local v30 = v20:__getDerivedState(v20.props, v27)
        v23.pendingState = assign(v27, v30)
    end
end

function v4.getElementTraceback(v31) -- line 178 | captures: InternalData
    return v31[InternalData].virtualNode.currentElement.source
end

function v4.render(v32) -- line 189 | captures: InternalData
    local componentClass = v32[InternalData].componentClass
    local v33 = ("The component %q is missing the `render` method.\n`render` must be defined when creating a Roact component!"):format((tostring(componentClass)))
    error(v33, 0)
end

function v4.__getContext(v34, v35) -- line 203 | captures: Type, internalAssert, v1, InternalData
    if v1.internalTypeChecks then
        local v36 = Type.of(v34) == Type.StatefulComponentInstance
        internalAssert(v36, "Invalid use of `__getContext`")
        internalAssert(v35 ~= nil, "Context key cannot be nil")
    end
    return v34[InternalData].virtualNode.context[v35]
end

function v4.__addContext(v37, v38, v39) -- line 219 | captures: assign, Type, internalAssert, v1, InternalData
    if v1.internalTypeChecks then
        local v40 = Type.of(v37) == Type.StatefulComponentInstance
        internalAssert(v40, "Invalid use of `__addContext`")
    end
    local virtualNode = v37[InternalData].virtualNode
    if virtualNode.originalContext == nil then
        virtualNode.originalContext = virtualNode.context
    end
    local context = virtualNode.context
    virtualNode.context = assign({}, context, { [v38] = v39 })
end

function v4.__validateProps(v41, v42) -- line 246 | captures: v1, InternalData
    if v1.propValidation then
        local validateProps = v41[InternalData].componentClass.validateProps
        if validateProps ~= nil then
            if typeof(validateProps) ~= "function" then
                error(("validateProps must be a function, but it is a %s.\nCheck the definition of the component %q."):format(typeof(validateProps), v41.__componentName))
            end
            local v43, v44 = validateProps(v42)
            if not v43 then
                local v45 = v44 or "<Validator function did not supply a message>"
                error(("Property validation failed in %s: %s\n\n%s"):format(v41.__componentName, tostring(v45), v41:getElementTraceback() or "<enable element tracebacks>"), 0)
            end
        end
    end
end

function v4.__mount(v46, v47, v48) -- line 280 | captures: assign, ComponentLifecyclePhase, Type, internalAssert, v1, InternalData
    if v1.internalTypeChecks then
        local v49 = Type.of(v46) == Type.StatefulComponentClass
        internalAssert(v49, "Invalid use of `__mount`")
        internalAssert(Type.of(v48) == Type.VirtualNode, "Expected arg #2 to be of type VirtualNode")
    end
    local currentElement = v48.currentElement
    local hostParent = v48.hostParent
    local v50 = {
        reconciler = v47,
        virtualNode = v48,
        componentClass = v46,
        lifecyclePhase = ComponentLifecyclePhase.Init
    }
    local v51 = {}
    v51[Type] = Type.StatefulComponentInstance
    v51[InternalData] = v50
    setmetatable(v51, v46)
    v48.instance = v51
    local props = currentElement.props
    if v46.defaultProps ~= nil then
        props = assign({}, v46.defaultProps, props)
    end
    v51:__validateProps(props)
    v51.props = props
    v51._context = assign({}, v48.legacyContext)
    v51.state = assign({}, v51:__getDerivedState(v51.props, {}))
    if v51.init ~= nil then
        v51:init(v51.props)
        assign(v51.state, v51:__getDerivedState(v51.props, v51.state))
    end
    v48.legacyContext = v51._context
    v50.lifecyclePhase = ComponentLifecyclePhase.Render
    local v52 = v51:render()
    v50.lifecyclePhase = ComponentLifecyclePhase.ReconcileChildren
    v47.updateVirtualNodeWithRenderResult(v48, hostParent, v52)
    if v51.didMount ~= nil then
        v50.lifecyclePhase = ComponentLifecyclePhase.DidMount
        v51:didMount()
    end
    if v50.pendingState ~= nil then
        v51:__update(nil, nil)
    end
    v50.lifecyclePhase = ComponentLifecyclePhase.Idle
end

function v4.__unmount(v53) -- line 353 | captures: ComponentLifecyclePhase, Type, internalAssert, v1, InternalData
    if v1.internalTypeChecks then
        local v54 = Type.of(v53) == Type.StatefulComponentInstance
        internalAssert(v54, "Invalid use of `__unmount`")
    end
    local v55 = v53[InternalData]
    local virtualNode = v55.virtualNode
    local reconciler = v55.reconciler
    if v53.willUnmount ~= nil then
        v55.lifecyclePhase = ComponentLifecyclePhase.WillUnmount
        v53:willUnmount()
    end
    for v56, v57 in pairs(virtualNode.children) do
        reconciler.unmountVirtualNode(v57)
    end
end

function v4.__update(v58, v59, v60) -- line 378 | captures: assign, Type, internalAssert, v1, InternalData
    if v1.internalTypeChecks then
        local v61 = Type.of(v58) == Type.StatefulComponentInstance
        internalAssert(v61, "Invalid use of `__update`")
        local v62 = if Type.of(v59) == Type.Element then true else v59 == nil
        internalAssert(v62, "Expected arg #1 to be of type Element or nil")
        local v63 = if typeof(v60) == "table" then true else v60 == nil
        internalAssert(v63, "Expected arg #2 to be of type table or nil")
    end
    local v64 = v58[InternalData]
    local componentClass = v64.componentClass
    local props = v58.props
    local props_2
    if v59 == nil then
        props_2 = props
    else
        local props = v59.props
        if componentClass.defaultProps ~= nil then
            props = assign({}, componentClass.defaultProps, props)
        end
        v58:__validateProps(props)
        props_2 = props
    end
    local v65 = v60
    local v66 = 0
    while true do
        local pendingState
        if v64.pendingState == nil then
        else
            pendingState = v64.pendingState
            v64.pendingState = nil
        end
        if not (v65 == nil and props_2 == v58.props) then
            local v67
            if pendingState == nil then
                v67 = v65 or v58.state
            else
                v67 = assign(pendingState, v65)
            end
            local v68 = v58:__getDerivedState(props_2, v67)
            if v68 == nil then
                pendingState = v67
            else
                pendingState = assign({}, v67, v68)
            end
            v65 = nil
        end
        local v69
        if v58:__resolveUpdate(props_2, pendingState) then
            v69 = v66 + 1
            if v69 > 100 then
                local error_2 = error
                local componentClass = v64.componentClass
                error_2(("The component %q has reached the setState update recursion limit.\nWhen using `setState` in `didUpdate`, make sure that it won't repeat infinitely!"):format((tostring(componentClass))), 3)
            end
        else
            break
        end
        if v64.pendingState == nil then
            return true
        end
        v66 = v69
    end
    return false
end

function v4.__resolveUpdate(v70, v71, v72) -- line 455 | captures: ComponentLifecyclePhase, Type, internalAssert, v1, InternalData
    if v1.internalTypeChecks then
        local v73 = Type.of(v70) == Type.StatefulComponentInstance
        internalAssert(v73, "Invalid use of `__resolveUpdate`")
    end
    local v74 = v70[InternalData]
    local virtualNode = v74.virtualNode
    local reconciler = v74.reconciler
    local props = v70.props
    local state = v70.state
    local v75 = if v71 == nil then props else v71
    local v76 = if v72 == nil then state else v72
    local v77 = v70.shouldUpdate == nil
    local v78
    if not v77 then
        v74.lifecyclePhase = ComponentLifecyclePhase.ShouldUpdate
        v78 = v70:shouldUpdate(v75, v76)
    end
    if v77 or v78 then
        if v70.willUpdate ~= nil then
            v74.lifecyclePhase = ComponentLifecyclePhase.WillUpdate
            v70:willUpdate(v75, v76)
        end
        v74.lifecyclePhase = ComponentLifecyclePhase.Render
        v70.props = v75
        v70.state = v76
        local v79 = virtualNode.instance:render()
        v74.lifecyclePhase = ComponentLifecyclePhase.ReconcileChildren
        reconciler.updateVirtualNodeWithRenderResult(virtualNode, virtualNode.hostParent, v79)
        if v70.didUpdate ~= nil then
            v74.lifecyclePhase = ComponentLifecyclePhase.DidUpdate
            v70:didUpdate(props, state)
        end
        v74.lifecyclePhase = ComponentLifecyclePhase.Idle
        return true
    end
    v74.lifecyclePhase = ComponentLifecyclePhase.Idle
    return false
end

return v4
