-- Generated from ui/ReplicatedStorage/Assets/Survivors/Civilian/Behavior/InMemoriam.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "InMemoriam", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 100000 })
		I[2] = new("ImageLabel", I[1], "Shedletsky", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114059916194146"), Position = UDim2.fromScale(0.0670575, 0.5), Size = UDim2.fromScale(0.3527359, 0.6695502) })
		I[3] = new("TextLabel", I[1], "Quote", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.495254, 0.4074394), Size = UDim2.fromOffset(616, 267), Text = "Died of Death.", TextColor3 = Color3.fromRGB(127, 127, 127), TextSize = 70, TextStrokeColor3 = Color3.fromRGB(43, 43, 43), TextXAlignment = Enum.TextXAlignment.Left })
		I[4] = new("TextLabel", I[1], "Username", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.495254, 0.3391004), Size = UDim2.fromOffset(616, 267), Text = "Player", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 100, TextStrokeColor3 = Color3.fromRGB(43, 43, 43), TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
