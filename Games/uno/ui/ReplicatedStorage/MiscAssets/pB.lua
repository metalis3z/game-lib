-- Generated from ui/ReplicatedStorage/MiscAssets/pB.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "pB", { Active = true, ClipsDescendants = true, MaxDistance = 50, Size = UDim2.fromScale(12, 2), StudsOffset = Vector3.new(0, 2.5, 0) })
		I[2] = new("TextLabel", I[1], "Ttl", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.5), Text = "CHUCKNORRISFISHERMAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
			I[3] = new("TextLabel", I[2], "Dark", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 1), Text = "CHUCKNORRISFISHERMAN", TextColor3 = Color3.fromRGB(156, 156, 156), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
		I[4] = new("TextLabel", I[1], "LvlTxt", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 0.4), Text = "<font color=\"rgb(77,77,77)\">[I]</font> LEVEL 1", TextColor3 = Color3.fromRGB(255, 225, 70), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
			I[5] = new("TextLabel", I[4], "Dark", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), RichText = true, Size = UDim2.fromScale(1, 1), Text = "<font color=\"rgb(0,0,0)\">[I]</font> LEVEL 1", TextColor3 = Color3.fromRGB(171, 126, 37), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
