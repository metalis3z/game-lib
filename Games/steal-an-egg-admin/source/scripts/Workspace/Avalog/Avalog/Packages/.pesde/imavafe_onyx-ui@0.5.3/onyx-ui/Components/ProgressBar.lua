-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local innerScope = Fusion.innerScope
local v1 = {
    Frame = require(script.Parent.Frame),
    Group = require(script.Parent.Group)
}
return function(v2, v3) -- line 42 | captures: Fusion, Util, Themer, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Progress, 0)
    local v7 = Util.Fallback(v3.Color, v5.Colors.Primary.Main)
    local v8 = Util.Fallback(v3.Direction, Enum.FillDirection.Horizontal)
    local v9 = Util.Fallback(v3.Inverted, false)
    local v10 = Util.Fallback(v3.CornerRadius, v4:Computed(function(v11) -- line 52 | captures: v5
        return UDim.new(0, v11(v5.CornerRadius.Full))
    end))
    local v12 = Util.Fallback(v3.Length, v4:Computed(function() -- line 58
        return UDim.new(0, 200)
    end))
    local CombineProps = Util.CombineProps
    local v13 = { Name = "ProgressBar" }
    v13.Size = v4:Computed(function(v14) -- line 65 | captures: v5, v8, v12
        local v15 = v14(v8)
        local v16 = v14(v12)
        if v15 == Enum.FillDirection.Horizontal then
            return UDim2.new(v16, UDim.new(0, v14(v5.TextSize["0.75"])))
        end
        return UDim2.new(UDim.new(0, v14(v5.TextSize["0.75"])), v16)
    end)
    v13.AutomaticSize = Enum.AutomaticSize.None
    v13.BackgroundTransparency = 0
    v13.BackgroundColor3 = v5.Colors.Neutral.Dark
    v13.CornerRadius = v10
    local v17 = {
        Name = "ProgressFill",
        BackgroundTransparency = 0
    }
    v17.Size = v4:Spring(v4:Computed(function(v18) -- line 83 | captures: v6, v8
        if v18(v8) == Enum.FillDirection.Horizontal then
            return UDim2.fromScale(v18(v6), 1)
        end
        return UDim2.fromScale(1, v18(v6))
    end), v5.SpringSpeed["0.5"], v5.SpringDampening["1"])
    v17.AnchorPoint = v4:Computed(function(v19) -- line 93 | captures: v8, v9
        if v19(v9) then
            if v19(v8) == Enum.FillDirection.Horizontal then
                return Vector2.new(1, 0)
            end
            return Vector2.new(0, 1)
        end
        return Vector2.new(0, 0)
    end)
    v17.Position = v4:Computed(function(v20) -- line 104 | captures: v8, v9
        if v20(v9) then
            if v20(v8) == Enum.FillDirection.Horizontal then
                return UDim2.fromScale(1, 0)
            end
            return UDim2.fromScale(0, 1)
        end
        return UDim2.fromScale(0, 0)
    end)
    v17.AutomaticSize = Enum.AutomaticSize.None
    v17.BackgroundColor3 = v7
    v13[Children] = { v4:Frame(v17) }
    return v4:Group(CombineProps(v3, v13))
end
