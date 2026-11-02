-- Generated from ui/ReplicatedStorage/Assets/RankTexts/F A L L E N   A N G E L.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "F A L L E N   A N G E L", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4822915, 0.5593462), RichText = true, Size = UDim2.fromScale(0.2959406, 0.1656315), Text = "F A L L E N   A N G E L", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 100, TextStrokeColor3 = Color3.fromRGB(128, 255, 139), ZIndex = 3 })
		I[2] = new("UIStroke", I[1], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(73, 100, 255)), ColorSequenceKeypoint.new(0.449827, Color3.fromRGB(158, 176, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(158, 176, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(73, 100, 255)) }), Rotation = 90 })
		I[4] = new("UIGradient", I[1], "Event_Horizon", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.15, Color3.fromRGB(0, 0, 80)), ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 200, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 200, 255)), ColorSequenceKeypoint.new(0.85, Color3.fromRGB(0, 0, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = 90 })
	return I[1]
end

return build
