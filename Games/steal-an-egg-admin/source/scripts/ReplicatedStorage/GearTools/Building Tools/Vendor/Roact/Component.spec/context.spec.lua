-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local oneChild = require(script.Parent.Parent.oneChild)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should be provided as an internal api on Component", function() -- line 12 | captures: assertDeepEqual, createElement, Component, v1
        local Provider = Component:extend("Provider")

        function Provider.init(v2) -- line 15
            v2:__addContext("foo", "bar")
        end

        function Provider.render(v3) -- line 19
        end

        local v4 = createElement(Provider)
        local Provider_2 = v1.mountVirtualNode(v4, nil, "Provider")
        local v5 = { foo = "bar" }
        assertDeepEqual(Provider_2.context, v5)
    end)
    it("should be inherited from parent stateful nodes", function() -- line 34 | captures: assertDeepEqual, createElement, Component, v1
        local Consumer = Component:extend("Consumer")
        local v6

        function Consumer.init(v7) -- line 38 | captures: v6
            v6 = {
                hello = v7:__getContext("hello"),
                value = v7:__getContext("value")
            }
        end

        local function render(v8) -- line 45
        end

        Consumer.render = render
        local Parent = Component:extend("Parent")

        function Parent.render(v9) -- line 50 | captures: Consumer, createElement
            return createElement(Consumer)
        end

        local v10 = createElement(Parent)
        local v11 = {
            hello = "world",
            value = 6
        }
        local v12 = v1.mountVirtualNode(v10, nil, "Parent", v11)
        expect(v6).never.to.equal(v11)
        expect(v6).never.to.equal(v12.context)
        assertDeepEqual(v12.context, v11)
        assertDeepEqual(v6, v11)
    end)
    it("should be inherited from parent function nodes", function() -- line 69 | captures: assertDeepEqual, createElement, Component, v1
        local Consumer = Component:extend("Consumer")
        local v13

        function Consumer.init(v14) -- line 73 | captures: v13
            v13 = {
                hello = v14:__getContext("hello"),
                value = v14:__getContext("value")
            }
        end

        local function render(v15) -- line 80
        end

        Consumer.render = render

        local function Parent() -- line 83 | captures: Consumer, createElement
            return createElement(Consumer)
        end

        local v16 = createElement(Parent)
        local v17 = {
            hello = "world",
            value = 6
        }
        local v18 = v1.mountVirtualNode(v16, nil, "Parent", v17)
        expect(v13).never.to.equal(v17)
        expect(v13).never.to.equal(v18.context)
        assertDeepEqual(v18.context, v17)
        assertDeepEqual(v13, v17)
    end)
    it("should not copy the context table if it doesn't need to", function() -- line 102 | captures: assertDeepEqual, createElement, oneChild, Component, v1
        local Parent = Component:extend("Parent")

        function Parent.init(v19) -- line 105
            v19:__addContext("parent", "I'm here!")
        end

        function Parent.render(v20) -- line 109 | captures: createElement
            return createElement(function() -- line 111
            end)
        end

        local v21 = createElement(Parent)
        local Parent_2 = v1.mountVirtualNode(v21, nil, "Parent")
        local v22 = { parent = "I'm here!" }
        assertDeepEqual(Parent_2.context, v22)
        local v23 = oneChild(Parent_2.children)
        expect(Parent_2.context).to.equal(v23.context)
    end)
    it("should not allow context to move up the tree", function() -- line 131 | captures: assertDeepEqual, createElement, oneChild, Component, v1
        local ChildProvider = Component:extend("ChildProvider")

        local function init(v24) -- line 134
            v24:__addContext("child", "I'm here too!")
        end

        ChildProvider.init = init

        local function render(v25) -- line 138
        end

        ChildProvider.render = render
        local ParentProvider = Component:extend("ParentProvider")

        function ParentProvider.init(v26) -- line 143
            v26:__addContext("parent", "I'm here!")
        end

        function ParentProvider.render(v27) -- line 147 | captures: ChildProvider, createElement
            return createElement(ChildProvider)
        end

        local v28 = createElement(ParentProvider)
        local Parent = v1.mountVirtualNode(v28, nil, "Parent")
        local v29 = oneChild(Parent.children)
        local v30 = { parent = "I'm here!" }
        local v31 = {
            parent = "I'm here!",
            child = "I'm here too!"
        }
        assertDeepEqual(Parent.context, v30)
        assertDeepEqual(v29.context, v31)
    end)
    it("should contain values put into the tree by parent nodes", function() -- line 172 | captures: assertDeepEqual, createElement, Component, v1
        local Consumer = Component:extend("Consumer")
        local v32

        function Consumer.init(v33) -- line 176 | captures: v32
            v32 = {
                dont = v33:__getContext("dont"),
                frob = v33:__getContext("frob")
            }
        end

        local function render(v34) -- line 183
        end

        Consumer.render = render
        local Provider = Component:extend("Provider")

        function Provider.init(v35) -- line 188
            v35:__addContext("frob", "ulator")
        end

        function Provider.render(v36) -- line 192 | captures: Consumer, createElement
            return createElement(Consumer)
        end

        local v37 = createElement(Provider)
        local v38 = { dont = "try it" }
        local v39 = v1.mountVirtualNode(v37, nil, "Consumer", v38)
        local v40 = { dont = "try it" }
        local v41 = {
            dont = "try it",
            frob = "ulator"
        }
        expect(v39.context).never.to.equal(v38)
        expect(v32).never.to.equal(v38)
        expect(v32).never.to.equal(v39.context)
        assertDeepEqual(v38, v40)
        assertDeepEqual(v39.context, v41)
        assertDeepEqual(v32, v41)
    end)
    it("should transfer context to children that are replaced", function() -- line 223 | captures: assertDeepEqual, createElement, Component, v1
        local ConsumerA = Component:extend("ConsumerA")

        local function captureAllContext(v42) -- line 226
            return {
                A = v42:__getContext("A"),
                B = v42:__getContext("B"),
                frob = v42:__getContext("frob")
            }
        end

        local v43

        function ConsumerA.init(v44) -- line 235 | captures: v43, captureAllContext
            v44:__addContext("A", "hello")
            v43 = captureAllContext(v44)
        end

        local function render(v45) -- line 241
        end

        ConsumerA.render = render
        local ConsumerB = Component:extend("ConsumerB")
        local v46

        function ConsumerB.init(v47) -- line 247 | captures: v46, captureAllContext
            v47:__addContext("B", "hello")
            v46 = captureAllContext(v47)
        end

        local function render_2(v48) -- line 253
        end

        ConsumerB.render = render_2
        local Provider = Component:extend("Provider")

        function Provider.init(v49) -- line 258
            v49:__addContext("frob", "ulator")
        end

        function Provider.render(v50) -- line 262 | captures: ConsumerA, ConsumerB, createElement
            if v50.props.useConsumerB then
                return createElement(ConsumerB)
            end
            return createElement(ConsumerA)
        end

        local v51 = createElement(Provider)
        local Consumer = v1.mountVirtualNode(v51, nil, "Consumer")
        local v52 = {
            frob = "ulator",
            A = "hello"
        }
        assertDeepEqual(v43, v52)
        local v53 = {
            frob = "ulator",
            B = "hello"
        }
        local v54 = createElement(Provider, { useConsumerB = true })
        v1.updateVirtualNode(Consumer, v54)
        assertDeepEqual(v46, v53)
    end)
end
