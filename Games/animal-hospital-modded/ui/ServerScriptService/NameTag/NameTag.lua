-- Generated from ui/ServerScriptService/NameTag/NameTag.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "NameTag", { Active = true, AlwaysOnTop = true, LightInfluence = 1, MaxDistance = math.huge, Size = UDim2.fromScale(4, 1), StudsOffset = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "chlZnedFchlZ" })
		I[2] = new("TextLabel", I[1], "UpperText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Dummy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["_lemonadeUniqueId"] = "BNwOLlvpBNwO" })
		I[3] = new("TextLabel", I[1], "LowerText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.1), Size = UDim2.fromScale(1, 0.7), Text = "Guest", TextColor3 = Color3.fromRGB(218, 218, 218), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["_lemonadeUniqueId"] = "eede5uxReede" })
	return I[1]
end

return build
