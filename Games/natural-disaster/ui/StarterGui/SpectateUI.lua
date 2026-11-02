-- Generated from ui/StarterGui/SpectateUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpectateUI")
		I[2] = new("TextButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(85, 255, 0), FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5278638), Size = UDim2.fromScale(0.1476591, 0.0773994), Text = "Spectate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 27, TextStrokeTransparency = 0, TextWrapped = true })
			I[3] = new("UICorner", I[2], "UICorner")
		I[4] = new("UICorner", I[1], "UICorner")
		I[5] = new("Frame", I[1], "Bar", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderSizePixel = 5, Position = UDim2.new(-1, -100, 0.88, -50), Size = UDim2.fromOffset(200, 50) })
			I[6] = new("TextButton", I[5], "Previous", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(130, 203, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.25, 1), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48 })
			I[7] = new("TextButton", I[5], "Next", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(130, 203, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(-0.25, 1), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48 })
			I[8] = new("TextLabel", I[5], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.275, 0), Size = UDim2.fromScale(0.45, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[9] = new("Texture", I[8], "Texture", { TextureContent = Content.fromUri("131860027709009") })
				I[10] = new("UICorner", I[8], "UICorner")
			I[11] = new("UICorner", I[5], "UICorner")
	return I[1]
end

return build
