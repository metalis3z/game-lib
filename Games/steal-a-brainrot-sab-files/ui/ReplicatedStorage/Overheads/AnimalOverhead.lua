-- Generated from ui/ReplicatedStorage/Overheads/AnimalOverhead.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "AnimalOverhead", { Active = true, AutoLocalize = false, ClipsDescendants = true, MaxDistance = 60, Size = UDim2.fromScale(15, 5), StudsOffset = Vector3.new(0, 2.5, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "INIXMKRjINIX" }, { "AnimalOverhead" })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "CgpeyM7TCgpe" })
		I[3] = new("TextLabel", I[1], "Mutation", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "Gold", TextColor3 = Color3.fromRGB(255, 222, 89), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "7Lw2wjie7Lw2" })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 4, Transparency = 0.35 }, { ["_lemonadeUniqueId"] = "2HXyFJRN2HXy" })
		I[5] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "Rarity", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "FD69XseIFD69" })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 4, Transparency = 0.35 }, { ["_lemonadeUniqueId"] = "8EH8Ztjj8EH8" })
		I[7] = new("TextLabel", I[1], "Generation", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "$0/s", TextColor3 = Color3.fromRGB(255, 247, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "o2fcR9dxo2fc" })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 4, Transparency = 0.35 }, { ["_lemonadeUniqueId"] = "JZWfZ5DlJZWf" })
		I[9] = new("TextLabel", I[1], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "$500", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "owjteM2wowjt" })
			I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 4, Transparency = 0.35 }, { ["_lemonadeUniqueId"] = "bBoBINTnbBoB" })
		I[11] = new("TextLabel", I[1], "Stolen", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "STOLEN", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["_lemonadeUniqueId"] = "ShJmdfkkShJm" })
			I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 4, Transparency = 0.35 }, { ["_lemonadeUniqueId"] = "jX9NhzsOjX9N" })
		I[13] = new("TextLabel", I[1], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "{DisplayName}", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "tJ0ZSucetJ0Z" })
			I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 4, Transparency = 0.35 }, { ["_lemonadeUniqueId"] = "QVC4FJdXQVC4" })
		I[15] = new("Frame", I[1], "Traits", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.2), Visible = false }, { ["_lemonadeUniqueId"] = "LJk4KpcELJk4" })
			I[16] = new("UIListLayout", I[15], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "UgxACaKmUgxA" })
			I[17] = new("ImageLabel", I[15], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110835412437000"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false }, { ["_lemonadeUniqueId"] = "UJtkS13bUJtk" })
	return I[1]
end

return build
