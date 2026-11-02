-- Generated from ui/ReplicatedStorage/Assets/Billboards/TeamWinHeader.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TeamWinHeader", { Active = true, MaxDistance = 66.8515701, Size = UDim2.fromScale(59.5460014, 1.4), StudsOffset = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["BillBoardIdentifier"] = "ab5a18f2-c1db-4c5d-8476-3e9f5aa44afa", ["MaxDist"] = 80 })
		I[2] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(1, 0.9), Text = "VICTORY!", TextColor3 = Color3.fromRGB(0, 255, 51), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DataName"] = "Holder_Level_", ["TeamDependent"] = "Level" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.068 })
	return I[1]
end

return build
