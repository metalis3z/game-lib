-- Generated from ui/StarterGui/KillFeed.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "KillFeed", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Brightness", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://504996715"), ImageTransparency = 1, Position = UDim2.fromScale(0.4903033, 0.7985783), Size = UDim2.fromScale(0.3716559, 0.0456324) })
		I[3] = new("TextLabel", I[1], "Notification", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4771053, 0.7981731), RichText = true, Size = UDim2.fromScale(0.2934277, 0.0214484), Text = "ELIMINATED              /Player name/", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 1, TextStrokeColor3 = Color3.fromRGB(33, 33, 33), TextTransparency = 1, TextWrapped = true, ZIndex = 2 })
		I[4] = new("ImageLabel", I[1], "skull", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://7383316325"), ImageTransparency = 1, Position = UDim2.fromScale(0.47626, 0.79809), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0336012, 0.042292), ZIndex = 45 })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 1.1684536 })
		I[6] = new("Sound", I[1], "KillSound", { Volume = 0.818 })
	return I[1]
end

return build
