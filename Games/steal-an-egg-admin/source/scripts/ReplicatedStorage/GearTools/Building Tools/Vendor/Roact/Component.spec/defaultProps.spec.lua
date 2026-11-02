-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local None = require(script.Parent.Parent.None)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should fill in when mounting before init", function() -- line 12 | captures: assertDeepEqual, createElement, Component, v1
        local v2 = {
            a = 3,
            b = 2
        }
        local Foo = Component:extend("Foo")
        Foo.defaultProps = v2
        local props

        function Foo.init(v3) -- line 23 | captures: props
            props = v3.props
        end

        function Foo.render(v4) -- line 27
        end

        local v5 = {
            b = 4,
            c = 6
        }
        local v6 = createElement(Foo, v5)
        v1.mountVirtualNode(v6, nil, "Some Foo")
        local v7 = {
            a = v2.a,
            b = v5.b,
            c = v5.c
        }
        assertDeepEqual(props, v7)
    end)
    it("should fill in when updating via props", function() -- line 50 | captures: assertDeepEqual, createElement, Component, v1
        local v8 = {
            a = 3,
            b = 2
        }
        local Foo = Component:extend("Foo")
        Foo.defaultProps = v8
        local props

        function Foo.render(v9) -- line 61 | captures: props
            props = v9.props
        end

        local v10 = {
            b = 4,
            c = 6
        }
        local v11 = createElement(Foo, v10)
        local v12 = v1.mountVirtualNode(v11, nil, "Some Foo")
        local v13 = { c = 5 }
        local v14 = createElement(Foo, v13)
        v1.updateVirtualNode(v12, v14)
        local v15 = {
            a = v8.a,
            b = v8.b,
            c = v13.c
        }
        assertDeepEqual(props, v15)
    end)
    it("should respect None to override a default prop with nil", function() -- line 92 | captures: assertDeepEqual, createElement, None, Component, v1
        local v16 = {
            a = 3,
            b = 2
        }
        local Foo = Component:extend("Foo")
        Foo.defaultProps = v16
        local props

        function Foo.render(v17) -- line 103 | captures: props
            props = v17.props
        end

        local v18 = {
            c = 4,
            b = None
        }
        local v19 = createElement(Foo, v18)
        v1.mountVirtualNode(v19, nil, "Some Foo")
        local v20 = {
            b = nil,
            a = v16.a,
            c = v18.c
        }
        assertDeepEqual(props, v20)
    end)
end
