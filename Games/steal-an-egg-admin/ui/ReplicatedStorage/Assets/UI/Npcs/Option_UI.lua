-- Generated from ui/ReplicatedStorage/Assets/UI/Npcs/Option_UI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Option_UI", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.9, 0.15) }, { ["_lemonadeUniqueId"] = "3OPYe8JF3OPY" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "sp3PlEnZsp3P" })
			I[3] = new("ImageButton", I[2], "ImageButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "qFkyI8BXqFky" })
			I[4] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://122978741620600"), ImageTransparency = 0.6, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.75, 1) }, { ["_lemonadeUniqueId"] = "4KFf6Tuc4KFf" })
				I[5] = new("UIGradient", I[4], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(0.0981, 0), NumberSequenceKeypoint.new(0.899, 0), NumberSequenceKeypoint.new(1, 0.7) }) }, { ["_lemonadeUniqueId"] = "Vgyqby1jVgyq" })
			I[6] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 1) }, { ["_lemonadeUniqueId"] = "YSPacFFdYSPa" })
				I[7] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.07, 1), Text = "#1", TextColor3 = Color3.fromRGB(0, 255, 21), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "AFl8aUckAFl8" })
				I[8] = new("TextLabel", I[6], "Text_Element", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0, 0.5), RichText = true, Size = UDim2.fromScale(1, 1), Text = "[\"Yo whats up\"]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "54Ba5HH154Ba" })
					I[9] = new("UIPadding", I[8], "UIPadding", { PaddingLeft = UDim.new(0.05, 0) }, { ["_lemonadeUniqueId"] = "hLjvsnqkhLjv" })
				I[10] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.003, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "EZxXndAMEZxX" })
	return I[1]
end

return build
