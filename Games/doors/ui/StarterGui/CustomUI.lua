-- Generated from ui/StarterGui/CustomUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CustomUI", { DisplayOrder = 2, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ScrollingFrame", I[1], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 3), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.15, 0.5), Visible = false })
			I[3] = new("UIGridLayout", I[2], "UIGridLayout", { CellSize = UDim2.fromScale(1, 0.0216), SortOrder = Enum.SortOrder.LayoutOrder })
		I[4] = new("ScrollingFrame", I[1], "scary", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 3), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.15, 0.5), Visible = false })
			I[5] = new("UIGridLayout", I[4], "UIGridLayout", { CellSize = UDim2.fromScale(1, 0.0216), SortOrder = Enum.SortOrder.LayoutOrder })
			I[6] = new("TextButton", I[4], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 2, Size = UDim2.fromOffset(200, 50), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Rush", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[7] = new("TextButton", I[4], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 2, Size = UDim2.fromOffset(200, 50), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Ambush", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[8] = new("Frame", I[1], "TestFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[9] = new("TextLabel", I[8], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7676493, 0.0648036), Size = UDim2.fromScale(0.1587302, 0.0984615), Text = "Recreation", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 38, TextTransparency = 0.55 })
		I[10] = new("Frame", I[1], "TestFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[11] = new("TextLabel", I[10], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.420204, 0.0086238), RichText = true, Size = UDim2.fromScale(0.1587302, 0.0984615), Text = "NOT THE FINISHED MODEL<br/>preview", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 38, TextTransparency = 0.12 })
	return I[1]
end

return build
