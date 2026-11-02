-- Generated from ui/ServerScriptService/MainClient/BillboardGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "BillboardGui", { MaxDistance = math.huge, Size = UDim2.fromScale(2, 1), SizeOffset = Vector2.new(-0.5, 1.25) })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(2, 1) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.3), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextStrokeColor3 = Color3.fromRGB(108, 108, 108), TextStrokeTransparency = 0, TextWrapped = true })
				I[4] = new("UIGradient", I[3], "thing", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(162, 162, 162)), ColorSequenceKeypoint.new(0.5103806, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 85)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0.5) }) })
			I[5] = new("ImageLabel", I[2], "Verified", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://10679719925"), Position = UDim2.fromScale(0.13, 0.4), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.1, 0.4), Visible = false })
	return I[1]
end

return build
