-- Generated from ui/ServerScriptService/Modded/Resources/Guis/PurchasePromptApp.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PurchasePromptApp", { AutoLocalize = false, DisplayOrder = 999999999, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets }, { ["OnTopOfCoreBlur"] = true })
		I[2] = new("Frame", I[1], "ProductPurchaseContainer", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Animator", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1) })
		I[4] = new("Folder", I[1], "EventConnections")
		I[5] = new("Frame", I[1], "FoundationCursorContainer", { Visible = false })
	return I[1]
end

return build
