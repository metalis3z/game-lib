-- Generated from ui/ReplicatedStorage/MiscAssets/UnboxTemp.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "UnboxTemp", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(0.99, -12, 0.1, 0) })
		I[2] = new("TextLabel", I[1], "User", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.35), Text = "CHUCKNORRISFISHERMAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "Method", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(1, 0.32), Text = "FROM CRAFTING", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[4] = new("ImageLabel", I[1], "Avatar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[5] = new("ImageLabel", I[1], "RarityBack", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://1008360521"), Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, SliceCenter = Rect.new(30, 30, 300, 300) })
			I[6] = new("ViewportFrame", I[5], "VM", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 3 })
			I[7] = new("ImageLabel", I[5], "Img", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 4 })
		I[8] = new("NumberValue", I[1], "YVal")
	return I[1]
end

return build
