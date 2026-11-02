-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Observers = require(Packages.Observers)
local Trove = require(Packages.Trove)
local Net = require(Packages.Net)

local plotServiceOpen = Net:RemoteEvent("PlotService/Open")
local LocalPlayer = Players.LocalPlayer

local _PlotClient
local function getPlotClient()
	if not _PlotClient then
		_PlotClient = require(ReplicatedStorage:WaitForChild("Classes").PlotClient)
	end
	return _PlotClient
end

local _SharedAnimals
local function getSharedAnimals()
	if not _SharedAnimals then
		_SharedAnimals = require(ReplicatedStorage.Shared.Animals)
	end
	return _SharedAnimals
end

local _AnimalsData
local function getAnimalsData()
	if not _AnimalsData then
		_AnimalsData = require(ReplicatedStorage:WaitForChild("Datas").Animals)
	end
	return _AnimalsData
end

local _VFX
local function getVFX()
	if not _VFX then
		_VFX = require(ReplicatedStorage.Shared.VFX)
	end
	return _VFX
end

local _SoundController
local function getSoundController()
	if not _SoundController then
		_SoundController = require(ReplicatedStorage.Controllers.SoundController)
	end
	return _SoundController
end

local _AnimationSyncController
local function getAnimationSyncController()
	if not _AnimationSyncController then
		_AnimationSyncController = require(ReplicatedStorage.Controllers.AnimationSyncController)
	end
	return _AnimationSyncController
end

local _AnimationsFolder
local function getAnimationsFolder()
	if not _AnimationsFolder then
		_AnimationsFolder = ReplicatedStorage:WaitForChild("Animations").Animals
	end
	return _AnimationsFolder
end

local DEBUG_PLOTCONTROLLER = false
local function dbg(fmt, ...)
	if not DEBUG_PLOTCONTROLLER then return end
	print(("[PlotController] " .. fmt):format(...))
end

local val1 = nil
local data = {}

local function round(val2)
	return math.floor(val2 * 100) / 100
end

local function CreateAnimalClone(trove, animalName, mutation, traits)
	local model = require(ReplicatedStorage.Shared.BrainrotAssets).getModel(animalName)
	if not model then
		return nil
	end

	local SharedAnimals = getSharedAnimals()
	local Animations = getAnimationsFolder()
	local AnimationSyncController = getAnimationSyncController()

	local clone = trove:Clone(model)
	clone.PrimaryPart.Anchored = true
	clone.Parent = workspace.CurrentCamera
	for _, part in clone:QueryDescendants("BasePart") do
		part.CanQuery = false
		part.CanTouch = false
		part.CanCollide = false
	end
	for _, particle in clone:QueryDescendants("ParticleEmitter") do
		particle:Destroy()
	end
	if mutation then
		trove:Add(SharedAnimals:ApplyMutation(clone, animalName, mutation))
	end
	if traits then
		trove:Add(SharedAnimals:ApplyTraits(clone, animalName, traits))
	end
	for _, trail in clone:QueryDescendants("Trail") do
		trail:Destroy()
	end
	local animController = clone:FindFirstChild("AnimationController")
	if animController then
		animController:Destroy()
	end
	local humanoid = trove:Add(Instance.new("Humanoid", clone))
	local animator = trove:Add(Instance.new("Animator", humanoid))
	humanoid.Name = "AnimationController"
	humanoid.EvaluateStateMachine = false
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.PlatformStand = true
	humanoid.Parent = clone
	local animFolder = Animations:FindFirstChild(animalName)
	local idleAnim = animFolder and animFolder:FindFirstChild("Idle")
	if idleAnim and animator then
		local track = animator:LoadAnimation(idleAnim)
		track.Looped = true
		track:Play()
		local syncRemove = AnimationSyncController:Add(track)
		trove:Add(function()
			syncRemove()
			track:Stop(0)
			track:Destroy()
		end)
	end
	return clone
end

