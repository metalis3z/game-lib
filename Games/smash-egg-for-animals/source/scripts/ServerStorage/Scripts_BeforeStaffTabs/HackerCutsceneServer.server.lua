-- HackerCutsceneServer : cinématique "Hacker Infiltration" (panneau admin F2 > Cutscenes, ou ServerStorage.GameBindables.PlayHackerCutscene)
-- Un hacker en capuche entre dans une salle serveur, sort son ordinateur de son sac, le pose sur la table, pirate le système
-- ("SYSTEM HACKED !!!!!" sur l'écran), puis repart par la porte. Toute la mise en scène est jouée côté client :
-- StarterPlayerScripts.HackerCutsceneClient. Ici : l'avatar du hacker, le déclenchement, et le verrou (une seule à la fois).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local folder = ReplicatedStorage:WaitForChild("HackerCutscene")
local playRemote = folder:WaitForChild("Play")
local startRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("StartHackerCutscene")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local TOPIC = "AdminHackerCutscene"
local LENGTH = 34     -- durée de la cinématique (s) : on ne peut pas la relancer pendant qu'elle tourne
local LEAD_TIME = 2   -- délai avant le début, pour que tous les joueurs chargent le décor

---------------------------------------------------------------- l'avatar du hacker (skin demandé) :
-- corps noir, torse vert lumineux et translucide avec les côtes, tête noire aux yeux rouges et au sourire en dents de scie,
-- couronne verte avec un domino dessus
local rgb = Color3.fromRGB
local BLACK, BODY, GREEN = rgb(16, 16, 18), rgb(34, 34, 38), rgb(70, 235, 95)
local function buildRig()
	if folder:FindFirstChild("Rig") then return true end
	local ok, rig = pcall(function()
		local desc = Instance.new("HumanoidDescription")
		desc.HeadColor = BLACK
		desc.TorsoColor = GREEN
		desc.LeftArmColor, desc.RightArmColor = BODY, BODY
		desc.LeftLegColor, desc.RightLegColor = BODY, BODY
		return Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15)
	end)
	if not ok or not rig then
		warn("[HackerCutscene] avatar impossible à créer : " .. tostring(rig))
		return false
	end
	rig.Name = "Rig"
	for _, d in rig:GetDescendants() do
		if d:IsA("Script") or d:IsA("LocalScript") then d:Destroy() end
		if d:IsA("BasePart") then d.CanCollide, d.CanQuery, d.CanTouch = false, false, false end
	end
	local humanoid = rig:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
	end
	-- pas de visage, d'habits ni d'accessoires par défaut : on dessine le skin nous-mêmes
	for _, d in rig:GetDescendants() do
		if d:IsA("Accessory") or d:IsA("Shirt") or d:IsA("Pants") or d:IsA("ShirtGraphic") or (d:IsA("Decal") and d.Name == "face") then d:Destroy() end
	end
	-- une pièce soudée à une partie du corps (elle suit tous ses mouvements)
	local function gear(body, name, size, offset, color, material, props)
		local p = Instance.new("Part")
		p.Name = name
		p.Size = size
		p.Color = color
		p.Material = material or Enum.Material.SmoothPlastic
		p.CanCollide, p.CanQuery, p.CanTouch, p.Massless, p.CastShadow = false, false, false, true, false
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		for k, v in props or {} do p[k] = v end
		p.CFrame = body.CFrame * offset
		local w = Instance.new("WeldConstraint")
		w.Part0, w.Part1 = body, p
		w.Parent = p
		p.Parent = rig
		return p
	end
	local V, rad = Vector3.new, math.rad
	-- torse vert lumineux et translucide, avec un cœur sombre, une colonne et des côtes à l'intérieur
	for _, name in {"UpperTorso", "LowerTorso"} do
		local t = rig:FindFirstChild(name)
		if t then
			t.Color, t.Material, t.Transparency = GREEN, Enum.Material.Neon, 0.35
			local s = t.Size
			gear(t, "Core", s * V(0.72, 0.8, 0.55), CFrame.new(0, 0, 0.05), rgb(14, 70, 30), Enum.Material.SmoothPlastic)
		end
	end
	local upper = rig:FindFirstChild("UpperTorso")
	if upper then
		local s = upper.Size
		gear(upper, "Spine", V(s.X * 0.1, s.Y * 0.9, s.Z * 0.2), CFrame.new(0, 0, -s.Z * 0.3), rgb(170, 255, 180), Enum.Material.Neon)
		for i = 0, 3 do
			local y = s.Y * (0.28 - i * 0.18)
			for _, side in {-1, 1} do
				gear(upper, "Rib", V(s.X * 0.36, s.Y * 0.06, s.Z * 0.1), CFrame.new(side * s.X * 0.2, y, -s.Z * 0.36) * CFrame.Angles(0, 0, rad(side * -14)),
					rgb(150, 255, 165), Enum.Material.Neon)
			end
		end
	end
	-- tête noire : yeux rouges méchants, sourire en dents de scie
	local head = rig:FindFirstChild("Head")
	if head then
		head.Color = BLACK
		local hs = head.Size
		local front = -hs.Z * 0.5
		for _, side in {-1, 1} do
			gear(head, "Eye", V(hs.X * 0.26, hs.Y * 0.12, 0.06), CFrame.new(side * hs.X * 0.18, hs.Y * 0.12, front) * CFrame.Angles(0, 0, rad(side * 20)), rgb(255, 30, 30), Enum.Material.Neon)
		end
		gear(head, "Grin", V(hs.X * 0.6, hs.Y * 0.16, 0.05), CFrame.new(0, -hs.Y * 0.19, front), rgb(225, 225, 225), Enum.Material.SmoothPlastic)
		for i = 0, 8 do -- dents en zigzag
			gear(head, "Tooth", V(0.03, hs.Y * 0.16, 0.06), CFrame.new(-hs.X * 0.27 + i * hs.X * 0.0675, -hs.Y * 0.19, front - 0.005) * CFrame.Angles(0, 0, rad(i % 2 == 0 and 30 or -30)), BLACK)
		end
		-- couronne verte : bandeau noir, chapeau vert, domino et deux tiges
		local top = hs.Y * 0.5
		local upright = CFrame.Angles(0, 0, rad(90))
		gear(head, "HatBand", V(hs.Y * 0.16, hs.X * 1.02, hs.X * 1.02), CFrame.new(0, top + hs.Y * 0.02, 0) * upright, BLACK, Enum.Material.SmoothPlastic, {Shape = Enum.PartType.Cylinder})
		gear(head, "Hat", V(hs.Y * 0.38, hs.X * 0.98, hs.X * 0.98), CFrame.new(0, top + hs.Y * 0.28, 0) * upright, rgb(120, 230, 100), Enum.Material.SmoothPlastic, {Shape = Enum.PartType.Cylinder})
		local domino = gear(head, "Domino", V(hs.X * 0.42, hs.Y * 0.8, 0.12), CFrame.new(-hs.X * 0.05, top + hs.Y * 0.82, hs.Z * 0.05) * CFrame.Angles(0, 0, rad(8)), rgb(130, 235, 110))
		local dw, dh = domino.Size.X, domino.Size.Y
		gear(domino, "DominoLine", V(dw * 0.9, 0.03, 0.14), CFrame.new(), rgb(40, 90, 40))
		for _, d in {{-0.25, 0.38}, {0.25, 0.38}, {-0.25, 0.22}, {0.25, 0.22}, {-0.25, -0.22}, {0.25, -0.22}, {0, -0.38}} do
			gear(domino, "Dot", V(0.07, 0.07, 0.15), CFrame.new(d[1] * dw, d[2] * dh, 0), BLACK)
		end
		for _, side in {-1, 1} do
			gear(head, "Stick", V(0.08, hs.Y * 0.75, 0.08), CFrame.new(side * hs.X * 0.3, top + hs.Y * 0.75, hs.Z * 0.2) * CFrame.Angles(rad(-10), 0, rad(side * -12)), rgb(110, 220, 90))
		end
	end
	rig:PivotTo(CFrame.new(0, 3000, 0))
	rig.Parent = folder
	return true
