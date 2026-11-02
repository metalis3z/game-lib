-- Generated from ui/StarterGui/CountdownGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CountdownGui", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "vI0zWKimvI0z" })
		I[2] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.28), Size = UDim2.fromScale(0.4, 0.13) }, { ["_lemonadeUniqueId"] = "EIh0BePxEIh0" })
			I[3] = new("UIScale", I[2], "Punch", nil, { ["_lemonadeUniqueId"] = "AnxZbxVdAnxZ" })
			I[4] = new("TextLabel", I[2], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 5, 0.5, 5), RichText = true, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextTransparency = 0.5, TextWrapped = true }, { ["_lemonadeUniqueId"] = "iAkGaYdxiAkG" })
			I[5] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "vk6GcE1Xvk6G" })
				I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.09 }, { ["_lemonadeUniqueId"] = "vkCfVTnrvkCf" })
	return I[1]
end

return build
