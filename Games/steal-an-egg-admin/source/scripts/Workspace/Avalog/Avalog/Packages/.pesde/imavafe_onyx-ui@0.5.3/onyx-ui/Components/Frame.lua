-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local innerScope = Fusion.innerScope
local v1 = { Base = require(script.Parent.Base) }
return function(v2, v3) -- line 26 | captures: Fusion, Util, innerScope, v1
    return innerScope(v2, Fusion, Util, v1):Base(Util.CombineProps(v3, {
        ClassName = "Frame",
        Name = "Frame",
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }))
end
