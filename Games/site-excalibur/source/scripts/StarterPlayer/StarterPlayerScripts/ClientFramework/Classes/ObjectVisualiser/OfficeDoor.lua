local TweenService = game:GetService("TweenService")

local Visualiser = {}

function Visualiser:Hook(Object)
	local self = {}
	
	self.CurrentTweens = {}
	self.Origin = Object.Scripted.Hinge.CFrame
	self.Goal = Object.Scripted.Hinge.CFrame * CFrame.Angles(0, math.rad(-90), 0)
	
	if Object.Open.Value then
		Object.Scripted.Hinge.CFrame = self.Goal
	end
	
	Object.Open.Changed:Connect(function(Value)
		for _, PlayingTween in next, self.CurrentTweens do
			PlayingTween:Destroy()
		end
		local Tween = TweenService:Create(Object.Scripted.Hinge, TweenInfo.new(0.57, Enum.EasingStyle.Sine), {CFrame = Value and self.Goal or self.Origin})
		delay(0.57, function()
			Object.Opened.Value = Object.Open.Value and true or false
		end)
		Tween:Play()
		table.insert(self.CurrentTweens, Tween)
		for _, Tween in next, self.CurrentTweens do
			Tween.Completed:Connect(function()
				Tween:Destroy()
			end)
		end
	end)
end

return Visualiser