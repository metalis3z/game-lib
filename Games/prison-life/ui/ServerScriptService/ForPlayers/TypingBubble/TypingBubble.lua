-- Generated from ui/ServerScriptService/ForPlayers/TypingBubble/TypingBubble.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TypingBubble", { Active = true, ClipsDescendants = true, Enabled = false, ExtentsOffsetWorldSpace = Vector3.new(0, 4, 0), MaxDistance = math.huge, Size = UDim2.fromScale(2, 2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "TypingBubble", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5127647902"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(0.1, 0.1, 0.1, 1) })
	return I[1]
end

return build
