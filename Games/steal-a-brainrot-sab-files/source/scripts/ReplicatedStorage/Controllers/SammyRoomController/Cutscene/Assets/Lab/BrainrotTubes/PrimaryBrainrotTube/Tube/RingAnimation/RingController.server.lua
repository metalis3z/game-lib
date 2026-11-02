local TweenService = game:GetService("TweenService")
local v1 = script.Parent
local Ring = v1:WaitForChild("Ring")
local function SpawnRing()
	local v12 = Ring:Clone()
	v12.Parent = v1
	v12.CFrame = Ring.CFrame
	local v2 = TweenService:Create(v12, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		CFrame = v12.CFrame * CFrame.new(0, 20, 0)
	})
	local v3 = TweenService:Create(v12, TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 1
	})
	v2:Play()
	v3:Play()
	task.delay(1.55, function()
		v12:Destroy()
	end)
end
while true do
	SpawnRing()
	task.wait(0.75)
end