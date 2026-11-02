-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script:FindFirstAncestorWhichIsA("Tool"):WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local createElement = v1.createElement
local v2 = require(script:WaitForChild("ToolList"))
local v3 = require(script:WaitForChild("SelectionPane"))
local v4 = require(script:WaitForChild("AboutPane"))
local v5 = v1.PureComponent:extend(script.Name)

function v5.init(v6) -- line 16 | captures: v1
    local v7, v8 = v1.createBinding(UDim2.new())
    v6.DockSize = v7
    v6.SetDockSize = v8
end

function v5.render(v9) -- line 20 | captures: v1, createElement, v2, v3, v4
    local v10 = {
        Active = true,
        BackgroundTransparency = 1,
        ZIndex = 0,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.6, 0),
        Size = v9.DockSize
    }
    local v11 = {}
    local v12 = {
        Padding = UDim.new(0, 1),
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    }

    v12[v1.Ref] = function(v13) -- line 35 | captures: v9
        if v13 then
            v9.SetDockSize(UDim2.fromOffset(v13.AbsoluteContentSize.X, v13.AbsoluteContentSize.Y))
        end
    end

    v12[v1.Change.AbsoluteContentSize] = function(v14) -- line 40 | captures: v9
        v9.SetDockSize(UDim2.fromOffset(v14.AbsoluteContentSize.X, v14.AbsoluteContentSize.Y))
    end

    v11.Layout = createElement("UIListLayout", v12)
    v11.ToolList = createElement(v2, {
        LayoutOrder = 0,
        Tools = v9.props.Tools,
        Core = v9.props.Core
    })
    v11.SelectionPane = createElement(v3, {
        LayoutOrder = 1,
        Core = v9.props.Core
    })
    v11.AboutPane = createElement(v4, {
        LayoutOrder = 2,
        Core = v9.props.Core
    })
    return createElement("Frame", v10, v11)
end

return v5
