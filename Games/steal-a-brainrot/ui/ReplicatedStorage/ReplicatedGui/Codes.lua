-- Generated from ui/ReplicatedStorage/ReplicatedGui/Codes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Codes", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_5c90180dcc" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Codes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -6, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.35, 0.35), Visible = false }, { ["ViralWorkerRef"] = "vw_ea2cf177f6" })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.75 }, { ["ViralWorkerRef"] = "vw_a7343f510b" })
			I[4] = new("Frame", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(85, 255, 127), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0012953), Size = UDim2.fromScale(1, 0.1973904) }, { ["ViralWorkerRef"] = "vw_1c4dd1435b" })
				I[5] = new("ImageButton", I[4], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.935, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1046386, 0.7770305) }, { ["ViralWorkerRef"] = "vw_fd814a553c" })
					I[6] = new("TextLabel", I[5], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_2ff3453c7f" })
						I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_e8ae9a557d" }, { "ScreenStroke", "UIStroke" })
						I[8] = new("UIPadding", I[6], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["ViralWorkerRef"] = "vw_a0fc0cf07f" })
				I[9] = new("TextLabel", I[4], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4471743, 0.5000006), Size = UDim2.fromScale(0.8359804, 0.777031), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_97e4827bd2" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 1.8518518 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_2c27c419a5" }, { "ScreenStroke", "UIStroke" })
				I[11] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }) }, { ["ViralWorkerRef"] = "vw_54dcf37184" })
			I[12] = new("TextLabel", I[2], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4985293, 0.3633362), RichText = true, Size = UDim2.fromScale(0.8999997, 0.2304949), Text = "Redeem any Codes from Admin here", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_3c857f99f5" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.8518518 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_99ad83ea9a" }, { "ScreenStroke", "UIStroke" })
			I[14] = new("Frame", I[2], "CodeRedeem", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 170, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 170, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6156899), Size = UDim2.fromScale(0.8545258, 0.1711729) }, { ["ViralWorkerRef"] = "vw_18e556fe52" })
				I[15] = new("TextBox", I[14], "TextBox", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(122, 122, 122), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(235, 235, 235), PlaceholderText = "Code Here...", Position = UDim2.fromScale(0.5, 0.4999998), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_dd98159691" })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_dc32c90810" }, { "ScreenStroke", "UIStroke" })
					I[17] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.15, 0) }, { ["ViralWorkerRef"] = "vw_36d31aaae6" })
				I[18] = new("UIStroke", I[14], "UIStroke", { Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_7e173b93f8" }, { "ScreenStroke", "UIStroke" })
			I[19] = new("ImageButton", I[2], "Confirm", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5000001, 0.95), Size = UDim2.fromScale(0.5226423, 0.1826344) }, { ["ViralWorkerRef"] = "vw_cb7a081c3a" })
				I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(16, 29, 17), Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_497859857d" }, { "ScreenStroke", "UIStroke" })
				I[21] = new("TextLabel", I[19], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4999998), Size = UDim2.fromScale(1, 0.5600001), Text = "Submit", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_e558868228" })
					I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 3.7037036 }, { ["OriginalThickness"] = 4, ["ViralWorkerRef"] = "vw_ff067d8a38" }, { "ScreenStroke", "UIStroke" })
			I[23] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }) }, { ["ViralWorkerRef"] = "vw_2d6e7bb9ed" })
	return I[1]
end

return build
