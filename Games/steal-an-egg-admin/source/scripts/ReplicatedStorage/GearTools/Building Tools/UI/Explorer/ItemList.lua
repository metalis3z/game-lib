-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local UI = Parent:WaitForChild("UI")
game:GetService("RunService")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
require(Libraries:WaitForChild("Maid"))
local createElement = v2.createElement
local v3 = require(UI:WaitForChild("Frame"))
local v4 = require(UI:WaitForChild("ScrollingFrame"))
local v5 = require(script.Parent:WaitForChild("ItemRow"))
local ItemList = v2.Component:extend("ItemList")

ItemList.defaultProps = { MaxHeight = 300 }

function ItemList.init(v6, v7) -- line 24
    v6:setState({
        Min = 0,
        Max = v7.MaxHeight,
        CanvasPosition = Vector2.new()
    })

    function v6.UpdateBoundaries(v8) -- line 32 | captures: v6
        if v6.Mounted then
            v6:setState({
                CanvasPosition = v8.CanvasPosition,
                Min = v8.CanvasPosition.Y - v8.AbsoluteSize.Y,
                Max = v8.CanvasPosition.Y + v8.AbsoluteSize.Y
            })
        end
    end
end

function ItemList.didMount(v9) -- line 43
    v9.Mounted = true
end

function ItemList.willUnmount(v10) -- line 47
    v10.Mounted = false
end

function ItemList.didUpdate(v11, v12, v13) -- line 51
    local v14 = v11.props.ScrollTo and v12.ScrollTo ~= v11.props.ScrollTo
    if v12.Scope ~= v11.props.Scope and not v14 then
        v11:setState({
            Min = 0,
            CanvasPosition = Vector2.new(0, 0),
            Max = v11.props.MaxHeight
        })
    end
end

function ItemList.render(v15) -- line 65 | captures: v1, v2, createElement, v3, v4, v5
    local props = v15.props
    local state = v15.state
    local v16 = {}
    local RowHeight = props.RowHeight
    local v17 = v1.Values(props.Items)
    table.sort(v17, function(v18, v19) -- line 81
        return v18.Order < v19.Order
    end)
    local v20 = #v17
    local v21 = 0
    local v22 = 0
    local v23
    local v24 = 0
    for v25 = 1, v20 do
        local v26 = v17[v25]
        local v27 = v26.Parent and props.IdMap[v26.Parent]
        local v28, v29
        if v27 then
            v27 = props.Items[v27]
            local v30 = 0
            while true do
                if v27 then
                    if v27.Expanded then
                        v30 += 1
                        local v31 = props.IdMap[v27.Parent]
                        v27 = props.Items[v31]
                        continue
                    end
                    v28 = nil
                else
                    v28 = true
                end
                v29 = v30
                break
            end
        else
            v28 = true
            v29 = 0
        end
        local v32, v33, v34
        if v26.Id == props.ScrollTo then
            if v15.ScrolledTo == props.ScrollTo then
                v33 = v23
                v34 = true
            else
                v32 = v24 * props.RowHeight
                if v32 < state.CanvasPosition.Y or state.CanvasPosition.Y + props.MaxHeight < v32 then
                    v34 = false
                else
                    v33 = v23
                    v34 = true
                end
            end
        else
            v33 = v23
            v34 = true
        end
        if not v34 then
            v33 = Vector2.new(0, v32)
            v15.ScrolledTo = v26.Id
        end
        local v35
        if v28 then
            v24 += 1
            local v36 = (v24 - 1) * props.RowHeight
            if v36 < state.Min then
                v21 += 1
            elseif state.Max < v36 then
                v22 += 1
            else
                v35 = v28
            end
        else
            v35 = v28
        end
        v16[v26.Id] = v35 and
        createElement(v5, v1.Merge({}, v26, {
            Depth = v29,
            Core = props.Core,
            ToggleExpand = props.ToggleExpand,
            Height = props.RowHeight
        }))
        v23 = v33
    end
    local v37 = {
        Layout = "List",
        LayoutDirection = "Vertical",
        CanvasSize = UDim2.new(1, -2, 0, v24 * props.RowHeight),
        Size = UDim2.new(1, 0, 0, v24 * props.RowHeight)
    }
    v37.CanvasPosition = v23 or state.CanvasPosition
    v37.ScrollBarThickness = 4
    v37.ScrollBarImageTransparency = 0.6
    v37.VerticalScrollBarInset = "ScrollBar"
    v37[v2.Change.CanvasPosition] = v15.UpdateBoundaries
    v37[v2.Children] = v1.Merge(v16, {
        TopSpacer = createElement(v3, {
            LayoutOrder = 0,
            Size = UDim2.new(0, 0, 0, v21 * props.RowHeight)
        }),
        BottomSpacer = createElement(v3, {
            Size = UDim2.new(0, 0, 0, v22 * props.RowHeight),
            LayoutOrder = #v17 + 1
        }),
        SizeConstraint = createElement("UISizeConstraint", {
            MinSize = Vector2.new(0, 20),
            MaxSize = Vector2.new((1/0), props.MaxHeight)
        })
    })
    return createElement(v4, v37)
end

return ItemList
