local particles = script:WaitForChild("RainParticles")

local underCover = false

local camera = workspace.CurrentCamera

local tweenService = game:GetService("TweenService")

local balls = {}

local lastBall = tick()


game:GetService("RunService").RenderStepped:Connect(function()

	if not underCover then

		if workspace:FindFirstChild("RainParticles") and workspace.RainParticles ~= particles then
			workspace.RainParticles:Destroy()
		end

		particles.Parent = workspace

		if tick() - lastBall >= Random.new():NextNumber(0.3, 0.7) then
			local ball = Instance.new("Part")

			local specialMesh = Instance.new("SpecialMesh", ball)
			specialMesh.MeshType = Enum.MeshType.Sphere

			ball.Material = Enum.Material.Glass
			ball.Transparency = 0.7
			ball.CastShadow = false
			ball.Anchored = true
			ball.CanCollide = false

			local size = Random.new():NextNumber(0.1, 1.3)
			ball.Size = Vector3.new(size, size, size)

			local x = Random.new():NextNumber(-40/2, 40/2)
			local y = Random.new():NextNumber(-15/2, 15/2)

			local xOffset = camera.CFrame.RightVector * x
			local yOffset = camera.CFrame.UpVector * y

			local zOffset = camera.CFrame.LookVector * 10

			local yTweenValue = Instance.new("NumberValue")
			yTweenValue.Value = 0

			table.insert(balls, {ball, x, y, yTweenValue})

			ball.Parent = workspace

			spawn(function()

				wait(wait(Random.new():NextNumber(0, 1)))

				local tweenInfo = TweenInfo.new(Random.new():NextNumber(1, 3), Enum.EasingStyle.Quint, Enum.EasingDirection.In)

				local transparencyTween = tweenService:Create(ball, tweenInfo, {Transparency = 1})
				transparencyTween:Play()

				local dropTween = tweenService:Create(yTweenValue, tweenInfo, {Value = Random.new():NextNumber(1, 5)})
				dropTween:Play()

				transparencyTween.Completed:Wait()
				ball:Destroy()
			end)

			lastBall = tick()
		end

	else

		particles.Parent = game.ReplicatedStorage
	end


	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {script.Parent, particles}

	local ray = workspace:Raycast(script.Parent.Head.Position, script.Parent.Head.Position + Vector3.new(0, 100000000, 0), rayParams)

	if ray and ray.Instance.Transparency < 1 then

		underCover = true

	else
		underCover = false
	end

	for i, ballInfo in pairs(balls) do

		local xOffset = camera.CFrame.RightVector * ballInfo[2]
		local yOffset = camera.CFrame.UpVector * ballInfo[3]

		local zOffset = camera.CFrame.LookVector * 10

		local dropOffset = -camera.CFrame.UpVector * ballInfo[4].Value

		ballInfo[1].CFrame = camera.CFrame + xOffset + zOffset + yOffset + dropOffset

		local size = ballInfo[1].Size

		ballInfo[1].Size = Vector3.new(size.X, size.Y + ballInfo[4].Value/Random.new():NextNumber(70, 90), size.Z)
	end
end)