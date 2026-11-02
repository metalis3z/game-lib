-- Generated from ui/ReplicatedStorage/Assets/InfoOverlay/Blocks/Quality.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Quality", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 12), ZIndex = 11 })
		I[2] = new("Configuration", I[1], "settings")
			I[3] = new("NumberValue", I[2], "sort", { Value = 2 })
			I[4] = new("NumberValue", I[2], "maxSizeX", { Value = 300 })
			I[5] = new("NumberValue", I[2], "minSizeX", { Value = 25 })
		I[6] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 0), Size = UDim2.new(1, -20, 1, 0), Text = "Quality", TextColor3 = Color3.fromRGB(17, 192, 255), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
		I[7] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(17, 192, 255), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4010121377"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 20, 1, 0) })
	return I[1]
end

return build
