-- Generated from ui/ReplicatedStorage/Assets/BeanstalkBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "BeanstalkBillboard", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, MaxDistance = 200, ResetOnSpawn = false, Size = UDim2.fromScale(25, 10), StudsOffset = Vector3.new(0, 5, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "OverheadUITag" })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("TextLabel", I[1], "TAG", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), RichText = true, Size = UDim2.fromScale(1, 0.5), Text = "[GG]", TextColor3 = Color3.fromRGB(230, 237, 243), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 15 })
			I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.025, 0), PaddingRight = UDim.new(0.025, 0), PaddingTop = UDim.new(0.05, 0) })
	return I[1]
end

return build
