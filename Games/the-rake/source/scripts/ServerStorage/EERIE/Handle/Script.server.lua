local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(3,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local Info2 = TweenInfo.new(1,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
local unLit = TweenService:Create(script.Parent.LightPart,Info2,{Transparency = 1})
local Light = TweenService:Create(script.Parent.Flame.LIGHT,Info2,{Brightness = 20})
local unLight = TweenService:Create(script.Parent.Flame.LIGHT,Info2,{Brightness = 0})
local Decompose = TweenService:Create(script.Parent.U2,Info1,{Transparency = 1})

script.Parent.LightPart.Transparency = 0
wait(0.3)
script.Parent.Scare:Play()
wait(1.7)
script.Parent.Charge:Play()
script.Parent.Flame.A.Flame.Enabled = true
script.Parent.Anchored = true
wait(1)
script.Parent.Flame.A.Flame.Enabled = false
script.Parent.Flame.A.Flame2.Enabled = true
wait(1.784)
script.Parent.CanCollide = false
game.Workspace.Fake:Play()
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
script.Parent.Kill.Script.Disabled = false
wait(4)
unLit:Play()
script.Parent.Massless = false
unLight:Play()
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
script.Parent.Kill.Script.Disabled = true
wait(4)
script.Parent.Anchored = false
script.Parent.CanCollide = true
Decompose:Play()
wait(3)
script.Parent:Destroy()
