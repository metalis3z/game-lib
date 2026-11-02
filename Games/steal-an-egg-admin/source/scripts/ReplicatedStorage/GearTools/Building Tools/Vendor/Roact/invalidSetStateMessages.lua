-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ComponentLifecyclePhase = require(script.Parent.ComponentLifecyclePhase)
local v1 = {}

v1[ComponentLifecyclePhase.WillUpdate] = "setState cannot be used in the willUpdate lifecycle method.\nConsider using the didUpdate method instead, or using getDerivedStateFromProps.\n\nCheck the definition of willUpdate in the component %q."
v1[ComponentLifecyclePhase.WillUnmount] = "setState cannot be used in the willUnmount lifecycle method.\nA component that is being unmounted cannot be updated!\n\nCheck the definition of willUnmount in the component %q."
v1[ComponentLifecyclePhase.ShouldUpdate] = "setState cannot be used in the shouldUpdate lifecycle method.\nshouldUpdate must be a pure function that only depends on props and state.\n\nCheck the definition of shouldUpdate in the component %q."
v1[ComponentLifecyclePhase.Render] = "setState cannot be used in the render method.\nrender must be a pure function that only depends on props and state.\n\nCheck the definition of render in the component %q."
v1.default = "setState can not be used in the current situation, because Roact doesn't know\nwhich part of the lifecycle this component is in.\n\nThis is a bug in Roact.\nIt was triggered by the component %q.\n"
return v1
