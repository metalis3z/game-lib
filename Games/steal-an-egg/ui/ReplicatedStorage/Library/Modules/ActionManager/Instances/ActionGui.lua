-- Generated from ui/ReplicatedStorage/Library/Modules/ActionManager/Instances/ActionGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ActionGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["Proprety"] = "Enabled", ["Value_Off"] = false, ["Value_On"] = true, ["__syncback_sanitization_auto_save"] = "ActionGui" })
		I[2] = new("Frame", I[1], "ListFrame", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(1, -60, 1, -60), Size = UDim2.fromOffset(48, 48) }, { ["__syncback_sanitization_auto_save"] = "ListFrame" })
			I[3] = new("UIScale", I[2], "UIScale", nil, { ["__syncback_sanitization_auto_save"] = "UIScale" })
			I[4] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["__syncback_sanitization_auto_save"] = "UIListLayout" })
	return I[1]
end

return build
