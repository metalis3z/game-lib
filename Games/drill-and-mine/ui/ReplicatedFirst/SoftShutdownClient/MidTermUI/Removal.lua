-- Generated from ui/ReplicatedFirst/SoftShutdownClient/MidTermUI/Removal.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Removal", { DisplayOrder = 999999999, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[3] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0.9), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.91), Size = UDim2.fromScale(0.4, 0.05), Text = "Updating Servers", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextTransparency = 1, ZIndex = 3 })
		I[4] = new("TextLabel", I[1], "Instruction", { AnchorPoint = Vector2.new(0.5, 0.9), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9609808), Size = UDim2.fromScale(0.7, 0.05), Text = "You Will Be Teleported To A New Server Automatically", TextColor3 = Color3.fromRGB(204, 204, 204), TextSize = 16, TextTransparency = 1, ZIndex = 3 })
		I[5] = new("Frame", I[1], "Bar", { AnchorPoint = Vector2.new(0.5, 0.8), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.4, 0.1), ZIndex = 4 })
			I[6] = new("UIGridLayout", I[5], "Layout", { CellPadding = UDim2.fromScale(0.005, 0), CellSize = UDim2.fromScale(0.08, 0.55), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[7] = new("UIAspectRatioConstraint", I[5], "Aspect", { AspectRatio = 7, DominantAxis = Enum.DominantAxis.Height })
			I[8] = new("Frame", I[5], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.4599999, 0.2000002), Size = UDim2.fromOffset(2, 3) })
				I[9] = new("Frame", I[8], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(55, 135, 188), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.5) })
					I[10] = new("UICorner", I[9], "C", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[11] = new("BoolValue", I[8], "Status")
				I[12] = new("UIAspectRatioConstraint", I[8], "Aspect", { AspectRatio = 0.7, DominantAxis = Enum.DominantAxis.Height })
			I[13] = new("Frame", I[5], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.4599999, 0.2000002), Size = UDim2.fromOffset(2, 3) })
				I[14] = new("Frame", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(55, 135, 188), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.5) })
					I[15] = new("UICorner", I[14], "C", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[16] = new("BoolValue", I[13], "Status")
				I[17] = new("UIAspectRatioConstraint", I[13], "Aspect", { AspectRatio = 0.7, DominantAxis = Enum.DominantAxis.Height })
			I[18] = new("Frame", I[5], "Empty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 3, Position = UDim2.fromScale(0.4599999, 0.2000002), Size = UDim2.fromOffset(2, 3) })
				I[19] = new("Frame", I[18], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.5) })
					I[20] = new("UICorner", I[19], "C", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[21] = new("BoolValue", I[18], "Status")
				I[22] = new("UIAspectRatioConstraint", I[18], "Aspect", { AspectRatio = 0.7, DominantAxis = Enum.DominantAxis.Height })
	return I[1]
end

return build
