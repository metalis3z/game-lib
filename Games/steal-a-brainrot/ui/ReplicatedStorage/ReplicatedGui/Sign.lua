-- Generated from ui/ReplicatedStorage/ReplicatedGui/Sign.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Sign", { DisplayOrder = 50, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_f8a0adafaa" })
		I[2] = new("Frame", I[1], "SignPanel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 20, 30), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.65), Visible = false }, { ["ViralWorkerRef"] = "vw_9af8c76aaf" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 4.0999999 }, { ["ViralWorkerRef"] = "vw_4c4400ca99" })
			I[4] = new("UISizeConstraint", I[2], "UISizeConstraint", { MaxSize = Vector2.new(500, 600) }, { ["ViralWorkerRef"] = "vw_947010995c" })
			I[5] = new("TextButton", I[2], "Back", { BackgroundColor3 = Color3.fromRGB(40, 40, 50), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.new(0, 10, 1, -40), Size = UDim2.new(0.01, 100, 0.01, 30), Text = "← Back", TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14, Visible = false }, { ["ViralWorkerRef"] = "vw_ab558f66f3" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.5999999 }, { ["ViralWorkerRef"] = "vw_1bb7ebb386" })
			I[7] = new("TextButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(40, 40, 50), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.97, -45, 0.0097003, 5), Size = UDim2.new(0.016, 40, 0.01, 40), Text = "X", TextColor3 = Color3.fromRGB(255, 100, 100), TextSize = 20 }, { ["ViralWorkerRef"] = "vw_4825afd93f" })
				I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 3.5 }, { ["ViralWorkerRef"] = "vw_1265e75f6b" })
			I[9] = new("TextLabel", I[2], "Info", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.new(0, 10, 1, -40), Size = UDim2.new(1, -130, 0, 30), Text = "", TextColor3 = Color3.fromRGB(150, 150, 160), TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["ViralWorkerRef"] = "vw_d48d013809" })
			I[10] = new("TextLabel", I[2], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.104, 0), Size = UDim2.new(1, 0, 0.01, 50), Text = "Signing System", TextColor3 = Color3.fromRGB(170, 85, 255), TextSize = 24 }, { ["ViralWorkerRef"] = "vw_8fc31e2e12" })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 4.6999998 }, { ["ViralWorkerRef"] = "vw_4414d2e1ac" })
			I[12] = new("ScrollingFrame", I[2], "Content", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(10, 72), ScrollBarImageColor3 = Color3.fromRGB(170, 85, 255), ScrollBarThickness = 6, Size = UDim2.new(1, -20, 0.97, -120) }, { ["ViralWorkerRef"] = "vw_48996459cc" })
				I[13] = new("UIListLayout", I[12], "UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_6fb0dc8286" })
			I[14] = new("ImageLabel", I[2], "Shiny", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.86, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4983588, 0.0486512), Size = UDim2.fromScale(1, 0.1), ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_d282ffd4b9" })
				I[15] = new("UIGradient", I[14], "UIGradient", { Offset = Vector2.new(0.12, 0.12), Rotation = 10, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4975063, 1), NumberSequenceKeypoint.new(0.4987531, 0), NumberSequenceKeypoint.new(0.6346633, 0), NumberSequenceKeypoint.new(0.6371571, 1), NumberSequenceKeypoint.new(0.701995, 1), NumberSequenceKeypoint.new(0.7044888, 0), NumberSequenceKeypoint.new(0.7431422, 0), NumberSequenceKeypoint.new(0.7443891, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["ViralWorkerRef"] = "vw_bf3b3c0767" })
				I[16] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["ViralWorkerRef"] = "vw_e37a0b69b8" })
			I[17] = new("ImageLabel", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(102, 0, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://"), Position = UDim2.fromScale(0.5, 0.0591873), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1183745), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_493ee80505" })
				I[18] = new("UIStroke", I[17], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Center, Thickness = 4 }, { ["ViralWorkerRef"] = "vw_63e50fd48d" })
				I[19] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 31, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 234)) }) }, { ["ViralWorkerRef"] = "vw_a5c1b1c0b0" })
	return I[1]
end

return build
