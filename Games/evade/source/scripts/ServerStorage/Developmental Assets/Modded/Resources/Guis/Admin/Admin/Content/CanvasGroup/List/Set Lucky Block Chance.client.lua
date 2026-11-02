local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local animalData = require(ReplicatedStorage.Datas.Animals)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local SetLuckyBlockChanceRemote = Net:RemoteFunction("AdminService/SetLuckyBlockChance")
-- local SetLuckyBlockRemote = Net:RemoteEvent("AdminService/SetLuckyBlock") -- use if u want ig
local LuckyBlock = script.Parent.LuckyBlock.Frame
local mainNameLabel = LuckyBlock.mainName
local mainBrainrotLabel = LuckyBlock.mainBrainrot
local mainChanceLabel = LuckyBlock.mainChance
Net:RemoteEvent("AdminService/SetLuckyBlock").OnClientEvent:Connect(function(p13)
	warn(p13)
	local v14 = false
	for _, v15 in pairs(LuckyBlocks[p13.LuckyBlock].Animals) do
		if v15.Name == p13.Name then
			v15.Chance = p13.Chance
			v14 = true
		end
	end
	if not v14 then
		local v16 = LuckyBlocks[p13.LuckyBlock].Animals
		local v17 = {
			["Name"] = p13.Name,
			["Chance"] = p13.Chance
		}
		table.insert(v16, v17)
	end
end)
local SetButton = AnimatedButton.new(LuckyBlock.Set)
SetButton:Animate()
SetButton.OnActivated:Connect(function()
	local success, message = SetLuckyBlockChanceRemote:InvokeServer(mainNameLabel.Text, mainBrainrotLabel.Text, mainChanceLabel.Text)
	if not success then
		NotificationController:Error(message)
	end
end)
local RemoveButton = AnimatedButton.new(LuckyBlock.RemoveButton)
RemoveButton:Animate()
RemoveButton.OnActivated:Connect(function()
	local success, message = SetLuckyBlockChanceRemote:InvokeServer(script.Parent.LuckyBlock.Frame.mainName.Text, script.Parent.LuckyBlock.Frame.mainBrainrot.Text, nil, true)
	if not success then
		NotificationController:Error(message)
	end
end)
local luckyBlockList = {}
for _, v29 in pairs(animalData) do
	if v29.LuckyBlock then
		table.insert(luckyBlockList, v29)
	end
end
table.sort(luckyBlockList, function(a, b)
	local v32 = a.Rarity
	local v33 = b.Rarity
	local v34 = raritiesData[v32].Weight
	local v35 = raritiesData[v33].Weight
	if v34 == v35 then
		return a.DisplayName < b.DisplayName
	else
		return v34 < v35
	end
end)
script.Parent.LuckyBlock.Frame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(luckyBlockList, function(selectedLuckyBlock)
		script.Parent.LuckyBlock.Frame.mainName.Text = selectedLuckyBlock
	end)
end)
local animalList = {}
for _, v38 in pairs(animalData) do
	table.insert(animalList, v38)
end
table.sort(animalList, function(a, b)
	local v41 = a.Rarity
	local v42 = b.Rarity
	local v43 = raritiesData[v41].Weight
	local v44 = raritiesData[v42].Weight
	if v43 == v44 then
		return a.DisplayName < b.DisplayName
	else
		return v43 < v44
	end
end)
script.Parent.LuckyBlock.Frame.brainrottext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(animalList, function(selectedAnimal)
		script.Parent.LuckyBlock.Frame.mainBrainrot.Text = selectedAnimal
	end)
end)
