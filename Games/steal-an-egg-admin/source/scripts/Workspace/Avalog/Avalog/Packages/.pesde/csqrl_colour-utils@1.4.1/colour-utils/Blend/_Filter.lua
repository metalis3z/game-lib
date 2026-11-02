-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local ClampColor = require(script.Parent.Parent.Util.ClampColor)
return function(v1, v2) -- line 4 | captures: Assert, ClampColor
    local v3 = Assert.prepTypeOf(v1)
    return function(v4, v5) -- line 7 | captures: v2, v3, ClampColor
        v3("background", "Color3", v4)
        v3("foreground", "Color3", v5)
        local v6 = Color3.fromRGB(v2(v4.R, v5.R), v2(v4.G, v5.G), v2(v4.B, v5.B))
        return ClampColor(v6)
    end
end
