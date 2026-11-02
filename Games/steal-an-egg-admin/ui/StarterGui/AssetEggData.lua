-- Generated from ui/StarterGui/AssetEggData.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AssetEggData", { DisplayOrder = -1000, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "e7d8h4RDe7d8", ["bruh"] = true })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 0.1), Visible = false }, { ["_lemonadeUniqueId"] = "KBWuVV5tKBWu" })
			I[3] = new("CanvasGroup", I[2], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.4, 2.5) }, { ["_lemonadeUniqueId"] = "jVQLwDVBjVQL" })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.055, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, VerticalFlex = Enum.UIFlexAlignment.Fill }, { ["_lemonadeUniqueId"] = "TETbHxNpTETb" })
				I[5] = new("TextLabel", I[3], "DisplayName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.7), Text = "Common Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "vlE8PYnnvlE8" })
					I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.8460648 }, { ["_lemonadeUniqueId"] = "2RLG4N9x2RLG", ["oldp_Thickness"] = 2.5 })
				I[7] = new("TextLabel", I[3], "RemainingHatchTime", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0049188, 0.4094478), Size = UDim2.fromScale(1, 0.7), Text = "Ready!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "U89LhoNPU89L" })
					I[8] = new("UIStroke", I[7], "UIStroke1", { Thickness = 1.8460648 }, { ["_lemonadeUniqueId"] = "cEHye6o8cEHy", ["oldp_Thickness"] = 2.5 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 3 }, { ["_lemonadeUniqueId"] = "vgsfWyg4vgsf" })
	return I[1]
end

return build
