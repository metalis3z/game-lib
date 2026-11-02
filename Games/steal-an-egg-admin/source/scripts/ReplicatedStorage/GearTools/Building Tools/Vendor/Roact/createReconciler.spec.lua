-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assign = require(script.Parent.assign)
    local createElement = require(script.Parent.createElement)
    local createFragment = require(script.Parent.createFragment)
    local createSpy = require(script.Parent.createSpy)
    local NoopRenderer = require(script.Parent.NoopRenderer)
    local Type = require(script.Parent.Type)
    local ElementKind = require(script.Parent.ElementKind)
    local createReconciler = require(script.Parent.createReconciler)
    local v1 = createReconciler(NoopRenderer)
    describe("tree operations", function() -- line 14 | captures: createElement, v1
        it("should mount and unmount", function() -- line 15 | captures: createElement, v1
            local v2 = v1.mountVirtualTree(createElement("StringValue"))
            expect(v2).to.be.ok()
            v1.unmountVirtualTree(v2)
        end)
        it("should mount, update, and unmount", function() -- line 23 | captures: createElement, v1
            local v3 = v1.mountVirtualTree(createElement("StringValue"))
            expect(v3).to.be.ok()
            v1.updateVirtualTree(v3, createElement("StringValue"))
            v1.unmountVirtualTree(v3)
        end)
    end)
    describe("booleans", function() -- line 34 | captures: createElement, v1
        it("should mount booleans as nil", function() -- line 35 | captures: v1
            local test = v1.mountVirtualNode(false, nil, "test")
            expect(test).to.equal(nil)
        end)
        it("should unmount nodes if they are updated to a boolean value", function() -- line 40 | captures: createElement, v1
            local test = v1.mountVirtualNode(createElement("StringValue"), nil, "test")
            expect(test).to.be.ok()
            local v4 = v1.updateVirtualNode(test, true)
            expect(v4).to.equal(nil)
        end)
    end)
    describe("invalid elements", function() -- line 51 | captures: createElement, v1
        it("should throw errors when attempting to mount invalid elements", function() -- line 52 | captures: createElement, v1
            local function v5() -- line 54
                return "Hello"
            end

            local function v6() -- line 57
                return 1
            end

            local function v7() -- line 60
                return function() -- line 61
                end
            end

            local function v8() -- line 63
                return {}
            end

            expect(function() -- line 70 | captures: v5, createElement, v1
                v1.mountVirtualNode(createElement(v5), nil, "Some Key")
            end).to.throw()
            expect(function() -- line 74 | captures: v6, createElement, v1
                v1.mountVirtualNode(createElement(v6), nil, "Some Key")
            end).to.throw()
            expect(function() -- line 78 | captures: v7, createElement, v1
                v1.mountVirtualNode(createElement(v7), nil, "Some Key")
            end).to.throw()
            expect(function() -- line 82 | captures: v8, createElement, v1
                v1.mountVirtualNode(createElement(v8), nil, "Some Key")
            end).to.throw()
        end)
    end)
    describe("Host components", function() -- line 88 | captures: assign, createElement, createSpy, NoopRenderer, Type, createReconciler
        it("should invoke the renderer to mount host nodes", function() -- line 89 | captures: assign, createElement, createSpy, NoopRenderer, Type, createReconciler
            local v9 = createSpy(NoopRenderer.mountHostNode)
            local v10 = assign({}, NoopRenderer, { mountHostNode = v9.value })
            local v11 = createReconciler(v10)
            local StringValue = createElement("StringValue")
            local v12 = v11.mountVirtualNode(StringValue, nil, "Some Key")
            expect(Type.of(v12)).to.equal(Type.VirtualNode)
            expect(v9.callCount).to.equal(1)
            local node = v9:captureValues("reconciler", "node")
            expect(node.reconciler).to.equal(v11)
            expect(node.node).to.equal(v12)
        end)
        it("should invoke the renderer to update host nodes", function() -- line 113 | captures: assign, createElement, createSpy, NoopRenderer, Type, createReconciler
            local v13 = createSpy(NoopRenderer.updateHostNode)
            local v14 = assign({}, NoopRenderer, {
                mountHostNode = NoopRenderer.mountHostNode,
                updateHostNode = v13.value
            })
            local v15 = createReconciler(v14)
            local StringValue = createElement("StringValue")
            local Key = v15.mountVirtualNode(StringValue, nil, "Key")
            expect(Type.of(Key)).to.equal(Type.VirtualNode)
            local StringValue_2 = createElement("StringValue")
            local v16 = v15.updateVirtualNode(Key, StringValue_2)
            expect(v16).to.equal(Key)
            expect(v13.callCount).to.equal(1)
            local newElement = v13:captureValues("reconciler", "node", "newElement")
            expect(newElement.reconciler).to.equal(v15)
            expect(newElement.node).to.equal(Key)
            expect(newElement.newElement).to.equal(StringValue_2)
        end)
        it("should invoke the renderer to unmount host nodes", function() -- line 144 | captures: assign, createElement, createSpy, NoopRenderer, Type, createReconciler
            local v17 = createSpy(NoopRenderer.unmountHostNode)
            local v18 = assign({}, NoopRenderer, {
                mountHostNode = NoopRenderer.mountHostNode,
                unmountHostNode = v17.value
            })
            local v19 = createReconciler(v18)
            local StringValue = createElement("StringValue")
            local Key = v19.mountVirtualNode(StringValue, nil, "Key")
            expect(Type.of(Key)).to.equal(Type.VirtualNode)
            v19.unmountVirtualNode(Key)
            expect(v17.callCount).to.equal(1)
            local node = v17:captureValues("reconciler", "node")
            expect(node.reconciler).to.equal(v19)
            expect(node.node).to.equal(Key)
        end)
    end)
    describe("Function components", function() -- line 172 | captures: createElement, createFragment, createSpy, Type, v1
        it("should mount and unmount function components", function() -- line 173 | captures: createElement, createSpy, Type, v1
            local v20 = createSpy(function(v21) -- line 174
                return nil
            end)
            local v22 = createElement(v20.value, { someValue = 5 })
            local v23 = v1.mountVirtualNode(v22, nil, "A Key")
            expect(Type.of(v23)).to.equal(Type.VirtualNode)
            expect(v20.callCount).to.equal(1)
            local props = v20:captureValues("props")
            expect(props.props).to.be.a("table")
            expect(props.props.someValue).to.equal(5)
            v1.unmountVirtualNode(v23)
            expect(v20.callCount).to.equal(1)
        end)
        it("should mount single children of function components", function() -- line 199 | captures: createElement, createSpy, Type, v1
            local v24 = createSpy(function(v25) -- line 200
                return nil
            end)
            local v26 = createSpy(function(v27) -- line 204 | captures: v24, createElement
                return createElement(v24.value, { value = v27.value + 1 })
            end)
            local v28 = createElement(v26.value, { value = 13 })
            local v29 = v1.mountVirtualNode(v28, nil, "A Key")
            expect(Type.of(v29)).to.equal(Type.VirtualNode)
            expect(v26.callCount).to.equal(1)
            expect(v24.callCount).to.equal(1)
            local props = v26:captureValues("props")
            local props_2 = v24:captureValues("props")
            expect(props.props).to.be.a("table")
            expect(props.props.value).to.equal(13)
            expect(props_2.props).to.be.a("table")
            expect(props_2.props.value).to.equal(14)
            v1.unmountVirtualNode(v29)
            expect(v26.callCount).to.equal(1)
            expect(v24.callCount).to.equal(1)
        end)
        it("should mount fragments returned by function components", function() -- line 237 | captures: createElement, createFragment, createSpy, Type, v1
            local v30 = createSpy(function(v31) -- line 238
                return nil
            end)
            local v32 = createSpy(function(v33) -- line 242
                return nil
            end)
            local v34 = createSpy(function(v35) -- line 246 | captures: v30, v32, createElement, createFragment
                return createFragment({
                    A = createElement(v30.value, { value = v35.value + 1 }),
                    B = createElement(v32.value, { value = v35.value + 5 })
                })
            end)
            local v36 = createElement(v34.value, { value = 17 })
            local v37 = v1.mountVirtualNode(v36, nil, "A Key")
            expect(Type.of(v37)).to.equal(Type.VirtualNode)
            expect(v34.callCount).to.equal(1)
            expect(v30.callCount).to.equal(1)
            expect(v32.callCount).to.equal(1)
            local props = v34:captureValues("props")
            local props_2 = v30:captureValues("props")
            local props_3 = v32:captureValues("props")
            expect(props.props).to.be.a("table")
            expect(props.props.value).to.equal(17)
            expect(props_2.props).to.be.a("table")
            expect(props_2.props.value).to.equal(18)
            expect(props_3.props).to.be.a("table")
            expect(props_3.props.value).to.equal(22)
            v1.unmountVirtualNode(v37)
            expect(v34.callCount).to.equal(1)
            expect(v30.callCount).to.equal(1)
            expect(v32.callCount).to.equal(1)
        end)
    end)
    describe("Fragments", function() -- line 291 | captures: createElement, createFragment, createSpy, ElementKind, v1
        it("should mount fragments", function() -- line 292 | captures: createFragment, ElementKind, v1
            local v38 = createFragment({})
            local test = v1.mountVirtualNode(v38, nil, "test")
            expect(test).to.be.ok()
            expect(ElementKind.of(test.currentElement)).to.equal(ElementKind.Fragment)
        end)
        it("should mount an empty fragment", function() -- line 300 | captures: createFragment, v1
            local v39 = createFragment({})
            local test = v1.mountVirtualNode(v39, nil, "test")
            expect(test).to.be.ok()
            expect(next(test.children)).to.never.be.ok()
        end)
        it("should mount all fragment's children", function() -- line 308 | captures: createElement, createFragment, createSpy, v1
            local v40 = createSpy(function(v41) -- line 309
                return nil
            end)
            local v42 = {}
            for v43 = 1, 5 do
                v42["key" .. tostring(v43)] = createElement(v40.value, {})
            end
            local v44 = createFragment(v42)
            local test = v1.mountVirtualNode(v44, nil, "test")
            expect(test).to.be.ok()
            expect(v40.callCount).to.equal(5)
        end)
    end)
end
