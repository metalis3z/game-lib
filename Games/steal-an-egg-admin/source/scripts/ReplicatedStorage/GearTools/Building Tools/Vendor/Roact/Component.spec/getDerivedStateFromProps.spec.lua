-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
    local createSpy = require(script.Parent.Parent.createSpy)
    local createElement = require(script.Parent.Parent.createElement)
    local createFragment = require(script.Parent.Parent.createFragment)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should be invoked on initial mount", function() -- line 13 | captures: assertDeepEqual, createSpy, createElement, Component, v1
        local v2 = createSpy()
        local WithDerivedState = Component:extend("WithDerivedState")
        WithDerivedState.getDerivedStateFromProps = v2.value

        function WithDerivedState.render(v3) -- line 19
            return nil
        end

        local v4 = createElement(WithDerivedState, { someProp = 1 })
        v1.mountVirtualNode(v4, nil, "WithDerivedState")
        expect(v2.callCount).to.equal(1)
        local state = v2:captureValues("props", "state")
        assertDeepEqual(state.props, { someProp = 1 })
        assertDeepEqual(state.state, {})
    end)
    it("should be invoked when updated via props", function() -- line 39 | captures: assertDeepEqual, createSpy, createElement, Component, v1
        local v5 = createSpy()
        local WithDerivedState = Component:extend("WithDerivedState")
        WithDerivedState.getDerivedStateFromProps = v5.value

        function WithDerivedState.render(v6) -- line 45
            return nil
        end

        local WithDerivedState_2 = v1.mountVirtualNode(createElement(WithDerivedState, { someProp = 1 }), nil, "WithDerivedState")
        v1.updateVirtualNode(WithDerivedState_2, createElement(WithDerivedState, { someProp = 2 }))
        expect(v5.callCount).to.equal(2)
        local state = v5:captureValues("props", "state")
        assertDeepEqual(state.props, { someProp = 2 })
        assertDeepEqual(state.state, {})
    end)
    it("should be invoked when updated via state", function() -- line 68 | captures: assertDeepEqual, createSpy, createElement, Component, v1
        local v7 = createSpy()
        local WithDerivedState = Component:extend("WithDerivedState")
        WithDerivedState.getDerivedStateFromProps = v7.value

        function WithDerivedState.init(v8) -- line 74
            v8:setState({ someState = 1 })
        end

        function WithDerivedState.render(v9) -- line 80
            return nil
        end

        local v10 = createElement(WithDerivedState)
        local WithDerivedState_2 = v1.mountVirtualNode(v10, nil, "WithDerivedState")
        v1.updateVirtualNode(WithDerivedState_2, v10, { someState = 2 })
        expect(v7.callCount).to.equal(4)
        local state = v7:captureValues("props", "state")
        assertDeepEqual(state.props, {})
        assertDeepEqual(state.state, { someState = 2 })
    end)
    it("should be invoked when updating via state in init (which skips reconciliation)", function() -- line 107 | captures: assertDeepEqual, createSpy, createElement, Component, v1
        local v11 = createSpy()
        local WithDerivedState = Component:extend("WithDerivedState")
        WithDerivedState.getDerivedStateFromProps = v11.value

        function WithDerivedState.init(v12) -- line 113
            v12:setState({ stateFromInit = 1 })
        end

        function WithDerivedState.render(v13) -- line 119
            return nil
        end

        local v14 = createElement(WithDerivedState, { someProp = 1 })
        v1.mountVirtualNode(v14, nil, "WithDerivedState")
        expect(v11.callCount).to.equal(3)
        local state = v11:captureValues("props", "state")
        assertDeepEqual(state.props, { someProp = 1 })
        assertDeepEqual(state.state, { stateFromInit = 1 })
    end)
    it("should receive defaultProps", function() -- line 147 | captures: assertDeepEqual, createSpy, createElement, Component, v1
        local v15 = createSpy()
        local WithDerivedState = Component:extend("WithDerivedState")
        WithDerivedState.defaultProps = { someDefaultProp = "foo" }
        WithDerivedState.getDerivedStateFromProps = v15.value

        function WithDerivedState.render(v16) -- line 157
            return nil
        end

        local v17 = createElement(WithDerivedState, { someProp = 1 })
        local WithDerivedState_2 = v1.mountVirtualNode(v17, nil, "WithDerivedState")
        expect(v15.callCount).to.equal(1)
        local state = v15:captureValues("props", "state")
        assertDeepEqual(state.props, {
            someDefaultProp = "foo",
            someProp = 1
        })
        local v18 = createElement(WithDerivedState, { someProp = 2 })
        v1.updateVirtualNode(WithDerivedState_2, v18)
        expect(v15.callCount).to.equal(2)
        local state_2 = v15:captureValues("props", "state")
        assertDeepEqual(state_2.props, {
            someDefaultProp = "foo",
            someProp = 2
        })
    end)
    it("should derive state for all setState updates, even when deferred", function() -- line 195 | captures: createSpy, createElement, createFragment, Component, v1
        local Child = Component:extend("Child")
        local v19 = createSpy(function() -- line 197
            return {}
        end)
        local v20 = createSpy()

        local function render(v21) -- line 202
            return nil
        end

        Child.render = render

        local function didMount(v22) -- line 206
            v22.props.callback()
        end

        Child.didMount = didMount
        local Parent = Component:extend("Parent")
        Parent.getDerivedStateFromProps = v20.value

        function Parent.render(v23) -- line 214 | captures: Child, v19, createElement, createFragment
            local function v24() -- line 215 | captures: v23, v19
                v23:setState(v19.value)
            end

            return createFragment({
                ChildA = createElement(Child, { callback = v24 }),
                ChildB = createElement(Child, { callback = v24 })
            })
        end

        local v25 = createElement(Parent)
        v1.mountVirtualNode(v25, nil, "Test")
        expect(v19.callCount).to.equal(2)
        expect(v20.callCount).to.equal(3)
    end)
    it("should have derived state after assigning to state in init", function() -- line 241 | captures: assertDeepEqual, createSpy, createElement, Component, v1
        local v26
        local v27 = createSpy(function() -- line 243
            return { derived = true }
        end)
        local WithDerivedState = Component:extend("WithDerivedState")
        WithDerivedState.getDerivedStateFromProps = v27.value

        function WithDerivedState.init(v28) -- line 252 | captures: v26
            v28.state = { init = true }

            function v26() -- line 257 | captures: v28
                return v28.state
            end
        end

        function WithDerivedState.render(v29) -- line 262
            return nil
        end

        local v30 = createElement(WithDerivedState)
        v1.mountVirtualNode(v30, nil, "WithDerivedState")
        expect(v27.callCount).to.equal(2)
        assertDeepEqual(v26(), {
            init = true,
            derived = true
        })
    end)
end
