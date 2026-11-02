-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script:FindFirstAncestorWhichIsA("Tool"):WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local createElement = v1.createElement
local v2 = v1.PureComponent:extend(script.Name)

function v2.init(v3) -- line 11
    v3:setState({ ShouldDisplayDetails = false })
end

function v2.render(v4) -- line 17 | captures: v1, createElement
    local v5 = {
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(1, 0, 0, 24),
        LayoutOrder = v4.props.LayoutOrder
    }
    local v6 = {
        ColorBar = createElement("Frame", {
            BorderSizePixel = 0,
            BackgroundColor3 = v4.props.ThemeColor,
            Size = UDim2.new(1, 0, 0, 2)
        })
    }
    local v7 = {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0)
    }
    local new = UDim2.new
    local v8 = if v4.state.ShouldDisplayDetails then 1 else 0.5
    v7.Size = new(v8, 0, 0, 22)
    v7.Text = "GOT IT"
    v7.Font = Enum.Font.Gotham
    v7.TextSize = 10
    v7.TextColor3 = Color3.fromRGB(255, 255, 255)

    v7[v1.Event.Activated] = function(v9) -- line 41 | captures: v4
        v4.props.OnDismiss()
    end

    v6.OKButton = createElement("TextButton", v7)
    if v4.state.ShouldDisplayDetails then
        v6.DetailsButton = nil
    else
        local v10 = {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.8,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0.5, 0, 1, 0),
            Size = UDim2.new(0.5, 0, 0, 22),
            Text = "WHAT CAN I DO?",
            Font = Enum.Font.Gotham,
            TextSize = 10,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }

        v10[v1.Event.Activated] = function(v11) -- line 56 | captures: v4
            v4:setState({ ShouldDisplayDetails = true })
        end

        v6.DetailsButton = createElement("TextButton", v10)
    end
    if v4.state.ShouldDisplayDetails then
        v6.ButtonDivider = nil
    else
        v6.ButtonDivider = createElement("Frame", {
            BackgroundTransparency = 0.75,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Position = UDim2.new(0.5, 0, 1, 0),
            AnchorPoint = Vector2.new(0.5, 1),
            Size = UDim2.new(0, 1, 0, 22)
        })
    end
    local v12 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 2),
        Size = UDim2.new(1, 0, 1, -24),
        TextWrapped = true,
        RichText = true,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11,
        TextStrokeTransparency = 0.9,
        LineHeight = 1
    }
    v12.Text = not v4.state.ShouldDisplayDetails and v4.props.NoticeText or v4.props.DetailText

    v12[v1.Change.TextBounds] = function(v13) -- line 84
        v13.Parent.Size = UDim2.new(1, 0, 0, v13.TextBounds.Y + 29 + 22 + 2)
    end

    v6.Text = createElement("TextLabel", v12)
    return createElement("Frame", v5, v6)
end

return v2
