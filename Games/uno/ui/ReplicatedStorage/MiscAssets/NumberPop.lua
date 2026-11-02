-- Generated from ui/ReplicatedStorage/MiscAssets/NumberPop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "NumberPop", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, MaxDistance = 100, ResetOnSpawn = false, Size = UDim2.fromScale(7, 1.25), StudsOffset = Vector3.new(0, 2, 0) })
		I[2] = new("TextLabel", I[1], "Txt", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "+1", TextColor3 = Color3.fromRGB(255, 95, 95), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 2 })
			I[3] = new("TextLabel", I[2], "Dark", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.04), Size = UDim2.fromScale(1, 1), Text = "+1", TextColor3 = Color3.fromRGB(184, 68, 68), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
	return I[1]
end

return build
