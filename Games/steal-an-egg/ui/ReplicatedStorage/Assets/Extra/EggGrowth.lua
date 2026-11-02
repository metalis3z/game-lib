-- Generated from ui/ReplicatedStorage/Assets/Extra/EggGrowth.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "EggGrowth", { Active = true, AlwaysOnTop = true, MaxDistance = 25, ResetOnSpawn = false, Size = UDim2.fromScale(0.9, 1) })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 1), Text = "2%", TextColor3 = Color3.fromRGB(184, 184, 184), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2.5, Transparency = 0.35 })
	return I[1]
end

return build
