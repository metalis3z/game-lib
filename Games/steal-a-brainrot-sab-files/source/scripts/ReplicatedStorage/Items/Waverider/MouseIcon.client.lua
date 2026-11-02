local v1 = script.Parent
local v2 = nil

local function UpdateIcon()
	if not v2 then
		return
	end

	v2.Icon = if v1.Enabled then "rbxasset://textures/GunCursor.png" else "rbxasset://textures/GunWaitCursor.png"
end

local function OnEquipped(p1)
	v2 = p1

	if not p1 then
		return
	end

	p1.Icon = if v1.Enabled then "rbxasset://textures/GunCursor.png" else "rbxasset://textures/GunWaitCursor.png"
end

local function OnChanged(p1)
	if p1 ~= "Enabled" or not v2 then
		return
	end

	v2.Icon = if v1.Enabled then "rbxasset://textures/GunCursor.png" else "rbxasset://textures/GunWaitCursor.png"
end

v1.Equipped:Connect(OnEquipped)
v1.Changed:Connect(OnChanged)