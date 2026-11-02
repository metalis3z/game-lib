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
    IconButton = require(script.Parent.IconButton),
    IconText = require(script.Parent.IconText)
}
return function(v2, v3) -- line 48 | captures: Fusion, Util, Themer, Children, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Content, {})
    local v7 = Util.Fallback(v3.ContentSize, v5.TextSize["1.5"])
    local v8 = Util.Fallback(v3.ContentColor, v5.Colors.BaseContent.Main)
    local v9 = Util.Fallback(v3.ContentFontFace, v4:Computed(function(v10) -- line 57 | captures: v5
        return Font.new(v10(v5.Font.Heading), v10(v5.FontWeight.Heading))
    end))
    local v11 = Util.Fallback(v3.CloseButtonDisabled, false)
    local v12 = Util.Fallback(v3.CloseButtonIcon, "rbxassetid://80218226919142")
    local v13 = Util.Fallback(v3.OnClose, function() -- line 63
    end)
    local CombineProps = Util.CombineProps
    local v14 = {
        Name = "TitleBar",
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local v15 = {
        Name = "Title",
        ContentWrapped = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Content = v6,
        ContentColor = v8,
        ContentSize = v7,
        ContentFontFace = v9
    }
    v15.ListPadding = v4:Computed(function(v16) -- line 80 | captures: v5
        return UDim.new(0, v16(v5.Spacing["0.5"]))
    end)
    local v17 = v4:IconText(v15)
    v14[Children] = {
        v17,
        v4:Computed(function(v18) -- line 84 | captures: v4, v7, v8, v11, v12, v13
            if v18(v11) ~= false then
                return
            end
            local v19 = {
                Name = "CloseButton",
                Style = "Ghost",
                Image = v12,
                ContentSize = v7,
                ContentColor = v8,
                Color = v8,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.fromScale(1, 0.5)
            }

            function v19.OnActivated() -- line 96 | captures: v18, v13
                if v18(v13) then
                    v18(v13)()
                end
            end

            return v4:IconButton(v19)
        end)
    }
    return v4:Frame(CombineProps(v3, v14))
end
