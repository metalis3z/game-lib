-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Component = require(script.Parent.Component)
    local NoopRenderer = require(script.Parent.NoopRenderer)
    local Children = require(script.Parent.PropMarkers.Children)
    local createContext = require(script.Parent.createContext)
    local createElement = require(script.Parent.createElement)
    local createFragment = require(script.Parent.createFragment)
    local createReconciler = require(script.Parent.createReconciler)
    local createSpy = require(script.Parent.createSpy)
    local v1 = createReconciler(NoopRenderer)
    it("should return a table", function() -- line 13 | captures: createContext
        local Test = createContext("Test")
        expect(Test).to.be.ok()
        expect((type(Test))).to.equal("table")
    end)
    it("should contain a Provider and a Consumer", function() -- line 19 | captures: createContext
        local Test = createContext("Test")
        expect(Test.Provider).to.be.ok()
        expect(Test.Consumer).to.be.ok()
    end)
    describe("Provider", function() -- line 25 | captures: createContext, createElement, createSpy, v1
        it("should render its children", function() -- line 26 | captures: createContext, createElement, createSpy, v1
            local Test = createContext("Test")
            local v2 = createSpy(function() -- line 29
                return nil
            end)
            local v3 = createElement(Test.Provider, { value = "Test" }, { Listener = createElement(v2.value) })
            local v4 = v1.mountVirtualTree(v3, nil, "Provide Tree")
            v1.unmountVirtualTree(v4)
            expect(v2.callCount).to.equal(1)
        end)
    end)
    describe("Consumer", function() -- line 46 | captures: Component, Children, createContext, createElement, createFragment, createSpy, v1
        it("should expect a render function", function() -- line 47 | captures: createContext, createElement, v1
            local Test = createContext("Test")
            local v5 = createElement(Test.Consumer)
            expect(function() -- line 51 | captures: v5, v1
                v1.mountVirtualTree(v5, nil, "Provide Tree")
            end).to.throw()
        end)
        it("should return the default value if there is no Provider", function() -- line 56 | captures: createContext, createElement, createSpy, v1
            local v6 = createSpy()
            local Test = createContext("Test")
            local v7 = createElement(Test.Consumer, { render = v6.value })
            local v8 = v1.mountVirtualTree(v7, nil, "Provide Tree")
            v1.unmountVirtualTree(v8)
            v6:assertCalledWith("Test")
        end)
        it("should pass the value to the render function", function() -- line 70 | captures: createContext, createElement, createSpy, v1
            local v9 = createSpy()
            local Test = createContext("Test")

            local function Listener() -- line 74 | captures: v9, Test, createElement
                return createElement(Test.Consumer, { render = v9.value })
            end

            local v10 = createElement(Test.Provider, { value = "NewTest" }, { Listener = createElement(Listener) })
            local v11 = v1.mountVirtualTree(v10, nil, "Provide Tree")
            v1.unmountVirtualTree(v11)
            v9:assertCalledWith("NewTest")
        end)
        it("should update when the value updates", function() -- line 92 | captures: createContext, createElement, createSpy, v1
            local v12 = createSpy()
            local Test = createContext("Test")

            local function Listener() -- line 96 | captures: v12, Test, createElement
                return createElement(Test.Consumer, { render = v12.value })
            end

            local v13 = createElement(Test.Provider, { value = "NewTest" }, { Listener = createElement(Listener) })
            local v14 = v1.mountVirtualTree(v13, nil, "Provide Tree")
            expect(v12.callCount).to.equal(1)
            v12:assertCalledWith("NewTest")
            v1.updateVirtualTree(v14, createElement(Test.Provider, { value = "ThirdTest" }, { Listener = createElement(Listener) }))
            expect(v12.callCount).to.equal(2)
            v12:assertCalledWith("ThirdTest")
            v1.unmountVirtualTree(v14)
        end)
        it("should update when the value updates through an update blocking component", function() -- line 130 | captures: Component, Children, createContext, createElement, createFragment, createSpy, v1
            local v15 = createSpy()
            local Test = createContext("Test")
            local UpdateBlocker = Component:extend("UpdateBlocker")

            function UpdateBlocker.render(v16) -- line 136 | captures: Children, createFragment
                return createFragment(v16.props[Children])
            end

            function UpdateBlocker.shouldUpdate(v17) -- line 140
                return false
            end

            local function Listener() -- line 144 | captures: v15, Test, createElement
                return createElement(Test.Consumer, { render = v15.value })
            end

            local v18 = createElement(Test.Provider, { value = "NewTest" }, { Blocker = createElement(UpdateBlocker, nil, { Listener = createElement(Listener) }) })
            local v19 = v1.mountVirtualTree(v18, nil, "Provide Tree")
            expect(v15.callCount).to.equal(1)
            v15:assertCalledWith("NewTest")
            v1.updateVirtualTree(v19, createElement(Test.Provider, { value = "ThirdTest" }, { Blocker = createElement(UpdateBlocker, nil, { Listener = createElement(Listener) }) }))
            expect(v15.callCount).to.equal(2)
            v15:assertCalledWith("ThirdTest")
            v1.unmountVirtualTree(v19)
        end)
        it("should behave correctly when the default value is nil", function() -- line 177 | captures: createContext, createElement, createSpy, v1
            local v20 = createContext(nil)
            local v21 = createSpy()

            local function Listener() -- line 181 | captures: v20, v21, createElement
                return createElement(v20.Consumer, { render = v21.value })
            end

            local v22 = v1.mountVirtualTree(createElement(Listener), nil, "Provide Tree")
            expect(v21.callCount).to.equal(1)
            v21:assertCalledWith(nil)
            local v23 = v1.updateVirtualTree(v22, createElement(Listener))
            v1.unmountVirtualTree(v23)
            expect(v21.callCount).to.equal(2)
            v21:assertCalledWith(nil)
        end)
    end)
    describe("Update order", function() -- line 199 | captures: createContext, createElement, v1
        it("should update context at the same time as props", function() -- line 253 | captures: createContext, createElement, v1
            local v24 = false
            local v25 = false
            local v26 = 0
            local default = createContext("default")

            local function Listener(v27) -- line 262 | captures: v24, v25, v26, default, createElement
                local Consumer = default.Consumer
                local v28 = {}

                function v28.render(v29) -- line 264 | captures: v27, v24, v25, v26
                    v26 += 1
                    if v29 == "context_1" then
                        expect(v27.someProp).to.equal("prop_1")
                        v24 = true
                    elseif v29 == "context_2" then
                        expect(v27.someProp).to.equal("prop_2")
                        v25 = true
                    else
                        error("Unexpected context value")
                    end
                end

                return createElement(Consumer, v28)
            end

            local v30 = createElement(default.Provider, { value = "context_1" }, { Child = createElement(Listener, { someProp = "prop_1" }) })
            local v31 = createElement(default.Provider, { value = "context_2" }, { Child = createElement(Listener, { someProp = "prop_2" }) })
            local UpdateObservationIsFun = v1.mountVirtualTree(v30, nil, "UpdateObservationIsFun")
            v1.updateVirtualTree(UpdateObservationIsFun, v31)
            expect(v26).to.equal(2)
            expect(v24).to.equal(true)
            expect(v25).to.equal(true)
        end)
    end)
end
