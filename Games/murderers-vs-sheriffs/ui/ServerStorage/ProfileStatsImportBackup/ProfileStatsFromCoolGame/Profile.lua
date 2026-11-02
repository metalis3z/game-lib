-- Generated from ui/ServerStorage/ProfileStatsImportBackup/ProfileStatsFromCoolGame/Profile.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Profile", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, Size = UDim2.new(0.2, 0, 0, 50) })
		I[2] = new("TextButton", I[1], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 3 })
		I[3] = new("Frame", I[1], "ViewBorder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[4] = new("Frame", I[3], "LeftBorder", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 3, 0, 3) })
			I[5] = new("Frame", I[3], "LeftBorder", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 3, 1, 0) })
			I[6] = new("Frame", I[3], "LeftBorder", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, 0), ZIndex = 2 })
			I[7] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, Position = UDim2.new(0, 3, 1, -3), Size = UDim2.new(1, -3, 0, 3), ZIndex = 2 })
		I[8] = new("Frame", I[1], "DontView", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[9] = new("Frame", I[8], "LeftBorder", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, -3) })
			I[10] = new("Frame", I[8], "LeftBorder", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 3) })
			I[11] = new("Frame", I[8], "LeftBorder", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 3, 1, -3) })
		I[12] = new("TextLabel", I[1], "TabName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.55), Text = "Profile", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextWrapped = true })
	return I[1]
end

return build
