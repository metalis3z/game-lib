-- Generated from ui/ReplicatedStorage/Assets/UI/BoothSurfaceGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "BoothSurfaceGui", { Brightness = 0.5, ClipsDescendants = true, LightInfluence = 0.25, MaxDistance = 150, PixelsPerStud = 131.9261169, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud })
		I[2] = new("Frame", I[1], "List", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("ScrollingFrame", I[2], "Holder", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://9039079675"), CanvasSize = UDim2.fromScale(1.3, 0), ClipsDescendants = false, MidImageContent = Content.fromUri("rbxassetid://9039055773"), Position = UDim2.fromScale(0.5, 0.5), ScrollBarThickness = 0, Size = UDim2.fromScale(1, 1), TopImageContent = Content.fromUri("rbxassetid://9039080581") })
				I[4] = new("UIGridLayout", I[3], "UIGridLayout", { CellPadding = UDim2.fromOffset(15, 0), CellSize = UDim2.fromScale(0.24, 1), FillDirection = Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
