-- Generated from ui/ReplicatedStorage/Assets/SellBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "SellBillboard", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, Enabled = false, LightInfluence = 1, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(7, 2.5), StudsOffset = Vector3.new(5, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[3] = new("TextButton", I[1], "SellOne", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, nil, { "UIButton" })
			I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8, 255, 12)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.20625), NumberSequenceKeypoint.new(1, 1) }) })
			I[5] = new("TextLabel", I[3], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "1. \"I want to Sell This Brainrot\"", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
			I[7] = new("UIScale", I[3], "UIScale")
		I[8] = new("TextButton", I[1], "SellAll", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, { ["NeedConfirmation"] = true }, { "UIButton" })
			I[9] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.20625), NumberSequenceKeypoint.new(1, 1) }) })
			I[10] = new("TextLabel", I[8], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "2. \"I wanna Sell Everything\"", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 2 })
			I[12] = new("UIScale", I[8], "UIScale")
		I[13] = new("TextButton", I[1], "Worth", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 3, Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, nil, { "UIButton" })
			I[14] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 191, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.20625), NumberSequenceKeypoint.new(1, 1) }) })
			I[15] = new("TextLabel", I[13], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "3. \"What is This Brainrot Worth\"", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2 })
			I[17] = new("UIScale", I[13], "UIScale")
		I[18] = new("TextButton", I[1], "Nothing", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, nil, { "UIButton" })
			I[19] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.20625), NumberSequenceKeypoint.new(1, 1) }) })
			I[20] = new("TextLabel", I[18], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "4. \"Byeeeeeeeeeeeeeeeeeee!\"", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 })
			I[22] = new("UIScale", I[18], "UIScale")
	return I[1]
end

return build
