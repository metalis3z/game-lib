-- Generated from ui/ServerStorage/OldInventory/Inventory_Data/GetMore.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "GetMore", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(0.2, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6) })
			I[3] = new("ImageLabel", I[2], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 166, 47), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=335261161"), Position = UDim2.new(0.5, -39, 0, 0), Size = UDim2.fromOffset(80, 80) })
			I[4] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -30), Size = UDim2.new(1, 0, 0, 30), Text = "Get More", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7 })
			I[5] = new("TextButton", I[2], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14 })
	return I[1]
end

return build
