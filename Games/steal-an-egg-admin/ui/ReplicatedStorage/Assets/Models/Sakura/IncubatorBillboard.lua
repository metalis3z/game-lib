-- Generated from ui/ReplicatedStorage/Assets/Models/Sakura/IncubatorBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "IncubatorBillboard", { Active = true, AlwaysOnTop = true, Brightness = 2, ClipsDescendants = true, MaxDistance = 400, ResetOnSpawn = false, Size = UDim2.fromScale(36, 9.6000004), StudsOffset = Vector3.new(0, 1.6203827, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "rmEnB8VBrmEn" })
		I[2] = new("TextLabel", I[1], "DisplayText", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.9, 0.4), Text = "Sakura Incubator", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "05OJFoTn05OJ" })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.1278066, Color3.fromRGB(2, 7, 255)), ColorSequenceKeypoint.new(0.4559585, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(0.5595855, Color3.fromRGB(81, 244, 255)), ColorSequenceKeypoint.new(0.5647668, Color3.fromRGB(85, 255, 255)), ColorSequenceKeypoint.new(0.6338515, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(0.8411053, Color3.fromRGB(2, 5, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "9cB6toma9cB6" })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.5 }, { ["_lemonadeUniqueId"] = "BAeYhezvBAeY" })
		I[5] = new("TextLabel", I[1], "Countdown", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.9, 0.3), Text = "Sealed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "oNwQmPkOoNwQ" })
			I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(186, 186, 186)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "mlp3TlDBmlp3" })
			I[7] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.3 }, { ["_lemonadeUniqueId"] = "HiXcFmIqHiXc" })
		I[8] = new("Frame", I[1], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = -90, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.new(0.5, 0, 0.25, 2), ZIndex = -1 }, { ["Hitted_Size"] = UDim2.fromScale(1.5, 1.5), ["Originale_Size"] = UDim2.fromScale(1, 1), ["_lemonadeUniqueId"] = "MJrbzNHfMJrb" })
			I[9] = new("Frame", I[8], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.4, 1), ZIndex = -888888888 }, { ["Updated"] = true, ["_lemonadeUniqueId"] = "WM872LHvWM87" }, { "Humanoid_Health" })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "IsYvar1dIsYv" })
				I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 254, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 254, 8)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "fJyDq3NvfJyD" })
			I[12] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.1 }, { ["_lemonadeUniqueId"] = "FffWUJIaFffW" })
			I[13] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) }, { ["_lemonadeUniqueId"] = "xTDViRDBxTDV" })
				I[14] = new("UIScale", I[13], "Scaler", nil, { ["_lemonadeUniqueId"] = "h5weWVHDh5we" })
			I[15] = new("Frame", I[8], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -999999999 }, { ["_lemonadeUniqueId"] = "hgna6zNPhgna" })
				I[16] = new("UIStroke", I[15], "UIStroke", { Enabled = false, Thickness = 3 }, { ["ThicknessUDim"] = UDim.new(0.1440821, 0), ["_lemonadeUniqueId"] = "IMt8bTNjIMt8" })
				I[17] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) }, { ["_lemonadeUniqueId"] = "Uh1GcfFTUh1G" })
	return I[1]
end

return build
