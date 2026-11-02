-- Generated from ui/ReplicatedFirst/UISelector/Loading/Loading_Clean.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Loading_Clean", { DisplayOrder = 10, ResetOnSpawn = false }, { ["by"] = "takenliars" })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(0, -100), Size = UDim2.new(1, 0, 1, 100), ZIndex = 8 })
			I[3] = new("TextLabel", I[2], "LoadingText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.78), Size = UDim2.fromScale(1, 0.08), Text = "Connecting...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 42, TextWrapped = true, ZIndex = 10 })
			I[4] = new("TextButton", I[2], "Skip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -100, 0.87, 0), Size = UDim2.new(0, 200, 0.06, 0), SizeConstraint = Enum.SizeConstraint.RelativeYY, Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Skip", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7, Visible = false, ZIndex = 8 })
			I[5] = new("TextLabel", I[2], "Warning", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0, 0.94), Size = UDim2.fromScale(1, 0.03), Text = "Warning: Skipping may cause clothes to appear grey", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextWrapped = true, Visible = false, ZIndex = 8 })
			I[6] = new("ImageLabel", I[2], "Thumbs", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(232, 232, 232), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=167884734"), Position = UDim2.new(0, 10, 0.95, -10), Selectable = true, Size = UDim2.fromScale(0.05, 0.05), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 8 })
				I[7] = new("TextLabel", I[6], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(1, 10, 0, 0), Size = UDim2.fromScale(10, 1), Text = "Don't forget to thumbs up!", TextColor3 = Color3.fromRGB(179, 179, 179), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 8 })
			I[8] = new("Frame", I[2], "LoadingBar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, 0.07), Visible = false, ZIndex = 10 })
				I[9] = new("Frame", I[8], "BarContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(53, 53, 53), BorderSizePixel = 5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 0.7), ZIndex = 10 })
					I[10] = new("Frame", I[9], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(72, 77, 70), BorderColor3 = Color3.fromRGB(35, 35, 35), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1), ZIndex = 11 })
					I[11] = new("TextLabel", I[9], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Loading Inventory...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true, ZIndex = 12 })
			I[12] = new("Frame", I[2], "Images", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[13] = new("ImageLabel", I[12], "Colored_Clean", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18933728633"), Position = UDim2.fromScale(-0.4, -0.4104167), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 10 })
				I[14] = new("ImageLabel", I[12], "Grey", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18933730045"), Position = UDim2.fromScale(-0.4, -0.4), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 9 })
	return I[1]
end

return build
