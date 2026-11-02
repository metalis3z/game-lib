-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/TeammateLabel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TeammateLabel", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, ExtentsOffsetWorldSpace = Vector3.new(0, 3.25, 0), LightInfluence = 1, MaxDistance = 500, ResetOnSpawn = false, Size = UDim2.new(15, 100, 15, 100), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Health", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(75, 127, 50), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.54), Size = UDim2.fromScale(0.2, 0.01), ZIndex = 10 })
			I[3] = new("Frame", I[2], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(100, 255, 50), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.75, 1) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[5] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(100, 255, 50), Thickness = 2 })
			I[6] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[7] = new("UIStroke", I[2], "UIStroke", { Thickness = 2, Transparency = 0.25 })
		I[8] = new("Frame", I[1], "Player", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 215, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.545), Size = UDim2.fromScale(0.2, 0.2) })
			I[9] = new("UIGradient", I[8], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 1), NumberSequenceKeypoint.new(1, 0) }) })
			I[10] = new("ImageLabel", I[8], "Headshot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/headshot-thumbnail/image?userId=15941965&width=420&height=420&format=png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[11] = new("UICorner", I[10], "UICorner")
			I[12] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.025, 0), BottomRightRadius = UDim.new(0.025, 0), TopLeftRadius = UDim.new(0.025, 0), TopRightRadius = UDim.new(0.025, 0) })
	return I[1]
end

return build
