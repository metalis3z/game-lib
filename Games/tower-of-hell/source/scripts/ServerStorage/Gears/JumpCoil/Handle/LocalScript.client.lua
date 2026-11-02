local userInputService = game:GetService("UserInputService")

local player = game:GetService("Players").LocalPlayer

local tool = script.Parent.Parent
local sound = script.Parent.CoilSound

local isInfJump = false
local jumpDebounce = false

tool.Equipped:Connect(function()
	sound:Play()
	isInfJump = true
end)

tool.Unequipped:Connect(function()
	isInfJump = false
end)

userInputService.JumpRequest:Connect(function()
	if not isInfJump then return end
	if jumpDebounce then return end
	if not player.Character then return end
	if not player.Character:FindFirstChild("Humanoid") then return end
	if player.Character.Humanoid.Health == 0 then return end
	
	jumpDebounce = true
	player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	wait(0.25)
	jumpDebounce = false
end)