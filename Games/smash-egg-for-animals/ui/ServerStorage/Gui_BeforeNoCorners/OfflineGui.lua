-- Generated from ui/ServerStorage/Gui_BeforeNoCorners/OfflineGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "OfflineGui", { DisplayOrder = 30, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Dim", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(500, 310), ZIndex = 2 })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 91, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 52, 65)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
				I[5] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 5 })
				I[6] = new("ImageLabel", I[3], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
				I[7] = new("UIScale", I[3], "Fit")
				I[8] = new("TextLabel", I[3], "Welcome", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(16, 16), Size = UDim2.new(1, -32, 0, 56), Text = "Welcome back!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 4.5 })
					I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 225, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 167, 255)) }), Rotation = 90 })
				I[11] = new("TextLabel", I[3], "Away", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 82), Size = UDim2.new(1, -40, 0, 30), Text = "You were offline for 0s.", TextColor3 = Color3.fromRGB(190, 215, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
					I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 3 })
				I[13] = new("TextLabel", I[3], "Amount", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 126), Size = UDim2.new(1, -40, 0, 58), Text = "$0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 4.5 })
					I[15] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 255, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 200, 80)) }), Rotation = 90 })
				I[16] = new("TextButton", I[3], "Ok", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0.238, 20, 1, -100), Size = UDim2.new(0.5, -28, 0, 78), Text = "", ZIndex = 3 })
					I[17] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 20, 40)) }), Rotation = 90 })
					I[18] = new("UIStroke", I[16], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
					I[19] = new("ImageLabel", I[16], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 3 })
					I[20] = new("TextLabel", I[16], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.06, 0.18), Size = UDim2.fromScale(0.88, 0.64), Text = "OK!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
						I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 4 })
	return I[1]
end

return build
