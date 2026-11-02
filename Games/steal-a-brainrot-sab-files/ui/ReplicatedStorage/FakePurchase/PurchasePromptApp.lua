-- Generated from ui/ReplicatedStorage/FakePurchase/PurchasePromptApp.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PurchasePromptApp", { AutoLocalize = false, DisplayOrder = 999999999, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets }, { ["OnTopOfCoreBlur"] = true, ["_lemonadeUniqueId"] = "4hJrr5dv4hJr" })
		I[2] = new("Frame", I[1], "ProductPurchaseContainer", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "GmsheyLdGmsh" })
			I[3] = new("Frame", I[2], "Animator", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "YR4GS8FlYR4G" })
		I[4] = new("Folder", I[1], "EventConnections", nil, { ["_lemonadeUniqueId"] = "9EhtJ6P59Eht" })
		I[5] = new("Frame", I[1], "FoundationCursorContainer", { Visible = false }, { ["_lemonadeUniqueId"] = "nsQi5NFNnsQi" })
	return I[1]
end

return build
