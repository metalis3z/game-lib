-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/SavedOutfitsController/divider.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "divider", { BackgroundColor3 = Color3.fromRGB(30, 45, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 300, Position = UDim2.fromScale(0, 0.7583923), Size = UDim2.fromScale(1, 0.035), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 0 })
		I[2] = new("Frame", I[1], "line", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(70, 68, 77), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.9, 0, 0.05, 2) })
			I[3] = new("UISizeConstraint", I[2], "UISizeConstraint", { MaxSize = Vector2.new(math.huge, 2), MinSize = Vector2.new(0, 2) })
	return I[1]
end

return build
