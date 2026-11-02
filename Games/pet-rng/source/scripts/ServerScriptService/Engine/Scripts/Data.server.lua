--made by caelm and fruskle
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEnigne = ReplicatedStorage.Engine
local DataManager = script.DataManager
local ChangeData = require(DataManager.ChangeData)

local RemoteFunctions = RSEnigne.RemotesFunctions
local RemoteEvents = RSEnigne.RemotesEvents
local ChangeValue = RemoteEvents.ChangeValue
local ChangeNotDataValue = RemoteEvents.ChangeNotDataValue
local GetValue = RemoteFunctions.GetValue

local profiles = require(DataManager)

DataManager = require(script:WaitForChild("DataManager"))

ChangeValue.OnServerEvent:Connect(function(...) -- passes player, value to change, new value, optional value instance path
	ChangeData.ChangeValue(...)
end)

ChangeNotDataValue.OnServerEvent:Connect(function(...) -- passes player, value to change, new value, optional value instance path
	ChangeData.ChangeNotDataValue(...)
end)

GetValue.OnServerInvoke = function(plr, path)
	repeat wait() until DataManager.profiles[plr]
	return DataManager.profiles[plr].Data[path]
end