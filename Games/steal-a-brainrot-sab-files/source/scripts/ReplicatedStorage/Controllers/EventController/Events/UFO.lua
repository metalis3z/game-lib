

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)
local Net = require(ReplicatedStorage.Packages.Net)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.VFX)
local UFO = ReplicatedStorage.Models.Events.UFO.UFO

local eventServiceUFOAbductionBurst = Net:RemoteEvent("EventService/UFO/AbductionBurst")
local eventServiceUFOSpawned = Net:RemoteEvent("EventService/UFO/Spawned")

local managedObj = Trove.new()

local function playUFOSpawnFX()

	local parent = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if not parent then
		return
	else
		local screenGui = Instance.new("ScreenGui")
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.DisplayOrder = 10000
		screenGui.Name = "UFO_SpawnFlash"
		local frame = Instance.new("Frame")
		frame.Size = UDim2.fromScale(1, 1)
		frame.BackgroundColor3 = Color3.fromRGB(60, 255, 120)
		frame.BackgroundTransparency = 1
		frame.Parent = screenGui
		screenGui.Parent = parent
		local tweenInfo = CreateTween(frame, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.4
		}, false)
		local tweenInfo_2 = CreateTween(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			BackgroundTransparency = 1
		}, false)
		tweenInfo:Play()
		tweenInfo.Completed:Once(function()

			tweenInfo_2:Play()
			tweenInfo_2.Completed:Once(function()

				screenGui:Destroy()
			end)
		end)
		local managedObj_2 = ShakePresets.BumpS:Clone()
		managedObj_2.Sustain = true
		local val2 = ShakePresets.BindShakeToCamera(managedObj_2, workspace.CurrentCamera)
		managedObj_2:Start()
		task.delay(0.3, function()

			managedObj_2:StopSustain()
			task.delay(0.2, function()

				managedObj_2:Destroy()
				val2()
			end)
		end)
		return
	end
end

