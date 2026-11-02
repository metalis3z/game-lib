-- Generated from ui/ReplicatedStorage/Death.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Death", { MaxDistance = math.huge, Size = UDim2.fromScale(8, 4), StudsOffset = Vector3.new(0, 3.2, 0) })
		I[2] = new("Frame", I[1], "Info", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, -60, 0.34, 0), Size = UDim2.new(1, 120, 0.18, 2) })
			I[3] = new("TextLabel", I[2], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Killed by SirMing", TextColor3 = Color3.fromRGB(0, 255, 255), TextScaled = true, TextSize = 42, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[4] = new("TextLabel", I[3], "Shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.fromScale(1, 1), Text = "Killed by SirMing", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 42, TextStrokeTransparency = 0.5, TextWrapped = true })
	return I[1]
end

return build
