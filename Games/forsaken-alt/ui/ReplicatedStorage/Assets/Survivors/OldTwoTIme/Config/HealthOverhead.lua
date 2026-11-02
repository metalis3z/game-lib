-- Generated from ui/ReplicatedStorage/Assets/Survivors/OldTwoTIme/Config/HealthOverhead.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "HealthOverhead", { Active = true, ClipsDescendants = true, MaxDistance = 15, Size = UDim2.fromOffset(200, 35), StudsOffset = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(24, 24, 24), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("Frame", I[2], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(104, 104, 104), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.85), ZIndex = 2 })
				I[4] = new("Frame", I[3], "Red", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.15, 1), ZIndex = 3 })
					I[5] = new("UICorner", I[4], "UICorner")
				I[6] = new("UICorner", I[3], "UICorner")
			I[7] = new("UICorner", I[2], "UICorner")
	return I[1]
end

return build
