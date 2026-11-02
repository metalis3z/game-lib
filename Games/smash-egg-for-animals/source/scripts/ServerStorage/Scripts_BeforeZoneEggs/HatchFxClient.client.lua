-- Éclosion fluide, animée sur chaque client (le serveur ne fait qu'attendre) :
--   œuf marqué "Hatching" : il gonfle en douceur, vibre de plus en plus vite et s'illumine jusqu'à éclater
--   animal éclos ("HatchedPet") : il surgit, fait un tour sur lui-même, suit du regard pendant 5 secondes puis se fige en idle
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local folder = workspace:WaitForChild("ZoneEggs")

local eggs, pets = {}, {} -- [modèle] = état
local SPIN_TIME = 2 -- secondes pour un tour complet de l'animal éclos

local function startEgg(egg)
	if eggs[egg] or not egg.PrimaryPart then return end
	local glow = Instance.new("Highlight")
	glow.FillColor = Color3.fromRGB(255, 245, 190)
	glow.OutlineColor = Color3.fromRGB(255, 255, 255)
	glow.FillTransparency, glow.OutlineTransparency = 1, 1
	glow.DepthMode = Enum.HighlightDepthMode.Occluded
	glow.Parent = egg
	local light = Instance.new("PointLight")
	light.Color = Color3.fromRGB(255, 235, 150)
	light.Brightness, light.Range = 0, 10 + (egg:GetAttribute("Height") or 3) * 2
	light.Parent = egg.PrimaryPart
	eggs[egg] = {Start = os.clock(), Pivot = egg:GetPivot(), Scale = egg:GetScale(), Glow = glow, Light = light}
end

local function startPet(pet)
	if pets[pet] then return end
	task.spawn(function()
		local waited = 0
		while pet.Parent and not pet.PrimaryPart and waited < 3 do waited += task.wait() end
		if not pet.Parent or not pet.PrimaryPart or pets[pet] then return end
		task.wait(0.05) -- laisse arriver toutes les pièces
		local state = {Start = os.clock(), Pivot = pet:GetPivot(), Scale = pet:GetScale(), Life = pet:GetAttribute("Lifetime"), Dropped = pet:GetAttribute("Dropped") == true}
		if state.Life then -- temps restant, en rouge au-dessus de l'animal
			local _, size = pet:GetBoundingBox()
			local board = Instance.new("BillboardGui")
			board.Name = "LifeTimer"
			board.Size = UDim2.new(5 + size.Y * 0.4, 0, 1.1 + size.Y * 0.1, 0)
			board.StudsOffsetWorldSpace = Vector3.new(0, size.Y * 0.6 + 3.6 + size.Y * 0.16, 0)
			board.LightInfluence = 0
			board.MaxDistance = 160 + size.Y * 6
			local label = Instance.new("TextLabel")
			label.BackgroundTransparency = 1
			label.Size = UDim2.fromScale(1, 1)
			label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
			label.TextScaled = true
			label.TextColor3 = Color3.fromRGB(255, 70, 60)
			label.Text = ""
			local stroke = Instance.new("UIStroke")
			stroke.Thickness = 3
			stroke.Color = Color3.new(0, 0, 0)
			stroke.Parent = label
			label.Parent = board
			board.Parent = pet.PrimaryPart
			state.Timer = label
		end
		pets[pet] = state
	end)
end

local function watch(model)
	if not model:IsA("Model") then return end
	if model.Name == "HatchedPet" then
		startPet(model)
	elseif model:GetAttribute("EggKey") then
		if model:GetAttribute("Hatching") then startEgg(model) end
		model:GetAttributeChangedSignal("Hatching"):Connect(function()
			if model:GetAttribute("Hatching") then startEgg(model) end
		end)
	end
end
folder.DescendantAdded:Connect(watch)
for _, d in folder:GetDescendants() do watch(d) end

local function backOut(k) -- dépasse un peu puis revient
	local c = 1.9
	return 1 + (c + 1) * (k - 1) ^ 3 + c * (k - 1) ^ 2
end

RunService.RenderStepped:Connect(function()
	local now = os.clock()
	for egg, state in eggs do
		if not egg.Parent then
			eggs[egg] = nil
		else
			local k = math.min((now - state.Start) / 0.8, 1)
			local swell = k * k * (3 - 2 * k)
			egg:ScaleTo(state.Scale * (1 + 0.2 * swell))
			local shake = math.rad(5 * k * k)
			egg:PivotTo(state.Pivot * CFrame.Angles(math.sin(now * (18 + 30 * k)) * shake * 0.6, 0, math.sin(now * (23 + 34 * k) + 1) * shake))
			state.Glow.FillTransparency = 1 - 0.75 * k ^ 3
			state.Glow.OutlineTransparency = 1 - k
			state.Light.Brightness = 6 * k * k
		end
	end
	for pet, state in pets do
		if not pet.Parent or pet:GetAttribute("Taken") then
			pets[pet] = nil
		else
			local t = now - state.Start
			local pop = t < 0.45 and math.max(backOut(t / 0.45), 0.05) or 1
			if state.Popped ~= true then
				pet:ScaleTo(state.Scale * pop)
				if pop == 1 then state.Popped = true end
			end
			local angle, lift
			lift = 0
			if state.Dropped then
				-- lâché par un joueur : petite chute avec rebond, puis il reste là où on l'a posé
				angle = 0
				if t < 0.35 then
					local k = t / 0.35
					lift = (1 - k * k) * 3
				elseif t < 0.55 then
					lift = math.sin((t - 0.35) / 0.2 * math.pi) * 0.5
				end
			elseif t < SPIN_TIME then
				-- Phase 1 : un tour complet (360°) en douceur
				local k = t / SPIN_TIME
				angle = math.pi * 2 * (k * k * (3 - 2 * k))
			elseif t < SPIN_TIME + 5 then
				-- Phase 2 : suit du regard le joueur local pendant 5 secondes
				local player = game:GetService("Players").LocalPlayer
				local char = player and player.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if hrp then
					local initYaw = math.atan2(-state.Pivot.LookVector.X, -state.Pivot.LookVector.Z)
					local targetYaw = math.atan2(hrp.Position.X - state.Pivot.Position.X, hrp.Position.Z - state.Pivot.Position.Z)
					angle = targetYaw - initYaw
				else
					angle = state.LastAngle or 0
				end
				state.LastAngle = angle
			else
				-- Phase 3 : figé en idle
				angle = state.LastAngle or 0
			end
			if state.Life then
				local left = state.Life - t
				if state.Timer then state.Timer.Text = left > 0 and (math.ceil(left) .. "s left") or "" end
				if left < 1.3 then -- trou noir : il tourbillonne de plus en plus vite, rétrécit et disparaît
					local k = math.clamp(1 - left / 1.3, 0, 1)
					if not state.Hole then
						local hole = Instance.new("Part")
						hole.Shape = Enum.PartType.Ball
						hole.Material = Enum.Material.Neon
						hole.Color = Color3.new(0, 0, 0)
						hole.Anchored, hole.CanCollide, hole.CanQuery, hole.CanTouch, hole.CastShadow = true, false, false, false, false
						hole.Size = Vector3.one * 0.1
						hole.CFrame = CFrame.new(state.Pivot.Position)
						local rim = Instance.new("Highlight")
						rim.FillTransparency = 1
						rim.OutlineColor = Color3.fromRGB(170, 80, 255)
						rim.Parent = hole
						hole.Parent = workspace
						game:GetService("Debris"):AddItem(hole, 1.8)
						state.Hole = hole
						local _, size = pet:GetBoundingBox()
						state.HoleSize = math.max(size.X, size.Y, size.Z) * 0.9
					end
					state.Hole.Size = Vector3.one * state.HoleSize * math.sin(k * math.pi) ^ 0.6
					pet:ScaleTo(math.max(state.Scale * (1 - k) ^ 1.5, state.Scale * 0.02))
					angle += k * k * 70
					lift = 0
				end
			end
			pet:PivotTo(state.Pivot * CFrame.new(0, lift, 0) * CFrame.Angles(0, angle, 0))
		end
	end
end)
