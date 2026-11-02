-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/HotbarSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "HotbarSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.fromScale(1, 1) })
		I[2] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://13188153054"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), ZIndex = -1 })
		I[3] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13197584241"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(3, 3), SliceCenter = Rect.new(15, 15, 16, 16), ZIndex = 0 })
		I[4] = new("ImageButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Interactable = false, Size = UDim2.fromScale(1, 1), ZIndex = 999 })
		I[5] = new("Frame", I[1], "Inputs", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, nil, { "UIInputFrame" })
			I[6] = new("Frame", I[5], "MouseKeyboard", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[7] = new("Frame", I[6], "Keybind", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 1), Size = UDim2.fromScale(0.4, 0.4), Visible = false }, nil, { "UIKeybindContainer" })
			I[8] = new("Frame", I[5], "Touch", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
			I[9] = new("Frame", I[5], "Gamepad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
		I[10] = new("Frame", I[1], "Cooldowns", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4, 0), Size = UDim2.fromScale(0.8, 0.2) })
			I[11] = new("UIListLayout", I[10], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
		I[12] = new("Frame", I[1], "Ammo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
			I[13] = new("ImageLabel", I[12], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16539130428"), Position = UDim2.fromScale(0.925, 0.8), Size = UDim2.fromScale(0.15, 0.15) })
			I[14] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.75, 0.76), RichText = true, Size = UDim2.fromScale(1.8, 0.25), Text = "20<font size=\"8\"> 90</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
				I[15] = new("UIStroke", I[14], "UIStroke", { Transparency = 0.875 })
	return I[1]
end

return build
