-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should be provided as a mutable self._context in Component:init", function() -- line 11 | captures: assertDeepEqual, createElement, Component, v1
        local Provider = Component:extend("Provider")

        function Provider.init(v2) -- line 14
            v2._context.foo = "bar"
        end

        function Provider.render(v3) -- line 18
        end

        local v4 = createElement(Provider)
        local Provider_2 = v1.mountVirtualNode(v4, nil, "Provider")
        local v5 = { foo = "bar" }
        assertDeepEqual(Provider_2.legacyContext, v5)
    end)
    it("should be inherited from parent stateful nodes", function() -- line 33 | captures: assertDeepEqual, createElement, Component, v1
        local Consumer = Component:extend("Consumer")
        local _context

        function Consumer.init(v6) -- line 37 | captures: _context
            _context = v6._context
        end

        local function render(v7) -- line 41
        end

        Consumer.render = render
        local Parent = Component:extend("Parent")

        function Parent.render(v8) -- line 46 | captures: Consumer, createElement
            return createElement(Consumer)
        end

        local v9 = createElement(Parent)
        local v10 = {
            hello = "world",
            value = 6
        }
        local v11 = v1.mountVirtualNode(v9, nil, "Parent", nil, v10)
        expect(_context).never.to.equal(v10)
        expect(_context).never.to.equal(v11.legacyContext)
        assertDeepEqual(v11.legacyContext, v10)
        assertDeepEqual(_context, v10)
    end)
    it("should be inherited from parent function nodes", function() -- line 65 | captures: assertDeepEqual, createElement, Component, v1
        local Consumer = Component:extend("Consumer")
        local _context

        function Consumer.init(v12) -- line 69 | captures: _context
            _context = v12._context
        end

        local function render(v13) -- line 73
        end

        Consumer.render = render

        local function Parent() -- line 76 | captures: Consumer, createElement
            return createElement(Consumer)
        end

        local v14 = createElement(Parent)
        local v15 = {
            hello = "world",
            value = 6
        }
        local v16 = v1.mountVirtualNode(v14, nil, "Parent", nil, v15)
        expect(_context).never.to.equal(v15)
        expect(_context).never.to.equal(v16.legacyContext)
        assertDeepEqual(v16.legacyContext, v15)
        assertDeepEqual(_context, v15)
    end)
    it("should contain values put into the tree by parent nodes", function() -- line 95 | captures: assertDeepEqual, createElement, Component, v1
        local Consumer = Component:extend("Consumer")
        local _context

        function Consumer.init(v17) -- line 99 | captures: _context
            _context = v17._context
        end

        local function render(v18) -- line 103
        end

        Consumer.render = render
        local Provider = Component:extend("Provider")

        function Provider.init(v19) -- line 108
            v19._context.frob = "ulator"
        end

        function Provider.render(v20) -- line 112 | captures: Consumer, createElement
            return createElement(Consumer)
        end

        local v21 = createElement(Provider)
        local v22 = { dont = "try it" }
        local v23 = v1.mountVirtualNode(v21, nil, "Consumer", nil, v22)
        local v24 = { dont = "try it" }
        local v25 = {
            dont = "try it",
            frob = "ulator"
        }
        expect(v23.legacyContext).never.to.equal(v22)
        expect(_context).never.to.equal(v22)
        expect(_context).never.to.equal(v23.legacyContext)
        assertDeepEqual(v22, v24)
        assertDeepEqual(v23.legacyContext, v25)
        assertDeepEqual(_context, v25)
    end)
    it("should transfer context to children that are replaced", function() -- line 143 | captures: assertDeepEqual, createElement, Component, v1
        local ConsumerA = Component:extend("ConsumerA")
        local _context

        function ConsumerA.init(v26) -- line 147 | captures: _context
            v26._context.A = "hello"
            _context = v26._context
        end

        local function render(v27) -- line 153
        end

        ConsumerA.render = render
        local ConsumerB = Component:extend("ConsumerB")
        local _context_2

        function ConsumerB.init(v28) -- line 159 | captures: _context_2
            v28._context.B = "hello"
            _context_2 = v28._context
        end

        local function render_2(v29) -- line 165
        end

        ConsumerB.render = render_2
        local Provider = Component:extend("Provider")

        function Provider.init(v30) -- line 170
            v30._context.frob = "ulator"
        end

        function Provider.render(v31) -- line 174 | captures: ConsumerA, ConsumerB, createElement
            if v31.props.useConsumerB then
                return createElement(ConsumerB)
            end
            return createElement(ConsumerA)
        end

        local v32 = createElement(Provider)
        local Consumer = v1.mountVirtualNode(v32, nil, "Consumer")
        local v33 = {
            frob = "ulator",
            A = "hello"
        }
        assertDeepEqual(_context, v33)
        local v34 = {
            frob = "ulator",
            B = "hello"
        }
        local v35 = createElement(Provider, { useConsumerB = true })
        v1.updateVirtualNode(Consumer, v35)
        assertDeepEqual(_context_2, v34)
    end)
end
