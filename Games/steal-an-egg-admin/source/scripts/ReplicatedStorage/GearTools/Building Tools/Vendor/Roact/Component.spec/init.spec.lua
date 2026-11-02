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
    it("should be invoked with props when mounted", function() -- line 13 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local v2 = createSpy()
        MyComponent.init = v2.value

        function MyComponent.render(v3) -- line 20
            return nil
        end

        local v4 = { a = 5 }
        local v5 = createElement(MyComponent, v4)
        v1.mountVirtualNode(v5, nil, "Some Component Key")
        expect(v2.callCount).to.equal(1)
        local props = v2:captureValues("self", "props")
        expect(Type.of(props.self)).to.equal(Type.StatefulComponentInstance)
        local expect_2 = expect
        local props_2 = props.props
        expect_2((typeof(props_2))).to.equal("table")
        assertDeepEqual(props.props, v4)
    end)
end
