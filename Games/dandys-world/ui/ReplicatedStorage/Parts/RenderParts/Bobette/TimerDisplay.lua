-- Generated from ui/ReplicatedStorage/Parts/RenderParts/Bobette/TimerDisplay.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TimerDisplay", { AlwaysOnTop = true, MaxDistance = 50, Size = UDim2.fromScale(7, 2), StudsOffset = Vector3.new(0, 4, 0) })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Emerging: 5.3s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 4 })
		I[4] = new("ImageLabel", I[1], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://134335070990754"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
			I[5] = new("ImageLabel", I[4], "TimeLeft", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(68, 170, 109), ImageContent = Content.fromUri("rbxassetid://130707527101106"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[6] = new("UIGradient", I[5], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4962806, 0), NumberSequenceKeypoint.new(0.4994687, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["OffsetEnd"] = 0.45, ["OffsetStart"] = -0.44 })
			I[7] = new("ImageLabel", I[4], "SmoothTimeLeft", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://129237509459206"), ImageTransparency = 0.87, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
				I[8] = new("UIGradient", I[7], "UIGradient", { Offset = Vector2.new(0.45, 0), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4962806, 0), NumberSequenceKeypoint.new(0.4994687, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["OffsetEnd"] = 0.45, ["OffsetStart"] = -0.44 })
	return I[1]
end

return build
