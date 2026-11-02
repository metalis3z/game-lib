local TweenService = game:GetService("TweenService")
local btn = script.Parent.Parent
local SetSizeTo = Vector3.new(20, 20, 20)
local SetSizeBack = Vector3.new(0, 0, 0)

local tweenInfo = TweenInfo.new(
	1,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	0,
	false
)

local TweenTo = TweenService:Create(script.Parent, tweenInfo, {Size = SetSizeTo})
local TweenBack = TweenService:Create(script.Parent, tweenInfo, {Size = SetSizeTo})
btn:WaitForChild("Light").BrickColor = BrickColor.new("Bright red")
btn.Light.Material = Enum.Material.Neon
TweenTo:Play()
repeat task.wait() until TweenTo.PlaybackState == Enum.PlaybackState.Completed
local Boom = Instance.new("Explosion")
Boom.Position = script.Parent.Position
Boom.Parent = script.Parent
Boom.DestroyJointRadiusPercent = 0
Boom.BlastPressure = 0
Boom.Hit:Connect(function(hit)
	local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if Player then
		local Humanoid : Humanoid? = Player.Character:FindFirstChild("Humanoid") :: Humanoid?
		if Humanoid ~= nil then
			Humanoid.Health = 0
		end
	end
end)
TweenBack:Play()
repeat task.wait() until TweenBack.PlaybackState == Enum.PlaybackState.Completed
script.Parent:Destroy()
btn.Light.BrickColor = BrickColor.new("Black")
btn.Light.Material = Enum.Material.SmoothPlastic