local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Lighting")
local Players = game:GetService("Players")
game:GetService("Debris")
require(ReplicatedStorage.Shared.EventTypes)
local Module = {}
require(ReplicatedStorage.Controllers.EncryptedAssetsController)
require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
require(ReplicatedStorage.Controllers.CameraController)
require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Controllers.EventController)
require(ReplicatedStorage.Controllers.CycleController)
require(ReplicatedStorage.Shared.SharedEventUtils)
require(ReplicatedStorage.Packages.CreateTween)
require(ReplicatedStorage.Shared.TweenPivot)
local Observers = require(ReplicatedStorage.Packages.Observers)
require(ReplicatedStorage.Utils.MathUtils)
require(ReplicatedStorage.Shared.Animals)
require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage.Packages.Trove)
require(ReplicatedStorage.Packages.Shake)
require(ReplicatedStorage.Packages.Timer)
require(ReplicatedStorage.Packages.Spr)
require(ReplicatedStorage.Packages.Net)
require(ReplicatedStorage.Shared.VFX)
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local ScriptName = script.Name
function Module.OnStart(_) end
function Module.OnStop(_) end
function Module.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	local hideIn3RoadsObserver = nil
	local showIn3RoadsObserver = nil
	local function OnAttributeChanged(isInitial)
		if ReplicatedStorage:GetAttribute("3RoadsEvent") then
			if not isInitial then
				EffectController:Activate("Blink")
			end
			if hideIn3RoadsObserver then
				hideIn3RoadsObserver()
				hideIn3RoadsObserver = nil
			end
			if not showIn3RoadsObserver then
				showIn3RoadsObserver = Observers.observeTag("HideIn3Roads", function(instance)
					local originalParent = instance.Parent
					instance.Parent = script
					return function()
						pcall(function()
							instance.Parent = originalParent
						end)
					end
				end, { workspace, script })
				return
			end
		else
			if not isInitial then
				EffectController:Activate("Blink")
			end
			if not hideIn3RoadsObserver then
				hideIn3RoadsObserver = Observers.observeTag("ShowIn3Roads", function(instance)
					local originalParent = instance.Parent
					local isDestroyed = false
					local destroyingConnection = originalParent.Destroying:Once(function()
						isDestroyed = true
						instance:Destroy()
					end)
					instance.Parent = script
					return function()
						destroyingConnection:Disconnect()
						if not isDestroyed then
							pcall(function()
								instance.Parent = originalParent
							end)
						end
					end
				end, { workspace, script })
			end
			if showIn3RoadsObserver then
				showIn3RoadsObserver()
				showIn3RoadsObserver = nil
			end
		end
	end
	ReplicatedStorage:GetAttributeChangedSignal("3RoadsEvent"):Connect(OnAttributeChanged)
	task.spawn(OnAttributeChanged, true)
end
return Module