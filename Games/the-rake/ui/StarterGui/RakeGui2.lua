-- Generated from ui/StarterGui/RakeGui2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RakeGui2")
		I[2] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/RomanAntique.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2651391), Size = UDim2.fromOffset(236, 68), Text = "Rake has died", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 3.4705882 })
		I[4] = new("TextLabel", I[1], "AwardLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/RomanAntique.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4996355, 0.3584288), Size = UDim2.fromOffset(333, 96), Text = "You earned 100 Points", TextColor3 = Color3.fromRGB(255, 255, 0), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 3.46875 })
		I[6] = new("Sound", I[1], "AwardBeat", { PlaybackSpeed = 1.03, RollOffMaxDistance = 80, Volume = 1 })
		I[7] = new("Sound", I[1], "AwardBeat2", { RollOffMaxDistance = 80, Volume = 1 })
		I[8] = new("Sound", I[1], "AwardBeat3", { PlaybackSpeed = 0.92, RollOffMaxDistance = 80, Volume = 1 })
	return I[1]
end

return build
