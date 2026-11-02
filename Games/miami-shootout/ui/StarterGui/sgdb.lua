-- Generated from ui/StarterGui/sgdb.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "sgdb", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.3348666, 0), Size = UDim2.fromScale(0.3164673, 0.345776) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1404959), Text = "Gun spawner cooldown: 180 seconds", TextColor3 = Color3.fromRGB(220, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(11, 11, 11), TextStrokeTransparency = 0.2, TextWrapped = true, Visible = false })
			I[4] = new("UIListLayout", I[2], "UIListLayout", { Padding = UDim.new(-0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