local createUFOVisuals = function()

	local subCollector = managedObj:Extend()
	subCollector:Add(Observers.observeTag("GalaxyUFO", function(parent_2)

		if not parent_2:IsA("BasePart") then

			return nil
		else
			local subCollector_2 = subCollector:Extend()
			local getDescendantsObj = subCollector_2:Clone(UFO)
			for _, descendant in getDescendantsObj:GetDescendants() do
				if descendant:IsA("BasePart") then
					descendant.Anchored = true
				end
			end
			local tweenObj = ReplicatedStorage.Sounds.Events.UFO.Flying:Clone()
			tweenObj.Parent = parent_2
			tweenObj:Play()
			getDescendantsObj.Parent = workspace
			local l_v30_FirstChild_0 = getDescendantsObj:FindFirstChild("BeamPart", true)
			local att0 = l_v30_FirstChild_0 and l_v30_FirstChild_0:FindFirstChild("att0")
			local att1 = l_v30_FirstChild_0 and l_v30_FirstChild_0:FindFirstChild("att1")
			if not l_v30_FirstChild_0 or not att0 or not att1 or not att0:IsA("Attachment") or not att1:IsA("Attachment") then
				subCollector_2:Destroy()

				return nil
			else
				local data_2 = {}
				for _, child in att1:GetChildren() do
					if child:IsA("Beam") then
						child.Attachment0 = att0
						child.Attachment1 = att1
						child.Enabled = false
						table.insert(data_2, child)
					end
				end
				local Position = att1.Position
				local cancelObj = nil

				local function stopTween()

					if cancelObj then
						cancelObj:Cancel()
						cancelObj = nil
					end
				end
				local setBeams = function(enabled)

					for _, v37Entry in data_2 do
						v37Entry.Enabled = enabled
					end
				end

				local function _(val3, val4)

					if cancelObj then
						cancelObj:Cancel()
						cancelObj = nil
					end
					cancelObj = CreateTween(att1, TweenInfo.new(val4, Enum.EasingStyle.Quad), {
						Position = val3
					})

					return cancelObj
				end

				local function setState(flag)

					if flag == "down" then
						local tweenObj_2 = ReplicatedStorage.Sounds.Events.UFO.Abducting:Clone()
						tweenObj_2.Parent = parent_2
						tweenObj_2:Play()
						for _, v37Entry_2 in data_2 do
							v37Entry_2.Enabled = true
						end
						att1.Position = att0.Position
						local l_Position_0 = Position
						if cancelObj then
							cancelObj:Cancel()
							cancelObj = nil
						end
						cancelObj = CreateTween(att1, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
							Position = l_Position_0
						})
						return
					else
						if flag == "off" then
							local Positionatt0 = att0.Position
							if cancelObj then
								cancelObj:Cancel()
								cancelObj = nil
							end
							cancelObj = CreateTween(att1, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
								Position = Positionatt0
							})
							local v41 = cancelObj
							if v41 then
								v41.Completed:Wait()
							end

							for _, v37Entry_3 in data_2 do
								v37Entry_3.Enabled = false
							end
							att1.Position = Position
						end
						return
					end
				end
				subCollector_2:Add(parent_2:GetAttributeChangedSignal("BeamState"):Connect(function()

					local l_v28_Attribute_0 = parent_2:GetAttribute("BeamState")
					if typeof(l_v28_Attribute_0) == "string" then
						setState(l_v28_Attribute_0)
					end
				end))
				subCollector_2:Add(RunService.PostSimulation:Connect(function()

					debug.profilebegin("UFO:MoveUFO")
					if getDescendantsObj.PrimaryPart ~= nil and parent_2.Parent ~= nil then
						getDescendantsObj:PivotTo(parent_2.CFrame)
					else
						subCollector_2:Destroy()
					end
					debug.profileend()
				end))
				subCollector_2:Add(stopTween)
				subCollector_2:Add(task.spawn(function()

					local l_v28_Attribute_1 = parent_2:GetAttribute("BeamState")
					if typeof(l_v28_Attribute_1) == "string" then
						setState(l_v28_Attribute_1)
						return
					else
						for _, v37Entry_4 in data_2 do
							v37Entry_4.Enabled = false
						end
						att1.Position = Position
						return
					end
				end))

				return function()

					subCollector_2:Destroy()
				end
			end
		end
	end))
end

