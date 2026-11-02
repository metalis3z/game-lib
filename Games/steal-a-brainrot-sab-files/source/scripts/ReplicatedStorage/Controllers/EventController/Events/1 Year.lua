
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

game:GetService("Debris")

local ContentProvider = game:GetService("ContentProvider")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local CameraController = require(ReplicatedStorage.Controllers.CameraController)
local HudController = require(ReplicatedStorage.Controllers.HudController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local v24 = Net:RemoteEvent("EventService/1 Year/CreateFirework")
local v25 = Net:RemoteEvent("EventService/1 Year/ExplodeTraitEffect")
local v26 = Net:RemoteEvent("EventService/1 Year/PhaseTaco")
local v27 = Net:RemoteEvent("EventService/1 Year/PhaseClaws")
local v28 = Net:RemoteEvent("EventService/1 Year/PhaseBrazilFocus")
local v29 = Net:RemoteEvent("EventService/1 Year/PhaseBrazilBurst")
local v30 = Net:RemoteEvent("EventService/1 Year/PhaseSombrero")
local scriptName = script.Name
local v32 = Trove.new()
local raycastParams = RaycastParams.new()

raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = {
	workspace.Map,
	workspace.Plots
}

function t1.OnStart(_)
	local ActiveEventData = EventController:GetActiveEventData(scriptName)

	assert(ActiveEventData)
	ReplicatedStorage:SetAttribute("1YearEvent", true)
	v32:Add(function()
		ReplicatedStorage:SetAttribute("1YearEvent", nil)
	end)

	local t2 = {}

	v32:Add(RunService.Heartbeat:Connect(function()
		local v243 = ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1

		if v243 >= 1 then
			return
		end

		for v244, v245 in t2 do
			v244:AdjustSpeed(v245 * v243)
		end
	end))
	EffectController:Activate("Blink")
	v32:Add(function()
		EffectController:Activate("Blink")
	end)
	SoundController:UpdateOST()
	CycleController:Update()

	local Events = ReplicatedStorage.Controllers.EventController.Events
	local v39 = Events:FindFirstChild("Raining Tacos")
	local v40 = Events:FindFirstChild("Crab Rave")
	local Brazil = Events:FindFirstChild("Brazil")
	local Mexico = Events:FindFirstChild("Mexico")
	local AnniversaryMap = ReplicatedStorage.Models.Events["1 Year"]:FindFirstChild("AnniversaryMap")
	local clone = nil

	if AnniversaryMap then
		clone = v32:Clone(AnniversaryMap)
		clone.Parent = workspace
	else
		warn("[1 Year] ReplicatedStorage.Models.Events['1 Year'].AnniversaryMap missing; map will not be cloned")
	end

	local Spotlights = nil
	local Flamethrowers = nil

	if clone then
		local StageFeatures = clone:FindFirstChild("StageFeatures")

		if StageFeatures then
			Spotlights = StageFeatures:FindFirstChild("Spotlights")
			Flamethrowers = StageFeatures:FindFirstChild("Flamethrowers")
		end
	end

	local color3 = Color3.fromRGB(20, 20, 20)
	local t3 = {}

	local function dimSpotlightNeons()
		if not Spotlights then
			return
		end

		for _, v247 in Spotlights:GetDescendants() do
			if v247:IsA("BasePart") and v247.Material == Enum.Material.Neon then
				if not t3[v247] then
					t3[v247] = v247.Color
				end

				v247.Color = color3
			end
		end
	end

	if Spotlights then
		VFX.disable(Spotlights, true)
		dimSpotlightNeons()
	end

	if Flamethrowers then
		VFX.disable(Flamethrowers, true)
	end

	v32:Add(Observers.observeTag("HideIn1Year", function(p2)
		local p2Parent = p2.Parent

		p2.Parent = script

		return function()
			pcall(function()
				p2.Parent = p2Parent
			end)
		end
	end, {
		workspace,
		script
	}))

	local t4 = {}
	local t5 = {}
	local Fireworks = ReplicatedStorage.Models.Events["1 Year"]:FindFirstChild("Fireworks")

	if Fireworks then
		local clone2 = v32:Clone(Fireworks)

		clone2.Parent = workspace

		for _, v56 in clone2:GetChildren() do
			if v56:IsA("BasePart") then
				table.insert(t4, v56)
			end
		end

		table.sort(t4, function(p3, p4)
			local v254 = tonumber(p3.Name) or tonumber(p3.Name:match("(%d+)$"))
			local v255 = tonumber(p4.Name) or tonumber(p4.Name:match("(%d+)$"))

			return (v254 or 0) < (v255 or 0)
		end)

		for _, v58 in t4 do
			t5[v58] = v58.CFrame
		end
	else
		warn("[1 Year] ReplicatedStorage.Models.Events['1 Year'].Fireworks missing; no firework launchers")
	end

	local random = Random.new()

	for _, v61 in t4 do
		v61.CFrame = t5[v61] - Vector3.new(0, v61.Size.Y * 1.1, 0)

		local v62 = TweenService:Create(v61, TweenInfo.new(random:NextNumber(3, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = t5[v61]
		})
		local v63 = v32:Add(function()
			v62:Cancel()
			v62:Destroy()
		end)

		v62.Completed:Once(function()
			v32:Remove(v63)
		end)
		v62:Play()
	end

	v32:Add(function()
		for _, v257 in t4 do
			TweenService:Create(v257, TweenInfo.new(1 + math.random() + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				CFrame = t5[v257] - Vector3.new(0, v257.Size.Y * 1.1, 0)
			}):Play()
		end
	end)

	local clone3 = ShakePresets.BumpS:Clone()

	v32:Add(clone3)
	clone3.Sustain = true
	v32:Add(ShakePresets.BindShakeToCamera(clone3, workspace.CurrentCamera))
	clone3:Start()
	v32:Add(task.delay(ActiveEventData.startedAt + 4 - workspace:GetServerTimeNow(), function()
		clone3:StopSustain()
	end))
	v32:Add(v24.OnClientEvent:Connect(function(t6: {[any]: any})
		for _, v260 in t6 do
			local v261 = t4[v260.Chosen]

			if v261 then
				local clone4 = script.Firework:Clone()

				clone4.CFrame = t5[v261]
				clone4.Parent = workspace

				local clone5 = script.FireworkStartup:Clone()

				clone5.CFrame = t5[v261] + Vector3.new(0, v261.Size.Y * 0.5 - clone5.Size.Y * 0.5, 0)
				clone5.Parent = workspace
				VFX.emit(clone5)

				local v264 = ReplicatedStorage.Sounds.Events:FindFirstChild("1 Year") or ReplicatedStorage.Sounds.Events:FindFirstChild("4th of July")

				if v264 then
					local v265 = v264:FindFirstChild("Trail Sound Ball")

					if v265 and v265:IsA("Sound") then
						local clone6 = v265:Clone()

						clone6.Parent = clone4
						clone6:Play()
						clone6.Ended:Once(function()
							clone6:Destroy()
						end)
					end

					local Shot = v264:FindFirstChild("Shot")

					if Shot and Shot:IsA("Sound") then
						local clone7 = Shot:Clone()

						clone7.Parent = clone5
						clone7:Play()
						clone7.Ended:Once(function()
							clone7:Destroy()
						end)
					end
				end

				task.delay(2, function()
					clone5:Destroy()
				end)

				local v269 = t5[v261] - Vector3.new(0, v261.Size.Y, 0)
				local v270 = t5[v261] + Vector3.new(0, v260.Height, 0)
				local v271 = v260.Height / 20
				local v272 = TweenService:Create(clone4, TweenInfo.new(v271, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					CFrame = v270
				})

				v272:Play()
				task.delay(v271 * 0.8, function()
					v272:Destroy()

					local v545 = ReplicatedStorage.Sounds.Events:FindFirstChild("1 Year") or ReplicatedStorage.Sounds.Events:FindFirstChild("4th of July")

					if v545 then
						local v546 = v545:FindFirstChild("Firework Explosion")

						if v546 and v546:IsA("Sound") then
							SoundController:PlaySound(v546, v270.Position)
						end
					end

					local clone8 = script.Effects["1"]:Clone()

					clone8.CFrame = v270
					clone8.Parent = workspace
					VFX.emit(clone8)
					clone4:Destroy()
					task.delay(4, function()
						clone8:Destroy()
					end)

					for _, v549 in v260.Falloffs do
						local u550 = nil

						if typeof(v549) == "Vector3" then
							u550 = v269 + v549

							local raycastResult = workspace:Raycast((v270 + v549).Position, Vector3.new(-0, -200, -0), raycastParams)

							if raycastResult then
								u550 = CFrame.new(raycastResult.Position)
							end
						end

						local clone9 = script.Falloff:Clone()

						clone9.CFrame = v270
						clone9.Parent = workspace

						local n1 = 0
						local connection = nil

						connection = RunService.PostSimulation:Connect(function(n2: number)
							debug.profilebegin("1 Year:Falloff")
							n1 += n2

							local v778 = u550 or (type(v549) ~= "string" or CFrame.new(ClientEventUtils.getAnimalPosition(v549))) or CFrame.identity
							local v779 = n1 / 2.3

							SharedEventUtils.pushPartCFrame(clone9, CFrame.new(MathUtils.quadBezier(v779, v270.Position, v270.Position + Vector3.new(0, v260.Height, 0) + (v778.Position - v270.Position) * Vector3.new(1, 0, 1) * 0.7, v778.Position)))

							if v779 >= 1 and type(v549) ~= "string" then
								local clone10 = script.GroundImpact:Clone()

								clone10.CFrame = v778 + Vector3.new(0, clone10.Size.Y * 0.5, 0)
								clone10.Parent = workspace
								VFX.emit(clone10)
								VFX.disable(clone9)
								task.delay(1.5, function()
									if clone10.Parent then
										TweenService:Create(clone10, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
											Transparency = 1
										}):Play()
									end

									if clone9.Parent then
										TweenService:Create(clone9, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
											Transparency = 1
										}):Play()
									end
								end)
								task.delay(3, function()
									clone9:Destroy()
									clone10:Destroy()
								end)
								connection:Disconnect()
							end

							debug.profileend()
						end)
					end
				end)
			end
		end
	end))

	if clone then
		local NPCs = clone:FindFirstChild("NPCs")

		if NPCs then
			local t7 = {}

			if v40 then
				for _, v68 in {
					"Animation5",
					"Animation6",
					"Animation7",
					"Animation8"
				} do
					local v69 = v40:FindFirstChild(v68)

					if v69 and v69:IsA("Animation") then
						table.insert(t7, v69)
					end
				end
			end

			local t8 = {}

			if Mexico then
				for _, v72 in {
					"RoachTrumpet",
					"RoachMaracas",
					"RoachAccordion",
					"RoachViolin"
				} do
					local v73 = Mexico:FindFirstChild(v72)

					if v73 and v73:IsA("Animation") then
						table.insert(t8, v73)
					end
				end
			end

			local n3 = 0
			local n4 = 0

			for _, v77 in NPCs:GetChildren() do
				if v77:IsA("Model") then
					local v78 = v77:FindFirstChildOfClass("AnimationController") or v77:FindFirstChildWhichIsA("AnimationController", true)

					if v78 then
						local Animator = v78:FindFirstChildOfClass("Animator")

						if Animator then
							local v80 = nil

							if v77.Name:match("^Crab") and #t7 > 0 then
								n3 = n3 % #t7 + 1
								v80 = t7[n3]
							elseif v77.Name:match("^Cockroach") and #t8 > 0 then
								n4 = n4 % #t8 + 1
								v80 = t8[n4]
							end

							if v80 then
								local v81 = Animator:LoadAnimation(v80)

								v81.Priority = Enum.AnimationPriority.Idle
								v81.Looped = true
								v81:Play()
								v32:Add(function()
									v81:Stop(0)
									v81:Destroy()
								end)
							end
						end
					end
				end
			end
		end
	end

	if clone then
		local MapMechanics = clone:FindFirstChild("MapMechanics")
		local Indonesia = Events:FindFirstChild("Indonesia")
		local v84 = Indonesia and Indonesia:FindFirstChild("BambuDance")

		if MapMechanics and v84 and v84:IsA("Animation") then
			for _, v86 in MapMechanics:GetChildren() do
				if v86:IsA("Model") and v86.Name:match("^Canoe") then
					local v87 = v86:FindFirstChild("Bambu Bambu Sahur")

					if v87 then
						local v88 = v87:FindFirstChildOfClass("AnimationController") or v87:FindFirstChildWhichIsA("AnimationController", true)
						local v89 = v88 and v88:FindFirstChildOfClass("Animator")

						if v89 then
							local v90 = v89:LoadAnimation(v84)

							v90.Priority = Enum.AnimationPriority.Idle
							v90.Looped = true
							v90:Play()
							v32:Add(function()
								v90:Stop(0)
								v90:Destroy()
							end)
						end
					end
				end
			end
		end
	end

	if clone then
		local Brainrots = clone:FindFirstChild("Brainrots")
		local Animations = ReplicatedStorage:FindFirstChild("Animations")
		local v93 = Animations and Animations:FindFirstChild("Animals")

		if Brainrots and v93 then
			for _, v95 in Brainrots:GetChildren() do
				if v95:IsA("Model") then
					local Name = v93:FindFirstChild(v95.Name)
					local v97 = Name and Name:FindFirstChild("Idle")

					if v97 and v97:IsA("Animation") then
						local v98 = v95:FindFirstChildOfClass("AnimationController") or v95:FindFirstChildWhichIsA("AnimationController", true)
						local v99 = v98 and v98:FindFirstChildOfClass("Animator")

						if v99 then
							local v100 = v99:LoadAnimation(v97)

							v100.Priority = Enum.AnimationPriority.Idle
							v100.Looped = true
							v100:Play()
							v32:Add(function()
								v100:Stop(0)
								v100:Destroy()
							end)
						end
					end
				end
			end
		end
	end

	if clone then
		local MapMechanics = clone:FindFirstChild("MapMechanics")

		if MapMechanics then
			local t9 = {}

			for _, v104 in MapMechanics:GetChildren() do
				if v104:IsA("Model") and v104.Name:match("^UFO") then
					table.insert(t9, {
						model = v104,
						initialPivot = v104:GetPivot(),
						phase = math.random() * 3.141592653589793 * 2
					})
				end
			end

			if #t9 > 0 then
				v32:Add(RunService.PostSimulation:Connect(function()
					debug.profilebegin("1 Year:UFOFloat")

					local ServerTimeNow = workspace:GetServerTimeNow()

					for _, v275 in t9 do
						local v276 = math.sin((ServerTimeNow + v275.phase) * 1.4) * 5

						v275.model:PivotTo(v275.initialPivot + Vector3.new(0, v276, 0))
					end

					debug.profileend()
				end))
			end
		end
	end

	local v105 = v40 and v40:FindFirstChild("Crab")

	v32:Add(Observers.observeTag("OneYearCrab", function(p5)
		if not v105 or not p5:IsA("Model") then
			return nil
		end

		local v278 = Trove.new()
		local HumanoidRootPart = p5:WaitForChild("HumanoidRootPart", 5)

		if not HumanoidRootPart then
			return v278:WrapClean()
		end

		local clone11 = v278:Clone(v105)
		local v281 = clone11:FindFirstChild("Cylinder.005")

		if not v281 then
			v278:Destroy()

			return nil
		end

		local v282 = v278:Add(Instance.new("Weld"))

		v282.Part0 = v281
		v282.Part1 = HumanoidRootPart
		v282.C1 = CFrame.new(0, 3.6, 0)
		v282.Parent = clone11
		clone11.Parent = p5

		local AnimationController = clone11:FindFirstChildOfClass("AnimationController")
		local v284 = AnimationController and AnimationController:FindFirstChildOfClass("Animator")

		if not v284 then
			return v278:WrapClean()
		end

		local function loadAnim(s1: string)
			local v556 = v40 and v40:FindFirstChild(s1)

			if not v556 or not v556:IsA("Animation") then
				return nil
			end

			local v557 = v284:LoadAnimation(v556)

			v278:Add(function()
				v557:Stop(0)
				v557:Destroy()
			end)

			return v557
		end

		local v286 = loadAnim("Animation1")
		local v287 = loadAnim("Animation2")
		local v288 = loadAnim("Animation3_Right")
		local v289 = loadAnim("Animation3_Left")

		if v289 then
			v289.Priority = Enum.AnimationPriority.Action
		end

		local v290 = loadAnim("Animation4_Walk")

		if v290 then
			v290.Priority = Enum.AnimationPriority.Action
		end

		local v291 = loadAnim("Animation4_Attack")

		if v291 then
			v291.Priority = Enum.AnimationPriority.Action4
		end

		local v292 = loadAnim("Animation5")
		local v293 = loadAnim("Animation6")
		local v294 = loadAnim("Animation7")
		local v295 = loadAnim("Animation8")

		for _, v297 in {
			v292,
			v293,
			v294,
			v295
		} do
			if v297 then
				v297.Priority = Enum.AnimationPriority.Action2
			end
		end

		local t10 = {}

		if v292 then
			t10[1] = v292
		end

		if v293 then
			t10[2] = v293
		end

		if v294 then
			t10[3] = v294
		end

		if v295 then
			t10[4] = v295
		end

		local u299 = v290
		local u300 = false
		local u301 = nil

		local function setDance(p6)
			if not u300 then
				return
			end

			local v562 = if type(p6) ~= "number" then if not p6 then nil else math.random(1, (math.max(1, #t10))) else p6
			local v563 = v562 and t10[v562]

			if v563 == u301 then
				return
			end

			if u301 then
				u301:Stop()
				u301 = nil
			end

			if v563 then
				u301 = v563
				v563:Play()
			end
		end

		v278:Add(p5:GetAttributeChangedSignal("Dance"):Connect(function()
			setDance(p5:GetAttribute("Dance"))
		end))

		local u303 = nil
		local u304 = nil
		local u305 = nil
		local v306 = v40 and v40:FindFirstChild("SanddrumRoll")

		if v306 then
			v278:Add(p5:GetAttributeChangedSignal("ReachedFirstTarget"):Once(function()
				if u303 then
					return
				end

				local clone12 = v278:Clone(v306)

				u303 = clone12

				local v565 = v278:Add(Instance.new("Weld"))

				v565.Part0 = clone12
				v565.Part1 = v281
				v565.C0 = CFrame.new(0.2, 3.629, 4.378)
				v565.Parent = clone12
				clone12.Parent = clone11
			end))
		end

		v278:Add(p5:GetAttributeChangedSignal("IsRunning"):Connect(function()
			local v566 = p5:GetAttribute("IsRunning") == true
			local v567 = u299

			if u304 then
				local ParticleEmitter = u304:FindFirstChildOfClass("ParticleEmitter")

				if ParticleEmitter then
					ParticleEmitter.Enabled = v566
				end
			end

			if u305 then
				local ParticleEmitter = u305:FindFirstChildOfClass("ParticleEmitter")

				if ParticleEmitter then
					ParticleEmitter.Enabled = v566
				end
			end

			if v566 and u301 then
				u301:Stop()
				u301 = nil
			elseif not v566 then
				setDance(p5:GetAttribute("Dance"))
			end

			if not v567 then
				return
			end

			if v566 then
				if not v567.IsPlaying then
					v567:Play()

					return
				end
			elseif v567.IsPlaying then
				v567:Stop()
			end
		end))

		if v291 then
			v278:Add(p5:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
				v291:Play()
			end))
		end

		local v307 = ActiveEventData.startedAt + 61
		local v308 = workspace:GetServerTimeNow() - v307 + 12.5

		if v308 < 7 and v286 then
			v286:Play()
		elseif v308 < 46 and v287 then
			v287:Play()
		end

		local v309 = v307 + -5.5 - workspace:GetServerTimeNow()

		if not (v309 <= 0) then
			v278:Add(task.delay(v309, function()
				if v286 then
					v286:Stop()
				end

				if v287 then
					v287:Play()
				end
			end))
		end

		local v310 = v307 + 15 - workspace:GetServerTimeNow()

		if not (v310 <= 0) then
			v278:Add(task.delay(v310, function()
				if v289 then
					local v574 = v289

					if v574 ~= u299 then
						local v575 = u299 and u299.IsPlaying

						if v575 and u299 then
							u299:Stop()
						end

						u299 = v574

						if not v575 then
						end
					end

					v289:Play(nil, nil, 0.3333333333333333)
				end

				local v576 = u303

				if v576 then
					local ParticleEmitter = v576:FindFirstChildOfClass("ParticleEmitter")

					if ParticleEmitter then
						ParticleEmitter.Enabled = false
					end

					task.delay(3, function()
						if v576.Parent then
							v576:Destroy()
						end
					end)
					u303 = nil
				end
			end))
		end

		local v311 = v40 and v40:FindFirstChild("WalkPart")
		local v312 = v307 + 18.5 - workspace:GetServerTimeNow()

		if not (v312 <= 0) then
			v278:Add(task.delay(v312, function()
				if v289 then
					v289:AdjustSpeed(1)
				end

				if v311 then
					local clone13 = v278:Clone(v311)

					u304 = clone13

					local v579 = v278:Add(Instance.new("Weld"))

					v579.Part0 = clone13
					v579.Part1 = v281
					v579.C0 = CFrame.new(0.614, 3.129, 4.731) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
					v579.Parent = clone13
					clone13.Parent = clone11

					local clone14 = v278:Clone(v311)

					u305 = clone14

					local v581 = v278:Add(Instance.new("Weld"))

					v581.Part0 = clone14
					v581.Part1 = v281
					v581.C0 = CFrame.new(0.414, 3.129, -4.78) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
					v581.Parent = clone14
					clone14.Parent = clone11

					local v582 = p5:GetAttribute("IsRunning") == true

					for _, v584 in {
						clone13,
						clone14
					} do
						local ParticleEmitter = v584:FindFirstChildOfClass("ParticleEmitter")

						if ParticleEmitter then
							ParticleEmitter.Enabled = v582
						end
					end
				end
			end))
		end

		local v313 = v307 + 30.5 - workspace:GetServerTimeNow()

		if not (v313 <= 0) then
			v278:Add(task.delay(v313, function()
				if v288 then
					v288:Play(nil, nil, 0.3333333333333333)
				end
			end))
		end

		local v314 = v307 + 33.5 - workspace:GetServerTimeNow()

		if not (v314 <= 0) then
			v278:Add(task.delay(v314, function()
				if v288 then
					v288:Stop()
				end

				local v586 = v290

				if v586 ~= u299 then
					local v587 = u299 and u299.IsPlaying

					if v587 and u299 then
						u299:Stop()
					end

					u299 = v586

					if v587 and v586 then
						v586:Play()
					end
				end

				u300 = true
				setDance(p5:GetAttribute("Dance"))
			end))
		end

		if v308 >= 46 then
			u300 = true
			setDance(p5:GetAttribute("Dance"))
		end

		return v278:WrapClean()
	end, { workspace }))

	local v106 = Mexico and Mexico:FindFirstChild("Cockroach")
	local v107 = Mexico and Mexico:FindFirstChild("Instruments")

	v32:Add(Observers.observeTag("OneYearRoach", function(p7)
		if not v106 or not p7:IsA("Model") then
			return nil
		end

		local v316 = Trove.new()
		local HumanoidRootPart = p7:WaitForChild("HumanoidRootPart", 5)

		if not HumanoidRootPart then
			return v316:WrapClean()
		end

		local clone15 = v316:Clone(v106)
		local PrimaryPart = clone15.PrimaryPart

		if not PrimaryPart then
			v316:Destroy()

			return nil
		end

		local v320 = v316:Add(Instance.new("Weld"))

		v320.Part0 = PrimaryPart
		v320.Part1 = HumanoidRootPart
		v320.Parent = PrimaryPart

		local AnimationController = clone15:FindFirstChild("AnimationController")

		if AnimationController then
			AnimationController:Destroy()
		end

		local Humanoid = Instance.new("Humanoid")

		Humanoid.Name = "AnimationController"
		Humanoid.EvaluateStateMachine = false
		Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		Humanoid.PlatformStand = true
		Humanoid.Parent = clone15

		local Animator = Instance.new("Animator")

		Animator.Parent = Humanoid
		clone15.Parent = p7

		local function loadAnim(p8, s2: string, p9, b1: boolean?)
			local v592 = Mexico and Mexico:FindFirstChild(s2)

			if not v592 or not v592:IsA("Animation") then
				return nil
			end

			local v593 = Animator:LoadAnimation(v592)

			if p9 then
				v593.Priority = p9
			end

			if b1 ~= nil then
				v593.Looped = b1
			end

			t2[v593] = 1
			p8:Add(function()
				t2[v593] = nil
				v593:Stop(0)
				v593:Destroy()
			end)

			return v593
		end

		local v325 = loadAnim(v316, "PutHat", Enum.AnimationPriority.Action4, false)
		local v326 = loadAnim(v316, "TakeHat", Enum.AnimationPriority.Action3, false)
		local u327 = nil


		local function setupInstrument(s3: string)
			if u327 then
				u327:Destroy()
			end

			local v595 = Trove.new()

			u327 = v595

			local v596 = loadAnim(v595, `Roach{ s3 }`, Enum.AnimationPriority.Action, true)
			local v597 = loadAnim(v595, `RoachWalk{ s3 }`, Enum.AnimationPriority.Action2, true) or loadAnim(v595, "RoachWalk", Enum.AnimationPriority.Action2, true)

			if s3 == "Maracas" and v596 then
				v596:AdjustSpeed(0.65)
			end

			local RootPart = clone15:FindFirstChild("RootPart")
			local v599 = RootPart and RootPart:FindFirstChild("VFX")

			if v599 then
				if s3 == "Sombrero" then
					VFX.disable(v599)
				else
					VFX.enable(v599)
				end
			end

			if s3 == "Sombrero" and v326 then
				v326:Play()
			end

			local v600 = v107 and v107:FindFirstChild(s3)

			if v600 then
				local clone16 = v595:Clone(v600)

				if clone16.PrimaryPart then
					local Weld = Instance.new("Weld")

					Weld.Part0 = clone16.PrimaryPart
					Weld.Part1 = PrimaryPart
					Weld.C0 = CFrame.new(0, 3.5, 0)
					Weld.Parent = clone16.PrimaryPart
				end

				for _, v604 in clone16:GetChildren() do
					local RigidConstraint = v604:FindFirstChildOfClass("RigidConstraint")

					if RigidConstraint then
						local RigidConstraintAttachment0 = RigidConstraint.Attachment0

						if RigidConstraintAttachment0 then
							local RigidConstraintAttachment0Name = clone15:FindFirstChild(RigidConstraintAttachment0.Name, true)

							if RigidConstraintAttachment0Name then
								RigidConstraint.Attachment1 = RigidConstraintAttachment0Name
							end
						end
					end
				end

				clone16.Parent = PrimaryPart

				local AnimationController2 = clone16:FindFirstChild("AnimationController")
				local v609 = AnimationController2 and AnimationController2:FindFirstChildOfClass("Animator")

				if v609 then
					local v610 = Mexico and Mexico:FindFirstChild(s3)

					if v610 and v610:IsA("Animation") then
						local v611 = v609:LoadAnimation(v610)

						v611.Priority = Enum.AnimationPriority.Action
						v611.Looped = true
						v611:Play()
						v595:Add(function()
							v611:Stop(0)
							v611:Destroy()
						end)
					end

					local v612 = Mexico and Mexico:FindFirstChild(`Walk{ s3 }`)

					if v612 and v612:IsA("Animation") then
						local v613 = v609:LoadAnimation(v612)

						v613.Priority = Enum.AnimationPriority.Action2
						v613.Looped = true
						v595:Add(function()
							v613:Stop(0)
							v613:Destroy()
						end)

						local function syncInstrumentWalk()
							if p7:GetAttribute("IsRunning") then
								if not v613.IsPlaying then
									v613:Play()
								end
							elseif v613.IsPlaying then
								v613:Stop()
							end
						end
						v595:Add(p7:GetAttributeChangedSignal("IsRunning"):Connect(syncInstrumentWalk))
						syncInstrumentWalk()
					end
				end
			end

			if v596 then
				v596:Play()
			end

			local function syncRoachWalk()
				if not v597 then
					return
				end
				if p7:GetAttribute("IsRunning") then
					if not v597.IsPlaying then
						v597:Play()
					end
				elseif v597.IsPlaying then
					v597:Stop()
				end
			end
			v595:Add(p7:GetAttributeChangedSignal("IsRunning"):Connect(syncRoachWalk))
			syncRoachWalk()
		end


		local Instrument = p7:GetAttribute("Instrument")

		setupInstrument(type(Instrument) ~= "string" and "Trumpet" or Instrument)
		v316:Add(p7:GetAttributeChangedSignal("Instrument"):Connect(function()
			local Instrument2 = p7:GetAttribute("Instrument")

			setupInstrument(type(Instrument2) ~= "string" and "Trumpet" or Instrument2)
		end))
		v316:Add(function()
			if u327 then
				u327:Destroy()
				u327 = nil
			end
		end)

		if v325 then
			v316:Add(p7:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
				v325:Play()
			end))
		end

		return v316:WrapClean()
	end, { workspace }))

	local t11 = {}

	local function scheduleMusic(s4: string, n5: number, n6: number, s5: string?, n7: number?)
		local s4_2 = workspace.Sounds:FindFirstChild(s4)

		if not s4_2 or not s4_2:IsA("Sound") then
			warn(`[1 Year] workspace.Sounds.{ s4 } missing for phase music`)

			return
		end

		local v336 = ActiveEventData.startedAt + n5
		local v337 = ActiveEventData.startedAt + n6
		local v338 = n7 or 0

		local function play()
			if workspace:GetServerTimeNow() >= v337 then
				return
			end

			EffectController:Activate("Blink")

			local v615 = v32:Extend()
			local u616 = false

			v615:Add(function()
				u616 = true
			end)

			local clone17 = s4_2:Clone()

			v615:Add(clone17)
			clone17.Parent = workspace
			clone17.Looped = false
			clone17.PlayOnRemove = false

			local g618

			if s5 then

				if u616 then
					return
				end

				g618 = nil

				repeat
					if clone17.IsLoaded then
						g618 = true
					end

					if g618 then
						break
					end

					task.wait()
				until u616

				if not g618 then
					return
				end
			end

			g618 = false
			t11[s4] = clone17
			v615:Add(function()
				if t11[s4] == clone17 then
					t11[s4] = nil
				end
			end)

			local clone17Volume = clone17.Volume

			clone17.Volume = 0
			clone17.TimePosition = v338 + math.max(0, workspace:GetServerTimeNow() - v336)
			clone17:Play()
			TweenService:Create(clone17, TweenInfo.new(1.2), {
				Volume = clone17Volume
			}):Play()
			v615:Add(task.delay(v337 - workspace:GetServerTimeNow() - 1.2, function()
				TweenService:Create(clone17, TweenInfo.new(1.2), {
					Volume = 0
				}):Play()
				task.wait(1.3)
				v615:Destroy()
			end))
		end

		local v340 = v336 - workspace:GetServerTimeNow()

		if v340 <= 0 then
			if v337 > workspace:GetServerTimeNow() then
				task.spawn(play)

				return
			end
		else
			v32:Add(task.delay(v340, play))
		end
	end

	scheduleMusic("RainingTacos", 0, 61)
	scheduleMusic("CrabRave", 61, 121, nil, 12.5)
	scheduleMusic("BrazilEvent", 121, 181, nil, 6)
	scheduleMusic("MexicoEvent", 181, 240, nil, 15)

	if clone then
		local DJSammy = clone:FindFirstChild("DJSammy", true)

		if DJSammy and DJSammy:IsA("Model") then
			local v111 = DJSammy:FindFirstChildOfClass("AnimationController") or DJSammy:FindFirstChildWhichIsA("AnimationController", true)
			local v112 = v111 and v111:FindFirstChildOfClass("Animator")

			if v112 then
				local t12 = {
					[1] = {
						mix = "RainingTacosSammy",
						music = "RainingTacos",
						model = "RainingTacos",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					},
					[2] = {
						mix = "CrabSammy",
						music = "CrabRave",
						model = "Crab",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					},
					[3] = {
						mix = "BrazilSammy",
						music = "BrazilEvent",
						model = "Brazil",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					},
					[4] = {
						mix = "MexicoSammy",
						music = "MexicoEvent",
						model = "Mexico",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					}
				}
				local AnimatedModels = DJSammy:FindFirstChild("AnimatedModels", true)
				local t13 = {}
				local t14 = {}

				local function applyVisibility(p10, b2: boolean)
					if p10:IsA("BasePart") or (p10:IsA("Decal") or p10:IsA("Texture")) then
						if t13[p10] == nil then
							t13[p10] = p10.Transparency
						end

						p10.Transparency = not b2 and 1 or t13[p10]

						return
					end

					if p10:IsA("ParticleEmitter") or p10:IsA("Beam") or p10:IsA("Trail") or p10:IsA("Light") or p10:IsA("LayerCollector") then
						if t14[p10] == nil then
							t14[p10] = p10.Enabled
						end

						p10.Enabled = not not b2 and t14[p10]
					end
				end

				if AnimatedModels then
					for _, v119 in AnimatedModels:GetChildren() do
						applyVisibility(v119, false)

						for _, v121 in v119:GetDescendants() do
							applyVisibility(v121, false)
						end
					end

					v32:Add(function()
						for v349, v350 in t13 do
							if v349.Parent then
								v349.Transparency = v350
							end
						end

						for v351, v352 in t14 do
							if v351.Parent then
								v351.Enabled = v352
							end
						end
					end)
				else
					warn("[1 Year] DJSammy.AnimatedModels not found; per-phase models will not show/hide correctly")
				end

				local t15 = {
					[1] = {
						startT = 0,
						endT = 61
					},
					[2] = {
						startT = 61,
						endT = 121
					},
					[3] = {
						startT = 121,
						endT = 181
					},
					[4] = {
						startT = 181,
						endT = 240
					}
				}

				local function loadSammyAnim(s6: string)
					local s6_2 = script:FindFirstChild(s6)

					if not s6_2 or not s6_2:IsA("Animation") then
						warn(`[1 Year] DJSammy animation '{ s6 }' not found (search: script -> DJSammy -> DJSammy descendants)`)

						return nil
					end

					local v355 = v112:LoadAnimation(s6_2)

					v355.Looped = false
					t2[v355] = 1
					v32:Add(function()
						t2[v355] = nil
						v355:Stop(0)
						v355:Destroy()
					end)

					return v355
				end

				local v124 = loadSammyAnim("DefaultSammy")
				local v125 = t12[1]
				local v126 = t15[1]

				if v125 and v126 then
					local startT = v126.startT
					local n8 = 1

					local function v129()
						if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + v126.endT then
							return
						end

						local v362 = loadSammyAnim(v125.mix)

						if not v362 and not v124 then
							return
						end

						local v363 = v32:Extend()
						local u364 = true
						local n9 = 0
						local u366 = nil
						local u367 = nil

						if AnimatedModels then
							u367 = AnimatedModels:FindFirstChild(v125.model) or AnimatedModels:FindFirstChild(v125.model, true)

							if not u367 then
								warn(`[1 Year] AnimatedModels child '{ v125.model }' not found for phase { n8 }; model show/hide skipped`)
							end
						end

						local function setModelVisible(b3: boolean)
							if not u367 then
								return
							end

							applyVisibility(u367, b3)

							for _, v631 in u367:GetDescendants() do
								applyVisibility(v631, b3)
							end
						end

						setModelVisible(false)
						v363:Add(function()
							setModelVisible(false)
						end)

						if v124 then
							v124.Priority = Enum.AnimationPriority.Action
							v363:Add(RunService.PostSimulation:Connect(function()
								local v632 = t11[v125.music]
								local v633 = math.clamp((not v632 and 0 or v632.PlaybackLoudness) / 700, 0, 1)
								local v634 = ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1

								v124:AdjustSpeed(v125.defaultSpeed * (v633 + 0.6) * v634)
							end))
						end

						if v362 then
							v362.Priority = Enum.AnimationPriority.Action
						end

						local function playNext()
							if not u364 then
								return
							end

							local v635 = ActiveEventData.startedAt + v126.endT - workspace:GetServerTimeNow()
							local v636 = not v362 and 0 or v362.Length
							local v637 = not v124 and 0 or v124.Length
							local v638

							if v124 and (v635 > 0 and v635 < math.max(v636, v637) + 0.25) then
								v638 = v124
							elseif v125.pattern == "double_default" then
								if n9 > 0 then
									v638 = v124
									n9 -= 1
								elseif u366 == v362 then
									v638 = v124
									n9 = 1
								else
									v638 = v362
								end
							else
								v638 = if u366 ~= v124 then v124 else v362
							end

							if not v638 then
								v638 = v124 or v362
							end

							if not v638 then
								return
							end

							if v124 then
								v124.Looped = false
							end

							local v639 = u366

							u366 = v638

							if v639 and v639 ~= v638 and v639.IsPlaying then
								v639:Stop(0)
							end

							setModelVisible(v638 == v362)

							if v638 == v362 and v362 then
								v362:AdjustSpeed(v125.mixSpeed)
							end

							v638:Play()
						end

						if v124 then
							v363:Add(v124.Stopped:Connect(function()
								if u364 and u366 == v124 then
									playNext()
								end
							end))
						end

						if v362 then
							v363:Add(v362.Stopped:Connect(function()
								if u364 and u366 == v362 then
									playNext()
								end
							end))
						end

						playNext()

						local v370 = ActiveEventData.startedAt + v126.endT - workspace:GetServerTimeNow()

						if v370 <= 0 then
							u364 = false

							if v362 and v362.IsPlaying then
								v362:Stop(0)
							end

							if v124 then
								v124.Looped = false

								if v124.IsPlaying then
									v124:Stop(0)
								end
							end

							if v362 then
								v362:Destroy()
							end

							v363:Destroy()
						else
							v32:Add(task.delay(v370, function()
								u364 = false

								if v362 and v362.IsPlaying then
									v362:Stop(0)
								end

								if v124 then
									v124.Looped = false

									if v124.IsPlaying then
										v124:Stop(0)
									end
								end

								if v362 then
									v362:Destroy()
								end

								v363:Destroy()
							end))
						end
					end

					local v130 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

					if startT <= v130 then
						task.spawn(v129)
					else
						v32:Add(task.delay(startT - v130, v129))
					end
				end

				local v131 = t12[2]
				local v132 = t15[2]

				if v131 and v132 then
					local startT = v132.startT
					local n10 = 2

					local function v135()
						if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + v132.endT then
							return
						end

						local v371 = loadSammyAnim(v131.mix)

						if not v371 and not v124 then
							return
						end

						local v372 = v32:Extend()
						local u373 = true
						local n11 = 0
						local u375 = nil
						local u376 = nil

						if AnimatedModels then
							u376 = AnimatedModels:FindFirstChild(v131.model) or AnimatedModels:FindFirstChild(v131.model, true)

							if not u376 then
								warn(`[1 Year] AnimatedModels child '{ v131.model }' not found for phase { n10 }; model show/hide skipped`)
							end
						end

						local function setModelVisible(b4: boolean)
							if not u376 then
								return
							end

							applyVisibility(u376, b4)

							for _, v642 in u376:GetDescendants() do
								applyVisibility(v642, b4)
							end
						end

						setModelVisible(false)
						v372:Add(function()
							setModelVisible(false)
						end)

						if v124 then
							v124.Priority = Enum.AnimationPriority.Action
							v372:Add(RunService.PostSimulation:Connect(function()
								local v643 = t11[v131.music]
								local v644 = math.clamp((not v643 and 0 or v643.PlaybackLoudness) / 700, 0, 1)
								local v645 = ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1

								v124:AdjustSpeed(v131.defaultSpeed * (v644 + 0.6) * v645)
							end))
						end

						if v371 then
							v371.Priority = Enum.AnimationPriority.Action
						end

						local function playNext()
							if not u373 then
								return
							end

							local v646 = ActiveEventData.startedAt + v132.endT - workspace:GetServerTimeNow()
							local v647 = not v371 and 0 or v371.Length
							local v648 = not v124 and 0 or v124.Length
							local v649

							if v124 and (v646 > 0 and v646 < math.max(v647, v648) + 0.25) then
								v649 = v124
							elseif v131.pattern == "double_default" then
								if n11 > 0 then
									v649 = v124
									n11 -= 1
								elseif u375 == v371 then
									v649 = v124
									n11 = 1
								else
									v649 = v371
								end
							else
								v649 = if u375 ~= v124 then v124 else v371
							end

							if not v649 then
								v649 = v124 or v371
							end

							if not v649 then
								return
							end

							if v124 then
								v124.Looped = false
							end

							local v650 = u375

							u375 = v649

							if v650 and v650 ~= v649 and v650.IsPlaying then
								v650:Stop(0)
							end

							setModelVisible(v649 == v371)

							if v649 == v371 and v371 then
								v371:AdjustSpeed(v131.mixSpeed)
							end

							v649:Play()
						end

						if v124 then
							v372:Add(v124.Stopped:Connect(function()
								if u373 and u375 == v124 then
									playNext()
								end
							end))
						end

						if v371 then
							v372:Add(v371.Stopped:Connect(function()
								if u373 and u375 == v371 then
									playNext()
								end
							end))
						end

						playNext()

						local v379 = ActiveEventData.startedAt + v132.endT - workspace:GetServerTimeNow()

						if v379 <= 0 then
							u373 = false

							if v371 and v371.IsPlaying then
								v371:Stop(0)
							end

							if v124 then
								v124.Looped = false

								if v124.IsPlaying then
									v124:Stop(0)
								end
							end

							if v371 then
								v371:Destroy()
							end

							v372:Destroy()
						else
							v32:Add(task.delay(v379, function()
								u373 = false

								if v371 and v371.IsPlaying then
									v371:Stop(0)
								end

								if v124 then
									v124.Looped = false

									if v124.IsPlaying then
										v124:Stop(0)
									end
								end

								if v371 then
									v371:Destroy()
								end

								v372:Destroy()
							end))
						end
					end

					local v136 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

					if startT <= v136 then
						task.spawn(v135)
					else
						v32:Add(task.delay(startT - v136, v135))
					end
				end

				local v137 = t12[3]
				local v138 = t15[3]

				if v137 and v138 then
					local startT = v138.startT
					local n12 = 3

					local function v141()
						if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + v138.endT then
							return
						end

						local v380 = loadSammyAnim(v137.mix)

						if not v380 and not v124 then
							return
						end

						local v381 = v32:Extend()
						local u382 = true
						local n13 = 0
						local u384 = nil
						local u385 = nil

						if AnimatedModels then
							u385 = AnimatedModels:FindFirstChild(v137.model) or AnimatedModels:FindFirstChild(v137.model, true)

							if not u385 then
								warn(`[1 Year] AnimatedModels child '{ v137.model }' not found for phase { n12 }; model show/hide skipped`)
							end
						end

						local function setModelVisible(b5: boolean)
							if not u385 then
								return
							end

							applyVisibility(u385, b5)

							for _, v653 in u385:GetDescendants() do
								applyVisibility(v653, b5)
							end
						end

						setModelVisible(false)
						v381:Add(function()
							setModelVisible(false)
						end)

						if v124 then
							v124.Priority = Enum.AnimationPriority.Action
							v381:Add(RunService.PostSimulation:Connect(function()
								local v654 = t11[v137.music]
								local v655 = math.clamp((not v654 and 0 or v654.PlaybackLoudness) / 700, 0, 1)
								local v656 = ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1

								v124:AdjustSpeed(v137.defaultSpeed * (v655 + 0.6) * v656)
							end))
						end

						if v380 then
							v380.Priority = Enum.AnimationPriority.Action
						end

						local function playNext()
							if not u382 then
								return
							end

							local v657 = ActiveEventData.startedAt + v138.endT - workspace:GetServerTimeNow()
							local v658 = not v380 and 0 or v380.Length
							local v659 = not v124 and 0 or v124.Length
							local v660

							if v124 and (v657 > 0 and v657 < math.max(v658, v659) + 0.25) then
								v660 = v124
							elseif v137.pattern == "double_default" then
								if n13 > 0 then
									v660 = v124
									n13 -= 1
								elseif u384 == v380 then
									v660 = v124
									n13 = 1
								else
									v660 = v380
								end
							else
								v660 = if u384 ~= v124 then v124 else v380
							end

							if not v660 then
								v660 = v124 or v380
							end

							if not v660 then
								return
							end

							if v124 then
								v124.Looped = false
							end

							local v661 = u384

							u384 = v660

							if v661 and v661 ~= v660 and v661.IsPlaying then
								v661:Stop(0)
							end

							setModelVisible(v660 == v380)

							if v660 == v380 and v380 then
								v380:AdjustSpeed(v137.mixSpeed)
							end

							v660:Play()
						end

						if v124 then
							v381:Add(v124.Stopped:Connect(function()
								if u382 and u384 == v124 then
									playNext()
								end
							end))
						end

						if v380 then
							v381:Add(v380.Stopped:Connect(function()
								if u382 and u384 == v380 then
									playNext()
								end
							end))
						end

						playNext()

						local v388 = ActiveEventData.startedAt + v138.endT - workspace:GetServerTimeNow()

						if v388 <= 0 then
							u382 = false

							if v380 and v380.IsPlaying then
								v380:Stop(0)
							end

							if v124 then
								v124.Looped = false

								if v124.IsPlaying then
									v124:Stop(0)
								end
							end

							if v380 then
								v380:Destroy()
							end

							v381:Destroy()
						else
							v32:Add(task.delay(v388, function()
								u382 = false

								if v380 and v380.IsPlaying then
									v380:Stop(0)
								end

								if v124 then
									v124.Looped = false

									if v124.IsPlaying then
										v124:Stop(0)
									end
								end

								if v380 then
									v380:Destroy()
								end

								v381:Destroy()
							end))
						end
					end

					local v142 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

					if startT <= v142 then
						task.spawn(v141)
					else
						v32:Add(task.delay(startT - v142, v141))
					end
				end

				local v143 = t12[4]
				local v144 = t15[4]

				if v143 and v144 then
					local startT = v144.startT
					local n14 = 4

					local function v147()
						if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + v144.endT then
							return
						end

						local v389 = loadSammyAnim(v143.mix)

						if not v389 and not v124 then
							return
						end

						local v390 = v32:Extend()
						local u391 = true
						local n15 = 0
						local u393 = nil
						local u394 = nil

						if AnimatedModels then
							u394 = AnimatedModels:FindFirstChild(v143.model) or AnimatedModels:FindFirstChild(v143.model, true)

							if not u394 then
								warn(`[1 Year] AnimatedModels child '{ v143.model }' not found for phase { n14 }; model show/hide skipped`)
							end
						end

						local function setModelVisible(b6: boolean)
							if not u394 then
								return
							end

							applyVisibility(u394, b6)

							for _, v664 in u394:GetDescendants() do
								applyVisibility(v664, b6)
							end
						end

						setModelVisible(false)
						v390:Add(function()
							setModelVisible(false)
						end)

						if v124 then
							v124.Priority = Enum.AnimationPriority.Action
							v390:Add(RunService.PostSimulation:Connect(function()
								local v665 = t11[v143.music]
								local v666 = math.clamp((not v665 and 0 or v665.PlaybackLoudness) / 700, 0, 1)
								local v667 = ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1

								v124:AdjustSpeed(v143.defaultSpeed * (v666 + 0.6) * v667)
							end))
						end

						if v389 then
							v389.Priority = Enum.AnimationPriority.Action
						end

						local function playNext()
							if not u391 then
								return
							end

							local v668 = ActiveEventData.startedAt + v144.endT - workspace:GetServerTimeNow()
							local v669 = not v389 and 0 or v389.Length
							local v670 = not v124 and 0 or v124.Length
							local v671

							if v124 and (v668 > 0 and v668 < math.max(v669, v670) + 0.25) then
								v671 = v124
							elseif v143.pattern == "double_default" then
								if n15 > 0 then
									v671 = v124
									n15 -= 1
								elseif u393 == v389 then
									v671 = v124
									n15 = 1
								else
									v671 = v389
								end
							else
								v671 = if u393 ~= v124 then v124 else v389
							end

							if not v671 then
								v671 = v124 or v389
							end

							if not v671 then
								return
							end

							if v124 then
								v124.Looped = false
							end

							local v672 = u393

							u393 = v671

							if v672 and v672 ~= v671 and v672.IsPlaying then
								v672:Stop(0)
							end

							setModelVisible(v671 == v389)

							if v671 == v389 and v389 then
								v389:AdjustSpeed(v143.mixSpeed)
							end

							v671:Play()
						end

						if v124 then
							v390:Add(v124.Stopped:Connect(function()
								if u391 and u393 == v124 then
									playNext()
								end
							end))
						end

						if v389 then
							v390:Add(v389.Stopped:Connect(function()
								if u391 and u393 == v389 then
									playNext()
								end
							end))
						end

						playNext()

						local v397 = ActiveEventData.startedAt + v144.endT - workspace:GetServerTimeNow()

						if v397 <= 0 then
							u391 = false

							if v389 and v389.IsPlaying then
								v389:Stop(0)
							end

							if v124 then
								v124.Looped = false

								if v124.IsPlaying then
									v124:Stop(0)
								end
							end

							if v389 then
								v389:Destroy()
							end

							v390:Destroy()
						else
							v32:Add(task.delay(v397, function()
								u391 = false

								if v389 and v389.IsPlaying then
									v389:Stop(0)
								end

								if v124 then
									v124.Looped = false

									if v124.IsPlaying then
										v124:Stop(0)
									end
								end

								if v389 then
									v389:Destroy()
								end

								v390:Destroy()
							end))
						end
					end

					local v148 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

					if startT <= v148 then
						task.spawn(v147)
					else
						v32:Add(task.delay(startT - v148, v147))
					end
				end
			end
		end
	end

	for _, v150 in {
		{
			name = "Raining Tacos",
			startOffset = 0,
			endOffset = 61
		},
		{
			name = "Crab Rave",
			startOffset = 61,
			endOffset = 121
		},
		{
			name = "Brazil",
			startOffset = 121,
			endOffset = 181
		},
		{
			name = "Mexico",
			startOffset = 181,
			endOffset = 240
		}
	} do
		local startOffset = v150.startOffset

		local function v152()
			local v398 = ActiveEventData.startedAt + v150.endOffset

			if v398 <= workspace:GetServerTimeNow() then
				return
			end

			local v399 = v32:Extend()

			v399:Add(HudController:ShowFakeEvent(v150.name, v398))

			local v400 = v398 - workspace:GetServerTimeNow()

			if v400 <= 0 then
				v399:Destroy()

				return
			end

			v32:Add(task.delay(v400, function()
				v399:Destroy()
			end))
		end

		local v153 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

		if startOffset <= v153 then
			task.spawn(v152)
		else
			v32:Add(task.delay(startOffset - v153, v152))
		end
	end

	local v154 = v40 and v40:FindFirstChild("Dance")

	if v154 then
		local v155 = ActiveEventData.startedAt + 94.5
		local n16 = 121
		local v157 = nil
		local v158 = nil
		local n17 = 8

		local function v160()
			if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + n16 then
				return
			end

			local v412 = v32:Extend()

			v412:Add(Observers.observeCharacter(Players.LocalPlayer, function(_, p12)
				local v677 = Trove.new()

				v677:Add(task.spawn(function()
					local Humanoid = p12:WaitForChild("Humanoid")

					if not Humanoid then
						return
					end

					local Animator = Humanoid:WaitForChild("Animator")

					if not Animator then
						return
					end

					local v798 = Animator:LoadAnimation(v154)

					v677:Add(function()
						v798:Stop()
						v798:Destroy()
					end)
					v798.Priority = Enum.AnimationPriority.Action

					if v157 then
						t2[v798] = 1
						v677:Add(function()
							t2[v798] = nil
						end)
					end

					local n18 = 0
					local n19 = 0

					v677:Add(RunService.PostSimulation:Connect(function(n20: number)
						debug.profilebegin("1 Year:Player:Dance")

						local ServerTimeNow = workspace:GetServerTimeNow()

						if v158 then
							local v818 = t11[v158]

							if v818 then
								local v819 = v818.PlaybackLoudness / 1000

								v798:AdjustSpeed((math.clamp(v819 / 0.07, 0.8, 1.5)))
							end
						end

						if v155 + n17 - ServerTimeNow > 0 then
							if not v798.IsPlaying then
								v798:Play()

								if v798.Length > 0 then
									v798.TimePosition = (ServerTimeNow - v155) % v798.Length
								end
							end

							debug.profileend()

							return
						end

						local Length = v798.Length

						if Length ~= n19 and Length > 0 then
							n19 = Length
							v798.TimePosition = (ServerTimeNow - v155) % Length
						end

						if Humanoid.MoveDirection == Vector3.new(0, 0, 0) and not Players.LocalPlayer:GetAttribute("Stealing") then
							if n18 < 3 then
								n18 += n20
							elseif not v798.IsPlaying then
								v798:Play()

								if v798.Length > 0 then
									v798.TimePosition = (ServerTimeNow - v155) % v798.Length
								end
							end
						else
							n18 = 0

							if v798.IsPlaying then
								v798:Stop()
							end
						end

						debug.profileend()
					end))
				end))

				return v677:WrapClean()
			end))

			local v413 = ActiveEventData.startedAt + n16 - workspace:GetServerTimeNow()

			if v413 > 0 then
				v412:Add(task.delay(v413, function()
					v412:Destroy()
				end))

				return
			end

			v412:Destroy()
		end

		local v161 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

		if v161 >= 94.5 then
			task.spawn(v160)
		else
			v32:Add(task.delay(94.5 - v161, v160))
		end
	end

	local v162 = Brazil and Brazil:FindFirstChild("Dance")

	if v162 then
		local v163 = ActiveEventData.startedAt + 136
		local n21 = 181
		local v165 = nil
		local s7 = "BrazilEvent"
		local n22 = 35

		local function v168()
			if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + n21 then
				return
			end

			local v414 = v32:Extend()

			v414:Add(Observers.observeCharacter(Players.LocalPlayer, function(_, p14)
				local v680 = Trove.new()

				v680:Add(task.spawn(function()
					local Humanoid = p14:WaitForChild("Humanoid")

					if not Humanoid then
						return
					end

					local Animator = Humanoid:WaitForChild("Animator")

					if not Animator then
						return
					end

					local v803 = Animator:LoadAnimation(v162)

					v680:Add(function()
						v803:Stop()
						v803:Destroy()
					end)
					v803.Priority = Enum.AnimationPriority.Action

					if v165 then
						t2[v803] = 1
						v680:Add(function()
							t2[v803] = nil
						end)
					end

					local n23 = 0
					local n24 = 0

					v680:Add(RunService.PostSimulation:Connect(function(n25: number)
						debug.profilebegin("1 Year:Player:Dance")

						local ServerTimeNow = workspace:GetServerTimeNow()

						if s7 then
							local v823 = t11[s7]

							if v823 then
								local v824 = v823.PlaybackLoudness / 1000

								v803:AdjustSpeed((math.clamp(v824 / 0.07, 0.8, 1.5)))
							end
						end

						if v163 + n22 - ServerTimeNow > 0 then
							if not v803.IsPlaying then
								v803:Play()

								if v803.Length > 0 then
									v803.TimePosition = (ServerTimeNow - v163) % v803.Length
								end
							end

							debug.profileend()

							return
						end

						local Length = v803.Length

						if Length ~= n24 and Length > 0 then
							n24 = Length
							v803.TimePosition = (ServerTimeNow - v163) % Length
						end

						if Humanoid.MoveDirection == Vector3.new(0, 0, 0) and not Players.LocalPlayer:GetAttribute("Stealing") then
							if n23 < 3 then
								n23 += n25
							elseif not v803.IsPlaying then
								v803:Play()

								if v803.Length > 0 then
									v803.TimePosition = (ServerTimeNow - v163) % v803.Length
								end
							end
						else
							n23 = 0

							if v803.IsPlaying then
								v803:Stop()
							end
						end

						debug.profileend()
					end))
				end))

				return v680:WrapClean()
			end))

			local v415 = ActiveEventData.startedAt + n21 - workspace:GetServerTimeNow()

			if v415 > 0 then
				v414:Add(task.delay(v415, function()
					v414:Destroy()
				end))

				return
			end

			v414:Destroy()
		end

		local v169 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

		if v169 >= 136 then
			task.spawn(v168)
		else
			v32:Add(task.delay(136 - v169, v168))
		end
	end

	local v170 = Mexico and Mexico:FindFirstChild("PlayerDance")

	if v170 then
		local v171 = ActiveEventData.startedAt + 194.5
		local n26 = 240
		local v173 = true
		local v174 = nil
		local n27 = 15

		local function v176()
			if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + n26 then
				return
			end

			local v416 = v32:Extend()

			v416:Add(Observers.observeCharacter(Players.LocalPlayer, function(_, p16)
				local v683 = Trove.new()

				v683:Add(task.spawn(function()
					local Humanoid = p16:WaitForChild("Humanoid")

					if not Humanoid then
						return
					end

					local Animator = Humanoid:WaitForChild("Animator")

					if not Animator then
						return
					end

					local v808 = Animator:LoadAnimation(v170)

					v683:Add(function()
						v808:Stop()
						v808:Destroy()
					end)
					v808.Priority = Enum.AnimationPriority.Action

					if v173 then
						t2[v808] = 1
						v683:Add(function()
							t2[v808] = nil
						end)
					end

					local n28 = 0
					local n29 = 0

					v683:Add(RunService.PostSimulation:Connect(function(n30: number)
						debug.profilebegin("1 Year:Player:Dance")

						local ServerTimeNow = workspace:GetServerTimeNow()

						if v174 then
							local v828 = t11[v174]

							if v828 then
								local v829 = v828.PlaybackLoudness / 1000

								v808:AdjustSpeed((math.clamp(v829 / 0.07, 0.8, 1.5)))
							end
						end

						if v171 + n27 - ServerTimeNow > 0 then
							if not v808.IsPlaying then
								v808:Play()

								if v808.Length > 0 then
									v808.TimePosition = (ServerTimeNow - v171) % v808.Length
								end
							end

							debug.profileend()

							return
						end

						local Length = v808.Length

						if Length ~= n29 and Length > 0 then
							n29 = Length
							v808.TimePosition = (ServerTimeNow - v171) % Length
						end

						if Humanoid.MoveDirection == Vector3.new(0, 0, 0) and not Players.LocalPlayer:GetAttribute("Stealing") then
							if n28 < 3 then
								n28 += n30
							elseif not v808.IsPlaying then
								v808:Play()

								if v808.Length > 0 then
									v808.TimePosition = (ServerTimeNow - v171) % v808.Length
								end
							end
						else
							n28 = 0

							if v808.IsPlaying then
								v808:Stop()
							end
						end

						debug.profileend()
					end))
				end))

				return v683:WrapClean()
			end))

			local v417 = ActiveEventData.startedAt + n26 - workspace:GetServerTimeNow()

			if v417 > 0 then
				v416:Add(task.delay(v417, function()
					v416:Destroy()
				end))

				return
			end

			v416:Destroy()
		end

		local v177 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

		if v177 >= 194.5 then
			task.spawn(v176)
		else
			v32:Add(task.delay(194.5 - v177, v176))
		end
	end

	local function v178()
		if Spotlights then
			for v418, v419 in t3 do
				if v418.Parent then
					v418.Color = v419
				end
			end

			VFX.enable(Spotlights, true)
		end

		if Flamethrowers then
			VFX.disable(Flamethrowers, true)

			local v420 = v32:Extend()
			local n31 = 0
			local u422 = false

			v420:Add(RunService.PostSimulation:Connect(function()
				local BrazilEvent = t11.BrazilEvent
				local v685 = not BrazilEvent and 0 or BrazilEvent.PlaybackLoudness
				local ServerTimeNow = workspace:GetServerTimeNow()

				if v685 >= 380 and (not u422 and ServerTimeNow - n31 >= 1.5) then
					n31 = ServerTimeNow
					u422 = true
					VFX.enable(Flamethrowers, true)
					v420:Add(task.delay(0.5, function()
						if u422 and Flamethrowers then
							VFX.disable(Flamethrowers, true)
							u422 = false
						end
					end))
				end
			end))

			local v423 = ActiveEventData.startedAt + 181 - workspace:GetServerTimeNow()

			if v423 <= 0 then
				v420:Destroy()
			else
				v32:Add(task.delay(v423, function()
					v420:Destroy()
				end))
			end
		end
	end

	local v179 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

	if v179 >= 121 then
		task.spawn(v178)
	else
		v32:Add(task.delay(121 - v179, v178))
	end

	local function v180()
		if Spotlights then
			VFX.disable(Spotlights, true)
			dimSpotlightNeons()
		end

		if Flamethrowers then
			VFX.disable(Flamethrowers, true)
		end
	end

	local v181 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

	if v181 >= 181 then
		task.spawn(v180)
	else
		v32:Add(task.delay(181 - v181, v180))
	end

	local function v182()
		if not Mexico then
			return
		end

		if workspace:GetServerTimeNow() >= ActiveEventData.startedAt + 240 then
			return
		end

		local v424 = v32:Extend()
		local MapTsunami = nil

		if ServerData.IsTsunamiServer() then
			MapTsunami = Mexico:FindFirstChild("MapTsunami")
		end

		if not MapTsunami and ServerData.IsBiggerServer() then
			MapTsunami = Mexico:FindFirstChild("MapBigger")
		end

		if not MapTsunami then
			MapTsunami = Mexico:FindFirstChild("Map")
		end

		local v426 = MapTsunami and MapTsunami:FindFirstChild("mexicoeventvfx")

		if v426 then
			local clone18 = v424:Clone(v426)

			clone18.Parent = workspace
			VFX.enable(clone18, true)
		else
			warn("[1 Year] Mexico mexicoeventvfx subfolder missing; phase 4 decor skipped")
		end

		local v428 = ActiveEventData.startedAt + 240 - workspace:GetServerTimeNow()

		if v428 <= 0 then
			v424:Destroy()

			return
		end

		v32:Add(task.delay(v428, function()
			v424:Destroy()
		end))
	end

	local v183 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

	if v183 >= 181 then
		task.spawn(v182)
	else
		v32:Add(task.delay(181 - v183, v182))
	end

	local function v184()
		if not Spotlights then
			return
		end

		local v429 = v32:Extend()
		local color3_2 = Color3.fromRGB(128, 255, 0)
		local color3_3 = Color3.fromRGB(0, 255, 0)
		local t16 = {}
		local t17 = {}
		local t18 = {}
		local t19 = {}
		local t20 = {}
		local t21 = {}
		local t22 = {}
		local t23 = {}
		local t24 = {}
		local t25 = {}
		local t26 = {}

		for _, v444 in Spotlights:GetDescendants() do
			if v444:IsA("Beam") then
				table.insert(t24, v444)

				local Attachment1 = v444.Attachment1

				if Attachment1 and not t17[Attachment1] then
					local WorldPosition = Attachment1.WorldPosition

					t17[Attachment1] = WorldPosition

					local v447 = math.random() * 3.141592653589793 * 2

					t18[Attachment1] = WorldPosition + Vector3.new(math.cos(v447) * 30, 0, math.sin(v447) * 30)

					local v448 = math.random() * 3.141592653589793 * 2

					t19[Attachment1] = WorldPosition + Vector3.new(math.cos(v448) * 30, 0, math.sin(v448) * 30)
					table.insert(t16, Attachment1)
				end
			elseif v444:IsA("SpotLight") or v444:IsA("PointLight") then
				table.insert(t25, v444)

				if v444:IsA("SpotLight") and v444.Parent and v444.Parent:IsA("BasePart") then
					local Parent = v444.Parent

					if not t21[Parent] then
						t21[Parent] = Parent.CFrame

						local ParentPosition = Parent.Position
						local v451 = math.random() * 3.141592653589793 * 2

						t22[Parent] = ParentPosition + Vector3.new(math.cos(v451) * 30, 0, math.sin(v451) * 30)

						local ParentPosition2 = Parent.Position
						local v453 = math.random() * 3.141592653589793 * 2

						t23[Parent] = ParentPosition2 + Vector3.new(math.cos(v453) * 30, 0, math.sin(v453) * 30)
						table.insert(t20, Parent)
					end
				end
			elseif v444:IsA("BasePart") and v444.Material == Enum.Material.Neon then
				table.insert(t26, v444)
			end
		end

		v429:Add(function()
			for v690, v691 in t21 do
				if v690.Parent then
					v690.CFrame = v691
				end
			end
		end)

		local n32 = 1
		local n33 = 0
		local n34 = 0

		v429:Add(RunService.PostSimulation:Connect(function(n35: number)
			debug.profilebegin("1 Year:Phase3SpotlightSync")
			n33 -= n35

			local BrazilEvent = t11.BrazilEvent
			local v694 = not BrazilEvent and 0 or BrazilEvent.PlaybackLoudness
			local v695 = math.clamp(v694 / 1000, 0, 1)
			local ServerTimeNow = workspace:GetServerTimeNow()

			if v694 >= 320 and ServerTimeNow - n34 >= 2 then
				n34 = ServerTimeNow

				for v697 in t19 do
					local v698 = t19
					local v699 = t17[v697]
					local v700 = math.random() * 3.141592653589793 * 2

					v698[v697] = v699 + Vector3.new(math.cos(v700) * 30, 0, math.sin(v700) * 30)
				end

				for v701 in t23 do
					local v702 = t23
					local Position = t21[v701].Position
					local v704 = math.random() * 3.141592653589793 * 2

					v702[v701] = Position + Vector3.new(math.cos(v704) * 30, 0, math.sin(v704) * 30)
				end
			end

			local v705 = math.lerp(35, 120, (math.clamp((v694 - 100) / 200, 0, 1))) * n35

			for _, v707 in t16 do
				local v708 = t18[v707]
				local v709 = t19[v707]
				local v710 = v709 - v708

				if v705 > v710.Magnitude then
					local v711 = t19
					local v712 = t17[v707]
					local v713 = math.random() * 3.141592653589793 * 2

					v711[v707] = v712 + Vector3.new(math.cos(v713) * 30, 0, math.sin(v713) * 30)
				else
					v709 = v708 + v710.Unit * v705
				end

				t18[v707] = v709
				v707.WorldCFrame = CFrame.new(v709)
			end

			for _, v715 in t20 do
				local v716 = t22[v715]
				local v717 = t23[v715]
				local v718 = v717 - v716

				if v705 > v718.Magnitude then
					local v719 = t23
					local Position = t21[v715].Position
					local v721 = math.random() * 3.141592653589793 * 2

					v719[v715] = Position + Vector3.new(math.cos(v721) * 30, 0, math.sin(v721) * 30)
				else
					v717 = v716 + v718.Unit * v705
				end

				t22[v715] = v717

				local v722 = t21[v715]

				v715.CFrame = CFrame.lookAt(v722.Position, v717)
			end

			if v695 >= 0.11 and n33 <= 0 then
				n33 = 0.4
				n32 = n32 ~= 1 and 1 or 2

				local v723 = if n32 ~= 1 then color3_3 else color3_2
				local colorSequence = ColorSequence.new(v723)

				for _, v726 in t24 do
					v726.Color = colorSequence
				end

				for _, v728 in t25 do
					v728.Color = v723
				end

				for _, v730 in t26 do
					v730.Color = v723
				end
			end

			debug.profileend()
		end))

		local v457 = ActiveEventData.startedAt + 181 - workspace:GetServerTimeNow()

		if v457 <= 0 then
			v429:Destroy()
		else
			v32:Add(task.delay(v457, function()
				v429:Destroy()
			end))
		end
	end

	local v185 = workspace:GetServerTimeNow() - ActiveEventData.startedAt

	if v185 >= 121 then
		task.spawn(v184)
	else
		v32:Add(task.delay(121 - v185, v184))
	end

	local t27 = {
		[1] = "1YearTacosPhase",
		[2] = "1YearClawsPhase",
		[3] = "1YearBrazilPhase",
		[4] = "1YearMexicoPhase"
	}

	local function activatePhaseGrass(n36: number)
		for _, v460 in t27 do
			ReplicatedStorage:SetAttribute(v460, nil)
		end

		ReplicatedStorage:SetAttribute(t27[n36], true)
		EffectController:Run("OneYearEvent", "GrassRecolor")
	end

	v32:Add(function()
		for _, v462 in t27 do
			ReplicatedStorage:SetAttribute(v462, nil)
		end

		EffectController:Stop("OneYearEvent", "GrassRecolor")
	end)

	local ServerTimeNow = workspace:GetServerTimeNow()

	for v189, v190 in {
		0,
		61,
		121,
		181
	} do
		local v191 = ActiveEventData.startedAt + v190
		local v192 = ActiveEventData.startedAt + ({
			61,
			121,
			181,
			240
		})[v189]
		local v193 = v191 - ServerTimeNow

		if v193 <= 0 then
			if ServerTimeNow < v192 then
				task.spawn(activatePhaseGrass, v189)
			end
		else
			v32:Add(task.delay(v193, activatePhaseGrass, v189))
		end
	end

	local function setupPhase2Ocean()
		if not v40 then
			return
		end

		local v463 = if not ServerData.IsBiggerServer() then v40:FindFirstChild("Ocean") else v40:FindFirstChild("OceanBigger")

		if not v463 then
			warn("[1 Year] Crab Rave Ocean template missing")

			return
		end

		local v464 = v32:Extend()
		local v465 = ActiveEventData.startedAt + 121 - workspace:GetServerTimeNow()

		if v465 <= 0 then
			v464:Destroy()

			return
		end

		v32:Add(task.delay(v465, function()
			v464:Destroy()
		end))

		local v466 = not ServerData.IsBiggerServer() and 400 or 902
		local clone19 = v464:Clone(v463)

		clone19.Parent = workspace

		local v468 = ActiveEventData.startedAt + 61 + 45 - workspace:GetServerTimeNow()

		for _, v470 in clone19:GetChildren() do
			if v470:IsA("Beam") then
				local TextureLength = v470.TextureLength

				if v468 > 0 then
					v470.TextureLength = 0
					TweenService:Create(v470, TweenInfo.new(v468, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
						TextureLength = TextureLength
					}):Play()
				else
					v470.TextureLength = TextureLength
				end
			end
		end

		local att1 = clone19:FindFirstChild("att1")

		if att1 then
			local vector3 = Vector3.new(0, 0, v466)

			if v468 > 0 then
				TweenService:Create(att1, TweenInfo.new(v468, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
					Position = vector3
				}):Play()
			else
				att1.Position = vector3
			end
		end

		local oceanparticles = clone19:FindFirstChild("oceanparticles")

		if oceanparticles then
			if v468 > 0 then
				v464:Add(task.delay(v468, function()
					VFX.enable(oceanparticles)
				end))

				return
			end

			VFX.enable(oceanparticles)
		end
	end

	local v195 = ActiveEventData.startedAt + 121
	local ServerTimeNow2 = workspace:GetServerTimeNow()

	if ServerTimeNow2 < v195 then
		local v197 = ActiveEventData.startedAt + 51 - ServerTimeNow2

		if v197 <= 0 then
			task.spawn(setupPhase2Ocean)
		else
			v32:Add(task.delay(v197, setupPhase2Ocean))
		end
	end

	local v198 = ActiveEventData.startedAt + 61 + 5
	local v199 = ActiveEventData.startedAt + 121

	local function startFovPump()
		if workspace:GetServerTimeNow() >= v199 then
			return
		end

		local v475 = v32:Extend()
		local n37 = 0

		v475:Add(RunService.PostSimulation:Connect(function(n38: number)
			debug.profilebegin("1 Year:CrabRaveFov")
			n37 -= n38

			local CrabRave = t11.CrabRave
			local v733 = math.clamp(((not CrabRave and 0 or CrabRave.PlaybackLoudness) - 100) / 900, 0, 1)

			if v733 >= 0.25 and n37 <= 0 then
				n37 = 0.1
				CameraController:Fov((v733 - 0.25) * 20 + 70, 0.1)
			end

			debug.profileend()
		end))

		local v477 = v199 - workspace:GetServerTimeNow()

		if v477 <= 0 then
			v475:Destroy()
		else
			v32:Add(task.delay(v477, function()
				v475:Destroy()
			end))
		end
	end

	if v199 > workspace:GetServerTimeNow() then
		local v201 = v198 - workspace:GetServerTimeNow()

		if v201 <= 0 then
			task.spawn(startFovPump)
		else
			v32:Add(task.delay(v201, startFovPump))
		end
	end

	local v202 = ActiveEventData.startedAt + 121
	local v203 = ActiveEventData.startedAt + 181

	local function startFovPump2()
		if workspace:GetServerTimeNow() >= v203 then
			return
		end

		local v478 = v32:Extend()
		local n39 = 0

		v478:Add(RunService.PostSimulation:Connect(function(n40: number)
			debug.profilebegin("1 Year:BrazilFov")
			n39 -= n40

			local BrazilEvent = t11.BrazilEvent
			local v736 = math.clamp((not BrazilEvent and 0 or BrazilEvent.PlaybackLoudness) / 1000, 0, 1)

			if v736 >= 0.1 and n39 <= 0 then
				n39 = 0.1
				CameraController:Fov(v736 / 0.7 * 15 + 70, 0.1)
			end

			debug.profileend()
		end))

		local v480 = v203 - workspace:GetServerTimeNow()

		if v480 <= 0 then
			v478:Destroy()
		else
			v32:Add(task.delay(v480, function()
				v478:Destroy()
			end))
		end
	end

	if v203 > workspace:GetServerTimeNow() then
		local v205 = v202 - workspace:GetServerTimeNow()

		if v205 <= 0 then
			task.spawn(startFovPump2)
		else
			v32:Add(task.delay(v205, startFovPump2))
		end
	end

	local v206 = not ServerData.IsBiggerServer() and "TacoAmbient" or "TacoAmbientBigger"
	local v207 = v39 and v39:FindFirstChild(v206)

	if v207 then
		local ok, result = pcall(require, ReplicatedStorage.Shared.MapInformation)

		if ok and result and result.MapCenter then
			local v210 = v32:Extend()
			local clone20 = v210:Clone(v207)

			clone20:PivotTo(result.MapCenter.CFrame + Vector3.new(0, 40, 0))
			clone20.Parent = workspace
			v210:Add(task.delay(ActiveEventData.startedAt + 61 - workspace:GetServerTimeNow(), function()
				for _, v482 in clone20:GetDescendants() do
					if v482:IsA("ParticleEmitter") then
						v482.Enabled = false
					end
				end

				task.wait(5)
				v210:Destroy()
			end))
		end
	end

	local v212 = v39 and v39:FindFirstChild("Cannon")
	local v213 = v39 and v39:FindFirstChild("Taco")
	local v214 = v39 and v39:FindFirstChild("StruckVFX")
	local u215 = nil
	local ShootPart = nil
	local u217 = nil
	local u218 = nil

	if v212 then
		local clone21 = v32:Clone(v212)
		local Pivot = clone21:GetPivot()

		for _, v222 in clone21:GetDescendants() do
			if v222:IsA("BasePart") and v222:HasTag("Grass") then
				v222.Transparency = 1
				v222.CanCollide = false
				v222.CanQuery = false
				v222.CanTouch = false
			end
		end

		local function updateCannonPosition()
			local v483 = Pivot

			if ServerData.IsBiggerServer() then
				v483 = CFrame.new(-410.091, 24.718, -393.962) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
			end

			if ReplicatedStorage:GetAttribute("DivineStairsEnabled") == true then
				v483 -= Vector3.new(0, 11, 0)
			end

			local v484 = v483 + Vector3.new(0, 10, 0)

			clone21:PivotTo(v484)
		end

		v32:Add(ReplicatedStorage:GetAttributeChangedSignal("DivineStairsEnabled"):Connect(updateCannonPosition))
		updateCannonPosition()
		ShootPart = clone21:FindFirstChild("ShootPart", true)

		local Top = clone21:FindFirstChild("Top")
		local Bottom = clone21:FindFirstChild("Bottom")
		local u226 = nil
		local u227 = nil

		if Top then
			local v228 = Top:FindFirstChild("Meshes/tacolauncher_Cube.004")

			u226 = v228 and v228:FindFirstChild("Meshes/tacolauncher_Cube.003")
		end

		if Bottom then
			local RootPart = Bottom:FindFirstChild("RootPart")

			u227 = RootPart and RootPart:FindFirstChild("Meshes/tacolauncher_Cube.004")
		end

		u217 = Spring.new(0)
		u217.Speed = 6.5
		u217.Damper = 0.85
		u218 = Spring.new(0)
		u218.Speed = 9
		u218.Damper = 0.6
		v32:Add(RunService.PostSimulation:Connect(function(_)
			debug.profilebegin("1 Year:TacoCannonSpring")

			if u226 and u217 then
				u226.C1 = CFrame.new(u217.Position, 0, 0)
			end

			if u227 and u218 then
				u227.C1 = CFrame.Angles(0, 0, -math.rad(u218.Position))
			end

			debug.profileend()
		end))
		clone21.Parent = workspace
		u215 = clone21

		local v230 = ActiveEventData.startedAt + 61 - workspace:GetServerTimeNow()

		if v230 > 0 then
			v32:Add(task.delay(v230, function()
				if u215 then
					u215:Destroy()
					u215 = nil
					ShootPart = nil
				end
			end))
		else
			clone21:Destroy()
			u215 = nil
			ShootPart = nil
		end
	end

	v32:Add(v26.OnClientEvent:Connect(function(s8: string, n41: number, n42: number?)
		local v489 = u215
		local v490 = ShootPart

		if not v489 or (not v490 or not v213 or not v214) then
			return
		end

		local v491 = v32:Extend()
		local clone22 = v491:Clone(v213)

		clone22.Parent = workspace

		local v493 = n42 or 2.5

		v491:Add(task.delay(v493 + 2, function()
			v491:Destroy()
		end))
		task.spawn(function()
			local v737 = ReplicatedStorage.Sounds.Events:FindFirstChild("Raining Tacos")
			local v738 = v737 and v737:FindFirstChild("Shoot")

			if v738 and v738:IsA("Sound") then
				SoundController:PlaySound(v738, v489:GetPivot().Position)
			end
		end)
		task.spawn(function()
			if u218 then
				u218:Impulse(650)
			end

			task.wait(0.05)

			if u217 then
				u217:Impulse(35)
			end
		end)

		local CFramePosition = v490.CFrame.Position

		v491:Add(RunService.PreRender:Connect(function()
			debug.profilebegin("1 Year:Taco")

			local v739 = ClientEventUtils.getAnimalPosition(s8)

			if not v739 then
				return
			end

			local v740 = CFramePosition + (v739 - CFramePosition) * 0.5 + Vector3.new(0, 60, 0)
			local v741 = math.clamp(1 - (n41 + v493 - workspace:GetServerTimeNow()) / v493, 0, 1)
			local v742 = MathUtils.quadBezier(v741, CFramePosition, v740, v739)
			local v743 = MathUtils.quadBezier(v741 + 0.1, CFramePosition, v740, v739)

			clone22.CFrame = CFrame.lookAt(v742, v743)

			if v741 >= 1 then
				local v744 = ReplicatedStorage.Sounds.Events:FindFirstChild("Raining Tacos")
				local v745 = v744 and v744:FindFirstChild("Hit")

				ClientEventUtils.playBurst(v214, s8, if not v745 or not v745:IsA("Sound") then nil else { v745 })
				v491:Destroy()
			end

			debug.profileend()
		end))
	end))
	v32:Add(v27.OnClientEvent:Connect(function(s9: string)
		local v496 = v40 and v40:FindFirstChild("CrabHit")

		if not v496 then
			return
		end

		local v497 = ReplicatedStorage.Sounds.Events:FindFirstChild("Crab Rave")
		local v498 = v497 and v497:FindFirstChild("Brainrot Hit")

		ClientEventUtils.playBurst(v496, s9, if not v498 or not v498:IsA("Sound") then nil else { v498 })
	end))

	local u231 = nil

	v32:Add(v28.OnClientEvent:Connect(function(s10: string?)
		u231 = s10
	end))
	v32:Add(v29.OnClientEvent:Connect(function(s11: string)
		local v501 = Brazil and Brazil:FindFirstChild("Burst")

		if not v501 then
			return
		end

		local Brazil2 = ReplicatedStorage.Sounds.Events:FindFirstChild("Brazil")
		local v503 = Brazil2 and Brazil2:FindFirstChild("Hit")

		ClientEventUtils.playBurst(v501, s11, if not v503 or not v503:IsA("Sound") then nil else { v503 })
	end))

	local color3_4 = Color3.fromRGB(128, 255, 0)
	local color3_5 = Color3.fromRGB(0, 255, 0)

	v32:Add(Observers.observeTag("OneYearBrazilHitbox", function(p18)
		local v505 = Trove.new()
		local BrazilEvent = script:FindFirstChild("BrazilEvent")
		local BrazilBeam = nil
		local t28 = {}
		local t29 = {}
		local t30 = {}
		local t31 = {}
		local t32 = {}
		local t33 = {}
		local vector3 = Vector3.new(9, 9, 9)
		local u515 = nil
		local n43 = 0
		local u517 = nil

		if BrazilEvent then
			local clone23 = v505:Clone(BrazilEvent)

			clone23.Parent = workspace
			VFX.enable(clone23)
			BrazilBeam = clone23:FindFirstChild("BrazilBeam", true)

			if BrazilBeam then
				local Bottom = BrazilBeam:FindFirstChild("Bottom")
				local Top = BrazilBeam:FindFirstChild("Top")

				if Bottom then
					for _, v522 in Bottom:GetChildren() do
						if v522:IsA("Attachment") then
							t31[v522] = v522.Position
							table.insert(t33, v522)
							v522.Position = v522.Position * Vector3.new(1, 1, 1) * 9
						end
					end
				end

				if Top then
					for _, v524 in Top:GetChildren() do
						if v524:IsA("Attachment") then
							t31[v524] = v524.Position
							table.insert(t32, v524)
							v524.Position = v524.Position * Vector3.new(1, 1, 1) * 9
						end
					end
				end
			end

			for _, v526 in clone23:GetDescendants() do
				if v526:IsA("ParticleEmitter") or v526:IsA("Beam") then
					table.insert(t28, v526)
				elseif v526:IsA("SpotLight") or v526:IsA("PointLight") then
					table.insert(t29, v526)
				elseif v526:IsA("BasePart") and v526.Material == Enum.Material.Neon then
					table.insert(t30, v526)
				end
			end
		end

		local n44 = 1
		local n45 = 0
		local u529 = color3_4
		local colorSequence = ColorSequence.new(color3_4)
		local u531 = false

		v505:Add(RunService.PostSimulation:Connect(function(n46: number)
			debug.profilebegin("1 Year:Phase3Beam")

			if u231 ~= u517 then
				u515 = vector3
				u517 = u231
			end

			local ServerTimeNow3 = workspace:GetServerTimeNow()
			local Focused = p18:GetAttribute("Focused")
			local v749 = if not u231 or (not Focused or not (Focused <= ServerTimeNow3)) then nil else ClientEventUtils.getAnimalModel(u231)

			if u231 and v749 then
				assert(Focused)

				if not u531 then
					u531 = true

					local Brazil3 = ReplicatedStorage.Sounds.Events:FindFirstChild("Brazil")
					local v751 = Brazil3 and Brazil3:FindFirstChild("Cube")

					if v751 and v751:IsA("Sound") then
						local clone24 = v751:Clone()

						clone24.Parent = p18
						clone24:Play()
						clone24.Ended:Once(function()
							clone24:Destroy()
						end)
					end
				end

				local v753 = math.clamp((ServerTimeNow3 - Focused) / 1, 0, 1)

				n43 = math.clamp((ServerTimeNow3 - (Focused + 1)) / 1, 0, 1)

				local VfxInstance = v749:FindFirstChild("VfxInstance")
				local v755 = (((if not VfxInstance then v749:GetExtentsSize() else VfxInstance.Size)) * Vector3.new(1.25, 1.5, 1.25)):Min((Vector3.new(9, 18, 9)))

				if not u515 then
					u515 = vector3
				end

				assert(u515)

				local v756 = u515:Lerp(v755, v753)
				local v757 = u515:Lerp(Vector3.new(v755.X, 0, v755.Z), v753)

				vector3 = v756

				for _, v759 in t32 do
					v759.Position = (t31[v759] + Vector3.new(0, n43 * 1, 0)) * v756
				end

				for _, v761 in t33 do
					v761.Position = t31[v761] * v757
				end
			else
				if u531 then
					u531 = false
				end

				local v762 = math.exp(n46 * -4)

				vector3 = Vector3.new(9, 9, 9):Lerp(vector3, v762)
				u515 = vector3
				n43 = math.lerp(0, n43, v762)

				for _, v764 in t32 do
					v764.Position = (t31[v764] + Vector3.new(0, n43 * 1, 0)) * vector3
				end

				for _, v766 in t33 do
					v766.Position = t31[v766] * vector3
				end
			end

			if BrazilBeam then
				SharedEventUtils.pushPartCFrame(BrazilBeam, p18.CFrame)
			end

			n45 -= n46

			local BrazilEvent2 = t11.BrazilEvent

			if math.clamp((not BrazilEvent2 and 0 or BrazilEvent2.PlaybackLoudness) / 1000, 0, 1) >= 0.11 and n45 <= 0 then
				n45 = 0.4
				n44 = n44 ~= 1 and 1 or 2
				u529 = if n44 ~= 1 then color3_5 else color3_4
				colorSequence = ColorSequence.new(u529)

				for _, v769 in t28 do
					v769.Color = colorSequence
				end

				for _, v771 in t29 do
					v771.Color = u529
				end

				for _, v773 in t30 do
					v773.Color = u529
				end
			end

			debug.profileend()
		end))

		return v505:WrapClean()
	end, { workspace }))
	v32:Add(v30.OnClientEvent:Connect(function(p19)
		local v533 = Mexico and Mexico:FindFirstChild("Burst")

		if not v533 then
			return
		end

		local Mexico2 = ReplicatedStorage.Sounds.Events:FindFirstChild("Mexico")
		local v535 = Mexico2 and Mexico2:FindFirstChild("Hit")

		ClientEventUtils.playBurst(v533, p19, if not v535 or not v535:IsA("Sound") then nil else { v535 })
	end))
end
function t1.OnStop(_)
	v32:Destroy()
end
function t1.OnLoad(_)
	task.spawn(pcall, function()
		local t34 = {}

		for _, v538 in script:GetChildren() do
			table.insert(t34, v538)
		end

		local Events = ReplicatedStorage.Controllers.EventController.Events

		local function collectAnimations(p22)
			if not p22 then
				return
			end

			for _, v776 in p22:GetDescendants() do
				if v776:IsA("Animation") then
					table.insert(t34, v776)
				end
			end
		end

		collectAnimations(Events:FindFirstChild("Crab Rave"))
		collectAnimations(Events:FindFirstChild("Mexico"))
		collectAnimations(Events:FindFirstChild("Raining Tacos"))
		collectAnimations(Events:FindFirstChild("Brazil"))
		collectAnimations(Events:FindFirstChild("Indonesia"))
		ContentProvider:PreloadAsync(t34)
	end)
	v25.OnClientEvent:Connect(function(p23)
		local v542 = ReplicatedStorage.Sounds.Events:FindFirstChild("1 Year") or ReplicatedStorage.Sounds.Events:FindFirstChild("4th of July")
		local v543 = v542 and v542:FindFirstChild("Brainrot Hit")
		local v544 = if not v543 or not v543:IsA("Sound") then nil else { v543 }

		ClientEventUtils.playBurst(script.FireworkBurst, p23, v544)
	end)
end

return t1
