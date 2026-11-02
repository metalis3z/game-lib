-- Generated from ui/ServerStorage/Gui_BeforeRecolor/ClotureInteractGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ClotureInteractGui", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("TextButton", I[1], "InteractButton", { BackgroundColor3 = Color3.fromRGB(40, 180, 80), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -150, 0.85, -80), Size = UDim2.fromOffset(300, 80), Text = "INTERACT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
			I[5] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(40, 180, 80), ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
	return I[1]
end

return build
