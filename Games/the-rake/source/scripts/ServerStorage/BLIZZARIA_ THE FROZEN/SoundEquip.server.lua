WeaponTool = script.Parent
local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local Info2 = TweenInfo.new(3,Enum.EasingStyle.Bounce,Enum.EasingDirection.InOut)
local Lit = TweenService:Create(script.Parent.Handle.LightPart,Info1,{Transparency = 0})
local u2 = TweenService:Create(script.Parent.Handle.U2,Info2,{Transparency = 0.9})
local light = TweenService:Create(script.Parent.Handle.U2.Light,Info2,{Range = 15})

function OnEquipped()
	script.Parent.Enabling.Disabled = false
	script.Parent.Handle.Equip:Play()
	script.Parent.Handle.LightPart.Transparency = 1
	u2:Play()
	Lit:Play()
	light:Play()
end
function OnUnequipped()
	script.Parent.Handle.Equip:Stop()
	script.Parent.Done.Value = false
	script.Parent.Enabling.Disabled = true
	script.Parent.Handle.LightPart.Transparency = 1
	script.Parent.Handle.U2.Transparency = 1
	script.Parent.Handle.U2.Light.Range = 0
end
WeaponTool.Equipped:connect(OnEquipped)
WeaponTool.Unequipped:connect(OnUnequipped)