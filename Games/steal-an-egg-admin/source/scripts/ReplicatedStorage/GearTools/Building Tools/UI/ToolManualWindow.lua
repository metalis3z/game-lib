-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script:FindFirstAncestorWhichIsA("Tool"):WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local createElement = v1.createElement
local v2 = v1.PureComponent:extend(script.Name)

function v2.init(v3) -- line 11 | captures: v1
    local v4, v5 = v1.createBinding(UDim2.new(1, 0, 0, 0))
    v3.CanvasSize = v4
    v3.SetCanvasSize = v5
end

function v2.render(v6) -- line 15 | captures: v1, createElement
    local v7 = { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }
    local v8 = {}
    local v9 = {
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(61, 61, 61),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }
    v9.Size = v6.CanvasSize:map(function(v10) -- line 25
        return UDim2.fromOffset(420, v10.Y.Offset + 10)
    end)
    local v11 = {
        SizeConstraint = createElement("UISizeConstraint", { MaxSize = Vector2.new((1/0), 300) }),
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
        ColorBar = createElement("Frame", {
            BorderSizePixel = 0,
            BackgroundColor3 = v6.props.ThemeColor,
            Size = UDim2.new(0, 3, 1, 0)
        }, { Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 3) }) })
    }
    local v12 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = v6.CanvasSize,
        ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
        ScrollingDirection = Enum.ScrollingDirection.Y
    }
    local v13 = {}
    local v14 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.Gotham,
        LineHeight = 1.2,
        RichText = true,
        Text = v6.props.Text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    }

    v14[v1.Change.TextBounds] = function(v15) -- line 70 | captures: v6
        v6.SetCanvasSize(UDim2.new(1, 0, 0, v15.TextBounds.Y + 20))
    end

    v13.Text = createElement("TextLabel", v14, {
        Padding = createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 0),
            PaddingLeft = UDim.new(0, 25),
            PaddingRight = UDim.new(0, 25),
            PaddingTop = UDim.new(0, 15)
        })
    })
    v11.Content = createElement("ScrollingFrame", v12, v13)
    v8.Window = createElement("Frame", v9, v11)
    return createElement("ScreenGui", v7, v8)
end

return v2
