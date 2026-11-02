local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(3,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local Info2 = TweenInfo.new(1,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local Info3 = TweenInfo.new(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local Info4 = TweenInfo.new(12,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local Info5 = TweenInfo.new(3,Enum.EasingStyle.Bounce,Enum.EasingDirection.InOut)
local unLit = TweenService:Create(script.Parent.LightPart,Info5,{Transparency = 1})
local Light = TweenService:Create(script.Parent.Flame.icelight,Info3,{Brightness = 50})
local unLight = TweenService:Create(script.Parent.Flame.icelight,Info5,{Brightness = 0})
local Decompose = TweenService:Create(script.Parent.PUMPKIN,Info4,{Transparency = 1})
local granite = TweenService:Create(script.Parent.granite,Info4,{Transparency = 1})
local ff = TweenService:Create(script.Parent.ff,Info4,{Transparency = 1})
local slate = TweenService:Create(script.Parent.slate,Info4,{Transparency = 1})
local DecomposeLight = TweenService:Create(script.Parent.PUMPKIN.Light,Info5,{Range = 0})
local Decompose2 = TweenService:Create(script.Parent.PUMPKIN,Info5,{Transparency = 1})
local lightcolor = TweenService:Create(script.Parent.LightPart,Info2,{Color = Color3.fromRGB(128, 187, 219)})
local ffcolor = TweenService:Create(script.Parent.ff,Info2,{Color = Color3.fromRGB(4, 175, 236)})
local plightcolor = TweenService:Create(script.Parent.PUMPKIN.Light,Info2,{Color = Color3.fromRGB(0,170,255)})
local location = script.Parent.iceeffects
local location2 = script.Parent.Kill.killing
local handlescream = script.Parent.ICE
local scream = game.Workspace.Fake3
script.Parent.LightPart.Transparency = 0
script.Parent.granite.Transparency = 0.4
script.Parent.slate.Transparency = 0.6
script.Parent.PUMPKIN.Transparency = 0
script.Parent.ff.Script.Disabled = true
script.Parent.LightPart.Script.Disabled = true
script.Parent.ff.Transparency = 0
script.Parent.PUMPKIN.Light.Range = 15
plightcolor:Play()
ffcolor:Play()
lightcolor:Play()
wait(0.3)
script.Parent.Scare:Play()
wait(1.7)
script.Parent.Charge:Play()
location.A.Flame.Enabled = true
script.Parent.Anchored = true
wait(1)
location.A.Flame.Enabled = false
location.A.Flame2.Enabled = true
location.A.ShockParticlesFlames2.Enabled = true
location.A.ShockParticlesFlames21.Enabled = true
location.A.ShockParticlesFlames22.Enabled = true
location.A.ShockParticlesFlames23.Enabled = true
wait(2)
script.Parent.CanCollide = false
scream:Play()
handlescream:Play()
Light:Play()
location.A.Flame.Enabled = false
location.A.Flame2.Enabled = false
location.A.Flame3.Enabled = true
location.EFFECT.Enabled = true
location.EFFECT1.Enabled = true
location.EFFECT2.Enabled = true
location.EFFECT3.Enabled = true
location.EFFECT4.Enabled = true
location.EFFECT5.Enabled = true
location.EFFECT6.Enabled = true
location.EFFECT7.Enabled = true
location.EFFECT8.Enabled = true
location.EFFECT9.Enabled = true
location.EFFECT10.Enabled = true
location.EFFECT11.Enabled = true
location.EFFECT12.Enabled = true
location.EFFECT13.Enabled = true
location.EFFECT14.Enabled = true
location.EFFECT15.Enabled = true
location.EFFECT16.Enabled = true
location.EFFECT17.Enabled = true
location.EFFECT18.Enabled = true
location.EFFECT19.Enabled = true
location.EFFECT20.Enabled = true
location.EFFECT21.Enabled = true
location.EFFECT22.Enabled = true
location.EFFECT23.Enabled = true
location.EFFECT24.Enabled = true
location.EFFECT25.Enabled = true
location.EFFECT26.Enabled = true
location.EFFECT27.Enabled = true
location.EFFECT28.Enabled = true
location.EFFECT29.Enabled = true
location.EFFECT30.Enabled = true
location.EFFECT31.Enabled = true
location.EFFECT32.Enabled = true
location.EFFECT33.Enabled = true
location.EFFECT34.Enabled = true
location.EFFECT35.Enabled = true
location2.ice.Disabled = false
location.Fog.Enabled = true
location.Fog2.Enabled = true
location.Fog3.Enabled = true
location.Fog4.Enabled = true
location.Fog5.Enabled = true
location.EXPLOSION.Enabled = true
location.EXPLOSION1.Enabled = true
location.EXPLOSION2.Enabled = true
location.EXPLOSION3.Enabled = true
location.EXPLOSION4.Enabled = true
location.EXPLOSION5.Enabled = true
location.EXPLOSION6.Enabled = true
location.EXPLOSION7.Enabled = true
location.EXPLOSION8.Enabled = true
location.EXPLOSION9.Enabled = true
location.EXPLOSION10.Enabled = true
wait(6)
unLit:Play()
script.Parent.Massless = false
unLight:Play()
DecomposeLight:Play()
location.Fog.Enabled = false
location.Fog2.Enabled = false
location.Fog3.Enabled = false
location.Fog4.Enabled = false
location.Fog5.Enabled = false
location.EXPLOSION.Enabled = false
location.EXPLOSION1.Enabled = false
location.EXPLOSION2.Enabled = false
location.EXPLOSION3.Enabled = false
location.EXPLOSION4.Enabled = false
location.EXPLOSION5.Enabled = false
location.EXPLOSION6.Enabled = false
location.EXPLOSION7.Enabled = false
location.EXPLOSION8.Enabled = false
location.EXPLOSION9.Enabled = false
location.EXPLOSION10.Enabled = false
location.A.ShockParticlesFlames2.Enabled = false
location.A.ShockParticlesFlames21.Enabled = false
location.A.ShockParticlesFlames22.Enabled = false
location.A.ShockParticlesFlames23.Enabled = false
location.A.Flame3.Enabled = false
location.EFFECT.Enabled = false
location.EFFECT1.Enabled = false
location.EFFECT2.Enabled = false
location.EFFECT3.Enabled = false
location.EFFECT4.Enabled = false
location.EFFECT5.Enabled = false
location.EFFECT6.Enabled = false
location.EFFECT7.Enabled = false
location.EFFECT8.Enabled = false
location.EFFECT9.Enabled = false
location.EFFECT10.Enabled = false
location.EFFECT11.Enabled = false
location.EFFECT12.Enabled = false
location.EFFECT13.Enabled = false
location.EFFECT14.Enabled = false
location.EFFECT15.Enabled = false
location.EFFECT16.Enabled = false
location.EFFECT17.Enabled = false
location.EFFECT18.Enabled = false
location.EFFECT19.Enabled = false
location.EFFECT20.Enabled = false
location.EFFECT21.Enabled = false
location.EFFECT22.Enabled = false
location.EFFECT23.Enabled = false
location.EFFECT24.Enabled = false
location.EFFECT25.Enabled = false
location.EFFECT26.Enabled = false
location.EFFECT27.Enabled = false
location.EFFECT28.Enabled = false
location.EFFECT29.Enabled = false
location.EFFECT30.Enabled = false
location.EFFECT31.Enabled = false
location.EFFECT32.Enabled = false
location.EFFECT33.Enabled = false
location.EFFECT34.Enabled = false
location.EFFECT35.Enabled = false
location2.ice.Disabled = true
wait(2)
script.Parent.Anchored = false
script.Parent.CanCollide = true
Decompose:Play()
Decompose2:Play()
slate:Play()
ff:Play()
granite:Play()
wait(14)
script.Parent:Destroy()
