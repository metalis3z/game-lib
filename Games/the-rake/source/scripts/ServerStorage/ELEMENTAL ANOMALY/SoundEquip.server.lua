WeaponTool = script.Parent
local TweenService = game:GetService("TweenService")
local Info2 = TweenInfo.new(5,Enum.EasingStyle.Bounce,Enum.EasingDirection.In)
local light = TweenService:Create(script.Parent.Handle.PUMPKIN.Light,Info2,{Range = 15})
local glow = TweenService:Create(script.Parent.Handle.LightPart,Info2,{Transparency = 0})
local pumpkin = TweenService:Create(script.Parent.Handle.PUMPKIN,Info2,{Transparency = 0})
local ff = TweenService:Create(script.Parent.Handle.ff,Info2,{Transparency = 0})
local slate = TweenService:Create(script.Parent.Handle.slate,Info2,{Transparency = 0.6})
local granite = TweenService:Create(script.Parent.Handle.granite,Info2,{Transparency = 0})


function OnEquipped()
	script.Parent.Enabling.Disabled = false
	script.Parent.Handle.Equip:Play()
	script.Parent.Handle.LightPart.Transparency = 1
	script.Parent.Handle.slate.Transparency = 1
	script.Parent.Handle.PUMPKIN.Transparency = 1
	script.Parent.Handle.granite.Transparency = 1
	script.Parent.Handle.ff.Transparency = 1
	granite:Play()
	slate:Play()
	light:Play()
	ff:Play()
	pumpkin:Play()
	glow:Play()
end
function OnUnequipped()
	script.Parent.Handle.Equip:Stop()
	script.Parent.Done.Value = false
	script.Parent.Enabling.Disabled = true
	script.Parent.Handle.LightPart.Transparency = 1
	script.Parent.Handle.PUMPKIN.Light.Range = 0
	script.Parent.Handle.slate.Transparency = 1
	script.Parent.Handle.PUMPKIN.Transparency = 1
	script.Parent.Handle.granite.Transparency = 1
	script.Parent.Handle.ff.Transparency = 1
end
WeaponTool.Equipped:connect(OnEquipped)
WeaponTool.Unequipped:connect(OnUnequipped)