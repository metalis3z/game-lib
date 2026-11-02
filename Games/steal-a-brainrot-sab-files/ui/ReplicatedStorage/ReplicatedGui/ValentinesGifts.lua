-- Generated from ui/ReplicatedStorage/ReplicatedGui/ValentinesGifts.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ValentinesGifts", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "rbIlHph5rbIl" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "ValentinesGifts", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.99, 0.98) }, { ["_lemonadeUniqueId"] = "NrChKDvnNrCh" })
			I[3] = new("ImageLabel", I[2], "Template", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(244, 154, 220), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1698942, 0.1375656), SliceCenter = Rect.new(485, 14, 485, 75), Visible = false }, { ["_lemonadeUniqueId"] = "zPHMBPCazPHM" })
				I[4] = new("TextLabel", I[3], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.152), Size = UDim2.fromScale(0.93, 0.214), Text = "GIFT RECEIVED", TextColor3 = Color3.fromRGB(244, 102, 190), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "L3NAjswmL3NA" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "DjjZjSBLDjjZ" }, { "ScreenStroke", "UIStroke" })
				I[6] = new("TextLabel", I[3], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.93, 0.225), Text = "SpyderSammy sent you a gift!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "AWmiPC8AAWmi" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "nhX0UDeknhX0" }, { "ScreenStroke", "UIStroke" })
				I[8] = new("ImageButton", I[3], "Yes", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.04, 0.9), Size = UDim2.fromScale(0.439, 0.3) }, { ["_lemonadeUniqueId"] = "ZX3YvNg8ZX3Y" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "b6KD6YJXb6KD" }, { "ScreenStroke", "UIStroke" })
					I[10] = new("TextLabel", I[8], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "OPEN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "9iXSF4p79iXS" })
						I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "AVQp5W4sAVQp" }, { "ScreenStroke", "UIStroke" })
				I[12] = new("ImageButton", I[3], "No", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(233, 66, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.96, 0.9), Size = UDim2.fromScale(0.439, 0.3) }, { ["_lemonadeUniqueId"] = "ksPFizTlksPF" })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "IqHqlwAqIqHq" }, { "ScreenStroke", "UIStroke" })
					I[14] = new("TextLabel", I[12], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "V9FSQqrlV9FS" })
						I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "w2VS2Hwcw2VS" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 0.9342592 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "r66mdv7rr66m" }, { "ScreenStroke", "UIStroke" })
				I[17] = new("Frame", I[3], "Fill", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.025) }, { ["_lemonadeUniqueId"] = "qfThioJrqfTh" })
				I[18] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.75 }, { ["_lemonadeUniqueId"] = "QDFh79LtQDFh" })
	return I[1]
end

return build
