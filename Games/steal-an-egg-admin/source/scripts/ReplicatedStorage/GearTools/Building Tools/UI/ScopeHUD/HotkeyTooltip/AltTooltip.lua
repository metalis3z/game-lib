-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script.Parent.Parent.Parent.Parent:WaitForChild("Vendor")
local TextService = game:GetService("TextService")
local createElement = require(Vendor:WaitForChild("Roact")).createElement
local X = TextService:GetTextSize("ALT", 10.5, Enum.Font.SourceSansSemibold, Vector2.new((1/0), (1/0))).X

local function ScopeInTooltip(v1) -- line 14 | captures: createElement, X
    return createElement("ImageLabel", {
        BackgroundTransparency = 1,
        ImageTransparency = 0.86,
        Image = "rbxassetid://4445959523",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(4, 4, 12, 12),
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, X + 4, 0, 15),
        LayoutOrder = v1.LayoutOrder or 3
    }, {
        Label = createElement("TextLabel", {
            BackgroundTransparency = 1,
            TextSize = 10.5,
            Text = "ALT",
            TextTransparency = 0.5,
            LayoutOrder = 1,
            Size = UDim2.new(0, X, 1, 0),
            Position = UDim2.new(0, 2.5, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Font = Enum.Font.SourceSansSemibold,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        })
    })
end

return ScopeInTooltip
