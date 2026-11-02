-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Symbol = require(script.Parent.Symbol)
return (require(script.Parent.strict)({
    Init = Symbol.named("init"),
    Render = Symbol.named("render"),
    ShouldUpdate = Symbol.named("shouldUpdate"),
    WillUpdate = Symbol.named("willUpdate"),
    DidMount = Symbol.named("didMount"),
    DidUpdate = Symbol.named("didUpdate"),
    WillUnmount = Symbol.named("willUnmount"),
    ReconcileChildren = Symbol.named("reconcileChildren"),
    Idle = Symbol.named("idle")
}, "ComponentLifecyclePhase"))
