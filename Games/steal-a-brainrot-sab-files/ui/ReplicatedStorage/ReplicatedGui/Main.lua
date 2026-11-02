-- Generated from ui/ReplicatedStorage/ReplicatedGui/Main.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Main", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "h2mMX93Th2mM" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Tutorial", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 99, Position = UDim2.new(0.5, 0, 0, 58), Size = UDim2.fromScale(1, 0.1) }, { ["_lemonadeUniqueId"] = "SR2W0sY0SR2W" })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 0.6), Text = "Go buy a Noobini Pizzanini", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["_lemonadeUniqueId"] = "K7yHOQ0gK7yH" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "t4js63bVt4js" }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
