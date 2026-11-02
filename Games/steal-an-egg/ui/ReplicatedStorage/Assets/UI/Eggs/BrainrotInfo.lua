-- Generated from ui/ReplicatedStorage/Assets/UI/Eggs/BrainrotInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BrainrotInfo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[3] = new("Frame", I[1], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[4] = new("TextLabel", I[1], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
			I[5] = new("UIStroke", I[4], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
		I[6] = new("Frame", I[1], "RarityHolder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[7] = new("TextLabel", I[6], "RarityLabel", { AnchorPoint = Vector2.new(0.6, 0.6), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0.6), Size = UDim2.fromScale(0.8, 0.8), Text = "Mythic", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[8] = new("TextLabel", I[7], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Mythic", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[9] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5 })
			I[10] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[11] = new("UIStroke", I[6], "UIStroke", { Enabled = false, Thickness = 2.5999999 })
	return I[1]
end

return build
