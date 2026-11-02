
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(4,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
local Decompose = tweenService:Create(script.Parent,TweenInfoo,{Transparency = 1})

while true do
	wait()
	if workspace.Values.SeerHour.Value == true then
		Decompose:Play()
	end
end