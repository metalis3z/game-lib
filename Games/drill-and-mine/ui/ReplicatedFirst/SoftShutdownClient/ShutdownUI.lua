-- Generated from ui/ReplicatedFirst/SoftShutdownClient/ShutdownUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ShutdownUI", { DisplayOrder = 999999999, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0.9), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.91), Size = UDim2.fromScale(0.4, 0.05), Text = "Updating Servers", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextTransparency = 1, Visible = false, ZIndex = 3 })
		I[4] = new("TextLabel", I[1], "Instruction", { AnchorPoint = Vector2.new(0.5, 0.9), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9609808), Size = UDim2.fromScale(0.7, 0.05), Text = "You Will Be Teleported To A New Server Automatically", TextColor3 = Color3.fromRGB(204, 204, 204), TextSize = 16, TextTransparency = 1, Visible = false, ZIndex = 3 })
		I[5] = new("Frame", I[1], "Bar", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.83), Size = UDim2.fromScale(0.4, 0.1), Visible = false, ZIndex = 4 })
			I[6] = new("UIGridLayout", I[5], "Layout", { CellPadding = UDim2.fromScale(0.005, 0), CellSize = UDim2.fromScale(0.08, 0.55), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[7] = new("UIAspectRatioConstraint", I[5], "Aspect", { AspectRatio = 7, DominantAxis = Enum.DominantAxis.Height })
		I[8] = new("Frame", I[1], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.4599999, 0.2000002), Size = UDim2.fromOffset(2, 3) })
			I[9] = new("Frame", I[8], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.5) })
				I[10] = new("UICorner", I[9], "C", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[11] = new("BoolValue", I[8], "Status")
			I[12] = new("UIAspectRatioConstraint", I[8], "Aspect", { AspectRatio = 0.7, DominantAxis = Enum.DominantAxis.Height })
		I[13] = new("Frame", I[1], "Cube", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100) })
			I[14] = new("Frame", I[13], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.1) })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) })
			I[16] = new("UIAspectRatioConstraint", I[13], "Aspect", { AspectRatio = 0.979 })
		I[17] = new("Frame", I[1], "Cube", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100) })
			I[18] = new("Frame", I[17], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
		I[20] = new("Frame", I[1], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.4599999, 0.2000002), Size = UDim2.fromOffset(2, 3) })
			I[21] = new("Frame", I[20], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.5) })
				I[22] = new("UICorner", I[21], "C", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[23] = new("BoolValue", I[20], "Status")
			I[24] = new("UIAspectRatioConstraint", I[20], "Aspect", { AspectRatio = 0.7, DominantAxis = Enum.DominantAxis.Height })
		I[25] = new("Frame", I[1], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.4599999, 0.2000002), Size = UDim2.fromOffset(2, 3) })
			I[26] = new("Frame", I[25], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.5) })
				I[27] = new("UICorner", I[26], "C", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[28] = new("BoolValue", I[25], "Status")
			I[29] = new("UIAspectRatioConstraint", I[25], "Aspect", { AspectRatio = 0.7, DominantAxis = Enum.DominantAxis.Height })
		I[30] = new("Frame", I[1], "Cube", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100) })
			I[31] = new("Frame", I[30], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
		I[33] = new("Frame", I[1], "Transition", { BackgroundColor3 = Color3.fromRGB(17, 17, 17), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 99 })
		I[34] = new("Frame", I[1], "CubeHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.25, 1.25), ZIndex = 10 })
			I[35] = new("UIGridLayout", I[34], "UIGridLayout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(0.127, 0.25), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
