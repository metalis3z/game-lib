-- Generated from ui/ReplicatedStorage/Assets/UI/PromptThemes/Item.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Item", { Active = true, AlwaysOnTop = true, Enabled = false, MaxDistance = math.huge, Size = UDim2.fromOffset(250, 150) }, { ["OverridePositions"] = true, ["Theme"] = "" })
		I[2] = new("ImageLabel", I[1], "PromptFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18733946703"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.125, 1.125) })
			I[3] = new("TextLabel", I[2], "ObjectText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(249, 248, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.2, 6), Size = UDim2.fromScale(1, 1), Text = "ObjectName", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.5 })
			I[4] = new("TextLabel", I[2], "ActionText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.2, -12), Size = UDim2.fromScale(1, 1), Text = "Interact", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextStrokeTransparency = 0.5 })
			I[5] = new("Frame", I[2], "InputFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.5), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[6] = new("Frame", I[5], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(169, 44, 171), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[7] = new("ImageLabel", I[6], "ButtonImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18733960603"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -30, 1, -30) })
					I[8] = new("ImageLabel", I[6], "ButtonTextImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/shift.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -48, 1, -48), Visible = false, ZIndex = 2 })
					I[9] = new("ImageLabel", I[6], "ButtonFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -24, 1, -24), ZIndex = 2 })
						I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
					I[11] = new("TextLabel", I[6], "ButtonText", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -1), Size = UDim2.fromScale(1, 1), Text = "E", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 40, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
						I[12] = new("UIPadding", I[11], "UIPadding", { PaddingTop = UDim.new(0, 5) })
					I[13] = new("Frame", I[6], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -34, 1, -30), ZIndex = 2 })
						I[14] = new("Frame", I[13], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(252, 250, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.5, 0), ZIndex = 5 })
						I[15] = new("NumberValue", I[13], "Progress")
					I[16] = new("UIScale", I[6], "UIScale")
		I[17] = new("TextButton", I[1], "TextButton", { BackgroundTransparency = 1, Selectable = false, Size = UDim2.fromScale(1, 1), TextTransparency = 1 })
	return I[1]
end

return build