end
task.spawn(buildRig) -- prêt dès le démarrage du serveur

---------------------------------------------------------------- lancement
local busyUntil = 0
local function play()
	if os.clock() < busyUntil then return false end -- déjà en cours : pas deux en même temps
	busyUntil = os.clock() + LENGTH + LEAD_TIME
	buildRig()
	local startAt = workspace:GetServerTimeNow() + LEAD_TIME
	ReplicatedStorage:SetAttribute("HackerCutsceneEnd", startAt + LENGTH)
	playRemote:FireAllClients(startAt)
	task.delay(LENGTH + LEAD_TIME, function()
		if os.clock() >= busyUntil - 0.1 then ReplicatedStorage:SetAttribute("HackerCutsceneEnd", nil) end
	end)
	return true
end

-- déclenchement par un autre script : ServerStorage.GameBindables.PlayHackerCutscene:Fire()
local bindables = ServerStorage:FindFirstChild("GameBindables")
local bindable = bindables and bindables:FindFirstChild("PlayHackerCutscene")
if bindable then bindable.Event:Connect(function() play() end) end

-- tous les serveurs
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" and data.JobId == game.JobId then return end -- déjà lancée ici
		play()
	end)
end)

-- panneau admin : scope "server" = ce serveur, "global" = tous les serveurs
startRemote.OnServerEvent:Connect(function(player, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if not play() then
		notifyRemote:FireClient(player, "The hacker cutscene is already playing")
		return
	end
	if scope == "global" then
		pcall(function() MessagingService:PublishAsync(TOPIC, {JobId = game.JobId}) end)
	end
	notifyRemote:FireClient(player, "Hacker cutscene started" .. (scope == "global" and " on ALL servers" or ""))
end)
