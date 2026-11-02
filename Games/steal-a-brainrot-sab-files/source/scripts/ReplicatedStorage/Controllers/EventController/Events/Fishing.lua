
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Lighting")

local Players = game:GetService("Players")

game:GetService("Debris")
require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}

require(ReplicatedStorage.Controllers.EncryptedAssetsController)

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)

require(ReplicatedStorage.Controllers.AnimalController)

local EffectController = require(ReplicatedStorage.Controllers.EffectController)

require(ReplicatedStorage.Controllers.CameraController)

local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)

require(ReplicatedStorage.Shared.SharedEventUtils)
require(ReplicatedStorage.Packages.CreateTween)

local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Mutations2 = require(ReplicatedStorage.Shared.Mutations)

require(ReplicatedStorage.Utils.MathUtils)
require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage.Packages.Spring)

local Trove = require(ReplicatedStorage.Packages.Trove)

require(ReplicatedStorage.Packages.Shake)
require(ReplicatedStorage.Packages.Net)

local Spr = require(ReplicatedStorage.Packages.Spr)

require(ReplicatedStorage.Shared.VFX)

local _ = Players.LocalPlayer
local _ = workspace.CurrentCamera
local scriptName = script.Name
local v20 = Trove.new()

local function loadAnimation(p1, p2, p3)
	local track = p1:LoadAnimation(p2);

	(p3 or v20):Add(function()
		track:Stop(0)
		track:Destroy()
	end)

	return track
end

function t1.OnStart(_)
	local ActiveEventData = EventController:GetActiveEventData(scriptName)

	assert(ActiveEventData)

	local function calculateTimeLeft(n1: number)
		return (math.max(ActiveEventData.startedAt + n1 - workspace:GetServerTimeNow(), 0))
	end

	v20:Add(function()
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)

	local v29 = if not ServerData.IsTsunamiServer() then if not ServerData.IsBiggerServer() then v20:Clone(script.FishingMap) else v20:Clone(script.FishingMapBigger) else v20:Clone(script.FishingMapTsunami)

	v29.Parent = workspace
	EffectController:Activate("Blink")
	CycleController:Update()
	SoundController:UpdateOST()

	local Pivot = v29.Flood:GetPivot()

	v29.Flood:PivotTo(Pivot - Vector3.new(0, 3, 0))
	v20:Add(TweenPivot(v29.Flood, TweenInfo.new(ActiveEventData.startedAt + 3 - workspace:GetServerTimeNow(), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), Pivot)):Play()
	v20:Add(Observers.observeTag("FishermanPrompt", function(p5)
		local connection = p5.Triggered:Connect(function()
			InterfaceController:Toggle("RodsShop")
		end)

		return function()
			connection:Disconnect()
		end
	end))

	local function darken(color3: Color3, n2: number)
		local v40 = math.clamp(n2, 0, 1)
		local v41, v42, v43 = color3:ToHSV()
		local v44 = v43 * v40

		return Color3.fromHSV(v41, v42, v44)
	end
	local function updateFloodColor()
		local v45 = Mutations2.get()

		if v45 then
			local v46 = Mutations[v45]

			Spr.target(v29.Flood.TopWater["Water.001"], 1, 4, {
				Color = v46.MainColor
			})

			local target = Spr.target
			local v48 = v29.Flood.Water["Water.001"]
			local t2 = {}
			local MainColor = v46.MainColor
			local v51 = math.clamp(0.5, 0, 1)
			local v52, v53, v54 = MainColor:ToHSV()
			local v55 = v54 * v51

			t2.Color = Color3.fromHSV(v52, v53, v55)
			target(v48, 1, 4, t2)

			return
		end

		Spr.target(v29.Flood.TopWater["Water.001"], 1, 4, {
			Color = Color3.fromRGB(73, 161, 255)
		})
		Spr.target(v29.Flood.Water["Water.001"], 1, 4, {
			Color = Color3.fromRGB(0, 103, 172)
		})
	end

	v20:Add(Mutations2.watch(updateFloodColor))
	updateFloodColor()
end
function t1.OnStop(_)
	v20:Destroy()
end
function t1.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
end

return t1
