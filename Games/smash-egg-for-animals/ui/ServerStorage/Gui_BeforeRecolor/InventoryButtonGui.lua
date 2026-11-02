-- Generated from ui/ServerStorage/Gui_BeforeRecolor/InventoryButtonGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "InventoryButtonGui", { DisplayOrder = 9, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "IconButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135211112386622"), Position = UDim2.fromScale(0.4989375, 0.9057456), ScaleType = Enum.ScaleType.Fit, Selectable = false, Size = UDim2.fromOffset(80, 60), Visible = false }, nil, { "UIButton" })
			I[3] = new("TextLabel", I[2], "Caption", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(1.3, 0.3), Text = "Inventory", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
	return I[1]
end

return build
