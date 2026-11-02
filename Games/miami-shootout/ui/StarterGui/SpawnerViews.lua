-- Generated from ui/StarterGui/SpawnerViews.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpawnerViews", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ScreenGui", I[1], "Spawner2", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5045992, 0.6974345), Size = UDim2.fromScale(0.2166794, 0.0572082), Text = "You have spawns left", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = -10, TextWrapped = true })
				I[4] = new("TextLabel", I[3], "LOL", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4867201, 2.9084916), Size = UDim2.fromScale(1.1248841, 1.1258875), Text = "This is serious roleplay game", TextColor3 = Color3.fromRGB(199, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = -10, TextWrapped = true })
				I[5] = new("TextLabel", I[3], "LOL", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5120558, 1.6463364), Size = UDim2.fromScale(0.9368805, 1.3984481), Text = "! IMPORTANT  !", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = -10, TextWrapped = true })
		I[6] = new("ScreenGui", I[1], "Spawner", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
			I[7] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5045992, 0.6974345), Size = UDim2.fromScale(0.2166794, 0.0572082), Text = "You have spawns left", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = -10, TextWrapped = true })
				I[8] = new("TextLabel", I[7], "LOL", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4867201, 2.9084916), Size = UDim2.fromScale(1.1248841, 1.1258875), Text = "This is serious roleplay game", TextColor3 = Color3.fromRGB(199, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = -10, TextWrapped = true })
				I[9] = new("TextLabel", I[7], "LOL", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5120558, 1.6463364), Size = UDim2.fromScale(0.9368805, 1.3984481), Text = "! IMPORTANT  !", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = -10, TextWrapped = true })
	return I[1]
end

return build
