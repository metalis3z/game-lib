-- Generated from ui/ReplicatedStorage/Assets/Billboards/GuardMiss.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "GuardMiss", { Active = true, AlwaysOnTop = true, MaxDistance = 66.8515701, Size = UDim2.fromScale(59.5460014, 1.4), StudsOffset = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["BillBoardIdentifier"] = "ab5a18f2-c1db-4c5d-8476-3e9f5aa44afa", ["MaxDist"] = 80 })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80424172781827"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 2) })
	return I[1]
end

return build
