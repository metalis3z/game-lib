-- Generated from ui/ReplicatedStorage/Assets/Billboards/CashCollect.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "CashCollect", { Brightness = 2, Face = Enum.NormalId.Right, MaxDistance = 1000, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 4 })
			I[5] = new("TextLabel", I[2], "Money", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Rotation = -90, Size = UDim2.fromScale(1.5, 0.53), Text = "$0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 })
				I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
	return I[1]
end

return build
