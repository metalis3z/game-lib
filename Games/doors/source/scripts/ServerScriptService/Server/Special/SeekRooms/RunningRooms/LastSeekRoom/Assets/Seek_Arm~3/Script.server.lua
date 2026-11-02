local anie = script.Parent.AnimationController
local d = anie:LoadAnimation(script.Parent.Animation)

d:AdjustSpeed(0.8)
game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 1, 0, 0.7)
d:Play()
while true do
	wait(0.1)
	d.Ended:Connect(function()
		script.Parent.PrimaryPart.CFrame = script.Parent.PrimaryPart.CFrame + Vector3.new(20, 0, 0)
	end)
end