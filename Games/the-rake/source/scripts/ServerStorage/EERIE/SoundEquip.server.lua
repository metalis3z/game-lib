WeaponTool = script.Parent
local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local Lit = TweenService:Create(script.Parent.Handle.LightPart,Info1,{Transparency = 0})

function OnEquipped()
	script.Parent.Enabling.Disabled = false
	script.Parent.Handle.Equip:Play()
	script.Parent.Handle.LightPart.Transparency = 1
	Lit:Play()
end
function OnUnequipped()
	script.Parent.Handle.Equip:Stop()
	script.Parent.Done.Value = false
	script.Parent.Enabling.Disabled = true
	script.Parent.Handle.LightPart.Transparency = 1
end
WeaponTool.Equipped:connect(OnEquipped)
WeaponTool.Unequipped:connect(OnUnequipped)