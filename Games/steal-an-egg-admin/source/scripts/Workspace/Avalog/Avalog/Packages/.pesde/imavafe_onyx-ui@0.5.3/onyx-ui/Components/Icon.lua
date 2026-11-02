-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Util = require(Parent.Util)
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(script.Parent.Parent.Themer)
local innerScope = Fusion.innerScope
local v1 = { Image = require(script.Parent.Image) }
return function(v2, v3) -- line 27 | captures: Util, Fusion, Themer, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local CombineProps = Util.CombineProps
    local v6 = {
        Name = "Icon",
        BackgroundTransparency = 1
    }
    v6.Size = v4:Computed(function(v7) -- line 33 | captures: v5
        return UDim2.fromOffset(v7(v5.TextSize["1"]), v7(v5.TextSize["1"]))
    end)
    return v4:Image(CombineProps(v3, v6))
end
