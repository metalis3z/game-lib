local tweenService = game:GetService("TweenService")
local knocked = false
local TweenInfoo = TweenInfo.new(0.2,Enum.EasingStyle.Bounce,Enum.EasingDirection.In)
local Knocked = tweenService:Create(script.Parent.Parent.Door,TweenInfoo,{CFrame = script.Parent.Parent.KnockPos.CFrame})
local Normal = tweenService:Create(script.Parent.Parent.Door,TweenInfoo,{CFrame = script.Parent.Parent.ClosePos.CFrame})

script.Parent.ProximityPrompt.Triggered:connect(function(player)
if knocked == false then
knocked = true
local DoorKnockAnim = player.Character.Humanoid:LoadAnimation(player.Character.DoorKnock)
DoorKnockAnim:Play()
wait(0.2)
script.Parent.Knock:Play()
wait(0.9)
knocked = false
end
end)