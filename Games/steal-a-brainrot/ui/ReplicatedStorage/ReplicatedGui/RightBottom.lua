-- Generated from ui/ReplicatedStorage/ReplicatedGui/RightBottom.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RightBottom", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_6b253caf94" }, { "ScreenGui" })
		I[2] = new("ImageButton", I[1], "MobileShiftLock", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/mouseLock_off.png"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.07, 0.07), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false }, { ["ViralWorkerRef"] = "vw_2d02dbfc63" })
		I[3] = new("ImageButton", I[1], "Slowmode", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137163242046829"), Position = UDim2.fromScale(0.8921548, 0.4612644), Size = UDim2.fromScale(0.0890072, 0.074005), Visible = false }, { ["ViralWorkerRef"] = "vw_8ff7210273" })
			I[4] = new("TextLabel", I[3], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.7), Text = "ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_39cdcd0d1d" })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_b238cf9bf8" }, { "ScreenStroke", "UIStroke" })
			I[6] = new("TextLabel", I[3], "Slow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.25), Size = UDim2.fromScale(1, 0.6), Text = "Slow Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_d7009702f3" })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_fb8850825d" }, { "ScreenStroke", "UIStroke" })
			I[8] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.5 }, { ["ViralWorkerRef"] = "vw_9d402c3a93" })
	return I[1]
end

return build
