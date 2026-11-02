local ts = game:GetService("TweenService")

local ts1 = ts:Create(script.Parent,TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{
	Position = script.Parent.Position - Vector3.new(0,2,0)
})

local ts2 = ts:Create(script.Parent,TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),{
	Position = script.Parent.Position + Vector3.new(0,2,0)
})

while true do
	ts1:Play()
	ts1.Completed:Wait()
	ts2:Play()
	ts2.Completed:Wait()
end