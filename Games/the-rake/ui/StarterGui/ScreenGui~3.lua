-- Generated from ui/StarterGui/ScreenGui~3.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ScreenGui")
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/RomanAntique.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5146363, -0.0204931), Size = UDim2.fromScale(0.2630081, 0.0528292), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 7.2952957 })
				I[5] = new("ImageLabel", I[3], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.3, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5999103989"), Position = UDim2.new(-0.277897, 35, 0.0548241, 0), Size = UDim2.fromScale(0.1395121, 0.9451759) })
					I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.0768176 })
	return I[1]
end

return build
