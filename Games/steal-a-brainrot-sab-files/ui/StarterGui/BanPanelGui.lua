-- Generated from ui/StarterGui/BanPanelGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BanPanelGui", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("TextButton", I[1], "ToggleButton", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(35, 35, 45), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 15, 1, -70), Size = UDim2.fromOffset(55, 55), Text = "🛡️", TextSize = 24 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
		I[4] = new("Frame", I[1], "MainPanel", { BackgroundColor3 = Color3.fromRGB(25, 25, 32), Position = UDim2.new(0, 15, 1, -340), Size = UDim2.fromOffset(420, 320), Visible = false })
			I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
			I[6] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(60, 60, 75), Thickness = 1.5 })
			I[7] = new("Frame", I[4], "Header", { BackgroundColor3 = Color3.fromRGB(35, 35, 48), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 50) })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
				I[9] = new("TextLabel", I[7], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(18, 0), Size = UDim2.new(1, -60, 1, 0), Text = "PANEL ADMIN", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("TextButton", I[7], "CloseButton", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(200, 60, 60), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -41, 0, 9), Size = UDim2.fromOffset(32, 32), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[11] = new("UICorner", I[10], "UICorner")
			I[12] = new("TextBox", I[4], "UsernameInput", { BackgroundColor3 = Color3.fromRGB(40, 40, 52), ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(120, 120, 140), PlaceholderText = "Entrez le pseudo...", Position = UDim2.new(0.075, 0, 0, 75), Size = UDim2.new(0.85, 0, 0, 42), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 15 })
				I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
			I[14] = new("TextButton", I[4], "BanButton", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(190, 45, 45), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.075, 0, 0, 135), Size = UDim2.new(0.41, 0, 0, 46), Text = "BAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16 })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
			I[16] = new("TextButton", I[4], "UnbanButton", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(40, 160, 75), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.515, 0, 0, 135), Size = UDim2.new(0.41, 0, 0, 46), Text = "UNBAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16 })
				I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
			I[18] = new("Frame", I[4], "StatusFrame", { BackgroundColor3 = Color3.fromRGB(35, 35, 48), BorderSizePixel = 0, Position = UDim2.new(0.075, 0, 0, 200), Size = UDim2.new(0.85, 0, 0, 55) })
				I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[20] = new("TextLabel", I[18], "StatusLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Text = "En attente d'une action...", TextColor3 = Color3.fromRGB(150, 150, 170), TextSize = 13, TextWrapped = true })
	return I[1]
end

return build
