-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.assertDeepEqual)
    local Binding = require(script.Parent.Binding)
    local Children = require(script.Parent.PropMarkers.Children)
    local Component = require(script.Parent.Component)
    local createElement = require(script.Parent.createElement)
    local createFragment = require(script.Parent.createFragment)
    local createReconciler = require(script.Parent.createReconciler)
    local createRef = require(script.Parent.createRef)
    local createSpy = require(script.Parent.createSpy)
    local GlobalConfig = require(script.Parent.GlobalConfig)
    local Portal = require(script.Parent.Portal)
    local Ref = require(script.Parent.PropMarkers.Ref)
    local RobloxRenderer = require(script.Parent.RobloxRenderer)
    local v1 = createReconciler(RobloxRenderer)
    describe("mountHostNode", function() -- line 19 | captures: Binding, createElement, createRef, createSpy, GlobalConfig, Ref, RobloxRenderer, v1
        it("should create instances with correct props", function() -- line 20 | captures: createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v2 = createElement("StringValue", { Value = "Hello!" })
            local v3 = v1.createVirtualNode(v2, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v3)
            expect(#Folder:GetChildren()).to.equal(1)
            local v4 = Folder:GetChildren()[1]
            expect(v4.ClassName).to.equal("StringValue")
            expect(v4.Value).to.equal("Hello!")
            expect(v4.Name).to.equal("Some Key")
        end)
        it("should create children with correct names and props", function() -- line 42 | captures: createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v5 = createElement("StringValue", { Value = "Hey there!" }, {
                ChildA = createElement("IntValue", { Value = 173 }),
                ChildB = createElement("Folder")
            })
            local v6 = v1.createVirtualNode(v5, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v6)
            expect(#Folder:GetChildren()).to.equal(1)
            local v7 = Folder:GetChildren()[1]
            expect(v7.ClassName).to.equal("StringValue")
            expect(v7.Value).to.equal("Hey there!")
            expect(v7.Name).to.equal("Some Key")
            expect(#v7:GetChildren()).to.equal(2)
            local ChildA = v7.ChildA
            local ChildB = v7.ChildB
            expect(ChildA).to.be.ok()
            expect(ChildB).to.be.ok()
            expect(ChildA.ClassName).to.equal("IntValue")
            expect(ChildA.Value).to.equal(173)
            expect(ChildB.ClassName).to.equal("Folder")
        end)
        it("should attach Bindings to Roblox properties", function() -- line 84 | captures: Binding, createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v8, v9 = Binding.create(10)
            local v10 = createElement("IntValue", { Value = v8 })
            local v11 = v1.createVirtualNode(v10, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v11)
            expect(#Folder:GetChildren()).to.equal(1)
            local v12 = Folder:GetChildren()[1]
            expect(v12.ClassName).to.equal("IntValue")
            expect(v12.Value).to.equal(10)
            v9(20)
            expect(v12.Value).to.equal(20)
            RobloxRenderer.unmountHostNode(v1, v11)
        end)
        it("should connect Binding refs", function() -- line 111 | captures: createElement, createRef, Ref, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v13 = createRef()
            local v14 = createElement("Frame", { [Ref] = v13 })
            local v15 = v1.createVirtualNode(v14, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v15)
            expect(#Folder:GetChildren()).to.equal(1)
            local v16 = Folder:GetChildren()[1]
            expect(v13.current).to.be.ok()
            expect(v13.current).to.equal(v16)
            RobloxRenderer.unmountHostNode(v1, v15)
        end)
        it("should call function refs", function() -- line 134 | captures: createElement, createSpy, Ref, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v17 = createSpy()
            local v18 = createElement("Frame", { [Ref] = v17.value })
            local v19 = v1.createVirtualNode(v18, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v19)
            expect(#Folder:GetChildren()).to.equal(1)
            local v20 = Folder:GetChildren()[1]
            expect(v17.callCount).to.equal(1)
            v17:assertCalledWith(v20)
            RobloxRenderer.unmountHostNode(v1, v19)
        end)
        it("should throw if setting invalid instance properties", function() -- line 157 | captures: createElement, GlobalConfig, RobloxRenderer, v1
            local v21 = { elementTracing = true }
            GlobalConfig.scoped(v21, function() -- line 162 | captures: createElement, RobloxRenderer, v1
                local Folder = Instance.new("Folder")
                local v22 = createElement("Frame", { Frob = 6 })
                local v23 = v1.createVirtualNode(v22, Folder, "Some Key")
                local v24, v25 = pcall(RobloxRenderer.mountHostNode, v1, v23)
                local v26 = not v24
                assert(v26, "Expected call to fail")
                expect(v25:find("Frob")).to.be.ok()
                expect(v25:find("Frame")).to.be.ok()
                expect(v25:find("RobloxRenderer%.spec")).to.be.ok()
            end)
        end)
    end)
    describe("updateHostNode", function() -- line 182 | captures: Binding, createElement, createRef, createSpy, GlobalConfig, Ref, RobloxRenderer, v1
        it("should update node props and children", function() -- line 183 | captures: createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local Value = Instance.new("StringValue").Value
            local v27 = createElement("StringValue", { Value = "foo" }, {
                ChildA = createElement("IntValue", { Value = 1 }),
                ChildB = createElement("BoolValue", { Value = true }),
                ChildC = createElement("StringValue", { Value = "test" }),
                ChildD = createElement("StringValue", { Value = "test" })
            })
            local updateHostNodeTest = v1.createVirtualNode(v27, Folder, "updateHostNodeTest")
            RobloxRenderer.mountHostNode(v1, updateHostNodeTest)
            local v28 = createElement("StringValue", { Value = "bar" }, {
                ChildA = createElement("StringValue", { Value = "test" }),
                ChildB = createElement("BoolValue", { Value = false }),
                ChildC = createElement("StringValue", {}),
                ChildE = createElement("Folder", {})
            })
            RobloxRenderer.updateHostNode(v1, updateHostNodeTest, v28)
            local updateHostNodeTest_2 = Folder.updateHostNodeTest
            expect(updateHostNodeTest_2.ClassName).to.equal("StringValue")
            expect(updateHostNodeTest_2.Value).to.equal("bar")
            expect(#updateHostNodeTest_2:GetChildren()).to.equal(4)
            local ChildA = updateHostNodeTest_2.ChildA
            expect(ChildA.ClassName).to.equal("StringValue")
            expect(ChildA.Value).to.equal("test")
            local ChildB = updateHostNodeTest_2.ChildB
            expect(ChildB.ClassName).to.equal("BoolValue")
            expect(ChildB.Value).to.equal(false)
            local ChildC = updateHostNodeTest_2.ChildC
            expect(ChildC.ClassName).to.equal("StringValue")
            expect(ChildC.Value).to.equal(Value)
            local ChildE = updateHostNodeTest_2.ChildE
            expect(ChildE.ClassName).to.equal("Folder")
        end)
        it("should update Bindings", function() -- line 257 | captures: Binding, createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v29, v30 = Binding.create(10)
            local v31 = createElement("IntValue", { Value = v29 })
            local v32 = v1.createVirtualNode(v31, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v32)
            local v33 = Folder:GetChildren()[1]
            expect(v33.Value).to.equal(10)
            local v34, v35 = Binding.create(99)
            local v36 = createElement("IntValue", { Value = v34 })
            RobloxRenderer.updateHostNode(v1, v32, v36)
            expect(v33.Value).to.equal(99)
            v30(123)
            expect(v33.Value).to.equal(99)
            v35(123)
            expect(v33.Value).to.equal(123)
            RobloxRenderer.unmountHostNode(v1, v32)
        end)
        it("should update Binding refs", function() -- line 294 | captures: createElement, createRef, Ref, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v37 = createRef()
            local v38 = createRef()
            local v39 = createElement("Frame", { [Ref] = v37 })
            local v40 = v1.createVirtualNode(v39, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v40)
            expect(#Folder:GetChildren()).to.equal(1)
            local v41 = Folder:GetChildren()[1]
            expect(v37.current).to.equal(v41)
            expect(v38.current).never.to.be.ok()
            local v42 = createElement("Frame", { [Ref] = v38 })
            RobloxRenderer.updateHostNode(v1, v40, v42)
            expect(v37.current).never.to.be.ok()
            expect(v38.current).to.equal(v41)
            RobloxRenderer.unmountHostNode(v1, v40)
        end)
        it("should call old function refs with nil and new function refs with a valid rbx", function() -- line 328 | captures: createElement, createSpy, Ref, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v43 = createSpy()
            local v44 = createSpy()
            local v45 = createElement("Frame", { [Ref] = v43.value })
            local v46 = v1.createVirtualNode(v45, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v46)
            expect(#Folder:GetChildren()).to.equal(1)
            local v47 = Folder:GetChildren()[1]
            expect(v43.callCount).to.equal(1)
            v43:assertCalledWith(v47)
            expect(v44.callCount).to.equal(0)
            local v48 = createElement("Frame", { [Ref] = v44.value })
            RobloxRenderer.updateHostNode(v1, v46, v48)
            expect(v43.callCount).to.equal(2)
            v43:assertCalledWith(nil)
            expect(v44.callCount).to.equal(1)
            v44:assertCalledWith(v47)
            RobloxRenderer.unmountHostNode(v1, v46)
        end)
        it("should not call function refs again if they didn't change", function() -- line 365 | captures: createElement, createSpy, Ref, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v49 = createSpy()
            local v50 = { Size = UDim2.new(1, 0, 1, 0) }
            v50[Ref] = v49.value
            local v51 = createElement("Frame", v50)
            local v52 = v1.createVirtualNode(v51, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v52)
            expect(#Folder:GetChildren()).to.equal(1)
            local v53 = Folder:GetChildren()[1]
            expect(v49.callCount).to.equal(1)
            v49:assertCalledWith(v53)
            local v54 = { Size = UDim2.new(0.5, 0, 0.5, 0) }
            v54[Ref] = v49.value
            local v55 = createElement("Frame", v54)
            RobloxRenderer.updateHostNode(v1, v52, v55)
            expect(v49.callCount).to.equal(1)
        end)
        it("should throw if setting invalid instance properties", function() -- line 398 | captures: createElement, GlobalConfig, RobloxRenderer, v1
            local v56 = { elementTracing = true }
            GlobalConfig.scoped(v56, function() -- line 403 | captures: createElement, RobloxRenderer, v1
                local Folder = Instance.new("Folder")
                local Frame = createElement("Frame")
                local v57 = createElement("Frame", { Frob = 6 })
                local v58 = v1.createVirtualNode(Frame, Folder, "Some Key")
                RobloxRenderer.mountHostNode(v1, v58)
                local v59, v60 = pcall(RobloxRenderer.updateHostNode, v1, v58, v57)
                local v61 = not v59
                assert(v61, "Expected call to fail")
                expect(v60:find("Frob")).to.be.ok()
                expect(v60:find("Frame")).to.be.ok()
                expect(v60:find("RobloxRenderer%.spec")).to.be.ok()
            end)
        end)
        it("should delete instances when reconciling to nil children", function() -- line 424 | captures: createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v62 = createElement("Frame", { Size = UDim2.new(1, 0, 1, 0) }, { child = createElement("Frame") })
            local v63 = v1.createVirtualNode(v62, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v63)
            expect(#Folder:GetChildren()).to.equal(1)
            local v64 = Folder:GetChildren()[1]
            expect(#v64:GetChildren()).to.equal(1)
            local v65 = createElement("Frame", { Size = UDim2.new(0.5, 0, 0.5, 0) })
            RobloxRenderer.updateHostNode(v1, v63, v65)
            expect(#v64:GetChildren()).to.equal(0)
        end)
    end)
    describe("unmountHostNode", function() -- line 452 | captures: Binding, createElement, createRef, createSpy, Ref, RobloxRenderer, v1
        it("should delete instances from the inside-out", function() -- line 453 | captures: createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v66 = createElement("Folder", nil, { Child = createElement("Folder", nil, { Grandchild = createElement("Folder") }) })
            local Root = v1.mountVirtualNode(v66, Folder, "Root")
            expect(#Folder:GetChildren()).to.equal(1)
            local v67 = Folder:GetChildren()[1]
            expect(#v67:GetChildren()).to.equal(1)
            local v68 = v67:GetChildren()[1]
            expect(#v68:GetChildren()).to.equal(1)
            local v69 = v68:GetChildren()[1]
            RobloxRenderer.unmountHostNode(v1, Root)
            expect(v69.Parent).to.equal(nil)
            expect(v68.Parent).to.equal(nil)
            expect(v67.Parent).to.equal(nil)
        end)
        it("should unsubscribe from any Bindings", function() -- line 481 | captures: Binding, createElement, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v70, v71 = Binding.create(10)
            local v72 = createElement("IntValue", { Value = v70 })
            local v73 = v1.createVirtualNode(v72, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v73)
            local v74 = Folder:GetChildren()[1]
            expect(v74.Value).to.equal(10)
            RobloxRenderer.unmountHostNode(v1, v73)
            v71(56)
            expect(v74.Value).to.equal(10)
        end)
        it("should clear Binding refs", function() -- line 504 | captures: createElement, createRef, Ref, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v75 = createRef()
            local v76 = createElement("Frame", { [Ref] = v75 })
            local v77 = v1.createVirtualNode(v76, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v77)
            expect(v75.current).to.be.ok()
            RobloxRenderer.unmountHostNode(v1, v77)
            expect(v75.current).never.to.be.ok()
        end)
        it("should call function refs with nil", function() -- line 524 | captures: createElement, createSpy, Ref, RobloxRenderer, v1
            local Folder = Instance.new("Folder")
            local v78 = createSpy()
            local v79 = createElement("Frame", { [Ref] = v78.value })
            local v80 = v1.createVirtualNode(v79, Folder, "Some Key")
            RobloxRenderer.mountHostNode(v1, v80)
            expect(v78.callCount).to.equal(1)
            RobloxRenderer.unmountHostNode(v1, v80)
            expect(v78.callCount).to.equal(2)
            v78:assertCalledWith(nil)
        end)
    end)
    describe("Portals", function() -- line 546 | captures: createElement, Portal, v1
        it("should create and destroy instances as children of `target`", function() -- line 547 | captures: createElement, Portal, v1
            local Folder = Instance.new("Folder")

            local function FunctionComponent(v81) -- line 550 | captures: createElement
                return createElement("IntValue", { Value = v81.value })
            end

            local v82 = createElement(Portal, { target = Folder }, {
                folderOne = createElement("Folder"),
                folderTwo = createElement("Folder"),
                intValueOne = createElement(FunctionComponent, { value = 42 })
            })
            local v83 = v1.mountVirtualNode(v82, nil, "Some Key")
            expect(#Folder:GetChildren()).to.equal(3)
            expect(Folder:FindFirstChild("folderOne")).to.be.ok()
            expect(Folder:FindFirstChild("folderTwo")).to.be.ok()
            expect(Folder:FindFirstChild("intValueOne")).to.be.ok()
            expect(Folder:FindFirstChild("intValueOne").Value).to.equal(42)
            v1.unmountVirtualNode(v83)
            expect(#Folder:GetChildren()).to.equal(0)
        end)
        it("should pass prop updates through to children", function() -- line 581 | captures: createElement, Portal, v1
            local Folder = Instance.new("Folder")
            local v84 = createElement(Portal, { target = Folder }, { ChildValue = createElement("IntValue", { Value = 1 }) })
            local v85 = createElement(Portal, { target = Folder }, { ChildValue = createElement("IntValue", { Value = 2 }) })
            local v86 = v1.mountVirtualNode(v84, nil, "A Host Key")
            expect(#Folder:GetChildren()).to.equal(1)
            local ChildValue = Folder.ChildValue
            expect(ChildValue.Value).to.equal(1)
            local v87 = v1.updateVirtualNode(v86, v85)
            expect(#Folder:GetChildren()).to.equal(1)
            local ChildValue_2 = Folder.ChildValue
            expect(ChildValue).to.equal(ChildValue_2)
            expect(ChildValue_2.Value).to.equal(2)
            v1.unmountVirtualNode(v87)
            expect(#Folder:GetChildren()).to.equal(0)
        end)
        it("should throw if `target` is nil", function() -- line 622 | captures: createElement, Portal, v1
            local v88 = createElement(Portal)
            expect(function() -- line 628 | captures: v88, v1
                v1.mountVirtualNode(v88, nil, "Keys for Everyone")
            end).to.throw()
        end)
        it("should throw if `target` is not a Roblox instance", function() -- line 633 | captures: createElement, Portal, v1
            local v89 = createElement(Portal, {
                target = {}
            })
            expect(function() -- line 640 | captures: v89, v1
                v1.mountVirtualNode(v89, nil, "Unleash the keys!")
            end).to.throw()
        end)
        it("should recreate instances if `target` changes in an update", function() -- line 645 | captures: createElement, Portal, v1
            local Folder = Instance.new("Folder")
            local Folder_2 = Instance.new("Folder")
            local v90 = createElement(Portal, { target = Folder }, { ChildValue = createElement("IntValue", { Value = 1 }) })
            local v91 = createElement(Portal, { target = Folder_2 }, { ChildValue = createElement("IntValue", { Value = 2 }) })
            local v92 = v1.mountVirtualNode(v90, nil, "Some Key")
            expect(#Folder:GetChildren()).to.equal(1)
            expect(#Folder_2:GetChildren()).to.equal(0)
            local ChildValue = Folder.ChildValue
            expect(ChildValue.Value).to.equal(1)
            local v93 = v1.updateVirtualNode(v92, v91)
            expect(#Folder:GetChildren()).to.equal(0)
            expect(#Folder_2:GetChildren()).to.equal(1)
            local ChildValue_2 = Folder_2.ChildValue
            expect(ChildValue_2.Value).to.equal(2)
            v1.unmountVirtualNode(v93)
            expect(#Folder:GetChildren()).to.equal(0)
            expect(#Folder_2:GetChildren()).to.equal(0)
        end)
    end)
    describe("Fragments", function() -- line 690 | captures: createElement, createFragment, v1
        it("should parent the fragment's elements into the fragment's parent", function() -- line 691 | captures: createElement, createFragment, v1
            local Folder = Instance.new("Folder")
            local v94 = createFragment({
                key = createElement("IntValue", { Value = 1 }),
                key2 = createElement("IntValue", { Value = 2 })
            })
            local test = v1.mountVirtualNode(v94, Folder, "test")
            expect(Folder:FindFirstChild("key")).to.be.ok()
            expect(Folder.key.ClassName).to.equal("IntValue")
            expect(Folder.key.Value).to.equal(1)
            expect(Folder:FindFirstChild("key2")).to.be.ok()
            expect(Folder.key2.ClassName).to.equal("IntValue")
            expect(Folder.key2.Value).to.equal(2)
            v1.unmountVirtualNode(test)
            expect(#Folder:GetChildren()).to.equal(0)
        end)
        it("should allow sibling fragment to have common keys", function() -- line 718 | captures: createElement, createFragment, v1
            local Folder = Instance.new("Folder")

            local function parent(v95) -- line 722 | captures: createElement, createFragment
                return createElement("IntValue", {}, {
                    fragmentA = createFragment({
                        key = createElement("StringValue", { Value = "A" }),
                        key2 = createElement("StringValue", { Value = "B" })
                    }),
                    fragmentB = createFragment({
                        key = createElement("StringValue", { Value = "C" }),
                        key2 = createElement("StringValue", { Value = "D" })
                    })
                })
            end

            local Test = v1.mountVirtualNode(createElement(parent), Folder, "Test")
            local v96 = Folder.Test:GetChildren()
            expect(#v96).to.equal(4)
            local v97 = {}
            for v98, v99 in pairs(v96) do
                expect(v99.ClassName).to.equal("StringValue")
                v97[v99.Value] = 1 + (v97[v99.Value] or 0)
            end
            expect(v97.A).to.equal(1)
            expect(v97.B).to.equal(1)
            expect(v97.C).to.equal(1)
            expect(v97.D).to.equal(1)
            v1.unmountVirtualNode(Test)
            expect(#Folder:GetChildren()).to.equal(0)
        end)
        it("should render nested fragments", function() -- line 766 | captures: createElement, createFragment, v1
            local Folder = Instance.new("Folder")
            local v100 = createFragment({
                key = createFragment({
                    TheValue = createElement("IntValue", { Value = 1 }),
                    TheOtherValue = createElement("IntValue", { Value = 2 })
                })
            })
            local Test = v1.mountVirtualNode(v100, Folder, "Test")
            expect(Folder:FindFirstChild("TheValue")).to.be.ok()
            expect(Folder.TheValue.ClassName).to.equal("IntValue")
            expect(Folder.TheValue.Value).to.equal(1)
            expect(Folder:FindFirstChild("TheOtherValue")).to.be.ok()
            expect(Folder.TheOtherValue.ClassName).to.equal("IntValue")
            expect(Folder.TheOtherValue.Value).to.equal(2)
            v1.unmountVirtualNode(Test)
            expect(#Folder:GetChildren()).to.equal(0)
        end)
        it("should not add any instances if the fragment is empty", function() -- line 795 | captures: createFragment, v1
            local Folder = Instance.new("Folder")
            local test = v1.mountVirtualNode(createFragment({}), Folder, "test")
            expect(#Folder:GetChildren()).to.equal(0)
            v1.unmountVirtualNode(test)
            expect(#Folder:GetChildren()).to.equal(0)
        end)
    end)
    describe("Context", function() -- line 808 | captures: assertDeepEqual, Children, Component, createElement, Portal, v1
        it("should pass context values through Roblox host nodes", function() -- line 809 | captures: assertDeepEqual, Component, createElement, v1
            local Consumer = Component:extend("Consumer")
            local v101

            function Consumer.init(v102) -- line 813 | captures: v101
                v101 = { hello = v102:__getContext("hello") }
            end

            function Consumer.render(v103) -- line 819
            end

            local v104 = createElement("Folder", nil, { Consumer = createElement(Consumer) })
            local v105 = { hello = "world" }
            local v106 = v1.mountVirtualNode(v104, nil, "Context Test", v105)
            expect(v101).never.to.equal(v105)
            assertDeepEqual(v101, v105)
            v1.unmountVirtualNode(v106)
        end)
        it("should pass context values through portal nodes", function() -- line 838 | captures: assertDeepEqual, Children, Component, createElement, Portal, v1
            local Folder = Instance.new("Folder")
            local Provider = Component:extend("Provider")

            function Provider.init(v107) -- line 843
                v107:__addContext("foo", "bar")
            end

            function Provider.render(v108) -- line 847 | captures: Children, createElement
                return createElement("Folder", nil, v108.props[Children])
            end

            local Consumer = Component:extend("Consumer")
            local v109

            function Consumer.init(v110) -- line 854 | captures: v109
                v109 = { foo = v110:__getContext("foo") }
            end

            function Consumer.render(v111) -- line 860
                return nil
            end

            local v112 = createElement(Provider, nil, { Portal = createElement(Portal, { target = Folder }, { Consumer = createElement(Consumer) }) })
            v1.mountVirtualNode(v112, nil, "Some Key")
            assertDeepEqual(v109, { foo = "bar" })
        end)
    end)
    describe("Legacy context", function() -- line 881 | captures: assertDeepEqual, Children, Component, createElement, Portal, v1
        it("should pass context values through Roblox host nodes", function() -- line 882 | captures: assertDeepEqual, Component, createElement, v1
            local Consumer = Component:extend("Consumer")
            local _context

            function Consumer.init(v113) -- line 886 | captures: _context
                _context = v113._context
            end

            function Consumer.render(v114) -- line 890
            end

            local v115 = createElement("Folder", nil, { Consumer = createElement(Consumer) })
            local v116 = { hello = "world" }
            local v117 = v1.mountVirtualNode(v115, nil, "Context Test", nil, v116)
            expect(_context).never.to.equal(v116)
            assertDeepEqual(_context, v116)
            v1.unmountVirtualNode(v117)
        end)
        it("should pass context values through portal nodes", function() -- line 909 | captures: assertDeepEqual, Children, Component, createElement, Portal, v1
            local Folder = Instance.new("Folder")
            local Provider = Component:extend("Provider")

            function Provider.init(v118) -- line 914
                v118._context.foo = "bar"
            end

            function Provider.render(v119) -- line 918 | captures: Children, createElement
                return createElement("Folder", nil, v119.props[Children])
            end

            local Consumer = Component:extend("Consumer")
            local _context

            function Consumer.init(v120) -- line 925 | captures: _context
                _context = v120._context
            end

            function Consumer.render(v121) -- line 929
                return nil
            end

            local v122 = createElement(Provider, nil, { Portal = createElement(Portal, { target = Folder }, { Consumer = createElement(Consumer) }) })
            v1.mountVirtualNode(v122, nil, "Some Key")
            assertDeepEqual(_context, { foo = "bar" })
        end)
    end)
end
