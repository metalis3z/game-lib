--==>>| Made By The Crooked Man |<<==--

--=====================>>| Services |<<=====================--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--==========================================================--

--====================================>>| Requires |<<====================================--
local mutationData = require(ReplicatedStorage.Datas.Mutations)
local traitData = require(ReplicatedStorage.Datas.Traits)
local animalData = require(ReplicatedStorage.Datas.Animals)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
--========================================================================================--

--============================>>| Remotes |<<============================--
local GlobalSpawnBrainrotRemote = Net:RemoteFunction("GlobalSpawnBrainrot")
local ServerSpawnBrainrotRemote = Net:RemoteFunction("ServerSpawnBrainrot")
--=======================================================================--

--===============>>| Frame |<<===============--
local SpawnBrainrot = script.Parent.Spawn.Frame
--===========================================--

--=================>>| Labels |<<=================--
local mainMutationLabel = SpawnBrainrot.mainMutation
local mainTraitLabel = SpawnBrainrot.mainTrait
local mainNameLabel = SpawnBrainrot.mainName
local mainSpeedLabel = SpawnBrainrot.mainSpeed
--================================================--

--==========================================================================>>| Button |<<==========================================================================--
local GlobalSpawn = AnimatedButton.new(SpawnBrainrot.GlobalSpawn)
GlobalSpawn:Animate()
GlobalSpawn.OnActivated:Connect(function()
	local success, message = GlobalSpawnBrainrotRemote:InvokeServer(mainNameLabel.Text, mainMutationLabel.Text, mainTraitLabel.Text, (tonumber(mainSpeedLabel.Text)));
	if not success then
		NotificationController:Error(message);
	end;
end);
local ServerSpawn = AnimatedButton.new(SpawnBrainrot.ServerSpawn)
ServerSpawn:Animate()
ServerSpawn.OnActivated:Connect(function()
	local success, message = ServerSpawnBrainrotRemote:InvokeServer(mainNameLabel.Text, mainMutationLabel.Text, mainTraitLabel.Text, (tonumber(mainSpeedLabel.Text)));
	if not success then
		NotificationController:Error(message);
	end;
end);
--==================================================================================================================================================================--

--================>>| Unchanged,  Unsure If This Is Used |<<================--
local mutationList = {}
for v29, v30 in pairs(mutationData) do
	mutationList[v29] = v30
	mutationList[v29].DisplayName = v29
	mutationList[v29].Color = v30.MainColor
end
local traitList = {
	[" All"] = {
		["DisplayName"] = " All",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">All</font>",
		["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
		["Color"] = Color3.fromRGB(85, 170, 0),
		["MultiplierModifier"] = 1
	}
}
for v32, v33 in pairs(traitData) do
	traitList[v32] = v33
	traitList[v32].DisplayName = v32
end
local nameList = {}
for _, v35 in pairs(animalData) do
	table.insert(nameList, v35)
end
table.sort(nameList, function(a, b)
	local v38 = a.Rarity
	local v39 = b.Rarity
	local v40 = raritiesData[v38].Weight
	local v41 = raritiesData[v39].Weight
	if v40 == v41 then
		return a.DisplayName < b.DisplayName
	else
		return v40 < v41
	end
end)
SpawnBrainrot.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		mainNameLabel.Text = selectedName
	end)
end)
SpawnBrainrot.traittext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(traitList, function(selectedTrait)
		mainTraitLabel.Text = selectedTrait
	end, "multiple", mainTraitLabel.Text)
end)
SpawnBrainrot.mutationtext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(mutationList, function(selectedMutation)
		mainMutationLabel.Text = selectedMutation
	end)
end)
--==========================================================================--

