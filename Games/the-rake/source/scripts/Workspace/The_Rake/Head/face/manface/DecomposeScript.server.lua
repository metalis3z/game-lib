local Humanoid = script.Humanoid.Value
local Number = script.Number.Value.Value
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(Number,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
local Decompose = tweenService:Create(script.Parent,TweenInfoo,{Transparency = 1})

while true do
	wait()
	if Humanoid.Health == 0 then
		Decompose:Play()
	end
end