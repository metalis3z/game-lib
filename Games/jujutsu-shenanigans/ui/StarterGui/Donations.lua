-- Generated from ui/StarterGui/Donations.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "Donations", { ClipsDescendants = true, PixelsPerStud = 100, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud })
		I[2] = new("TextButton", I[1], "Big", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromOffset(200, 30), Text = " 1,000", TextColor3 = Color3.fromRGB(70, 70, 70), TextSize = 30 })
			I[3] = new("UICorner", I[2], "UICorner")
		I[4] = new("TextButton", I[1], "Huge", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 4, Size = UDim2.fromOffset(200, 30), Text = " 100,000", TextColor3 = Color3.fromRGB(70, 70, 70), TextSize = 30 })
			I[5] = new("UICorner", I[4], "UICorner")
		I[6] = new("TextButton", I[1], "Mega", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 5, Size = UDim2.fromOffset(200, 30), Text = " 1,000,000", TextColor3 = Color3.fromRGB(70, 70, 70), TextSize = 30 })
			I[7] = new("UICorner", I[6], "UICorner")
		I[8] = new("TextButton", I[1], "Normal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromOffset(200, 30), Text = " 100", TextColor3 = Color3.fromRGB(70, 70, 70), TextSize = 30 })
			I[9] = new("UICorner", I[8], "UICorner")
		I[10] = new("TextButton", I[1], "Small", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromOffset(200, 30), Text = " 10", TextColor3 = Color3.fromRGB(70, 70, 70), TextSize = 30 })
			I[11] = new("UICorner", I[10], "UICorner")
		I[12] = new("TextButton", I[1], "VeryBig", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Size = UDim2.fromOffset(200, 30), Text = " 10,000", TextColor3 = Color3.fromRGB(70, 70, 70), TextSize = 30 })
			I[13] = new("UICorner", I[12], "UICorner")
		I[14] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.009, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
	return I[1]
end

return build
