-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script.Parent.Parent.Parent.Parent:WaitForChild("Vendor")
local TextService = game:GetService("TextService")
local createElement = require(Vendor:WaitForChild("Roact")).createElement
local v1 = Vector2.new((1/0), (1/0))
local v2 = TextService:GetTextSize("Selection mode", 12, Enum.Font.SourceSans, v1)
local v3 = TextService:GetTextSize("SHIFT-T", 12, Enum.Font.SourceSans, v1)
local v4 = TextService:GetTextSize("Groups and parts", 12.5, Enum.Font.SourceSans, v1)
local v5 = TextService:GetTextSize("Parts only", 12.5, Enum.Font.SourceSans, v1)

local function Tooltip(v6) -- line 16 | captures: createElement, v2, v3, v4, v5
    local v7 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://4445959523"
    }
    v7.AnchorPoint = v6.IsToolModeEnabled and Vector2.new(0, 1) or Vector2.new(0, 0)
    v7.Position = v6.IsToolModeEnabled and UDim2.new(0, 0, 0, -6) or UDim2.new(0, 0, 1, 6)
    v7.ScaleType = Enum.ScaleType.Slice
    v7.SliceCenter = Rect.new(4, 4, 12, 12)
    v7.ImageColor3 = Color3.fromRGB(67, 67, 67)
    v7.Size = UDim2.new(0, v2.X + 7.5 + v3.X + 11, 0, 47)
    v7.Visible = v6.Visible
    local v8 = {}
    local v9 = {
        BorderSizePixel = 0,
        Rotation = 45,
        BackgroundColor3 = Color3.fromRGB(67, 67, 67),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }
    v9.Position = v6.IsToolModeEnabled and UDim2.new(0, 9, 1, 0) or UDim2.new(0, 9, 0, 0)
    v9.Size = UDim2.new(0, 5, 0, 5)
    v8.Arrow = createElement("Frame", v9)
    v8.Title = createElement("TextLabel", {
        BackgroundTransparency = 1,
        TextSize = 12,
        TextTransparency = 0.4,
        Text = "Selection mode",
        Font = Enum.Font.SourceSans,
        TextColor3 = Color3.new(1, 1, 1),
        Size = UDim2.new(0, v2.X, 0, v2.Y),
        Position = UDim2.new(0, 4, 0, 4.5)
    })
    v8.Hotkey = createElement("TextLabel", {
        BackgroundTransparency = 1,
        TextSize = 10,
        TextTransparency = 0,
        Text = "SHIFT-T",
        Font = Enum.Font.SourceSansSemibold,
        TextColor3 = Color3.new(1, 1, 1),
        Size = UDim2.new(0, v3.X, 0, v3.Y),
        Position = UDim2.new(0, 4 + v2.X + 7.5, 0, 4.5)
    })
    v8.ScopedIcon = createElement("ImageLabel", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://4463020853",
        ImageTransparency = 0.6,
        Position = UDim2.fromOffset(4, 2.5 + v2.Y + 2),
        Size = UDim2.new(0, 14, 0, 14),
        ImageRectOffset = Vector2.new(0, 0),
        ImageRectSize = Vector2.new(14, 14)
    })
    v8.ScopedLabel = createElement("TextLabel", {
        BackgroundTransparency = 1,
        TextSize = 12.5,
        Text = "Groups and parts",
        Font = Enum.Font.SourceSans,
        TextColor3 = Color3.new(1, 1, 1),
        Size = UDim2.new(0, v4.X, 0, v4.Y),
        Position = UDim2.fromOffset(21, 2.5 + v2.Y + 2),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    v8.DirectIcon = createElement("ImageLabel", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://4463020853",
        ImageTransparency = 0.6,
        Position = UDim2.fromOffset(4, 2.5 + v2.Y + 2 + v4.Y + 1),
        Size = UDim2.new(0, 14, 0, 14),
        ImageRectOffset = Vector2.new(14, 0),
        ImageRectSize = Vector2.new(14, 14)
    })
    v8.DirectLabel = createElement("TextLabel", {
        BackgroundTransparency = 1,
        TextSize = 12.5,
        Text = "Parts only",
        Font = Enum.Font.SourceSans,
        TextColor3 = Color3.new(1, 1, 1),
        Size = UDim2.new(0, v5.X, 0, v5.Y),
        Position = UDim2.fromOffset(21, 2.5 + v2.Y + 2 + v4.Y + 1),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    return createElement("ImageLabel", v7, v8)
end

return Tooltip
