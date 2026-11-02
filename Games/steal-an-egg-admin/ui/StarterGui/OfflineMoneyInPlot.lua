-- Generated from ui/StarterGui/OfflineMoneyInPlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "OfflineMoneyInPlot", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "T28WL3jVT28W" })
		I[2] = new("Frame", I[1], "TopBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.442939, 0.1222222) }, { ["_lemonadeUniqueId"] = "sTg7rgAAsTg7" })
			I[3] = new("Frame", I[2], "InPlot", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.544516) }, { ["_lemonadeUniqueId"] = "YEDhuMMUYEDh" })
				I[4] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6530411), RichText = true, Size = UDim2.fromScale(1, 1), Text = "You earn <font color = \"#AAAAAA\">$%s</font>/Day offline! 😈", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "vuHhhe2QvuHh" })
					I[5] = new("UIStroke", I[4], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 }, { ["_lemonadeUniqueId"] = "ZJBr3wKqZJBr" })
			I[6] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 6.439394 }, { ["_lemonadeUniqueId"] = "Gm2XBKJbGm2X" })
	return I[1]
end

return build
