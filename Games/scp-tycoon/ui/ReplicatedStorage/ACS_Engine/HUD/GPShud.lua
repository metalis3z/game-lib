-- Generated from ui/ReplicatedStorage/ACS_Engine/HUD/GPShud.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GPShud", { DisplayOrder = 2 })
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://2319391988"), Position = UDim2.fromScale(0.02, 0.875), Size = UDim2.fromScale(0.1, 0.1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
			I[3] = new("ImageLabel", I[2], "FriendBlip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 85, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 85, 255), ImageContent = Content.fromUri("rbxassetid://3513778112"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.12, 0.12), SizeConstraint = Enum.SizeConstraint.RelativeXX, SliceScale = 0, Visible = false })
			I[4] = new("Folder", I[2], "Players")
			I[5] = new("ImageLabel", I[2], "FoeBlip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(170, 0, 0), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(170, 0, 0), ImageContent = Content.fromUri("rbxassetid://502107146"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.11, 0.11), SizeConstraint = Enum.SizeConstraint.RelativeXX, SliceScale = 0, Visible = false })
			I[6] = new("Frame", I[2], "RosaDosVentos", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[7] = new("TextLabel", I[6], "E", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.5), Rotation = 90, SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "E", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
				I[8] = new("TextLabel", I[6], "N", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "N", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
				I[9] = new("TextLabel", I[6], "S", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Rotation = 180, SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "S", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
				I[10] = new("TextLabel", I[6], "W", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Rotation = -90, SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "W", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[11] = new("ImageLabel", I[2], "MinhaVisao", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3513778112"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.15, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
		I[12] = new("Frame", I[1], "Squad", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.01, 0.85), Size = UDim2.fromScale(0.125, 0.125), SizeConstraint = Enum.SizeConstraint.RelativeXX })
			I[13] = new("TextLabel", I[12], "Esquadrao", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.05), Size = UDim2.fromScale(1, 0.15), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[14] = new("Frame", I[12], "Membros", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.95, 0), Size = UDim2.fromScale(1.25, 0.975) })
				I[15] = new("UIGridLayout", I[14], "UIGridLayout", { CellPadding = UDim2.fromScale(0, 0.025), CellSize = UDim2.fromScale(0.5, 0.15), StartCorner = Enum.StartCorner.BottomLeft, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[16] = new("TextLabel", I[12], "Exemplo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.15), Text = "00Scopion00", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, Visible = false })
	return I[1]
end

return build
