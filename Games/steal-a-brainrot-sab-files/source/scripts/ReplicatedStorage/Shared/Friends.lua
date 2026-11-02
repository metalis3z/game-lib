
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Signal = require(Packages.Signal)
local Debounce = require(Packages.Debounce)
local Promise = require(ReplicatedStorage.Packages.Promise)
local FriendMain = script:WaitForChild("FriendMain")
local t1 = {}
local t2 = {
	OnFriendsUpdate = Signal.new()
}

local function OnPlayerAdded(p1)
	t1[p1] = t1[p1] or {}

	local v18 = t1[p1]

	for _, v20 in Players:GetPlayers() do
		if v20 ~= p1 then
			local ok, result = pcall(function()
				return p1:IsFriendsWithAsync(v20.UserId)
			end)

			if ok and result then
				t1[v20] = t1[v20] or {}

				if not table.find(v18, v20) then
					table.insert(v18, v20)
				end

				if not table.find(t1[v20], p1) then
					table.insert(t1[v20], p1)
				end
			end
		end
	end
end
local function OnPlayerRemoving(p2)
	for v24, v25 in t1 do
		if v24 ~= p2 then
			local v26 = table.find(v25, p2)

			if v26 then
				table.remove(v25, v26)
			end
		end
	end

	t1[p2] = nil
end

function t2.GetFriendBoostPercentage(_: {[any]: any}, p3)
	if not p3 then
		return 0
	end

	return math.clamp(t2:GetAmountOfFriendsOnline(p3), 0, 3) * 10
end
function t2.GetFriendBoostModifier(_: {[any]: any}, p4)
	if not p4 then
		return 0
	end

	return math.clamp(t2:GetAmountOfFriendsOnline(p4), 0, 3) / 10
end
function t2.GetAmountOfFriendsOnline(_: {[any]: any}, p5)
	local v33 = t1[p5]

	return v33 and #v33 or 0
end

local t6 = {}
local t7 = {}

function t2.GetOnlineFriends(_: {[any]: any}, p6)
	if p6 == nil then
		assert(RunService:IsClient())
		p6 = Players.LocalPlayer
	end

	assert(p6)

	local UnixTimestamp = DateTime.now().UnixTimestamp

	if t6[p6] == nil or UnixTimestamp - (t7[p6] or 0) >= 600 or t6[p6]:getStatus() == Promise.Status.Rejected then
		t7[p6] = UnixTimestamp
		t6[p6] = Promise.try(function()
			return p6:GetFriendsOnlineAsync(200)
		end)
	end

	return t6[p6]:await()
end

local t9 = {}

function t2.GetFriendsAsync(_: {[any]: any}, p7)
	if p7 == nil then
		assert(RunService:IsClient())
		p7 = Players.LocalPlayer
	end

	assert(p7)

	local _ = DateTime.now().UnixTimestamp

	if t9[p7] == nil or t9[p7]:getStatus() == Promise.Status.Rejected then
		t9[p7] = Promise.new(function(p8, _, p10)
			local FriendsAsync = Players:GetFriendsAsync(p7.UserId)
			local t11 = {}

			while not p10() do
				local CurrentPage = FriendsAsync:GetCurrentPage()

				table.move(CurrentPage, 1, #CurrentPage, #t11 + 1, t11)

				if FriendsAsync.IsFinished or not pcall(function()
						FriendsAsync:AdvanceToNextPageAsync()
					end) then
					break
				end
			end

			p8(t11)
		end)
	end

	return t9[p7]:await()
end

Players.PlayerRemoving:Connect(function(player)
	if t6[player] then
		t6[player]:cancel()
		t6[player] = nil
	end

	if t9[player] then
		t9[player]:cancel()
		t9[player] = nil
	end

	t7[player] = nil
end)

function t2.HasFriendInGameAsync(_: {[any]: any}, p11)
	for _, v46 in Players:GetPlayers() do
		if v46 == p11 then
			continue
		end

		local ok, result = pcall(function()
			return p11:IsFriendsWithAsync(v46.UserId)
		end)

		if ok and result then
			return true
		end
	end

	return false
end
function t2.GetInGameFriends(_: {[any]: any}, p12)
	return t1[p12] or {}
end
function t2.Start(_)
	if RunService:IsServer() then
		FriendMain.OnServerEvent:Connect(function(player, b1: boolean?, p14)
			if Debounce(`Friends/Check/{ player.Name }`, 0.1) then
				return
			end

			if b1 == true then
				if not p14 or typeof(p14) ~= "Instance" or not p14:IsDescendantOf(Players) or p14 == player then
					return
				end

				local v66 = t1[player]

				if not v66 then
					return
				end

				local v67 = t1[p14]

				if not v67 then
					return
				end

				if not player:IsFriendsWithAsync(p14.UserId) then
					return
				end

				if not table.find(v66, p14) then
					table.insert(v66, p14)
				end

				if not table.find(v67, player) then
					table.insert(v67, player)
				end

				FriendMain:FireClient(player, v66)
				FriendMain:FireClient(p14, v67)

				return
			end

			FriendMain:FireClient(player, t1[player] or {})
		end)
		Players.PlayerAdded:Connect(OnPlayerAdded)
		Players.PlayerRemoving:Connect(OnPlayerRemoving)

		for _, v53 in Players:GetPlayers() do
			task.spawn(OnPlayerAdded, v53)
		end

		return
	end

	local LocalPlayer = Players.LocalPlayer

	FriendMain.OnClientEvent:Connect(function(p15)
		t1[LocalPlayer] = p15
		t2.OnFriendsUpdate:Fire()
	end)

	while true do
		local ok, _ = pcall(function()
			return StarterGui:GetCore("PlayerFriendedEvent").Event:Connect(function(p16)
				FriendMain:FireServer(true, p16)
			end)
		end)

		if ok then
			break
		end

		task.wait(0.1)
	end

	FriendMain:FireServer()
	task.spawn(function()
		while task.wait(15) do
			FriendMain:FireServer()
		end
	end)
end

t2:Start()

return t2
