-- Generated from ui/ReplicatedStorage/Assets/Extra/GunBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "GunBillboard", { Active = true, AlwaysOnTop = true, MaxDistance = 1000000, ResetOnSpawn = false, Size = UDim2.fromScale(15, 6), StudsOffset = Vector3.new(0, 4, 0) })
		I[2] = new("TextLabel", I[1], "Weapon", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "GUN!", TextColor3 = Color3.fromRGB(34, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2, Transparency = 0.35 })
	return I[1]
end

return build
