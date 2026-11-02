-- Generated from ui/ServerStorage/e/Radios.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Radios", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(1, 1) })
		I[2] = new("Frame", I[1], "Items", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, -150), Style = Enum.FrameStyle.DropShadow })
			I[3] = new("Frame", I[2], "ScrollBar", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.new(1, -6, 0, 0), Size = UDim2.new(0, 3, 1, 0) })
			I[4] = new("ScrollingFrame", I[2], "ScrollFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScrollBarThickness = 10, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[5] = new("Frame", I[4], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, -11, 1, 0) })
		I[6] = new("Frame", I[1], "Equipped", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -155), Size = UDim2.new(1, 0, 0, 155), Style = Enum.FrameStyle.DropShadow })
			I[7] = new("ImageButton", I[6], "Slot1", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, 7, 0.5, -60), Size = UDim2.fromOffset(120, 120) })
				I[8] = new("TextLabel", I[7], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -30), Size = UDim2.new(1, 0, 0, 30), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24 })
		I[9] = new("Frame", I[1], "BuyRadio", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[10] = new("TextLabel", I[9], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 0.5, -50), Size = UDim2.new(1, 0, 0, 50), Text = "You don't have the radio gamepass!", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, ZIndex = 3 })
			I[11] = new("TextButton", I[9], "Get", { BackgroundColor3 = Color3.fromRGB(18, 182, 0), BorderColor3 = Color3.fromRGB(12, 121, 0), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -90, 0.5, 0), Size = UDim2.fromOffset(180, 40), Text = "Get it Now!", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextStrokeTransparency = 0.7, ZIndex = 3 })
	return I[1]
end

return build
