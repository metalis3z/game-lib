-- Generated from ui/ServerStorage/Removed_DragonSystem/BurnGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BurnGui", { DisplayOrder = 2, ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(250, 56) }, nil, { "AutoScale" })
			I[3] = new("ImageLabel", I[2], "Flame", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://78970514864199"), Position = UDim2.fromOffset(30, 11), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(34, 34), ZIndex = 4 })
			I[4] = new("TextLabel", I[2], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(68, 31), Size = UDim2.new(1, -66, 0, 15), Text = "BURN POWER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 3 })
			I[6] = new("TextLabel", I[2], "Value", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(179, 24), Size = UDim2.new(1, -80, 0, 30), Text = "5%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 3.5 })
				I[8] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 245, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 40)) }), Rotation = 90 })
	return I[1]
end

return build
