
local scriptParent = script.Parent
local u2 = nil

function UpdateIcon()
	if u2 then
		u2.Icon = not scriptParent.Enabled and "rbxasset://textures/GunWaitCursor.png" or "rbxasset://textures/GunCursor.png"
	end
end
function OnEquipped(p1)
	u2 = p1
	UpdateIcon()
end
function OnChanged(s1: string)
	if s1 == "Enabled" then
		UpdateIcon()
	end
end

scriptParent.Equipped:Connect(OnEquipped)
scriptParent.Changed:Connect(OnChanged)
