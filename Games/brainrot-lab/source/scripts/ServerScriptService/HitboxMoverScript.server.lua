local workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- Configurações
local SPEED = 30          -- Velocidade de movimento (studs por segundo)
local PAUSE_TIME = 0.5    -- Tempo de pausa ao chegar no waypoint

local activated = false

local function startHitboxMover()
	if activated then return end
	activated = true

	local fireFolder = workspace:FindFirstChild("Base") and workspace.Base:FindFirstChild("Lava") and workspace.Base.Lava:FindFirstChild("Fire")
	if not fireFolder then
		warn("[HitboxMover] Pasta 'Lava.Fire' não encontrada!")
		activated = false
		return
	end

	local hitboxFolder = fireFolder:FindFirstChild("Hitbox")
	local waypointsFolder = fireFolder:FindFirstChild("Waypoints")

	if not hitboxFolder or not waypointsFolder then
		warn("[HitboxMover] Pasta 'Hitbox' ou 'Waypoints' não encontrada!")
		activated = false
		return
	end

	-- Coletar waypoints
	local waypoints = {}
	for _, child in ipairs(waypointsFolder:GetChildren()) do
		if child:IsA("BasePart") then
			table.insert(waypoints, child)
		end
	end

	if #waypoints == 0 then
		warn("[HitboxMover] Nenhum waypoint encontrado!")
		activated = false
		return
	end

	-- Coletar hitboxes
	local hitboxes = {}
	for _, child in ipairs(hitboxFolder:GetChildren()) do
		if child:IsA("BasePart") then
			table.insert(hitboxes, child)
		end
	end

	if #hitboxes == 0 then
		warn("[HitboxMover] Nenhuma hitbox encontrada!")
		activated = false
		return
	end

	-- Função para escolher um waypoint aleatório (diferente do atual)
	local function getRandomWaypoint(currentPos)
		local candidates = {}
		for _, wp in ipairs(waypoints) do
			if (wp.Position - currentPos).Magnitude > 5 then
				table.insert(candidates, wp)
			end
		end
		if #candidates == 0 then
			return waypoints[math.random(1, #waypoints)]
		end
		return candidates[math.random(1, #candidates)]
	end

	-- Função para mover uma hitbox para um waypoint
	local function moveHitbox(hitbox)
		local currentPos = hitbox.Position
		local target = getRandomWaypoint(currentPos)
		local distance = (target.Position - currentPos).Magnitude
		local timeToMove = distance / SPEED

		local tweenInfo = TweenInfo.new(timeToMove, Enum.EasingStyle.Linear)
		local tween = TweenService:Create(hitbox, tweenInfo, {Position = target.Position})

		tween:Play()
		tween.Completed:Connect(function()
			task.wait(PAUSE_TIME)
			moveHitbox(hitbox)
		end)
	end

	-- Iniciar movimento de cada hitbox
	for _, hitbox in ipairs(hitboxes) do
		task.spawn(function()
			moveHitbox(hitbox)
		end)
	end

	print("[HitboxMover] " .. #hitboxes .. " hitboxes movendo entre " .. #waypoints .. " waypoints")
end

-- Verifica se o model Lava já está no workspace
local baseFolder = workspace:FindFirstChild("Base")

if baseFolder and baseFolder:FindFirstChild("Lava") then
	startHitboxMover()
else
	-- Monitora até a pasta Base aparecer e depois o Lava dentro dela
	local function watchForLava(parent)
		parent.ChildAdded:Connect(function(child)
			if child.Name == "Lava" then
				task.wait(0.5)
				startHitboxMover()
			end
		end)
	end

	if baseFolder then
		watchForLava(baseFolder)
	else
		workspace.ChildAdded:Connect(function(child)
			if child.Name == "Base" then
				watchForLava(child)
				-- Caso o Lava já esteja dentro do Base quando ele aparece
				if child:FindFirstChild("Lava") then
					task.wait(0.5)
					startHitboxMover()
				end
			end
		end)
	end
	print("[HitboxMover] Aguardando o model 'Lava' aparecer em Workspace.Base...")
end