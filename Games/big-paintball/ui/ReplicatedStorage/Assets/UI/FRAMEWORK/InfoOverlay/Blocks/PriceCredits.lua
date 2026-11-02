-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/PriceCredits.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PriceCredits", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 6, Size = UDim2.new(1, 0, 0, 22), ZIndex = 11 })
		I[2] = new("Configuration", I[1], "settings")
			I[3] = new("NumberValue", I[2], "sort", { Value = 6 })
			I[4] = new("NumberValue", I[2], "maxSizeX", { Value = 300 })
			I[5] = new("NumberValue", I[2], "minSizeX", { Value = 25 })
		I[6] = new("TextLabel", I[1], "Price", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(25, 0), Size = UDim2.new(1, -25, 1, 0), Text = "100,000,000", TextColor3 = Color3.fromRGB(62, 255, 139), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
		I[7] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3701177967"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 20, 0.7, 0) })
	return I[1]
end

return build
