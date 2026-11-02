-- Generated from ui/StarterGui/SpecialEvent.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpecialEvent", { DisplayOrder = 10, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, -0.5), Size = UDim2.fromScale(0.5, 0.305), ZIndex = 0 })
			I[3] = new("TextLabel", I[2], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6033143), RichText = true, Size = UDim2.fromScale(0.95, 0.6), Text = "<stroke color= \"rgb(0, 0, 0)\" joins=\"round\" thickness=\"2\" transparency=\"0\"><font color= \"rgb(255, 255, 255)\"><font color= \"rgb(0, 255, 0)\">Deathmatch!</font>: Killing people gives you some of their gems for 5 minutes.</font></stroke>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 4 })
			I[5] = new("Frame", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), Position = UDim2.fromScale(0.5, 0.0870125), Size = UDim2.fromScale(1.0000001, 0.1740247) })
				I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
			I[8] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.1011456), Size = UDim2.fromScale(0.8, 0.1103407), Text = "SPECIAL EVENT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2 })
				I[10] = new("TextLabel", I[8], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "SPECIAL EVENT", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 2 })
			I[12] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 })
			I[13] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.6127684 })
			I[14] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14262761173"), ImageTransparency = 0.95, Position = UDim2.fromScale(0.5, 0.575), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 1), ZIndex = 0 })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
	return I[1]
end

return build
