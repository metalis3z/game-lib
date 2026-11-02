-- Generated from ui/StarterPlayer/StarterPlayerScripts/HumanoidLabels/Health.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Health", { AlwaysOnTop = true, MaxDistance = math.huge, Size = UDim2.fromOffset(96, 24), StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0) })
		I[2] = new("TextLabel", I[1], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.75), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(10, 1), Text = "CloneTrooper1019", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextStrokeTransparency = 0, TextWrapped = true })
		I[3] = new("Frame", I[1], "RedBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.3) })
			I[4] = new("Frame", I[3], "GreenBar", { BackgroundColor3 = Color3.fromRGB(129, 197, 22), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
