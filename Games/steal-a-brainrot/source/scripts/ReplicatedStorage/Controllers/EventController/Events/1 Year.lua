--willly
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
game:GetService("Debris")
local ContentProvider = game:GetService("ContentProvider")
require(ReplicatedStorage.Shared.EventTypes)
local t = {}
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
local v1 = Net:RemoteEvent("EventService/1 Year/CreateFirework")
local v2 = Net:RemoteEvent("EventService/1 Year/ExplodeTraitEffect")
local v3 = Net:RemoteEvent("EventService/1 Year/PhaseTaco")
local v4 = Net:RemoteEvent("EventService/1 Year/PhaseClaws")
local v5 = Net:RemoteEvent("EventService/1 Year/PhaseBrazilFocus")
local v6 = Net:RemoteEvent("EventService/1 Year/PhaseBrazilBurst")
local v7 = Net:RemoteEvent("EventService/1 Year/PhaseSombrero")
local v8 = script.Name
local v9 = Trove.new()
local v10 = RaycastParams.new()
v10.FilterType = Enum.RaycastFilterType.Include
v10.FilterDescendantsInstances = { workspace.Map, workspace.Plots }
local function sortLaunchers(p1) --[[ sortLaunchers | Line: 63 ]]
	table.sort(p1, function(p1, p2) --[[ Line: 64 ]]
		local v2 = tonumber(p1.Name)
		if not v2 then
			v2 = tonumber(p1.Name:match("(%d+)$"))
		end
		local v5 = tonumber(p2.Name)
		if not v5 then
			v5 = tonumber(p2.Name:match("(%d+)$"))
		end
		return (v2 or 0) < (v5 or 0)
	end)
