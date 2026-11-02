-- Generated from ui/ServerScriptService/WeaponSpawners/Spawns/Spawner.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Spawner", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "TextA", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7048055), Size = UDim2.fromScale(0.207481, 0.0572082), Text = "You have spawns left", TextColor3 = Color3.fromRGB(229, 229, 229), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "Text2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5004473, 0.7714096), Size = UDim2.fromScale(0.3872663, 0.0572082), Text = "! IMPORTANT !", TextColor3 = Color3.fromRGB(229, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[4] = new("TextLabel", I[1], "Text1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4986584, 0.8370757), Size = UDim2.fromScale(0.3872663, 0.0572082), Text = "This is a serious roleplaying game", TextColor3 = Color3.fromRGB(199, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[5] = new("TextLabel", I[1], "Text3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4986584, 0.8370757), Size = UDim2.fromScale(0.3872663, 0.0572082), Text = "This is a serious roleplaying game", TextColor3 = Color3.fromRGB(229, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 1, TextWrapped = true })
		I[6] = new("TextLabel", I[1], "Ting", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4986583, 0.6570738), Size = UDim2.fromScale(0.2499002, 0.0236886), Text = "TIME REMAINING UNTIL NEW SPAWN :", TextColor3 = Color3.fromRGB(138, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
