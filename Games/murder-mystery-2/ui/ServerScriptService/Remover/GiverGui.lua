-- Generated from ui/ServerScriptService/Remover/GiverGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GiverGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "MainFrame", { BackgroundColor3 = Color3.fromRGB(31, 31, 31), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.new(0.5, -236, 0.5, -141), Size = UDim2.fromOffset(473, 283) })
			I[3] = new("TextButton", I[2], "GiveWeapon", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0021142, 0.8233216), Size = UDim2.fromOffset(181, 50), Text = "Remove Weapon", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("TextButton", I[2], "GivePet", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5759717), Size = UDim2.fromOffset(180, 50), Text = "Remove Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("TextBox", I[2], "PlayerName", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter Users Name", Size = UDim2.fromOffset(473, 51), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
			I[7] = new("TextBox", I[2], "ItemName", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Knife/Pet Name Here!", Position = UDim2.fromScale(0, 0.2756184), Size = UDim2.fromOffset(473, 51), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[9] = new("TextButton", I[2], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7864693, 0.7208481), Size = UDim2.fromOffset(101, 79), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
	return I[1]
end

return build
