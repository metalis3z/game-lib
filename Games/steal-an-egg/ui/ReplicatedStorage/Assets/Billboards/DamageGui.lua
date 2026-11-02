-- Generated from ui/ReplicatedStorage/Assets/Billboards/DamageGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "DamageGui", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, ExtentsOffset = Vector3.new(0, 3, 0), MaxDistance = 400, ResetOnSpawn = false, Size = UDim2.fromScale(30, 30), StudsOffset = Vector3.new(-1, 1.5, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Value", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.075), Text = "40", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
			I[3] = new("UIGradient", I[2], "Critical", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.5190312, Color3.fromRGB(255, 108, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 157, 0)) }), Enabled = false, Rotation = -44 })
			I[4] = new("UIGradient", I[2], "Normal", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 158, 160)), ColorSequenceKeypoint.new(0.5951557, Color3.fromRGB(250, 10, 14)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 0, 1)) }), Rotation = -44 })
	return I[1]
end

return build
