
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)

local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local Name = script.Name

local onClientEventObj = Net:RemoteEvent((("EventService/%*/Burst"):format(Name)))

local managedObj = Trove.new()

local function growBush(getDescendantsObj, val1, flag)

	local function growPart(ref2, ref3, val2, val3)
		local originalCFrame = ref2.CFrame
		local size = Vector3.new(val3 and 0 or ref3.X, 0, val3 and 0 or ref3.Z)

		local frame = originalCFrame * CFrame.new(0, -(ref3.Y - size.Y) / 2, 0)

		ref2.Size = size
		ref2.CFrame = frame

		local originalTransparency = ref2.Transparency
		ref2.Transparency = 1

		managedObj:Add(task.delay(if flag then flag(val2) else val2, function()
			ref2.Transparency = originalTransparency

			local duration = if flag then flag(val2 + 1) else 1
			local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

			CreateTween(ref2, tweenInfo, {
				Size = ref3,
				CFrame = originalCFrame
			})
		end))
	end
	local data_2 = {}
	local val5 = 1e999
	local val6 = -1e999
	for _, descendant in getDescendantsObj:GetDescendants() do
		if descendant:IsA("BasePart") and descendant.Transparency < 1 then
			table.insert(data_2, descendant)
			val5 = math.min(val5, descendant.Position.Y)
			val6 = math.max(val6, descendant.Position.Y)
		end
	end
	table.sort(data_2, function(ref4, ref5)

		return ref4.Position.Y < ref5.Position.Y
	end)
	local val7 = val6 - val5
	for _, v34Entry in data_2 do
		local val8 = (v34Entry.Position.Y - val5) / val7 * val1 + 0.25
		local flag_2 = v34Entry:FindFirstAncestorOfClass("Model").Name == "strawberry"
		if flag_2 then
			val8 = val8 + 1
		end
		growPart(v34Entry, v34Entry.Size, val8, flag_2)
	end
end

data.OnStart = function(_)

	local l_v10_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v10_ActiveEventData_0)
	ReplicatedStorage:SetAttribute("StrawberryEvent", true)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("StrawberryEvent", nil)
	end)
	EffectController:Activate("Blink")
	EffectController:Run("StrawberryEvent", "GrassRecolor")
	managedObj:Add(function()

		EffectController:Stop("StrawberryEvent", "GrassRecolor")
		EffectController:Activate("Blink")
	end)
	local Atmosphere = Lighting:FindFirstChild("Atmosphere")
	if Atmosphere then
		Atmosphere.Parent = script
		managedObj:Add(function()

			Atmosphere.Parent = Lighting
		end)
	end
	managedObj:Clone(script.Atmosphere).Parent = Lighting
	local ref1 = Lighting:FindFirstChildOfClass("Sky")
	if ref1 then
		ref1.Parent = script
		managedObj:Add(function()

			ref1.Parent = Lighting
		end)
	end
	managedObj:Clone(script.Sky).Parent = Lighting
	local ref6 = managedObj:Clone(script.StrawberryVFX)
	ref6.Parent = workspace
	VFX.enable(ref6)
	local getChildrenObj = managedObj:Clone(script.Bushes)

	local function _(val9)

		return l_v10_ActiveEventData_0.startedAt + val9 - workspace:GetServerTimeNow()
	end
	local nextNumberObj = Random.new()
	for _, child in getChildrenObj:GetChildren() do
		growBush(child, nextNumberObj:NextNumber(5, 7), function(val10)

			return l_v10_ActiveEventData_0.startedAt + val10 - workspace:GetServerTimeNow()
		end)
	end
	getChildrenObj.Parent = workspace
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	onClientEventObj.OnClientEvent:Connect(function(val11)

		ClientEventUtils.playBurst(script.Burst, val11, {
			ReplicatedStorage.Sounds.Events.Strawberry.BrainrotHit
		})
	end)
end

return data
