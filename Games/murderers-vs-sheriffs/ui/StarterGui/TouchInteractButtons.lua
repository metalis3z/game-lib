-- Generated from ui/StarterGui/TouchInteractButtons.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TouchInteractButtons", { AutoLocalize = false, DisplayOrder = 3, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Phone", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageButton", I[2], "TouchInteract", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Input/TouchControlsSheetV2.png"), ImageRectOffset = Vector2.new(1, 1), ImageRectSize = Vector2.new(144, 144), Position = UDim2.new(1, -175, 1, -165), Size = UDim2.fromOffset(70, 70), Visible = false })
				I[4] = new("Frame", I[3], "Use", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[5] = new("TextLabel", I[4], "PerkName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "Activate", TextColor3 = Color3.fromRGB(220, 220, 220), TextSize = 24, TextStrokeTransparency = 0.7, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
					I[6] = new("ImageLabel", I[4], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4605890398"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[7] = new("Frame", I[3], "Cooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
					I[8] = new("ImageLabel", I[7], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(52, 52, 52), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4605890398"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[9] = new("Frame", I[3], "Knife", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
					I[10] = new("ImageLabel", I[9], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4681024341"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[11] = new("TextLabel", I[9], "PerkName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "Slash", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[12] = new("ImageButton", I[2], "TouchInteractKnife", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Input/TouchControlsSheetV2.png"), ImageRectOffset = Vector2.new(1, 1), ImageRectSize = Vector2.new(144, 144), Position = UDim2.new(1, -175, 1, -165), Size = UDim2.fromOffset(70, 70), Visible = false })
				I[13] = new("Frame", I[12], "Knife", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[14] = new("ImageLabel", I[13], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4681024341"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[15] = new("TextLabel", I[13], "PerkName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "Slash", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
		I[16] = new("Frame", I[1], "Tablet", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[17] = new("ImageButton", I[16], "TouchInteractKnife", { AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Input/TouchControlsSheetV2.png"), ImageRectOffset = Vector2.new(1, 1), ImageRectSize = Vector2.new(144, 144), Position = UDim2.new(1, -175, 1, -100), Size = UDim2.fromOffset(100, 100), Visible = false })
				I[18] = new("Frame", I[17], "Knife", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[19] = new("ImageLabel", I[18], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4681024341"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[20] = new("TextLabel", I[18], "PerkName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "Slash", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[21] = new("ImageButton", I[16], "TouchInteract", { AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Input/TouchControlsSheetV2.png"), ImageRectOffset = Vector2.new(1, 1), ImageRectSize = Vector2.new(144, 144), Position = UDim2.new(1, -175, 1, -100), Size = UDim2.fromOffset(100, 100), Visible = false })
				I[22] = new("Frame", I[21], "Use", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[23] = new("TextLabel", I[22], "PerkName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "Activate", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
					I[24] = new("ImageLabel", I[22], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4605890398"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[25] = new("Frame", I[21], "Cooldown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
					I[26] = new("ImageLabel", I[25], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(44, 44, 44), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4605890398"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[27] = new("Frame", I[21], "Knife", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
					I[28] = new("ImageLabel", I[27], "KnifeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4681024341"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[29] = new("TextLabel", I[27], "PerkName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "Slash", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
	return I[1]
end

return build
