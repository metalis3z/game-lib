--[[
     Made by arxx pls nooo
]]

local _Players = game:GetService("Players")
local _Datastore = game:GetService('DataStoreService')
local _MyData = _Datastore:GetDataStore("DataBase")
local _BoothData = require(script.Parent.Parent:FindFirstChild("Services").Booth)

_Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"
	
	local Raised = Instance.new("IntValue", leaderstats)
	Raised.Name = "Raised"
	
	local Donated = Instance.new("IntValue", leaderstats)
	Donated.Name = "Donated"
	
	local Bux = Instance.new("IntValue", player)
	Bux.Name = "Cashbux"
	
	player:SetAttribute("Claimed", false)
	player:SetAttribute("OwnedBooth", "None")
	
	local RaisedData = nil
	local DonatedData = nil
	local CashBux = nil
	local success, responce = pcall(function()
		RaisedData = _MyData:GetAsync(player.UserId .. "-Raised")
		DonatedData = _MyData:GetAsync(player.UserId .. "-Donated")
		CashBux = _MyData:GetAsync(player.UserId .. "-CashBux")
	end)
	if success then
		Raised.Value = RaisedData
		Donated.Value = DonatedData
		Bux.Value = CashBux
	else
		warn(responce)
	end
end)

_Players.PlayerRemoving:Connect(function(player)
	local slot = player:GetAttribute("OwnedBooth")
	local Raised = player:FindFirstChild("leaderstats").Raised.Value
	local Donated = player:FindFirstChild("leaderstats").Donated.Value
	local CashBux = player.Cashbux.Value
	
	local success, responce = pcall(function()
		_MyData:SetAsync(player.UserId .. "-Raised", Raised)
		_MyData:SetAsync(player.UserId .. "-Donated", Donated)
		_MyData:SetAsync(player.UserId .. "-CashBux", CashBux)
		if slot then
			local booth = _BoothData:GetBooth(slot)
			local interaction = _BoothData:GetInteraction(slot)
			_BoothData:ResetBooth(player, slot, booth, interaction)
		end
	end)
	
	if responce then
		warn(responce)
	end
end)

game.ReplicatedStorage.TpToBooth.OnServerEvent:Connect(function(player, booth)
	player.Character.HumanoidRootPart:PivotTo(booth:GetPivot() + Vector3.new(0, 10, 0))
end)