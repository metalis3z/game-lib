-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script:FindFirstAncestorWhichIsA("Tool"):WaitForChild("Vendor")
local TextService = game:GetService("TextService")
local v1 = require(Vendor:WaitForChild("Roact"))
local createElement = v1.createElement
local v2 = v1.PureComponent:extend(script.Name)

function v2.init(v3) -- line 12 | captures: v1
    local v4, v5 = v1.createBinding(UDim2.new())
    v3.FrameSize = v4
    v3.SetFrameSize = v5
    v3:UpdateTextBounds(v3.props.Text)
end

function v2.willUpdate(v6, v7) -- line 17
    if v6.props.Text ~= v7.Text then
        v6:UpdateTextBounds(v7.Text)
    end
end

function v2.UpdateTextBounds(v8, v9) -- line 23 | captures: TextService
    v8.TextBounds = TextService:GetTextSize(v9:gsub("<br />", "\n"):gsub("<.->", ""), 10, Enum.Font.Gotham, Vector2.new((1/0), (1/0)))
end

function v2.render(v10) -- line 32 | captures: createElement
    return createElement("Frame", {
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(58, 58, 58),
        Position = UDim2.new(0.5, 0, 1, 2),
        Size = UDim2.fromOffset(v10.TextBounds.X + 20, v10.TextBounds.Y + 8),
        Visible = v10.props.IsVisible
    }, {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
        Arrow = createElement("Frame", {
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ZIndex = 2,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(58, 58, 58),
            Position = UDim2.new(0.5, 0, 0, 0),
            Size = UDim2.new(0, 6, 0, 6)
        }),
        Text = createElement("TextLabel", {
            BackgroundTransparency = 1,
            ZIndex = 2,
            RichText = true,
            TextSize = 10,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.Gotham,
            Text = v10.props.Text,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })
    })
end

return v2
