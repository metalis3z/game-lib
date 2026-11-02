-- Generated from ui/StarterGui/Challenges.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Challenges", { ResetOnSpawn = false })
		I[2] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.005, 4), PaddingLeft = UDim.new(0.003, 4), PaddingRight = UDim.new(0.003, 4), PaddingTop = UDim.new(0.005, 4) })
		I[3] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.15), Size = UDim2.new(0.15, 70, 0.25, 0) })
			I[4] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
