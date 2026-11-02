-- Generated from ui/ServerScriptService/VisualizeBulletScript/TextLabel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0689655, 0.8394737), RichText = true, Size = UDim2.fromScale(1, 0.135), Text = "     ELIMATED fakeflipsy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[2] = new("ImageLabel", I[1], "Keyboard", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3926305904"), ImageRectOffset = Vector2.new(324, 84), ImageRectSize = Vector2.new(36, 36), Interactable = false, Position = UDim2.fromScale(-0.103, 0.039), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 1), Visible = false })
		I[3] = new("ImageLabel", I[1], "Mobile", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3926307971"), ImageRectOffset = Vector2.new(644, 204), ImageRectSize = Vector2.new(36, 36), Interactable = false, Position = UDim2.fromScale(-0.103, 0.039), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 1), Visible = false })
		I[4] = new("ImageLabel", I[1], "Controller", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3639528354"), Interactable = false, Position = UDim2.fromScale(-0.1028777, 0.0393772), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 1), Visible = false })
	return I[1]
end

return build
