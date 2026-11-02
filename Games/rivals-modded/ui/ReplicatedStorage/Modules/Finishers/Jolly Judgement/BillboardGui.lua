-- Generated from ui/ReplicatedStorage/Modules/Finishers/Jolly Judgement/BillboardGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "BillboardGui", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, ExtentsOffset = Vector3.new(0, 3, 0), MaxDistance = 400, ResetOnSpawn = false, Size = UDim2.new(15, 250, 15, 250), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.075), Text = "NAUGHTY.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(31, 31, 31), Thickness = 2 })
	return I[1]
end

return build
