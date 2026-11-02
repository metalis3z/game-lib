-- Generated from ui/ReplicatedStorage/ReplicatedGui/DuelsMachinePrompt.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DuelsMachinePrompt", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_7d363d53fe" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "DuelsMachinePrompt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.99, 0.98) }, { ["ViralWorkerRef"] = "vw_d0b9635659" })
			I[3] = new("ImageLabel", I[2], "InviteTemplate", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1698942, 0.1375656), SliceCenter = Rect.new(485, 14, 485, 75), Visible = false }, { ["ViralWorkerRef"] = "vw_f8c7120be0" })
				I[4] = new("TextLabel", I[3], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.3916417, 0.1523007), Size = UDim2.fromScale(0.6999999, 0.2144083), Text = "Invite", TextColor3 = Color3.fromRGB(115, 223, 120), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_6f287e8dcc" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_365da6cbba" }, { "ScreenStroke", "UIStroke" })
				I[6] = new("TextLabel", I[3], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.507, 0.45), Size = UDim2.fromScale(0.9297194, 0.3222941), Text = "Onlytwentycharacters invited you to a Duel!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_fecc159022" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_9e231376ee" }, { "ScreenStroke", "UIStroke" })
				I[8] = new("ImageButton", I[3], "Yes", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.04, 0.933), Size = UDim2.fromScale(0.4394761, 0.2736073) }, { ["ViralWorkerRef"] = "vw_a63f615f12" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_8453bf9598" }, { "ScreenStroke", "UIStroke" })
					I[10] = new("TextLabel", I[8], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_0f385f6581" })
						I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_7696b8359d" }, { "ScreenStroke", "UIStroke" })
				I[12] = new("ImageButton", I[3], "No", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(233, 66, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.96, 0.933), Size = UDim2.fromScale(0.4394762, 0.2736073) }, { ["ViralWorkerRef"] = "vw_ae5a9bceeb" })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_2440f4bd60" }, { "ScreenStroke", "UIStroke" })
					I[14] = new("TextLabel", I[12], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Decline", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_6a3dae9a24" })
						I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_69f07d8315" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("UIStroke", I[3], "UIStroke", { Thickness = 0.5546296 }, { ["OriginalThickness"] = 1, ["ViralWorkerRef"] = "vw_0817ecf284" }, { "ScreenStroke", "UIStroke" })
				I[17] = new("Frame", I[3], "Fill", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.025) }, { ["ViralWorkerRef"] = "vw_05f4eeb869" })
				I[18] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.5 }, { ["ViralWorkerRef"] = "vw_b5204aee43" })
	return I[1]
end

return build
