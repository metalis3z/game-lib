-- Generated from ui/ServerScriptService/RadioService/Assets/Interface.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Interface", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Container", { Active = true, BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 0.4, Position = UDim2.fromScale(0.7832838, 0.7669454), Size = UDim2.fromScale(0.318323, 0.2753278) })
			I[3] = new("ScrollingFrame", I[2], "Body", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ElasticBehavior = Enum.ElasticBehavior.Never, LayoutOrder = 2, Position = UDim2.fromScale(0, 0.0995671), ScrollBarImageTransparency = 0.3, ScrollBarThickness = 0, Size = UDim2.fromScale(0.9487805, 0.900433) })
				I[4] = new("UIListLayout", I[3], "List", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.7748917 })
			I[6] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2390244, 0), Size = UDim2.fromScale(0.4878049, 0.0995671), Text = "Foundation Communications", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 8.695652 })
			I[8] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5266214115"), Position = UDim2.fromScale(0.8682927, -0.0909091), Size = UDim2.fromScale(0.1902439, 0.3419913) })
				I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint", { AspectRatio = 0.9873418 })
			I[10] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://8650390810"), Position = UDim2.fromScale(0, -0.2467532), Size = UDim2.fromScale(0.9682927, 0.5324675) })
				I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 3.2276423 })
			I[12] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5266214115"), Position = UDim2.fromScale(0.8682927, -0.965368), Size = UDim2.fromScale(0.1902439, 3.1385281) })
				I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 0.1075862 })
			I[14] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5266214115"), Position = UDim2.fromScale(-0.1015532, -0.9594526), Size = UDim2.fromScale(0.1902439, 3.1385281) })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 0.1075862 })
	return I[1]
end

return build
