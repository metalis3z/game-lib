local RunService = game:GetService("RunService") -- Gets RunService For Timing
local Camera = workspace.CurrentCamera -- Gets The Camera
local intensity = 0 -- Intensity Of Shake (Script Will Change It)
local rawIntensity = 3 -- The RawIntensity (The Base Intensity which Will make the shake lower in size)
local lastShake = tick() -- The Timing for the Last Shake
local waitTime = 7
local Sound = Instance.new("Sound", game.Workspace) -- This Sets Up The Sound
Sound.SoundId = "rbxassetid://2621252081" -- Adds Sound ID
Sound.Volume = 1 -- Adds Volume

RunService.RenderStepped:Connect(function(step) -- This Function Makes The Shake
	if tick() - lastShake >= waitTime then
		intensity = 0.5 -- Intensity Of The Shake When It Starts (You Can Lower For Less Intense Shakes)
		lastShake = tick()
	end

	Camera.CFrame = Camera.CFrame * CFrame.new( -- Offsets The Camera
		(math.random() - 0.5) * intensity * rawIntensity,
		(math.random() - 0.5) * intensity * rawIntensity,
		(math.random() - 0.5) * intensity * rawIntensity
	)

	intensity = intensity - step -- Lowers The Intensity
	if intensity < 0 then
		intensity = 0
	end
end)

while wait(waitTime) do -- Plays The Shake Sound Every 6 Seconds (wait time amount)
	Sound:Play()
end