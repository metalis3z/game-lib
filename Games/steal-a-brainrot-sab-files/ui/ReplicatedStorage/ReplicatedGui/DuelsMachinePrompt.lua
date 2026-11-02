-- Generated from ui/ReplicatedStorage/ReplicatedGui/DuelsMachinePrompt.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DuelsMachinePrompt", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "4lEtT8uY4lEt" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "DuelsMachinePrompt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.99, 0.98) }, { ["_lemonadeUniqueId"] = "zKw0dNeyzKw0" })
			I[3] = new("ImageLabel", I[2], "InviteTemplate", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1698942, 0.1375656), SliceCenter = Rect.new(485, 14, 485, 75), Visible = false }, { ["_lemonadeUniqueId"] = "7Gqp7FW07Gqp" })
				I[4] = new("TextLabel", I[3], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.3916417, 0.1523007), Size = UDim2.fromScale(0.6999999, 0.2144083), Text = "Invite", TextColor3 = Color3.fromRGB(115, 223, 120), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "b68isVeKb68i" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "SzsgjWicSzsg" }, { "ScreenStroke", "UIStroke" })
				I[6] = new("TextLabel", I[3], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.507, 0.45), Size = UDim2.fromScale(0.9297194, 0.3222941), Text = "Onlytwentycharacters invited you to a Duel!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "QI1OnjQwQI1O" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "rjwZ4J2OrjwZ" }, { "ScreenStroke", "UIStroke" })
				I[8] = new("ImageButton", I[3], "Yes", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.04, 0.933), Size = UDim2.fromScale(0.4394761, 0.2736073) }, { ["_lemonadeUniqueId"] = "zshMxP1jzshM" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "rfruU5XFrfru" }, { "ScreenStroke", "UIStroke" })
					I[10] = new("TextLabel", I[8], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "UUwlp03FUUwl" })
						I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "w3T4okhZw3T4" }, { "ScreenStroke", "UIStroke" })
				I[12] = new("ImageButton", I[3], "No", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(233, 66, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.96, 0.933), Size = UDim2.fromScale(0.4394762, 0.2736073) }, { ["_lemonadeUniqueId"] = "ksBxm7umksBx" })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "tRspfeZ3tRsp" }, { "ScreenStroke", "UIStroke" })
					I[14] = new("TextLabel", I[12], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Decline", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "WzCkXb1FWzCk" })
						I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "xSjW6zHXxSjW" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("UIStroke", I[3], "UIStroke", { Thickness = 0.5546296 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "peC2nqPvpeC2" }, { "ScreenStroke", "UIStroke" })
				I[17] = new("Frame", I[3], "Fill", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.025) }, { ["_lemonadeUniqueId"] = "7qlbpUyO7qlb" })
				I[18] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.5 }, { ["_lemonadeUniqueId"] = "8rZAtGvn8rZA" })
	return I[1]
end

return build
