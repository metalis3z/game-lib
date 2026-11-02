-- Generated from ui/StarterGui/HeartbeatMinigameUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HeartbeatMinigameUI", { DisplayOrder = -1, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.25 })
			I[4] = new("Frame", I[2], "Heartbeat", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 10, 25), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.3469513, 0.0867378) })
				I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 4 })
				I[6] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(0, 249, 0), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 }, nil, { "ScreenStroke" })
			I[7] = new("Folder", I[2], "Templates")
				I[8] = new("ImageLabel", I[7], "Beep", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 255, 39), ImageContent = Content.fromUri("rbxassetid://76871683546806"), Size = UDim2.fromScale(1, 1), Visible = false })
					I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
				I[10] = new("ImageLabel", I[7], "Line", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 255, 39), ImageContent = Content.fromUri("rbxassetid://127731561074520"), Size = UDim2.fromScale(1, 1), Visible = false })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
			I[12] = new("Frame", I[2], "ButtonsHolder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.3, 0.0573918) })
		I[13] = new("TextLabel", I[1], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2, 0.075), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[14] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 32 }, { ["Max"] = 16 })
			I[15] = new("UIStroke", I[13], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
	return I[1]
end

return build
