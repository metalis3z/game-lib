-- Generated from ui/ReplicatedStorage/Characters/Survivor/Medic/Normal/Assets/bar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "bar", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Healing", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[3] = new("Frame", I[2], "Holder", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.9306372), Size = UDim2.fromScale(0.1498947, 0.0841498) })
				I[4] = new("TextLabel", I[3], "Name", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365769", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5556188, 0.1133732), Size = UDim2.fromScale(0.8578651, 0.2335304), Text = "Healing...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139024622029957"), Position = UDim2.fromScale(0.3839672, 0.2297852), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0830962, 0.3725287), ZIndex = 3 })
					I[6] = new("UIGradient", I[5], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.645619, 0.0315789), NumberSequenceKeypoint.new(1, 1) }) })
				I[7] = new("CanvasGroup", I[3], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(61, 61, 61), BackgroundTransparency = 0.45, Position = UDim2.fromScale(0.5000001, 0.4896929), Size = UDim2.fromScale(0.7428572, 0.1014493) })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[9] = new("UIGradient", I[7], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.273196, 0.684211), NumberSequenceKeypoint.new(0.601804, 0.310526), NumberSequenceKeypoint.new(0.690722, 0), NumberSequenceKeypoint.new(0.791237, 0), NumberSequenceKeypoint.new(0.92268, 0.257895), NumberSequenceKeypoint.new(1, 1) }) })
					I[10] = new("Frame", I[7], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[11] = new("UIGradient", I[10], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) }) })
				I[12] = new("ImageLabel", I[3], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://6150493168"), ImageTransparency = 0.83, Position = UDim2.fromScale(0.5000001, 0.4896931), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.8433447, 0.4492753), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.4, ZIndex = -10 })
				I[13] = new("UISizeConstraint", I[3], "UISizeConstraint", { MinSize = Vector2.new(180, 180) })
				I[14] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 3.043 })
			I[15] = new("ImageLabel", I[2], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://537309753"), Position = UDim2.fromScale(0.5, 0.9305083), Size = UDim2.fromScale(0.3, 0.201065), TileSize = UDim2.fromOffset(350, 350), ZIndex = -10 })
				I[16] = new("UIGradient", I[15], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.206452, 0.0857143), NumberSequenceKeypoint.new(0.496774, 0), NumberSequenceKeypoint.new(0.806452, 0.0971429), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
