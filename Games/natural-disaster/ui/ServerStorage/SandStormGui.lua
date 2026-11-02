-- Generated from ui/ServerStorage/SandStormGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SandStormGui")
		I[2] = new("Frame", I[1], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Flakes", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136683669"), Size = UDim2.fromScale(1.33, 1.5), Visible = false, ZIndex = 2 })
			I[4] = new("ImageLabel", I[2], "Flakes2", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136683669"), Position = UDim2.fromScale(-0.0083398, -0.1555463), Size = UDim2.fromScale(0.6666, 0.75), Visible = false })
				I[5] = new("ImageLabel", I[4], "FlakesRight", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136683669"), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1) })
				I[6] = new("ImageLabel", I[4], "FlakesTopRight", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136683669"), Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(1, 1) })
				I[7] = new("ImageLabel", I[4], "FlakesTop", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136683669"), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1) })
			I[8] = new("ImageLabel", I[2], "DeepFrost", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=93077714"), Position = UDim2.fromOffset(-2, -2), Size = UDim2.new(1, 4, 1, 4), Visible = false })
			I[9] = new("ImageLabel", I[2], "FrostLight", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136684400"), Position = UDim2.fromOffset(-2, -2), Size = UDim2.new(1, 4, 1, 4), Visible = false })
			I[10] = new("ImageLabel", I[2], "Frost", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136684400"), Position = UDim2.fromOffset(-2, -2), Size = UDim2.new(1, 4, 1, 4), Visible = false })
			I[11] = new("ImageLabel", I[2], "FrostLight2", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/Asset?ID=136684400"), Position = UDim2.fromOffset(-2, -2), Size = UDim2.new(1, 4, 1, 4), Visible = false })
			I[12] = new("Frame", I[2], "ExposureFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(0.5, -130, 1, -100), Size = UDim2.fromOffset(240, 40), Style = Enum.FrameStyle.RobloxRound, Visible = false })
				I[13] = new("Frame", I[12], "Bar", { BackgroundColor3 = Color3.fromRGB(125, 195, 245), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1) })
				I[14] = new("TextLabel", I[12], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Exposure", TextColor3 = Color3.fromRGB(6, 3, 44), TextSize = 18, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
