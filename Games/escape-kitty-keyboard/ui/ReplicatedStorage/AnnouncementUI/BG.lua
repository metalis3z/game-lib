-- Generated from ui/ReplicatedStorage/AnnouncementUI/BG.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "BG", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(162, 162, 162), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=55700616&w=420&h=420"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(0.6, 0.043) })
		I[2] = new("TextLabel", I[1], "Text", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(162, 162, 162), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), RichText = true, Size = UDim2.fromScale(0.75, 1), TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.3 })
	return I[1]
end

return build
