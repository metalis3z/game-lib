-- Generated from ui/ReplicatedStorage/MiscAssets/ListTemp.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ListTemp", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.25) })
		I[2] = new("ImageLabel", I[1], "Avatar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.2, 0.5), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[3] = new("TextLabel", I[1], "Ttl", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8, 0.5), RichText = true, Size = UDim2.fromScale(0.84, 0.43), Text = "CHUCKNORRISFISHERMAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 5 })
			I[4] = new("TextLabel", I[3], "Dark", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.03), RichText = true, Size = UDim2.fromScale(1, 1), Text = "CHUCKNORRISFISHERMAN", TextColor3 = Color3.fromRGB(153, 153, 153), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
	return I[1]
end

return build
