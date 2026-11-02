-- Tapis de course des bases : les flèches de la bande (texture "Arrows") défilent en continu vers l'arrière, comme si la bande
-- tournait (plus vite quand quelqu'un court dessus). Tapis Galactic : les anneaux et la lune (modèles "Orbit", attribut Spin
-- en degrés par seconde) tournent autour de la planète et des soleils, les étoiles (attribut SpinSelf) tournent sur elles-mêmes.
-- Tout est local (chaque joueur anime ce qu'il voit), seulement pour les tapis proches de la caméra.
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local bases = workspace:WaitForChild("all base")
local ARROW_SPEED = 4.5   -- studs par seconde, bande au repos
local RUN_SPEED = 18      -- quand son propriétaire court dessus (même vitesse que la texture Scroll de SpeedClient)
local NEAR = 260          -- au-delà, on n'anime pas

local treadmills = {} -- [modèle] = {Arrows, Orbits = {{Parts, Base, Rel, Spin}}, Stars = {{Part, Base, Spin}}, Belt}
local function scan(model)
	local entry = {Orbits = {}, Stars = {}}
	local belt = model:FindFirstChild("Belt")
	entry.Belt = belt
	entry.Arrows = belt and belt:FindFirstChild("Arrows")
	for _, o in model:GetChildren() do
		if o:IsA("Model") and o.Name == "Orbit" then
			local center = o:FindFirstChild("OrbitCenter")
			if center then
				local list = {Base = center.CFrame, Spin = math.rad(o:GetAttribute("Spin") or 30), Parts = {}, Rel = {}}
				for _, p in o:GetChildren() do
					if p:IsA("BasePart") and p ~= center then
						table.insert(list.Parts, p)
						table.insert(list.Rel, center.CFrame:ToObjectSpace(p.CFrame))
					end
				end
				table.insert(entry.Orbits, list)
			end
		elseif o:IsA("BasePart") and o:GetAttribute("SpinSelf") then
			table.insert(entry.Stars, {Part = o, Base = o.CFrame, Spin = math.rad(o:GetAttribute("SpinSelf"))})
		end
	end
	return entry
end

local lastScan = 0
local function rescan()
	for model in treadmills do if not model.Parent then treadmills[model] = nil end end
	local showcase = workspace:FindFirstChild("GalacticShowcaseTreadmill") -- showcase de l'update Galactic (GalacticUpdateClient)
	if showcase and not treadmills[showcase] then treadmills[showcase] = scan(showcase) end
	for _, base in bases:GetChildren() do
		local model = base:FindFirstChild("Treadmill")
		if model and not treadmills[model] then
			-- le modèle arrive par morceaux (streaming) : on attend d'avoir sa bande
			if model:FindFirstChild("Belt") then treadmills[model] = scan(model) end
		end
	end
end

local cframes, parts = {}, {}
RunService.RenderStepped:Connect(function(dt)
	local now = os.clock()
	if now - lastScan > 1 then
		lastScan = now
		rescan()
	end
	local camera = workspace.CurrentCamera
	local eye = camera and camera.CFrame.Position or Vector3.zero
	local player = Players.LocalPlayer
	table.clear(cframes)
	table.clear(parts)
	for model, entry in treadmills do
		local belt = entry.Belt
		if not belt or not belt.Parent or (belt.Position - eye).Magnitude > NEAR then continue end
		if entry.Arrows and entry.Arrows.Parent then
			local base = model.Parent
			local running = base and base:GetAttribute("OwnerUserId") == player.UserId and player:GetAttribute("OnTreadmill") == true
			local a = entry.Arrows
			a.OffsetStudsV = (a.OffsetStudsV + dt * (running and RUN_SPEED or ARROW_SPEED)) % a.StudsPerTileV
		end
		for _, orbit in entry.Orbits do
			local turn = orbit.Base * CFrame.Angles(0, now * orbit.Spin, 0)
			for i, p in orbit.Parts do
				table.insert(parts, p)
				table.insert(cframes, turn * orbit.Rel[i])
			end
		end
		for _, star in entry.Stars do
			table.insert(parts, star.Part)
			table.insert(cframes, star.Base * CFrame.Angles(now * star.Spin, now * star.Spin * 0.7, 0))
		end
	end
	if #parts > 0 then workspace:BulkMoveTo(parts, cframes, Enum.BulkMoveMode.FireCFrameChanged) end
end)
