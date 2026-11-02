-- Generated from ui/ReplicatedStorage/Modules/EmoteModule/Back.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Back", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(54, 54, 54), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Size = UDim2.fromScale(0.333, 1) })
		I[2] = new("Frame", I[1], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(68, 68, 68), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(22, 22, 22), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6) })
			I[3] = new("ImageLabel", I[2], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2432693659"), Size = UDim2.fromScale(1, 1) })
			I[4] = new("TextButton", I[2], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[5] = new("ImageLabel", I[2], "BButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15026912025"), Size = UDim2.fromScale(1, 1) }, nil, { "ButtonIcon_ButtonB" })
				I[6] = new("ImageLabel", I[5], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png"), Size = UDim2.fromScale(1, 1), Visible = false })
					I[7] = new("ImageLabel", I[6], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png"), Size = UDim2.fromScale(1, 1) })
			I[8] = new("TextLabel", I[2], "Hotkey", { BackgroundColor3 = Color3.fromRGB(32, 32, 32), BackgroundTransparency = 0.2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-4, -4), Size = UDim2.fromOffset(30, 30), Text = "2", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextWrapped = true })
	return I[1]
end

return build
