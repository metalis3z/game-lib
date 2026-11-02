-- Generated from ui/ReplicatedStorage/ReplicatedGui/SecurityCam.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "SecurityCam", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "WTWiPMksWTWi" })
		I[2] = new("ImageLabel", I[1], "Lines", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://92543764882752"), ImageTransparency = 0.9, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(2, 2), TileSize = UDim2.fromScale(1, 0.05) }, { ["_lemonadeUniqueId"] = "NvbQwFCeNvbQ" })
		I[3] = new("ImageLabel", I[1], "Noise", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106244541328715"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(2, 2), SliceCenter = Rect.new(0, 0, 512, 288), TileSize = UDim2.fromScale(0.333, 0.333), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "EC8gbr1PEC8g" })
		I[4] = new("ImageLabel", I[1], "TopLeftCorner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74287015141557"), Rotation = 180, Size = UDim2.fromScale(0.15, 0.15), SliceCenter = Rect.new(0, 0, 512, 288), TileSize = UDim2.fromScale(0.333, 0.333), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "9x6Lr9Qq9x6L" })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "J3xkq38CJ3xk" })
			I[6] = new("Frame", I[4], "Record", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.75, 0.5), Rotation = 180, Size = UDim2.fromScale(3, 1.5), ZIndex = 99 }, { ["_lemonadeUniqueId"] = "Qasfc5WuQasf" })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 5 }, { ["_lemonadeUniqueId"] = "AahBqyw8AahB" })
				I[8] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "S7Zr7JcgS7Zr" })
				I[9] = new("Frame", I[6], "Dot", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(0.8, 0.8) }, { ["_lemonadeUniqueId"] = "fpkZdelLfpkZ" })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "IlI2niC0IlI2" })
					I[11] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "r3kNBiOur3kN" })
					I[12] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "eyScflEeeySc" })
				I[13] = new("TextLabel", I[6], "Text", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.99, 0.99), Size = UDim2.fromScale(0.5, 1), Text = "REC", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 99 }, { ["_lemonadeUniqueId"] = "TZfnsZouTZfn" })
					I[14] = new("UIStroke", I[13], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 }, { ["_lemonadeUniqueId"] = "JU2TtSwcJU2T" })
		I[15] = new("ImageLabel", I[1], "BottomLeftCorner", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74287015141557"), Position = UDim2.fromScale(0, 1), Rotation = 90, Size = UDim2.fromScale(0.15, 0.15), SliceCenter = Rect.new(0, 0, 512, 288), TileSize = UDim2.fromScale(0.333, 0.333), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "mEk7q4J3mEk7" })
			I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "wEJsfOnDwEJs" })
			I[17] = new("TextLabel", I[15], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.75), Rotation = -90, Size = UDim2.fromScale(3, 0.625), Text = "02:34 AM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 99 }, { ["_lemonadeUniqueId"] = "EeSkiw2aEeSk" })
				I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 5 }, { ["_lemonadeUniqueId"] = "bCI9c7vLbCI9" })
				I[19] = new("UIStroke", I[17], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 }, { ["_lemonadeUniqueId"] = "6p0VlYNT6p0V" })
		I[20] = new("ImageLabel", I[1], "BottomRightCorner", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74287015141557"), Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.15, 0.15), SliceCenter = Rect.new(0, 0, 512, 288), TileSize = UDim2.fromScale(0.333, 0.333), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "OUGmap48OUGm" })
			I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "iOzz0rs8iOzz" })
			I[22] = new("TextLabel", I[20], "CamNumber", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.75, 0.5), Size = UDim2.fromScale(3, 0.625), Text = "CAM_01", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 99 }, { ["_lemonadeUniqueId"] = "jaLRCxPTjaLR" })
				I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", { AspectRatio = 5 }, { ["_lemonadeUniqueId"] = "eZtGCpOCeZtG" })
				I[24] = new("UIStroke", I[22], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 }, { ["_lemonadeUniqueId"] = "F0HEH43XF0HE" })
		I[25] = new("ImageLabel", I[1], "TopRightCorner", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74287015141557"), Position = UDim2.fromScale(1, 0), Rotation = -90, Size = UDim2.fromScale(0.15, 0.15), SliceCenter = Rect.new(0, 0, 512, 288), TileSize = UDim2.fromScale(0.333, 0.333), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "gnfVeLDJgnfV" })
			I[26] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "EOy8AJEWEOy8" })
			I[27] = new("ImageLabel", I[25], "BatteryIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132015840678217"), Position = UDim2.fromScale(0.5, 0), Rotation = 90, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5845965, 1.2203507), ZIndex = 99 }, { ["_lemonadeUniqueId"] = "Uj5azvtXUj5a" })
		I[28] = new("ImageButton", I[1], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Modal = true, Position = UDim2.fromScale(0.5, 0.9), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.15, 0.1), SliceCenter = Rect.new(10, 10, 66, 66), ZIndex = 99 }, { ["_lemonadeUniqueId"] = "6csIF0Pv6csI" })
			I[29] = new("TextLabel", I[28], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "Close", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "aFxPc9jHaFxP" })
				I[30] = new("UIStroke", I[29], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 }, { ["_lemonadeUniqueId"] = "eOwU0HEaeOwU" })
			I[31] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint", { AspectRatio = 2.5 }, { ["_lemonadeUniqueId"] = "zdZarkBxzdZa" })
	return I[1]
end

return build
