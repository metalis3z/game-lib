-- Generated from ui/StarterGui/SolitaryUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SolitaryUI", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.216, -1.5), Size = UDim2.fromScale(0.5667557, 0.5665489) })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://4833010476"), Position = UDim2.fromScale(0.3651354, 0.006237), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2685513, 0.4178794) })
				I[4] = new("UIGradient", I[3], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1997704, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[5] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.001649, 0.447079), Size = UDim2.fromScale(1, 0.15), Text = "You are now in Solitary.", TextColor3 = Color3.fromRGB(70, 70, 70), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("TextLabel", I[5], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -3), Size = UDim2.fromScale(1, 1), Text = "You are now in Solitary.", TextColor3 = Color3.fromRGB(245, 245, 245), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[7] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1853946, 0.5759771), Size = UDim2.fromScale(0.628033, 0.15), Text = "Please wait until the cooldown ends.", TextColor3 = Color3.fromRGB(70, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("TextLabel", I[7], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -3), Size = UDim2.fromScale(1, 1), Text = "Please wait until the cooldown ends.", TextColor3 = Color3.fromRGB(245, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[9] = new("TextLabel", I[2], "Cooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3644288, 0.8286236), Selectable = true, Size = UDim2.fromScale(0.2570083, 0.1447548), Text = "[TIMER]", TextColor3 = Color3.fromRGB(70, 70, 70), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("TextLabel", I[9], "Back", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -3), Selectable = true, Size = UDim2.fromScale(1, 1), Text = "[TIMER]", TextColor3 = Color3.fromRGB(245, 245, 245), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
