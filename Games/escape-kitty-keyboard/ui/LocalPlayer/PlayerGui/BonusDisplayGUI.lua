-- Generated from ui/LocalPlayer/PlayerGui/BonusDisplayGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BonusDisplayGUI", { DisplayOrder = 50, ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "BonusContainer", { AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -15, 1, -15), Size = UDim2.fromScale(0.15, 0.12) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Bottom })
	return I[1]
end

return build