end
function t.OnStart(p1) --[[ OnStart | Line: 71 | Upvalues: EventController (copy), v8 (copy), ReplicatedStorage (copy), v9 (copy), RunService (copy), EffectController (copy), SoundController (copy), CycleController (copy), VFX (copy), Observers (copy), TweenService (copy), ShakePresets (copy), v1 (copy), v10 (copy), ClientEventUtils (copy), SharedEventUtils (copy), MathUtils (copy), Trove (copy), EncryptedAssetsController (copy), HudController (copy), Players (copy), ServerData (copy), CameraController (copy), Spring (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy) ]]
	local v12 = EventController:GetActiveEventData(v8)
	assert(v12)
	ReplicatedStorage:SetAttribute("1YearEvent", true)
	v9:Add(function() --[[ Line: 76 | Upvalues: ReplicatedStorage (ref) ]]
		ReplicatedStorage:SetAttribute("1YearEvent", nil)
	end)
	local t = {}
	local function registerSlowdownTrack(p1, p2) --[[ registerSlowdownTrack | Line: 85 | Upvalues: t (copy) ]]
		t[p1] = p2 or 1
	end
	local function unregisterSlowdownTrack(p1) --[[ unregisterSlowdownTrack | Line: 88 | Upvalues: t (copy) ]]
		t[p1] = nil
	end
	v9:Add(RunService.Heartbeat:Connect(function() --[[ Line: 91 | Upvalues: ReplicatedStorage (ref), t (copy) ]]
		local v1 = ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1
		if v1 >= 1 then
			return
		end
		for v2, v3 in t do
			v2:AdjustSpeed(v3 * v1)
		end
	end))
	EffectController:Activate("Blink")
	v9:Add(function() --[[ Line: 104 | Upvalues: EffectController (ref) ]]
		EffectController:Activate("Blink")
	end)
	SoundController:UpdateOST()
	CycleController:Update()
	local Events = ReplicatedStorage.Controllers.EventController.Events
	local v2 = Events:FindFirstChild("Raining Tacos")
	local v32 = Events:FindFirstChild("Crab Rave")
	local Brazil = Events:FindFirstChild("Brazil")
	local Mexico = Events:FindFirstChild("Mexico")
	local AnniversaryMap = ReplicatedStorage.Models.Events["1 Year"]:FindFirstChild("AnniversaryMap")
	local v42 = nil
	if AnniversaryMap then
		local v52 = v9:Clone(AnniversaryMap)
		v52.Parent = workspace
		v42 = v52
	else
		warn("[1 Year] ReplicatedStorage.Models.Events[\'1 Year\'].AnniversaryMap missing; map will not be cloned")
	end
	local v62 = nil
	local v72 = nil
	if v42 then
		local StageFeatures = v42:FindFirstChild("StageFeatures")
		if StageFeatures then
			v62 = StageFeatures:FindFirstChild("Spotlights")
			v72 = StageFeatures:FindFirstChild("Flamethrowers")
		end
	end
	local v82 = Color3.fromRGB(20, 20, 20)
	local t2 = {}
	local function dimSpotlightNeons() --[[ dimSpotlightNeons | Line: 142 | Upvalues: v62 (ref), t2 (copy), v82 (copy) ]]
		if not v62 then
			return
		end
		for v1, v2 in v62:GetDescendants() do
			if v2:IsA("BasePart") and v2.Material == Enum.Material.Neon then
				if not t2[v2] then
					t2[v2] = v2.Color
				end
				v2.Color = v82
			end
		end
	end
	local function restoreSpotlightNeons() --[[ restoreSpotlightNeons | Line: 156 | Upvalues: t2 (copy) ]]
		for v1, v2 in t2 do
			if v1.Parent then
				v1.Color = v2
			end
		end
	end
	if v62 then
		VFX.disable(v62, true)
		dimSpotlightNeons()
	end
	if v72 then
		VFX.disable(v72, true)
	end
	v9:Add(Observers.observeTag("HideIn1Year", function(p1) --[[ Line: 172 ]]
		local v1 = p1.Parent
		p1.Parent = script
		return function() --[[ Line: 175 | Upvalues: p1 (copy), v1 (copy) ]]
			pcall(function() --[[ Line: 176 | Upvalues: p1 (ref), v1 (ref) ]]
				p1.Parent = v1
			end)
		end
	end, { workspace, script }))
	local t3 = {}
	local t4 = {}
	local Fireworks = ReplicatedStorage.Models.Events["1 Year"]:FindFirstChild("Fireworks")
	if Fireworks then
		local v92 = v9:Clone(Fireworks)
		v92.Parent = workspace
		for v102, v11 in v92:GetChildren() do
			if v11:IsA("BasePart") then
				table.insert(t3, v11)
			end
		end
		table.sort(t3, function(p1, p2) --[[ Line: 64 ]]
			local v2 = tonumber(p1.Name)
			if not v2 then
				v2 = tonumber(p1.Name:match("(%d+)$"))
			end
			local v5 = tonumber(p2.Name)
			if not v5 then
				v5 = tonumber(p2.Name:match("(%d+)$"))
			end
			return (v2 or 0) < (v5 or 0)
		end)
		for v122, v13 in t3 do
			t4[v13] = v13.CFrame
		end
	else
		warn("[1 Year] ReplicatedStorage.Models.Events[\'1 Year\'].Fireworks missing; no firework launchers")
	end
	local v14 = Random.new()
	for v15, v16 in t3 do
		v16.CFrame = t4[v16] - Vector3.new(0, v16.Size.Y * 1.1, 0)
		local v19 = TweenService:Create(v16, TweenInfo.new(v14:NextNumber(3, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = t4[v16]
		})
		local v20 = v9:Add(function() --[[ Line: 213 | Upvalues: v19 (copy) ]]
			v19:Cancel()
			v19:Destroy()
		end)
		v19.Completed:Once(function() --[[ Line: 218 | Upvalues: v9 (ref), v20 (copy) ]]
			v9:Remove(v20)
		end)
		v19:Play()
	end
	v9:Add(function() --[[ Line: 225 | Upvalues: t3 (copy), TweenService (ref), t4 (copy) ]]
		for v1, v2 in t3 do
			local v4 = TweenInfo.new(1 + math.random() + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			local t = {}
			t.CFrame = t4[v2] - Vector3.new(0, v2.Size.Y * 1.1, 0)
			TweenService:Create(v2, v4, t):Play()
		end
	end)
	local v21 = ShakePresets.BumpS:Clone()
	v9:Add(v21)
	v21.Sustain = true
	v9:Add(ShakePresets.BindShakeToCamera(v21, workspace.CurrentCamera))
	v21:Start()
	v9:Add(task.delay(v12.startedAt + 4 - workspace:GetServerTimeNow(), function() --[[ Line: 239 | Upvalues: v21 (copy) ]]
		v21:StopSustain()
	end))
	v9:Add(v1.OnClientEvent:Connect(function(p1) --[[ Line: 245 | Upvalues: t3 (copy), t4 (copy), VFX (ref), ReplicatedStorage (ref), TweenService (ref), SoundController (ref), v10 (ref), RunService (ref), ClientEventUtils (ref), SharedEventUtils (ref), MathUtils (ref) ]]
		for v1, v2 in p1 do
			local v3 = t3[v2.Chosen]
			if v3 then
				local v4 = script.Firework:Clone()
				v4.CFrame = t4[v3]
				v4.Parent = workspace
				local v5 = script.FireworkStartup:Clone()
				v5.CFrame = t4[v3] + Vector3.new(0, v3.Size.Y * 0.5 - v5.Size.Y * 0.5, 0)
				v5.Parent = workspace
				VFX.emit(v5)
				local v8 = ReplicatedStorage.Sounds.Events:FindFirstChild("1 Year") or ReplicatedStorage.Sounds.Events:FindFirstChild("4th of July")
				if v8 then
					local v9 = v8:FindFirstChild("Trail Sound Ball")
					if v9 and v9:IsA("Sound") then
						local v102 = v9:Clone()
						v102.Parent = v4
						v102:Play()
						v102.Ended:Once(function() --[[ Line: 277 | Upvalues: v102 (copy) ]]
							v102:Destroy()
						end)
					end
					local Shot = v8:FindFirstChild("Shot")
					if Shot and Shot:IsA("Sound") then
						local v11 = Shot:Clone()
						v11.Parent = v5
						v11:Play()
						v11.Ended:Once(function() --[[ Line: 287 | Upvalues: v11 (copy) ]]
							v11:Destroy()
						end)
					end
				end
				task.delay(2, function() --[[ Line: 293 | Upvalues: v5 (copy) ]]
					v5:Destroy()
				end)
				local v13 = t4[v3] - Vector3.new(0, v3.Size.Y, 0)
				local v15 = t4[v3] + Vector3.new(0, v2.Height, 0)
				local v16 = v2.Height / 20
				local v17 = TweenService:Create(v4, TweenInfo.new(v16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					CFrame = v15
				})
				v17:Play()
				task.delay(v16 * 0.8, function() --[[ Line: 305 | Upvalues: v17 (copy), ReplicatedStorage (ref), SoundController (ref), v15 (copy), VFX (ref), v4 (copy), v2 (copy), v13 (copy), v10 (ref), RunService (ref), ClientEventUtils (ref), SharedEventUtils (ref), MathUtils (ref), TweenService (ref) ]]
					v17:Destroy()
					local v1 = ReplicatedStorage.Sounds.Events:FindFirstChild("1 Year") or ReplicatedStorage.Sounds.Events:FindFirstChild("4th of July")
					if v1 then
						local v22 = v1:FindFirstChild("Firework Explosion")
						if v22 and v22:IsA("Sound") then
							SoundController:PlaySound(v22, v15.Position)
						end
					end
					local v3 = script.Effects["1"]:Clone()
					v3.CFrame = v15
					v3.Parent = workspace
					VFX.emit(v3)
					v4:Destroy()
					task.delay(4, function() --[[ Line: 325 | Upvalues: v3 (copy) ]]
						v3:Destroy()
					end)
					local v42
					for v5, v6 in v2.Falloffs do
						if typeof(v6) == "Vector3" then
							v42 = v13 + v6
							local v7 = workspace:Raycast((v15 + v6).Position, Vector3.new(-0, -200, -0), v10)
							if v7 then
								v42 = CFrame.new(v7.Position)
							end
						else
							v42 = nil
						end
						local v8 = script.Falloff:Clone()
						v8.CFrame = v15
						v8.Parent = workspace
						local v9 = 0
						local v102 = nil
						v102 = RunService.PostSimulation:Connect(function(p1) --[[ Line: 346 | Upvalues: v9 (ref), v42 (ref), v6 (copy), ClientEventUtils (ref), SharedEventUtils (ref), v8 (copy), MathUtils (ref), v15 (ref), v2 (ref), VFX (ref), TweenService (ref), v102 (ref) ]]
							debug.profilebegin("1 Year:Falloff")
							v9 = v9 + p1
							local v1 = v42
							if not v1 and type(v6) == "string" then
								v1 = CFrame.new(ClientEventUtils.getAnimalPosition(v6))
							end
							if not v1 then
								v1 = CFrame.identity
							end
							local v4 = v9 / 2.3
							local v5 = v8
							SharedEventUtils.pushPartCFrame(v5, CFrame.new(MathUtils.quadBezier(v4, v15.Position, v15.Position + Vector3.new(0, v2.Height, 0) + (v1.Position - v15.Position) * Vector3.new(1, 0, 1) * 0.7, v1.Position)))
							if v4 >= 1 and type(v6) ~= "string" then
								local v82 = script.GroundImpact:Clone()
								v82.CFrame = v1 + Vector3.new(0, v82.Size.Y * 0.5, 0)
								v82.Parent = workspace
								VFX.emit(v82)
								VFX.disable(v8)
								task.delay(1.5, function() --[[ Line: 378 | Upvalues: v82 (copy), TweenService (ref), v8 (ref) ]]
									if v82.Parent then
										TweenService:Create(v82, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
											Transparency = 1
										}):Play()
									end
									if not v8.Parent then
										return
									end
									TweenService:Create(v8, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
										Transparency = 1
									}):Play()
								end)
								task.delay(3, function() --[[ Line: 391 | Upvalues: v8 (ref), v82 (copy) ]]
									v8:Destroy()
									v82:Destroy()
								end)
								v102:Disconnect()
							end
							debug.profileend()
						end)
					end
				end)
			end
		end
	end))
	if v42 then
		local NPCs = v42:FindFirstChild("NPCs")
		if NPCs then
			local t5 = {}
			if v32 then
				for v22, v23 in { "Animation5", "Animation6", "Animation7", "Animation8" } do
					local v24 = v32:FindFirstChild(v23)
					if v24 and v24:IsA("Animation") then
						table.insert(t5, v24)
					end
				end
			end
			local t6 = {}
			if Mexico then
				for v25, v26 in { "RoachTrumpet", "RoachMaracas", "RoachAccordion", "RoachViolin" } do
					local v27 = Mexico:FindFirstChild(v26)
					if v27 and v27:IsA("Animation") then
						table.insert(t6, v27)
					end
				end
			end
			local v28 = 0
			local v29 = 0
			for v30, v31 in NPCs:GetChildren() do
				if v31:IsA("Model") then
					local v322 = v31:FindFirstChildOfClass("AnimationController") or v31:FindFirstChildWhichIsA("AnimationController", true)
					if v322 then
						local Animator = v322:FindFirstChildOfClass("Animator")
						if Animator then
							local v33 = nil
							if v31.Name:match("^Crab") and #t5 > 0 then
								v29 = v29 % #t5 + 1
								v33 = t5[v29]
							elseif v31.Name:match("^Cockroach") and #t6 > 0 then
								v28 = v28 % #t6 + 1
								v33 = t6[v28]
							end
							if v33 then
								local v34 = Animator:LoadAnimation(v33)
								v34.Priority = Enum.AnimationPriority.Idle
								v34.Looped = true
								v34:Play()
								v9:Add(function() --[[ Line: 465 | Upvalues: v34 (copy) ]]
									v34:Stop(0)
									v34:Destroy()
								end)
							end
						end
					end
				end
			end
		end
	end
	if v42 then
		local MapMechanics = v42:FindFirstChild("MapMechanics")
		local Indonesia = Events:FindFirstChild("Indonesia")
		local v35 = Indonesia and Indonesia:FindFirstChild("BambuDance")
		if MapMechanics and (v35 and v35:IsA("Animation")) then
			for v36, v37 in MapMechanics:GetChildren() do
				if v37:IsA("Model") and v37.Name:match("^Canoe") then
					local v38 = v37:FindFirstChild("Bambu Bambu Sahur")
					if v38 then
						local v39 = v38:FindFirstChildOfClass("AnimationController") or v38:FindFirstChildWhichIsA("AnimationController", true)
						local v40 = v39 and v39:FindFirstChildOfClass("Animator")
						if v40 then
							local v41 = v40:LoadAnimation(v35)
							v41.Priority = Enum.AnimationPriority.Idle
							v41.Looped = true
							v41:Play()
							v9:Add(function() --[[ Line: 506 | Upvalues: v41 (copy) ]]
								v41:Stop(0)
								v41:Destroy()
							end)
						end
					end
				end
			end
		end
	end
	if v42 then
		local Brainrots = v42:FindFirstChild("Brainrots")
		local Animations = ReplicatedStorage:FindFirstChild("Animations")
		local v43 = Animations and Animations:FindFirstChild("Animals")
		if Brainrots and v43 then
			for v44, v45 in Brainrots:GetChildren() do
				if v45:IsA("Model") then
					local v46 = v43:FindFirstChild(v45.Name)
					local v47 = v46 and v46:FindFirstChild("Idle")
					if v47 and v47:IsA("Animation") then
						local v48 = v45:FindFirstChildOfClass("AnimationController") or v45:FindFirstChildWhichIsA("AnimationController", true)
						local v49 = v48 and v48:FindFirstChildOfClass("Animator")
						if v49 then
							local v50 = v49:LoadAnimation(v47)
							v50.Priority = Enum.AnimationPriority.Idle
							v50.Looped = true
							v50:Play()
							v9:Add(function() --[[ Line: 545 | Upvalues: v50 (copy) ]]
								v50:Stop(0)
								v50:Destroy()
							end)
						end
					end
				end
			end
		end
	end
	if v42 then
		local MapMechanics = v42:FindFirstChild("MapMechanics")
		if MapMechanics then
			local t5 = {}
			for v51, v52 in MapMechanics:GetChildren() do
				if v52:IsA("Model") and v52.Name:match("^UFO") then
					table.insert(t5, {
						model = v52,
						initialPivot = v52:GetPivot(),
						phase = math.random() * math.pi * 2
					})
				end
			end
			if #t5 > 0 then
				v9:Add(RunService.PostSimulation:Connect(function() --[[ Line: 576 | Upvalues: t5 (copy) ]]
					debug.profilebegin("1 Year:UFOFloat")
					local v1 = workspace:GetServerTimeNow()
					for v2, v3 in t5 do
						v3.model:PivotTo(v3.initialPivot + Vector3.new(0, math.sin((v1 + v3.phase) * 1.4) * 5, 0))
					end
					debug.profileend()
				end))
			end
		end
	end
	local v53 = v32 and v32:FindFirstChild("Crab")
	v9:Add(Observers.observeTag("OneYearCrab", function(p1) --[[ Line: 603 | Upvalues: v53 (copy), Trove (ref), v32 (copy), v12 (copy) ]]
		if not (v53 and p1:IsA("Model")) then
			return nil
		end
		local v1 = Trove.new()
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart", 5)
		if not HumanoidRootPart then
			return v1:WrapClean()
		end
		local v2 = v1:Clone(v53)
		local v3 = v2:FindFirstChild("Cylinder.005")
		if not v3 then
			v1:Destroy()
			return nil
		end
		local v4 = v1:Add(Instance.new("Weld"))
		v4.Part0 = v3
		v4.Part1 = HumanoidRootPart
		v4.C1 = CFrame.new(0, 3.6, 0)
		v4.Parent = v2
		v2.Parent = p1
		local AnimationController = v2:FindFirstChildOfClass("AnimationController")
		local v5 = AnimationController and AnimationController:FindFirstChildOfClass("Animator")
		if not v5 then
			return v1:WrapClean()
		end
		local function loadAnim(p1) --[[ loadAnim | Line: 636 | Upvalues: v32 (ref), v5 (copy), v1 (copy) ]]
			local v12 = v32 and v32:FindFirstChild(p1)
			if v12 and v12:IsA("Animation") then
				local v2 = v5:LoadAnimation(v12)
				v1:Add(function() --[[ Line: 642 | Upvalues: v2 (copy) ]]
					v2:Stop(0)
					v2:Destroy()
				end)
				return v2
			else
				return nil
			end
		end
		local v6 = loadAnim("Animation1")
		local v7 = loadAnim("Animation2")
		local v8 = loadAnim("Animation3_Right")
		local v9 = loadAnim("Animation3_Left")
		if v9 then
			v9.Priority = Enum.AnimationPriority.Action
		end
		local v10 = loadAnim("Animation4_Walk")
		if v10 then
			v10.Priority = Enum.AnimationPriority.Action
		end
		local v11 = loadAnim("Animation4_Attack")
		if v11 then
			v11.Priority = Enum.AnimationPriority.Action4
		end
		local v122 = loadAnim("Animation5")
		local v13 = loadAnim("Animation6")
		local v14 = loadAnim("Animation7")
		local v15 = loadAnim("Animation8")
		for v16, v17 in { v122, v13, v14, v15 } do
			if v17 then
				v17.Priority = Enum.AnimationPriority.Action2
			end
		end
		local t = {}
		if v122 then
			t[1] = v122
		end
		if v13 then
			t[2] = v13
		end
		if v14 then
			t[3] = v14
		end
		if v15 then
			t[4] = v15
		end
		local v18 = v10
		local function switchWalkAnimationTrack(p1, p2) --[[ switchWalkAnimationTrack | Line: 683 | Upvalues: v18 (ref) ]]
			if v18 == p1 then
				return
			end
			local v1 = v18 and v18.IsPlaying
			if v1 and v18 then
				v18:Stop()
			end
			v18 = p1
			if not v1 or (p2 or not p1) then
				return
			end
			p1:Play()
		end
		local v19 = false
		local v20 = nil
		local function setDance(p1) --[[ setDance | Line: 701 | Upvalues: v19 (ref), t (copy), v20 (ref) ]]
			if not v19 then
				return
			end
			local v1 = if type(p1) == "number" then p1 elseif p1 then math.random(1, (math.max(1, #t))) else nil
			local v3 = if v1 then t[v1] else v1
			if v20 == v3 then
				return
			end
			if v20 then
				v20:Stop()
				v20 = nil
			end
			if not v3 then
				return
			end
			v20 = v3
			v3:Play()
		end
		v1:Add(p1:GetAttributeChangedSignal("Dance"):Connect(function() --[[ Line: 727 | Upvalues: setDance (copy), p1 (copy) ]]
			setDance(p1:GetAttribute("Dance"))
		end))
		local v21 = nil
		local v22 = nil
		local v23 = nil
		local v24 = v32 and v32:FindFirstChild("SanddrumRoll")
		if v24 then
			v1:Add(p1:GetAttributeChangedSignal("ReachedFirstTarget"):Once(function() --[[ Line: 739 | Upvalues: v21 (ref), v1 (copy), v24 (copy), v3 (copy), v2 (copy) ]]
				if not v21 then
					local v12 = v1:Clone(v24)
					v21 = v12
					local v22 = v1:Add(Instance.new("Weld"))
					v22.Part0 = v12
					v22.Part1 = v3
					v22.C0 = CFrame.new(0.2, 3.629, 4.378)
					v22.Parent = v12
					v12.Parent = v2
				end
			end))
		end
		v1:Add(p1:GetAttributeChangedSignal("IsRunning"):Connect(function() --[[ Line: 754 | Upvalues: p1 (copy), v18 (ref), v22 (ref), v23 (ref), v20 (ref), setDance (copy) ]]
			local v1 = p1:GetAttribute("IsRunning") == true
			local v2 = v18
			if v22 then
				local ParticleEmitter = v22:FindFirstChildOfClass("ParticleEmitter")
				if ParticleEmitter then
					ParticleEmitter.Enabled = v1
				end
			end
			if v23 then
				local ParticleEmitter = v23:FindFirstChildOfClass("ParticleEmitter")
				if ParticleEmitter then
					ParticleEmitter.Enabled = v1
				end
			end
			if v1 and v20 then
				v20:Stop()
				v20 = nil
			elseif not v1 then
				setDance(p1:GetAttribute("Dance"))
			end
			if not v2 then
				return
			end
			if v1 then
				if not v2.IsPlaying then
					v2:Play()
				end
			else
				if not v2.IsPlaying then
					return
				end
				v2:Stop()
			end
		end))
		if v11 then
			v1:Add(p1:GetAttributeChangedSignal("AttackAnimation"):Connect(function() --[[ Line: 794 | Upvalues: v11 (copy) ]]
				v11:Play()
			end))
		end
		local v25 = v12.startedAt + 61
		local function timeLeftForSongT(p1) --[[ timeLeftForSongT | Line: 800 | Upvalues: v25 (copy) ]]
			return v25 + (p1 - 12.5) - workspace:GetServerTimeNow()
		end
		local function scheduleAtSongT(p1, p2) --[[ scheduleAtSongT | Line: 804 | Upvalues: v25 (copy), v1 (copy) ]]
			local v12 = v25 + (p1 - 12.5) - workspace:GetServerTimeNow()
			if not (v12 <= 0) then
				v1:Add(task.delay(v12, p2))
			end
		end
		local v26 = workspace:GetServerTimeNow() - v25 + 12.5
		if v26 < 7 and v6 then
			v6:Play()
		elseif v26 < 46 and v7 then
			v7:Play()
		end
		local function f27() --[[ Line: 820 | Upvalues: v6 (copy), v7 (copy) ]]
			if v6 then
				v6:Stop()
			end
			if not v7 then
				return
			end
			v7:Play()
		end
		local v28 = v25 + -5.5 - workspace:GetServerTimeNow()
		if not (v28 <= 0) then
			v1:Add(task.delay(v28, f27))
		end
		local function f29() --[[ Line: 829 | Upvalues: v9 (copy), v18 (ref), v21 (ref) ]]
			if v9 then
				local v1 = v9
				if v18 ~= v1 then
					if v18 and v18.IsPlaying and v18 then
						v18:Stop()
					end
					v18 = v1
				end
				v9:Play(nil, nil, 0.3333333333333333)
			end
			local v3 = v21
			if not v3 then
				return
			end
			local ParticleEmitter = v3:FindFirstChildOfClass("ParticleEmitter")
			if ParticleEmitter then
				ParticleEmitter.Enabled = false
			end
			task.delay(3, function() --[[ Line: 841 | Upvalues: v3 (copy) ]]
				if not v3.Parent then
					return
				end
				v3:Destroy()
			end)
			v21 = nil
		end
		local v30 = v25 + 15 - workspace:GetServerTimeNow()
		if not (v30 <= 0) then
			v1:Add(task.delay(v30, f29))
		end
		local v31 = v32 and v32:FindFirstChild("WalkPart")
		local function f32() --[[ Line: 851 | Upvalues: v9 (copy), v31 (copy), v1 (copy), v22 (ref), v3 (copy), v2 (copy), v23 (ref), p1 (copy) ]]
			if v9 then
				v9:AdjustSpeed(1)
			end
			if not v31 then
				return
			end
			local v12 = v1:Clone(v31)
			v22 = v12
			local v24 = v1:Add(Instance.new("Weld"))
			v24.Part0 = v12
			v24.Part1 = v3
			v24.C0 = CFrame.new(0.614, 3.129, 4.731) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
			v24.Parent = v12
			v12.Parent = v2
			local v32 = v1:Clone(v31)
			v23 = v32
			local v4 = v1:Add(Instance.new("Weld"))
			v4.Part0 = v32
			v4.Part1 = v3
			v4.C0 = CFrame.new(0.414, 3.129, -4.78) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
			v4.Parent = v32
			v32.Parent = v2
			local v5 = p1:GetAttribute("IsRunning") == true
			for v6, v7 in { v12, v32 } do
				local ParticleEmitter = v7:FindFirstChildOfClass("ParticleEmitter")
				if ParticleEmitter then
					ParticleEmitter.Enabled = v5
				end
			end
		end
		local v33 = v25 + 18.5 - workspace:GetServerTimeNow()
		if not (v33 <= 0) then
			v1:Add(task.delay(v33, f32))
		end
		local function f34() --[[ Line: 886 | Upvalues: v8 (copy) ]]
			if not v8 then
				return
			end
			v8:Play(nil, nil, 0.3333333333333333)
		end
		local v35 = v25 + 30.5 - workspace:GetServerTimeNow()
		if not (v35 <= 0) then
			v1:Add(task.delay(v35, f34))
		end
		local function f36() --[[ Line: 892 | Upvalues: v8 (copy), v10 (copy), v18 (ref), v19 (ref), setDance (copy), p1 (copy) ]]
			if v8 then
				v8:Stop()
			end
			local v1 = v10
			if v18 ~= v1 then
				local v2 = v18 and v18.IsPlaying
				if v2 and v18 then
					v18:Stop()
				end
				v18 = v1
				if v2 and v1 then
					v1:Play()
				end
			end
			v19 = true
			setDance(p1:GetAttribute("Dance"))
		end
		local v37 = v25 + 33.5 - workspace:GetServerTimeNow()
		if not (v37 <= 0) then
			v1:Add(task.delay(v37, f36))
		end
		if not (v26 >= 46) then
			return v1:WrapClean()
		end
		v19 = true
		setDance(p1:GetAttribute("Dance"))
		return v1:WrapClean()
	end, { workspace }))
	local v54 = Mexico and Mexico:FindFirstChild("Cockroach")
	local v55 = Mexico and Mexico:FindFirstChild("Instruments")
	v9:Add(Observers.observeTag("OneYearRoach", function(p1) --[[ Line: 916 | Upvalues: v54 (copy), Trove (ref), Mexico (copy), t (copy), VFX (ref), v55 (copy) ]]
		if not (v54 and p1:IsA("Model")) then
			return nil
		end
		local v1 = Trove.new()
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart", 5)
		if not HumanoidRootPart then
			return v1:WrapClean()
		end
		local v2 = v1:Clone(v54)
		local PrimaryPart = v2.PrimaryPart
		if not PrimaryPart then
			v1:Destroy()
			return nil
		end
		local v3 = v1:Add(Instance.new("Weld"))
		v3.Part0 = PrimaryPart
		v3.Part1 = HumanoidRootPart
		v3.Parent = PrimaryPart
		local AnimationController = v2:FindFirstChild("AnimationController")
		if AnimationController then
			AnimationController:Destroy()
		end
		local AnimationController_2 = Instance.new("Humanoid")
		AnimationController_2.Name = "AnimationController"
		AnimationController_2.EvaluateStateMachine = false
		AnimationController_2.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		AnimationController_2.PlatformStand = true
		AnimationController_2.Parent = v2
		local Animator = Instance.new("Animator")
		Animator.Parent = AnimationController_2
		v2.Parent = p1
		local function loadAnim(p1, p2, p3, p4) --[[ loadAnim | Line: 958 | Upvalues: Mexico (ref), Animator (copy), t (ref) ]]
			local v1 = Mexico and Mexico:FindFirstChild(p2)
			if not (v1 and v1:IsA("Animation")) then
				return nil
			end
			local v2 = Animator:LoadAnimation(v1)
			if p3 then
				v2.Priority = p3
			end
			if p4 ~= nil then
				v2.Looped = p4
			end
			t[v2] = 1
			p1:Add(function() --[[ Line: 971 | Upvalues: v2 (copy), t (ref) ]]
				t[v2] = nil
				v2:Stop(0)
				v2:Destroy()
			end)
			return v2
		end
		local v4 = loadAnim(v1, "PutHat", Enum.AnimationPriority.Action4, false)
		local v5 = loadAnim(v1, "TakeHat", Enum.AnimationPriority.Action3, false)
		local v6 = nil
		local function setupInstrument(p12) --[[ setupInstrument | Line: 984 | Upvalues: v6 (ref), Trove (ref), loadAnim (copy), v2 (copy), VFX (ref), v5 (copy), v55 (ref), PrimaryPart (copy), Mexico (ref), p1 (copy) ]]
			if v6 then
				v6:Destroy()
			end
			local v1 = Trove.new()
			v6 = v1
			local v22 = loadAnim(v1, ("Roach%*"):format(p12), Enum.AnimationPriority.Action, true)
			local v3 = loadAnim(v1, ("RoachWalk%*"):format(p12), Enum.AnimationPriority.Action2, true) or loadAnim(v1, "RoachWalk", Enum.AnimationPriority.Action2, true)
			if p12 == "Maracas" and v22 then
				v22:AdjustSpeed(0.65)
			end
			local RootPart = v2:FindFirstChild("RootPart")
			local v4 = if RootPart then RootPart:FindFirstChild("VFX") else RootPart
			if v4 and p12 == "Sombrero" then
				VFX.disable(v4)
			elseif v4 then
				VFX.enable(v4)
			end
			if p12 == "Sombrero" and v5 then
				v5:Play()
			end
			local v52 = v55 and v55:FindFirstChild(p12)
			if v52 then
				local v62 = v1:Clone(v52)
				if v62.PrimaryPart then
					local Weld = Instance.new("Weld")
					Weld.Part0 = v62.PrimaryPart
					Weld.Part1 = PrimaryPart
					Weld.C0 = CFrame.new(0, 3.5, 0)
					Weld.Parent = v62.PrimaryPart
				end
				for v7, v8 in v62:GetChildren() do
					local RigidConstraint = v8:FindFirstChildOfClass("RigidConstraint")
					if RigidConstraint then
						local Attachment0 = RigidConstraint.Attachment0
						if Attachment0 then
							local v9 = v2:FindFirstChild(Attachment0.Name, true)
							if v9 then
								RigidConstraint.Attachment1 = v9
							end
						end
					end
				end
				v62.Parent = PrimaryPart
				local AnimationController = v62:FindFirstChild("AnimationController")
				local v10 = if AnimationController then AnimationController:FindFirstChildOfClass("Animator") else AnimationController
				if v10 then
					local v11 = Mexico and Mexico:FindFirstChild(p12)
					if v11 and v11:IsA("Animation") then
						local v12 = v10:LoadAnimation(v11)
						v12.Priority = Enum.AnimationPriority.Action
						v12.Looped = true
						v12:Play()
						v1:Add(function() --[[ Line: 1054 | Upvalues: v12 (copy) ]]
							v12:Stop(0)
							v12:Destroy()
						end)
					end
					local v13 = Mexico and Mexico:FindFirstChild((("Walk%*"):format(p12)))
					if v13 and v13:IsA("Animation") then
						local v14 = v10:LoadAnimation(v13)
						v14.Priority = Enum.AnimationPriority.Action2
						v14.Looped = true
						v1:Add(function() --[[ Line: 1065 | Upvalues: v14 (copy) ]]
							v14:Stop(0)
							v14:Destroy()
						end)
						v1:Add(p1:GetAttributeChangedSignal("IsRunning"):Connect(function() --[[ Line: 1069 | Upvalues: p1 (ref), v14 (copy) ]]
							if p1:GetAttribute("IsRunning") then
								if not v14.IsPlaying then
									v14:Play()
								end
							else
								if not v14.IsPlaying then
									return
								end
								v14:Stop()
							end
						end))
					end
				end
			end
			if v22 then
				v22:Play()
			end
			v1:Add(p1:GetAttributeChangedSignal("IsRunning"):Connect(function() --[[ Line: 1088 | Upvalues: p1 (ref), v3 (copy) ]]
				local v1 = p1:GetAttribute("IsRunning")
				if not v3 then
					return
				end
				if v1 then
					if not v3.IsPlaying then
						v3:Play()
					end
				else
					if not v3.IsPlaying then
						return
					end
					v3:Stop()
				end
			end))
		end
		local v7 = p1:GetAttribute("Instrument")
		setupInstrument(if type(v7) == "string" then v7 else "Trumpet")
		v1:Add(p1:GetAttributeChangedSignal("Instrument"):Connect(function() --[[ Line: 1109 | Upvalues: p1 (copy), setupInstrument (copy) ]]
			local v1 = p1:GetAttribute("Instrument")
			setupInstrument(if type(v1) == "string" then v1 else "Trumpet")
		end))
		v1:Add(function() --[[ Line: 1114 | Upvalues: v6 (ref) ]]
			if not v6 then
				return
			end
			v6:Destroy()
			v6 = nil
		end)
		if v4 then
			v1:Add(p1:GetAttributeChangedSignal("AttackAnimation"):Connect(function() --[[ Line: 1122 | Upvalues: v4 (copy) ]]
				v4:Play()
			end))
		end
		return v1:WrapClean()
	end, { workspace }))
	local t5 = {}
	local function scheduleMusic(p1, p2, p3, p4, p5) --[[ scheduleMusic | Line: 1138 | Upvalues: v12 (copy), EffectController (ref), v9 (ref), EncryptedAssetsController (ref), t5 (copy), TweenService (ref) ]]
		local v1 = workspace.Sounds:FindFirstChild(p1)
		if not (v1 and v1:IsA("Sound")) then
			warn((("[1 Year] workspace.Sounds.%* missing for phase music"):format(p1)))
			return
		end
		local v2 = v12.startedAt + p2
		local v3 = v12.startedAt + p3
		local v4 = p5 or 0
		local function play() --[[ play | Line: 1155 | Upvalues: v3 (copy), EffectController (ref), v9 (ref), v1 (copy), p4 (copy), EncryptedAssetsController (ref), t5 (ref), p1 (copy), v4 (copy), v2 (copy), TweenService (ref) ]]
			if v3 <= workspace:GetServerTimeNow() then
				return
			end
			EffectController:Activate("Blink")
			local v12 = v9:Extend()
			local v22 = false
			v12:Add(function() --[[ Line: 1167 | Upvalues: v22 (ref) ]]
				v22 = true
			end)
			local v32 = v1:Clone()
			v12:Add(v32)
			v32.Parent = workspace
			v32.Looped = false
			v32.PlayOnRemove = false
			if p4 then
				EncryptedAssetsController:WaitForAssetId(p4)
				if not v22 then
					v32.SoundId = ""
					v32.SoundId = p4
					while not v32.IsLoaded do
						task.wait()
						if v22 then
							return
						end
					end
				end
			end
			t5[p1] = v32
			v12:Add(function() --[[ Line: 1193 | Upvalues: t5 (ref), p1 (ref), v32 (copy) ]]
				if t5[p1] ~= v32 then
					return
				end
				t5[p1] = nil
			end)
			local Volume = v32.Volume
			v32.Volume = 0
			v32.TimePosition = v4 + math.max(0, workspace:GetServerTimeNow() - v2)
			v32:Play()
			TweenService:Create(v32, TweenInfo.new(1.2), {
				Volume = Volume
			}):Play()
			v12:Add(task.delay(v3 - workspace:GetServerTimeNow() - 1.2, function() --[[ Line: 1206 | Upvalues: TweenService (ref), v32 (copy), v12 (copy) ]]
				TweenService:Create(v32, TweenInfo.new(1.2), {
					Volume = 0
				}):Play()
				task.wait(1.3)
				v12:Destroy()
			end))
		end
		local v5 = v2 - workspace:GetServerTimeNow()
		if v5 <= 0 then
			if workspace:GetServerTimeNow() < v3 then
				task.spawn(play)
			end
		else
			v9:Add(task.delay(v5, play))
		end
	end
	scheduleMusic("RainingTacos", 0, 61)
	scheduleMusic("CrabRave", 61, 121, nil, 12.5)
	scheduleMusic("BrazilEvent", 121, 181, "rbxassetid://136243635275209", 5)
	scheduleMusic("MexicoEvent", 181, 240, "rbxassetid://101252122546671", 15)
	local function scheduleStageFeature(p1, p2) --[[ scheduleStageFeature | Line: 1228 | Upvalues: v12 (copy), v9 (ref) ]]
		local v1 = workspace:GetServerTimeNow() - v12.startedAt
		if p1 <= v1 then
			task.spawn(p2)
		else
			v9:Add(task.delay(p1 - v1, p2))
		end
	end
	if v42 then
		local DJSammy = v42:FindFirstChild("DJSammy", true)
		if DJSammy and DJSammy:IsA("Model") then
			local v56 = DJSammy:FindFirstChildOfClass("AnimationController") or DJSammy:FindFirstChildWhichIsA("AnimationController", true)
			local v57 = v56 and v56:FindFirstChildOfClass("Animator")
			if v57 then
				local t6 = {
					{
						mix = "RainingTacosSammy",
						music = "RainingTacos",
						model = "RainingTacos",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					},
					{
						mix = "CrabSammy",
						music = "CrabRave",
						model = "Crab",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					},
					{
						mix = "BrazilSammy",
						music = "BrazilEvent",
						model = "Brazil",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					},
					{
						mix = "MexicoSammy",
						music = "MexicoEvent",
						model = "Mexico",
						defaultSpeed = 1,
						mixSpeed = 1,
						pattern = "alternate"
					}
				}
				local AnimatedModels = DJSammy:FindFirstChild("AnimatedModels", true)
				local t7 = {}
				local t8 = {}
				local function applyVisibility(p1, p2) --[[ applyVisibility | Line: 1278 | Upvalues: t7 (copy), t8 (copy) ]]
					if p1:IsA("BasePart") or (p1:IsA("Decal") or p1:IsA("Texture")) then
						if t7[p1] == nil then
							t7[p1] = p1.Transparency
						end
						p1.Transparency = if p2 then t7[p1] else 1
					else
						if not (p1:IsA("ParticleEmitter") or (p1:IsA("Beam") or (p1:IsA("Trail") or (p1:IsA("Light") or p1:IsA("LayerCollector"))))) then
							return
						end
						if t8[p1] == nil then
							t8[p1] = p1.Enabled
						end
						p1.Enabled = if p2 then t8[p1] else false
					end
				end
				local function hideAnimatedModel(p1) --[[ hideAnimatedModel | Line: 1305 | Upvalues: applyVisibility (copy) ]]
					applyVisibility(p1, false)
					for v1, v2 in p1:GetDescendants() do
						applyVisibility(v2, false)
					end
				end
				if AnimatedModels then
					for v58, v59 in AnimatedModels:GetChildren() do
						applyVisibility(v59, false)
						for v60, v61 in v59:GetDescendants() do
							applyVisibility(v61, false)
						end
					end
					v9:Add(function() --[[ Line: 1315 | Upvalues: t7 (copy), t8 (copy) ]]
						for v1, v2 in t7 do
							if v1.Parent then
								v1.Transparency = v2
							end
						end
						for v3, v4 in t8 do
							if v3.Parent then
								v3.Enabled = v4
							end
						end
					end)
				else
					warn("[1 Year] DJSammy.AnimatedModels not found; per-phase models will not show/hide correctly")
				end
				local t9 = {
					{
						startT = 0,
						endT = 61
					},
					{
						startT = 61,
						endT = 121
					},
					{
						startT = 121,
						endT = 181
					},
					{
						startT = 181,
						endT = 240
					}
				}
				local function loadSammyAnim(p1) --[[ loadSammyAnim | Line: 1342 | Upvalues: v57 (copy), t (copy), v9 (ref) ]]
					local v1 = script:FindFirstChild(p1)
					if v1 and v1:IsA("Animation") then
						local v2 = v57:LoadAnimation(v1)
						v2.Looped = false
						t[v2] = 1
						v9:Add(function() --[[ Line: 1352 | Upvalues: v2 (copy), t (ref) ]]
							t[v2] = nil
							v2:Stop(0)
							v2:Destroy()
						end)
						return v2
					else
						warn((("[1 Year] DJSammy animation \'%*\' not found (search: script -> DJSammy -> DJSammy descendants)"):format(p1)))
						return nil
					end
				end
				local v622 = loadSammyAnim("DefaultSammy")
				local function schedulePhaseDJ(p1) --[[ schedulePhaseDJ | Line: 1362 | Upvalues: t6 (copy), t9 (copy), v12 (copy), loadSammyAnim (copy), v622 (copy), v9 (ref), AnimatedModels (copy), applyVisibility (copy), RunService (ref), t5 (copy), ReplicatedStorage (ref) ]]
					local v1 = t6[p1]
					local v2 = t9[p1]
					if not (v1 and v2) then
						return
					end
					local startT = v2.startT
					local function f3() --[[ Line: 1369 | Upvalues: v12 (ref), v2 (copy), loadSammyAnim (ref), v1 (copy), v622 (ref), v9 (ref), AnimatedModels (ref), p1 (copy), applyVisibility (ref), RunService (ref), t5 (ref), ReplicatedStorage (ref) ]]
						if workspace:GetServerTimeNow() >= v12.startedAt + v2.endT then
							return
						end
						local v13 = loadSammyAnim(v1.mix)
						if not (v13 or v622) then
							return
						end
						local v22 = v9:Extend()
						local v3 = true
						local v4 = 0
						local v5 = nil
						local v6
						if AnimatedModels then
							v6 = AnimatedModels:FindFirstChild(v1.model) or AnimatedModels:FindFirstChild(v1.model, true)
							if not v6 then
								warn((("[1 Year] AnimatedModels child \'%*\' not found for phase %*; model show/hide skipped"):format(v1.model, p1)))
							end
						else
							v6 = nil
						end
						local function setModelVisible(p1) --[[ setModelVisible | Line: 1399 | Upvalues: v6 (ref), applyVisibility (ref) ]]
							if not v6 then
								return
							end
							applyVisibility(v6, p1)
							for v1, v2 in v6:GetDescendants() do
								applyVisibility(v2, p1)
							end
						end
						setModelVisible(false)
						v22:Add(function() --[[ Line: 1410 | Upvalues: setModelVisible (copy) ]]
							setModelVisible(false)
						end)
						if v622 then
							v622.Priority = Enum.AnimationPriority.Action
							v22:Add(RunService.PostSimulation:Connect(function() --[[ Line: 1416 | Upvalues: t5 (ref), v1 (ref), ReplicatedStorage (ref), v622 (ref) ]]
								local v12 = t5[v1.music]
								local v3 = math.clamp((if v12 then v12.PlaybackLoudness else 0) / 700, 0, 1)
								v622:AdjustSpeed(v1.defaultSpeed * (v3 + 0.6) * (ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1))
							end))
						end
						if v13 then
							v13.Priority = Enum.AnimationPriority.Action
						end
						local function playNext() --[[ playNext | Line: 1431 | Upvalues: v3 (ref), v12 (ref), v2 (ref), v13 (copy), v622 (ref), v1 (ref), v4 (ref), v5 (ref), setModelVisible (copy) ]]
							if not v3 then
								return
							end
							local v14 = v12.startedAt + v2.endT - workspace:GetServerTimeNow()
							local v52
							if v622 and (if v14 > 0 then v14 < math.max(if v13 then v13.Length else 0, if v622 then v622.Length else 0) + 0.25 else false) then
								v52 = v622
							elseif v1.pattern == "double_default" then
								if v4 > 0 then
									v52 = v622
									v4 = v4 - 1
								elseif v5 == v13 then
									v52 = v622
									v4 = 1
								else
									v52 = v13
								end
							else
								v52 = if v5 == v622 then v13 else v622
							end
							if not v52 then
								v52 = v622 or v13
							end
							if not v52 then
								return
							end
							if v622 then
								v622.Looped = false
							end
							local v7 = v5
							v5 = v52
							if v7 and (v7 ~= v52 and v7.IsPlaying) then
								v7:Stop(0)
							end
							setModelVisible(v52 == v13)
							if v52 == v13 and v13 then
								v13:AdjustSpeed(v1.mixSpeed)
							end
							v52:Play()
						end
						if v622 then
							v22:Add(v622.Stopped:Connect(function() --[[ Line: 1501 | Upvalues: v3 (ref), v5 (ref), v622 (ref), playNext (copy) ]]
								if not v3 or v5 ~= v622 then
									return
								end
								playNext()
							end))
						end
						if v13 then
							v22:Add(v13.Stopped:Connect(function() --[[ Line: 1508 | Upvalues: v3 (ref), v5 (ref), v13 (copy), playNext (copy) ]]
								if not v3 or v5 ~= v13 then
									return
								end
								playNext()
							end))
						end
						playNext()
						local v7 = v12.startedAt + v2.endT - workspace:GetServerTimeNow()
						local function stopSequence() --[[ stopSequence | Line: 1518 | Upvalues: v3 (ref), v13 (copy), v622 (ref), v22 (copy) ]]
							v3 = false
							if v13 and v13.IsPlaying then
								v13:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v13 then
								v13:Destroy()
							end
							v22:Destroy()
						end
						if v7 <= 0 then
							v3 = false
							if v13 and v13.IsPlaying then
								v13:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v13 then
								v13:Destroy()
							end
							v22:Destroy()
						else
							v9:Add(task.delay(v7, stopSequence))
						end
					end
					local v4 = workspace:GetServerTimeNow() - v12.startedAt
					if startT <= v4 then
						task.spawn(f3)
					else
						v9:Add(task.delay(startT - v4, f3))
					end
				end
				local v63 = t6[1]
				local v64 = t9[1]
				if v63 and v64 then
					local startT = v64.startT
					local v65 = 1
					local function f66() --[[ Line: 1369 | Upvalues: v12 (copy), v64 (copy), loadSammyAnim (copy), v63 (copy), v622 (copy), v9 (ref), AnimatedModels (copy), v65 (copy), applyVisibility (copy), RunService (ref), t5 (copy), ReplicatedStorage (ref) ]]
						if workspace:GetServerTimeNow() >= v12.startedAt + v64.endT then
							return
						end
						local v1 = loadSammyAnim(v63.mix)
						if not (v1 or v622) then
							return
						end
						local v2 = v9:Extend()
						local v3 = true
						local v4 = 0
						local v5 = nil
						local v6
						if AnimatedModels then
							v6 = AnimatedModels:FindFirstChild(v63.model) or AnimatedModels:FindFirstChild(v63.model, true)
							if not v6 then
								warn((("[1 Year] AnimatedModels child \'%*\' not found for phase %*; model show/hide skipped"):format(v63.model, v65)))
							end
						else
							v6 = nil
						end
						local function setModelVisible(p1) --[[ setModelVisible | Line: 1399 | Upvalues: v6 (ref), applyVisibility (ref) ]]
							if not v6 then
								return
							end
							applyVisibility(v6, p1)
							for v1, v2 in v6:GetDescendants() do
								applyVisibility(v2, p1)
							end
						end
						setModelVisible(false)
						v2:Add(function() --[[ Line: 1410 | Upvalues: setModelVisible (copy) ]]
							setModelVisible(false)
						end)
						if v622 then
							v622.Priority = Enum.AnimationPriority.Action
							v2:Add(RunService.PostSimulation:Connect(function() --[[ Line: 1416 | Upvalues: t5 (ref), v63 (ref), ReplicatedStorage (ref), v622 (ref) ]]
								local v1 = t5[v63.music]
								local v3 = math.clamp((if v1 then v1.PlaybackLoudness else 0) / 700, 0, 1)
								v622:AdjustSpeed(v63.defaultSpeed * (v3 + 0.6) * (ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1))
							end))
						end
						if v1 then
							v1.Priority = Enum.AnimationPriority.Action
						end
						local function playNext() --[[ playNext | Line: 1431 | Upvalues: v3 (ref), v12 (ref), v64 (ref), v1 (copy), v622 (ref), v63 (ref), v4 (ref), v5 (ref), setModelVisible (copy) ]]
							if not v3 then
								return
							end
							local v13 = v12.startedAt + v64.endT - workspace:GetServerTimeNow()
							local v52
							if v622 and (if v13 > 0 then v13 < math.max(if v1 then v1.Length else 0, if v622 then v622.Length else 0) + 0.25 else false) then
								v52 = v622
							elseif v63.pattern == "double_default" then
								if v4 > 0 then
									v52 = v622
									v4 = v4 - 1
								elseif v5 == v1 then
									v52 = v622
									v4 = 1
								else
									v52 = v1
								end
							else
								v52 = if v5 == v622 then v1 else v622
							end
							if not v52 then
								v52 = v622 or v1
							end
							if not v52 then
								return
							end
							if v622 then
								v622.Looped = false
							end
							local v7 = v5
							v5 = v52
							if v7 and (v7 ~= v52 and v7.IsPlaying) then
								v7:Stop(0)
							end
							setModelVisible(v52 == v1)
							if v52 == v1 and v1 then
								v1:AdjustSpeed(v63.mixSpeed)
							end
							v52:Play()
						end
						if v622 then
							v2:Add(v622.Stopped:Connect(function() --[[ Line: 1501 | Upvalues: v3 (ref), v5 (ref), v622 (ref), playNext (copy) ]]
								if not v3 or v5 ~= v622 then
									return
								end
								playNext()
							end))
						end
						if v1 then
							v2:Add(v1.Stopped:Connect(function() --[[ Line: 1508 | Upvalues: v3 (ref), v5 (ref), v1 (copy), playNext (copy) ]]
								if not v3 or v5 ~= v1 then
									return
								end
								playNext()
							end))
						end
						playNext()
						local v7 = v12.startedAt + v64.endT - workspace:GetServerTimeNow()
						local function stopSequence() --[[ stopSequence | Line: 1518 | Upvalues: v3 (ref), v1 (copy), v622 (ref), v2 (copy) ]]
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						end
						if v7 <= 0 then
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						else
							v9:Add(task.delay(v7, stopSequence))
						end
					end
					local v67 = workspace:GetServerTimeNow() - v12.startedAt
					if startT <= v67 then
						task.spawn(f66)
					else
						v9:Add(task.delay(startT - v67, f66))
					end
				end
				local v68 = t6[2]
				local v69 = t9[2]
				if v68 and v69 then
					local startT = v69.startT
					local v70 = 2
					local function f71() --[[ Line: 1369 | Upvalues: v12 (copy), v69 (copy), loadSammyAnim (copy), v68 (copy), v622 (copy), v9 (ref), AnimatedModels (copy), v70 (copy), applyVisibility (copy), RunService (ref), t5 (copy), ReplicatedStorage (ref) ]]
						if workspace:GetServerTimeNow() >= v12.startedAt + v69.endT then
							return
						end
						local v1 = loadSammyAnim(v68.mix)
						if not (v1 or v622) then
							return
						end
						local v2 = v9:Extend()
						local v3 = true
						local v4 = 0
						local v5 = nil
						local v6
						if AnimatedModels then
							v6 = AnimatedModels:FindFirstChild(v68.model) or AnimatedModels:FindFirstChild(v68.model, true)
							if not v6 then
								warn((("[1 Year] AnimatedModels child \'%*\' not found for phase %*; model show/hide skipped"):format(v68.model, v70)))
							end
						else
							v6 = nil
						end
						local function setModelVisible(p1) --[[ setModelVisible | Line: 1399 | Upvalues: v6 (ref), applyVisibility (ref) ]]
							if not v6 then
								return
							end
							applyVisibility(v6, p1)
							for v1, v2 in v6:GetDescendants() do
								applyVisibility(v2, p1)
							end
						end
						setModelVisible(false)
						v2:Add(function() --[[ Line: 1410 | Upvalues: setModelVisible (copy) ]]
							setModelVisible(false)
						end)
						if v622 then
							v622.Priority = Enum.AnimationPriority.Action
							v2:Add(RunService.PostSimulation:Connect(function() --[[ Line: 1416 | Upvalues: t5 (ref), v68 (ref), ReplicatedStorage (ref), v622 (ref) ]]
								local v1 = t5[v68.music]
								local v3 = math.clamp((if v1 then v1.PlaybackLoudness else 0) / 700, 0, 1)
								v622:AdjustSpeed(v68.defaultSpeed * (v3 + 0.6) * (ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1))
							end))
						end
						if v1 then
							v1.Priority = Enum.AnimationPriority.Action
						end
						local function playNext() --[[ playNext | Line: 1431 | Upvalues: v3 (ref), v12 (ref), v69 (ref), v1 (copy), v622 (ref), v68 (ref), v4 (ref), v5 (ref), setModelVisible (copy) ]]
							if not v3 then
								return
							end
							local v13 = v12.startedAt + v69.endT - workspace:GetServerTimeNow()
							local v52
							if v622 and (if v13 > 0 then v13 < math.max(if v1 then v1.Length else 0, if v622 then v622.Length else 0) + 0.25 else false) then
								v52 = v622
							elseif v68.pattern == "double_default" then
								if v4 > 0 then
									v52 = v622
									v4 = v4 - 1
								elseif v5 == v1 then
									v52 = v622
									v4 = 1
								else
									v52 = v1
								end
							else
								v52 = if v5 == v622 then v1 else v622
							end
							if not v52 then
								v52 = v622 or v1
							end
							if not v52 then
								return
							end
							if v622 then
								v622.Looped = false
							end
							local v7 = v5
							v5 = v52
							if v7 and (v7 ~= v52 and v7.IsPlaying) then
								v7:Stop(0)
							end
							setModelVisible(v52 == v1)
							if v52 == v1 and v1 then
								v1:AdjustSpeed(v68.mixSpeed)
							end
							v52:Play()
						end
						if v622 then
							v2:Add(v622.Stopped:Connect(function() --[[ Line: 1501 | Upvalues: v3 (ref), v5 (ref), v622 (ref), playNext (copy) ]]
								if not v3 or v5 ~= v622 then
									return
								end
								playNext()
							end))
						end
						if v1 then
							v2:Add(v1.Stopped:Connect(function() --[[ Line: 1508 | Upvalues: v3 (ref), v5 (ref), v1 (copy), playNext (copy) ]]
								if not v3 or v5 ~= v1 then
									return
								end
								playNext()
							end))
						end
						playNext()
						local v7 = v12.startedAt + v69.endT - workspace:GetServerTimeNow()
						local function stopSequence() --[[ stopSequence | Line: 1518 | Upvalues: v3 (ref), v1 (copy), v622 (ref), v2 (copy) ]]
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						end
						if v7 <= 0 then
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						else
							v9:Add(task.delay(v7, stopSequence))
						end
					end
					local v722 = workspace:GetServerTimeNow() - v12.startedAt
					if startT <= v722 then
						task.spawn(f71)
					else
						v9:Add(task.delay(startT - v722, f71))
					end
				end
				local v73 = t6[3]
				local v74 = t9[3]
				if v73 and v74 then
					local startT = v74.startT
					local v75 = 3
					local function f76() --[[ Line: 1369 | Upvalues: v12 (copy), v74 (copy), loadSammyAnim (copy), v73 (copy), v622 (copy), v9 (ref), AnimatedModels (copy), v75 (copy), applyVisibility (copy), RunService (ref), t5 (copy), ReplicatedStorage (ref) ]]
						if workspace:GetServerTimeNow() >= v12.startedAt + v74.endT then
							return
						end
						local v1 = loadSammyAnim(v73.mix)
						if not (v1 or v622) then
							return
						end
						local v2 = v9:Extend()
						local v3 = true
						local v4 = 0
						local v5 = nil
						local v6
						if AnimatedModels then
							v6 = AnimatedModels:FindFirstChild(v73.model) or AnimatedModels:FindFirstChild(v73.model, true)
							if not v6 then
								warn((("[1 Year] AnimatedModels child \'%*\' not found for phase %*; model show/hide skipped"):format(v73.model, v75)))
							end
						else
							v6 = nil
						end
						local function setModelVisible(p1) --[[ setModelVisible | Line: 1399 | Upvalues: v6 (ref), applyVisibility (ref) ]]
							if not v6 then
								return
							end
							applyVisibility(v6, p1)
							for v1, v2 in v6:GetDescendants() do
								applyVisibility(v2, p1)
							end
						end
						setModelVisible(false)
						v2:Add(function() --[[ Line: 1410 | Upvalues: setModelVisible (copy) ]]
							setModelVisible(false)
						end)
						if v622 then
							v622.Priority = Enum.AnimationPriority.Action
							v2:Add(RunService.PostSimulation:Connect(function() --[[ Line: 1416 | Upvalues: t5 (ref), v73 (ref), ReplicatedStorage (ref), v622 (ref) ]]
								local v1 = t5[v73.music]
								local v3 = math.clamp((if v1 then v1.PlaybackLoudness else 0) / 700, 0, 1)
								v622:AdjustSpeed(v73.defaultSpeed * (v3 + 0.6) * (ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1))
							end))
						end
						if v1 then
							v1.Priority = Enum.AnimationPriority.Action
						end
						local function playNext() --[[ playNext | Line: 1431 | Upvalues: v3 (ref), v12 (ref), v74 (ref), v1 (copy), v622 (ref), v73 (ref), v4 (ref), v5 (ref), setModelVisible (copy) ]]
							if not v3 then
								return
							end
							local v13 = v12.startedAt + v74.endT - workspace:GetServerTimeNow()
							local v52
							if v622 and (if v13 > 0 then v13 < math.max(if v1 then v1.Length else 0, if v622 then v622.Length else 0) + 0.25 else false) then
								v52 = v622
							elseif v73.pattern == "double_default" then
								if v4 > 0 then
									v52 = v622
									v4 = v4 - 1
								elseif v5 == v1 then
									v52 = v622
									v4 = 1
								else
									v52 = v1
								end
							else
								v52 = if v5 == v622 then v1 else v622
							end
							if not v52 then
								v52 = v622 or v1
							end
							if not v52 then
								return
							end
							if v622 then
								v622.Looped = false
							end
							local v7 = v5
							v5 = v52
							if v7 and (v7 ~= v52 and v7.IsPlaying) then
								v7:Stop(0)
							end
							setModelVisible(v52 == v1)
							if v52 == v1 and v1 then
								v1:AdjustSpeed(v73.mixSpeed)
							end
							v52:Play()
						end
						if v622 then
							v2:Add(v622.Stopped:Connect(function() --[[ Line: 1501 | Upvalues: v3 (ref), v5 (ref), v622 (ref), playNext (copy) ]]
								if not v3 or v5 ~= v622 then
									return
								end
								playNext()
							end))
						end
						if v1 then
							v2:Add(v1.Stopped:Connect(function() --[[ Line: 1508 | Upvalues: v3 (ref), v5 (ref), v1 (copy), playNext (copy) ]]
								if not v3 or v5 ~= v1 then
									return
								end
								playNext()
							end))
						end
						playNext()
						local v7 = v12.startedAt + v74.endT - workspace:GetServerTimeNow()
						local function stopSequence() --[[ stopSequence | Line: 1518 | Upvalues: v3 (ref), v1 (copy), v622 (ref), v2 (copy) ]]
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						end
						if v7 <= 0 then
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						else
							v9:Add(task.delay(v7, stopSequence))
						end
					end
					local v77 = workspace:GetServerTimeNow() - v12.startedAt
					if startT <= v77 then
						task.spawn(f76)
					else
						v9:Add(task.delay(startT - v77, f76))
					end
				end
				local v78 = t6[4]
				local v79 = t9[4]
				if v78 and v79 then
					local startT = v79.startT
					local v80 = 4
					local function f81() --[[ Line: 1369 | Upvalues: v12 (copy), v79 (copy), loadSammyAnim (copy), v78 (copy), v622 (copy), v9 (ref), AnimatedModels (copy), v80 (copy), applyVisibility (copy), RunService (ref), t5 (copy), ReplicatedStorage (ref) ]]
						if workspace:GetServerTimeNow() >= v12.startedAt + v79.endT then
							return
						end
						local v1 = loadSammyAnim(v78.mix)
						if not (v1 or v622) then
							return
						end
						local v2 = v9:Extend()
						local v3 = true
						local v4 = 0
						local v5 = nil
						local v6
						if AnimatedModels then
							v6 = AnimatedModels:FindFirstChild(v78.model) or AnimatedModels:FindFirstChild(v78.model, true)
							if not v6 then
								warn((("[1 Year] AnimatedModels child \'%*\' not found for phase %*; model show/hide skipped"):format(v78.model, v80)))
							end
						else
							v6 = nil
						end
						local function setModelVisible(p1) --[[ setModelVisible | Line: 1399 | Upvalues: v6 (ref), applyVisibility (ref) ]]
							if not v6 then
								return
							end
							applyVisibility(v6, p1)
							for v1, v2 in v6:GetDescendants() do
								applyVisibility(v2, p1)
							end
						end
						setModelVisible(false)
						v2:Add(function() --[[ Line: 1410 | Upvalues: setModelVisible (copy) ]]
							setModelVisible(false)
						end)
						if v622 then
							v622.Priority = Enum.AnimationPriority.Action
							v2:Add(RunService.PostSimulation:Connect(function() --[[ Line: 1416 | Upvalues: t5 (ref), v78 (ref), ReplicatedStorage (ref), v622 (ref) ]]
								local v1 = t5[v78.music]
								local v3 = math.clamp((if v1 then v1.PlaybackLoudness else 0) / 700, 0, 1)
								v622:AdjustSpeed(v78.defaultSpeed * (v3 + 0.6) * (ReplicatedStorage:GetAttribute("1YearEventSpeed") or 1))
							end))
						end
						if v1 then
							v1.Priority = Enum.AnimationPriority.Action
						end
						local function playNext() --[[ playNext | Line: 1431 | Upvalues: v3 (ref), v12 (ref), v79 (ref), v1 (copy), v622 (ref), v78 (ref), v4 (ref), v5 (ref), setModelVisible (copy) ]]
							if not v3 then
								return
							end
							local v13 = v12.startedAt + v79.endT - workspace:GetServerTimeNow()
							local v52
							if v622 and (if v13 > 0 then v13 < math.max(if v1 then v1.Length else 0, if v622 then v622.Length else 0) + 0.25 else false) then
								v52 = v622
							elseif v78.pattern == "double_default" then
								if v4 > 0 then
									v52 = v622
									v4 = v4 - 1
								elseif v5 == v1 then
									v52 = v622
									v4 = 1
								else
									v52 = v1
								end
							else
								v52 = if v5 == v622 then v1 else v622
							end
							if not v52 then
								v52 = v622 or v1
							end
							if not v52 then
								return
							end
							if v622 then
								v622.Looped = false
							end
							local v7 = v5
							v5 = v52
							if v7 and (v7 ~= v52 and v7.IsPlaying) then
								v7:Stop(0)
							end
							setModelVisible(v52 == v1)
							if v52 == v1 and v1 then
								v1:AdjustSpeed(v78.mixSpeed)
							end
							v52:Play()
						end
						if v622 then
							v2:Add(v622.Stopped:Connect(function() --[[ Line: 1501 | Upvalues: v3 (ref), v5 (ref), v622 (ref), playNext (copy) ]]
								if not v3 or v5 ~= v622 then
									return
								end
								playNext()
							end))
						end
						if v1 then
							v2:Add(v1.Stopped:Connect(function() --[[ Line: 1508 | Upvalues: v3 (ref), v5 (ref), v1 (copy), playNext (copy) ]]
								if not v3 or v5 ~= v1 then
									return
								end
								playNext()
							end))
						end
						playNext()
						local v7 = v12.startedAt + v79.endT - workspace:GetServerTimeNow()
						local function stopSequence() --[[ stopSequence | Line: 1518 | Upvalues: v3 (ref), v1 (copy), v622 (ref), v2 (copy) ]]
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						end
						if v7 <= 0 then
							v3 = false
							if v1 and v1.IsPlaying then
								v1:Stop(0)
							end
							if v622 then
								v622.Looped = false
								if v622.IsPlaying then
									v622:Stop(0)
								end
							end
							if v1 then
								v1:Destroy()
							end
							v2:Destroy()
						else
							v9:Add(task.delay(v7, stopSequence))
						end
					end
					local v822 = workspace:GetServerTimeNow() - v12.startedAt
					if startT <= v822 then
						task.spawn(f81)
					else
						v9:Add(task.delay(startT - v822, f81))
					end
				end
			end
		end
	end
	for v83, v84 in {
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
		local startOffset = v84.startOffset
		local function f85() --[[ Line: 1565 | Upvalues: v12 (copy), v84 (copy), v9 (ref), HudController (ref) ]]
			local v1 = v12.startedAt + v84.endOffset
			if v1 <= workspace:GetServerTimeNow() then
				return
			end
			local v2 = v9:Extend()
			v2:Add(HudController:ShowFakeEvent(v84.name, v1))
			local v3 = v1 - workspace:GetServerTimeNow()
			if v3 <= 0 then
				v2:Destroy()
			else
				v9:Add(task.delay(v3, function() --[[ Line: 1578 | Upvalues: v2 (copy) ]]
					v2:Destroy()
				end))
			end
		end
		local v86 = workspace:GetServerTimeNow() - v12.startedAt
		if startOffset <= v86 then
			task.spawn(f85)
			continue
		end
		v9:Add(task.delay(startOffset - v86, f85))
	end
	local function schedulePlayerDance(p1, p2, p3, p4, p5, p6, p7) --[[ schedulePlayerDance | Line: 1587 | Upvalues: v12 (copy), v9 (ref), Observers (ref), Players (ref), Trove (ref), t (copy), RunService (ref), t5 (copy) ]]
		if not p3 then
			return
		end
		if p2 <= p1 then
			return
		end
		local v1 = p1 + (p6 or 0)
		if p2 <= v1 then
			return
		end
		local v2 = v12.startedAt + v1
		local function f3() --[[ Line: 1611 | Upvalues: v12 (ref), p2 (copy), v9 (ref), Observers (ref), Players (ref), Trove (ref), p3 (copy), p7 (copy), t (ref), RunService (ref), p5 (copy), t5 (ref), v2 (copy), p4 (copy) ]]
			if workspace:GetServerTimeNow() >= v12.startedAt + p2 then
				return
			end
			local v1 = v9:Extend()
			v1:Add(Observers.observeCharacter(Players.LocalPlayer, function(p1, p2) --[[ Line: 1618 | Upvalues: Trove (ref), p3 (ref), p7 (ref), t (ref), RunService (ref), p5 (ref), t5 (ref), v2 (ref), p4 (ref), Players (ref) ]]
				local v1 = Trove.new()
				v1:Add(task.spawn(function() --[[ Line: 1621 | Upvalues: p2 (copy), p3 (ref), v1 (copy), p7 (ref), t (ref), RunService (ref), p5 (ref), t5 (ref), v2 (ref), p4 (ref), Players (ref) ]]
					local Humanoid = p2:WaitForChild("Humanoid")
					if not Humanoid then
						return
					end
					local Animator = Humanoid:WaitForChild("Animator")
					if not Animator then
						return
					end
					local v12 = Animator:LoadAnimation(p3)
					v1:Add(function() --[[ Line: 1638 | Upvalues: v12 (copy) ]]
						v12:Stop()
						v12:Destroy()
					end)
					v12.Priority = Enum.AnimationPriority.Action
					if p7 then
						t[v12] = 1
						v1:Add(function() --[[ Line: 1646 | Upvalues: v12 (copy), t (ref) ]]
							t[v12] = nil
						end)
					end
					local v22 = 0
					local v3 = 0
					v1:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 1653 | Upvalues: p5 (ref), t5 (ref), v12 (copy), v2 (ref), p4 (ref), v3 (ref), Humanoid (copy), Players (ref), v22 (ref) ]]
						debug.profilebegin("1 Year:Player:Dance")
						local v1 = workspace:GetServerTimeNow()
						if p5 then
							local v23 = t5[p5]
							if v23 then
								v12:AdjustSpeed((math.clamp(v23.PlaybackLoudness / 1000 / 0.07, 0.8, 1.5)))
							end
						end
						if v2 + p4 - v1 > 0 then
							if not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v2) % v12.Length
								end
							end
						else
							local Length = v12.Length
							if v3 ~= Length and Length > 0 then
								v3 = Length
								v12.TimePosition = (v1 - v2) % Length
							end
							local v5 = if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then false else true
							if v5 or Players.LocalPlayer:GetAttribute("Stealing") then
								v22 = 0
								if v12.IsPlaying then
									v12:Stop()
								end
							elseif v22 < 3 then
								v22 = v22 + p1
							elseif not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v2) % v12.Length
								end
							end
						end
						debug.profileend()
					end))
				end))
				return v1:WrapClean()
			end))
			local v22 = v12.startedAt + p2 - workspace:GetServerTimeNow()
			if v22 > 0 then
				v1:Add(task.delay(v22, function() --[[ Line: 1709 | Upvalues: v1 (copy) ]]
					v1:Destroy()
				end))
			else
				v1:Destroy()
			end
		end
		local v4 = workspace:GetServerTimeNow() - v12.startedAt
		if v1 <= v4 then
			task.spawn(f3)
		else
			v9:Add(task.delay(v1 - v4, f3))
		end
	end
	local v87 = v32 and v32:FindFirstChild("Dance")
	if v87 then
		local v88 = v12.startedAt + 94.5
		local v89 = 121
		local v90 = nil
		local v91 = nil
		local v92 = 8
		local function f93() --[[ Line: 1611 | Upvalues: v12 (copy), v89 (copy), v9 (ref), Observers (ref), Players (ref), Trove (ref), v87 (copy), v90 (copy), t (copy), RunService (ref), v91 (copy), t5 (copy), v88 (copy), v92 (copy) ]]
			if workspace:GetServerTimeNow() >= v12.startedAt + v89 then
				return
			end
			local v1 = v9:Extend()
			v1:Add(Observers.observeCharacter(Players.LocalPlayer, function(p1, p2) --[[ Line: 1618 | Upvalues: Trove (ref), v87 (ref), v90 (ref), t (ref), RunService (ref), v91 (ref), t5 (ref), v88 (ref), v92 (ref), Players (ref) ]]
				local v1 = Trove.new()
				v1:Add(task.spawn(function() --[[ Line: 1621 | Upvalues: p2 (copy), v87 (ref), v1 (copy), v90 (ref), t (ref), RunService (ref), v91 (ref), t5 (ref), v88 (ref), v92 (ref), Players (ref) ]]
					local Humanoid = p2:WaitForChild("Humanoid")
					if not Humanoid then
						return
					end
					local Animator = Humanoid:WaitForChild("Animator")
					if not Animator then
						return
					end
					local v12 = Animator:LoadAnimation(v87)
					v1:Add(function() --[[ Line: 1638 | Upvalues: v12 (copy) ]]
						v12:Stop()
						v12:Destroy()
					end)
					v12.Priority = Enum.AnimationPriority.Action
					if v90 then
						t[v12] = 1
						v1:Add(function() --[[ Line: 1646 | Upvalues: v12 (copy), t (ref) ]]
							t[v12] = nil
						end)
					end
					local v2 = 0
					local v3 = 0
					v1:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 1653 | Upvalues: v91 (ref), t5 (ref), v12 (copy), v88 (ref), v92 (ref), v3 (ref), Humanoid (copy), Players (ref), v2 (ref) ]]
						debug.profilebegin("1 Year:Player:Dance")
						local v1 = workspace:GetServerTimeNow()
						if v91 then
							local v22 = t5[v91]
							if v22 then
								v12:AdjustSpeed((math.clamp(v22.PlaybackLoudness / 1000 / 0.07, 0.8, 1.5)))
							end
						end
						if v88 + v92 - v1 > 0 then
							if not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v88) % v12.Length
								end
							end
						else
							local Length = v12.Length
							if v3 ~= Length and Length > 0 then
								v3 = Length
								v12.TimePosition = (v1 - v88) % Length
							end
							local v5 = if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then false else true
							if v5 or Players.LocalPlayer:GetAttribute("Stealing") then
								v2 = 0
								if v12.IsPlaying then
									v12:Stop()
								end
							elseif v2 < 3 then
								v2 = v2 + p1
							elseif not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v88) % v12.Length
								end
							end
						end
						debug.profileend()
					end))
				end))
				return v1:WrapClean()
			end))
			local v2 = v12.startedAt + v89 - workspace:GetServerTimeNow()
			if v2 > 0 then
				v1:Add(task.delay(v2, function() --[[ Line: 1709 | Upvalues: v1 (copy) ]]
					v1:Destroy()
				end))
			else
				v1:Destroy()
			end
		end
		local v94 = workspace:GetServerTimeNow() - v12.startedAt
		if v94 >= 94.5 then
			task.spawn(f93)
		else
			v9:Add(task.delay(94.5 - v94, f93))
		end
	end
	local v95 = Brazil and Brazil:FindFirstChild("Dance")
	if v95 then
		local v96 = v12.startedAt + 136
		local v97 = 181
		local v98 = nil
		local v99 = "BrazilEvent"
		local v100 = 35
		local function f101() --[[ Line: 1611 | Upvalues: v12 (copy), v97 (copy), v9 (ref), Observers (ref), Players (ref), Trove (ref), v95 (copy), v98 (copy), t (copy), RunService (ref), v99 (copy), t5 (copy), v96 (copy), v100 (copy) ]]
			if workspace:GetServerTimeNow() >= v12.startedAt + v97 then
				return
			end
			local v1 = v9:Extend()
			v1:Add(Observers.observeCharacter(Players.LocalPlayer, function(p1, p2) --[[ Line: 1618 | Upvalues: Trove (ref), v95 (ref), v98 (ref), t (ref), RunService (ref), v99 (ref), t5 (ref), v96 (ref), v100 (ref), Players (ref) ]]
				local v1 = Trove.new()
				v1:Add(task.spawn(function() --[[ Line: 1621 | Upvalues: p2 (copy), v95 (ref), v1 (copy), v98 (ref), t (ref), RunService (ref), v99 (ref), t5 (ref), v96 (ref), v100 (ref), Players (ref) ]]
					local Humanoid = p2:WaitForChild("Humanoid")
					if not Humanoid then
						return
					end
					local Animator = Humanoid:WaitForChild("Animator")
					if not Animator then
						return
					end
					local v12 = Animator:LoadAnimation(v95)
					v1:Add(function() --[[ Line: 1638 | Upvalues: v12 (copy) ]]
						v12:Stop()
						v12:Destroy()
					end)
					v12.Priority = Enum.AnimationPriority.Action
					if v98 then
						t[v12] = 1
						v1:Add(function() --[[ Line: 1646 | Upvalues: v12 (copy), t (ref) ]]
							t[v12] = nil
						end)
					end
					local v2 = 0
					local v3 = 0
					v1:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 1653 | Upvalues: v99 (ref), t5 (ref), v12 (copy), v96 (ref), v100 (ref), v3 (ref), Humanoid (copy), Players (ref), v2 (ref) ]]
						debug.profilebegin("1 Year:Player:Dance")
						local v1 = workspace:GetServerTimeNow()
						if v99 then
							local v22 = t5[v99]
							if v22 then
								v12:AdjustSpeed((math.clamp(v22.PlaybackLoudness / 1000 / 0.07, 0.8, 1.5)))
							end
						end
						if v96 + v100 - v1 > 0 then
							if not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v96) % v12.Length
								end
							end
						else
							local Length = v12.Length
							if v3 ~= Length and Length > 0 then
								v3 = Length
								v12.TimePosition = (v1 - v96) % Length
							end
							local v5 = if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then false else true
							if v5 or Players.LocalPlayer:GetAttribute("Stealing") then
								v2 = 0
								if v12.IsPlaying then
									v12:Stop()
								end
							elseif v2 < 3 then
								v2 = v2 + p1
							elseif not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v96) % v12.Length
								end
							end
						end
						debug.profileend()
					end))
				end))
				return v1:WrapClean()
			end))
			local v2 = v12.startedAt + v97 - workspace:GetServerTimeNow()
			if v2 > 0 then
				v1:Add(task.delay(v2, function() --[[ Line: 1709 | Upvalues: v1 (copy) ]]
					v1:Destroy()
				end))
			else
				v1:Destroy()
			end
		end
		local v102 = workspace:GetServerTimeNow() - v12.startedAt
		if v102 >= 136 then
			task.spawn(f101)
		else
			v9:Add(task.delay(136 - v102, f101))
		end
	end
	local v103 = Mexico and Mexico:FindFirstChild("PlayerDance")
	if v103 then
		local v104 = v12.startedAt + 194.5
		local v105 = 240
		local v106 = true
		local v107 = nil
		local v108 = 15
		local function f109() --[[ Line: 1611 | Upvalues: v12 (copy), v105 (copy), v9 (ref), Observers (ref), Players (ref), Trove (ref), v103 (copy), v106 (copy), t (copy), RunService (ref), v107 (copy), t5 (copy), v104 (copy), v108 (copy) ]]
			if workspace:GetServerTimeNow() >= v12.startedAt + v105 then
				return
			end
			local v1 = v9:Extend()
			v1:Add(Observers.observeCharacter(Players.LocalPlayer, function(p1, p2) --[[ Line: 1618 | Upvalues: Trove (ref), v103 (ref), v106 (ref), t (ref), RunService (ref), v107 (ref), t5 (ref), v104 (ref), v108 (ref), Players (ref) ]]
				local v1 = Trove.new()
				v1:Add(task.spawn(function() --[[ Line: 1621 | Upvalues: p2 (copy), v103 (ref), v1 (copy), v106 (ref), t (ref), RunService (ref), v107 (ref), t5 (ref), v104 (ref), v108 (ref), Players (ref) ]]
					local Humanoid = p2:WaitForChild("Humanoid")
					if not Humanoid then
						return
					end
					local Animator = Humanoid:WaitForChild("Animator")
					if not Animator then
						return
					end
					local v12 = Animator:LoadAnimation(v103)
					v1:Add(function() --[[ Line: 1638 | Upvalues: v12 (copy) ]]
						v12:Stop()
						v12:Destroy()
					end)
					v12.Priority = Enum.AnimationPriority.Action
					if v106 then
						t[v12] = 1
						v1:Add(function() --[[ Line: 1646 | Upvalues: v12 (copy), t (ref) ]]
							t[v12] = nil
						end)
					end
					local v2 = 0
					local v3 = 0
					v1:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 1653 | Upvalues: v107 (ref), t5 (ref), v12 (copy), v104 (ref), v108 (ref), v3 (ref), Humanoid (copy), Players (ref), v2 (ref) ]]
						debug.profilebegin("1 Year:Player:Dance")
						local v1 = workspace:GetServerTimeNow()
						if v107 then
							local v22 = t5[v107]
							if v22 then
								v12:AdjustSpeed((math.clamp(v22.PlaybackLoudness / 1000 / 0.07, 0.8, 1.5)))
							end
						end
						if v104 + v108 - v1 > 0 then
							if not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v104) % v12.Length
								end
							end
						else
							local Length = v12.Length
							if v3 ~= Length and Length > 0 then
								v3 = Length
								v12.TimePosition = (v1 - v104) % Length
							end
							local v5 = if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then false else true
							if v5 or Players.LocalPlayer:GetAttribute("Stealing") then
								v2 = 0
								if v12.IsPlaying then
									v12:Stop()
								end
							elseif v2 < 3 then
								v2 = v2 + p1
							elseif not v12.IsPlaying then
								v12:Play()
								if v12.Length > 0 then
									v12.TimePosition = (v1 - v104) % v12.Length
								end
							end
						end
						debug.profileend()
					end))
				end))
				return v1:WrapClean()
			end))
			local v2 = v12.startedAt + v105 - workspace:GetServerTimeNow()
			if v2 > 0 then
				v1:Add(task.delay(v2, function() --[[ Line: 1709 | Upvalues: v1 (copy) ]]
					v1:Destroy()
				end))
			else
				v1:Destroy()
			end
		end
		local v110 = workspace:GetServerTimeNow() - v12.startedAt
		if v110 >= 194.5 then
			task.spawn(f109)
		else
			v9:Add(task.delay(194.5 - v110, f109))
		end
	end
	local function f111() --[[ Line: 1744 | Upvalues: v62 (ref), t2 (copy), VFX (ref), v72 (ref), v9 (ref), RunService (ref), t5 (copy), v12 (copy) ]]
		if v62 then
			for v1, v2 in t2 do
				if v1.Parent then
					v1.Color = v2
				end
			end
			VFX.enable(v62, true)
		end
		if not v72 then
			return
		end
		VFX.disable(v72, true)
		local v3 = v9:Extend()
		local v4 = 0
		local v5 = false
		v3:Add(RunService.PostSimulation:Connect(function() --[[ Line: 1762 | Upvalues: t5 (ref), v5 (ref), v4 (ref), VFX (ref), v72 (ref), v3 (copy) ]]
			local BrazilEvent = t5.BrazilEvent
			local v1 = if BrazilEvent then BrazilEvent.PlaybackLoudness else 0
			local v2 = workspace:GetServerTimeNow()
			if not (v1 >= 380) or (v5 or not (v2 - v4 >= 1.5)) then
				return
			end
			v4 = v2
			v5 = true
			VFX.enable(v72, true)
			v3:Add(task.delay(0.5, function() --[[ Line: 1771 | Upvalues: v5 (ref), v72 (ref), VFX (ref) ]]
				if not (v5 and v72) then
					return
				end
				VFX.disable(v72, true)
				v5 = false
			end))
		end))
		local v6 = v12.startedAt + 181 - workspace:GetServerTimeNow()
		if v6 <= 0 then
			v3:Destroy()
		else
			v9:Add(task.delay(v6, function() --[[ Line: 1785 | Upvalues: v3 (copy) ]]
				v3:Destroy()
			end))
		end
	end
	local v112 = workspace:GetServerTimeNow() - v12.startedAt
	if v112 >= 121 then
		task.spawn(f111)
	else
		v9:Add(task.delay(121 - v112, f111))
	end
	local function f113() --[[ Line: 1792 | Upvalues: v62 (ref), VFX (ref), dimSpotlightNeons (copy), v72 (ref) ]]
		if v62 then
			VFX.disable(v62, true)
			dimSpotlightNeons()
		end
		if not v72 then
			return
		end
		VFX.disable(v72, true)
	end
	local v114 = workspace:GetServerTimeNow() - v12.startedAt
	if v114 >= 181 then
		task.spawn(f113)
	else
		v9:Add(task.delay(181 - v114, f113))
	end
	local function f115() --[[ Line: 1808 | Upvalues: Mexico (copy), v12 (copy), v9 (ref), ServerData (ref), VFX (ref) ]]
		if not Mexico then
			return
		end
		if workspace:GetServerTimeNow() >= v12.startedAt + 240 then
			return
		end
		local v1 = v9:Extend()
		local v2 = if ServerData.IsTsunamiServer() then Mexico:FindFirstChild("MapTsunami") else nil
		if not v2 and ServerData.IsBiggerServer() then
			v2 = Mexico:FindFirstChild("MapBigger")
		end
		if not v2 then
			v2 = Mexico:FindFirstChild("Map")
		end
		local v3 = if v2 then v2:FindFirstChild("mexicoeventvfx") else v2
		if v3 then
			local v4 = v1:Clone(v3)
			v4.Parent = workspace
			VFX.enable(v4, true)
		else
			warn("[1 Year] Mexico mexicoeventvfx subfolder missing; phase 4 decor skipped")
		end
		local v5 = v12.startedAt + 240 - workspace:GetServerTimeNow()
		if v5 <= 0 then
			v1:Destroy()
		else
			v9:Add(task.delay(v5, function() --[[ Line: 1842 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end))
		end
	end
	local v116 = workspace:GetServerTimeNow() - v12.startedAt
	if v116 >= 181 then
		task.spawn(f115)
	else
		v9:Add(task.delay(181 - v116, f115))
	end
	local function f117() --[[ Line: 1854 | Upvalues: v62 (ref), v9 (ref), RunService (ref), t5 (copy), v12 (copy) ]]
		if not v62 then
			return
		end
		local v1 = v9:Extend()
		local v2 = Color3.fromRGB(128, 255, 0)
		local v3 = Color3.fromRGB(0, 255, 0)
		local function getRandomXZTarget(p1, p2) --[[ getRandomXZTarget | Line: 1865 ]]
			local v1 = math.random() * math.pi * 2
			local v2 = math.cos(v1) * p2
			return p1 + Vector3.new(v2, 0, math.sin(v1) * p2)
		end
		local t = {}
		local t2 = {}
		local t3 = {}
		local t4 = {}
		local t6 = {}
		local t7 = {}
		local t8 = {}
		local t9 = {}
		local t10 = {}
		local t11 = {}
		local t12 = {}
		for v4, v5 in v62:GetDescendants() do
			if v5:IsA("Beam") then
				table.insert(t8, v5)
				local Attachment1 = v5.Attachment1
				if Attachment1 and not t9[Attachment1] then
					local WorldPosition = Attachment1.WorldPosition
					t9[Attachment1] = WorldPosition
					local v6 = math.random() * math.pi * 2
					local v7 = math.cos(v6) * 30
					t10[Attachment1] = WorldPosition + Vector3.new(v7, 0, math.sin(v6) * 30)
					local v92 = math.random() * math.pi * 2
					local v10 = math.cos(v92) * 30
					t11[Attachment1] = WorldPosition + Vector3.new(v10, 0, math.sin(v92) * 30)
					table.insert(t12, Attachment1)
				end
				continue
			end
			if v5:IsA("SpotLight") or v5:IsA("PointLight") then
				table.insert(t, v5)
				if v5:IsA("SpotLight") and (v5.Parent and v5.Parent:IsA("BasePart")) then
					local v122 = v5.Parent
					if not t2[v122] then
						t2[v122] = v122.CFrame
						local v13 = math.random() * math.pi * 2
						local v14 = math.cos(v13) * 30
						t3[v122] = v122.Position + Vector3.new(v14, 0, math.sin(v13) * 30)
						local v16 = math.random() * math.pi * 2
						local v17 = math.cos(v16) * 30
						t4[v122] = v122.Position + Vector3.new(v17, 0, math.sin(v16) * 30)
						table.insert(t6, v122)
					end
				end
				continue
			end
			if v5:IsA("BasePart") and v5.Material == Enum.Material.Neon then
				table.insert(t7, v5)
			end
		end
		v1:Add(function() --[[ Line: 1911 | Upvalues: t2 (copy) ]]
			for v1, v2 in t2 do
				if v1.Parent then
					v1.CFrame = v2
				end
			end
		end)
		local v19 = 1
		local v20 = 0
		local v21 = 0
		v1:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 1923 | Upvalues: v20 (ref), t5 (ref), v21 (ref), t11 (copy), t9 (copy), t4 (copy), t2 (copy), t12 (copy), t10 (copy), t6 (copy), t3 (copy), v19 (ref), v2 (copy), v3 (copy), t8 (copy), t (copy), t7 (copy) ]]
			debug.profilebegin("1 Year:Phase3SpotlightSync")
			v20 = v20 - p1
			local BrazilEvent = t5.BrazilEvent
			local v1 = if BrazilEvent then BrazilEvent.PlaybackLoudness else 0
			local v22 = math.clamp(v1 / 1000, 0, 1)
			local v32 = workspace:GetServerTimeNow()
			if v1 >= 320 and v32 - v21 >= 2 then
				v21 = v32
				for v4 in t11 do
					local v7 = math.random() * math.pi * 2
					t11[v4] = t9[v4] + Vector3.new(math.cos(v7) * 30, 0, math.sin(v7) * 30)
				end
				for v10 in t4 do
					local v12 = math.random() * math.pi * 2
					t4[v10] = t2[v10].Position + Vector3.new(math.cos(v12) * 30, 0, math.sin(v12) * 30)
				end
			end
			local v16 = math.lerp(35, 120, (math.clamp((v1 - 100) / 200, 0, 1))) * p1
			for v18, v192 in t12 do
				local v17
				local v202 = t10[v192]
				local v212 = t11[v192]
				local v222 = v212 - v202
				if v222.Magnitude < v16 then
					local v25 = math.random() * math.pi * 2
					t11[v192] = t9[v192] + Vector3.new(math.cos(v25) * 30, 0, math.sin(v25) * 30)
					v17 = v212
				else
					v17 = v202 + v222.Unit * v16
				end
				t10[v192] = v17
				v192.WorldCFrame = CFrame.new(v17)
			end
			for v29, v30 in t6 do
				local v28
				local v31 = t3[v30]
				local v322 = t4[v30]
				local v33 = v322 - v31
				if v33.Magnitude < v16 then
					local v35 = math.random() * math.pi * 2
					t4[v30] = t2[v30].Position + Vector3.new(math.cos(v35) * 30, 0, math.sin(v35) * 30)
					v28 = v322
				else
					v28 = v31 + v33.Unit * v16
				end
				t3[v30] = v28
				v30.CFrame = CFrame.lookAt(t2[v30].Position, v28)
			end
			if v22 >= 0.11 and v20 <= 0 then
				v20 = 0.4
				v19 = if v19 == 1 then 2 else 1
				local v40 = if v19 == 1 then v2 else v3
				local v41 = ColorSequence.new(v40)
				for v42, v43 in t8 do
					v43.Color = v41
				end
				for v44, v45 in t do
					v45.Color = v40
				end
				for v46, v47 in t7 do
					v47.Color = v40
				end
			end
			debug.profileend()
		end))
		local v22 = v12.startedAt + 181 - workspace:GetServerTimeNow()
		if v22 <= 0 then
			v1:Destroy()
		else
			v9:Add(task.delay(v22, function() --[[ Line: 2002 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end))
		end
	end
	local v118 = workspace:GetServerTimeNow() - v12.startedAt
	if v118 >= 121 then
		task.spawn(f117)
	else
		v9:Add(task.delay(121 - v118, f117))
	end
	local t6 = {
		"1YearTacosPhase",
		"1YearClawsPhase",
		"1YearBrazilPhase",
		"1YearMexicoPhase"
	}
	local function activatePhaseGrass(p1) --[[ activatePhaseGrass | Line: 2019 | Upvalues: t6 (copy), ReplicatedStorage (ref), EffectController (ref) ]]
		for v1, v2 in t6 do
			ReplicatedStorage:SetAttribute(v2, nil)
		end
		ReplicatedStorage:SetAttribute(t6[p1], true)
		EffectController:Run("OneYearEvent", "GrassRecolor")
	end
	v9:Add(function() --[[ Line: 2027 | Upvalues: t6 (copy), ReplicatedStorage (ref), EffectController (ref) ]]
		for v1, v2 in t6 do
			ReplicatedStorage:SetAttribute(v2, nil)
		end
		EffectController:Stop("OneYearEvent", "GrassRecolor")
	end)
	local v119 = workspace:GetServerTimeNow()
	local t7 = { 61, 121, 181, 240 }
	for v120, v121 in { 0, 61, 121, 181 } do
		local v123 = v12.startedAt + t7[v120]
		local v124 = v12.startedAt + v121 - v119
		if v124 <= 0 then
			if v119 < v123 then
				task.spawn(activatePhaseGrass, v120)
			end
			continue
		end
		v9:Add(task.delay(v124, activatePhaseGrass, v120))
	end
	local function setupPhase2Ocean() --[[ setupPhase2Ocean | Line: 2050 | Upvalues: v32 (copy), ServerData (ref), v9 (ref), v12 (copy), TweenService (ref), VFX (ref) ]]
		if not v32 then
			return
		end
		local v1 = if ServerData.IsBiggerServer() then v32:FindFirstChild("OceanBigger") else v32:FindFirstChild("Ocean")
		if not v1 then
			warn("[1 Year] Crab Rave Ocean template missing")
			return
		end
		local v2 = v9:Extend()
		local v3 = v12.startedAt + 121 - workspace:GetServerTimeNow()
		if v3 <= 0 then
			v2:Destroy()
			return
		end
		v9:Add(task.delay(v3, function() --[[ Line: 2070 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end))
		local v4 = if ServerData.IsBiggerServer() then 902 else 400
		local v5 = v2:Clone(v1)
		v5.Parent = workspace
		local v6 = v12.startedAt + 61 + 45 - workspace:GetServerTimeNow()
		for v7, v8 in v5:GetChildren() do
			if v8:IsA("Beam") then
				local TextureLength = v8.TextureLength
				if v6 > 0 then
					v8.TextureLength = 0
					TweenService:Create(v8, TweenInfo.new(v6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
						TextureLength = TextureLength
					}):Play()
					continue
				end
				v8.TextureLength = TextureLength
			end
		end
		local att1 = v5:FindFirstChild("att1")
		if att1 then
			local v92 = Vector3.new(0, 0, v4)
			if v6 > 0 then
				TweenService:Create(att1, TweenInfo.new(v6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
					Position = v92
				}):Play()
			else
				att1.Position = v92
			end
		end
		local oceanparticles = v5:FindFirstChild("oceanparticles")
		if not oceanparticles then
			return
		end
		if v6 > 0 then
			v2:Add(task.delay(v6, function() --[[ Line: 2114 | Upvalues: VFX (ref), oceanparticles (copy) ]]
				VFX.enable(oceanparticles)
			end))
			return
		end
		VFX.enable(oceanparticles)
	end
	local v126 = workspace:GetServerTimeNow()
	if v126 < v12.startedAt + 121 then
		local v127 = v12.startedAt + 51 - v126
		if v127 <= 0 then
			task.spawn(setupPhase2Ocean)
		else
			v9:Add(task.delay(v127, setupPhase2Ocean))
		end
	end
	local v128 = v12.startedAt + 61 + 5
	local v129 = v12.startedAt + 121
	local function startFovPump() --[[ startFovPump | Line: 2145 | Upvalues: v129 (copy), v9 (ref), RunService (ref), t5 (copy), CameraController (ref) ]]
		if v129 <= workspace:GetServerTimeNow() then
			return
		end
		local v1 = v9:Extend()
		local v2 = 0
		v1:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 2154 | Upvalues: v2 (ref), t5 (ref), CameraController (ref) ]]
			debug.profilebegin("1 Year:CrabRaveFov")
			v2 = v2 - p1
			local CrabRave = t5.CrabRave
			local v22 = math.clamp(((if CrabRave then CrabRave.PlaybackLoudness else 0) - 100) / 900, 0, 1)
			if v22 >= 0.25 and v2 <= 0 then
				v2 = 0.1
				CameraController:Fov((v22 - 0.25) * 20 + 70, 0.1)
			end
			debug.profileend()
		end))
		local v3 = v129 - workspace:GetServerTimeNow()
		if v3 <= 0 then
			v1:Destroy()
		else
			v9:Add(task.delay(v3, function() --[[ Line: 2173 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end))
		end
	end
	if workspace:GetServerTimeNow() < v129 then
		local v130 = v128 - workspace:GetServerTimeNow()
		if v130 <= 0 then
			task.spawn(startFovPump)
		else
			v9:Add(task.delay(v130, startFovPump))
		end
	end
	local v131 = v12.startedAt + 121
	local v132 = v12.startedAt + 181
	local function startFovPump_2() --[[ startFovPump | Line: 2195 | Upvalues: v132 (copy), v9 (ref), RunService (ref), t5 (copy), CameraController (ref) ]]
		if v132 <= workspace:GetServerTimeNow() then
			return
		end
		local v1 = v9:Extend()
		local v2 = 0
		v1:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 2204 | Upvalues: v2 (ref), t5 (ref), CameraController (ref) ]]
			debug.profilebegin("1 Year:BrazilFov")
			v2 = v2 - p1
			local BrazilEvent = t5.BrazilEvent
			local v22 = math.clamp((if BrazilEvent then BrazilEvent.PlaybackLoudness else 0) / 1000, 0, 1)
			if v22 >= 0.1 and v2 <= 0 then
				v2 = 0.1
				CameraController:Fov(v22 / 0.7 * 15 + 70, 0.1)
			end
			debug.profileend()
		end))
		local v3 = v132 - workspace:GetServerTimeNow()
		if v3 <= 0 then
			v1:Destroy()
		else
			v9:Add(task.delay(v3, function() --[[ Line: 2223 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end))
		end
	end
	if workspace:GetServerTimeNow() < v132 then
		local v133 = v131 - workspace:GetServerTimeNow()
		if v133 <= 0 then
			task.spawn(startFovPump_2)
		else
			v9:Add(task.delay(v133, startFovPump_2))
		end
	end
	local v134 = if ServerData.IsBiggerServer() then "TacoAmbientBigger" else "TacoAmbient"
	local v135 = v2 and v2:FindFirstChild(v134)
	if v135 then
		local v136, v137 = pcall(require, ReplicatedStorage.Shared.MapInformation)
		if v136 and (v137 and v137.MapCenter) then
			local v138 = v9:Extend()
			local v139 = v138:Clone(v135)
			v139:PivotTo(v137.MapCenter.CFrame + Vector3.new(0, 40, 0))
			v139.Parent = workspace
			v138:Add(task.delay(v12.startedAt + 61 - workspace:GetServerTimeNow(), function() --[[ Line: 2252 | Upvalues: v139 (copy), v138 (copy) ]]
				for v1, v2 in v139:GetDescendants() do
					if v2:IsA("ParticleEmitter") then
						v2.Enabled = false
					end
				end
				task.wait(5)
				v138:Destroy()
			end))
		end
	end
	local v140 = v2 and v2:FindFirstChild("Cannon")
	local v141 = v2 and v2:FindFirstChild("Taco")
	local v142 = v2 and v2:FindFirstChild("StruckVFX")
	local v143, v144, v145, v146
	if v140 then
		local v147 = v9:Clone(v140)
		local v148 = v147:GetPivot()
		for v149, v150 in v147:GetDescendants() do
			if v150:IsA("BasePart") and v150:HasTag("Grass") then
				v150.Transparency = 1
				v150.CanCollide = false
				v150.CanQuery = false
				v150.CanTouch = false
			end
		end
		local function updateCannonPosition() --[[ updateCannonPosition | Line: 2289 | Upvalues: v148 (copy), ServerData (ref), ReplicatedStorage (ref), v147 (copy) ]]
			local sum = v148
			if ServerData.IsBiggerServer() then
				sum = CFrame.new(-410.091, 24.718, -393.962) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
			end
			if ReplicatedStorage:GetAttribute("DivineStairsEnabled") == true then
				sum = sum - Vector3.new(0, 11, 0)
			end
			v147:PivotTo(sum + Vector3.new(0, 10, 0))
		end
		v9:Add(ReplicatedStorage:GetAttributeChangedSignal("DivineStairsEnabled"):Connect(updateCannonPosition))
		updateCannonPosition()
		v143 = v147:FindFirstChild("ShootPart", true)
		local Top = v147:FindFirstChild("Top")
		local Bottom = v147:FindFirstChild("Bottom")
		local v151 = nil
		local v152
		if Top then
			local v153 = Top:FindFirstChild("Meshes/tacolauncher_Cube.004")
			v152 = if v153 then v153:FindFirstChild("Meshes/tacolauncher_Cube.003") else v153
		else
			v152 = nil
		end
		if Bottom then
			local RootPart = Bottom:FindFirstChild("RootPart")
			v151 = if RootPart then RootPart:FindFirstChild("Meshes/tacolauncher_Cube.004") else RootPart
		end
		v144 = Spring.new(0)
		v144.Speed = 6.5
		v144.Damper = 0.85
		v145 = Spring.new(0)
		v145.Speed = 9
		v145.Damper = 0.6
		v9:Add(RunService.PostSimulation:Connect(function(p1) --[[ Line: 2327 | Upvalues: v152 (ref), v144 (ref), v151 (ref), v145 (ref) ]]
			debug.profilebegin("1 Year:TacoCannonSpring")
			if v152 and v144 then
				v152.C1 = CFrame.new(v144.Position, 0, 0)
			end
			if not (v151 and v145) then
				debug.profileend()
				return
			end
			local Angles = CFrame.Angles
			v151.C1 = Angles(0, 0, -math.rad(v145.Position))
			debug.profileend()
		end))
		v147.Parent = workspace
		v146 = v147
		local v156 = v12.startedAt + 61 - workspace:GetServerTimeNow()
		if v156 > 0 then
			v9:Add(task.delay(v156, function() --[[ Line: 2344 | Upvalues: v146 (ref), v143 (ref) ]]
				if not v146 then
					return
				end
				v146:Destroy()
				v146 = nil
				v143 = nil
			end))
		else
			v147:Destroy()
			v146 = nil
			v143 = nil
		end
	else
		v145 = nil
		v144 = nil
		v146 = nil
		v143 = nil
	end
	v9:Add(v3.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 2358 | Upvalues: v146 (ref), v143 (ref), v141 (copy), v142 (copy), v9 (ref), ReplicatedStorage (ref), SoundController (ref), v145 (ref), v144 (ref), RunService (ref), ClientEventUtils (ref), MathUtils (ref) ]]
		local v1 = v146
		local v2 = v143
		if v1 and (v2 and (v141 and v142)) then
			local v3 = v9:Extend()
			local v4 = v3:Clone(v141)
			v4.Parent = workspace
			local v5 = p3 or 2.5
			v3:Add(task.delay(v5 + 2, function() --[[ Line: 2373 | Upvalues: v3 (copy) ]]
				v3:Destroy()
			end))
			task.spawn(function() --[[ Line: 2377 | Upvalues: ReplicatedStorage (ref), SoundController (ref), v1 (copy) ]]
				local v12 = ReplicatedStorage.Sounds.Events:FindFirstChild("Raining Tacos")
				local v2 = if v12 then v12:FindFirstChild("Shoot") else v12
				if not (v2 and v2:IsA("Sound")) then
					return
				end
				SoundController:PlaySound(v2, v1:GetPivot().Position)
			end)
			task.spawn(function() --[[ Line: 2385 | Upvalues: v145 (ref), v144 (ref) ]]
				if v145 then
					v145:Impulse(650)
				end
				task.wait(0.05)
				if not v144 then
					return
				end
				v144:Impulse(35)
			end)
			local Position = v2.CFrame.Position
			v3:Add(RunService.PreRender:Connect(function() --[[ Line: 2397 | Upvalues: ClientEventUtils (ref), p1 (copy), Position (copy), p2 (copy), v5 (copy), MathUtils (ref), v4 (copy), ReplicatedStorage (ref), v142 (ref), v3 (copy) ]]
				debug.profilebegin("1 Year:Taco")
				local v1 = ClientEventUtils.getAnimalPosition(p1)
				if not v1 then
					return
				end
				local v2 = Position + (v1 - Position) * 0.5 + Vector3.new(0, 60, 0)
				local v42 = math.clamp(1 - (p2 + v5 - workspace:GetServerTimeNow()) / v5, 0, 1)
				v4.CFrame = CFrame.lookAt(MathUtils.quadBezier(v42, Position, v2, v1), (MathUtils.quadBezier(v42 + 0.1, Position, v2, v1)))
				if v42 >= 1 then
					local v7 = ReplicatedStorage.Sounds.Events:FindFirstChild("Raining Tacos")
					local v8 = if v7 then v7:FindFirstChild("Hit") else v7
					ClientEventUtils.playBurst(v142, p1, if v8 and v8:IsA("Sound") then { v8 } else nil)
					v3:Destroy()
				end
				debug.profileend()
			end))
		end
	end))
	v9:Add(v4.OnClientEvent:Connect(function(p1) --[[ Line: 2430 | Upvalues: v32 (copy), ReplicatedStorage (ref), ClientEventUtils (ref) ]]
		local v1 = v32 and v32:FindFirstChild("CrabHit")
		if not v1 then
			return
		end
		local v2 = ReplicatedStorage.Sounds.Events:FindFirstChild("Crab Rave")
		local v3 = if v2 then v2:FindFirstChild("Brainrot Hit") else v2
		local v4, v5, v6
		if v3 and v3:IsA("Sound") then
			v4 = v1
			v5 = p1
			v6 = { v3 }
		else
			v4 = v1
			v5 = p1
			v6 = nil
		end
		ClientEventUtils.playBurst(v4, v5, v6)
	end))
	local v157 = nil
	v9:Add(v5.OnClientEvent:Connect(function(p1) --[[ Line: 2443 | Upvalues: v157 (ref) ]]
		v157 = p1
	end))
	v9:Add(v6.OnClientEvent:Connect(function(p1) --[[ Line: 2447 | Upvalues: Brazil (copy), ReplicatedStorage (ref), ClientEventUtils (ref) ]]
		local v1 = Brazil and Brazil:FindFirstChild("Burst")
		if not v1 then
			return
		end
		local Brazil_2 = ReplicatedStorage.Sounds.Events:FindFirstChild("Brazil")
		local v2 = if Brazil_2 then Brazil_2:FindFirstChild("Hit") else Brazil_2
		local v3, v4, v5
		if v2 and v2:IsA("Sound") then
			v3 = v1
			v4 = p1
			v5 = { v2 }
		else
			v3 = v1
			v4 = p1
			v5 = nil
		end
		ClientEventUtils.playBurst(v3, v4, v5)
	end))
	local v158 = Color3.fromRGB(128, 255, 0)
	local v159 = Color3.fromRGB(0, 255, 0)
	v9:Add(Observers.observeTag("OneYearBrazilHitbox", function(p1) --[[ Line: 2461 | Upvalues: Trove (ref), VFX (ref), v158 (copy), RunService (ref), v157 (ref), ClientEventUtils (ref), ReplicatedStorage (ref), SharedEventUtils (ref), t5 (copy), v159 (copy) ]]
		local v1 = Trove.new()
		local BrazilEvent = script:FindFirstChild("BrazilEvent")
		local t = {}
		local t2 = {}
		local t3 = {}
		local t4 = {}
		local t6 = {}
		local t7 = {}
		local v2 = Vector3.new(9, 9, 9)
		local v3 = nil
		local v4 = 0
		local v5 = nil
		local v6
		if BrazilEvent then
			local v7 = v1:Clone(BrazilEvent)
			v7.Parent = workspace
			VFX.enable(v7)
			v6 = v7:FindFirstChild("BrazilBeam", true)
			if v6 then
				local Bottom = v6:FindFirstChild("Bottom")
				local Top = v6:FindFirstChild("Top")
				if Bottom then
					for v8, v9 in Bottom:GetChildren() do
						if v9:IsA("Attachment") then
							t4[v9] = v9.Position
							table.insert(t7, v9)
							v9.Position = v9.Position * Vector3.new(1, 1, 1) * 9
						end
					end
				end
				if Top then
					for v10, v11 in Top:GetChildren() do
						if v11:IsA("Attachment") then
							t4[v11] = v11.Position
							table.insert(t6, v11)
							v11.Position = v11.Position * Vector3.new(1, 1, 1) * 9
						end
					end
				end
			end
			for v12, v13 in v7:GetDescendants() do
				if v13:IsA("ParticleEmitter") or v13:IsA("Beam") then
					table.insert(t, v13)
					continue
				end
				if v13:IsA("SpotLight") or v13:IsA("PointLight") then
					table.insert(t2, v13)
					continue
				end
				if v13:IsA("BasePart") and v13.Material == Enum.Material.Neon then
					table.insert(t3, v13)
				end
			end
		else
			v6 = nil
		end
		local v14 = 1
		local v15 = 0
		local v16 = v158
		local v17 = ColorSequence.new(v158)
		local v18 = false
		v1:Add(RunService.PostSimulation:Connect(function(p12) --[[ Line: 2535 | Upvalues: v157 (ref), v5 (ref), v3 (ref), v2 (ref), p1 (copy), ClientEventUtils (ref), v18 (ref), ReplicatedStorage (ref), v4 (ref), t6 (copy), t4 (copy), t7 (copy), v6 (ref), SharedEventUtils (ref), v15 (ref), t5 (ref), v14 (ref), v16 (ref), v158 (ref), v159 (ref), v17 (ref), t (copy), t2 (copy), t3 (copy) ]]
			debug.profilebegin("1 Year:Phase3Beam")
			if v157 ~= v5 then
				v3 = v2
				v5 = v157
			end
			local v1 = workspace:GetServerTimeNow()
			local v22 = p1:GetAttribute("Focused")
			local v32 = if v157 and (v22 and v22 <= v1) then ClientEventUtils.getAnimalModel(v157) else nil
			if v157 and v32 then
				assert(v22)
				if not v18 then
					v18 = true
					local Brazil = ReplicatedStorage.Sounds.Events:FindFirstChild("Brazil")
					local v42 = if Brazil then Brazil:FindFirstChild("Cube") else Brazil
					if v42 and v42:IsA("Sound") then
						local v52 = v42:Clone()
						v52.Parent = p1
						v52:Play()
						v52.Ended:Once(function() --[[ Line: 2560 | Upvalues: v52 (copy) ]]
							v52:Destroy()
						end)
					end
				end
				local v62 = math.clamp((v1 - v22) / 1, 0, 1)
				v4 = math.clamp((v1 - (v22 + 1)) / 1, 0, 1)
				local VfxInstance = v32:FindFirstChild("VfxInstance")
				local v8 = ((if VfxInstance then VfxInstance.Size else v32:GetExtentsSize()) * Vector3.new(1.25, 1.5, 1.25)):Min(Vector3.new(9, 18, 9))
				if not v3 then
					v3 = v2
				end
				assert(v3)
				local v10 = v3:Lerp(v8, v62)
				local v12 = v3:Lerp(Vector3.new(v8.X, 0, v8.Z), v62)
				v2 = v10
				for v13, v142 in t6 do
					v142.Position = (t4[v142] + Vector3.new(0, v4 * 1, 0)) * v10
				end
				for v162, v172 in t7 do
					v172.Position = t4[v172] * v12
				end
			else
				if v18 then
					v18 = false
				end
				local v182 = math.exp(p12 * -4)
				v2 = (Vector3.new(9, 9, 9)):Lerp(v2, v182)
				v3 = v2
				v4 = math.lerp(0, v4, v182)
				for v20, v21 in t6 do
					v21.Position = (t4[v21] + Vector3.new(0, v4 * 1, 0)) * v2
				end
				for v23, v24 in t7 do
					v24.Position = t4[v24] * v2
				end
			end
			if v6 then
				SharedEventUtils.pushPartCFrame(v6, p1.CFrame)
			end
			v15 = v15 - p12
			local BrazilEvent = t5.BrazilEvent
			if not (math.clamp((if BrazilEvent then BrazilEvent.PlaybackLoudness else 0) / 1000, 0, 1) >= 0.11 and v15 <= 0) then
				debug.profileend()
				return
			end
			v15 = 0.4
			v14 = if v14 == 1 then 2 else 1
			v16 = if v14 == 1 then v158 else v159
			v17 = ColorSequence.new(v16)
			for v28, v29 in t do
				v29.Color = v17
			end
			for v30, v31 in t2 do
				v31.Color = v16
			end
			for v322, v33 in t3 do
				v33.Color = v16
			end
			debug.profileend()
		end))
		return v1:WrapClean()
	end, { workspace }))
	v9:Add(v7.OnClientEvent:Connect(function(p1) --[[ Line: 2642 | Upvalues: Mexico (copy), ReplicatedStorage (ref), ClientEventUtils (ref) ]]
		local v1 = Mexico and Mexico:FindFirstChild("Burst")
		if not v1 then
			return
		end
		local Mexico_2 = ReplicatedStorage.Sounds.Events:FindFirstChild("Mexico")
		local v2 = if Mexico_2 then Mexico_2:FindFirstChild("Hit") else Mexico_2
		local v3, v4, v5
		if v2 and v2:IsA("Sound") then
			v3 = v1
			v4 = p1
			v5 = { v2 }
		else
			v3 = v1
			v4 = p1
			v5 = nil
		end
		ClientEventUtils.playBurst(v3, v4, v5)
	end))
