-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script.Parent.Parent.Parent.Parent:WaitForChild("Vendor")
local TextService = game:GetService("TextService")
local createElement = require(Vendor:WaitForChild("Roact")).createElement
local X = TextService:GetTextSize("SHIFT-Z", 12, Enum.Font.SourceSans, Vector2.new((1/0), (1/0))).X

local function ScopeOutTooltip(v1) -- line 15 | captures: createElement, X
    return createElement("ImageLabel", {
        BackgroundTransparency = 1,
        ImageTransparency = 0.9299999999999999,
        Image = "rbxassetid://4445959523",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(4, 4, 12, 12),
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, X + 15, 0, 15),
        LayoutOrder = v1.LayoutOrder or 3
    }, {
        IconWrapper = createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 0,
            Size = UDim2.new(0, 10.5, 0, 10.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5)
        }, {
            Icon = createElement("ImageLabel", {
                BackgroundTransparency = 1,
                ImageTransparency = 0.7,
                Image = "rbxassetid://2244452978",
                Rotation = -90,
                Size = UDim2.new(1, 0, 1, 0),
                ImageRectOffset = Vector2.new(42, 0) * 2,
                ImageRectSize = Vector2.new(14, 14) * 2
            })
        }),
        Label = createElement("TextLabel", {
            BackgroundTransparency = 1,
            TextSize = 12,
            Text = "SHIFT-Z",
            TextTransparency = 0.7,
            LayoutOrder = 1,
            Size = UDim2.new(0, X, 1, 0),
            Position = UDim2.new(0, 10.5, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.SourceSans,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        })
    })
end

return ScopeOutTooltip
