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
    it("should throw on mount if not overridden", function() -- line 13 | captures: createElement, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local v2 = createElement(MyComponent)
        local v3, v4 = pcall(function() -- line 20 | captures: v2, v1
            v1.mountVirtualNode(v2, nil, "Test")
        end)
        expect(v3).to.equal(false)
        expect(v4:match("MyComponent")).to.be.ok()
        expect(v4:match("render")).to.be.ok()
    end)
    it("should be invoked when a component is mounted", function() -- line 29 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local Foo = Component:extend("Foo")
        local props, state
        local v5 = createSpy(function(v6) -- line 34 | captures: props, state
            props = v6.props
            state = v6.state
        end)
        Foo.render = v5.value
        local v7 = createElement(Foo)
        v1.mountVirtualNode(v7, nil, "Foo Test")
        expect(v5.callCount).to.equal(1)
        local self = v5:captureValues("self")
        expect(Type.of(self.self)).to.equal(Type.StatefulComponentInstance)
        assertDeepEqual(props, {})
        assertDeepEqual(state, {})
    end)
    it("should be invoked when a component is updated via props", function() -- line 55 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local Foo = Component:extend("Foo")
        local props, state
        local v8 = createSpy(function(v9) -- line 60 | captures: props, state
            props = v9.props
            state = v9.state
        end)
        Foo.render = v8.value
        local v10 = { a = 2 }
        local v11 = createElement(Foo, v10)
        local v12 = v1.mountVirtualNode(v11, nil, "Foo Test")
        expect(v8.callCount).to.equal(1)
        local self = v8:captureValues("self")
        local props_2 = props
        local state_2 = state
        expect(Type.of(self.self)).to.equal(Type.StatefulComponentInstance)
        assertDeepEqual(props_2, v10)
        assertDeepEqual(state_2, {})
        local v13 = { a = 3 }
        local v14 = createElement(Foo, v13)
        v1.updateVirtualNode(v12, v14)
        expect(v8.callCount).to.equal(2)
        local self_2 = v8:captureValues("self")
        local props_3 = props
        local state_3 = state
        expect(Type.of(self_2.self)).to.equal(Type.StatefulComponentInstance)
        expect(props_3).never.to.equal(props_2)
        assertDeepEqual(props_3, v13)
        expect(state_3).to.equal(state_2)
    end)
    it("should be invoked when a component is updated via state", function() -- line 104 | captures: createElement, createSpy, Type, Component, v1
        local Foo = Component:extend("Foo")
        local v15

        function Foo.init(v16) -- line 108 | captures: v15
            function v15(...) -- line 109 | captures: v16
                return v16:setState(...)
            end
        end

        local props, state
        local v17 = createSpy(function(v18) -- line 116 | captures: props, state
            props = v18.props
            state = v18.state
        end)
        Foo.render = v17.value
        local v19 = createElement(Foo)
        v1.mountVirtualNode(v19, nil, "Foo Test")
        expect(v17.callCount).to.equal(1)
        local self = v17:captureValues("self")
        local props_2 = props
        local state_2 = state
        expect(Type.of(self.self)).to.equal(Type.StatefulComponentInstance)
        v15({})
        expect(v17.callCount).to.equal(2)
        local self_2 = v17:captureValues("self")
        expect(Type.of(self_2.self)).to.equal(Type.StatefulComponentInstance)
        expect(props).to.equal(props_2)
        expect(state).never.to.equal(state_2)
    end)
    itSKIP("Test defaultProps on initial render", function() -- line 147
    end)
    itSKIP("Test defaultProps on prop update", function() -- line 148
    end)
    itSKIP("Test defaultProps on state update", function() -- line 149
    end)
end
