-- Generated from ui/ServerScriptService/Giver/GiftGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GiftGUI", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "MainFrame", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), BorderSizePixel = 20, Position = UDim2.new(0.5, -236, 0.5, -141), Size = UDim2.fromOffset(473, 395) })
			I[3] = new("TextButton", I[2], "GiftWeapon", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1719641), Size = UDim2.fromOffset(234, 50), Text = "Gift Weapon", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("TextButton", I[2], "GiftPerks", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.2985463), Size = UDim2.fromOffset(234, 49), Text = "Gift Perks", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("TextBox", I[2], "PlayerName", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter The Player's Name Here! (E.g. AniDarkness)", Size = UDim2.fromOffset(427, 34), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("TextBox", I[2], "ItemName", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter the item/map name here! (E.g. SwirlyGun or Mansion2)", Position = UDim2.fromScale(0, 0.0865411), Size = UDim2.fromOffset(473, 34), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[7] = new("TextButton", I[2], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9027484, -0.0001252), Size = UDim2.fromOffset(46, 34), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[8] = new("TextButton", I[2], "GiftPet", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947146, 0.1714273), Size = UDim2.fromOffset(239, 50), Text = "Gift Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[9] = new("TextButton", I[2], "GiftEmotes", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947146, 0.2980096), Size = UDim2.fromOffset(239, 50), Text = "Gift Emotes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[10] = new("TextButton", I[2], "GiftEffect", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.4245918), Size = UDim2.fromOffset(234, 49), Text = "Gift Effect", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[11] = new("TextButton", I[2], "GiftAllEffects", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5461109), Size = UDim2.fromOffset(234, 49), Text = "Gift All Effects", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[12] = new("TextButton", I[2], "GiftToys", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947146, 0.4271235), Size = UDim2.fromOffset(239, 48), Text = "Gift Toys", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[13] = new("TextButton", I[2], "GiftRadio", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947146, 0.5486424), Size = UDim2.fromOffset(239, 48), Text = "Gift Radio", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[14] = new("TextButton", I[2], "ForceBonusRound", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0021142, 0.6701615), Size = UDim2.fromOffset(234, 49), Text = "Force Bonus Round", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[15] = new("TextButton", I[2], "SetMap", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4968288, 0.6701615), Size = UDim2.fromOffset(238, 49), Text = "Set Map", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[16] = new("TextButton", I[2], "ForceSheriff", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947146, 0.7942122), Size = UDim2.fromOffset(239, 81), Text = "Force Sheriff", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[17] = new("TextButton", I[2], "ForceMurderer", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0021142, 0.7942122), Size = UDim2.fromOffset(234, 82), Text = "Force Murderer", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
