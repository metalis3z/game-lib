-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local createSpy = require(script.Parent.Parent.createSpy)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local GlobalConfig = require(script.Parent.Parent.GlobalConfig)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should be invoked when mounted", function() -- line 12 | captures: createElement, createSpy, GlobalConfig, Component, v1
        local v2 = { propValidation = true }
        GlobalConfig.scoped(v2, function() -- line 17 | captures: createElement, createSpy, Component, v1
            local MyComponent = Component:extend("MyComponent")
            local v3 = createSpy(function() -- line 20
                return true
            end)
            MyComponent.validateProps = v3.value

            function MyComponent.render(v4) -- line 26
                return nil
            end

            local v5 = createElement(MyComponent)
            v1.mountVirtualNode(v5, nil, "Test")
            expect(v3.callCount).to.equal(1)
        end)
    end)
    it("should be invoked when props change", function() -- line 39 | captures: createElement, createSpy, GlobalConfig, Component, v1
        local v6 = { propValidation = true }
        GlobalConfig.scoped(v6, function() -- line 44 | captures: createElement, createSpy, Component, v1
            local MyComponent = Component:extend("MyComponent")
            local v7 = createSpy(function() -- line 47
                return true
            end)
            MyComponent.validateProps = v7.value

            function MyComponent.render(v8) -- line 53
                return nil
            end

            local v9 = createElement(MyComponent, { a = 1 })
            local Test = v1.mountVirtualNode(v9, nil, "Test")
            expect(v7.callCount).to.equal(1)
            v7:assertCalledWithDeepEqual({ a = 1 })
            local v10 = createElement(MyComponent, { a = 2 })
            v1.updateVirtualNode(Test, v10)
            expect(v7.callCount).to.equal(2)
            v7:assertCalledWithDeepEqual({ a = 2 })
        end)
    end)
    it("should not be invoked when state changes", function() -- line 76 | captures: createElement, createSpy, GlobalConfig, Component, v1
        local v11 = { propValidation = true }
        GlobalConfig.scoped(v11, function() -- line 81 | captures: createElement, createSpy, Component, v1
            local MyComponent = Component:extend("MyComponent")
            local v12
            local v13 = createSpy(function() -- line 85
                return true
            end)
            MyComponent.validateProps = v13.value

            function MyComponent.init(v14) -- line 91 | captures: v12
                function v12(v15) -- line 92 | captures: v14
                    v14:setState(v15)
                end
            end

            function MyComponent.render(v16) -- line 97
                return nil
            end

            local v17 = createElement(MyComponent, { a = 1 })
            v1.mountVirtualNode(v17, nil, "Test")
            expect(v13.callCount).to.equal(1)
            v13:assertCalledWithDeepEqual({ a = 1 })
            v12({ b = 1 })
            expect(v13.callCount).to.equal(1)
        end)
    end)
    it("should throw if validateProps is not a function", function() -- line 119 | captures: createElement, GlobalConfig, Component, v1
        local v18 = { propValidation = true }
        GlobalConfig.scoped(v18, function() -- line 124 | captures: createElement, Component, v1
            local MyComponent = Component:extend("MyComponent")
            MyComponent.validateProps = 1

            function MyComponent.render(v19) -- line 128
                return nil
            end

            local v20 = createElement(MyComponent)
            expect(function() -- line 136 | captures: v20, v1
                v1.mountVirtualNode(v20, nil, "Test")
            end).to.throw()
        end)
    end)
    it("should throw if validateProps returns false", function() -- line 142 | captures: createElement, GlobalConfig, Component, v1
        local v21 = { propValidation = true }
        GlobalConfig.scoped(v21, function() -- line 147 | captures: createElement, Component, v1
            local MyComponent = Component:extend("MyComponent")

            function MyComponent.validateProps() -- line 149
                return false
            end

            function MyComponent.render(v22) -- line 153
                return nil
            end

            local v23 = createElement(MyComponent)
            expect(function() -- line 161 | captures: v23, v1
                v1.mountVirtualNode(v23, nil, "Test")
            end).to.throw()
        end)
    end)
    it("should include the component name in the error message", function() -- line 167 | captures: createElement, GlobalConfig, Component, v1
        local v24 = { propValidation = true }
        GlobalConfig.scoped(v24, function() -- line 172 | captures: createElement, Component, v1
            local MyComponent = Component:extend("MyComponent")

            function MyComponent.validateProps() -- line 174
                return false
            end

            function MyComponent.render(v25) -- line 178
                return nil
            end

            local v26 = createElement(MyComponent)
            local v27, v28 = pcall(function() -- line 186 | captures: v26, v1
                v1.mountVirtualNode(v26, nil, "Test")
            end)
            expect(v27).to.equal(false)
            local MyComponent_2 = v28:find("MyComponent")
            expect(MyComponent_2).to.be.ok()
        end)
    end)
    it("should be invoked after defaultProps are applied", function() -- line 196 | captures: createElement, createSpy, GlobalConfig, Component, v1
        local v29 = { propValidation = true }
        GlobalConfig.scoped(v29, function() -- line 201 | captures: createElement, createSpy, Component, v1
            local MyComponent = Component:extend("MyComponent")
            local v30 = createSpy(function() -- line 204
                return true
            end)
            MyComponent.validateProps = v30.value

            function MyComponent.render(v31) -- line 210
                return nil
            end

            MyComponent.defaultProps = { b = 2 }
            local v32 = createElement(MyComponent, { a = 1 })
            local Test = v1.mountVirtualNode(v32, nil, "Test")
            expect(v30.callCount).to.equal(1)
            v30:assertCalledWithDeepEqual({
                a = 1,
                b = 2
            })
            local v33 = createElement(MyComponent, { a = 2 })
            v1.updateVirtualNode(Test, v33)
            expect(v30.callCount).to.equal(2)
            v30:assertCalledWithDeepEqual({
                a = 2,
                b = 2
            })
        end)
    end)
    it("should not be invoked if the flag is off", function() -- line 239 | captures: createElement, createSpy, GlobalConfig, Component, v1
        local v34 = { propValidation = false }
        GlobalConfig.scoped(v34, function() -- line 244 | captures: createElement, createSpy, Component, v1
            local MyComponent = Component:extend("MyComponent")
            local v35 = createSpy(function() -- line 247
                return true
            end)
            MyComponent.validateProps = v35.value

            function MyComponent.render(v36) -- line 253
                return nil
            end

            local v37 = createElement(MyComponent, { a = 1 })
            local Test = v1.mountVirtualNode(v37, nil, "Test")
            expect(v35.callCount).to.equal(0)
            local v38 = createElement(MyComponent, { a = 2 })
            v1.updateVirtualNode(Test, v38)
            expect(v35.callCount).to.equal(0)
        end)
    end)
end
