-- Generated from ui/StarterGui/TreadmillScreenSideButtons.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "TreadmillScreenSideButtons", { AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, PixelsPerStud = 90, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = 1 }, { ["_lemonadeUniqueId"] = "wiB3CDl3wiB3" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "kXHxDnKwkXHx" })
			I[3] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.98, 0.5), Size = UDim2.fromScale(0.171, 0.114) }, { ["_lemonadeUniqueId"] = "Eouz1Df1Eouz" })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.1248285 }, { ["_lemonadeUniqueId"] = "PXIF0znhPXIF" })
				I[5] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.7, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "CFTguujRCFTg" })
				I[6] = new("ImageButton", I[3], "LikeButton", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://123761405635833"), ImageTransparency = 0.18, Position = UDim2.fromScale(0.98, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.76, 0.76), ZIndex = 3 }, { ["MuteSounds"] = true, ["_lemonadeUniqueId"] = "Gnt0Z2hRGnt0" })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 1.1248285 }, { ["_lemonadeUniqueId"] = "bYG5d0vHbYG5" })
					I[8] = new("TextLabel", I[6], "LikeCount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.5), Text = "500k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "ZkIMvMNjZkIM" })
						I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(98, 98, 98), Thickness = 1.2, Transparency = 0.44 }, { ["_lemonadeUniqueId"] = "ATolfLd9ATol" })
				I[10] = new("ImageButton", I[3], "CommentsButton", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116848344464672"), ImageTransparency = 0.18, Position = UDim2.fromScale(0.98, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.76, 0.76), ZIndex = 3 }, { ["MuteSounds"] = true, ["_lemonadeUniqueId"] = "ahqL8dUSahqL" })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 1.1248285 }, { ["_lemonadeUniqueId"] = "APlqCVEmAPlq" })
					I[12] = new("TextLabel", I[10], "CommentsCount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.5), Text = "500k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "uoGDuIhjuoGD" })
						I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(98, 98, 98), Thickness = 1.2, Transparency = 0.44 }, { ["_lemonadeUniqueId"] = "VaEvziwOVaEv" })
	return I[1]
end

return build
