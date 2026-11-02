-- Generated from ui/ServerStorage/OldSalvage.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "OldSalvage", { BackgroundColor3 = Color3.fromRGB(17, 17, 17), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(0.5, -375, 0.5, -125), Size = UDim2.fromOffset(750, 250), Visible = false })
		I[2] = new("Frame", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 1), Style = Enum.FrameStyle.DropShadow })
			I[3] = new("Frame", I[2], "Item2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(0.333, 1) })
				I[4] = new("Frame", I[3], "Container", { BackgroundColor3 = Color3.fromRGB(22, 22, 22), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 3, ClipsDescendants = true, Position = UDim2.fromOffset(9, 9), Size = UDim2.new(1, -18, 1, -18) })
					I[5] = new("Frame", I[4], "Slider", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BorderSizePixel = 0, Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1) })
						I[6] = new("ImageLabel", I[5], "Logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(150, 150, 150), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=319379487"), ImageTransparency = 0.7, Position = UDim2.fromOffset(-25, -25), Size = UDim2.new(1, 50, 1, 50) })
			I[7] = new("Frame", I[2], "Item1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.333, 0), Size = UDim2.fromScale(0.333, 1) })
				I[8] = new("Frame", I[7], "Container", { BackgroundColor3 = Color3.fromRGB(22, 22, 22), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 3, ClipsDescendants = true, Position = UDim2.fromOffset(9, 9), Size = UDim2.new(1, -18, 1, -18) })
					I[9] = new("Frame", I[8], "Slider", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BorderSizePixel = 0, Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1) })
						I[10] = new("ImageLabel", I[9], "Logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(150, 150, 150), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=319379487"), ImageTransparency = 0.7, Position = UDim2.fromOffset(-25, -25), Size = UDim2.new(1, 50, 1, 50) })
			I[11] = new("Frame", I[2], "Item3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.66, 0), Size = UDim2.fromScale(0.333, 1) })
				I[12] = new("Frame", I[11], "Container", { BackgroundColor3 = Color3.fromRGB(22, 22, 22), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 3, ClipsDescendants = true, Position = UDim2.fromOffset(9, 9), Size = UDim2.new(1, -18, 1, -18) })
					I[13] = new("Frame", I[12], "Slider", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BorderSizePixel = 0, Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1) })
						I[14] = new("ImageLabel", I[13], "Logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(150, 150, 150), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=319379487"), ImageTransparency = 0.7, Position = UDim2.fromOffset(-25, -25), Size = UDim2.new(1, 50, 1, 50) })
	return I[1]
end

return build
