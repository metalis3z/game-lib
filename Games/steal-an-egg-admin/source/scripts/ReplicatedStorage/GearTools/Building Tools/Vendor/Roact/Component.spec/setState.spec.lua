-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local createSpy = require(script.Parent.Parent.createSpy)
    local None = require(script.Parent.Parent.None)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    describe("setState", function() -- line 12 | captures: createElement, None, Component, v1
        it("should not trigger an extra update when called in init", function() -- line 13 | captures: createElement, Component, v1
            local v2 = 0
            local v3 = 0
            local state
            local InitComponent = Component:extend("InitComponent")

            function InitComponent.init(v4) -- line 20
                v4:setState({ a = 1 })
            end

            function InitComponent.willUpdate(v5) -- line 26 | captures: v3
                v3 += 1
            end

            function InitComponent.render(v6) -- line 30 | captures: v2, state
                v2 += 1
                state = v6.state
                return nil
            end

            local v7 = createElement(InitComponent)
            v1.mountVirtualTree(v7)
            expect(v2).to.equal(1)
            expect(v3).to.equal(0)
            expect(state.a).to.equal(1)
        end)
        it("should throw when called in render", function() -- line 45 | captures: createElement, Component, v1
            local TestComponent = Component:extend("TestComponent")

            function TestComponent.render(v8) -- line 48
                v8:setState({ a = 1 })
            end

            local v9 = createElement(TestComponent)
            local v10, v11 = pcall(v1.mountVirtualTree, v9)
            expect(v10).to.equal(false)
            expect(v11:match("render")).to.be.ok()
            expect(v11:match("TestComponent")).to.be.ok()
        end)
        it("should throw when called in shouldUpdate", function() -- line 63 | captures: createElement, Component, v1
            local TestComponent = Component:extend("TestComponent")

            function TestComponent.render(v12) -- line 66
                return nil
            end

            function TestComponent.shouldUpdate(v13) -- line 70
                v13:setState({ a = 1 })
            end

            local v14 = createElement(TestComponent)
            local v15 = createElement(TestComponent)
            local v16 = v1.mountVirtualTree(v14)
            local v17, v18 = pcall(v1.updateVirtualTree, v16, v15)
            expect(v17).to.equal(false)
            expect(v18:match("shouldUpdate")).to.be.ok()
            expect(v18:match("TestComponent")).to.be.ok()
        end)
        it("should throw when called in willUpdate", function() -- line 88 | captures: createElement, Component, v1
            local TestComponent = Component:extend("TestComponent")

            function TestComponent.render(v19) -- line 91
                return nil
            end

            function TestComponent.willUpdate(v20) -- line 95
                v20:setState({ a = 1 })
            end

            local v21 = createElement(TestComponent)
            local v22 = createElement(TestComponent)
            local v23 = v1.mountVirtualTree(v21)
            local v24, v25 = pcall(v1.updateVirtualTree, v23, v22)
            expect(v24).to.equal(false)
            expect(v25:match("willUpdate")).to.be.ok()
            expect(v25:match("TestComponent")).to.be.ok()
        end)
        it("should throw when called in willUnmount", function() -- line 112 | captures: createElement, Component, v1
            local TestComponent = Component:extend("TestComponent")

            function TestComponent.render(v26) -- line 115
                return nil
            end

            function TestComponent.willUnmount(v27) -- line 119
                v27:setState({ a = 1 })
            end

            local v28 = createElement(TestComponent)
            local v29 = v1.mountVirtualTree(v28)
            local v30, v31 = pcall(v1.unmountVirtualTree, v29)
            expect(v30).to.equal(false)
            expect(v31:match("willUnmount")).to.be.ok()
            expect(v31:match("TestComponent")).to.be.ok()
        end)
        it("should remove values from state when the value is None", function() -- line 135 | captures: createElement, None, Component, v1
            local TestComponent = Component:extend("TestComponent")
            local v32, v33

            function TestComponent.init(v34) -- line 139 | captures: v32, v33
                function v32(v35) -- line 140 | captures: v34
                    v34:setState(v35)
                end

                function v33() -- line 144 | captures: v34
                    return v34.state
                end

                v34:setState({ value = 0 })
            end

            function TestComponent.render(v36) -- line 153
                return nil
            end

            local v37 = createElement(TestComponent)
            local Test = v1.mountVirtualNode(v37, nil, "Test")
            expect(v33().value).to.equal(0)
            v32({ value = None })
            expect(v33().value).to.equal(nil)
            v1.unmountVirtualNode(Test)
        end)
        it("should invoke functions to compute a partial state", function() -- line 171 | captures: createElement, Component, v1
            local TestComponent = Component:extend("TestComponent")
            local v38, v39, v40

            function TestComponent.init(v41) -- line 175 | captures: v38, v39, v40
                function v38(v42) -- line 176 | captures: v41
                    v41:setState(v42)
                end

                function v39() -- line 180 | captures: v41
                    return v41.state
                end

                function v40() -- line 184 | captures: v41
                    return v41.props
                end

                v41:setState({ value = 0 })
            end

            function TestComponent.render(v43) -- line 193
                return nil
            end

            local v44 = createElement(TestComponent)
            local Test = v1.mountVirtualNode(v44, nil, "Test")
            expect(v39().value).to.equal(0)
            v38(function(v45, v46) -- line 202 | captures: v39, v40
                expect(v45).to.equal(v39())
                expect(v46).to.equal(v40())
                return { value = v45.value + 1 }
            end)
            expect(v39().value).to.equal(1)
            v1.unmountVirtualNode(Test)
        end)
        it("should cancel rendering if the function returns nil", function() -- line 216 | captures: createElement, Component, v1
            local TestComponent = Component:extend("TestComponent")
            local v47
            local v48 = 0

            function TestComponent.init(v49) -- line 221 | captures: v47
                function v47(v50) -- line 222 | captures: v49
                    v49:setState(v50)
                end

                v49:setState({ value = 0 })
            end

            function TestComponent.render(v51) -- line 231 | captures: v48
                v48 += 1
                return nil
            end

            local v52 = createElement(TestComponent)
            local Test = v1.mountVirtualNode(v52, nil, "Test")
            expect(v48).to.equal(1)
            v47(function(v53, v54) -- line 240
                return nil
            end)
            expect(v48).to.equal(1)
            v1.unmountVirtualNode(Test)
        end)
    end)
    describe("setState suspension", function() -- line 250 | captures: createElement, createSpy, Component, v1
        it("should defer setState triggered while reconciling", function() -- line 251 | captures: createElement, Component, v1
            local Child = Component:extend("Child")
            local v55

            local function render(v56) -- line 255
                return nil
            end

            Child.render = render

            local function didMount(v57) -- line 259
                v57.props.callback()
            end

            Child.didMount = didMount
            local Parent = Component:extend("Parent")

            function Parent.init(v58) -- line 265 | captures: v55
                function v55() -- line 266 | captures: v58
                    return v58.state
                end
            end

            function Parent.render(v59) -- line 271 | captures: Child, createElement
                local v60 = {}

                function v60.callback() -- line 273 | captures: v59
                    v59:setState({ foo = "bar" })
                end

                return createElement(Child, v60)
            end

            local v61 = createElement(Parent)
            local Test = v1.mountVirtualNode(v61, nil, "Test")
            expect(Test).to.be.ok()
            expect(v55().foo).to.equal("bar")
        end)
        it("should defer setState triggered while reconciling during an update", function() -- line 291 | captures: createElement, Component, v1
            local Child = Component:extend("Child")
            local v62

            local function render(v63) -- line 295
                return nil
            end

            Child.render = render

            local function didUpdate(v64) -- line 299
                v64.props.callback()
            end

            Child.didUpdate = didUpdate
            local Parent = Component:extend("Parent")

            function Parent.init(v65) -- line 305 | captures: v62
                function v62() -- line 306 | captures: v65
                    return v65.state
                end
            end

            function Parent.render(v66) -- line 311 | captures: Child, createElement
                local v67 = {}

                function v67.callback() -- line 313 | captures: v66
                    if not v66.state.foo then
                        v66:setState({ foo = "bar" })
                    end
                end

                return createElement(Child, v67)
            end

            local v68 = createElement(Parent)
            local Test = v1.mountVirtualNode(v68, nil, "Test")
            expect(Test).to.be.ok()
            expect(v62().foo).to.equal(nil)
            local v69 = v1.updateVirtualNode(Test, createElement(Parent))
            expect(v69).to.be.ok()
            expect(v62().foo).to.equal("bar")
            v1.unmountVirtualNode(v69)
        end)
        it("should combine pending state changes properly", function() -- line 341 | captures: createElement, Component, v1
            local Child = Component:extend("Child")
            local v70

            local function render(v71) -- line 345
                return nil
            end

            Child.render = render

            local function didMount(v72) -- line 349
                v72.props.callback("foo", 1)
                v72.props.callback("bar", 3)
            end

            Child.didMount = didMount
            local Parent = Component:extend("Parent")

            function Parent.init(v73) -- line 356 | captures: v70
                function v70() -- line 357 | captures: v73
                    return v73.state
                end
            end

            function Parent.render(v74) -- line 362 | captures: Child, createElement
                local v75 = {}

                function v75.callback(v76, v77) -- line 364 | captures: v74
                    v74:setState({ [v76] = v77 })
                end

                return createElement(Child, v75)
            end

            local v78 = createElement(Parent)
            local Test = v1.mountVirtualNode(v78, nil, "Test")
            expect(Test).to.be.ok()
            expect(v70().foo).to.equal(1)
            expect(v70().bar).to.equal(3)
            v1.unmountVirtualNode(Test)
        end)
        it("should abort properly when functional setState returns nil while deferred", function() -- line 385 | captures: createElement, createSpy, Component, v1
            local Child = Component:extend("Child")

            local function render(v79) -- line 388
                return nil
            end

            Child.render = render

            local function didMount(v80) -- line 392
                v80.props.callback()
            end

            Child.didMount = didMount
            local Parent = Component:extend("Parent")
            local v81 = createSpy(function(v82) -- line 398 | captures: Child, createElement
                local v83 = {}

                function v83.callback() -- line 400 | captures: v82
                    v82:setState(function() -- line 401
                        return nil
                    end)
                end

                return createElement(Child, v83)
            end)
            Parent.render = v81.value
            local v84 = createElement(Parent)
            local Test = v1.mountVirtualNode(v84, nil, "Test")
            expect(Test).to.be.ok()
            expect(v81.callCount).to.equal(1)
            v1.unmountVirtualNode(Test)
        end)
        it("should still apply pending state if a subsequent state update was aborted", function() -- line 423 | captures: createElement, Component, v1
            local Child = Component:extend("Child")
            local v85

            local function render(v86) -- line 427
                return nil
            end

            Child.render = render

            local function didMount(v87) -- line 431
                v87.props.callback(function() -- line 432
                    return { foo = 1 }
                end)
                v87.props.callback(function() -- line 437
                    return nil
                end)
            end

            Child.didMount = didMount
            local Parent = Component:extend("Parent")

            function Parent.init(v88) -- line 444 | captures: v85
                function v85() -- line 445 | captures: v88
                    return v88.state
                end
            end

            function Parent.render(v89) -- line 450 | captures: Child, createElement
                local v90 = {}

                function v90.callback(v91) -- line 452 | captures: v89
                    v89:setState(v91)
                end

                return createElement(Child, v90)
            end

            local v92 = createElement(Parent)
            local Test = v1.mountVirtualNode(v92, nil, "Test")
            expect(Test).to.be.ok()
            expect(v85().foo).to.equal(1)
            v1.unmountVirtualNode(Test)
        end)
        it("should not re-process new state when pending state is present after update", function() -- line 470 | captures: createElement, Component, v1
            local v93, v94
            local MyComponent = Component:extend("MyComponent")

            function MyComponent.init(v95) -- line 476 | captures: v93, v94
                v95:setState({
                    hasUpdatedOnce = false,
                    counter = 0
                })

                function v93(v96) -- line 482 | captures: v95
                    v95:setState(v96)
                end

                function v94() -- line 486 | captures: v95
                    return v95.state
                end
            end

            function MyComponent.render(v97) -- line 491
                return nil
            end

            function MyComponent.didUpdate(v98) -- line 495
                if v98.state.hasUpdatedOnce == false then
                    v98:setState({ hasUpdatedOnce = true })
                end
            end

            local v99 = createElement(MyComponent)
            v1.mountVirtualNode(v99, nil, "Test")
            expect(v94().hasUpdatedOnce).to.equal(false)
            expect(v94().counter).to.equal(0)
            v93(function(v100) -- line 512
                return { counter = v100.counter + 1 }
            end)
            expect(v94().hasUpdatedOnce).to.equal(true)
            expect(v94().counter).to.equal(1)
        end)
        it("should throw when an infinite update is triggered", function() -- line 522 | captures: createElement, Component, v1
            local InfiniteUpdater = Component:extend("InfiniteUpdater")

            function InfiniteUpdater.render(v101) -- line 525
                return nil
            end

            function InfiniteUpdater.didMount(v102) -- line 529
                v102:setState({})
            end

            function InfiniteUpdater.didUpdate(v103) -- line 533
                v103:setState({})
            end

            local v104 = createElement(InfiniteUpdater)
            local Test, Test_2 = pcall(v1.mountVirtualNode, v104, nil, "Test")
            expect(Test).to.equal(false)
            expect(Test_2:find("InfiniteUpdater")).to.be.ok()
            expect(Test_2:find("reached the setState update recursion limit")).to.be.ok()
        end)
        itSKIP("should process single updates with both new and pending state", function() -- line 548
        end)
        it("should call trigger update after didMount when setting state in didMount", function() -- line 555 | captures: createElement, Component, v1
            local MyComponent = Component:extend("MyComponent")

            function MyComponent.init(v105) -- line 566
                v105:setState({ status = "initial mount" })
                v105.isMounted = false
            end

            function MyComponent.render(v106) -- line 574
                return nil
            end

            function MyComponent.didMount(v107) -- line 578
                v107:setState({ status = "mounted" })
                v107.isMounted = true
            end

            function MyComponent.didUpdate(v108, v109, v110) -- line 586
                expect(v110.status).to.equal("initial mount")
                expect(v108.state.status).to.equal("mounted")
                expect(v108.isMounted).to.equal(true)
            end

            local v111 = createElement(MyComponent)
            local Test = v1.mountVirtualNode(v111, nil, "Test")
            expect(Test).to.be.ok()
        end)
    end)
end
