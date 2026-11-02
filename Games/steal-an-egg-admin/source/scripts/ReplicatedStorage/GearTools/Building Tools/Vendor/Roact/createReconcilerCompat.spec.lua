-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createElement = require(script.Parent.createElement)
    local createReconciler = require(script.Parent.createReconciler)
    local Logging = require(script.Parent.Logging)
    local NoopRenderer = require(script.Parent.NoopRenderer)
    local createReconcilerCompat = require(script.Parent.createReconcilerCompat)
    local v1 = createReconciler(NoopRenderer)
    local v2 = createReconcilerCompat(v1)
    it("reify should only warn once per call site", function() -- line 12 | captures: createElement, Logging, v1, v2
        local v3 = Logging.capture(function() -- line 13 | captures: createElement, v1, v2
            local v4 = v2.reify(createElement("StringValue"))
            v1.unmountVirtualTree(v4)
            local v5 = v2.reify(createElement("StringValue"))
            v1.unmountVirtualTree(v5)
        end)
        expect(#v3.warnings).to.equal(1)
        expect(v3.warnings[1]:find("reify")).to.be.ok()
        local v6 = Logging.capture(function() -- line 25 | captures: createElement, v1, v2
            local v7 = v2.reify(createElement("StringValue"))
            v1.unmountVirtualTree(v7)
        end)
        expect(#v6.warnings).to.equal(1)
        expect(v6.warnings[1]:find("reify")).to.be.ok()
    end)
    it("teardown should only warn once per call site", function() -- line 35 | captures: createElement, Logging, v1, v2
        local v8 = Logging.capture(function() -- line 36 | captures: createElement, v1, v2
            local v9 = v1.mountVirtualTree(createElement("StringValue"))
            v2.teardown(v9)
            local v10 = v1.mountVirtualTree(createElement("StringValue"))
            v2.teardown(v10)
        end)
        expect(#v8.warnings).to.equal(1)
        expect(v8.warnings[1]:find("teardown")).to.be.ok()
        local v11 = Logging.capture(function() -- line 48 | captures: createElement, v1, v2
            local v12 = v1.mountVirtualTree(createElement("StringValue"))
            v2.teardown(v12)
        end)
        expect(#v11.warnings).to.equal(1)
        expect(v11.warnings[1]:find("teardown")).to.be.ok()
    end)
    it("update should only warn once per call site", function() -- line 58 | captures: createElement, Logging, v1, v2
        local v13 = Logging.capture(function() -- line 59 | captures: createElement, v1, v2
            for v14 = 1, 2 do
                local v15 = v1.mountVirtualTree(createElement("StringValue"))
                v2.reconcile(v15, createElement("StringValue"))
                v1.unmountVirtualTree(v15)
            end
        end)
        expect(#v13.warnings).to.equal(1)
        expect(v13.warnings[1]:find("reconcile")).to.be.ok()
        local v16 = Logging.capture(function() -- line 72 | captures: createElement, v1, v2
            local v17 = v1.mountVirtualTree(createElement("StringValue"))
            v2.reconcile(v17, createElement("StringValue"))
            v1.unmountVirtualTree(v17)
        end)
        expect(#v16.warnings).to.equal(1)
        expect(v16.warnings[1]:find("reconcile")).to.be.ok()
    end)
end
