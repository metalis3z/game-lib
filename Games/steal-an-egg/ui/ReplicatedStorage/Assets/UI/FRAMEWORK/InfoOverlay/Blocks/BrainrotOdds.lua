-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/BrainrotOdds.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BrainrotOdds", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 30, Size = UDim2.new(1, 0, 0, 100) })
		I[2] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(199, 200) })
		I[3] = new("UIGridLayout", I[1], "UIGridLayout", { CellPadding = UDim2.fromOffset(3, 3), CellSize = UDim2.new(0.33, -3, 0, 60), FillDirectionMaxCells = 3, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
