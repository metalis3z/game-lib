-- Generated from ui/StarterGui/Dead.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Dead", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3859497, 0.457606) })
			I[3] = new("TextLabel", I[2], "randomMsg", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.3651496), Size = UDim2.fromScale(0.9999999, 0.1552593), Text = "GO GET BACK!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[4] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 42 })
			I[5] = new("TextLabel", I[2], "respawnIn", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2741573, 0.6101513), Size = UDim2.fromScale(0.4494383, 0.1904652), Text = "You will respawn in 20 seconds.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 50 })
			I[7] = new("TextLabel", I[2], "dead", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2261615), Size = UDim2.fromScale(0.9999999, 0.2315806), Text = "YOU ARE DEAD!", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 63 })
		I[9] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.4376558 })
	return I[1]
end

return build
