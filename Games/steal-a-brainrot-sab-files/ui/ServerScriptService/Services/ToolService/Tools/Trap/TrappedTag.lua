-- Generated from ui/ServerScriptService/Services/ToolService/Tools/Trap/TrappedTag.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TrappedTag", { Active = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = math.huge, Size = UDim2.fromScale(5, 1.2), StudsOffsetWorldSpace = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "LBNBQFPpLBNB" })
		I[2] = new("Frame", I[1], "MainFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "vvOPl9YgvvOP" })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(90, 255, 131), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.6), Text = "TRAPPED!", TextColor3 = Color3.fromRGB(255, 55, 55), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "05ZEitH705ZE" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "6rYel1Oq6rYe" })
			I[5] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(112, 112, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(1, 0.4), Text = "3s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "8KUrU1lj8KUr" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "GW08yg9rGW08" })
	return I[1]
end

return build
