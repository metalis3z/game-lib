-- Generated from ui/ReplicatedFirst/LoadingUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LoadingUI", { DisplayOrder = 999, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(38, 25, 25), Size = UDim2.fromScale(1, 1), Text = "Loading...", TextColor3 = Color3.fromRGB(207, 199, 176), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.3, 0), PaddingLeft = UDim.new(0.3, 0), PaddingRight = UDim.new(0.3, 0), PaddingTop = UDim.new(0.3, 0) })
	return I[1]
end

return build
