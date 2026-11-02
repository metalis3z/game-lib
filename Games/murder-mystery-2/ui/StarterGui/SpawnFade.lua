-- Generated from ui/StarterGui/SpawnFade.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpawnFade", { DisplayOrder = 2, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Fade", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Position = UDim2.fromOffset(-50, -50), Size = UDim2.new(1, 100, 1, 100) })
			I[3] = new("Frame", I[2], "Flash", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(-50, -50), Size = UDim2.new(1, 100, 1, 100) })
		I[4] = new("Frame", I[1], "CodeFrame", { BackgroundColor3 = Color3.fromRGB(17, 17, 17), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.new(0.4989879, -226, 0.4996122, -234), Size = UDim2.fromOffset(453, 468), Visible = false })
			I[5] = new("Frame", I[4], "ItemInfo", { BackgroundColor3 = Color3.fromRGB(17, 17, 17), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromScale(1, 0), Size = UDim2.fromOffset(214, 468), Visible = false })
				I[6] = new("TextLabel", I[5], "Code", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromOffset(214, 50), Text = "Code", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("TextLabel", I[5], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.198718), Size = UDim2.fromOffset(214, 50), Text = "Item Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("ImageLabel", I[5], "ItemIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.1448598, 0.3311966), Size = UDim2.fromOffset(155, 157) })
				I[9] = new("TextButton", I[5], "Hide", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.9038461), Size = UDim2.fromOffset(214, 45), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Exit", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[10] = new("Frame", I[4], "Title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(-0.0154527, -0.0128205), Size = UDim2.new(1.6997794, -310, -0.0042735, 45), Style = Enum.FrameStyle.DropShadow })
				I[11] = new("TextLabel", I[10], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(39, 3), Size = UDim2.new(0.8889922, -30, 0.7663602, 0), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextStrokeTransparency = 0.7 })
			I[12] = new("Folder", I[4], "ExpiredFrames")
				I[13] = new("Frame", I[12], "Expired", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(255, 0, 0), Position = UDim2.fromScale(0.2869757, 0.632094), Size = UDim2.fromOffset(182, 3), Visible = false })
			I[14] = new("TextButton", I[4], "Close", { BackgroundColor3 = Color3.fromRGB(217, 68, 68), BorderColor3 = Color3.fromRGB(149, 46, 46), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(-0.1679029, 13, -0.0275, 11), Selectable = false, Size = UDim2.fromOffset(45, 41), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48, TextStrokeTransparency = 0.7, ZIndex = 2 })
			I[15] = new("TextLabel", I[4], "Note", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0790598), Size = UDim2.new(1, 0, -0.0555556, 50), Text = "UPDATES EVERY NEW CODE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[16] = new("TextLabel", I[4], "Note", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2781457, 0.8354701), Size = UDim2.new(0.4437087, 0, -0.0555556, 50), Text = "Expires Soon...", TextColor3 = Color3.fromRGB(149, 149, 149), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[17] = new("TextButton", I[4], "Code 6", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.4957265), Size = UDim2.fromOffset(453, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[18] = new("TextButton", I[4], "Code 5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.00883, 0.4273504), Size = UDim2.fromOffset(453, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[19] = new("TextButton", I[4], "Code 4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.3611111), Size = UDim2.fromOffset(453, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[20] = new("TextButton", I[4], "Code 3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.292735), Size = UDim2.fromOffset(453, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[21] = new("TextButton", I[4], "Code 2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.224359), Size = UDim2.fromOffset(453, 50), Text = "D4RT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[22] = new("TextButton", I[4], "Code 1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1495726), Size = UDim2.fromOffset(453, 50), Text = "S33K3R", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[23] = new("TextButton", I[4], "Code 7", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.00883, 0.5641025), Size = UDim2.fromOffset(453, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[24] = new("TextButton", I[4], "Code 8", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.6346154), Size = UDim2.fromOffset(453, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[25] = new("TextButton", I[4], "Code 9", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7008547), Size = UDim2.fromOffset(453, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[26] = new("TextButton", I[4], "Code 2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.3034188), Size = UDim2.fromOffset(453, 50), Text = "M4K3SH1FT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[27] = new("TextButton", I[4], "Code 2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.3974359), Size = UDim2.fromOffset(453, 50), Text = "Z0MB13B4T", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[28] = new("TextButton", I[4], "Code 2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.4807692), Size = UDim2.fromOffset(453, 50), Text = "ICESHARD", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[29] = new("TextButton", I[4], "Code 2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5619658), Size = UDim2.fromOffset(453, 50), Text = "PEPPERM1NT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
