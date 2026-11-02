-- Generated from ui/StarterGui/Special.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Special", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "PayoffBounty", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(80, 80, 80), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.5, -2), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.22, 0.25), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.6, ZIndex = 25 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.8 })
			I[4] = new("ImageButton", I[2], "Yes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(92, 185, 0), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.28, 0.84), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.42, 0.18), SliceCenter = Rect.new(100, 100, 100, 100), ZIndex = 26 })
				I[5] = new("TextLabel", I[4], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.15), Size = UDim2.fromScale(0.7, 0.7), Text = "Yes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 27 })
			I[6] = new("ImageButton", I[2], "No", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(186, 0, 0), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.72, 0.84), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.42, 0.18), SliceCenter = Rect.new(100, 100, 100, 100), ZIndex = 26 })
				I[7] = new("TextLabel", I[6], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.15), Size = UDim2.fromScale(0.7, 0.7), Text = "No", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 27 })
			I[8] = new("TextLabel", I[2], "Price", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.56), Size = UDim2.fromScale(0.8, 0.16), Text = "$000,000", TextColor3 = Color3.fromRGB(255, 170, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
			I[9] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.05), Size = UDim2.fromScale(0.8, 0.18), Text = "Are you sure?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
			I[10] = new("TextLabel", I[2], "Description", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.22), Size = UDim2.fromScale(0.9, 0.33), Text = "Are you sure you would like to pay off your bounty for:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
		I[11] = new("ImageLabel", I[1], "BailPromt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(80, 80, 80), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.5, -2), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.22, 0.25), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.6, ZIndex = 25 })
			I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 1.79 })
			I[13] = new("ImageButton", I[11], "No", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(186, 0, 0), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.72, 0.84), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.42, 0.18), SliceCenter = Rect.new(100, 100, 100, 100), ZIndex = 26 })
				I[14] = new("TextLabel", I[13], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.15), Size = UDim2.fromScale(0.7, 0.7), Text = "No", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 27 })
			I[15] = new("ImageButton", I[11], "Yes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(92, 185, 0), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.28, 0.84), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.42, 0.18), SliceCenter = Rect.new(100, 100, 100, 100), ZIndex = 26 })
				I[16] = new("TextLabel", I[15], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.15), Size = UDim2.fromScale(0.7, 0.7), Text = "Yes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 27 })
			I[17] = new("TextLabel", I[11], "Price", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.56), Size = UDim2.fromScale(0.8, 0.16), Text = "$000,000", TextColor3 = Color3.fromRGB(255, 170, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
			I[18] = new("TextLabel", I[11], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.05), Size = UDim2.fromScale(0.8, 0.18), Text = "Are you sure?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
			I[19] = new("TextLabel", I[11], "Description", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.22), Size = UDim2.fromScale(0.9, 0.33), Text = "Click yes to bail out for the amount labeled below. Click no to close this prompt and cancel the bail.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
		I[20] = new("ImageLabel", I[1], "Jail", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(80, 80, 80), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(1, 0.65), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.15, 0.18), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.6, Visible = false, ZIndex = 25 })
			I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 1.6799999 })
			I[22] = new("ImageButton", I[20], "BailOut", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(92, 185, 0), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.5, 0.79), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.8, 0.25), SliceCenter = Rect.new(100, 100, 100, 100), ZIndex = 26 })
				I[23] = new("TextLabel", I[22], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.15), Size = UDim2.fromScale(0.7, 0.7), Text = "Bail Out", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 27 })
			I[24] = new("TextLabel", I[20], "TimeLeft", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.15), Size = UDim2.fromScale(0.8, 0.3), Text = "Time Left: 60", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
		I[25] = new("ImageLabel", I[1], "RadarGun", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(80, 80, 80), ImageContent = Content.fromUri("rbxassetid://8285754921"), Position = UDim2.fromScale(0.06, 0.78), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.15, 0.18), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.6, Visible = false, ZIndex = 25 })
			I[26] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint", { AspectRatio = 1.7 })
			I[27] = new("TextLabel", I[25], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.12), Size = UDim2.fromScale(0.8, 0.35), Text = "Click a vehicle to get its speed.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
			I[28] = new("TextLabel", I[25], "Speed", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.54), Size = UDim2.fromScale(0.8, 0.35), Text = "0 MPH", TextColor3 = Color3.fromRGB(0, 153, 230), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 26 })
				I[29] = new("ObjectValue", I[28], "Object")
	return I[1]
end

return build
