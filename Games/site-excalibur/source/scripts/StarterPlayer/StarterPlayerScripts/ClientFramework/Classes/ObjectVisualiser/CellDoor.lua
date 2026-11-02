local TweenService = game:GetService("TweenService")

local Visualiser = {}

function Visualiser:Hook(Object)
	local self = {}
	
	self.CurrentTweens = {}
	self.Origin = Object.Scripted.Door.CFrame
	self.Goal = Object.Scripted.Door.CFrame * CFrame.new(4.5, 0, 0)
	
	if Object.Open.Value then
		Object.Scripted.Door.CFrame = self.Goal
	end
	
	Object.Open.Changed:Connect(function(Value)
		for _, PlayingTween in pairs(self.CurrentTweens) do
			PlayingTween:Destroy()
		end
		local Tween = TweenService:Create(Object.Scripted.Door, TweenInfo.new(Object.Broken.Value and 1 or 2.58, Object.Broken.Value and Enum.EasingStyle.Bounce or Enum.EasingStyle.Quint), {CFrame = Value and self.Goal or self.Origin})
		delay(Object.Broken.Value and 1 or 2.58, function()
			Object.Opened.Value = Object.Open.Value and true or false
		end)
		table.insert(self.CurrentTweens, Tween)
		Tween:Play()
		Tween.Completed:Connect(function()
			Tween:Destroy()
		end)
	end)
end

return Visualiser