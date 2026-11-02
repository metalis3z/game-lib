-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/FlashbangGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FlashbangGui", { DisplayOrder = -1, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Rays1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(220, 215, 204), ImageContent = Content.fromUri("rbxassetid://14796588510"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2.6670001, 2.6670001), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[3] = new("ImageLabel", I[1], "Rays2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(220, 215, 204), ImageContent = Content.fromUri("rbxassetid://14796588510"), Position = UDim2.fromScale(0.5, 0.5), Rotation = 15, Size = UDim2.fromScale(2, 2), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[4] = new("ImageLabel", I[1], "Rays3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(220, 215, 204), ImageContent = Content.fromUri("rbxassetid://14796588510"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(3, 3), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[5] = new("Frame", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 2), ZIndex = 0 })
		I[6] = new("CanvasGroup", I[1], "Polaroid", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(221, 214, 200), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.575, 0.625), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[7] = new("Frame", I[6], "Picture", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(145, 138, 35), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(0.884, 0.748) })
				I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 188, 188)) }), Rotation = 90 })
				I[9] = new("ViewportFrame", I[7], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), LightDirection = Vector3.new(0, -1, 0), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[10] = new("WorldModel", I[9], "WorldModel")
			I[11] = new("TextLabel", I[6], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/IndieFlower.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.899), Size = UDim2.fromScale(0.9, 0.1), Text = "Look away next time!   :)", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
		I[12] = new("Frame", I[1], "Center", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[13] = new("Frame", I[12], "Skullbang", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[14] = new("ImageLabel", I[13], "Eye", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://135813200507249"), Position = UDim2.fromScale(0.375, 0.375), Size = UDim2.fromScale(0.15, 0.2) })
				I[15] = new("ImageLabel", I[13], "Eye", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://135813200507249"), Position = UDim2.fromScale(0.625, 0.375), Size = UDim2.fromScale(0.15, 0.2) })
	return I[1]
end

return build
