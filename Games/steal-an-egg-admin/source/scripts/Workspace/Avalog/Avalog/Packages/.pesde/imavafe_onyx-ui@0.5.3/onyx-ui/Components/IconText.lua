-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Util = require(Parent.Util)
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local innerScope = Fusion.innerScope
local Frame = require(Parent.Components.Frame)
local v1 = {
    Text = require(Parent.Components.Text),
    Icon = require(Parent.Components.Icon),
    Frame = Frame
}
return function(v2, v3) -- line 47 | captures: Util, Fusion, Themer, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Content, {})
    local v7 = Util.Fallback(v3.ContentSize, v5.TextSize["1"])
    local v8 = Util.Fallback(v3.ContentColor, v5.Colors.BaseContent.Main)
    local v9 = Util.Fallback(v3.ContentTransparency, 0)
    local v10 = Util.Fallback(v3.ContentWrapped, true)
    local v11 = Util.Fallback(v3.ContentRichText, true)
    local v12 = Util.Fallback(v3.ContentFontFace, v4:Computed(function(v13) -- line 59 | captures: v5
        return Font.new(v13(v5.Font.Body), v13(v5.FontWeight.Body))
    end))
    local CombineProps = Util.CombineProps
    local v14 = {
        Name = script.Name,
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal
    }
    v14.ListPadding = v4:Computed(function(v15) -- line 68 | captures: v5
        return UDim.new(0, v15(v5.Spacing["0"]))
    end)
    v14[Children] = {
        v4:ForValues(v6, function(v16, v17, v18) -- line 73 | captures: v7, v8, v9, v10, v11, v12
            if string.find(v18, "rbxassetid://", 1, true) then
                return v17:Icon({
                    Image = v18,
                    ImageColor3 = v8,
                    Size = v17:Computed(function(v19) -- line 78 | captures: v7
                        return UDim2.fromOffset(v19(v7), v19(v7))
                    end),
                    ImageTransparency = v9
                })
            end
            return v17:Text({
                Text = v18,
                TextColor3 = v8,
                TextSize = v7,
                TextTransparency = v9,
                TextWrapped = v10,
                RichText = v11,
                FontFace = v12
            })
        end)
    }
    return v4:Frame(CombineProps(v3, v14))
end
