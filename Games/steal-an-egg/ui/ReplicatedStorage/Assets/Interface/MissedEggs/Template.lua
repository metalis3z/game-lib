-- Generated from ui/ReplicatedStorage/Assets/Interface/MissedEggs/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://81389322135382"), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 3 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[4] = new("UIStroke", I[1], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 })
		I[5] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[6] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 138, 151)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 89, 102)) }), Rotation = 90 })
		I[7] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.95), RichText = true, Size = UDim2.fromScale(0.85, 0.25), Text = "15s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 5 })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 1.5 })
	return I[1]
end

return build
