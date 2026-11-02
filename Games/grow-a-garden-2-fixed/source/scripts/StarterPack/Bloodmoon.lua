--credit to prince games studio
local t = {}
local Players = game:GetService("Players")

game:GetService("ServerStorage")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.SharedModules.Networking)

local WeatherValues = ReplicatedStorage:WaitForChild("WeatherValues")

game:GetService("TweenService")
require(ReplicatedStorage.ClientModules.Trove)

local v1 = false
local v2 = 70
local v3 = 0
local Bloodmoon = Instance.new("Folder")

Bloodmoon.Name = "Bloodmoon"
Bloodmoon.Parent = WeatherValues

local Playing = Instance.new("BoolValue")

Playing.Name = "Playing"
Playing.Value = false
Playing.Parent = Bloodmoon

local EndTime = Instance.new("NumberValue")

EndTime.Name = "EndTime"
EndTime.Value = 0
EndTime.Parent = Bloodmoon

local function GetAnimationSpeedFromBass(p1) --[[ GetAnimationSpeedFromBass | Line: 55 ]]
	if p1 < 0.02 then
		return 1
	end

	return 1 + math.clamp((p1 - 0.02) / 0.030000000000000002, 0, 1) * 2
end

local function GetCombinedIntensity() --[[ GetCombinedIntensity | Line: 63 | Upvalues: v3 (ref) ]]
	return math.clamp((if v3 > 0.033 then math.clamp((v3 - 0.033) / 0.017, 0, 1) * 0.5 else 0) + 0, 0, 1)
end

local function MonitorBassAndFOV() --[[ MonitorBassAndFOV | Line: 74 | Upvalues: Players (copy), v2 (ref) ]]
	local LocalPlayer = Players.LocalPlayer
	local CurrentCamera = workspace.CurrentCamera
	local FieldOfView = CurrentCamera.FieldOfView

	v2 = FieldOfView
	task.wait(1)
	CurrentCamera.FieldOfView = FieldOfView
end

function t.Start(p1) --[[ Start | Line: 149 | Upvalues: v1 (ref), EndTime (copy), Playing (copy), Players (copy) ]]
	if not v1 then
		v1 = true
		EndTime.Value = DateTime.now().UnixTimestamp + (p1 or 120)
		Playing.Value = true
		playerAddedConnection = Players.PlayerAdded:Connect(function(p1) --[[ Line: 161 | Upvalues: v1 (ref) ]]
			p1.CharacterAdded:Once(function() --[[ Line: 162 | Upvalues: v1 (ref) ]]
				if not v1 then
					return
				end

				task.wait(1)
			end)
		end)
		Players.PlayerRemoving:Connect(function(p1) --[[ Line: 169 ]]
			activeCarpets[p1] = nil
		end)
	end
end
function t.Stop() --[[ Stop | Line: 174 | Upvalues: v1 (ref), Playing (copy), EndTime (copy) ]]
	if not v1 then
		return
	end

	v1 = false

	if not playerAddedConnection then
		Playing.Value = false
		EndTime.Value = 0

		return
	end

	playerAddedConnection:Disconnect()
	playerAddedConnection = nil
	Playing.Value = false
	EndTime.Value = 0
end

return t