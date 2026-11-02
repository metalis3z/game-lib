-- Generated from ui/ServerStorage/EventScript_Halloween2021/TierTest.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "TierTest", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromOffset(120, 150) })
		I[2] = new("Frame", I[1], "Claim", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(57, 177, 1), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(77, 230, 0), BorderSizePixel = 3, Position = UDim2.new(0.5, 0, 0, 5), Size = UDim2.new(1, -10, 0, 25), Visible = false })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Claim", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextStrokeTransparency = 0.3 })
		I[4] = new("Frame", I[1], "Locked", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
		I[5] = new("Frame", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(71, 71, 71), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(113, 113, 113), BorderSizePixel = 3, Position = UDim2.new(0.5, 0, 0, 5), Size = UDim2.new(1, -10, 0, 25) })
			I[6] = new("TextLabel", I[5], "TierNumber", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24 })
		I[7] = new("Frame", I[1], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(97, 97, 97), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(140, 140, 140), BorderSizePixel = 3, Position = UDim2.new(0.5, 0, 0.5, 17), Size = UDim2.new(1, -10, 1, -44) })
			I[8] = new("TextLabel", I[7], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Size = UDim2.new(1, -5, 0, 20), Text = "Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
			I[9] = new("TextLabel", I[7], "Rarity", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Size = UDim2.new(1, -5, 0, 20), Text = "Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
			I[10] = new("TextLabel", I[7], "Event", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Size = UDim2.new(1, -5, 0, 20), Text = "Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
			I[11] = new("TextLabel", I[7], "ItemType", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Size = UDim2.new(1, -5, 0, 20), Text = "Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Right })
			I[12] = new("TextLabel", I[7], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Sinister P.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextStrokeTransparency = 0.3, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[13] = new("TextLabel", I[7], "Year", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Size = UDim2.new(1, -5, 0, 20), Text = "Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.3, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
			I[14] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://314773056"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
	return I[1]
end

return build
