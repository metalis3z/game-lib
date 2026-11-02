-- Generated from ui/StarterGui/BackroomsDropButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BackroomsDropButton", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_17b654c803" })
		I[2] = new("Frame", I[1], "DropFrame", { BackgroundTransparency = 1, Position = UDim2.new(0.5, -90, 0.8587391, 0), Size = UDim2.fromOffset(191, 48), Visible = false }, { ["ViralWorkerRef"] = "vw_5895a2ec43" })
			I[3] = new("Frame", I[2], "DropBtn", { BackgroundColor3 = Color3.fromRGB(220, 50, 50), BorderSizePixel = 0, Size = UDim2.fromScale(1.1722223, 1) }, { ["ViralWorkerRef"] = "vw_e054f79f71" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(120, 0, 0), Thickness = 2 }, { ["ViralWorkerRef"] = "vw_6cb0a4faa1" })
				I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 32, 32)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 20, 20)) }), Rotation = 89 }, { ["ViralWorkerRef"] = "vw_63cda0aacd" })
				I[6] = new("TextLabel", I[3], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(62, 4), Size = UDim2.new(0.9620853, -56, 0.8363636, 0), Text = "DROP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_1781851040" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_fd16190213" })
				I[8] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 1), BottomRightRadius = UDim.new(0, 1), TopLeftRadius = UDim.new(0, 1), TopRightRadius = UDim.new(0, 1) }, { ["ViralWorkerRef"] = "vw_ed5826c8c1" })
				I[9] = new("Frame", I[3], "Shiny", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.82, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.45), ZIndex = 3 }, { ["ViralWorkerRef"] = "vw_59036eb20e" })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) }, { ["ViralWorkerRef"] = "vw_77eda22a83" })
					I[11] = new("ImageLabel", I[9], "Shiny", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.86, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5000001), Size = UDim2.fromScale(0.9999999, 1.0000001), ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_34e28e5667" })
						I[12] = new("UIGradient", I[11], "UIGradient", { Offset = Vector2.new(0.12, 0.12), Rotation = 10, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4975063, 1), NumberSequenceKeypoint.new(0.4987531, 0), NumberSequenceKeypoint.new(0.6346633, 0), NumberSequenceKeypoint.new(0.6371571, 1), NumberSequenceKeypoint.new(0.701995, 1), NumberSequenceKeypoint.new(0.7044888, 0), NumberSequenceKeypoint.new(0.7431422, 0), NumberSequenceKeypoint.new(0.7443891, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["ViralWorkerRef"] = "vw_aafabbd5cc" })
						I[13] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["ViralWorkerRef"] = "vw_41370d3c79" })
	return I[1]
end

return build
