-- Generated from ui/ReplicatedStorage/Assets/Killers/Guest666/Config/OldBloodUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "OldBloodUI", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4861023, 0.8871508), Size = UDim2.fromScale(0.1722046, 0.1743017) })
		I[2] = new("ImageLabel", I[1], "Blood", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(45, 20, 20), ImageContent = Content.fromUri("rbxassetid://7104844885"), Position = UDim2.fromScale(0.4999999, 0.2799949), Size = UDim2.fromScale(0.25, 0.5599898) })
			I[3] = new("TextLabel", I[2], "Count", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.3083031), Size = UDim2.fromScale(0.9999999, 0.7768596), Text = "125", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[4] = new("ImageLabel", I[2], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://7104844885"), Position = UDim2.fromScale(0.5000001, 0.5082644), Size = UDim2.fromScale(0.8599999, 0.8834711), ZIndex = 2 })
				I[5] = new("UIGradient", I[4], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5692042, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.583045, Color3.fromRGB(58, 58, 58)), ColorSequenceKeypoint.new(1, Color3.fromRGB(58, 58, 58)) }), Rotation = -90 })
			I[6] = new("TextLabel", I[2], "Max", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.4014168), Size = UDim2.fromScale(0.9999999, 0.708177), Text = "100", TextColor3 = Color3.fromRGB(180, 180, 180), TextSize = 18, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
		I[7] = new("Frame", I[1], "Timer", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(45, 20, 20), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.605), Size = UDim2.fromScale(1, 0.1318471) })
			I[8] = new("UICorner", I[7], "UICorner")
			I[9] = new("TextLabel", I[7], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.635), Size = UDim2.fromScale(1, 1.2898549), Text = "25:00", TextColor3 = Color3.fromRGB(255, 179, 179), TextSize = 25, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[10] = new("Frame", I[7], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.01, 0.5), Size = UDim2.fromScale(0.98, 0.75) })
				I[11] = new("UICorner", I[10], "UICorner")
				I[12] = new("UIGradient", I[10], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5813149, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.583045, Color3.fromRGB(58, 58, 58)), ColorSequenceKeypoint.new(1, Color3.fromRGB(58, 58, 58)) }) })
	return I[1]
end

return build
