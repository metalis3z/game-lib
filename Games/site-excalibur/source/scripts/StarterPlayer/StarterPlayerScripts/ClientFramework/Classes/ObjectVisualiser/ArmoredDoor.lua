local TweenService = game:GetService("TweenService")

local Visualiser = {}

function Visualiser:Hook(Object)
	local self = {}
	
	self.CurrentTweens = {}
	self.Origin0 = Object.Scripted.Door1.CFrame
	self.Origin1 = Object.Scripted.Door2.CFrame
	self.Goal0 = Object.Scripted.Door1.CFrame * CFrame.new(-3.25, 0, 0)
	self.Goal1 = Object.Scripted.Door2.CFrame * CFrame.new(0, 3.25, 0)
	
	if Object.Open.Value then
		Object.Scripted.Door1.CFrame = self.Goal0
		Object.Scripted.Door2.CFrame = self.Goal1
	end
	
	Object.Open.Changed:Connect(function(Value)
		for _, PlayingTween in pairs(self.CurrentTweens) do
			PlayingTween:Destroy()
		end
		local Tween = TweenService:Create(Object.Scripted.Door1, TweenInfo.new(Object.Broken.Value and 1 or 2.5, Object.Broken.Value and Enum.EasingStyle.Bounce or Enum.EasingStyle.Quint), {CFrame = Value and self.Goal0 or self.Origin0})
		local Tween1 = TweenService:Create(Object.Scripted.Door2, TweenInfo.new(Object.Broken.Value and 1 or 2.5, Object.Broken.Value and Enum.EasingStyle.Bounce or Enum.EasingStyle.Quint), {CFrame = Value and self.Goal1 or self.Origin1})
		delay(Object.Broken.Value and 1 or 2.5, function()
			Object.Opened.Value = Object.Open.Value and true or false
		end)
		table.insert(self.CurrentTweens, Tween)
		table.insert(self.CurrentTweens, Tween1)
		for _, Tween in next, self.CurrentTweens do
			Tween:Play()
			Tween.Completed:Connect(function()
				Tween:Destroy()
			end)
		end
	end)
end

return Visualiser