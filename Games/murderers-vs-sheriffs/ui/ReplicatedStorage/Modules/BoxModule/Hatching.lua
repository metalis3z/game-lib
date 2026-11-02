-- Generated from ui/ReplicatedStorage/Modules/BoxModule/Hatching.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Hatching", { DisplayOrder = 6, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Uncracked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.25, 0.25), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 3 })
			I[3] = new("ImageLabel", I[2], "Base", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3152772386"), Size = UDim2.fromScale(1, 1) })
			I[4] = new("ImageLabel", I[2], "Uncracked", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3152387679"), Size = UDim2.fromScale(1, 1), Visible = false })
			I[5] = new("ImageLabel", I[2], "Egg", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3152772634"), Size = UDim2.fromScale(1, 1) })
		I[6] = new("Frame", I[1], "Cracked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.25, 0.25), SizeConstraint = Enum.SizeConstraint.RelativeXX, Visible = false, ZIndex = 2 })
			I[7] = new("ImageLabel", I[6], "Back", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3152504722"), Size = UDim2.fromScale(1, 1) })
			I[8] = new("ImageLabel", I[6], "Front", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3152509901"), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[9] = new("ImageLabel", I[6], "PetIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3150088039"), Position = UDim2.fromScale(0.49, 0.35), Size = UDim2.fromScale(0.45, 0.45), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[10] = new("ImageLabel", I[6], "Starburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 234, 179), ImageContent = Content.fromUri("rbxassetid://3028270839"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.49, 0.5), Size = UDim2.fromScale(1.2, 1.2), ZIndex = 0 })
		I[11] = new("Frame", I[1], "BG", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
