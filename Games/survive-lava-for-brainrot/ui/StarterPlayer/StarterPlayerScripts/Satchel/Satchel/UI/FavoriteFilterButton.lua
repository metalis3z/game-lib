-- Generated from ui/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/UI/FavoriteFilterButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "FavoriteFilterButton", { BackgroundColor3 = Color3.fromRGB(25, 27, 29), BackgroundTransparency = 0.2, Position = UDim2.new(0.5921502, -230, 0.4379653, 5), Size = UDim2.fromOffset(30, 30) })
		I[2] = new("UICorner", I[1], "Corner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
		I[3] = new("UIStroke", I[1], "Border", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.8 })
		I[4] = new("TextLabel", I[1], "StarBorder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.7, 0.6), Text = "★", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextTransparency = 1 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.025 })
		I[6] = new("TextLabel", I[1], "StarFill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.7, 0.6), Text = "★", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, Visible = false })
		I[7] = new("Frame", I[1], "DiagonalLine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(2, 29), Visible = false, ZIndex = 3 })
		I[8] = new("TextButton", I[1], "Button", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "" })
	return I[1]
end

return build
