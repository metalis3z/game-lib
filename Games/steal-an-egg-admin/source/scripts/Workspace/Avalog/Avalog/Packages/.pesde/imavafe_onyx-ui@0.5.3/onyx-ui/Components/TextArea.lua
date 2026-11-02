-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Util = require(Parent.Util)
local Fusion = require(Parent.Parent.Fusion)
local innerScope = Fusion.innerScope
local v1 = { TextInput = require(Parent.Components.TextInput) }
return function(v2, v3) -- line 26 | captures: Util, Fusion, innerScope, v1
    return innerScope(v2, Fusion, Util, v1):TextInput(Util.CombineProps(v3, {
        TextWrapped = true,
        MultiLine = true,
        AutomaticSize = Enum.AutomaticSize.None
    }))
end
