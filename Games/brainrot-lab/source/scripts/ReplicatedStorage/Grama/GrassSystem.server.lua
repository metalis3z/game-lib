--==================================================
-- GRASS SYSTEM
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local GrassFolder = workspace:WaitForChild("Grass")

local Config = {
	-- Distância máxima que o jogador influencia a grama
	MaxDistance = 4,

	-- Inclinação máxima
	MaxTiltAngle = 45,

	-- Velocidade da resposta
	Tension = 0.08,

	-- Amortecimento
	Damping = 0.85,

	-- Quantas vezes por segundo atualiza
	UpdateRate = 180,
}

-- Guarda informações de cada grama
local GrassData = {}

--==================================================
-- REGISTRA AS PARTS DE GRAMA
--==================================================

for _, part in ipairs(GrassFolder:GetDescendants()) do

	if part:IsA("BasePart") then

		GrassData[part] = {
			OriginalCFrame = part.CFrame,
			HeightOffset = part.Size.Y / 2,

			CurrentTilt = Vector3.zero,
			TiltVelocity = Vector3.zero,
		}

		-- Evita a grama ser empurrada fisicamente
		part.CanCollide = false
		part.CanTouch = true
	end
end

--==================================================
-- PEGA OS JOGADORES
--==================================================

local function GetClosestRoot(position)

	local closestRoot = nil
	local closestDistance = Config.MaxDistance

	for _, player in ipairs(Players:GetPlayers()) do

		local character = player.Character

		if character then

			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local root = character:FindFirstChild("HumanoidRootPart")

			if humanoid and root and humanoid.Health > 0 then

				local distance =
					(Vector3.new(position.X, 0, position.Z)
						-
						Vector3.new(root.Position.X, 0, root.Position.Z)).Magnitude

				if distance <= closestDistance then
					closestDistance = distance
					closestRoot = root
				end
			end
		end
	end

	return closestRoot, closestDistance
end

--==================================================
-- ATUALIZA A GRAMA
--==================================================

local accumulator = 0

RunService.Heartbeat:Connect(function(dt)

	accumulator += dt

	if accumulator < (1 / Config.UpdateRate) then
		return
	end

	local deltaTime = accumulator
	accumulator = 0

	for part, data in pairs(GrassData) do

		if not part or not part.Parent then
			GrassData[part] = nil
			continue
		end

		local targetTilt = Vector3.zero

		-- Procura jogador próximo
		local root, distance = GetClosestRoot(part.Position)

		if root then

			local offset = part.Position - root.Position

			local pushDir = Vector3.new(
				offset.X,
				0,
				offset.Z
			)

			if pushDir.Magnitude > 0.01 then
				pushDir = pushDir.Unit
			else
				pushDir = Vector3.new(1, 0, 0)
			end

			-- Quanto mais perto, maior a inclinação
			local tiltAlpha =
				1 - (distance / Config.MaxDistance)

			local angle =
				Config.MaxTiltAngle * tiltAlpha

			targetTilt = Vector3.new(
				pushDir.Z * angle,
				0,
				-pushDir.X * angle
			)
		end

		--==================================================
		-- MOVIMENTO SUAVE
		--==================================================

		local force =
			(targetTilt - data.CurrentTilt)
			* Config.Tension

		data.TiltVelocity =
			(data.TiltVelocity + force)
			* Config.Damping

		data.CurrentTilt +=
			data.TiltVelocity

		--==================================================
		-- APLICA A ROTAÇÃO
		--==================================================

		local rot = CFrame.Angles(
			math.rad(data.CurrentTilt.X),
			0,
			math.rad(data.CurrentTilt.Z)
		)

		local pivot =
			data.OriginalCFrame
			* CFrame.new(0, -data.HeightOffset, 0)

		part.CFrame =
			pivot
			* rot
			* CFrame.new(0, data.HeightOffset, 0)

		--==================================================
		-- VOLTA AO NORMAL
		--==================================================

		if not root
			and data.TiltVelocity.Magnitude < 0.1
			and data.CurrentTilt.Magnitude < 0.1 then

			part.CFrame = data.OriginalCFrame

			data.CurrentTilt = Vector3.zero
			data.TiltVelocity = Vector3.zero
		end
	end
end)