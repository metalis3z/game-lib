-- Generated from ui/ReplicatedStorage/Assets/Survivors/Veeronica/Config/SkateUI_PRESET.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "SkateUI_PRESET", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.82, 0.067), Size = UDim2.fromScale(0.0698072, 0.0907093) })
		I[2] = new("ImageLabel", I[1], "ActiveIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://9874136659"), ImageTransparency = 0.41, Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[4] = new("ImageLabel", I[1], "InactiveIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://11198763659"), ImageTransparency = 0.41, Size = UDim2.fromScale(1, 1) })
		I[5] = new("ImageLabel", I[1], "Channel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://95780604256188"), ImageTransparency = 0.45, Position = UDim2.fromScale(0, 1.1272609), Size = UDim2.fromScale(1, 1), Visible = false })
			I[6] = new("TextLabel", I[5], "ModeName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.9935183), Size = UDim2.fromScale(1, 1), Text = "Ghost", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
	return I[1]
end

return build
