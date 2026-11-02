-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local Children = Fusion.Children
local Out = Fusion.Out
local OnChange = Fusion.OnChange
return function(v1, v2) -- line 16 | captures: OnyxUI, Fusion, States, Children, Out, OnChange
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components, { ItemButton = require(script.Parent.ItemButton) })
    local v4 = OnyxUI.Themer.Theme:now()
    local v5 = OnyxUI.Util.Fallback(v2.Shown, false)
    local v6 = OnyxUI.Util.Fallback(v2.Items, {})
    local v7 = OnyxUI.Util.Fallback(v2.OnReachedEnd, function() -- line 24
    end)
    local v8 = v3:Value(Vector2.new())
    local v9 = v3:Value(Vector2.new())
    local v10 = 0
    local CombineProps = OnyxUI.Util.CombineProps
    local v11 = {
        ListEnabled = true,
        ClipsDescendants = false,
        Name = script.Name,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v11.ListPadding = v3:Computed(function(v12) -- line 35 | captures: v4
        return UDim.new(0, v12(v4.Spacing["1"]))
    end)
    v11.ScrollBarImageColor3 = v4.Colors.Neutral.Light
    v11.Visible = v5
    v11.CanvasSize = UDim2.fromOffset(0, 0)
    v11.Padding = v3:Computed(function(v13) -- line 42 | captures: v4
        return UDim.new(0, v13(v4.Spacing["0"]))
    end)
    v11.PaddingRight = v3:Computed(function(v14) -- line 45 | captures: v4
        return UDim.new(0, v14(v4.Spacing["1"]))
    end)
    local v15 = v3:Hydrate(v3:Scroller(CombineProps(v2, v11)))
    local v16 = {}

    v16[OnChange("CanvasPosition")] = function(v17) -- line 49 | captures: v10, v7, v8, v9, Fusion
        local v18 = Fusion.peek(v7)
        local v19 = Fusion.peek(v8)
        local v20 = Fusion.peek(v9)
        local v21 = v19.Y - v20.Y
        local Y = v17.Y
        if v21 - 500 <= Y and os.time() - v10 > 0.5 then
            v10 = os.time()
            v18()
        end
    end

    v16[Out("AbsoluteCanvasSize")] = v8
    v16[Out("AbsoluteWindowSize")] = v9
    local v22 = {
        Name = "Items",
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
        ListWraps = true,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    v22[Children] = {
        v3:ForPairs(v6, function(v23, v24, v25, v26) -- line 75 | captures: v4, OnyxUI, States
            local v27 = OnyxUI.Themer.Theme:is(v23(States.Theme))
            return v25,
                v27:during(function() -- line 77 | captures: v24, v25, v26, v4
                    return v24:ItemButton({
                        Id = v26.Id,
                        Type = v26.Type,
                        Featured = v26.Featured,
                        Visible = v26.Visible,
                        Owned = v26.Owned,
                        LayoutOrder = v25,
                        Size = UDim2.fromScale(0.125, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        MinSize = v24:Computed(function(v28) -- line 87 | captures: v4
                            return Vector2.new(v28(v4.Spacing["8"]), 0)
                        end)
                    })
                end)
        end)
    }
    local v29 = v3:Frame(v22)
    local v30 = {
        Name = "NoItemsCard",
        ListEnabled = true,
        ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    v30.PaddingTop = v3:Computed(function(v31) -- line 101 | captures: v4
        return UDim.new(0, v31(v4.Spacing["8"]))
    end)
    v30.PaddingBottom = v3:Computed(function(v32) -- line 104 | captures: v4
        return UDim.new(0, v32(v4.Spacing["8"]))
    end)
    v30[Children] = {
        v3:Image({
            Image = "rbxassetid://10480493542",
            BackgroundTransparency = 1
        }),
        v3:Text({
            Text = "No more items to show!\nRate limits may have been hit.",
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center
        })
    }
    v16[Children] = {
        v29,
        v3:Card(v30)
    }
    return (v15(v16))
end
