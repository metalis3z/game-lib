local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(3,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local Info2 = TweenInfo.new(1,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local Info3 = TweenInfo.new(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local Info4 = TweenInfo.new(12,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local Info5 = TweenInfo.new(3,Enum.EasingStyle.Bounce,Enum.EasingDirection.InOut)
local unLit = TweenService:Create(script.Parent.LightPart,Info2,{Transparency = 1})
local Light = TweenService:Create(script.Parent.Flame.LIGHT,Info3,{Brightness = 50})
local unLight = TweenService:Create(script.Parent.Flame.LIGHT,Info5,{Brightness = 0})
local Decompose = TweenService:Create(script.Parent.U2,Info4,{Transparency = 1})
local DecomposeLight = TweenService:Create(script.Parent.U2.Light,Info5,{Range = 0})
local Decompose2 = TweenService:Create(script.Parent.PUMPKIN,Info4,{Transparency = 1})

script.Parent.LightPart.Transparency = 0
script.Parent.U2.Transparency = 0.3
script.Parent.U2.Light.Range = 10
wait(0.3)
script.Parent.Scare:Play()
wait(1.7)
script.Parent.Charge:Play()
script.Parent.Flame.A.Flame.Enabled = true
script.Parent.Anchored = true
wait(1)
script.Parent.Flame.A.Flame.Enabled = false
script.Parent.Flame.A.Flame2.Enabled = true
script.Parent.Flame.A.ShockParticlesFlames2.Enabled = true
script.Parent.Flame.A.ShockParticlesFlames21.Enabled = true
script.Parent.Flame.A.ShockParticlesFlames22.Enabled = true
script.Parent.Flame.A.ShockParticlesFlames23.Enabled = true
wait(2)
script.Parent.CanCollide = false
game.Workspace.Fake2:Play()
script.Parent.S1:Play()
script.Parent.S2:Play()
Light:Play()
script.Parent.Flame.A.Flame.Enabled = false
script.Parent.Flame.A.Flame2.Enabled = false
script.Parent.Flame.A.Flame3.Enabled = true
script.Parent.Flame.EFFECT.Enabled = true
script.Parent.Flame.EFFECT2.Enabled = true
script.Parent.Flame.EFFECT3.Enabled = true
script.Parent.Flame.EFFECT4.Enabled = true
script.Parent.Flame.EFFECT5.Enabled = true
script.Parent.Flame.EFFECT6.Enabled = true
script.Parent.Flame.EFFECT7.Enabled = true
script.Parent.Flame.EFFECT8.Enabled = true
script.Parent.Flame.EFFECT9.Enabled = true
script.Parent.Flame.EFFECT10.Enabled = true
script.Parent.Flame.EFFECT11.Enabled = true
script.Parent.Flame.EFFECT12.Enabled = true
script.Parent.Flame.EFFECT13.Enabled = true
script.Parent.Flame.EFFECT14.Enabled = true
script.Parent.Flame.EFFECT15.Enabled = true
script.Parent.Flame.EFFECT16.Enabled = true
script.Parent.Flame.EFFECT17.Enabled = true
script.Parent.Flame.EFFECT18.Enabled = true
script.Parent.Flame.EFFECT19.Enabled = true
script.Parent.Flame.EFFECT20.Enabled = true
script.Parent.Flame.EFFECT21.Enabled = true
script.Parent.Flame.EFFECT22.Enabled = true
script.Parent.Flame.EFFECT23.Enabled = true
script.Parent.Flame.EFFECT24.Enabled = true
script.Parent.Flame.EFFECT25.Enabled = true
script.Parent.Flame.EFFECT26.Enabled = true
script.Parent.Flame.EFFECT27.Enabled = true
script.Parent.Flame.EFFECT28.Enabled = true
script.Parent.Flame.EFFECT29.Enabled = true
script.Parent.Flame.EFFECT30.Enabled = true
script.Parent.Flame.EFFECT31.Enabled = true
script.Parent.Flame.EFFECT32.Enabled = true
script.Parent.Flame.EFFECT33.Enabled = true
script.Parent.Flame.EFFECT34.Enabled = true
script.Parent.Flame.EFFECT35.Enabled = true
script.Parent.Flame.EFFECT36.Enabled = true
script.Parent.Flame.EFFECT37.Enabled = true
script.Parent.Flame.EFFECT38.Enabled = true
script.Parent.Flame.EFFECT39.Enabled = true
script.Parent.Flame.EFFECT40.Enabled = true
script.Parent.Flame.EFFECT41.Enabled = true
script.Parent.Flame.EFFECT42.Enabled = true
script.Parent.Flame.EFFECT43.Enabled = true
script.Parent.Flame.EFFECT44.Enabled = true
script.Parent.Flame.EFFECT45.Enabled = true
script.Parent.Kill.Script.Disabled = false
script.Parent.Flame.EXPLOSION.Enabled = true
script.Parent.Flame.EXPLOSION1.Enabled = true
script.Parent.Flame.EXPLOSION2.Enabled = true
script.Parent.Flame.EXPLOSION3.Enabled = true
script.Parent.Flame.EXPLOSION4.Enabled = true
script.Parent.Flame.EXPLOSION5.Enabled = true
script.Parent.Flame.EXPLOSION6.Enabled = true
script.Parent.Flame.EXPLOSION7.Enabled = true
script.Parent.Flame.EXPLOSION8.Enabled = true
script.Parent.Flame.EXPLOSION9.Enabled = true
script.Parent.Flame.EXPLOSION10.Enabled = true
script.Parent.Flame.Fog.Enabled = true
script.Parent.Flame.Fog2.Enabled = true
script.Parent.Flame.Fog3.Enabled = true
script.Parent.Flame.Fog4.Enabled = true
script.Parent.Flame.Fog5.Enabled = true
wait(6)
unLit:Play()
script.Parent.Massless = false
unLight:Play()
DecomposeLight:Play()
script.Parent.Flame.EXPLOSION.Enabled = false
script.Parent.Flame.EXPLOSION1.Enabled = false
script.Parent.Flame.EXPLOSION2.Enabled = false
script.Parent.Flame.EXPLOSION3.Enabled = false
script.Parent.Flame.EXPLOSION4.Enabled = false
script.Parent.Flame.EXPLOSION5.Enabled = false
script.Parent.Flame.EXPLOSION6.Enabled = false
script.Parent.Flame.EXPLOSION7.Enabled = false
script.Parent.Flame.EXPLOSION8.Enabled = false
script.Parent.Flame.EXPLOSION9.Enabled = false
script.Parent.Flame.EXPLOSION10.Enabled = false
script.Parent.Flame.Fog.Enabled = false
script.Parent.Flame.Fog2.Enabled = false
script.Parent.Flame.Fog3.Enabled = false
script.Parent.Flame.Fog4.Enabled = false
script.Parent.Flame.Fog5.Enabled = false
script.Parent.Flame.A.ShockParticlesFlames2.Enabled = false
script.Parent.Flame.A.ShockParticlesFlames21.Enabled = false
script.Parent.Flame.A.ShockParticlesFlames22.Enabled = false
script.Parent.Flame.A.ShockParticlesFlames23.Enabled = false
script.Parent.Flame.A.Flame3.Enabled = false
script.Parent.Flame.EFFECT.Enabled = false
script.Parent.Flame.EFFECT2.Enabled = false
script.Parent.Flame.EFFECT3.Enabled = false
script.Parent.Flame.EFFECT4.Enabled = false
script.Parent.Flame.EFFECT5.Enabled = false
script.Parent.Flame.EFFECT6.Enabled = false
script.Parent.Flame.EFFECT7.Enabled = false
script.Parent.Flame.EFFECT8.Enabled = false
script.Parent.Flame.EFFECT9.Enabled = false
script.Parent.Flame.EFFECT10.Enabled = false
script.Parent.Flame.EFFECT11.Enabled = false
script.Parent.Flame.EFFECT12.Enabled = false
script.Parent.Flame.EFFECT13.Enabled = false
script.Parent.Flame.EFFECT14.Enabled = false
script.Parent.Flame.EFFECT15.Enabled = false
script.Parent.Flame.EFFECT16.Enabled = false
script.Parent.Flame.EFFECT17.Enabled = false
script.Parent.Flame.EFFECT18.Enabled = false
script.Parent.Flame.EFFECT19.Enabled = false
script.Parent.Flame.EFFECT20.Enabled = false
script.Parent.Flame.EFFECT21.Enabled = false
script.Parent.Flame.EFFECT22.Enabled = false
script.Parent.Flame.EFFECT23.Enabled = false
script.Parent.Flame.EFFECT24.Enabled = false
script.Parent.Flame.EFFECT25.Enabled = false
script.Parent.Flame.EFFECT26.Enabled = false
script.Parent.Flame.EFFECT27.Enabled = false
script.Parent.Flame.EFFECT28.Enabled = false
script.Parent.Flame.EFFECT29.Enabled = false
script.Parent.Flame.EFFECT30.Enabled = false
script.Parent.Flame.EFFECT31.Enabled = false
script.Parent.Flame.EFFECT32.Enabled = false
script.Parent.Flame.EFFECT33.Enabled = false
script.Parent.Flame.EFFECT34.Enabled = false
script.Parent.Flame.EFFECT35.Enabled = false
script.Parent.Flame.EFFECT36.Enabled = false
script.Parent.Flame.EFFECT37.Enabled = false
script.Parent.Flame.EFFECT38.Enabled = false
script.Parent.Flame.EFFECT39.Enabled = false
script.Parent.Flame.EFFECT40.Enabled = false
script.Parent.Flame.EFFECT41.Enabled = false
script.Parent.Flame.EFFECT42.Enabled = false
script.Parent.Flame.EFFECT43.Enabled = false
script.Parent.Flame.EFFECT44.Enabled = false
script.Parent.Flame.EFFECT45.Enabled = false
script.Parent.Kill.Script.Disabled = true
wait(5)
script.Parent.Anchored = false
script.Parent.CanCollide = true
Decompose:Play()
Decompose2:Play()
wait(14)
script.Parent:Destroy()
