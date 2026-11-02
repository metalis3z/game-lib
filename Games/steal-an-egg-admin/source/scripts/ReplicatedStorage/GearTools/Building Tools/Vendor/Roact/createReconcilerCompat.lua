-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Logging = require(script.Parent.Logging)

local function createReconcilerCompat(v1) -- line 23 | captures: Logging
    local v2 = {}

    function v2.reify(...) -- line 26 | captures: v1, Logging
        Logging.warnOnce("Roact.reify has been renamed to Roact.mount and will be removed in a future release.\nCheck the call to Roact.reify at:\n")
        return v1.mountVirtualTree(...)
    end

    function v2.teardown(...) -- line 32 | captures: v1, Logging
        Logging.warnOnce("Roact.teardown has been renamed to Roact.unmount and will be removed in a future release.\nCheck the call to Roact.teardown at:\n")
        return v1.unmountVirtualTree(...)
    end

    function v2.reconcile(...) -- line 38 | captures: v1, Logging
        Logging.warnOnce("Roact.reconcile has been renamed to Roact.update and will be removed in a future release.\nCheck the call to Roact.reconcile at:\n")
        return v1.updateVirtualTree(...)
    end

    return v2
end

return createReconcilerCompat
