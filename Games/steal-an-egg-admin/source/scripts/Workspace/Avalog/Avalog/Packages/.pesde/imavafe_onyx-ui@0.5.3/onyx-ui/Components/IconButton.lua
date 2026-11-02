-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local innerScope = Fusion.innerScope
local v1 = { Button = require(script.Parent.Button) }
return function(v2, v3) -- line 30 | captures: Fusion, Util, Themer, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Image, "")
    local v7 = v4:Computed(function(v8) -- line 35 | captures: v5
        return UDim.new(0, v8(v5.Spacing["0.25"]))
    end)
    local CombineProps = Util.CombineProps
    local v9 = {
        Name = "IconButton",
        PaddingLeft = v7,
        PaddingRight = v7,
        PaddingTop = v7,
        PaddingBottom = v7
    }
    v9.Content = v4:Computed(function(v10) -- line 45 | captures: v6
        return { v10(v6) }
    end)
    return v4:Button(CombineProps(v3, v9))
end
