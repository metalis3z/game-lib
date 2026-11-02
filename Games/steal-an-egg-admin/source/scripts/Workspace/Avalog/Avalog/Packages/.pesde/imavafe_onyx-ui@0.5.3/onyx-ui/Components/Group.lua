-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Util = require(Parent.Util)
local Fusion = require(Parent.Parent.Fusion)
local innerScope = Fusion.innerScope
local v1 = { Base = require(script.Parent.Base) }
return function(v2, v3) -- line 31 | captures: Util, Fusion, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    return v4:Hydrate(v4:Base(Util.CombineProps(v3, {
        ClassName = "CanvasGroup",
        Name = "Group",
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    })))({
        GroupTransparency = v3.GroupTransparency,
        GroupColor3 = v3.GroupColor3
    })
end