return {
	GetMyPlot = function(_)
		return val1
	end,
	GetPlots = function(_)
		return data
	end,
	Start = function(_)
		task.spawn(getPlotClient)
		task.spawn(getSharedAnimals)
		task.spawn(getAnimalsData)
		task.spawn(getVFX)
		task.spawn(getSoundController)
		task.spawn(getAnimationSyncController)
		task.spawn(getAnimationsFolder)

		plotServiceOpen.OnClientEvent:Connect(function(val3, val4, flag_3, val5, flag_4, flag_5)

			local SharedAnimals = getSharedAnimals()
			local Animals = getAnimalsData()
			local VFX = getVFX()
			local SoundController = getSoundController()
			local AnimationSyncController = getAnimationSyncController()
			local Animations = getAnimationsFolder()

			dbg("Open event received: UID=%s, podiumIndex=%s, type=%s",
				tostring(val3), tostring(val4), tostring(flag_3))

			local function liveModel(uid)
				local plotsFolder = workspace:FindFirstChild("Plots")
				return plotsFolder and plotsFolder:FindFirstChild(uid) or nil
			end

			local dataData = data[val3]
			local attempts = 0
			while attempts < 50 do
				dataData = data[val3]
				local live = liveModel(val3)
				if dataData and live and dataData.PlotModel == live and live:GetAttribute("Loaded") then
					break
				end
				if attempts == 0 or attempts == 10 or attempts == 25 then
					dbg("Open: waiting for fresh PlotClient. data[%s]=%s, dataData.PlotModel=%s, live=%s, Loaded=%s",
						tostring(val3),
						tostring(dataData),
						tostring(dataData and dataData.PlotModel),
						tostring(live),
						tostring(live and live:GetAttribute("Loaded")))
				end
				task.wait(0.1)
				attempts += 1
			end

			if not dataData then
				dbg("Open: gave up — no PlotClient for UID=%s after %d attempts", tostring(val3), attempts)
				return
			end

			local live = liveModel(val3)
			if live and dataData.PlotModel ~= live then
				dbg("Open: rewriting stale PlotModel reference (was %s, now %s) for UID=%s",
					tostring(dataData.PlotModel), tostring(live), tostring(val3))
				dataData.PlotModel = live
			end

			local animalPodiums = dataData.PlotModel:WaitForChild("AnimalPodiums", 5)
			if not animalPodiums then
				return
			end

			local isDescendantOfObj = animalPodiums:WaitForChild(tostring(val4), 5)
			if not isDescendantOfObj then
				return
			end

			while isDescendantOfObj:GetAttribute("DeferDisplay") and isDescendantOfObj:IsDescendantOf(workspace) do
				task.wait(0.1)
			end

			if not isDescendantOfObj:IsDescendantOf(workspace) then
				return
			end

			isDescendantOfObj:SetAttribute("DeferDisplay", val5)
			task.spawn(function()
				if dataData and dataData.UpdateAnimalPodiums then
					dataData:UpdateAnimalPodiums()
				end
			end)

			local Spawn = isDescendantOfObj.Base.Spawn
			local addObj = Trove.new()

			addObj:Add(function()
				if isDescendantOfObj and isDescendantOfObj.Parent then
					isDescendantOfObj:SetAttribute("DeferDisplay", nil)
				end
				if dataData and dataData.UpdateAnimalPodiums then
					dataData:UpdateAnimalPodiums()
				end
			end)

			local success, err = pcall(function()
				if flag_3 == "Coffin Tung Tung Tung Sahur" then
					local flag = require(ReplicatedStorage.Shared.BrainrotAssets).getModel(flag_3)
					if not flag then return end

					local getChildrenObj = addObj:Clone(flag)
					for _, child in getChildrenObj:GetChildren() do
						if child:IsA("MeshPart") and string.find(child.Name, "Plane.003_col", 1, true) then
							child.Transparency = 1
						end
					end
					getChildrenObj.PrimaryPart.Anchored = true
					getChildrenObj.Parent = workspace.CurrentCamera
					getChildrenObj:PivotTo(Spawn:GetPivot())
					if flag_4 then
						addObj:Add(SharedAnimals:ApplyMutation(getChildrenObj, flag_3, flag_4))
					end
					if flag_5 then
						addObj:Add(SharedAnimals:ApplyTraits(getChildrenObj, flag_3, flag_5))
					end
					for _, descendant in getChildrenObj:GetDescendants() do
						if descendant:IsA("Trail") then
							descendant:Destroy()
						end
					end
					local animationController = getChildrenObj:FindFirstChildOfClass("AnimationController") or addObj:Add(Instance.new("AnimationController", getChildrenObj))
					local animator = (animationController:FindFirstChildOfClass("Animator") or addObj:Add(Instance.new("Animator", animationController))):LoadAnimation(ReplicatedStorage.Controllers.CoffinDanceTungTungTungSahurController.Unbox)
					animator.Looped = false
					animator:Play(0)
					SoundController:PlaySound("Sounds.Sfx.Tung Tung Coffin", Spawn.CFrame.Position + Vector3.new(0, 3, 0, 0), false)
					addObj:Add(function()
						animator:Stop(0)
						animator:Destroy()
					end)
					local val6 = false
					local val7 = coroutine.running()
					local v48 = val6

					local function resume()
						v48 = true
						if coroutine.status(val7) == "suspended" then
							task.spawn(val7)
						end
					end
					animator.Stopped:Once(resume)
					local val8 = task.delay(15, resume)
					if not v48 then
						coroutine.yield()
					end
					if coroutine.status(val8) == "suspended" then
						pcall(task.cancel, val8)
					end
					local managedObj = VFX.copy(VFX.Library.Misc.Smoke, Spawn.CFrame + Vector3.new(0, 3, 0, 0))
					VFX.rescale(managedObj, 3)
					VFX.emit(managedObj)
					task.delay(5, function()
						managedObj:Destroy()
					end)
					SoundController:PlaySound("Sounds.Sfx.Lucky Blocks.SpinEnd", Spawn.CFrame.Position + Vector3.new(0, 3, 0, 0), false)

				elseif Animals[flag_3] and Animals[flag_3].Egg then
					local eggModel = require(ReplicatedStorage.Shared.BrainrotAssets).getModel(flag_3)
					if not eggModel then return end

					local spawnPivot = Spawn:GetPivot()
					local eggClone = addObj:Clone(eggModel)
					if flag_4 then
						SharedAnimals:ApplyMutation(eggClone, flag_3, flag_4)
					end
					if flag_5 then
						SharedAnimals:ApplyTraits(eggClone, flag_3, flag_5)
					end
					eggClone.PrimaryPart.Anchored = true
					eggClone:PivotTo(spawnPivot)
					eggClone.Parent = workspace.CurrentCamera
					local primaryPart = eggClone.PrimaryPart
					local originalCFrame = primaryPart.CFrame
					local startTime = os.clock()
					local shakeConnection = nil
					shakeConnection = RunService.Heartbeat:Connect(function()
						local elapsed = os.clock() - startTime
						if elapsed >= 1.2 then
							primaryPart.CFrame = originalCFrame
							shakeConnection:Disconnect()
							return
						else
							local progress = math.clamp(elapsed / 1.2, 0, 1)
							local speed = elapsed * math.lerp(8, 12, progress)
							local angle = progress * 0.5235987755982988
							primaryPart.CFrame = originalCFrame * CFrame.Angles(
								math.noise(speed, speed, 0) * angle * 0.5,
								0,
								math.noise(0, speed, speed) * angle
							)
						end
					end)
					SoundController:PlaySound("Sounds.Sfx.EggHatchStart", Spawn.CFrame.Position + Vector3.new(0, 3, 0, 0), false)
					addObj:Add(shakeConnection)
					task.wait(1.2)
					if shakeConnection.Connected then
						shakeConnection:Disconnect()
					end
					primaryPart.CFrame = originalCFrame
					eggClone:Destroy()
					local smokeVFX = VFX.copy(VFX.Library.Misc.Smoke, Spawn.CFrame + Vector3.new(0, 3, 0, 0))
					VFX.rescale(smokeVFX, 3)
					VFX.emit(smokeVFX)
					task.delay(5, function()
						smokeVFX:Destroy()
					end)
					local animalClone = CreateAnimalClone(addObj, val5, flag_4, flag_5)
					if not animalClone then return end

					animalClone:PivotTo(spawnPivot)
					local defaultScale = animalClone:GetScale()
					animalClone:ScaleTo(0.001)
					local scaleValue = addObj:Add(Instance.new("NumberValue"))
					scaleValue.Value = 0.001
					addObj:Add(scaleValue.Changed:Connect(function(newScale)
						animalClone:ScaleTo(newScale)
						animalClone:PivotTo(spawnPivot)
					end))
					local scaleTween = TweenService:Create(scaleValue, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
						Value = defaultScale
					})
					scaleTween:Play()
					task.wait(scaleTween.TweenInfo.Time * 0.82)
					scaleValue.Value = defaultScale
					scaleTween:Cancel()
					SoundController:PlaySound("Sounds.Sfx.Lucky Blocks.SpinEnd", Spawn.CFrame.Position + Vector3.new(0, 3, 0, 0), false)

				else
					local animalData = Animals[flag_3]
					if not animalData or not animalData.LuckyBlock then return end

					SoundController:PlaySound("Sounds.Sfx.Lucky Blocks.SpinStart", Spawn.CFrame.Position + Vector3.new(0, 3, 0, 0))
					local val9 = addObj:Add(VFX.copy(VFX.Library.Misc.LuckyBlockUnbox, Spawn.CFrame + Vector3.new(0, 3, 0, 0)))
					VFX.emit(val9)
					local Animals_3 = animalData.LuckyBlock.Animals
					local data_2 = {}
					local val10 = 0
					for _, l_Animals_1Entry in Animals_3 do
						if not l_Animals_1Entry.IsEnabled or l_Animals_1Entry.IsEnabled() then
							local Name = l_Animals_1Entry.Name
							local flag_2 = require(ReplicatedStorage.Shared.BrainrotAssets).getModel(Name)
							if flag_2 then
								local parent = addObj:Clone(flag_2)
								parent.PrimaryPart.Anchored = true
								parent.Parent = workspace.CurrentCamera
								for _, descendant_2 in parent:GetDescendants() do
									if descendant_2:IsA("ParticleEmitter") then
										descendant_2:Destroy()
									end
								end

								local isExclusive = require(ReplicatedStorage.Exclusive)[Name]

								if isExclusive then
									for _, child in parent:GetChildren() do
										if child:IsA("Model") then
											if flag_4 then addObj:Add(SharedAnimals:ApplyMutation(child, child.Name, flag_4)) end
											if flag_5 then addObj:Add(SharedAnimals:ApplyTraits(child, child.Name, flag_5)) end
										end
									end
								else
									if flag_4 then addObj:Add(SharedAnimals:ApplyMutation(parent, Name, flag_4)) end
									if flag_5 then addObj:Add(SharedAnimals:ApplyTraits(parent, Name, flag_5)) end
								end

								for _, descendant_3 in parent:GetDescendants() do
									if descendant_3:IsA("Trail") then
										descendant_3:Destroy()
									end
								end

								local animatorsToLoad = {}
								if isExclusive then
									for _, child in parent:GetChildren() do
										if child:IsA("Model") then
											local ac = child:FindFirstChildOfClass("AnimationController") or addObj:Add(Instance.new("AnimationController", child))
											local animator_2 = ac:FindFirstChildOfClass("Animator") or addObj:Add(Instance.new("Animator", ac))
											table.insert(animatorsToLoad, {Animator = animator_2, Lookup = child.Name})
										end
									end
								else
									local ac = parent:FindFirstChildOfClass("AnimationController") or addObj:Add(Instance.new("AnimationController", parent))
									local animator_2 = ac:FindFirstChildOfClass("Animator") or addObj:Add(Instance.new("Animator", ac))
									table.insert(animatorsToLoad, {Animator = animator_2, Lookup = Name})
								end

								for _, data_entry in animatorsToLoad do
									local findFirstChildObj = Animations:FindFirstChild(data_entry.Lookup)
									local Idle = findFirstChildObj and findFirstChildObj:FindFirstChild("Idle")
									if Idle and data_entry.Animator then
										local track = data_entry.Animator:LoadAnimation(Idle)
										track.Looped = true
										track:Play()
										local val11 = AnimationSyncController:Add(track)
										addObj:Add(function()
											val11()
											track:Stop(0)
											track:Destroy()
										end)
									end
								end

								table.insert(data_2, parent)
								if Name == val5 then
									val10 = #data_2
								end
							end
						end
					end

					if #data_2 == 0 then return end

					local numberValue = addObj:Add(Instance.new("NumberValue"))
					numberValue.Value = 0
					local data_3 = {}
					addObj:Add(numberValue.Changed:Connect(function(val12)
						local pivot = Spawn:GetPivot()
						for v57EntryId, v57Entry in data_2 do
							local val13 = math.sin(math.clamp((val12 - (v57EntryId - 1)) % #data_2 * 0.5, 0, 1) * 3.141592653589793)
							local l_v80_Attribute_0 = v57Entry:GetAttribute("DefaultScale")
							if l_v80_Attribute_0 == nil then
								l_v80_Attribute_0 = v57Entry:GetScale()
								v57Entry:SetAttribute("DefaultScale", l_v80_Attribute_0)
							end
							local flag_6 = data_3[v57Entry] or l_v80_Attribute_0
							local val14 = math.clamp(l_v80_Attribute_0 * val13 * 1.01, 0.001, l_v80_Attribute_0)
							if flag_6 >= 0.01 or val14 >= 0.01 then
								v57Entry:PivotTo(pivot)
								v57Entry:ScaleTo(val14)
								data_3[v57Entry] = val14
							end
						end
					end))
					local value = #data_2 * 12 + val10
					local tweenInfo = addObj:Add(TweenService:Create(numberValue, TweenInfo.new(6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						Value = value
					}))
					tweenInfo:Play()
					task.wait(tweenInfo.TweenInfo.Time * 0.82)
					numberValue.Value = value
					tweenInfo:Cancel()
					SoundController:PlaySound("Sounds.Sfx.Lucky Blocks.SpinEnd", Spawn.CFrame.Position + Vector3.new(0, 3, 0, 0))
				end
			end)

			if not success then
				warn("PlotController Open Animation Error (Safely Recovered): ", err)
			end

			addObj:Clean()
		end)

		Observers.observeTag("Plot", function(newArg)
			local addObj_2 = Trove.new()

			dbg("observeTag: new Plot tagged. Name=%s Parent=%s", tostring(newArg.Name), tostring(newArg.Parent))

			local active = true
			addObj_2:Add(function()
				active = false
				dbg("observeTag cleanup: Plot %s losing tag (likely destroyed)", tostring(newArg.Name))
			end)

			task.spawn(function()
				while active and not newArg:GetAttribute("Loaded") do
					task.wait(0.1)
				end

				if not active or not newArg:IsDescendantOf(workspace) then
					dbg("observeTag: aborting PlotClient construction for %s (active=%s, descendantOfWorkspace=%s)",
						tostring(newArg.Name), tostring(active), tostring(newArg:IsDescendantOf(workspace)))
					return
				end

				local PlotClient = getPlotClient()

				local handle = PlotClient.new(newArg)
				local l_v89_UID_0 = handle:GetUID()

				local previous = data[l_v89_UID_0]
				if previous and previous ~= handle then
					dbg("observeTag: replacing previous PlotClient for UID=%s (it was %s, will be GC'd when old plot tag dies)",
						tostring(l_v89_UID_0), tostring(previous))
				end

				data[l_v89_UID_0] = handle
				if handle:GetOwner() == LocalPlayer then
					val1 = handle
				end
				dbg("observeTag: PlotClient constructed for UID=%s, owner=%s",
					tostring(l_v89_UID_0), tostring(handle:GetOwner()))

				addObj_2:Add(handle)
				addObj_2:Add(function()
					if data[l_v89_UID_0] == handle then
						data[l_v89_UID_0] = nil
					end
					if val1 == handle then
						val1 = nil
					end
				end)
			end)

			return addObj_2:WrapClean()
		end)
	end
}