-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/DialogController/rowTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "rowTemplate", { BackgroundColor3 = Color3.fromRGB(29, 29, 31), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.1759259) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
		I[3] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Transparency = 0.5 })
		I[4] = new("Frame", I[1], "content", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[5] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.018, 0), PaddingRight = UDim.new(0.018, 0), PaddingTop = UDim.new(0.1, 0) })
			I[6] = new("UIListLayout", I[4], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[7] = new("TextLabel", I[4], "label", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.44), TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[8] = new("TextLabel", I[4], "description", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.28), Text = "Description", TextColor3 = Color3.fromRGB(213, 215, 221), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[9] = new("TextButton", I[1], "clickTarget", { AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 10 }, nil, { "UIEffectSoundOnly" })
	return I[1]
end

return build
