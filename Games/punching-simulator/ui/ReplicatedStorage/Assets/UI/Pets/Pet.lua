-- Generated from ui/ReplicatedStorage/Assets/UI/Pets/Pet.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Pet", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13810916591"), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.97, 1) }, nil, { "PopButton" })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
		I[3] = new("TextLabel", I[1], "Pet", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.05), Size = UDim2.fromScale(1, 0.325), Text = "Bat", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
			I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(19, 19, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
		I[5] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13808164747"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7399688, 0.7399688), ZIndex = 2 })
			I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
			I[7] = new("UIScale", I[5], "UIScale", { Scale = 1.25 })
		I[8] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[9] = new("ImageLabel", I[1], "Equip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13828408404"), Position = UDim2.fromScale(0.8, 0.2), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.35, 0.35), ZIndex = 2 })
			I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
			I[11] = new("UIScale", I[9], "UIScale", { Scale = 1.25 })
		I[12] = new("ImageLabel", I[1], "Delete", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13829668475"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7, 0.7), ZIndex = 2 })
			I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
			I[14] = new("UIScale", I[12], "UIScale", { Scale = 1.25 })
		I[15] = new("ImageLabel", I[1], "Trade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13828408404"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7, 0.7), Visible = false, ZIndex = 2 })
			I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
			I[17] = new("UIScale", I[15], "UIScale", { Scale = 1.25 })
	return I[1]
end

return build
