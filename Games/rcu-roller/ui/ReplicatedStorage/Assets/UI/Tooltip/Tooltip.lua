-- Generated from ui/ReplicatedStorage/Assets/UI/Tooltip/Tooltip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Tooltip", { Active = true, AnchorPoint = Vector2.new(0, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(27, 30, 31), BackgroundTransparency = 0.075, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.06, 0.033), Text = "...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1500 })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[3] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.07, 0), PaddingLeft = UDim.new(0.02, 0), PaddingRight = UDim.new(0.02, 0), PaddingTop = UDim.new(0.07, 0) })
	return I[1]
end

return build
