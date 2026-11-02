-- Generated from ui/ReplicatedStorage/PlayersListPlus/Assets/SelectedButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "SelectedButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Selectable = false, Size = UDim2.fromScale(1, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "", ZIndex = 1000 })
		I[2] = new("TextLabel", I[1], "ActionName", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.25, 0.5), Size = UDim2.fromScale(0, 1), Text = "Ban", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[3] = new("UITextSizeConstraint", I[2], "UITextSizeConstraint", { MaxTextSize = 30, MinTextSize = 5 })
		I[4] = new("ImageLabel", I[1], "ActionIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17440779476"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.6, 0.6) })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
		I[6] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.075, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[7] = new("UIPadding", I[1], "UIPadding", { PaddingLeft = UDim.new(0, 15) })
	return I[1]
end

return build
