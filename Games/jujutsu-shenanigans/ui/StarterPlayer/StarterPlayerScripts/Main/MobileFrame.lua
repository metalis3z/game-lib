-- Generated from ui/StarterPlayer/StarterPlayerScripts/Main/MobileFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "MobileFrame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1.5) })
		I[2] = new("ImageButton", I[1], "DashButton", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12252434969"), LayoutOrder = 2, Position = UDim2.new(1, -95, 1, -315), Size = UDim2.fromOffset(70, 70) })
		I[3] = new("ImageButton", I[1], "PunchButton", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12252402662"), LayoutOrder = 1, Position = UDim2.new(1, -95, 1, -165), Size = UDim2.fromOffset(70, 70) })
		I[4] = new("ImageButton", I[1], "BlockButton", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12252418253"), LayoutOrder = 3, Position = UDim2.new(1, -95, 1, -240), Size = UDim2.fromOffset(70, 70) })
		I[5] = new("ImageButton", I[1], "SpecialButton", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10002492897"), LayoutOrder = 3, Position = UDim2.new(0.8961424, -95, 1.1257485, -315), Size = UDim2.fromOffset(70, 70) })
	return I[1]
end

return build
