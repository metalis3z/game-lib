-- Generated from ui/ServerStorage/Quarantine_759220424/Timer~7.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.1791207), Size = UDim2.fromScale(1.221239, 0.3619048), Text = "Next Spin In 00:00", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 39, TextWrapped = true, ZIndex = 2 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Thickness = 2.825, Transparency = 0.11 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
		I[3] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(-0.0131579, 0), PaddingLeft = UDim.new(0.1582126, 0), PaddingRight = UDim.new(0.1582126, 0), PaddingTop = UDim.new(-0.0131579, 0) })
	return I[1]
end

return build
