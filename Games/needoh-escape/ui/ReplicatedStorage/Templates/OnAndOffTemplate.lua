-- Generated from ui/ReplicatedStorage/Templates/OnAndOffTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "OnAndOffTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.0552885, 0), Size = UDim2.fromScale(0.8894231, 0.267094) })
		I[2] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0529921, 0), Size = UDim2.fromScale(1.1558933, 0.3860154), Text = "This Is An On And Off Button!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 9.514286 })
		I[5] = new("TextLabel", I[1], "Desc", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.361029), Size = UDim2.fromScale(0.6127228, 0.5735086), Text = "bleh bleh blehbleh bleh blehbleh bleh blehbleh bleh blehbleh bleh blehbleh bleh bleh", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 })
			I[7] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 4.1730771 })
		I[8] = new("TextButton", I[1], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.8550444, 0.5982645), Size = UDim2.fromScale(0.3349443, 0.2788411), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 6 }, { ["Target"] = "Inventory" }, { "ButtonAnimation" })
			I[9] = new("UIAspectRatioConstraint", I[8], "Ratio", { AspectRatio = 4 })
			I[10] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[11] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[12] = new("TextLabel", I[8], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999996), Size = UDim2.fromScale(0.9, 0.6), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[13] = new("UIStroke", I[12], "Stroke", { Thickness = 3 })
				I[14] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 6 })
				I[15] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 19 })
			I[16] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[17] = new("ImageLabel", I[8], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://110859788740064"), Position = UDim2.fromScale(0.5000001, 0.4999996), Size = UDim2.fromScale(1, 1.1), ZIndex = 4 }, { ["Id"] = "rbxassetid://87326447332057" })
				I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 3.6363635 })
		I[19] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 3.3299999 })
	return I[1]
end

return build
