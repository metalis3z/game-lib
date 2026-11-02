-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/PurchasePendingGUI/Purchase Pending.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Purchase Pending", { DisplayOrder = 500, ResetOnSpawn = false }, { ["__syncback_sanitization_auto_save"] = "Purchase Pending" })
		I[2] = new("Frame", I[1], "Frame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(2, 2) }, { ["__syncback_sanitization_auto_save"] = "Frame" })
			I[3] = new("ImageLabel", I[2], "GIF", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageRectSize = Vector2.new(100, 100), ImageTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, -15), Size = UDim2.fromOffset(100, 100), TileSize = UDim2.fromScale(5, 5) }, { ["__syncback_sanitization_auto_save"] = "GIF" })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", nil, { ["__syncback_sanitization_auto_save"] = "UIAspectRatioConstraint" })
	return I[1]
end

return build
