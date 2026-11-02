-- Generated from ui/ServerStorage/Assets/Models/Killstreak/KillstreakGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "KillstreakGui", { Active = true, MaxDistance = math.huge, Size = UDim2.fromScale(1, 1), StudsOffset = Vector3.new(0, 4, 0) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 1.9, 2), Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Skull1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://18740706320"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 4, 1, 4), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[4] = new("ImageLabel", I[3], "Inside", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18740706320"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -4, 1, -4), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[5] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1, 0.5), Size = UDim2.fromScale(1.5, 1.25), Text = "10", TextColor3 = Color3.fromRGB(172, 1, 7), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
				I[6] = new("ImageLabel", I[5], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 3, 7), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7274452334"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.1, 0.5), Size = UDim2.fromScale(3, 3), ZIndex = 0 })
	return I[1]
end

return build
