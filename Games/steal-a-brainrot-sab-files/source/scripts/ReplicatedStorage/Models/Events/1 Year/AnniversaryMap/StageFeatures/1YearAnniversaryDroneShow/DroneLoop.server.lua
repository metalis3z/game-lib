
local TweenService = game:GetService("TweenService")
local v2 = script.Parent.AnimationController["1YearAnimation"]
local v3 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(v2)

v3.Looped = true
v3:Play()
v3:AdjustSpeed(0.5)

local t1 = {
	Color3.fromRGB(255, 75, 75),
	Color3.fromRGB(255, 75, 255),
	Color3.fromRGB(80, 255, 255),
	Color3.fromRGB(85, 255, 75),
	Color3.fromRGB(255, 255, 60),
	Color3.fromRGB(255, 100, 50)
}
local v5 = script.Parent:FindFirstChild("Drones.001")
local n1 = 1
local tweenInfo = TweenInfo.new(0.125, Enum.EasingStyle.Linear)

task.spawn(function()
	while true do
		if v5 then
			TweenService:Create(v5, tweenInfo, {
				Color = t1[n1]
			}):Play()
		end

		n1 = n1 % #t1 + 1
		task.wait(0.25)
	end
end)
