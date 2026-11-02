-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local innerScope = Fusion.innerScope
local v1 = { Frame = require(script.Parent.Frame) }
return function(v2, v3) -- line 40 | captures: Fusion, Util, Themer, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Length, UDim.new(1, 0))
    local v7 = Util.Fallback(v3.FillDirection, Enum.FillDirection.Horizontal)
    local v8 = Util.Fallback(v3.Color, v5.Colors.BaseContent.Main)
    local v9 = Util.Fallback(v3.Transparency, 0.9)
    local v10 = Util.Fallback(v3.Spacing, v4:Computed(function(v11) -- line 51 | captures: v5
        return UDim.new(0, v11(v5.Spacing["0.5"]))
    end))
    local v12 = v4:Computed(function(v13) -- line 56 | captures: v7, v10
        if v13(v7) == Enum.FillDirection.Horizontal then
            return v13(v10)
        end
        return UDim.new()
    end)
    local v14 = v4:Computed(function(v15) -- line 63 | captures: v7, v10
        if v15(v7) == Enum.FillDirection.Vertical then
            return v15(v10)
        end
        return UDim.new()
    end)
    local CombineProps = Util.CombineProps
    local v16 = { Name = "Divider" }
    v16.Size = v4:Computed(function(v17) -- line 73 | captures: v6, v7
        if v17(v7) == Enum.FillDirection.Horizontal then
            return UDim2.new(v6, UDim.new(0, 0))
        end
        return UDim2.new(UDim.new(0, 0), v17(v6))
    end)
    v16.AutomaticSize = v4:Computed(function(v18) -- line 80 | captures: v7
        if v18(v7) == Enum.FillDirection.Horizontal then
            return Enum.AutomaticSize.Y
        end
        return Enum.AutomaticSize.X
    end)
    v16.PaddingTop = v12
    v16.PaddingBottom = v12
    v16.PaddingLeft = v14
    v16.PaddingRight = v14
    local v19 = { Name = "DividingLine" }
    v19.Size = v4:Computed(function(v20) -- line 95 | captures: v5, v7
        if v20(v7) == Enum.FillDirection.Horizontal then
            return UDim2.new(UDim.new(1, 0), UDim.new(0, v20(v5.StrokeThickness["1"])))
        end
        return UDim2.new(UDim.new(0, v20(v5.StrokeThickness["1"])), UDim.new(1, 0))
    end)
    v19.AutomaticSize = Enum.AutomaticSize.None
    v19.BackgroundColor3 = v8
    v19.BackgroundTransparency = v9
    v16[Children] = { v4:Frame(v19) }
    return v4:Frame(CombineProps(v3, v16))
end
