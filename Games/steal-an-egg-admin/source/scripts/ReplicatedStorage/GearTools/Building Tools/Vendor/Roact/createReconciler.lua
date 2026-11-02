-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Type = require(script.Parent.Type)
local ElementKind = require(script.Parent.ElementKind)
local ElementUtils = require(script.Parent.ElementUtils)
local Children = require(script.Parent.PropMarkers.Children)
local Symbol = require(script.Parent.Symbol)
local internalAssert = require(script.Parent.internalAssert)
local v1 = require(script.Parent.GlobalConfig).get()
local InternalData = Symbol.named("InternalData")

local function createReconciler(v2) -- line 24 | captures: Type, ElementKind, ElementUtils, Children, internalAssert, v1, InternalData
    local v3, v4, v5, v6

    local function replaceVirtualNode(v7, v8) -- line 36 | captures: v4, v6
        local hostParent = v7.hostParent
        local hostKey = v7.hostKey
        local depth = v7.depth
        local v9 = v7.originalContext or v7.context
        local parentLegacyContext = v7.parentLegacyContext
        v6(v7)
        local v10 = v4(v8, hostParent, hostKey, v9, parentLegacyContext)
        if v10 ~= nil then
            v10.depth = depth
        end
        return v10
    end

    local function updateChildren(v11, v12, v13) -- line 62 | captures: v4, v5, Type, ElementUtils, internalAssert, v1
        if v1.internalTypeChecks then
            local v14 = Type.of(v11) == Type.VirtualNode
            internalAssert(v14, "Expected arg #1 to be of type VirtualNode")
        end
        local v15 = {}
        for v16, v17 in pairs(v11.children) do
            local v18 = ElementUtils.getElementByKey(v13, v16)
            local v19 = v5(v17, v18)
            if v19 == nil then
                v15[v16] = true
            else
                v11.children[v16] = v19
            end
        end
        for v20 in pairs(v15) do
            v11.children[v20] = nil
        end
        for v21, v22 in ElementUtils.iterateElements(v13) do
            local v23 = if v21 == ElementUtils.UseParentKey then v11.hostKey else v21
            if v11.children[v21] == nil then
                local v24 = v4(v22, v12, v23, v11.context, v11.legacyContext)
                if v24 ~= nil then
                    v24.depth = v11.depth + 1
                    v11.children[v21] = v24
                end
            end
        end
    end

    local function updateVirtualNodeWithChildren(v25, v26, v27) -- line 110 | captures: updateChildren
        updateChildren(v25, v26, v27)
    end

    local function updateVirtualNodeWithRenderResult(v28, v29, v30) -- line 114 | captures: updateChildren, Type
        if Type.of(v30) ~= Type.Element and v30 ~= nil and typeof(v30) ~= "boolean" then
            error(("%s\n%s"):format("Component returned invalid children:", v28.currentElement.source or "<enable element tracebacks>"), 0)
        else
            updateChildren(v28, v29, v30)
        end
    end

    function v6(v31) -- line 131 | captures: v3, v6, v2, Type, ElementKind, internalAssert, v1
        if v1.internalTypeChecks then
            local v32 = Type.of(v31) == Type.VirtualNode
            internalAssert(v32, "Expected arg #1 to be of type VirtualNode")
        end
        local v33 = ElementKind.of(v31.currentElement)
        if v33 == ElementKind.Host then
            v2.unmountHostNode(v3, v31)
        elseif v33 == ElementKind.Function then
            for v34, v35 in pairs(v31.children) do
                v6(v35)
            end
        elseif v33 == ElementKind.Stateful then
            v31.instance:__unmount()
        elseif v33 == ElementKind.Portal then
            for v36, v37 in pairs(v31.children) do
                v6(v37)
            end
        elseif v33 == ElementKind.Fragment then
            for v38, v39 in pairs(v31.children) do
                v6(v39)
            end
        else
            error(("Unknown ElementKind %q"):format(tostring(v33), 2))
        end
    end

    local function updateFunctionVirtualNode(v40, v41) -- line 159 | captures: updateVirtualNodeWithRenderResult
        local v42 = v41.component(v41.props)
        updateVirtualNodeWithRenderResult(v40, v40.hostParent, v42)
        return v40
    end

    local function updatePortalVirtualNode(v43, v44) -- line 167 | captures: v4, v6, v2, updateChildren, Children
        local target = v43.currentElement.props.target
        local target_2 = v44.props.target
        local v45 = v2.isHostObject(target_2)
        assert(v45, "Expected target to be host object")
        if target_2 == target then
            local v46 = v44.props[Children]
            updateChildren(v43, target_2, v46)
            return v43
        end
        local hostParent = v43.hostParent
        local hostKey = v43.hostKey
        local depth = v43.depth
        local v47 = v43.originalContext or v43.context
        local parentLegacyContext = v43.parentLegacyContext
        v6(v43)
        local v48 = v4(v44, hostParent, hostKey, v47, parentLegacyContext)
        if v48 ~= nil then
            v48.depth = depth
        end
        return v48
    end

    local function updateFragmentVirtualNode(v49, v50) -- line 186 | captures: updateChildren
        local hostParent = v49.hostParent
        local elements = v50.elements
        updateChildren(v49, hostParent, elements)
        return v49
    end

    function v5(v51, v52, v53) -- line 204 | captures: v3, v4, v6, v2, updateChildren, updateVirtualNodeWithRenderResult, Type, ElementKind, Children, internalAssert, v1
        if v1.internalTypeChecks then
            local v54 = Type.of(v51) == Type.VirtualNode
            internalAssert(v54, "Expected arg #1 to be of type VirtualNode")
        end
        if v1.typeChecks then
            local v55 = if Type.of(v52) == Type.Element or typeof(v52) == "boolean" then true else v52 == nil
            assert(v55, "Expected arg #2 to be of type Element, boolean, or nil")
        end
        if v51.currentElement == v52 and v53 == nil then
            return v51
        end
        if typeof(v52) == "boolean" or v52 == nil then
            v6(v51)
            return nil
        end
        if v51.currentElement.component == v52.component then
            local v56 = ElementKind.of(v52)
            local v57, v58
            if v56 == ElementKind.Host then
                v57 = v2.updateHostNode(v3, v51, v52)
                v58 = true
            elseif v56 == ElementKind.Function then
                local v59 = v52.component(v52.props)
                updateVirtualNodeWithRenderResult(v51, v51.hostParent, v59)
                v57 = v51
                v58 = true
            elseif v56 == ElementKind.Stateful then
                v57, v58 = v51, v51.instance:__update(v52, v53)
            else
                if v56 == ElementKind.Portal then
                    local target = v51.currentElement.props.target
                    local target_2 = v52.props.target
                    local v60 = v2.isHostObject(target_2)
                    assert(v60, "Expected target to be host object")
                    if target_2 == target then
                        local v61 = v52.props[Children]
                        updateChildren(v51, target_2, v61)
                        v57 = v51
                    else
                        local hostParent = v51.hostParent
                        local hostKey = v51.hostKey
                        local depth = v51.depth
                        local v62 = v51.originalContext or v51.context
                        local parentLegacyContext = v51.parentLegacyContext
                        v6(v51)
                        v57 = v4(v52, hostParent, hostKey, v62, parentLegacyContext)
                        if v57 ~= nil then
                            v57.depth = depth
                        end
                    end
                else
                    if v56 == ElementKind.Fragment then
                        local hostParent = v51.hostParent
                        local elements = v52.elements
                        updateChildren(v51, hostParent, elements)
                    else
                        error(("Unknown ElementKind %q"):format(tostring(v56), 2))
                    end
                    v57 = v51
                end
                v58 = true
            end
            if v58 then
                v57.currentElement = v52
            end
            return v57
        end
        local hostParent = v51.hostParent
        local hostKey = v51.hostKey
        local depth = v51.depth
        local v63 = v51.originalContext or v51.context
        local parentLegacyContext = v51.parentLegacyContext
        v6(v51)
        local v64 = v4(v52, hostParent, hostKey, v63, parentLegacyContext)
        if v64 ~= nil then
            v64.depth = depth
        end
        return v64
    end

    local function createVirtualNode(v65, v66, v67, v68, v69) -- line 261 | captures: v2, Type, internalAssert, v1
        if v1.internalTypeChecks then
            local v70 = v2.isHostObject(v66) or v66 == nil
            internalAssert(v70, "Expected arg #2 to be a host object")
            local v71 = if typeof(v68) == "table" then true else v68 == nil
            internalAssert(v71, "Expected arg #4 to be of type table or nil")
            local v72 = if typeof(v69) == "table" then true else v69 == nil
            internalAssert(v72, "Expected arg #5 to be of type table or nil")
        end
        if v1.typeChecks then
            local v73 = v67 ~= nil
            assert(v73, "Expected arg #3 to be non-nil")
            local v74 = if Type.of(v65) == Type.Element then true else typeof(v65) == "boolean"
            assert(v74, "Expected arg #1 to be of type Element or boolean")
        end
        local v75 = {}
        v75[Type] = Type.VirtualNode
        v75.currentElement = v65
        v75.depth = 1
        v75.children = {}
        v75.hostParent = v66
        v75.hostKey = v67
        v75.legacyContext = v69
        v75.parentLegacyContext = v69
        v75.context = v68 or {}
        v75.originalContext = nil
        return v75
    end

    local function mountFunctionVirtualNode(v76) -- line 303 | captures: updateVirtualNodeWithRenderResult
        local currentElement = v76.currentElement
        local v77 = currentElement.component(currentElement.props)
        updateVirtualNodeWithRenderResult(v76, v76.hostParent, v77)
    end

    local function mountPortalVirtualNode(v78) -- line 311 | captures: v2, updateChildren, Children
        local currentElement = v78.currentElement
        local target = currentElement.props.target
        local v79 = currentElement.props[Children]
        local v80 = v2.isHostObject(target)
        assert(v80, "Expected target to be host object")
        updateChildren(v78, target, v79)
    end

    local function mountFragmentVirtualNode(v81) -- line 322 | captures: updateChildren
        local elements = v81.currentElement.elements
        local hostParent = v81.hostParent
        updateChildren(v81, hostParent, elements)
    end

    function v4(v82, v83, v84, v85, v86) -- line 333 | captures: v3, v2, updateChildren, updateVirtualNodeWithRenderResult, createVirtualNode, Type, ElementKind, Children, internalAssert, v1
        if v1.internalTypeChecks then
            local v87 = v2.isHostObject(v83) or v83 == nil
            internalAssert(v87, "Expected arg #2 to be a host object")
            local v88 = if typeof(v86) == "table" then true else v86 == nil
            internalAssert(v88, "Expected arg #5 to be of type table or nil")
        end
        if v1.typeChecks then
            local v89 = v84 ~= nil
            assert(v89, "Expected arg #3 to be non-nil")
            local v90 = if Type.of(v82) == Type.Element then true else typeof(v82) == "boolean"
            assert(v90, "Expected arg #1 to be of type Element or boolean")
        end
        if typeof(v82) == "boolean" then
            return nil
        end
        local v91 = ElementKind.of(v82)
        local v92 = createVirtualNode(v82, v83, v84, v85, v86)
        if v91 == ElementKind.Host then
            v2.mountHostNode(v3, v92)
        elseif v91 == ElementKind.Function then
            local currentElement = v92.currentElement
            local v93 = currentElement.component(currentElement.props)
            updateVirtualNodeWithRenderResult(v92, v92.hostParent, v93)
        elseif v91 == ElementKind.Stateful then
            v82.component:__mount(v3, v92)
        elseif v91 == ElementKind.Portal then
            local currentElement = v92.currentElement
            local target = currentElement.props.target
            local v94 = currentElement.props[Children]
            local v95 = v2.isHostObject(target)
            assert(v95, "Expected target to be host object")
            updateChildren(v92, target, v94)
        elseif v91 == ElementKind.Fragment then
            local elements = v92.currentElement.elements
            local hostParent = v92.hostParent
            updateChildren(v92, hostParent, elements)
        else
            error(("Unknown ElementKind %q"):format(tostring(v91), 2))
        end
        return v92
    end

    v3 = {
        mountVirtualTree = function(v96, v97, v98) -- mountVirtualTree | line 379 | captures: v4, v2, Type, v1, InternalData
            if v1.typeChecks then
                local v99 = Type.of(v96) == Type.Element
                assert(v99, "Expected arg #1 to be of type Element")
                local v100 = v2.isHostObject(v97) or v97 == nil
                assert(v100, "Expected arg #2 to be a host object")
            end
            local v101 = if v98 == nil then "RoactTree" else v98
            local v102 = {}
            v102[Type] = Type.VirtualTree
            v102[InternalData] = {
                rootNode = nil,
                mounted = true
            }
            v102[InternalData].rootNode = v4(v96, v97, v101)
            return v102
        end,
        unmountVirtualTree = function(v103) -- unmountVirtualTree | line 410 | captures: v6, Type, v1, InternalData
            local v104 = v103[InternalData]
            if v1.typeChecks then
                local v105 = Type.of(v103) == Type.VirtualTree
                assert(v105, "Expected arg #1 to be a Roact handle")
                local mounted = v104.mounted
                assert(mounted, "Cannot unmounted a Roact tree that has already been unmounted")
            end
            v104.mounted = false
            if v104.rootNode ~= nil then
                v6(v104.rootNode)
            end
        end,
        updateVirtualTree = function(v106, v107) -- updateVirtualTree | line 428 | captures: v5, Type, v1, InternalData
            local v108 = v106[InternalData]
            if v1.typeChecks then
                local v109 = Type.of(v106) == Type.VirtualTree
                assert(v109, "Expected arg #1 to be a Roact handle")
                local v110 = Type.of(v107) == Type.Element
                assert(v110, "Expected arg #2 to be a Roact Element")
            end
            v108.rootNode = v5(v108.rootNode, v107)
            return v106
        end,
        createVirtualNode = createVirtualNode,
        mountVirtualNode = v4,
        unmountVirtualNode = v6,
        updateVirtualNode = v5,
        updateVirtualNodeWithChildren = updateVirtualNodeWithChildren,
        updateVirtualNodeWithRenderResult = updateVirtualNodeWithRenderResult
    }
    return v3
end

return createReconciler
