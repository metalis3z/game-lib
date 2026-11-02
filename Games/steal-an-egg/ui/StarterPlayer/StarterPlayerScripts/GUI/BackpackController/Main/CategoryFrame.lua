-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/CategoryFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CategoryFrame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(-0.01, 0.5), Size = UDim2.fromScale(0.0922, 1), Visible = false })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { Padding = UDim.new(0.015, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[3] = new("Frame", I[1], "CategoryTemplate", { BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[5] = new("UICorner", I[3], "UICorner")
			I[6] = new("ImageButton", I[3], "ImageButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://127424605928948"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75) })
	return I[1]
end

return build
