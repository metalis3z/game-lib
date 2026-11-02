-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/UIController/RebirthReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "RebirthReward", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://84003909635619"), Position = UDim2.fromScale(0.4415358, 0.1537935), Size = UDim2.fromScale(1, 1) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88170079230287"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7605634, 0.7777778), Visible = false })
		I[3] = new("TextLabel", I[1], "NameText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.1267606, 0.6388889), Size = UDim2.fromScale(1.2535211, 0.6944444), Text = "1.2x Multiplier", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
		I[5] = new("ViewportFrame", I[1], "ViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[6] = new("WorldModel", I[5], "WorldModel")
		I[7] = new("TextLabel", I[1], "RarityText", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.8, 0.3), Text = "Common", TextColor3 = Color3.fromRGB(4, 212, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
