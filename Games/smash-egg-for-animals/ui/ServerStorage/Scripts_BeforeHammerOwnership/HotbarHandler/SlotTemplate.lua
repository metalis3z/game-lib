-- Generated from ui/ServerStorage/Scripts_BeforeHammerOwnership/HotbarHandler/SlotTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "SlotTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromOffset(62, 62), Text = "", Visible = false }, { ["MontFix"] = true })
		I[2] = new("ViewportFrame", I[1], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(5, 5), Size = UDim2.new(1, -10, 1, -10) })
			I[3] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 232, 244)) }), Rotation = 90 })
		I[4] = new("TextLabel", I[1], "Key", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 3), Size = UDim2.fromOffset(16, 16), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2 })
		I[6] = new("TextLabel", I[1], "Kg", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 3, 1, -16), Size = UDim2.new(1, -6, 0, 13), Text = "", TextColor3 = Color3.fromRGB(200, 235, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2 })
		I[8] = new("TextLabel", I[1], "Count", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -30, 0, 3), Size = UDim2.fromOffset(26, 16), Text = "", TextColor3 = Color3.fromRGB(255, 240, 150), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
			I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2 })
		I[10] = new("UIStroke", I[1], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(10, 10, 12), Thickness = 3.5 })
		I[11] = new("UIGradient", I[1], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(74, 74, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22)) }), Rotation = 90 })
		I[12] = new("UIScale", I[1], "UIScale")
	return I[1]
end

return build
