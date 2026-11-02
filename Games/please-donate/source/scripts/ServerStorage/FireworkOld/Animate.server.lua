local TweenService = game:GetService('TweenService')
local Tweeninfo = TweenInfo.new(2.5, Enum.EasingStyle.Quint)

local MainTween = TweenService:Create(script.Parent, Tweeninfo, {
	Transparency = 1,
	Position = Vector3.new(script.Parent.Position.X, math.random(40, 60), script.Parent.Position.Z)
})

wait(script.Parent:GetAttribute('WaitTime'))

script.Parent.Transparency = 0

MainTween:Play()

MainTween.Completed:Connect(function()
	
	script.Parent.BangSound:Play()
	script.Parent.EmitPoint.Flash:Emit(1)
	script.Parent.EmitPoint.Sparks:Emit(30)
	
	wait(5)
	
	script.Parent:Destroy()
	
end)