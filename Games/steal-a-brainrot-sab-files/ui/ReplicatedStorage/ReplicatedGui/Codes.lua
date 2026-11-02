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
	I[1] = new("ScreenGui", nil, "Codes", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "BSTCcTHlBSTC" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Codes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.35, 0.35) }, { ["_lemonadeUniqueId"] = "O3Uq9mdHO3Uq" })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.75 }, { ["_lemonadeUniqueId"] = "bTtcy3gKbTtc" })
			I[4] = new("TextLabel", I[2], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(68, 207, 47), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4985293, 0.3633362), RichText = true, Size = UDim2.fromScale(0.8999997, 0.2304949), Text = "Redeem any <font color=\"rgb(36, 217, 33)\">DLC codes</font>, or codes from <font color=\"rgb(255, 213, 0)\">Admin</font> here", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "iARs38K8iARs" })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.8518518 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "4uHc4d5j4uHc" }, { "ScreenStroke", "UIStroke" })
			I[6] = new("Frame", I[2], "CodeRedeem", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(122, 122, 122), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6156899), Size = UDim2.fromScale(0.8545258, 0.1711729) }, { ["_lemonadeUniqueId"] = "Kc0eDi1xKc0e" })
				I[7] = new("TextBox", I[6], "TextBox", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(122, 122, 122), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(235, 235, 235), PlaceholderText = "Code Here...", Position = UDim2.fromScale(0.5, 0.4999998), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "IkmkMv7ZIkmk" })
					I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "ImAVvj5TImAV" }, { "ScreenStroke", "UIStroke" })
					I[9] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.15, 0) }, { ["_lemonadeUniqueId"] = "XGLGm75tXGLG" })
				I[10] = new("UIStroke", I[6], "UIStroke", { Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "od3TPo7vod3T" }, { "ScreenStroke", "UIStroke" })
			I[11] = new("ImageButton", I[2], "Confirm", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5000001, 0.95), Size = UDim2.fromScale(0.5226423, 0.1826344) }, { ["_lemonadeUniqueId"] = "QraJwmgYQraJ" })
				I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(16, 29, 17), Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "bkuC9W3vbkuC" }, { "ScreenStroke", "UIStroke" })
				I[13] = new("TextLabel", I[11], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4999998), Size = UDim2.fromScale(1, 0.5600001), Text = "Submit", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "CG9WZoFbCG9W" })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 3.7037036 }, { ["OriginalThickness"] = 4, ["_lemonadeUniqueId"] = "lZzsmVbVlZzs" }, { "ScreenStroke", "UIStroke" })
				I[15] = new("UICorner", I[11], "UICorner", nil, { ["_lemonadeUniqueId"] = "lA1tYQ80lA1t" })
			I[16] = new("UICorner", I[2], "UICorner", nil, { ["_lemonadeUniqueId"] = "RCc4zlVHRCc4" })
			I[17] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://129436581825199"), Position = UDim2.fromScale(-0.0874632, -0.1516136), Rotation = -30, Size = UDim2.fromScale(0.1939271, 0.2662826) }, { ["_lemonadeUniqueId"] = "aOJruikQaOJr" })
				I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 1.0483871 }, { ["_lemonadeUniqueId"] = "ZeHEE83HZeHE" })
			I[19] = new("Frame", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 0, 4), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0012953), Size = UDim2.fromScale(1, 0.1973904) }, { ["_lemonadeUniqueId"] = "NIozYLkANIoz" })
				I[20] = new("ImageButton", I[19], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.935, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1046386, 0.7770305) }, { ["_lemonadeUniqueId"] = "RF5le1y0RF5l" })
					I[21] = new("TextLabel", I[20], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "5hPPk5wi5hPP" })
						I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2.7777777 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "pXpnsBampXpn" }, { "ScreenStroke", "UIStroke" })
						I[23] = new("UIPadding", I[21], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "gup5Hq22gup5" })
				I[24] = new("TextLabel", I[19], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4471743, 0.5000006), Size = UDim2.fromScale(0.8359804, 0.777031), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "uOhIn6VjuOhI" })
					I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 1.8518518 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "li7M754ali7M" }, { "ScreenStroke", "UIStroke" })
				I[26] = new("UICorner", I[19], "UICorner", nil, { ["_lemonadeUniqueId"] = "ed5As31ted5A" })
	return I[1]
end

return build
