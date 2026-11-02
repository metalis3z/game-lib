local Tool = script.Parent
local debounce = false

local handle = Tool:WaitForChild("Handle")
local snowFalling = handle:WaitForChild("SnowFalling")
local particleEmitter = snowFalling:WaitForChild("ParticleEmitter")
local animation = Tool:WaitForChild("ShakeAnimation")

Tool.Activated:Connect(function()
	if debounce then return end
	debounce = true
	
	local character = Tool.Parent
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if humanoid and animation then
		local animTrack = humanoid:LoadAnimation(animation)
		animTrack:Play()
	end
	
    wait(0.5)
	particleEmitter.Enabled = true

	task.delay(5, function()
		particleEmitter.Enabled = false
	end)

	task.wait(11)
	debounce = false
end)
