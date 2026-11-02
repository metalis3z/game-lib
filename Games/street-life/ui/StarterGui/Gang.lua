-- Generated from ui/StarterGui/Gang.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Gang", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "Interact", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(100, 100, 100), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0452279, 0.2248713), RichText = true, Size = UDim2.fromScale(0.0715206, 0.0372208), Text = "GANG", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.275, 0), BottomRightRadius = UDim.new(0.275, 0), TopLeftRadius = UDim.new(0.275, 0), TopRightRadius = UDim.new(0.275, 0) })
			I[4] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
		I[5] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(150, 150, 150), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4993557, 0.5074443), Size = UDim2.fromScale(0.193299, 0.3101737), Visible = false })
			I[6] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
			I[7] = new("UICorner", I[5], "UICorner")
			I[8] = new("TextLabel", I[5], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1802845), Text = "SELECT GANG", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2 })
			I[10] = new("TextButton", I[5], "Apply", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5003602, 0.8201674), RichText = true, Size = UDim2.fromScale(0.8340542, 0.1632961), Text = "APPLY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[11] = new("UICorner", I[10], "UICorner")
				I[12] = new("UIStroke", I[10], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
			I[13] = new("TextBox", I[5], "Group", { BackgroundColor3 = Color3.fromRGB(200, 200, 200), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(226, 226, 226), PlaceholderText = "GROUP ID", Position = UDim2.fromScale(0.0866665, 0.512), Size = UDim2.fromScale(0.8333333, 0.16), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[15] = new("UICorner", I[13], "UICorner")
			I[16] = new("TextLabel", I[5], "Current", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0866665, 0.18), Size = UDim2.fromScale(0.8366666, 0.1002844), Text = "CURRENT GROUP: NONE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 1.5 })
			I[18] = new("TextLabel", I[5], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0866665, 0.28), Size = UDim2.fromScale(0.8366666, 0.0922844), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.5 })
		I[20] = new("Sound", I[1], "Press", { Volume = 0.8 })
		I[21] = new("Sound", I[1], "Error", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
	return I[1]
end

return build
