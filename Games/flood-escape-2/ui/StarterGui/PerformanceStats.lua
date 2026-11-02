-- Generated from ui/StarterGui/PerformanceStats.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PerformanceStats", { DisplayOrder = 2147483643, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Info", { AnchorPoint = Vector2.new(0, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), RichText = true, Size = UDim2.fromScale(0.2, 0.1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
	return I[1]
end

return build