data.OnStart = function(_)

	local subCollector_3 = managedObj:Extend()
	subCollector_3:Add(Observers.observeTag("GalaxyUFO", function(parent_3)

		if not parent_3:IsA("BasePart") then

			return nil
		else
			local subCollector_4 = subCollector_3:Extend()
			local getDescendantsObj_2 = subCollector_4:Clone(UFO)
			for _, descendant_2 in getDescendantsObj_2:GetDescendants() do
				if descendant_2:IsA("BasePart") then
					descendant_2.Anchored = true
				end
			end
			local tweenObj_3 = ReplicatedStorage.Sounds.Events.UFO.Flying:Clone()
			tweenObj_3.Parent = parent_3
			tweenObj_3:Play()
			getDescendantsObj_2.Parent = workspace
			local l_v69_FirstChild_0 = getDescendantsObj_2:FindFirstChild("BeamPart", true)
			local att0_2 = l_v69_FirstChild_0 and l_v69_FirstChild_0:FindFirstChild("att0")
			local att1_2 = l_v69_FirstChild_0 and l_v69_FirstChild_0:FindFirstChild("att1")
			if not l_v69_FirstChild_0 or not att0_2 or not att1_2 or not att0_2:IsA("Attachment") or not att1_2:IsA("Attachment") then
				subCollector_4:Destroy()

				return nil
			else
				local data_3 = {}
				for _, child_2 in att1_2:GetChildren() do
					if child_2:IsA("Beam") then
						child_2.Attachment0 = att0_2
						child_2.Attachment1 = att1_2
						child_2.Enabled = false
						table.insert(data_3, child_2)
					end
				end
				local Positionatt1_2 = att1_2.Position
				local cancelObj_2 = nil

				local function stopTween()

					if cancelObj_2 then
						cancelObj_2:Cancel()
						cancelObj_2 = nil
					end
				end
				local setBeams = function(enabled_2)

					for _, v76Entry in data_3 do
						v76Entry.Enabled = enabled_2
					end
				end

				local function _(val5, val6)

					if cancelObj_2 then
						cancelObj_2:Cancel()
						cancelObj_2 = nil
					end
					cancelObj_2 = CreateTween(att1_2, TweenInfo.new(val6, Enum.EasingStyle.Quad), {
						Position = val5
					})

					return cancelObj_2
				end

				local function setState(flag_2)

					if flag_2 == "down" then
						local tweenObj_4 = ReplicatedStorage.Sounds.Events.UFO.Abducting:Clone()
						tweenObj_4.Parent = parent_3
						tweenObj_4:Play()
						for _, v76Entry_2 in data_3 do
							v76Entry_2.Enabled = true
						end
						att1_2.Position = att0_2.Position
						local l_Position_2 = Positionatt1_2
						if cancelObj_2 then
							cancelObj_2:Cancel()
							cancelObj_2 = nil
						end
						cancelObj_2 = CreateTween(att1_2, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
							Position = l_Position_2
						})
						return
					else
						if flag_2 == "off" then
							local Positionatt0_2 = att0_2.Position
							if cancelObj_2 then
								cancelObj_2:Cancel()
								cancelObj_2 = nil
							end
							cancelObj_2 = CreateTween(att1_2, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
								Position = Positionatt0_2
							})
							local v80 = cancelObj_2
							if v80 then
								v80.Completed:Wait()
							end

							for _, v76Entry_3 in data_3 do
								v76Entry_3.Enabled = false
							end
							att1_2.Position = Positionatt1_2
						end
						return
					end
				end
				subCollector_4:Add(parent_3:GetAttributeChangedSignal("BeamState"):Connect(function()

					local l_v67_Attribute_0 = parent_3:GetAttribute("BeamState")
					if typeof(l_v67_Attribute_0) == "string" then
						setState(l_v67_Attribute_0)
					end
				end))
				subCollector_4:Add(RunService.PostSimulation:Connect(function()

					debug.profilebegin("UFO:MoveUFO")
					if getDescendantsObj_2.PrimaryPart ~= nil and parent_3.Parent ~= nil then
						getDescendantsObj_2:PivotTo(parent_3.CFrame)
					else
						subCollector_4:Destroy()
					end
					debug.profileend()
				end))
				subCollector_4:Add(stopTween)
				subCollector_4:Add(task.spawn(function()

					local l_v67_Attribute_1 = parent_3:GetAttribute("BeamState")
					if typeof(l_v67_Attribute_1) == "string" then
						setState(l_v67_Attribute_1)
						return
					else
						for _, v76Entry_4 in data_3 do
							v76Entry_4.Enabled = false
						end
						att1_2.Position = Positionatt1_2
						return
					end
				end))

				return function()

					subCollector_4:Destroy()
				end
			end
		end
	end))
	managedObj:Add(eventServiceUFOAbductionBurst.OnClientEvent:Connect(function(val1)

		ClientEventUtils.playBurst(script.Effects.ufoemit, val1, {
			ReplicatedStorage.Sounds.Events.UFO.Burst
		})
	end))
	managedObj:Add(eventServiceUFOSpawned.OnClientEvent:Connect(function(_)

		playUFOSpawnFX()
	end))
	ReplicatedStorage:SetAttribute("UFOEvent", true)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("UFOEvent", nil)
		CycleController:Update()
		SoundController:UpdateOST()
	end)
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

end

return data
