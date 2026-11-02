local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local CollectionService = game:GetService("CollectionService")
	local RunService        = game:GetService("RunService")

	local Animals   = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local BAMBU_DANCE_ID = "rbxassetid://100049531177822"
	local canoeTemplate  = ReplicatedStorage.Controllers.EventController.Events.Indonesia.Canoe

	-- Place le canoe en utilisant SetPrimaryPartCFrame (évite le pivot tordu du canoe)
	-- Le canoe se place exactement comme le weld dans l'event Indonesia :
	-- Part0 (canoe PP) = animalPP.CFrame * CFrame.Angles(0, pi, 0)
	local function placeCanoeLike(canoeModel, animalPP)
		local targetCF = animalPP.CFrame * CFrame.Angles(0, math.pi, 0)
		canoeModel:SetPrimaryPartCFrame(targetCF)
	end

	local function playBambuDance(canoeModel)
		local bambu = canoeModel:FindFirstChild("Bambu Bambu Sahur")
		if not bambu then warn("[canoe] Bambu introuvable") return end
		local ctrl = bambu:FindFirstChildOfClass("AnimationController")
		if not ctrl then warn("[canoe] AnimationController introuvable") return end
		local anim8r = ctrl:FindFirstChildOfClass("Animator")
			or Instance.new("Animator", ctrl)
		local anim = Instance.new("Animation")
		anim.AnimationId = BAMBU_DANCE_ID
		local track = anim8r:LoadAnimation(anim)
		track.Looped = true
		track:Play()
		anim:Destroy()
		print("[canoe] BambuDance joué ✅")
	end

	Conch.register("spawnbrainrotcanoe", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind = "argument", type = "Brainrot", name = "Brainrot" },
				{ kind = "argument", type = "Mutation",  name = "Mutation" },
				{ kind = "argument", type = "number",    name = "Amount", optional = true }
		end,
		callback = function(brainrot, mutation, amount)
			amount = tonumber(amount) or 1
			if amount < 1 then return false, "Amount must be at least 1." end

			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					AnimalData = data break
				end
			end
			if not AnimalData then
				return false, ("Brainrot '%s' not found."):format(tostring(brainrot))
			end

			local mutParam
			if mutation ~= nil and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then
					return false, ("Mutation '%s' not found."):format(tostring(mutation))
				end
				mutParam = mutation
			end

			local road    = workspace:FindFirstChild("Road")
			local roadEnd = road and road:FindFirstChild("End")

			for i = 1, amount do
				task.spawn(function()
					local movingAnimals = workspace:FindFirstChild("MovingAnimals")
					if not movingAnimals then return end

					local knownAnimals = {}
					for _, a in ipairs(CollectionService:GetTagged("Animal")) do
						knownAnimals[a.Name] = true
					end

					AnimalService.spawnAnimalCustom(AnimalData, mutParam, nil, nil, nil, nil)

					-- Attendre le nouvel animal
					local animal = nil
					local deadline = tick() + 5
					while tick() < deadline do
						for _, a in ipairs(CollectionService:GetTagged("Animal")) do
							if not knownAnimals[a.Name] and a.Parent == movingAnimals then
								animal = a break
							end
						end
						if animal then break end
						task.wait(0.05)
					end

					if not animal then warn("[canoe] Animal introuvable") return end
					animal:SetAttribute("Traits", nil)

					-- Jouer l'Idle du brainrot (stoppe le Walk)
					local idleFolder = ReplicatedStorage.Animations.Animals:FindFirstChild(AnimalData.DisplayName)
					local idleAnim   = idleFolder and idleFolder:FindFirstChild("Idle")
					if idleAnim then
						local animCtrl = animal:FindFirstChildOfClass("AnimationController")
						if animCtrl then
							local anim8r = animCtrl:FindFirstChildOfClass("Animator")
								or Instance.new("Animator", animCtrl)
							-- Stopper walk
							for _, t in ipairs(anim8r:GetPlayingAnimationTracks()) do t:Stop(0) end
							local track = anim8r:LoadAnimation(idleAnim)
							track.Looped = true
							track:Play()
							print("[canoe] Idle brainrot joué ✅")
						end
					end

					local animalPP = animal.PrimaryPart
					if not animalPP then return end

					-- Cloner et placer le canoe correctement
					local canoe = canoeTemplate:Clone()
					canoe.Parent = workspace
					for _, p in ipairs(canoe:GetDescendants()) do
						if p:IsA("BasePart") then
							p.Anchored   = true
							p.CanCollide = false
						end
					end

					-- Placement initial
					placeCanoeLike(canoe, animalPP)

					-- Jouer BambuDance
					playBambuDance(canoe)

					-- Suivre l'animal en temps réel
					local isBought = false
					local followConn
					followConn = RunService.Heartbeat:Connect(function()
						if isBought then followConn:Disconnect() return end
						if not animal or not animal.Parent then followConn:Disconnect() return end
						placeCanoeLike(canoe, animalPP)
					end)

					-- Surveiller l'achat
					local prompt = nil
					for _, d in ipairs(animal:GetDescendants()) do
						if d:IsA("ProximityPrompt") then prompt = d break end
					end

					if prompt and roadEnd then
						local buyConn
						buyConn = RunService.Heartbeat:Connect(function()
							if not animal or not animal.Parent then buyConn:Disconnect() return end
							if prompt:GetAttribute("TargetPlayer") ~= nil then
								buyConn:Disconnect()
								isBought = true

								-- Récupérer le CFrame actuel du PP du canoe (bien orienté)
								local startCF = canoe.PrimaryPart.CFrame
								-- Extraire seulement position + rotation Y → canoe à plat
								local _, ry, _ = startCF:ToEulerAnglesYXZ()
								local pos = startCF.Position
								startCF = CFrame.new(pos) * CFrame.Angles(0, ry, 0)
								canoe:SetPrimaryPartCFrame(startCF)

								local targetCF = CFrame.new(pos.X, pos.Y, roadEnd.Position.Z)
									* CFrame.Angles(0, ry, 0)

								local dist     = math.abs(roadEnd.Position.Z - pos.Z)
								local duration = math.max(1, dist / 12)
								local t0       = tick()

								local slideConn
								slideConn = RunService.Heartbeat:Connect(function()
									local alpha = math.min((tick() - t0) / duration, 1)
									canoe:SetPrimaryPartCFrame(startCF:Lerp(targetCF, alpha))
									if alpha >= 1 then
										slideConn:Disconnect()
										canoe:Destroy()
									end
								end)
								print("[canoe] ✅ Achat → canoe continue seul")
							end
						end)
					end

					print(("[canoe] ✅ %s spawné avec canoe"):format(tostring(brainrot)))
				end)
				task.wait(0.05)
			end

			return ("✅ %d '%s' spawné(s) dans le canoe !"):format(amount, tostring(brainrot))
		end,
	})
end

return module
