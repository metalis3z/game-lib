-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local States = require(Parent.SourceCode.Client.UI.States)
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local Children = Fusion.Children
return function(v1, v2) -- line 13 | captures: States, OnyxUI, Fusion, Children
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components)
    local v4 = OnyxUI.Themer.Theme:now()
    local v5 = OnyxUI.Util.Fallback(v2.Options, {})
    local v6 = v3:EnsureValue(OnyxUI.Util.Fallback(v2.Selection, 1))
    v3:Observer(v5):onChange(function() -- line 20 | captures: v6
        v6:set(1)
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v7 = {
        Name = script.Name,
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal
    }
    v7.ListPadding = v3:Computed(function(v8) -- line 28 | captures: v4
        return UDim.new(0, v8(v4.Spacing["0"]))
    end)
    v7.ScrollingDirection = Enum.ScrollingDirection.X
    v7.AutomaticSize = Enum.AutomaticSize.XY
    v7.AutomaticCanvasSize = Enum.AutomaticSize.X
    v7.CanvasSize = UDim2.fromScale(1.5, 0)
    v7.ScrollBarThickness = 0
    v7.ScrollBarImageTransparency = 1
    v7[Children] = {
        v3:ForValues(v5, function(v9, v10, v11) -- line 39 | captures: v4, v5, v6, States, OnyxUI, Fusion
            local v12 = v9(v5)
            return OnyxUI.Themer.Theme:is(Fusion.peek(States.Theme)):during(function() -- line 42 | captures: v10, v11, v12, v4, v5, v6
                return v10:Button({
                    Name = "OptionButton",
                    SizeVariant = "Medium",
                    Content = v10:Computed(function(v13) -- line 45 | captures: v11
                        return { v11 }
                    end),
                    Style = v10:Computed(function(v14) -- line 48 | captures: v11, v5, v6
                        if v14(v5)[v14(v6)] == v11 then
                            return "Filled"
                        end
                        return "Ghost"
                    end),
                    Color = v4.Colors.BaseContent.Main,
                    LayoutOrder = v10:Computed(function() -- line 57 | captures: v11, v12
                        return table.find(v12, v11) or 0
                    end),
                    OnActivated = function() -- OnActivated | line 61 | captures: v11, v12, v6
                        v6:set(table.find(v12, v11))
                    end
                })
            end)
        end)
    }
    local v15 = v3:Scroller(CombineProps(v2, v7))
    v3:Observer(v5):onChange(function() -- line 70 | captures: v15
        v15.CanvasPosition = Vector2.new(0, 0)
    end)
    return v15
end
