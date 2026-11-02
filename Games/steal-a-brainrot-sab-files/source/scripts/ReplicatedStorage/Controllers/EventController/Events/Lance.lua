

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local CameraController = require(ReplicatedStorage.Controllers.CameraController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Spring = require(ReplicatedStorage.Packages.Spring)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local LocalPlayer = Players.LocalPlayer

local CurrentCamera = workspace.CurrentCamera

local Name = script.Name

local val69 = {

	[1] = workspace.Sounds.LanceEvent1,
	[2] = workspace.Sounds.LanceEvent2
}
local onClientEventObj = Net:RemoteEvent((("EventService/%*/Burst"):format(Name)))
local _unused = workspace.RenderedMovingAnimals
local managedObj_4 = Trove.new()

data.OnStart = function(_)

	local l_v15_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v15_ActiveEventData_0)

	local function _(val94)

		return (math.max(l_v15_ActiveEventData_0.startedAt + val94 - workspace:GetServerTimeNow(), 0))
	end

	local function createEventScheduler(val97, val98, val104)

		local function compute()

			local v42 = val98

			return (math.max(l_v15_ActiveEventData_0.startedAt + v42 - workspace:GetServerTimeNow(), 0))
		end

		local function run()

			val104(compute)
		end
		local flag_37 = nil
		local serverTimeNow = math.max(l_v15_ActiveEventData_0.startedAt + val97 - workspace:GetServerTimeNow(), 0)
		if serverTimeNow > 0 then
			flag_37 = task.delay(serverTimeNow, run)
		else
			val104(compute)
		end

		return function()

			if flag_37 and coroutine.status(flag_37) == "suspended" then
				pcall(task.cancel, flag_37)
			end
		end
	end

	local function runAt(val122, val127, ...)

		local serverTimeNow_2 = math.max(l_v15_ActiveEventData_0.startedAt + val122 - workspace:GetServerTimeNow(), 0)
		if serverTimeNow_2 <= 0 then
			managedObj_4:Add(task.spawn(val127, ...))
			return
		else
			managedObj_4:Add(task.delay(serverTimeNow_2, val127, ...))
			return
		end
	end
	managedObj_4:Add(function()
		ReplicatedStorage:SetAttribute("LanceEvent1Music", nil)
		ReplicatedStorage:SetAttribute("LanceEventPart2", nil)
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)
	managedObj_4:Add(onClientEventObj.OnClientEvent:Connect(function(val132)

		ClientEventUtils.playBurst(script.Burst, val132, {
			ReplicatedStorage.Sounds.Events.Lance.Hit
		})
	end))
	local Cartoon = Lighting:FindFirstChild("Cartoon")
	if Cartoon then
		Cartoon.Parent = ReplicatedStorage
		managedObj_4:Add(function()

			Cartoon.Parent = Lighting
		end)
	end
	local colorCorrectionEffect = managedObj_4:Clone(Instance.new("ColorCorrectionEffect"))
	colorCorrectionEffect.Parent = CurrentCamera
	local parent_3 = managedObj_4:Clone(script.Stage)
	local LightSequences = require(parent_3.Stage.LightSequences)
	local StageRotate = require(parent_3.Stage.StageRotate)
	local val133 = Color3.fromRGB(255, 245, 192)
	local val134 = Color3.fromRGB(195, 128, 89)
	local val135 = Color3.fromRGB(90, 192, 217)
	local val136 = Color3.fromRGB(186, 0, 0)
	local val137 = Color3.fromRGB(0, 0, 0)

	local function bindToTag(val138, val139)

		local data_2 = {}
		local val141 = managedObj_4:Add(Observers.observeTag(val138, function(v66Arg)

			table.insert(data_2, v66Arg)
			local val140 = val139(v66Arg)

			return function()

				local flag_40 = table.find(data_2, v66Arg)
				if flag_40 then
					table.remove(data_2, flag_40)
				end

				if typeof(val140) == "function" then
					val140()
				end
			end
		end))

		return data_2, function()

			managedObj_4:Remove(val141)
		end
	end
	local v64 = val137
	local connections_7 = bindToTag("LanceStageLight", function(ref8)

		ref8.Color = v64

		return nil
	end)
	local flag_41 = true
	local data_3 = {}
	local isColorValidForLance = function(_)

		local val142 = true
		if v64.R <= 0.0392156862745098 then
			val142 = true
			if v64.G <= 0.0392156862745098 then
				val142 = v64.B > 0.0392156862745098
			end
		end

		return val142
	end
	local connections_8 = bindToTag("LanceTargetLight", function(ref9)

		local _unused = v64
		local flag_42 = true
		if v64.R <= 0.0392156862745098 then
			flag_42 = true
			if v64.G <= 0.0392156862745098 then
				flag_42 = v64.B > 0.0392156862745098
			end
		end

		if flag_42 then
			ref9.Color = v64
		end

		return nil
	end)
	local children = parent_3.Pavillion.Lights:GetChildren()
	for _, descendant in parent_3.Lights:GetDescendants() do
		if descendant:IsA("SpotLight") then
			table.insert(children, descendant)
		end
	end

	local function changeLightsNormal(val143)

		v64 = val143
		for _, v75Entry in connections_7 do
			Spr.target(v75Entry, 1, 7, {
				Color = val143
			})
		end

		if flag_41 then
			for _, v77Entry in data_3 do
				Spr.target(v77Entry, 1, 7, {
					Color = val143
				})
			end
		end
		local flag_43 = true
		if v64.R <= 0.0392156862745098 then
			flag_43 = true
			if v64.G <= 0.0392156862745098 then
				flag_43 = v64.B > 0.0392156862745098
			end
		end

		if flag_43 then
			for _, v84Entry in connections_8 do
				Spr.target(v84Entry, 1, 7, {
					Color = val143
				})
			end
		end

		for _, l_Children_0Entry in children do
			Spr.target(l_Children_0Entry, 1, 7, {
				Color = val143
			})
		end
	end
	local nextIntegerObj_3 = Random.new()

	local function changeLightsRng(val1)

		v64 = val1
		for _, v75Entry_2 in connections_7 do
			Spr.target(v75Entry_2, 1, 7, {
				Color = val1
			})
		end
		local flag_2 = true
		if v64.R <= 0.0392156862745098 then
			flag_2 = true
			if v64.G <= 0.0392156862745098 then
				flag_2 = v64.B > 0.0392156862745098
			end
		end

		if flag_2 then
			for _, v84Entry_2 in connections_8 do
				Spr.target(v84Entry_2, 1, 7, {
					Color = val1
				})
			end
		end

		for i = 1, nextIntegerObj_3:NextInteger(1, #children) do
			local val2 = nextIntegerObj_3:NextInteger(1, #children)
			local l_Children_0 = children
			local l_Children_0_2 = children
			local childData = children[val2]
			local childData_2 = children[i]
			l_Children_0[i] = childData
			l_Children_0_2[val2] = childData_2
			Spr.target(children[i], 1, 7, {
				Color = val1
			})
		end

		if flag_41 then
			for i_2 = 1, nextIntegerObj_3:NextInteger(1, #data_3) do
				local val3 = nextIntegerObj_3:NextInteger(1, #data_3)
				local v77 = data_3
				local v77_2 = data_3
				local data_3Data = data_3[val3]
				local data_3Data_2 = data_3[i_2]
				v77[i_2] = data_3Data
				v77_2[val3] = data_3Data_2
				Spr.target(data_3[i_2], 1, 7, {
					Color = val1
				})
			end
		end
	end
	local flag_3 = {
		CRAZY_SEQUENCE = function()

			local val4 = {
				Color3.fromRGB(218, 173, 145),
				Color3.fromRGB(255, 167, 116),
				(Color3.fromRGB(90, 180, 90))
			}
			local nextIntegerObj = Random.new()
			local eventObj = Timer.Simple(0.15, function()

				changeLightsRng(val4[nextIntegerObj:NextInteger(1, #val4)])
			end, true)

			return function()

				eventObj:Disconnect()
			end
		end,
		EXTRA_CRAZY_SEQUENCE = function()

			local val5 = Color3.fromRGB(223, 146, 101)
			local val6 = {
				Color3.fromRGB(40, 93, 180),
				Color3.fromRGB(255, 0, 0),
				val5
			}
			local nextIntegerObj_2 = Random.new()
			local eventObj_2 = Timer.Simple(0.15, function()

				changeLightsRng(val6[nextIntegerObj_2:NextInteger(1, #val6)])
			end, true)

			return function()

				eventObj_2:Disconnect()
			end
		end
	}
	local addResult = nil

	local function setStageColor(val7)

		if addResult then
			managedObj_4:Remove(addResult)
			addResult = nil
		end

		if flag_3[val7] then
			addResult = managedObj_4:Add(flag_3[val7]())
			return
		else
			changeLightsNormal(val7)
			return
		end
	end
	local val8 = 1

	local function createTrackPlayer(val9, connections, val10, val11)

		for _, v132Entry in connections do
			v132Entry.Looped = true
			v132Entry.Name = v132Entry.Animation.Name
			v132Entry:AdjustWeight(0.01)
		end
		local data_4 = {}
		for _, v132Entry_2 in connections do
			if v132Entry_2.Animation then
				local adjustWeightObj = SharedEventUtils.loadAnimation(managedObj_4, val9, v132Entry_2.Animation)
				adjustWeightObj.Name = v132Entry_2.Animation.Name .. "Copy"
				adjustWeightObj.Looped = true
				adjustWeightObj:AdjustWeight(0.01)
				data_4[v132Entry_2] = adjustWeightObj
				data_4[adjustWeightObj] = v132Entry_2
			end
		end
		local flag_4 = nil
		local adjustWeightObj_2 = nil

		return {
			setPlayingTrack = function(val12)

				if flag_4 then
					pcall(task.cancel, flag_4)
					flag_4 = nil
				end

				if adjustWeightObj_2 then
					adjustWeightObj_2:AdjustWeight(0.01, 0.4)
					adjustWeightObj_2 = nil
				end
				adjustWeightObj_2 = val12
				for _, v132Entry_3 in connections do
					if v132Entry_3 == val12 then
						if not v132Entry_3.IsPlaying then
							v132Entry_3:Play(0.1, 0.01, val8)
						end
						v132Entry_3:AdjustWeight(1, 0.25)
						if data_4[v132Entry_3] then
							data_4[v132Entry_3]:AdjustWeight(0.01, 0.4)
						end
					elseif v132Entry_3.IsPlaying then
						v132Entry_3:AdjustWeight(0.01, 0.4)
						if data_4[v132Entry_3] then
							data_4[v132Entry_3]:AdjustWeight(0.01, 0.4)
						end
					end
				end
				flag_4 = task.spawn(function()

					local v143 = val12
					if v143 and not val10[v143] then
						assert(val12)
						local val13 = val11[val12] or val11[data_4[val12]] or 1.1
						while true do
							if not v143.IsPlaying then
								v143:Play(0, 0.01, val8)
							end
							local data_4Data = data_4[v143]
							if not data_4Data.IsPlaying then
								data_4Data:Play(0, 0.01, val8)
							end
							adjustWeightObj_2 = v143
							v143.TimePosition = 0
							v143:AdjustWeight(1, 0.3)
							data_4Data:AdjustWeight(0, 0.3)
							task.wait((v143.Length or val13 + 0.5) - val13)
							data_4Data.TimePosition = v143.TimePosition
							v143:AdjustWeight(0.01, 0.4)
							data_4Data:AdjustWeight(1, 0.4)
							v143 = data_4Data
						end
					end
				end)
			end,
			trackPointers = data_4,
			tracks = connections
		}
	end

	local function part2()

		local v53 = runAt

		local function playAnimation(val14, val15, ...)

			return v53(val14 + 220.5, val15, ...)
		end
		managedObj_4:Add(function()

			val69[1]:Stop()
			val69[2]:Stop()
		end)
		managedObj_4:Add(task.spawn(function()
			local serverTimeNow_3 = workspace:GetServerTimeNow() - (l_v15_ActiveEventData_0.startedAt + 220.5)
			if serverTimeNow_3 >= 228 then
				return
			else
				val69[2].TimePosition = serverTimeNow_3
				val69[2].Volume = 0.5
				val69[2]:Play()
				return
			end
		end))
		local v64_2 = val137
		if addResult then
			managedObj_4:Remove(addResult)
			addResult = nil
		end

		if flag_3[v64_2] then
			addResult = managedObj_4:Add(flag_3[v64_2]())
		else
			changeLightsNormal(v64_2)
		end
		v64_2 = managedObj_4:Clone(script.SpotLights)
		VFX.disable(v64_2)
		v64_2.Parent = parent_3
		local children_2 = v64_2:GetChildren()
		local data_5 = {}
		local data_6 = {}
		local data_7 = {}
		for _, l_l_v64_1_Children_0Entry in children_2 do
			local displayText = nil
			displayText = if l_l_v64_1_Children_0Entry:GetAttribute("Outside") then data_5 else data_6
			local val16 = {
				model = l_l_v64_1_Children_0Entry,
				beam = l_l_v64_1_Children_0Entry.Rotate.Neon["1"].LightBeam,
				light = l_l_v64_1_Children_0Entry.Rotate.Neon.LightSource.SpotLight,
				neon = l_l_v64_1_Children_0Entry.Rotate.Neon,
				pivot = l_l_v64_1_Children_0Entry.Rotate:GetPivot(),
				side = l_l_v64_1_Children_0Entry:GetAttribute("Side"),
				beams = {}
			}
			table.insert(displayText, val16)
			table.insert(data_7, val16)
		end
		parent_3.Pavillion.Marquee.NowPlayingSign.Gui:FindFirstChild("Text").Text = "NOW PLAYING... <br /> LOCKED OUT OF HEAVEN"
		val69[2]:Play()
		local MainLance = parent_3.Stage.Rotate.Heaven.MainLance
		MainLance.Parent = parent_3.Stage
		MainLance:PivotTo(parent_3.Stage.HeavenMainLancePivot:GetPivot())
		TweenPivot(MainLance, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), MainLance:GetPivot() + Vector3.new(0, 22, 0, 0)):Play()
		local val17 = SharedEventUtils.loadAnimation(managedObj_4, MainLance.Humanoid.Animator, script.Lance2_1)
		local val18 = SharedEventUtils.loadAnimation(managedObj_4, MainLance.Humanoid.Animator, script.Lance2_3)
		local val19 = SharedEventUtils.loadAnimation(managedObj_4, MainLance.Humanoid.Animator, script.Lance2_4)
		local val20 = SharedEventUtils.loadAnimation(managedObj_4, MainLance.Humanoid.Animator, script.Lance2_4_Loop)
		local val21 = {
			[val17] = true,
			[val18] = true,
			[val19] = true,
			[val20] = true
		}
		local tweenObj = createTrackPlayer(MainLance.Humanoid.Animator, {
			val17,
			val18,
			val19,
			val20
		}, val21, {})
		local tracks = tweenObj.tracks

		local function _()

		end
		local val22 = {
			Color3.fromRGB(255, 50, 50),
			Color3.fromRGB(255, 139, 6)
		}
		local val23 = {
			Color3.fromRGB(255, 50, 50),
			Color3.fromRGB(255, 158, 105)
		}
		local val24 = {
			Color3.fromRGB(255, 50, 50),
			Color3.fromRGB(255, 255, 0)
		}
		local val25 = {
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 255, 0)
		}
		local val26 = {
			ColorSequence.new(val25[1]),
			ColorSequence.new(val25[2])
		}
		local HeavenBackwalls = parent_3.Stage.HeavenBackwalls
		local val27 = 7
		local val28 = 9
		local flag_5 = 1
		local connections_2 = bindToTag("LanceFogLightColor", function(ref1)

			ref1.Color = v64

			return nil
		end)
		local connections_3 = bindToTag("LanceTargetLight", function(ref2)

			ref2.Color = v64

			return nil
		end)

		local function setInterval(val29)

			flag_5 = val29
		end
		local val30 = 0
		local val31 = 0
		local children_3 = parent_3.Pavillion.Lights:GetChildren()
		for _, descendant_2 in parent_3.Lights:GetDescendants() do
			if descendant_2:IsA("SpotLight") then
				table.insert(children_3, descendant_2)
			end
		end
		local enabled = false
		local val32 = true
		local val33 = false

		local function tickColorChange()

			val30 = val30 % #val22 + 1
			local v188 = val30
			local v173Data = val22[v188]
			local val34 = v188 % #val22 + 1
			local v173Data_2 = val22[val34]
			Spr.target(HeavenBackwalls.NeonDeepYellow, 1, val27, {
				Color = v173Data
			})
			Spr.target(HeavenBackwalls.NeonRed, 1, val27, {
				Color = v173Data_2
			})
			Spr.target(HeavenBackwalls.NeonYellow, 1, val27, {
				Color = val23[val30]
			})
			local v175Data = val24[val30]
			for _, v183Entry in connections_2 do
				Spr.target(v183Entry, 1, val27, {
					Color = v175Data
				})
			end

			if flag_41 then
				for _, v77Entry_2 in data_3 do
					Spr.target(v77Entry_2, 1, val27, {
						Color = v175Data
					})
				end
			end

			for _, v185Entry in connections_3 do
				Spr.target(v185Entry, 1, val27, {
					Color = v175Data
				})
			end

			for _, l_Children_1Entry in children_3 do
				Spr.target(l_Children_1Entry, 1, val27, {
					Color = if nextIntegerObj_3:NextInteger(1, 2) == 1 then v175Data else val24[val34]
				})
			end
			enabled = not enabled
			for _, v159Entry in data_7 do
				local attribute = not v159Entry.model:GetAttribute("Outside")
				if (not val32 or not attribute) and (not val33 or not attribute) then
					local flag_6 = nextIntegerObj_3:NextInteger(1, 2)
					local val35 = if flag_6 == 1 then val25[val30] else val25[val34]
					local val36 = if flag_6 == 1 then val26[v188] else val26[val34]
					Spr.target(v159Entry.neon, 1, val28, {
						Color = val35
					})
					Spr.target(v159Entry.light, 1, val28, {
						Color = val35
					})
					Spr.target(v159Entry.beam, 1, val28, {
						Color = val36
					})
					for _, beam in v159Entry.beams do
						beam.beam.Enabled = enabled
						Spr.target(beam.beam, 1, val28, {
							Color = val36
						})
					end
				end
			end
			val31 = 0
		end
		local val38 = managedObj_4:Add(RunService.PostSimulation:Connect(function(val37)

			val31 = val31 + val37
			if flag_5 <= val31 then
				tickColorChange()
			end
		end))

		local function _(flag_7)
			if flag_7 == 1 then

				return flag_7 - 1, flag_7
			else

				return math.floor(flag_7 / 2), (math.ceil(flag_7 / 2))
			end
		end
		local val39 = 0

		local function setLaserAmount(flag_8)

			if flag_8 == 0 then
				local v222 = val39
				local val40, val41
				if v222 == 1 then
					val40 = v222 - 1
					val41 = v222
				else
					local val42 = math.floor(v222 / 2)
					local val43 = math.ceil(v222 / 2)
					val40 = val42
					val41 = val43
				end
				val39 = flag_8
				for _, v158Entry in data_6 do
					for i_3 = -val40, val41 do
						local managedObj = v158Entry.model.Rotate.Neon:FindFirstChild((("CustomAttachment_%*"):format(i_3)))
						if managedObj then
							for _, child in managedObj:GetChildren() do
								local flag_9 = table.find(v158Entry.beams, child)
								if flag_9 then
									table.remove(v158Entry.beams, flag_9)
								end
								Spr.target(child, 0.9, 5, {
									Width0 = 0,
									Width1 = 0
								})
							end
							task.delay(1, function()

								managedObj:Destroy()
							end)
						end
					end
				end
				return
			else
				local val44, val45
				if flag_8 == 1 then
					val44 = flag_8 - 1
					val45 = flag_8
				else
					local val46 = math.floor(flag_8 / 2)
					local val47 = math.ceil(flag_8 / 2)
					val44 = val46
					val45 = val47
				end
				local v222_2 = val39
				local val48, val49
				if v222_2 == 1 then
					val48 = v222_2 - 1
					val49 = v222_2
				else
					local val50 = math.floor(v222_2 / 2)
					local val51 = math.ceil(v222_2 / 2)
					val48 = val50
					val49 = val51
				end

				if v222_2 ~= 0 then
					for i_4 = -val48, val49 do
						if -val44 > i_4 or i_4 > val45 then
							for _, v158Entry_2 in data_6 do
								local managedObj_2 = v158Entry_2.model.Rotate.Neon:FindFirstChild((("CustomAttachment_%*"):format(i_4)))
								if managedObj_2 then
									for _, child_2 in managedObj_2:GetChildren() do
										local flag_10 = table.find(v158Entry_2.beams, child_2)
										if flag_10 then
											table.remove(v158Entry_2.beams, flag_10)
										end
										Spr.target(child_2, 0.9, 5, {
											Width0 = 0,
											Width1 = 0
										})
									end
									task.delay(1, function()

										managedObj_2:Destroy()
									end)
								end
							end
						end
					end
				end
				val39 = flag_8
				for _, v158Entry_3 in data_6 do
					local attachment0 = v158Entry_3.model.Rotate.Neon["1"]
					local cloneObj = v158Entry_3.model.Rotate.Neon["2"]
					local position = cloneObj.Position - Vector3.new(7.5, 0, 0, 0)
					for flag_11 = -val44, val45 do
						if not v158Entry_3.model.Rotate.Neon:FindFirstChild((("CustomAttachment_%*"):format(flag_11))) then
							local attachment1 = cloneObj:Clone()
							attachment1.Name = ("CustomAttachment_%*"):format(flag_11)
							if v222_2 ~= 0 then
								attachment1.Position = position + Vector3.new((if flag_11 < 0 then -val48 else val49) * 15, 0, 0)
							end
							attachment1.Parent = v158Entry_3.model.Rotate.Neon
							Spr.target(attachment1, 0.9, 5, {
								Position = position + Vector3.new(flag_11 * 15, 0, 0)
							})
							local managedObj_3 = script.lightbeambig.Beams:Clone()
							for _, child_3 in managedObj_3:GetChildren() do
								child_3.Color = v158Entry_3.beam.Color
								child_3.Width0 = 0.25
								child_3.Width1 = 0.5
								child_3.Brightness = 13
								child_3.Attachment0 = attachment0
								child_3.Attachment1 = attachment1
								child_3.Parent = v158Entry_3.model.Rotate.Neon
								table.insert(v158Entry_3.beams, {
									beam = child_3,
									attachment = attachment1,
									defaultPosition = position,
									targetPosition = position + Vector3.new(flag_11 * 15, 0, 0),
									index = flag_11
								})
							end
							managedObj_3:Destroy()
						end
					end
				end
				return
			end
		end

		local function _(val52)

			return (val52 - 57) / 0.4166666666666667
		end
		local connections_4 = {
			49.9,
			129.6,
			163,
			176.8
		}
		local connections_5 = {
			6.91,
			13.44,
			20.14,
			26.92,
			33.64,
			40.21,
			86.85,
			93.55,
			100.31,
			106.94,
			113.54,
			120.23,
			220.33,
			226.84
		}
		local getActivePanStart = function(val53)

			for _, v265Entry in connections_4 do
				if v265Entry <= val53 and val53 < v265Entry + 7.1 then

					return v265Entry
				end
			end

			return nil
		end
		local isInRedSweep = function(val54)

			for _, v266Entry in connections_5 do
				if v266Entry <= val54 and val54 <= v266Entry + 2.5 then

					return true
				end
			end

			return false
		end
		local getInsideState = function(flag_12)

			local flag_13 = false
			if flag_12 < 5 then

				return 0, 0
			elseif flag_12 < 45 then

				return 1, 5
			else
				local flag_14
				for _, v265Entry_2 in connections_4 do
					if v265Entry_2 <= flag_12 and flag_12 < v265Entry_2 + 7.1 then
						flag_14 = v265Entry_2
						flag_13 = true
					end

					if flag_13 then
						break
					end
				end

				if not flag_13 then
					flag_14 = nil
				end
				flag_13 = false
				if flag_14 then

					return 2, flag_14
				else
					local flag_15 = connections_4[1] + 7.1
					if flag_15 <= flag_12 and flag_12 < 85 then

						return 3, flag_15
					elseif flag_12 < 86 then

						return 0, 85
					elseif flag_12 < 123 then

						return 1, 86
					else
						local flag_16 = connections_4[2] + 7.1
						if flag_16 <= flag_12 and flag_12 < 162 then

							return 3, flag_16
						elseif flag_12 < 187 then

							return 0, 162
						else

							return 4, 187
						end
					end
				end
			end
		end

		local function setInsideEnabled(enabled_2)

			for _, v158Entry_4 in data_6 do
				v158Entry_4.light.Enabled = enabled_2
				v158Entry_4.beam.Enabled = enabled_2
				for _, beam_2 in v158Entry_4.beams do
					beam_2.beam.Enabled = enabled_2
				end
			end
		end
		local setInsideSpotLightEnabled = function(ref3, enabled_3)
			ref3.light.Enabled = enabled_3
			ref3.beam.Enabled = enabled_3
			for _, beam_3 in ref3.beams do
				beam_3.beam.Enabled = enabled_3
			end
		end

		local function setInsideSpotLightColor(val55)

			local val56 = ColorSequence.new(val55)
			for _, v158Entry_5 in data_6 do
				Spr.target(v158Entry_5.neon, 1, val28, {
					Color = val55
				})
				Spr.target(v158Entry_5.light, 1, val28, {
					Color = val55
				})
				Spr.target(v158Entry_5.beam, 1, val28, {
					Color = val56
				})
				for _, beam_4 in v158Entry_5.beams do
					Spr.target(beam_4.beam, 1, val28, {
						Color = val56
					})
				end
			end
		end
		local flag_17 = false
		local flag_18 = false
		local val57 = table.create(#data_6, 0)
		local val58 = table.create(#data_6, 0.8796459430051422)
		local nextNumberObj = Random.new()

		local function randomizeInsideRedAngles()

			for v158EntryId, v158Entry_12 in data_6 do
				local val59 = nextNumberObj:NextNumber(-0.6911503837897545, 0.6911503837897545) * v158Entry_12.side
				local val60 = nextNumberObj:NextNumber(0.6911503837897545, 1.0681415022205298)
				val57[v158EntryId] = val59
				val58[v158EntryId] = val60
			end
		end
		local val61 = -1
		local val62 = 0
		local val63 = table.create(#data_6, 0)

		local function _(flag_19)
			if flag_19 < 3.5 then

				return true, (math.clamp(flag_19 / 3.5, 0, 1))
			elseif flag_19 < 3.6 then

				return false, 0
			elseif flag_19 < 7.1 then
				local flag_20 = (flag_19 - 3.6) / 3.5
				if flag_20 >= 0.75 then

					return false, 0
				else

					return true, (math.clamp(flag_20, 0, 1))
				end
			else

				return false, 0
			end
		end
		local val64 = 0
		local flag_21 = 0
		for _, v158Entry_6 in data_6 do
			val64 = val64 + v158Entry_6.pivot.Position.Z
			flag_21 = flag_21 + 1
		end

		if flag_21 > 0 then
			val64 = val64 / flag_21
		end

		for v158EntryId_2, v158Entry_13 in data_6 do
			local val65 = val64 < v158Entry_13.pivot.Position.Z
			val63[v158EntryId_2] = (val65 and v158Entry_13.side == -1 or not val65 and v158Entry_13.side == 1) and 0 or 1.5707963267948966
		end

		local function aimInsideFig8(val66, _, val67)

			for v158EntryId_3, v158Entry_14 in data_6 do
				local val68 = val66 + val63[v158EntryId_3]
				local val70 = math.sin(val68)
				local val71 = math.sin(val68 * 2)
				local val72 = val70 * 3.141592653589793 * 0.13 * v158Entry_14.side + -v158Entry_14.side * 0.15707963267948966
				local val73 = 3.141592653589793 * (val67 * 0.05 * val71 + 0.225)
				v158Entry_14.model.Rotate:PivotTo(v158Entry_14.pivot * CFrame.Angles(val73, val72, 0))
			end
		end
		local parent = nil
		local parent_2 = nil
		task.spawn(function()

			if not RunService:IsStudio() then
				return
			else
				local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
				parent = Instance.new("ScreenGui")
				parent.ResetOnSpawn = false
				parent.IgnoreGuiInset = true
				parent_2 = Instance.new("TextLabel")
				parent_2.AnchorPoint = Vector2.new(0.5, 1)
				parent_2.Position = UDim2.new(0.5, 0, 1, 0)
				parent_2.Size = UDim2.new(0.25, 0, 0, 25)
				parent_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				parent_2.BackgroundTransparency = 0.35
				parent_2.BorderSizePixel = 0
				parent_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				parent_2.TextStrokeTransparency = 0.6
				parent_2.TextSize = 16
				parent_2.Font = Enum.Font.BuilderSansMedium
				parent_2.TextXAlignment = Enum.TextXAlignment.Left
				parent_2.TextYAlignment = Enum.TextYAlignment.Center
				parent_2.Text = ""
				parent_2.Parent = parent
				local uIPadding = Instance.new("UIPadding")
				uIPadding.PaddingLeft = UDim.new(0, 10)
				uIPadding.PaddingRight = UDim.new(0, 10)
				uIPadding.Parent = parent_2
				parent.Parent = PlayerGui
				managedObj_4:Add(parent)
				return
			end
		end)
		local flag_22 = 0
		local val74 = 0
		local val75 = false
		local val76 = 0
		local val77 = 0
		local val78 = 0
		managedObj_4:Add(RunService.PostSimulation:Connect(function(val79)

			local flag_23 = false
			local flag_24 = false
			local flag_25 = false
			local flag_26 = false
			local flag = val69[2].TimePosition
			local val80 = math.clamp(val69[2].PlaybackLoudness / 750, 0, 1)
			local flag_27, val81
			if flag < 5 then
				flag_27 = 0
				val81 = 0
			elseif flag < 45 then
				flag_27 = 1
				val81 = 5
			else
				local flag_28
				for _, v265Entry_3 in connections_4 do
					if v265Entry_3 <= flag and flag < v265Entry_3 + 7.1 then
						flag_28 = v265Entry_3
						flag_23 = true
					end

					if flag_23 then
						break
					end
				end

				if not flag_23 then
					flag_28 = nil
				end
				flag_23 = false
				if flag_28 then
					flag_27 = 2
					val81 = flag_28
				else
					local flag_29 = connections_4[1] + 7.1
					if flag_29 <= flag and flag < 85 then
						flag_27 = 3
						val81 = flag_29
					elseif flag < 86 then
						flag_27 = 0
						val81 = 85
					elseif flag < 123 then
						flag_27 = 1
						val81 = 86
					else
						local flag_30 = connections_4[2] + 7.1
						if flag_30 <= flag and flag < 162 then
							flag_27 = 3
							val81 = flag_30
						elseif flag < 187 then
							flag_27 = 0
							val81 = 162
						else
							flag_27 = 4
							val81 = 187
						end
					end
				end
			end

			if flag_27 ~= flag_22 then
				flag_22 = flag_27
				val74 = val81
				val32 = flag_22 ~= 4
				if flag_22 == 0 then
					setInsideSpotLightColor(val137)
					setInsideEnabled(false)
					val75 = false
					flag_17 = false
				elseif flag_22 == 1 then
					setInsideSpotLightColor(val25[1])
					setInsideEnabled(false)
					flag_17 = false
				elseif flag_22 == 2 then
					setInsideSpotLightColor(val25[2])
					setInsideEnabled(true)
					val75 = true
				elseif flag_22 == 3 then
					setInsideSpotLightColor(val25[2])
					setInsideEnabled(true)
					val61 = -1
				elseif flag_22 == 4 then
					setInsideEnabled(true)
				end
			end
			val78 = val78 + val79
			if parent_2 and val78 >= 0.1 then
				val78 = val78 - 0.1
				local val82 = ""
				if flag_22 == 0 then
					val82 = "OFF"
				elseif flag_22 == 1 then
					val82 = flag_17 and "Red sweep" or "RED - Off"
				elseif flag_22 == 2 then
					val82 = "YELLOW - pan"
				elseif flag_22 == 3 then
					val82 = "YELLOW - beat flash"
				elseif flag_22 == 4 then
					val82 = "Figure8"
				end
				local val83 = math.floor(flag / 60)
				local val84 = flag - val83 * 60
				parent_2.Text = string.format("%s  |  %s", string.format("%d:%05.2f", val83, val84), val82)
			end
			val76 = val76 + val79 * (1 / flag_5)
			local val85 = math.sin(val76)
			local val86 = math.cos(val76)
			for _, v157Entry in data_5 do
				v157Entry.model.Rotate:PivotTo(v157Entry.pivot * CFrame.Angles(val85 * v157Entry.side * 3.141592653589793 * 0.125, val86 * v157Entry.side * 3.141592653589793 * 0.125, 0))
				Spr.target(v157Entry.beam, 1, 5, {
					Width1 = 1 / flag_5 * 20 * (math.lerp(0.25, 1, val80) * 0.5)
				})
			end
			local val87 = (1 / math.max(flag_5, 0.001)) ^ 0.35 * 2
			local flag_31 = false
			if flag_22 == 4 then
				for _, v266Entry_2 in connections_5 do
					if v266Entry_2 <= flag and flag <= v266Entry_2 + 2.5 then
						flag_31 = true
						flag_24 = true
					end

					if flag_24 then
						break
					end
				end

				if not flag_24 then
					flag_31 = false
				end
			end
			flag_24 = false
			val33 = flag_31
			if flag_22 == 1 then
				for _, v266Entry_3 in connections_5 do
					if v266Entry_3 <= flag and flag <= v266Entry_3 + 2.5 then
						flag_31 = true
						flag_25 = true
					end

					if flag_25 then
						break
					end
				end

				if not flag_25 then
					flag_31 = false
				end
				flag_25 = false
				if flag_31 and not flag_17 then
					flag_17 = true
					randomizeInsideRedAngles()
					setInsideEnabled(true)
				elseif not flag_31 and flag_17 then
					flag_17 = false
					setInsideEnabled(false)
				end

				if flag_17 then
					local val88 = math.sin((flag - 57) / 0.4166666666666667 * 3.141592653589793 * 2 * 1)
					for v158EntryId_4, v158Entry_15 in data_6 do
						local val89 = val57[v158EntryId_4] + val88 * 0.5654866776461628 * v158Entry_15.side
						local v304Data = val58[v158EntryId_4]
						v158Entry_15.model.Rotate:PivotTo(v158Entry_15.pivot * CFrame.Angles(v304Data, val89, 0))
						v158Entry_15.beam.Brightness = math.lerp(6, 10, val80)
					end
				end
			elseif flag_22 == 2 then
				flag_31 = flag - val74
				local flag_32, val90
				if flag_31 < 3.5 then
					flag_32 = true
					val90 = math.clamp(flag_31 / 3.5, 0, 1)
				elseif flag_31 < 3.6 then
					flag_32 = false
					val90 = 0
				elseif flag_31 < 7.1 then
					local flag_33 = (flag_31 - 3.6) / 3.5
					if flag_33 >= 0.75 then
						flag_32 = false
						val90 = 0
					else
						flag_32 = true
						val90 = math.clamp(flag_33, 0, 1)
					end
				else
					flag_32 = false
					val90 = 0
				end

				if flag_32 ~= val75 then
					val75 = flag_32
					setInsideEnabled(flag_32)
					setInsideSpotLightColor(if flag_32 then val25[2] else val137)
				end

				if flag_32 then
					local val91 = math.lerp(1.5707963267948966, 0.4398229715025711, val90)
					for _, v158Entry_7 in data_6 do
						local val92 = -v158Entry_7.side * 0.15707963267948966
						v158Entry_7.model.Rotate:PivotTo(v158Entry_7.pivot * CFrame.Angles(val91, val92, 0))
						v158Entry_7.beam.Brightness = math.lerp(6, 10, val80)
					end
				end
			elseif flag_22 == 3 then
				flag_31 = math.floor((flag - 57) / 0.4166666666666667)
				if flag_31 ~= val61 then
					val61 = flag_31
					val62 = val62 + 0.26179938779914946
					local flag_34 = flag_31 % 2 == 0
					for _, v158Entry_8 in data_6 do
						local val93 = v158Entry_8.side == -1
						local enabled_4 = if flag_34 then val93 else not val93
						v158Entry_8.light.Enabled = enabled_4
						v158Entry_8.beam.Enabled = enabled_4
						for _, beam_5 in v158Entry_8.beams do
							beam_5.beam.Enabled = enabled_4
						end
					end
					aimInsideFig8(val62, 0.8, 0.8)
				end

				for _, v158Entry_9 in data_6 do
					v158Entry_9.beam.Brightness = 10
				end
			elseif flag_22 == 4 then
				for _, v266Entry_4 in connections_5 do
					if v266Entry_4 <= flag and flag <= v266Entry_4 + 2.5 then
						flag_31 = true
						flag_26 = true
					end

					if flag_26 then
						break
					end
				end

				if not flag_26 then
					flag_31 = false
				end
				flag_26 = false
				if flag_31 then
					if not flag_18 then
						flag_18 = true
						randomizeInsideRedAngles()
						setInsideEnabled(true)
						setInsideSpotLightColor(val25[1])
					end
					local val95 = math.sin((flag - 57) / 0.4166666666666667 * 3.141592653589793 * 2 * 1)
					for v158EntryId_5, v158Entry_16 in data_6 do
						local val96 = val57[v158EntryId_5] + val95 * 0.5654866776461628 * v158Entry_16.side
						local v304Data_2 = val58[v158EntryId_5]
						v158Entry_16.model.Rotate:PivotTo(v158Entry_16.pivot * CFrame.Angles(v304Data_2, val96, 0))
						v158Entry_16.beam.Brightness = math.lerp(6, 10, val80)
					end
				else
					if flag_18 then
						flag_18 = false
					end
					val77 = val77 + val79 * val87
					aimInsideFig8(val77, 1, 1)
					for _, v158Entry_10 in data_6 do
						v158Entry_10.beam.Brightness = math.lerp(5, 10, 1 / flag_5 * val80)
					end
				end
			end

			for _, v157Entry_2 in data_5 do
				v157Entry_2.beam.Brightness = math.lerp(5, 10, 1 / flag_5 * val80)
			end

			for _, v158Entry_11 in data_6 do
				for _, beam_6 in v158Entry_11.beams do
					Spr.target(beam_6.attachment, 0.9, 5, {
						Position = Vector3.new(beam_6.targetPosition.X, val85 * (math.abs(beam_6.index) % 2 == 0 and -1 or 1) * 15, beam_6.targetPosition.Z)
					})
				end
			end
		end))
		local data_8 = {}

		local function cancelCurrentCarpetLightEffects()

			for _, v408Entry in data_8 do
				if v408Entry then
					pcall(task.cancel, v408Entry)
				end
			end
			table.clear(data_8)
			for _, v77Entry_3 in data_3 do
				Spr.target(v77Entry_3, 1, val27, {
					Color = val137
				})
			end
		end
		local connections_6 = table.clone(data_3)
		table.sort(connections_6, function(ref4, ref5)

			return ref4.Position.Z < ref5.Position.Z
		end)
		local data_9 = {}
		for v414EntryId, v414Entry in connections_6 do
			if v414EntryId % 2 == 0 then
				table.insert(data_9, {
					connections_6[v414EntryId - 1],
					v414Entry
				})
			end
		end

		local function playCarpetLightsFillEffect(val99, val100, flag_35)

			table.insert(data_8, task.spawn(function()

				local val101 = val100 / 98
				local val102 = 0
				for v414EntryId_2, v414Entry_2 in connections_6 do
					Spr.target(v414Entry_2, 1, val27, {
						Color = val99
					})
					if flag_35 then
						table.insert(data_8, task.delay(flag_35, function()

							Spr.target(v414Entry_2, 1, val27, {
								Color = val137
							})
						end))
					end

					if v414EntryId_2 % 2 == 0 then
						while val102 < val101 do
							val102 = val102 + RunService.PostSimulation:Wait()
						end
						val102 = val102 - val101
					end
				end
				local flag_36 = table.find(data_8, coroutine.running())
				if flag_36 then
					table.remove(data_8, flag_36)
				end
			end))
		end

		local function flashingCarpetAlternatingEffect(val103, val105)

			cancelCurrentCarpetLightEffects()
			table.insert(data_8, task.spawn(function()

				local val106 = 0
				while true do
					for v417EntryId, v417Entry in data_9 do
						local val107 = if (v417EntryId + val106) % 2 == 0 then val105 else val137
						for _, v433Entry in v417Entry do
							Spr.target(v433Entry, 1, val27, {
								Color = val107
							})
						end
					end
					local val108 = val103()
					task.wait(val108)
					val106 = val106 + 1
				end
			end))
		end
		val8 = 1
		for _, l_tracks_0Entry in tracks do
			l_tracks_0Entry:AdjustSpeed(val31)
			if tweenObj.trackPointers[l_tracks_0Entry] then
				tweenObj.trackPointers[l_tracks_0Entry]:AdjustSpeed(val31)
			end
		end
		tweenObj.setPlayingTrack(val17)
		playAnimation(18.5, tweenObj.setPlayingTrack, val18)
		playAnimation(20.8, tweenObj.setPlayingTrack, val17)
		playAnimation(44.5, tweenObj.setPlayingTrack, val19)
		playAnimation(49, tweenObj.setPlayingTrack, val20)
		playAnimation(84, tweenObj.setPlayingTrack, val17)
		playAnimation(97, tweenObj.setPlayingTrack, val18)
		playAnimation(99.3, tweenObj.setPlayingTrack, val17)
		playAnimation(124, tweenObj.setPlayingTrack, val19)
		playAnimation(128.5, tweenObj.setPlayingTrack, val20)
		playAnimation(162, tweenObj.setPlayingTrack, val18)
		playAnimation(164.3, tweenObj.setPlayingTrack, val20)
		playAnimation(190, tweenObj.setPlayingTrack, val17)
		playAnimation(201, tweenObj.setPlayingTrack, val19)
		playAnimation(205.5, tweenObj.setPlayingTrack, val20)
		playAnimation(226, tweenObj.setPlayingTrack, val17)

		local function songIntervalGetter()

			return flag_5
		end
		flag_5 = 0.75
		VFX.enable(v64_2)
		flag_41 = false
		local val109 = val24[2]
		cancelCurrentCarpetLightEffects()
		table.insert(data_8, task.spawn(function()

			local val110 = 0
			while true do
				for v417EntryId_2, v417Entry_2 in data_9 do
					local val111 = if (v417EntryId_2 + val110) % 2 == 0 then val109 else val137
					for _, v445Entry in v417Entry_2 do
						Spr.target(v445Entry, 1, val27, {
							Color = val111
						})
					end
				end
				local val112 = songIntervalGetter()
				task.wait(val112)
				val110 = val110 + 1
			end
		end))
		playAnimation(3.8, cancelCurrentCarpetLightEffects)
		for _, val113 in {
			{
				4,
				8,
				2
			},
			{
				11,
				15,
				2
			},
			{
				18,
				22,
				2
			},
			{
				24,
				28,
				2
			},
			{
				31,
				35,
				2
			},
			{
				37,
				48,
				2
			},
			{
				50,
				58,
				1.25
			},
			{
				84,
				86,
				2
			},
			{
				90,
				94,
				2
			},
			{
				96,
				96,
				2
			},
			{
				102.5,
				106.5,
				2
			},
			{
				109.5,
				113.5,
				2
			},
			{
				116,
				120,
				2
			},
			{
				122,
				126,
				2
			},
			{
				214,
				218,
				2
			},
			{
				220,
				224,
				2
			},
			{
				226,
				228,
				2
			}
			} do
			for i_5 = val113[1] - 0, val113[2] - 0, val113[3] do
				playAnimation(i_5, playCarpetLightsFillEffect, val24[2], 0.3, 0.3)
				playAnimation(i_5 + 0.6, playCarpetLightsFillEffect, val24[2], 0.3, 0.3)
			end
		end
		playAnimation(57, flashingCarpetAlternatingEffect, songIntervalGetter, val24[2])
		playAnimation(83, cancelCurrentCarpetLightEffects)
		playAnimation(83, playCarpetLightsFillEffect, val24[2], 0.3, 0.5)
		playAnimation(130, flashingCarpetAlternatingEffect, songIntervalGetter, val24[2])
		playAnimation(160, cancelCurrentCarpetLightEffects)
		playAnimation(162, flashingCarpetAlternatingEffect, songIntervalGetter, val24[2])
		playAnimation(188, cancelCurrentCarpetLightEffects)
		playAnimation(202, flashingCarpetAlternatingEffect, songIntervalGetter, val24[2])
		playAnimation(214, cancelCurrentCarpetLightEffects)
		local val114 = 3 + 1
		playAnimation(57, setLaserAmount, val114)
		val114 = val114 + 1
		playAnimation(60, setLaserAmount, val114)
		val114 = val114 + 1
		playAnimation(63, setLaserAmount, val114)
		playAnimation(66, setLaserAmount, val114 + 1)
		playAnimation(4, setInterval, 0.3)
		playAnimation(44, setInterval, 0.2)
		playAnimation(57, setInterval, 0.15)
		playAnimation(70, setInterval, 0.125)
		playAnimation(79, setInterval, 0.3)
		playAnimation(84, setInterval, 0.15)
		playAnimation(84.5, setLaserAmount, 0)
		playAnimation(135, setInterval, 0.2)
		playAnimation(149, setInterval, 0.175)
		playAnimation(161, setInterval, 0.2)
		playAnimation(187.5, setInterval, 0.5)
		playAnimation(202, setInterval, 0.2)
		playAnimation(215, setInterval, 0.25)
		playAnimation(230.5, function()

			managedObj_4:Remove(val38)
			val27 = 1
			val28 = 2
			local val115 = ColorSequence.new(val137)
			Spr.target(HeavenBackwalls.NeonDeepYellow, 1, val27, {
				Color = val137
			})
			Spr.target(HeavenBackwalls.NeonRed, 1, val27, {
				Color = val137
			})
			Spr.target(HeavenBackwalls.NeonYellow, 1, val27, {
				Color = val137
			})
			for _, v183Entry_2 in connections_2 do
				Spr.target(v183Entry_2, 1, val27, {
					Color = val137
				})
			end

			for _, v185Entry_2 in connections_3 do
				Spr.target(v185Entry_2, 1, val27, {
					Color = val137
				})
			end

			for _, v75Entry_3 in connections_7 do
				Spr.target(v75Entry_3, 1, val27, {
					Color = val137
				})
			end

			for _, v77Entry_4 in data_3 do
				Spr.target(v77Entry_4, 1, val27, {
					Color = val137
				})
			end

			for _, l_Children_1Entry_2 in children_3 do
				Spr.target(l_Children_1Entry_2, 1, val27, {
					Color = val137
				})
			end

			for _, v159Entry_2 in data_7 do
				Spr.target(v159Entry_2.beam, 0.9, 5, {
					Width0 = 0,
					Width1 = 0
				})
				Spr.target(v159Entry_2.neon, 1, val28, {
					Color = val137
				})
				Spr.target(v159Entry_2.light, 1, val28, {
					Color = val137
				})
				Spr.target(v159Entry_2.beam, 1, val28, {
					Color = val115
				})
				for _, beam_7 in v159Entry_2.beams do
					Spr.target(beam_7.beam, 1, val28, {
						Color = val115
					})
				end
			end

			if math.max(l_v15_ActiveEventData_0.startedAt + 231.5 - workspace:GetServerTimeNow(), 0) <= 0 then
				return
			else
				local val116 = os.clock()
				while true do
					local flag_38 = (os.clock() - val116) / 0.5
					local val117 = math.lerp(1, 0, flag_38)
					val8 = val117
					for _, l_tracks_0Entry_2 in tracks do
						l_tracks_0Entry_2:AdjustSpeed(val117)
						if tweenObj.trackPointers[l_tracks_0Entry_2] then
							tweenObj.trackPointers[l_tracks_0Entry_2]:AdjustSpeed(val117)
						end
					end

					if flag_38 < 1 then
						RunService.PreRender:Wait()
					else
						break
					end
				end
				return
			end
		end)
		playAnimation(228, function()

			VFX.disable(parent_3.Stage)
		end)
	end

	local function createStage()

		managedObj_4:Add(function()

			val69[1]:Stop()
			val69[2]:Stop()
		end)
		managedObj_4:Add(task.spawn(function()
			local serverTimeNow_4 = workspace:GetServerTimeNow() - (l_v15_ActiveEventData_0.startedAt + 5)
			if serverTimeNow_4 >= 209.5 then
				return
			else
				val69[1].TimePosition = serverTimeNow_4
				val69[1].Volume = 0.5
				val69[1]:Play()
				return
			end
		end))
		managedObj_4:Clone(script.Night_Sky).Parent = Lighting
		local Atmosphere = Lighting:FindFirstChild("Atmosphere")
		if Atmosphere then
			Atmosphere.Parent = script
			managedObj_4:Add(function()

				Atmosphere.Parent = Lighting
			end)
		end
		managedObj_4:Clone(script.AtmosphereLance).Parent = Lighting
		local getChildrenObj = managedObj_4:Clone(script.CarpetLights)
		data_3 = getChildrenObj:GetChildren()
		getChildrenObj.Parent = parent_3
		parent_3.Parent = workspace
		parent_3.Pavillion.Marquee.NowPlayingSign.Gui:FindFirstChild("Text").Text = "NOW PLAYING... <br /> I JUST MIGHT"
		managedObj_4:Add(Observers.observeTag("HideInLance", function(ref6)
			local Parent = ref6.Parent
			ref6.Parent = script

			return function()

				pcall(function()

					ref6.Parent = Parent
				end)
			end
		end, {
			workspace,
			script,
			Lighting
		}))
		local v53_2 = runAt

		local function playAnimation_2(val118, ...)

			return v53_2(val118 + 5, ...)
		end
		local data_10 = {}

		local function playInstrumentLooped(findFirstChildObj)

			if not data_10[findFirstChildObj] and findFirstChildObj:FindFirstChild("Animation") then
				local tweenObj_2 = SharedEventUtils.loadAnimation(managedObj_4, findFirstChildObj.AnimationController.Animator, findFirstChildObj.Animation)
				tweenObj_2.Looped = true
				tweenObj_2:Play()
				data_10[findFirstChildObj] = tweenObj_2
			end
		end

		local function playInstrumentOnce(findFirstChildObj_2)

			local data_10Data = data_10[findFirstChildObj_2]
			if not data_10Data and findFirstChildObj_2:FindFirstChild("Animation") then
				data_10Data = SharedEventUtils.loadAnimation(managedObj_4, findFirstChildObj_2.AnimationController.Animator, findFirstChildObj_2.Animation)
				assert(data_10Data)
				data_10Data.Looped = false
				data_10[findFirstChildObj_2] = data_10Data
			end

			if data_10Data then
				data_10Data:Stop()
				data_10Data:Play()
			end
		end
		local Instruments = parent_3.Stage.Rotate.TheRomantic.Instruments
		playAnimation_2(2, playInstrumentLooped, Instruments.DrumKit.TomDrum1)
		playAnimation_2(2, playInstrumentLooped, Instruments.DrumKit.TomDrum2)
		local MainLance_2 = parent_3.Stage.Rotate.TheRomantic.MainLance
		local tweenObj_3 = SharedEventUtils.loadAnimation(managedObj_4, parent_3.Stage.Rotate.TheRomantic.CongaLance.Humanoid.Animator, script.LanceConga)
		tweenObj_3.Looped = true
		tweenObj_3:Play()
		managedObj_4:Add(tweenObj_3:GetMarkerReachedSignal("Conga1"):Connect(function()

			playInstrumentOnce(Instruments.Conga1)
		end))
		managedObj_4:Add(tweenObj_3:GetMarkerReachedSignal("Conga2"):Connect(function()

			playInstrumentOnce(Instruments.Conga2)
		end))
		local tweenObj_4 = SharedEventUtils.loadAnimation(managedObj_4, parent_3.Stage.Rotate.TheRomantic.DrumsLance.Humanoid.Animator, script.LanceDrums)
		tweenObj_4.Looped = true
		tweenObj_4:Play()
		managedObj_4:Add(tweenObj_4:GetMarkerReachedSignal("Drum1"):Connect(function()

			playInstrumentOnce(Instruments.DrumKit.Drum1)
		end))
		managedObj_4:Add(tweenObj_4:GetMarkerReachedSignal("Drum2"):Connect(function()

			playInstrumentOnce(Instruments.DrumKit.Drum2)
		end))
		managedObj_4:Add(tweenObj_4:GetMarkerReachedSignal("Drum3"):Connect(function()

			playInstrumentOnce(Instruments.DrumKit.Drum3)
		end))
		local tweenObj_5 = SharedEventUtils.loadAnimation(managedObj_4, parent_3.Stage.Rotate.TheRomantic.GuitarLance1.Humanoid.Animator, script.LanceGuitar)
		tweenObj_5.Looped = true
		tweenObj_5:Play()
		local tweenObj_6 = SharedEventUtils.loadAnimation(managedObj_4, parent_3.Stage.Rotate.TheRomantic.GuitarLance2.Humanoid.Animator, script.LanceGuitar)
		tweenObj_6.Looped = true
		tweenObj_6:Play()
		local val119 = SharedEventUtils.loadAnimation(managedObj_4, MainLance_2.Humanoid.Animator, script.Lance1)
		local val120 = SharedEventUtils.loadAnimation(managedObj_4, MainLance_2.Humanoid.Animator, script.Lance2)
		local adjustWeightObj_3 = SharedEventUtils.loadAnimation(managedObj_4, MainLance_2.Humanoid.Animator, script.Lance4)
		local val121 = SharedEventUtils.loadAnimation(managedObj_4, MainLance_2.Humanoid.Animator, script.Lance5)
		local val123 = SharedEventUtils.loadAnimation(managedObj_4, MainLance_2.Humanoid.Animator, script.Lance6)
		local val124 = SharedEventUtils.loadAnimation(managedObj_4, MainLance_2.Humanoid.Animator, script.Lance8)
		local val125 = {
			[adjustWeightObj_3] = true
		}
		local ref7 = createTrackPlayer(MainLance_2.Humanoid.Animator, {
			val119,
			val120,
			adjustWeightObj_3,
			val121,
			val123,
			val124
		}, val125, {
			[adjustWeightObj_3] = 1.5,
			[val120] = 0.95,
			[val121] = 0.3,
			[val123] = 0.5,
			[val124] = 0.8
		})
		local setPlayingTrack = ref7.setPlayingTrack
		local trackPointers = ref7.trackPointers
		local tracks_2 = ref7.tracks
		adjustWeightObj_3:AdjustWeight(1)
		playAnimation_2(0, setPlayingTrack, adjustWeightObj_3)
		playAnimation_2(5, setPlayingTrack, val119)
		playAnimation_2(14, setPlayingTrack, val120)
		playAnimation_2(27, setPlayingTrack, adjustWeightObj_3)
		playAnimation_2(36, setPlayingTrack, val120)
		playAnimation_2(64, setPlayingTrack, val123)
		playAnimation_2(97, setPlayingTrack, val120)
		playAnimation_2(117, setPlayingTrack, val124)
		playAnimation_2(135, setPlayingTrack, val121)
		playAnimation_2(161, setPlayingTrack, val124)
		playAnimation_2(180, setPlayingTrack, val119)
		LightSequences.Play("WhitePlain")
		local v64_3 = val137
		if addResult then
			managedObj_4:Remove(addResult)
			addResult = nil
		end

		if flag_3[v64_3] then
			addResult = managedObj_4:Add(flag_3[v64_3]())
		else
			changeLightsNormal(v64_3)
		end
		playAnimation_2(1.8, LightSequences.Stop)
		playAnimation_2(2, LightSequences.Play, "RowSpinWhite")
		playAnimation_2(2, setStageColor, val133)
		playAnimation_2(2.5, LightSequences.Stop)
		playAnimation_2(2.5, setStageColor, val137)
		playAnimation_2(3, LightSequences.Play, "OrangePlain")
		playAnimation_2(3, setStageColor, val134)
		playAnimation_2(3.5, LightSequences.Stop)
		playAnimation_2(3.5, setStageColor, val137)
		playAnimation_2(4, LightSequences.Play, "OrangePlain")
		playAnimation_2(4, setStageColor, val134)
		playAnimation_2(4.5, LightSequences.Stop)
		playAnimation_2(4.5, setStageColor, val137)
		playAnimation_2(5, LightSequences.Play, "Mirage")
		playAnimation_2(5, setStageColor, val134)
		playAnimation_2(9.2, LightSequences.Stop)
		playAnimation_2(9.2, setStageColor, val137)
		playAnimation_2(9.5, LightSequences.Play, "Spiral")
		playAnimation_2(9.5, setStageColor, val133)
		playAnimation_2(13, LightSequences.Play, "OrangePlain")
		playAnimation_2(13, setStageColor, val134)
		playAnimation_2(13.3, LightSequences.Play, "RedPlain")
		playAnimation_2(13.3, setStageColor, val136)
		playAnimation_2(13.5, LightSequences.Play, "OrangePlain")
		playAnimation_2(13.5, setStageColor, val134)
		playAnimation_2(13.7, LightSequences.Stop)
		playAnimation_2(13.7, setStageColor, val137)
		playAnimation_2(14, LightSequences.Play, "BackAndForth")
		playAnimation_2(14, setStageColor, val134)
		playAnimation_2(23, LightSequences.Stop)
		playAnimation_2(23, setStageColor, val137)
		playAnimation_2(23.5, LightSequences.Play, "BackAndForth")
		playAnimation_2(23.5, setStageColor, val134)
		playAnimation_2(31.5, LightSequences.Stop)
		playAnimation_2(31.5, setStageColor, val137)
		playAnimation_2(32, LightSequences.Play, "OrangePlain")
		playAnimation_2(32, setStageColor, val134)
		playAnimation_2(32.5, LightSequences.Play, "Crazy")
		playAnimation_2(32.5, setStageColor, "CRAZY_SEQUENCE")
		playAnimation_2(36.4, LightSequences.Stop)
		playAnimation_2(36.4, setStageColor, val137)
		playAnimation_2(36.7, LightSequences.Play, "Mirage")
		playAnimation_2(36.7, setStageColor, val133)
		playAnimation_2(39.6, LightSequences.Stop)
		playAnimation_2(39.6, setStageColor, val137)
		playAnimation_2(41, LightSequences.Play, "WhitePlain")
		playAnimation_2(41, setStageColor, val133)
		playAnimation_2(41.8, LightSequences.Play, "BackAndForth")
		playAnimation_2(41.8, setStageColor, val134)
		playAnimation_2(50, LightSequences.Play, "WhitePlain")
		playAnimation_2(50, setStageColor, val133)
		playAnimation_2(50.5, LightSequences.Stop)
		playAnimation_2(50.5, setStageColor, val137)
		playAnimation_2(51, LightSequences.Play, "WhitePlain")
		playAnimation_2(51, setStageColor, val133)
		playAnimation_2(51.5, LightSequences.Play, "ExtraCrazy")
		playAnimation_2(51.5, setStageColor, "EXTRA_CRAZY_SEQUENCE")
		playAnimation_2(62.5, LightSequences.Stop)
		playAnimation_2(62.5, setStageColor, val137)
		playAnimation_2(63, LightSequences.Play, "WhitePlain")
		playAnimation_2(63, setStageColor, val133)
		playAnimation_2(63.5, LightSequences.Stop)
		playAnimation_2(63.5, setStageColor, val137)
		playAnimation_2(64, LightSequences.Play, "WhitePlain")
		playAnimation_2(64, setStageColor, val133)
		playAnimation_2(64.5, LightSequences.Stop)
		playAnimation_2(64.5, setStageColor, val137)
		playAnimation_2(65, LightSequences.Play, "RowSpinWhite")
		playAnimation_2(65, setStageColor, val133)
		playAnimation_2(67, LightSequences.Play, "RowSpinRed")
		playAnimation_2(67, setStageColor, val136)
		playAnimation_2(74, LightSequences.Play, "WhitePlain")
		playAnimation_2(74, setStageColor, val133)
		playAnimation_2(74.3, LightSequences.Play, "OrangePlain")
		playAnimation_2(74.3, setStageColor, val134)
		playAnimation_2(74.6, LightSequences.Play, "WhitePlain")
		playAnimation_2(74.6, setStageColor, val133)
		playAnimation_2(74.8, LightSequences.Stop, true)
		playAnimation_2(74.8, setStageColor, val137)
		playAnimation_2(75, LightSequences.Play, "RowSpinRed")
		playAnimation_2(75, setStageColor, val136)
		playAnimation_2(78, LightSequences.Stop, true)
		playAnimation_2(78, setStageColor, val137)
		playAnimation_2(78.5, LightSequences.Play, "WhitePlain")
		playAnimation_2(78.5, setStageColor, val133)
		playAnimation_2(84, LightSequences.Play, "OrangePlain")
		playAnimation_2(84, setStageColor, val134)
		playAnimation_2(85.5, LightSequences.Play, "WhitePlain")
		playAnimation_2(85.5, setStageColor, val133)
		playAnimation_2(88.5, LightSequences.Play, "OrangePlain")
		playAnimation_2(88.5, setStageColor, val134)
		playAnimation_2(88.8, LightSequences.Stop, true)
		playAnimation_2(88.8, setStageColor, val137)
		playAnimation_2(89.3, LightSequences.Play, "WhitePlain")
		playAnimation_2(89.3, setStageColor, val133)
		playAnimation_2(97, LightSequences.Stop, true)
		playAnimation_2(97, setStageColor, val137)
		playAnimation_2(98, LightSequences.Play, "Crazy")
		playAnimation_2(98, setStageColor, "CRAZY_SEQUENCE")
		playAnimation_2(102.5, LightSequences.Play, "MirageRed")
		playAnimation_2(102.5, setStageColor, val136)
		playAnimation_2(106, LightSequences.Play, "OrangePlain")
		playAnimation_2(106, setStageColor, val134)
		playAnimation_2(106.4, LightSequences.Play, "WhitePlain")
		playAnimation_2(106.4, setStageColor, val133)
		playAnimation_2(107, LightSequences.Stop, true)
		playAnimation_2(107, setStageColor, val137)
		playAnimation_2(107.5, LightSequences.Play, "Crazy")
		playAnimation_2(107.5, setStageColor, "CRAZY_SEQUENCE")
		playAnimation_2(111.5, LightSequences.Play, "BackAndForthOrange")
		playAnimation_2(111.5, setStageColor, val134)
		playAnimation_2(116, LightSequences.Play, "WhitePlain")
		playAnimation_2(116, setStageColor, val133)
		playAnimation_2(116.3, LightSequences.Stop, true)
		playAnimation_2(116.3, setStageColor, val137)
		playAnimation_2(116.5, LightSequences.Play, "WhitePlain")
		playAnimation_2(116.5, setStageColor, val133)
		playAnimation_2(116.8, LightSequences.Stop, true)
		playAnimation_2(116.8, setStageColor, val137)
		playAnimation_2(117, LightSequences.Play, "ExtraCrazy")
		playAnimation_2(117, setStageColor, "EXTRA_CRAZY_SEQUENCE")
		playAnimation_2(128, LightSequences.Stop, true)
		playAnimation_2(128, setStageColor, val137)
		playAnimation_2(128.5, LightSequences.Play, "ExtraCrazy")
		playAnimation_2(128.5, setStageColor, "EXTRA_CRAZY_SEQUENCE")
		playAnimation_2(129, LightSequences.Stop)
		playAnimation_2(129, setStageColor, val137)
		playAnimation_2(129.5, LightSequences.Play, "WhitePlain")
		playAnimation_2(129.5, setStageColor, val133)
		playAnimation_2(129.8, LightSequences.Stop)
		playAnimation_2(129.8, setStageColor, val137)
		playAnimation_2(130.3, LightSequences.Play, "WhitePlain")
		playAnimation_2(130.3, setStageColor, val133)
		playAnimation_2(130.6, LightSequences.Stop)
		playAnimation_2(130.6, setStageColor, val137)
		playAnimation_2(131, LightSequences.Play, "RowSpinWhite")
		playAnimation_2(131, setStageColor, val133)
		playAnimation_2(132.5, LightSequences.Play, "RowSpinRed")
		playAnimation_2(132.5, setStageColor, val136)
		playAnimation_2(135, LightSequences.Stop)
		playAnimation_2(135, setStageColor, val137)
		playAnimation_2(135.5, LightSequences.Play, "BluePlain")
		playAnimation_2(135.5, setStageColor, val135)
		playAnimation_2(136, LightSequences.Play, "BackAndForthBlue")
		playAnimation_2(136, setStageColor, val135)
		playAnimation_2(157, LightSequences.Play, "WhitePlain")
		playAnimation_2(157, setStageColor, val133)
		playAnimation_2(157.5, LightSequences.Stop)
		playAnimation_2(157.5, setStageColor, val137)
		playAnimation_2(158, LightSequences.Play, "WhitePlain")
		playAnimation_2(158, setStageColor, val133)
		playAnimation_2(158.5, LightSequences.Stop)
		playAnimation_2(158.5, setStageColor, val137)
		playAnimation_2(159, LightSequences.Play, "RowSpinWhite")
		playAnimation_2(159, setStageColor, val133)
		playAnimation_2(160.5, LightSequences.Play, "RowSpinRed")
		playAnimation_2(160.5, setStageColor, val136)
		playAnimation_2(161.7, LightSequences.Stop)
		playAnimation_2(161.7, setStageColor, val137)
		playAnimation_2(162.3, LightSequences.Play, "WhitePlain")
		playAnimation_2(162.3, setStageColor, val133)
		playAnimation_2(162.6, LightSequences.Stop)
		playAnimation_2(162.6, setStageColor, val137)
		playAnimation_2(162.8, LightSequences.Play, "WhitePlain")
		playAnimation_2(162.8, setStageColor, val133)
		playAnimation_2(163.2, LightSequences.Play, "ExtraCrazy")
		playAnimation_2(163.2, setStageColor, "EXTRA_CRAZY_SEQUENCE")
		playAnimation_2(176, LightSequences.Stop)
		playAnimation_2(176, setStageColor, val137)
		playAnimation_2(176.5, LightSequences.Play, "WhitePlain")
		playAnimation_2(176.5, setStageColor, val133)
		playAnimation_2(176.7, LightSequences.Stop)
		playAnimation_2(176.7, setStageColor, val137)
		playAnimation_2(177, LightSequences.Play, "RowSpinWhite")
		playAnimation_2(177, setStageColor, val133)
		playAnimation_2(179, LightSequences.Play, "RowSpinRed")
		playAnimation_2(179, setStageColor, val136)
		playAnimation_2(181, LightSequences.Play, "OrangePlain")
		playAnimation_2(181, setStageColor, val134)
		playAnimation_2(181.3, LightSequences.Stop)
		playAnimation_2(181.3, setStageColor, val137)
		playAnimation_2(181.6, LightSequences.Play, "WhitePlain")
		playAnimation_2(181.6, setStageColor, val133)
		playAnimation_2(181.6, LightSequences.Play, "Mirage")
		playAnimation_2(181.6, setStageColor, val134)
		playAnimation_2(187.5, LightSequences.Play, "ExtraCrazy")
		playAnimation_2(187.5, setStageColor, "EXTRA_CRAZY_SEQUENCE")
		playAnimation_2(193.9, LightSequences.Stop)
		playAnimation_2(193.9, setStageColor, val137)
		playAnimation_2(194.4, LightSequences.Play, "WhitePlain")
		playAnimation_2(194.4, setStageColor, val133)
		playAnimation_2(194.8, LightSequences.Stop)
		playAnimation_2(194.8, setStageColor, val137)
		playAnimation_2(195, LightSequences.Play, "WhitePlain")
		playAnimation_2(195, setStageColor, val133)
		playAnimation_2(195.3, LightSequences.Stop)
		playAnimation_2(195.3, setStageColor, val137)
		playAnimation_2(195.6, LightSequences.Play, "RowSpinWhite")
		playAnimation_2(195.6, setStageColor, val133)
		playAnimation_2(198, LightSequences.Play, "RowSpinRed")
		playAnimation_2(198, setStageColor, val136)
		playAnimation_2(200, LightSequences.Play, "Crazy")
		playAnimation_2(200, setStageColor, "CRAZY_SEQUENCE")
		playAnimation_2(204, LightSequences.Play, "OrangePlain")
		playAnimation_2(204, setStageColor, val134)
		playAnimation_2(204.3, LightSequences.Play, "WhitePlain")
		playAnimation_2(204.3, setStageColor, val133)
		playAnimation_2(204.6, LightSequences.Stop)
		playAnimation_2(204.6, setStageColor, val137)
		playAnimation_2(205, LightSequences.Play, "Crazy")
		playAnimation_2(205, setStageColor, "CRAZY_SEQUENCE")
		playAnimation_2(208, LightSequences.Stop)
		playAnimation_2(208, setStageColor, val137)
		playAnimation_2(208.5, LightSequences.Play, "Mirage")
		playAnimation_2(208.5, setStageColor, val134)
		playAnimation_2(209, function()

			local val126 = os.clock()
			while true do
				local flag_39 = (os.clock() - val126) / 0.5
				local val128 = math.lerp(1, 0, flag_39)
				val8 = val128
				for _, l_tracks_1Entry in tracks_2 do
					l_tracks_1Entry:AdjustSpeed(val128)
					if trackPointers[l_tracks_1Entry] then
						trackPointers[l_tracks_1Entry]:AdjustSpeed(val128)
					end
				end
				tweenObj_5:AdjustSpeed(val128)
				tweenObj_6:AdjustSpeed(val128)
				tweenObj_3:AdjustSpeed(val128)
				tweenObj_4:AdjustSpeed(val128)
				if flag_39 < 1 then
					RunService.PreRender:Wait()
				else
					break
				end
			end
		end)
		playAnimation_2(209.5, LightSequences.Stop)
		playAnimation_2(209.5, setStageColor, val137)
		playAnimation_2(209.5, function()

			for _, v84Entry_3 in connections_8 do
				Spr.target(v84Entry_3, 1, 3, {
					Color = val137
				})
			end
			managedObj_4:Add(CreateTween(val69[1], TweenInfo.new((math.max(math.max(l_v15_ActiveEventData_0.startedAt + 215.5 - workspace:GetServerTimeNow(), 0), 0.05))), {
				Volume = 0
			})).Completed:Wait()
			StageRotate.Play(function(val129)

				local new = TweenInfo.new
				local val130 = val129 * 2 + 215.5

				return new(math.max(l_v15_ActiveEventData_0.startedAt + val130 - workspace:GetServerTimeNow(), 0), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
			end)
		end)
		playAnimation_2(216.5, function()
			ReplicatedStorage:SetAttribute("LanceEvent1Music", nil)
			ReplicatedStorage:SetAttribute("LanceEventPart2", true)
			SoundController:UpdateOST()
			for _, l_tracks_1Entry_2 in tracks_2 do
				managedObj_4:Add(task.delay(5, l_tracks_1Entry_2.Stop, l_tracks_1Entry_2, 0))
			end
			part2()
		end)
	end
	managedObj_4:Add((createEventScheduler(0, 5, function(val131)

		managedObj_4:Add(CreateTween(colorCorrectionEffect, TweenInfo.new(val131(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Brightness = -1.2
		}))
		EffectController:Run("LanceEvent", "GrassRecolor")
		managedObj_4:Add(function()

			EffectController:Stop("LanceEvent", "GrassRecolor")
		end)
		managedObj_4:Add(task.delay(val131(), function()

			createStage()
			ReplicatedStorage:SetAttribute("LanceEvent1Music", true)
			SoundController:UpdateOST()
			Lighting.Brightness = 1
			Lighting.Ambient = Color3.fromRGB(0, 0, 0)
			Lighting.GlobalShadows = false
			Lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 20)
			Lighting.ExposureCompensation = 1.5
			colorCorrectionEffect.Saturation = 0.15
			colorCorrectionEffect.Contrast = -0.1
			managedObj_4:Add(function()

				Lighting.Brightness = 2
				Lighting.GlobalShadows = true
				Lighting.Ambient = Color3.fromRGB(241, 241, 241)
				Lighting.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
				Lighting.ExposureCompensation = 0
			end)
			managedObj_4:Add(CreateTween(colorCorrectionEffect, TweenInfo.new(math.max(l_v15_ActiveEventData_0.startedAt + 6 - workspace:GetServerTimeNow(), 0), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Brightness = -0.1
			}))
		end))
	end)))
	CycleController:Update()
	SoundController:UpdateOST()
end

data.OnStop = function(_)

	managedObj_4:Destroy()
end

data.OnLoad = function(_)

end

return data
