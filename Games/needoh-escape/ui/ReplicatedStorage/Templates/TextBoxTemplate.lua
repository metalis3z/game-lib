-- Generated from ui/ReplicatedStorage/Templates/TextBoxTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "TextBoxTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.0552885, 0.3945783), Size = UDim2.fromScale(0.8894231, 0.267094) })
		I[2] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0529919, 0), Size = UDim2.fromScale(1.1558932, 0.3860154), Text = "This Is A TextBox", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 9.514286 })
		I[5] = new("TextLabel", I[1], "Desc", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.3500001), Size = UDim2.fromScale(0.6359069, 0.5735086), Text = "bleh bleh blehbleh bleh blehbleh bleh blehbleh bleh blehbleh bleh blehbleh bleh blehbleh bleh bleh", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 })
			I[7] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 2.8846154 })
		I[8] = new("TextButton", I[1], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.8716044, 0.6644386), Size = UDim2.fromScale(0.3349443, 0.2788411), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 6 }, { ["Target"] = "Inventory" }, { "ButtonAnimation" })
			I[9] = new("TextBox", I[8], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "hiiiii", Position = UDim2.fromScale(0.0000015, -0.0000036), Size = UDim2.fromScale(0.9999983, 1.0404783), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, ZIndex = 10 })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 })
				I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 3.8620689 })
			I[12] = new("UIAspectRatioConstraint", I[8], "Ratio", { AspectRatio = 4 })
			I[13] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[14] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[15] = new("ImageLabel", I[8], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://131798641019550"), Position = UDim2.fromScale(0.5, 0.5395517), Size = UDim2.fromScale(1, 1.1), ZIndex = 4 }, { ["Id"] = "rbxassetid://87326447332057" })
				I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint", { AspectRatio = 3.6363635 })
				I[17] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint", { AspectRatio = 3.6363635 })
			I[18] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint", { AspectRatio = 4 })
		I[19] = new("TextLabel", I[1], "Min", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4658542, 0.5505801), Size = UDim2.fromScale(0.218593, 0.1323481), Text = "Min: 0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 3 })
			I[21] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", { AspectRatio = 5.5 })
		I[22] = new("TextLabel", I[1], "Max", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4535094, 0.7269131), Size = UDim2.fromScale(0.2351531, 0.1323481), Text = "Max: 10", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 3 })
			I[24] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", { AspectRatio = 5.9166665 })
		I[25] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 3.3299999 })
	return I[1]
end

return build
