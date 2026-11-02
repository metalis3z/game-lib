local Tool = script.Parent
local handle = Tool.Handle
local carved = Tool.Carved
local carved2 = game.ServerStorage.PumpkinMeshes.Carved
local particleEmitter = handle:WaitForChild("ParticleEmitter") 
local sound = handle:WaitForChild("Snip")

local clickCount = 0
local cooldownTime = 35
local canUseTool = true

local function playSnipSound()
	for i = 1, 3 do
		sound:Play()
		wait(0.1)
	end
end

local function onActivated()
	if not canUseTool then return end

	clickCount += 1

	if clickCount == 1 then
		handle.Transparency = 1
		carved.Transparency = 0
		particleEmitter.Enabled = true
		playSnipSound()
		wait(0.1)
		particleEmitter.Enabled = false
	elseif clickCount == 2 then
	
		handle.Transparency = 1
		carved.Transparency = 1

		local clonedCarved = carved2:Clone()
		clonedCarved.Anchored = true
		clonedCarved.CanCollide = false

		local player = game.Players:GetPlayerFromCharacter(Tool.Parent)
		if not player then return end

		local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then return end
		local forwardDirection = humanoidRootPart.CFrame.LookVector 
		local startPosition = humanoidRootPart.Position + Vector3.new(0, 5, 0) 
		local offsetPosition = humanoidRootPart.Position + forwardDirection * 5 


		local rayOrigin = offsetPosition + Vector3.new(0, 5, 0)  
		local rayDirection = Vector3.new(0, -10, 0)
		local ray = Ray.new(rayOrigin, rayDirection)
		local hitPart, hitPosition = workspace:FindPartOnRay(ray, Tool)

		
		clonedCarved.Position = Vector3.new(hitPosition.X, hitPosition.Y + (clonedCarved.Size.Y / 2), hitPosition.Z)

		clonedCarved.Parent = workspace

		canUseTool = false
		task.delay(cooldownTime, function()
			handle.Transparency = 0
			clickCount = 0
			canUseTool = true
		end)
		task.wait(20)
		clonedCarved:Destroy()
	end
end

Tool.Activated:Connect(onActivated)
