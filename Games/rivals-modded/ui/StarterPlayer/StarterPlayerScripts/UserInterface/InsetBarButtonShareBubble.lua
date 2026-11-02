-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/InsetBarButtonShareBubble.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "InsetBarButtonShareBubble", { AnchorPoint = Vector2.new(0.325, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.99), Rotation = 0.001, Size = UDim2.fromScale(15, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[2] = new("TextLabel", I[1], "ExportTitle", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.65, 0.775), Size = UDim2.fromScale(0.5, 0.15), Text = "Share your layout by copying this: ", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
		I[3] = new("TextBox", I[1], "Export", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.65, 0.775), Size = UDim2.fromScale(0.075, 0.375), Text = "||\\/10,+//0,Z9!mnhshrnO!+\\/4+/4Z9!dyhR!z9!swdmohtpd^dkhanl!+|\\/4,+/70,Z9!mnhshrnO!+\\/2+/2Z9!dyhR!z9!uno`qdl`bgbshvr^dkhanl!+|\\/80,+/10,Z9!mnhshrnO!+\\/6+/6Z9!dyhR!z9!lh`^dkhanl!+|\\410,+/80,Z9!mnhshrnO!+\\//0+//0Z9!dyhR!z9!snngr^dkhanl!+|\\/20,+/3,Z9!mnhshrnO!+\\/4+/4Z9!dyhR!z9!gbtnqb^dkhanl!+|\\44,+/5,Z9!mnhshrnO!+\\/6+/6Z9!dyhR!z9!olti^dkhanl!+|\\/5,+/20,Z9!mnhshrnO!+\\/4+/4Z9!dyhR!z9!c`nkdq^dkhanl!+|\\/80,+/4,Z9!mnhshrnO!+\\/4+/4Z9!dyhR!z9!sbdormh^dkhanl!z", TextColor3 = Color3.fromRGB(0, 0, 0), TextEditable = false, TextSize = 3, TextWrapped = true })
		I[4] = new("ImageButton", I[1], "BackgroundButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
		I[5] = new("ImageButton", I[1], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(100, 100), ZIndex = -2 })
		I[6] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 })
			I[7] = new("ImageLabel", I[6], "Arrow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.new(0.325, 0, 0, 2), Rotation = 45, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.06, 0.06), SizeConstraint = Enum.SizeConstraint.RelativeYY, SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.125, ZIndex = -3 })
		I[8] = new("Frame", I[1], "Import", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.375), Size = UDim2.fromScale(0.925, 0.375) })
			I[9] = new("ImageLabel", I[8], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(18, 18, 21), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 })
			I[10] = new("TextBox", I[8], "Box", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(247, 247, 248), PlaceholderText = "Paste someone else's layout here", Position = UDim2.fromScale(0.025, 0.5), Size = UDim2.fromScale(0.65, 0.5), Text = "", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[11] = new("ImageButton", I[8], "Button", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.2, 1) })
				I[12] = new("ImageLabel", I[11], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
				I[13] = new("TextLabel", I[11], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.55), Text = "Import", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
