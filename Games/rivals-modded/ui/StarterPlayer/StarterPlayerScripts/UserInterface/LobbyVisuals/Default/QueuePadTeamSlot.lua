-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/LobbyVisuals/Default/QueuePadTeamSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "QueuePadTeamSlot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
		I[2] = new("Frame", I[1], "Players", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.525), Size = UDim2.fromScale(0.75, 0.75), SizeConstraint = Enum.SizeConstraint.RelativeXX })
			I[3] = new("UIGridLayout", I[2], "Layout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(0.75, 0.75), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
		I[4] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.075), Size = UDim2.fromScale(0.9, 0.125), Text = "0/1", TextColor3 = Color3.fromRGB(114, 140, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
		I[5] = new("ImageLabel", I[1], "Logo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(185, 207, 255), ImageContent = Content.fromUri("rbxassetid://18226913133"), ImageTransparency = 0.9, Position = UDim2.fromScale(0.85, 0.075), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.075), ZIndex = 3 })
		I[6] = new("TextLabel", I[1], "Full", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.18), Size = UDim2.fromScale(0.9, 0.035), Text = "PAD FULL", TextColor3 = Color3.fromRGB(185, 207, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.77, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
	return I[1]
end

return build
