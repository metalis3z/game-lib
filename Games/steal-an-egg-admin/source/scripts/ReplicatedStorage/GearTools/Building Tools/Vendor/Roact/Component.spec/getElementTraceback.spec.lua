-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local GlobalConfig = require(script.Parent.Parent.GlobalConfig)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should return stack traces in initial renders", function() -- line 11 | captures: createElement, GlobalConfig, Component, v1
        local TestComponent = Component:extend("TestComponent")
        local v2

        function TestComponent.init(v3) -- line 15 | captures: v2
            v2 = v3:getElementTraceback()
        end

        local function render(v4) -- line 19
            return nil
        end

        TestComponent.render = render
        local v5 = { elementTracing = true }
        GlobalConfig.scoped(v5, function() -- line 27 | captures: TestComponent, createElement, v1
            local v6 = createElement(TestComponent)
            v1.mountVirtualNode(v6, nil, "Some key")
        end)
        expect(v2).to.be.a("string")
    end)
    itSKIP("it should return an updated stack trace after an update", function() -- line 38
    end)
    it("should return nil when elementTracing is off", function() -- line 40 | captures: createElement, GlobalConfig, Component, v1
        local v7
        local v8 = { elementTracing = false }
        local TestComponent = Component:extend("TestComponent")

        function TestComponent.init(v9) -- line 49 | captures: v7
            v7 = v9:getElementTraceback()
        end

        local function render(v10) -- line 53
            return nil
        end

        TestComponent.render = render
        GlobalConfig.scoped(v8, function() -- line 57 | captures: TestComponent, createElement, v1
            local v11 = createElement(TestComponent)
            v1.mountVirtualNode(v11, nil, "Some key")
        end)
        expect(v7).to.equal(nil)
    end)
end
