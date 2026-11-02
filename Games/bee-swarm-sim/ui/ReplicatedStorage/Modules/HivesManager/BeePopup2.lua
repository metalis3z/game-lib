-- Generated from ui/ReplicatedStorage/Modules/HivesManager/BeePopup2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "BeePopup2", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(18, 18, 18), Position = UDim2.fromScale(0.5, 0.5), Rotation = 10, Size = UDim2.fromScale(0.2, 0.2) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[3] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.1626298, Color3.fromRGB(213, 213, 213)), ColorSequenceKeypoint.new(0.3252595, Color3.fromRGB(240, 240, 240)), ColorSequenceKeypoint.new(0.3356402, Color3.fromRGB(206, 206, 206)), ColorSequenceKeypoint.new(0.5449827, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5605537, Color3.fromRGB(213, 213, 213)), ColorSequenceKeypoint.new(0.7750865, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7854671, Color3.fromRGB(213, 213, 213)), ColorSequenceKeypoint.new(0.9480969, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9567474, Color3.fromRGB(240, 240, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Offset = Vector2.new(0, -0.05), Rotation = 85 })
		I[4] = new("ImageButton", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(36, 36, 36), Position = UDim2.fromScale(0.5, 0.5), Rotation = 350, Size = UDim2.fromScale(1, 1) })
			I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[6] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.26, 0.5), Size = UDim2.fromScale(0.4592007, 0.8844496) })
				I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 226, 226)), ColorSequenceKeypoint.new(0.1107266, Color3.fromRGB(226, 226, 226)), ColorSequenceKeypoint.new(0.1349481, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.2854671, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.3079585, Color3.fromRGB(226, 226, 226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 226, 226)) }), Offset = Vector2.new(-0.5, 0), Rotation = 45 })
				I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
				I[9] = new("ImageLabel", I[6], "Bee", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[10] = new("TextLabel", I[4], "QName", { BackgroundColor3 = Color3.fromRGB(124, 124, 124), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5085149, 0.0556365), Size = UDim2.fromScale(0.4610142, 0.1650021), Text = "Worker Bee", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.35, 0), BottomRightRadius = UDim.new(0.35, 0), TopLeftRadius = UDim.new(0.35, 0), TopRightRadius = UDim.new(0.35, 0) })
			I[12] = new("TextLabel", I[4], "Rank", { BackgroundColor3 = Color3.fromRGB(108, 88, 75), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0166667, 0.8082609), Size = UDim2.fromScale(0.4459558, 0.1596126), Text = "Common", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[14] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 226, 226)), ColorSequenceKeypoint.new(0.5259516, Color3.fromRGB(226, 226, 226)), ColorSequenceKeypoint.new(0.5415225, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 226, 226)) }), Rotation = 255 })
				I[15] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(20, 20, 20), Thickness = 3, Transparency = 0.7 })
				I[16] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(20, 20, 20), Thickness = 2.5 })
			I[17] = new("TextLabel", I[4], "Desc", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5085149, 0.2966005), Size = UDim2.fromScale(0.4610142, 0.4019499), Text = "An ordinary unremarkable bee, but you'll never know how useful it is", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0.35, 0), BottomRightRadius = UDim.new(0.35, 0), TopLeftRadius = UDim.new(0.35, 0), TopRightRadius = UDim.new(0.35, 0) })
			I[19] = new("TextLabel", I[4], "Token1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.95, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5085149, 0.7745121), Size = UDim2.fromScale(0.0860142, 0.1650021), Text = "★", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[21] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.1626298, Color3.fromRGB(213, 213, 213)), ColorSequenceKeypoint.new(0.3252595, Color3.fromRGB(240, 240, 240)), ColorSequenceKeypoint.new(0.3356402, Color3.fromRGB(206, 206, 206)), ColorSequenceKeypoint.new(0.5449827, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5605537, Color3.fromRGB(213, 213, 213)), ColorSequenceKeypoint.new(0.7750865, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7854671, Color3.fromRGB(213, 213, 213)), ColorSequenceKeypoint.new(0.9480969, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9567474, Color3.fromRGB(240, 240, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Offset = Vector2.new(0, -0.05), Rotation = 85 })
	return I[1]
end

return build
