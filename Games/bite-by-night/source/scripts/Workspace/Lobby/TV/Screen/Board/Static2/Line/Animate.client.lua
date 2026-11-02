

local TweenService = game:GetService("TweenService")
while true do
    script.Parent.Position = UDim2.new(0.5, 0, -0.3, 0)
    TweenService:Create(script.Parent, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 1.3, 0)}):Play()
    task.wait(math.random(4, 10))
end
