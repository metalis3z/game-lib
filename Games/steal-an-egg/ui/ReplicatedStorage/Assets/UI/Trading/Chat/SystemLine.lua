-- Generated from ui/ReplicatedStorage/Assets/UI/Trading/Chat/SystemLine.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "SystemLine", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(0.9, 0, 0, 40), ZIndex = 3000 }, { ["Template"] = true })
		I[2] = new("Frame", I[1], "RemoveMessage", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 88, 88), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3000 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[4] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.975, 0.8), Text = "They removed 1x Huge Cat from the trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 3000 })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 42 })
		I[6] = new("Frame", I[1], "AddMessage", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(88, 255, 88), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3000 })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[8] = new("TextLabel", I[6], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.975, 0.8), Text = "They added 1x Huge Cat from the trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 3000 })
				I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 42 })
	return I[1]
end

return build
