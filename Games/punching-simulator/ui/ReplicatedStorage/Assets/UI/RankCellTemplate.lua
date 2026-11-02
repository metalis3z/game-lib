-- Generated from ui/ReplicatedStorage/Assets/UI/RankCellTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "RankCellTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.125) })
		I[2] = new("ImageLabel", I[1], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(128, 255, 82), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 171, 221), ImageContent = Content.fromUri("rbxassetid://9857249030"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX, SliceCenter = Rect.new(22, 47, 429, 62) })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.5), Text = "Noob - 0 Rebirths", TextColor3 = Color3.fromRGB(249, 249, 249), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(58, 58, 58), Thickness = 1.5 })
	return I[1]
end

return build
