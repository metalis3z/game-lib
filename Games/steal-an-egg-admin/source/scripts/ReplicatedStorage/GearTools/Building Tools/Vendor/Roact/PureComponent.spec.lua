-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createElement = require(script.Parent.createElement)
    local NoopRenderer = require(script.Parent.NoopRenderer)
    local createReconciler = require(script.Parent.createReconciler)
    local PureComponent = require(script.Parent.PureComponent)
    local v1 = createReconciler(NoopRenderer)
    it("should be extendable", function() -- line 10 | captures: PureComponent
        local MyComponent = PureComponent:extend("MyComponent")
        expect(MyComponent).to.be.ok()
    end)
    it("should skip updates for shallow-equal props", function() -- line 16 | captures: createElement, PureComponent, v1
        local v2 = 0
        local v3
        local PureChild = PureComponent:extend("PureChild")

        function PureChild.willUpdate(v4) -- line 22 | captures: v2
            v2 += 1
        end

        local function render(v5) -- line 26
            return nil
        end

        PureChild.render = render
        local PureContainer = PureComponent:extend("PureContainer")

        function PureContainer.init(v6) -- line 32
            v6.state = { value = 0 }
        end

        function PureContainer.didMount(v7) -- line 38 | captures: v3
            function v3(v8) -- line 39 | captures: v7
                v7:setState({ value = v8 })
            end
        end

        function PureContainer.render(v9) -- line 46 | captures: PureChild, createElement
            return createElement(PureChild, { value = v9.state.value })
        end

        local v10 = createElement(PureContainer)
        local v11 = v1.mountVirtualTree(v10, nil, "PureComponent Tree")
        expect(v2).to.equal(0)
        v3(1)
        expect(v2).to.equal(1)
        v3(1)
        expect(v2).to.equal(1)
        v3(2)
        expect(v2).to.equal(2)
        v3(1)
        expect(v2).to.equal(3)
        v1.unmountVirtualTree(v11)
    end)
end
