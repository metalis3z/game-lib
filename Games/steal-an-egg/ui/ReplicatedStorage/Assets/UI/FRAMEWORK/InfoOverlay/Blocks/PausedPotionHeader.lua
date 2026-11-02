-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/PausedPotionHeader.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PausedPotionHeader", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 20, Size = UDim2.new(1, 0, 0, 35) })
		I[2] = new("TextLabel", I[1], "title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Queued", TextColor3 = Color3.fromRGB(56, 56, 56), TextSize = 25, TextWrapped = true })
		I[3] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(65, 150) })
	return I[1]
end

return build
