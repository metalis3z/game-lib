-- Generated from ui/ServerStorage/OldInventory/Examine_Data/EquipSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "EquipSlot", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0, 137, 0.5, -60), Size = UDim2.fromOffset(120, 120) })
		I[2] = new("Frame", I[1], "Locked", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("ImageLabel", I[2], "LockedIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=335260184"), ImageTransparency = 0.95, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[4] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Unlock", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, ZIndex = 2 })
			I[5] = new("TextLabel", I[2], "Price", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -29), Size = UDim2.new(1, -30, 0, 20), Text = "75", TextColor3 = Color3.fromRGB(255, 200, 0), TextSize = 36, TextStrokeColor3 = Color3.fromRGB(109, 85, 0), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
			I[6] = new("ImageLabel", I[2], "CoinIcon", { BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://3150319038"), Position = UDim2.new(1, -30, 1, -30), Size = UDim2.fromOffset(25, 25), ZIndex = 2 })
		I[7] = new("TextLabel", I[1], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.05, 0, 1, -30), Size = UDim2.new(0.9, 0, 0, 30), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextWrapped = true })
	return I[1]
end

return build
