-- Generated from ui/StarterGui/MoneyGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MoneyGui", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0.0387832, 0.4395062), Size = UDim2.fromScale(0.0666667, 0.0432099) })
			I[3] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0.2541864, -0.1660176), Size = UDim2.fromScale(0.8974359, 0.8) })
				I[4] = new("UICorner", I[3], "UICorner")
				I[5] = new("ImageLabel", I[3], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://6438570209"), Position = UDim2.fromScale(0.1614123, 2.8088689), Size = UDim2.fromScale(0.3, 0.75) })
				I[6] = new("TextLabel", I[3], "TextLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.1488784, 3.5815382), Size = UDim2.fromScale(0.9428571, 0.7852024), Text = "$1000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 47, TextWrapped = true })
					I[7] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 53 })
					I[8] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 3.0019555 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
			I[10] = new("UICorner", I[2], "UICorner")
			I[11] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.2285714 })
	return I[1]
end

return build
