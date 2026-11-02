-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local innerScope = Fusion.innerScope
local v1 = { Base = require(script.Parent.Base) }
return function(v2, v3) -- line 58 | captures: Fusion, Util, Themer, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.TextColor3, v5.Colors.BaseContent.Main)
    local v7 = Util.Fallback(v3.TextSize, v5.TextSize["1"])
    local v8 = Util.Fallback(v3.RichText, true)
    local v9 = Util.Fallback(v3.FontFace, v4:Computed(function(v10) -- line 67 | captures: v5
        return Font.new(v10(v5.Font.Body), v10(v5.FontWeight.Body))
    end))
    local v11 = Util.Fallback(v3.TextWrapped, true)
    local v12 = Util.Fallback(v3.TextXAlignment, Enum.TextXAlignment.Left)
    local v13 = Util.Fallback(v3.TextYAlignment, Enum.TextYAlignment.Top)
    return v4:Hydrate(v4:Base(Util.CombineProps(v3, {
        ClassName = "TextLabel",
        Name = "Text",
        ClipsDescendants = false,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    })))({
        TextColor3 = v6,
        TextSize = v7,
        RichText = v8,
        FontFace = v9,
        TextWrapped = v11,
        TextXAlignment = v12,
        TextYAlignment = v13,
        Text = v3.Text,
        TextTransparency = v3.TextTransparency,
        MaxVisibleGraphemes = v3.MaxVisibleGraphemes,
        LocalizedText = v3.LocalizedText,
        LineHeight = v3.LineHeight,
        TextTruncate = v3.TextTruncate,
        TextScaled = v3.TextScaled,
        Font = v3.Font
    })
end
