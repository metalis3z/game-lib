-- Generated from ui/ReplicatedStorage/Assets/Billboards/PlayerPlotSign.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "PlayerPlotSign", { Active = true, Enabled = false, MaxDistance = math.huge, Size = UDim2.fromScale(10, 10), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "e9N2NLNhe9N2" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "KpT1RSHLKpT1" })
			I[3] = new("ImageLabel", I[2], "PlayerIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "prpdGiTpprpd" })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "X4GlejDdX4Gl" })
			I[5] = new("TextLabel", I[2], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1.5, 0.4), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "yLCXUVTdyLCX" })
				I[6] = new("UIStroke", I[5], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "GVrIqfjBGVrI" })
			I[7] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "tNYpsNi8tNYp" })
			I[8] = new("UIStroke", I[2], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 }, { ["_lemonadeUniqueId"] = "7G3v5wsk7G3v" })
	return I[1]
end

return build
