-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local createSpy = require(script.Parent.Parent.createSpy)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Type = require(script.Parent.Parent.Type)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should be invoked when props update", function() -- line 13 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local props, state
        local v2 = createSpy(function(v3) -- line 18 | captures: props, state
            props = v3.props
            state = v3.state
            return true
        end)
        MyComponent.shouldUpdate = v2.value

        function MyComponent.render(v4) -- line 27
            return nil
        end

        local v5 = { a = 5 }
        local v6 = createElement(MyComponent, v5)
        local Test = v1.mountVirtualNode(v6, nil, "Test")
        expect(v2.callCount).to.equal(0)
        local v7 = {
            a = 6,
            b = 2
        }
        local v8 = createElement(MyComponent, v7)
        v1.updateVirtualNode(Test, v8)
        expect(v2.callCount).to.equal(1)
        local newState = v2:captureValues("self", "newProps", "newState")
        expect(Type.of(newState.self)).to.equal(Type.StatefulComponentInstance)
        assertDeepEqual(newState.newProps, v7)
        assertDeepEqual(props, v5)
        expect(newState.newState).to.equal(state)
        assertDeepEqual(state, {})
    end)
    it("should be invoked when state is updated", function() -- line 63 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local v9 = { a = 1 }
        local v10, state

        function MyComponent.init(v11) -- line 72 | captures: v10, state, v9
            function v10(...) -- line 73 | captures: v11
                return v11:setState(...)
            end

            v11:setState(v9)
            state = v11.state
        end

        local props, state_2
        local v12 = createSpy(function(v13) -- line 84 | captures: props, state_2
            props = v13.props
            state_2 = v13.state
            return true
        end)
        MyComponent.shouldUpdate = v12.value

        function MyComponent.render(v14) -- line 93
            return nil
        end

        local v15 = createElement(MyComponent)
        v1.mountVirtualNode(v15, nil, "Test")
        expect(v12.callCount).to.equal(0)
        local v16 = {
            a = 2,
            b = 3
        }
        v10(v16)
        expect(v12.callCount).to.equal(1)
        local newState = v12:captureValues("self", "newProps", "newState")
        expect(Type.of(newState.self)).to.equal(Type.StatefulComponentInstance)
        expect(newState.newProps).to.equal(props)
        assertDeepEqual(props, {})
        assertDeepEqual(state_2, v9)
        expect(state_2).to.equal(state)
        assertDeepEqual(newState.newState, v16)
    end)
    it("should not abort an update when returning true", function() -- line 126 | captures: createElement, createSpy, Component, v1
        local MyComponent = Component:extend("MyComponent")

        function MyComponent.shouldUpdate(v17) -- line 129
            return true
        end

        local v18 = createSpy()
        MyComponent.render = v18.value
        local v19 = createElement(MyComponent)
        local Test = v1.mountVirtualNode(v19, nil, "Test")
        expect(v18.callCount).to.equal(1)
        local v20 = createElement(MyComponent)
        v1.updateVirtualNode(Test, v20)
        expect(v18.callCount).to.equal(2)
    end)
    it("should abort an update when retuning false", function() -- line 151 | captures: createElement, createSpy, Component, v1
        local MyComponent = Component:extend("MyComponent")

        function MyComponent.shouldUpdate(v21) -- line 154
            return false
        end

        local v22 = createSpy()
        MyComponent.render = v22.value
        local v23 = createElement(MyComponent)
        local Test = v1.mountVirtualNode(v23, nil, "Test")
        expect(v22.callCount).to.equal(1)
        local v24 = createElement(MyComponent)
        v1.updateVirtualNode(Test, v24)
        expect(v22.callCount).to.equal(1)
    end)
end