end
function t.OnStop(p1) --[[ OnStop | Line: 2653 | Upvalues: v9 (copy) ]]
	v9:Destroy()
end
function t.OnLoad(p1) --[[ OnLoad | Line: 2657 | Upvalues: ReplicatedStorage (copy), ContentProvider (copy), v2 (copy), ClientEventUtils (copy) ]]
	task.spawn(pcall, function() --[[ Line: 2661 | Upvalues: ReplicatedStorage (ref), ContentProvider (ref) ]]
		local t = {}
		for v1, v2 in script:GetChildren() do
			table.insert(t, v2)
		end
		local Events = ReplicatedStorage.Controllers.EventController.Events
		local function collectAnimations(p1) --[[ collectAnimations | Line: 2669 | Upvalues: t (copy) ]]
			if not p1 then
				return
			end
			for v1, v2 in p1:GetDescendants() do
				if v2:IsA("Animation") then
					table.insert(t, v2)
				end
			end
		end
		collectAnimations(Events:FindFirstChild("Crab Rave"))
		collectAnimations(Events:FindFirstChild("Mexico"))
		collectAnimations(Events:FindFirstChild("Raining Tacos"))
		collectAnimations(Events:FindFirstChild("Brazil"))
		collectAnimations(Events:FindFirstChild("Indonesia"))
		ContentProvider:PreloadAsync(t)
	end)
	v2.OnClientEvent:Connect(function(p1) --[[ Line: 2688 | Upvalues: ReplicatedStorage (ref), ClientEventUtils (ref) ]]
		local v1 = ReplicatedStorage.Sounds.Events:FindFirstChild("1 Year") or ReplicatedStorage.Sounds.Events:FindFirstChild("4th of July")
		local v2 = if v1 then v1:FindFirstChild("Brainrot Hit") else v1
		ClientEventUtils.playBurst(script.FireworkBurst, p1, if v2 and v2:IsA("Sound") then { v2 } else nil)
	end)
end
return t