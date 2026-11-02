-- Generated from ui/ReplicatedStorage/Controllers/ThanksgivingTurkeyController/HealthBar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "HealthBar", { Active = true, LightInfluence = 1, MaxDistance = 120, ResetOnSpawn = false, Size = UDim2.fromScale(8, 2), StudsOffsetWorldSpace = Vector3.new(0, 1.75, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "cJHMgK8qcJHM" })
		I[2] = new("Frame", I[1], "Progress", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.3579545) }, { ["_lemonadeUniqueId"] = "ugClkyoGugCl" })
			I[3] = new("Frame", I[2], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(90, 216, 62), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.5, 1) }, { ["_lemonadeUniqueId"] = "sTE2SU37sTE2" })
			I[4] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "25.234k/500k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "MrYNQ8oOMrYN" })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "CXcIvKbZCXcI" })
			I[6] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "1tfcJeye1tfc" })
		I[7] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.3209657), Size = UDim2.fromScale(1, 0.6421592), Text = "Gobblino Uniciclino", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "3FGWnFhr3FGW" })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "GcF4slXfGcF4" })
	return I[1]
end

return build
