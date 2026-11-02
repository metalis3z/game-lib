-- Generated from ui/StarterGui/Killfeed.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Killfeed", { ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0, 1), Size = UDim2.new(0.35, 75, 0.215, 100) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[4] = new("UIScale", I[2], "UIScale")
		I[5] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.005, 4), PaddingLeft = UDim.new(0.003, 4), PaddingRight = UDim.new(0.003, 4), PaddingTop = UDim.new(0.005, 4) })
	return I[1]
end

return build
