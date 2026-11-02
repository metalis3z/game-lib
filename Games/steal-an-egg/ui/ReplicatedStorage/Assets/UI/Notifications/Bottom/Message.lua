-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Bottom/Message.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("CanvasGroup", nil, "Message", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1.5, 0.3) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.83), ZIndex = 2 })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[4] = new("TextLabel", I[2], "TextLabel", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, RichText = true, Size = UDim2.fromScale(0, 1), Text = "Generic message w00t!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 3.2 })
			I[6] = new("ImageLabel", I[2], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.2108759, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.067499, 1), Visible = false })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 1.3231632 })
			I[8] = new("TextLabel", I[2], "PreText", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, RichText = true, Size = UDim2.fromScale(0, 1), Text = "Generic message w00t!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 2 })
				I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 3.2 })
		I[10] = new("ImageLabel", I[1], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://90683431509636"), ImageTransparency = 0.56, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 1), Visible = false })
	return I[1]
end

return build
