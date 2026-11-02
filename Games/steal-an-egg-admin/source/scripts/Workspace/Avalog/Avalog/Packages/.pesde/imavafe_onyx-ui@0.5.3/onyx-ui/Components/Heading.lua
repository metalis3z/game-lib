-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Util = require(Parent.Util)
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local innerScope = Fusion.innerScope
local v1 = { Text = require(Parent.Components.Text) }
return function(v2, v3) -- line 32 | captures: Util, Fusion, Themer, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.HeadingSize, 1.75)
    local v7 = Util.Fallback(v3.TextSize, v5.TextSize["1"])
    local CombineProps = Util.CombineProps
    local v8 = { Name = script.Name }
    v8.TextSize = v4:Computed(function(v9) -- line 41 | captures: v6, v7
        local v10 = v9(v6)
        return v9(v7) * v10
    end)
    v8.FontFace = v4:Computed(function(v11) -- line 47 | captures: v5
        return Font.new(v11(v5.Font.Heading), v11(v5.FontWeight.Heading))
    end)
    return v4:Text(CombineProps(v3, v8))
end
