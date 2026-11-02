-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local innerScope = Fusion.innerScope
local v1 = { Base = require(script.Parent.Base) }
return function(v2, v3) -- line 58 | captures: Fusion, Themer, Util, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.BottomImage, v4:Computed(function(v7) -- line 64 | captures: v5
        if v7(v5.CornerRadius["1"]) >= 3 then
            return "rbxassetid://16547643439"
        end
        return "rbxassetid://16547330984"
    end))
    local v8 = Util.Fallback(v3.TopImage, v4:Computed(function(v9) -- line 74 | captures: v5
        if v9(v5.CornerRadius["1"]) >= 3 then
            return "rbxassetid://16547667444"
        end
        return "rbxassetid://16547330984"
    end))
    local v10 = Util.Fallback(v3.MidImage, "rbxassetid://16547330984")
    local v11 = Util.Fallback(v3.ScrollBarImageColor3, v5.Colors.NeutralContent.Dark)
    local v12 = Util.Fallback(v3.ScrollBarImageTransparency, 0)
    local v13 = Util.Fallback(v3.ScrollBarThickness, 8)
    local v14 = Util.Fallback(v3.AutomaticCanvasSize, Enum.AutomaticSize.Y)
    local v15 = Util.Fallback(v3.ScrollingDirection, Enum.ScrollingDirection.Y)
    return v4:Hydrate(v4:Base(Util.CombineProps(v3, {
        ClassName = "ScrollingFrame",
        Name = "Scroller",
        Selectable = false,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.None
    })))({
        BottomImage = v6,
        TopImage = v8,
        MidImage = v10,
        ScrollBarImageColor3 = v11,
        ScrollBarImageTransparency = v12,
        ScrollBarThickness = v13,
        AutomaticCanvasSize = v14,
        ScrollingDirection = v15,
        CanvasPosition = v3.CanvasPosition,
        CanvasSize = v3.CanvasSize,
        ElasticBehavior = v3.ElasticBehavior,
        HorizontalScrollBarInset = v3.HorizontalScrollBarInset,
        ScrollingEnabled = v3.ScrollingEnabled,
        VerticalScrollBarInset = v3.VerticalScrollBarInset,
        VerticalScrollBarPosition = v3.VerticalScrollBarPosition
    })
end
