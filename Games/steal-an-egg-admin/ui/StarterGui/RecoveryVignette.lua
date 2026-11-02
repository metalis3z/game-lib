-- Generated from ui/StarterGui/RecoveryVignette.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RecoveryVignette", { ClipToDeviceSafeArea = false, DisplayOrder = -10, Enabled = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "5b4mAKbV5b4m" })
		I[2] = new("ImageLabel", I[1], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12754479702"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "0WKODuw40WKO" })
			I[3] = new("UIGradient", I[2], "Rainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 77, 77)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 166, 64)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 89)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(89, 255, 128)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(89, 191, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(166, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 77, 77)) }) }, { ["_lemonadeUniqueId"] = "fKRAHQlBfKRA" })
		I[4] = new("ImageLabel", I[1], "Vignette2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12754479702"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "vYDfVo3vvYDf" })
			I[5] = new("UIGradient", I[4], "Rainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 77, 77)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 166, 64)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 89)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(89, 255, 128)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(89, 191, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(166, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 77, 77)) }) }, { ["_lemonadeUniqueId"] = "ytZXum7FytZX" })
		I[6] = new("ImageLabel", I[1], "Vignette3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12754479702"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 3 }, { ["_lemonadeUniqueId"] = "70MxgziC70Mx" })
			I[7] = new("UIGradient", I[6], "Rainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 77, 77)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 166, 64)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 89)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(89, 255, 128)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(89, 191, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(166, 102, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 77, 77)) }) }, { ["_lemonadeUniqueId"] = "QrRr3RxBQrRr" })
	return I[1]
end

return build
