-- Generated from ui/ReplicatedStorage/Assets/Skins/Killers/c00lkidd/#LoreAccurateC00l/Config/c00lgui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "c00lgui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0643522, 0.6504116), Size = UDim2.fromScale(0.3666385, 0.3208333), Visible = false })
			I[3] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 4) })
			I[4] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.2), Size = UDim2.fromScale(1, 0.2), Text = "c00lgui", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
			I[6] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[7] = new("UIStroke", I[6], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 4) })
				I[8] = new("TextButton", I[6], "Sky", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.022082, 0.0283224), Size = UDim2.fromScale(0.3, 0.11), Text = "Set Skybox", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[9] = new("UIStroke", I[8], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
				I[10] = new("TextButton", I[6], "Decals", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3722397, 0.1851852), Size = UDim2.fromScale(0.3, 0.11), Text = "Decal Spam", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[11] = new("UIStroke", I[10], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
				I[12] = new("TextButton", I[6], "Buffs", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.022082, 0.4901961), Size = UDim2.fromScale(0.3, 0.11), Text = "Buffs", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[13] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
				I[14] = new("TextButton", I[6], "KillAll", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3722397, 0.4901961), Size = UDim2.fromScale(0.3, 0.11), Text = "Kill All", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[15] = new("UIStroke", I[14], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
				I[16] = new("UIGridLayout", I[6], "UIGridLayout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(0.33333, 0.2), SortOrder = Enum.SortOrder.LayoutOrder })
				I[17] = new("TextButton", I[6], "SendMessage", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3722397, 0.4901961), Size = UDim2.fromScale(0.3, 0.11), Text = "Send Message", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[18] = new("UIStroke", I[17], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
				I[19] = new("TextButton", I[6], "FireAll", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3722397, 0.4901961), Size = UDim2.fromScale(0.3, 0.11), Text = "Spam Fire", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[20] = new("UIStroke", I[19], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
				I[21] = new("TextButton", I[6], "Spooky", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3722397, 0.4901961), Size = UDim2.fromScale(0.3, 0.11), Text = "Set Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[22] = new("UIStroke", I[21], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
				I[23] = new("TextButton", I[6], "HighlightAll", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3722397, 0.4901961), Size = UDim2.fromScale(0.3, 0.11), Text = "ESP", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[24] = new("UIStroke", I[23], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0) })
		I[25] = new("TextButton", I[1], "Open / Close", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7207302), Size = UDim2.fromOffset(65, 50), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[26] = new("UIStroke", I[25], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 4) })
	return I[1]
end

return build
