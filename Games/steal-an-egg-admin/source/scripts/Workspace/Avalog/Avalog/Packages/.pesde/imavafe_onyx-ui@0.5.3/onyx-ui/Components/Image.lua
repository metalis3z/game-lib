-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local innerScope = Fusion.innerScope
local v1 = { Base = require(script.Parent.Base) }
return function(v2, v3) -- line 47 | captures: Fusion, Util, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Util.Fallback(v3.FallbackImage, "rbxasset://textures/ui/GuiImagePlaceholder.png")
    local v6 = Util.Fallback(v3.Image, nil)
    local v7 = v4:Computed(function(v8) -- line 53 | captures: v5, v6
        if v8(v6) then
            return v8(v6)
        end
        return v8(v5)
    end)
    return v4:Hydrate(v4:Base(Util.CombineProps(v3, {
        ClassName = "ImageLabel",
        Name = "Image",
        Size = UDim2.fromOffset(100, 100),
        AutomaticSize = Enum.AutomaticSize.None
    })))({
        Image = v7,
        ImageColor3 = v3.ImageColor3,
        ImageTransparency = v3.ImageTransparency,
        ImageRectSize = v3.ImageRectSize,
        ResampleMode = v3.ResampleMode,
        ScaleType = v3.ScaleType,
        SliceCenter = v3.SliceCenter,
        SliceScale = v3.SliceScale,
        TileSize = v3.TileSize
    })
end
