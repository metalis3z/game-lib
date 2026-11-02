-- Generated from ui/ServerStorage/Scripts_BeforeInventoryIcons/InventoryHandler/SlotTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "SlotTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Text = "", Visible = false }, { ["MontFix"] = true }, { "UIButton" })
		I[2] = new("ViewportFrame", I[1], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(6, 36), Size = UDim2.new(1, -12, 1, -62), ZIndex = 2 })
		I[3] = new("TextLabel", I[1], "PetName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 0, 18), Text = "Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
		I[5] = new("TextLabel", I[1], "Rarity", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(6, 22), Size = UDim2.new(1, -12, 0, 13), Text = "Common", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
		I[7] = new("TextLabel", I[1], "Kg", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 1, -20), Size = UDim2.new(1, -8, 0, 15), Text = "1.00 kg", TextColor3 = Color3.fromRGB(200, 235, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
		I[9] = new("TextLabel", I[1], "Placed", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(52, 18), Text = "PLACED", TextColor3 = Color3.fromRGB(110, 255, 130), TextScaled = true, TextWrapped = true, Visible = false, ZIndex = 5 })
			I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 })
		I[11] = new("UIStroke", I[1], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
		I[12] = new("UIGradient", I[1], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 154, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(84, 88, 104)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
		I[13] = new("Frame", I[1], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3) })
		I[14] = new("Frame", I[1], "RaysClip", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
			I[15] = new("ImageLabel", I[14], "Rays", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://81911207340002"), ImageTransparency = 0.45, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1.7, 1.7), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[16] = new("Frame", I[1], "Strip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -24), Size = UDim2.new(1, 0, 0, 24), ZIndex = 3 })
		I[17] = new("Frame", I[1], "Inner", { BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = 3 })
			I[18] = new("UIStroke", I[17], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.5 })
	return I[1]
end

return build
