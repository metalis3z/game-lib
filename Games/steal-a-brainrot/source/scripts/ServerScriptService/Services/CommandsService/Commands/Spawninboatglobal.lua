local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local CollectionService = game:GetService("CollectionService")
	local RunService        = game:GetService("RunService")
	local MessagingService  = game:GetService("MessagingService")

	local Animals   = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local MSG_TYPE = "SpawnInBoatGlobal"
	local THIS_JOB_ID = game.JobId

	local BAMBU_DANCE_ID = "rbxassetid://100049531177822"

	local function getCanoeTemplate()
		-- Chercher dans France (ex-Indonesia) ou Indonesia selon le nom actuel
		local evtFolder = ReplicatedStorage.Controllers.EventController.Events
		local indoEvt = evtFolder:FindFirstChild("France") or evtFolder:FindFirstChild("Indonesia")
		if indoEvt then
			local canoe = indoEvt:FindFirstChild("Canoe")
			if canoe then return canoe end
		end
		-- Fallback : chercher dans tout ReplicatedStorage
		for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
			if v.Name == "Canoe" and v:IsA("Model") then return v end
		end
		return nil
	end

	local function placeCanoeLike(canoeModel, animalPP)
		local targetCF = animalPP.CFrame * CFrame.Angles(0, math.pi, 0)
		canoeModel:SetPrimaryPartCFrame(targetCF)
	end

	local function playBambuDance(canoeModel)
		local bambu = canoeModel:FindFirstChild("Bambu Bambu Sahur")
		if not bambu then return end
		local ctrl = bambu:FindFirstChildOfClass("AnimationController")
		if not ctrl then return end
		local anim8r = ctrl:FindFirstChildOfClass("Animator") or Instance.new("Animator", ctrl)
		local anim = Instance.new("Animation")
		anim.AnimationId = BAMBU_DANCE_ID
		local track = anim8r:LoadAnimation(anim)
		track.Looped = true
		track:Play()
		anim:Destroy()
	end

	-- Fonction qui spawn le canoe sur CE serveur
	local function spawnOnThisServer(brainrot, mutation, amount)
		amount = tonumber(amount) or 1

		local AnimalData
		for _, data in pairs(Animals) do
			if data.DisplayName == brainrot or data.Name == brainrot then
				AnimalData = data; break
			end
		end
		if not AnimalData then
			warn("[BoatGlobal] Brainrot introuvable: " .. tostring(brainrot))
			return false, "Brainrot not found"
		end

		local mutParam
		if mutation and mutation ~= "" and mutation ~= "Normal" then
			if Mutations[mutation] then mutParam = mutation end
		end

		local canoeTemplate = getCanoeTemplate()
		if not canoeTemplate then
			warn("[BoatGlobal] Template Canoe introuvable!")
			return false, "Canoe template not found"
		end

		local road    = workspace:FindFirstChild("Road")
		local roadEnd = road and road:FindFirstChild("End")

		for i = 1, amount do
			task.spawn(function()
				local movingAnimals = workspace:FindFirstChild("MovingAnimals")
				if not movingAnimals then return end

				local knownAnimals = {}
				for _, a in ipairs(CollectionService:GetTagged("Animal")) do
					knownAnimals[a] = true
				end

				AnimalService.spawnAnimalCustom(AnimalData, mutParam, nil, nil, nil, nil)

				local animal = nil
				local deadline = tick() + 6
				while tick() < deadline do
					for _, a in ipairs(CollectionService:GetTagged("Animal")) do
						if not knownAnimals[a] and a.Parent == movingAnimals then
							animal = a; break
						end
					end
					if animal then break end
					task.wait(0.05)
				end

				if not animal then
					warn("[BoatGlobal] Animal introuvable après spawn")
					return
				end

				animal:SetAttribute("Traits", nil)

				-- Animation Idle
				local idleFolder = ReplicatedStorage:FindFirstChild("Animations")
					and ReplicatedStorage.Animations:FindFirstChild("Animals")
					and ReplicatedStorage.Animations.Animals:FindFirstChild(AnimalData.DisplayName)
				local idleAnim = idleFolder and idleFolder:FindFirstChild("Idle")
				if idleAnim then
					local animCtrl = animal:FindFirstChildOfClass("AnimationController")
					if animCtrl then
						local anim8r = animCtrl:FindFirstChildOfClass("Animator")
							or Instance.new("Animator", animCtrl)
						for _, t in ipairs(anim8r:GetPlayingAnimationTracks()) do t:Stop(0) end
						local track = anim8r:LoadAnimation(idleAnim)
						track.Looped = true
						track:Play()
					end
				end

				local animalPP = animal.PrimaryPart
				if not animalPP then return end

				local canoe = canoeTemplate:Clone()
				canoe.Parent = workspace
				for _, p in ipairs(canoe:GetDescendants()) do
					if p:IsA("BasePart") then
						p.Anchored = true
						p.CanCollide = false
					end
				end

				placeCanoeLike(canoe, animalPP)
				playBambuDance(canoe)

				local isBought = false
				local followConn
				followConn = RunService.Heartbeat:Connect(function()
					if isBought or not animal or not animal.Parent then
						followConn:Disconnect()
						return
					end
					placeCanoeLike(canoe, animalPP)
				end)

				-- Surveiller achat
				local prompt
				for _, d in ipairs(animal:GetDescendants()) do
					if d:IsA("ProximityPrompt") then prompt = d; break end
				end

				if prompt and roadEnd then
					local buyConn
					buyConn = RunService.Heartbeat:Connect(function()
						if not animal or not animal.Parent then buyConn:Disconnect(); return end
						if prompt:GetAttribute("TargetPlayer") ~= nil then
							buyConn:Disconnect()
							isBought = true
							local startCF = canoe.PrimaryPart.CFrame
							local _, ry, _ = startCF:ToEulerAnglesYXZ()
							local pos = startCF.Position
							startCF = CFrame.new(pos) * CFrame.Angles(0, ry, 0)
							canoe:SetPrimaryPartCFrame(startCF)
							local targetCF = CFrame.new(pos.X, pos.Y, roadEnd.Position.Z) * CFrame.Angles(0, ry, 0)
							local dist = math.abs(roadEnd.Position.Z - pos.Z)
							local duration = math.max(1, dist / 12)
							local t0 = tick()
							local slideConn
							slideConn = RunService.Heartbeat:Connect(function()
								local alpha = math.min((tick() - t0) / duration, 1)
								canoe:SetPrimaryPartCFrame(startCF:Lerp(targetCF, alpha))
								if alpha >= 1 then
									slideConn:Disconnect()
									canoe:Destroy()
								end
							end)
						end
					end)
				end
			end)
			task.wait(0.05)
		end
		return true
	end

	-- Recevoir les messages des autres serveurs
	local function registerHandler()
		if not _G.MessagingHub then return end
		_G.MessagingHub.Register(MSG_TYPE, function(data)
			if typeof(data) ~= "table" then return end
			if data.senderJobId == THIS_JOB_ID then return end
			spawnOnThisServer(data.brainrot, data.mutation, data.amount)
		end)
	end

	task.spawn(function()
		while not _G.MessagingHub do task.wait(0.5) end
		registerHandler()
	end)

	Conch.register("spawninboatglobal", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind = "argument", type = "Brainrot", name = "Brainrot" },
				{ kind = "argument", type = "Mutation",  name = "Mutation", optional = true },
				{ kind = "argument", type = "number",    name = "Amount",   optional = true }
		end,
		callback = function(brainrot, mutation, amount)
			amount = tonumber(amount) or 1

			-- Spawn sur CE serveur
			local ok, err = spawnOnThisServer(brainrot, mutation, amount)
			if not ok then return false, err end

			-- Broadcaster aux autres serveurs
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					brainrot    = brainrot,
					mutation    = mutation or "Normal",
					amount      = amount,
					senderJobId = THIS_JOB_ID,
				})
				return ("✅ %d '%s' spawné(s) en canoe sur TOUS les serveurs !"):format(amount, tostring(brainrot))
			else
				return ("✅ %d '%s' spawné(s) en canoe (local seulement - MessagingHub indisponible)"):format(amount, tostring(brainrot))
			end
		end,
	})
end

return module
