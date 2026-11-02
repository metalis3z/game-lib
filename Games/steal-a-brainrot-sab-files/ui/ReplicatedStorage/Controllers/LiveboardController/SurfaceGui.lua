-- Generated from ui/ReplicatedStorage/Controllers/LiveboardController/SurfaceGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "SurfaceGui", { ClipsDescendants = true, Face = Enum.NormalId.Back, LightInfluence = 1, MaxDistance = 1000, PixelsPerStud = 25, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "KVkUQHzRKVkU" })
		I[2] = new("ScrollingFrame", I[1], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 1), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.95), ScrollBarThickness = 0, Size = UDim2.fromScale(0.95, 0.765) }, { ["_lemonadeUniqueId"] = "c0YZ6urxc0YZ" })
			I[3] = new("Frame", I[2], "GlobalTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0032051), Size = UDim2.fromScale(1, 0.275), Visible = false }, { ["_lemonadeUniqueId"] = "adg5TwY0adg5" })
				I[4] = new("Frame", I[3], "Filler", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(35, 45, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, -3, 0.95, 0) }, { ["_lemonadeUniqueId"] = "UJ8WPFmqUJ8W" })
					I[5] = new("UIStroke", I[4], "UIStroke", nil, { ["_lemonadeUniqueId"] = "eg8D3Icqeg8D" })
					I[6] = new("ImageLabel", I[4], "PlayerBg", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.966, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1244058, 0.537929), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "TLJEmc6OTLJE" })
						I[7] = new("ImageLabel", I[6], "Headshot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=47528603&w=100&h=100"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "Q5U8XZqSQ5U8" })
						I[8] = new("UIStroke", I[6], "UIStroke", nil, { ["_lemonadeUniqueId"] = "AJ2MKvMsAJ2M" })
						I[9] = new("TextLabel", I[6], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, -0.2), Size = UDim2.fromScale(1.45, 0.3), Text = "Claimed By", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "qv7E3RW4qv7E" })
							I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "A1g0IjWyA1g0" })
					I[11] = new("TextLabel", I[4], "Location", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.4043605, 0.7572966), Size = UDim2.fromScale(0.402945, 0.1639466), Text = "[GLOBAL]", TextColor3 = Color3.fromRGB(86, 211, 74), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "L5QYUzTfL5QY" })
						I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "MmrKTX8aMmrK" })
					I[13] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.2983033), Size = UDim2.fromScale(0.5671282, 0.2489627), Text = "Lucky Sammy Block", TextColor3 = Color3.fromRGB(255, 55, 55), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "KsnE7UC0KsnE" })
						I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "JGZ1RwMcJGZ1" })
					I[15] = new("ImageLabel", I[4], "BrainrotBg", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.0199999, 0.4829202), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1585106, 0.7147412), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "MHKkNkWOMHKk" })
						I[16] = new("ImageLabel", I[15], "Img", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://133401360483558"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "TKYCWDPTTKYC" })
						I[17] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) }, { ["_lemonadeUniqueId"] = "9Tzau7G69Tza" })
					I[18] = new("Frame", I[4], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.075) }, { ["_lemonadeUniqueId"] = "6J7xjWGs6J7x" })
						I[19] = new("Frame", I[18], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(36, 217, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.75, 1) }, { ["_lemonadeUniqueId"] = "2rqrXNbH2rqr" })
					I[20] = new("TextLabel", I[4], "Spawned", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.5456194), Size = UDim2.fromScale(0.567, 0.225), Text = "Spawned 43s ago", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "luJ8DnBrluJ8" })
						I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "OlNEPwlPOlNE" })
			I[22] = new("UIListLayout", I[2], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "itT0KQn3itT0" })
			I[23] = new("Frame", I[2], "ServerTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0032051), Size = UDim2.fromScale(1, 0.275), Visible = false }, { ["_lemonadeUniqueId"] = "D7qZ7X9rD7qZ" })
				I[24] = new("Frame", I[23], "Filler", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(35, 45, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, -3, 0.95, 0) }, { ["_lemonadeUniqueId"] = "WYzubExzWYzu" })
					I[25] = new("UIStroke", I[24], "UIStroke", nil, { ["_lemonadeUniqueId"] = "niKDCRgqniKD" })
					I[26] = new("ImageLabel", I[24], "PlayerBg", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.966, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1244058, 0.537929), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "KKazKsr9KKaz" })
						I[27] = new("ImageLabel", I[26], "Headshot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "3nXSEdEO3nXS" })
						I[28] = new("UIStroke", I[26], "UIStroke", nil, { ["_lemonadeUniqueId"] = "tOwAjjSotOwA" })
						I[29] = new("TextLabel", I[26], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, -0.2), Size = UDim2.fromScale(1.45, 0.3), Text = "UNCLAIMED", TextColor3 = Color3.fromRGB(255, 61, 61), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "x70nCwv9x70n" })
							I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "QyqJYaT5QyqJ" })
					I[31] = new("TextLabel", I[24], "Location", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.4043605, 0.7572966), Size = UDim2.fromScale(0.402945, 0.1639466), Text = "[SERVER]", TextColor3 = Color3.fromRGB(211, 68, 68), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "eWLiirtTeWLi" })
						I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "5oMuxxpx5oMu" })
					I[33] = new("TextLabel", I[24], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.2983033), Size = UDim2.fromScale(0.5671282, 0.2489627), Text = "Strawberry Elephant", TextColor3 = Color3.fromRGB(64, 172, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "LpySGx04LpyS" })
						I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "NNIu9ooENNIu" })
					I[35] = new("ImageLabel", I[24], "BrainrotBg", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.0199999, 0.4829202), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1585106, 0.7147412), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "Y9NIzD6gY9NI" })
						I[36] = new("ImageLabel", I[35], "Img", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100107772563289"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "UgKUvNlJUgKU" })
						I[37] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) }, { ["_lemonadeUniqueId"] = "jQ0bJ3wAjQ0b" })
					I[38] = new("Frame", I[24], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.075) }, { ["_lemonadeUniqueId"] = "l6fWIV4Il6fW" })
						I[39] = new("Frame", I[38], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(36, 217, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.3, 1) }, { ["_lemonadeUniqueId"] = "y1Izswj7y1Iz" })
					I[40] = new("TextLabel", I[24], "Spawned", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.5456194), Size = UDim2.fromScale(0.567, 0.225), Text = "Spawned 30s ago", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "x1hwHxhxx1hw" })
						I[41] = new("UIStroke", I[40], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "QBDct4SgQBDc" })
		I[42] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.025), Size = UDim2.fromScale(1, 0.125), Text = "LIVE SPAWNS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "JWmLLpJrJWmL" })
	return I[1]
end

return build
