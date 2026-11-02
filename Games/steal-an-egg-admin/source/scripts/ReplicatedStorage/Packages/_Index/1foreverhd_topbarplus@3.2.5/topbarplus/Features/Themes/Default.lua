-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {
    "IconCorners",
    "CornerRadius",
    UDim.new(1, 0)
}
local v3 = {
    "Selection",
    "Size",
    UDim2.new(1, 0, 1, 1)
}
local v4 = {
    "Selection",
    "Position",
    UDim2.new(0, 0, 0, 0)
}
local v5 = {}
local v6 = {}

v6[1] = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
v6[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 86, 86))
v5[1] = "SelectionGradient"
v5[2] = "Color"
v5[3] = ColorSequence.new(v6)

local v7 = {}
local v8 = UDim2.fromOffset(0, 0)

v7[1] = "IconLabel"
v7[2] = "Position"
v7[3] = v8
v7[4] = "Deselected"

local v9 = {}
local v10 = Color3.fromRGB(18, 18, 21)

v9[1] = "IconButton"
v9[2] = "BackgroundColor3"
v9[3] = v10
v9[4] = "Deselected"

local v11 = {}
local v12 = UDim.new(0, 0)

v11[1] = "IconImageCorner"
v11[2] = "CornerRadius"
v11[3] = v12
v11[4] = "Deselected"
v1[1] = v2
v1[2] = { "Selection", "RotationSpeed", 1 }
v1[3] = v3
v1[4] = v4
v1[5] = v5
v1[6] = { "IconImage", "Image", "", "Deselected" }
v1[7] = { "IconLabel", "Text", "", "Deselected" }
v1[8] = v7
v1[9] = { "Widget", "DesiredWidth", 44, "Deselected" }
v1[10] = { "Widget", "MinimumWidth", 44, "Deselected" }
v1[11] = { "Widget", "MinimumHeight", 44, "Deselected" }
v1[12] = { "Widget", "BorderSize", 4, "Deselected" }
v1[13] = v9
v1[14] = { "IconButton", "BackgroundTransparency", 0.08, "Deselected" }
v1[15] = { "IconImageScale", "Value", 0.5, "Deselected" }
v1[16] = v11

local v13 = {}
local v14 = Color3.fromRGB(255, 255, 255)

v13[1] = "IconImage"
v13[2] = "ImageColor3"
v13[3] = v14
v13[4] = "Deselected"

local v15 = {}
local v16 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

v15[1] = "IconLabel"
v15[2] = "FontFace"
v15[3] = v16
v15[4] = "Deselected"

local v17 = {
    "ContentsList",
    "HorizontalAlignment",
    Enum.HorizontalAlignment.Center,
    "Deselected"
}
local v18 = {}
local v19 = Color3.fromRGB(18, 18, 21)

v18[1] = "Dropdown"
v18[2] = "BackgroundColor3"
v18[3] = v19
v18[4] = "Deselected"
v1[17] = v13
v1[18] = { "IconImage", "ImageTransparency", 0, "Deselected" }
v1[19] = { "IconImageRatio", "AspectRatio", 1, "Deselected" }
v1[20] = v15
v1[21] = { "IconLabel", "TextSize", 16, "Deselected" }
v1[22] = { "IconSpot", "BackgroundTransparency", 1, "Deselected" }
v1[23] = { "IconOverlay", "BackgroundTransparency", 0.85, "Deselected" }
v1[24] = { "IconSpotGradient", "Enabled", false, "Deselected" }
v1[25] = { "IconGradient", "Enabled", false, "Deselected" }
v1[26] = { "ClickRegion", "Active", true, "Deselected" }
v1[27] = { "Menu", "Active", false, "Deselected" }
v1[28] = v17
v1[29] = v18
v1[30] = { "Dropdown", "BackgroundTransparency", 0.08, "Deselected" }
v1[31] = { "Dropdown", "MaxIcons", 4.5, "Deselected" }
v1[32] = { "Menu", "MaxIcons", 4, "Deselected" }

local v20 = {}
local v21 = UDim2.new(1, -12, 0, -1)

v20[1] = "Notice"
v20[2] = "Position"
v20[3] = v21
v20[4] = "Deselected"

local v22 = {}
local v23 = UDim2.new(0, 20, 0, 20)

v22[1] = "Notice"
v22[2] = "Size"
v22[3] = v23
v22[4] = "Deselected"

local v24 = {}
local v25 = UDim2.new(0, 9, 1, 0)

v24[1] = "PaddingLeft"
v24[2] = "Size"
v24[3] = v25
v24[4] = "Deselected"

local v26 = {}
local v27 = UDim2.new(0, 11, 1, 0)

v26[1] = "PaddingRight"
v26[2] = "Size"
v26[3] = v27
v26[4] = "Deselected"

local v28 = {}
local v29 = Color3.fromRGB(255, 255, 255)

v28[1] = "IconSpot"
v28[2] = "BackgroundColor3"
v28[3] = v29
v28[4] = "Selected"

local v30 = {}
local v31 = Color3.fromRGB(96, 98, 100)
local v32 = ColorSequence.new(v31, Color3.fromRGB(77, 78, 80))

v30[1] = "IconSpotGradient"
v30[2] = "Color"
v30[3] = v32
v30[4] = "Selected"
v1[33] = v20
v1[34] = v22
v1[35] = { "NoticeLabel", "TextSize", 13, "Deselected" }
v1[36] = v24
v1[37] = v26
v1[38] = { "IconSpot", "BackgroundTransparency", 0.7, "Selected" }
v1[39] = v28
v1[40] = { "IconSpotGradient", "Enabled", true, "Selected" }
v1[41] = { "IconSpotGradient", "Rotation", 45, "Selected" }
v1[42] = v30
return v1
