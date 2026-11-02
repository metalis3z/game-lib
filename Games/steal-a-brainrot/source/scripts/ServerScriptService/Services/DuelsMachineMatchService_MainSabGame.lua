--!native


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local ReplicatorServer = require(ReplicatedStorage.Packages.ReplicatorServer)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ServerData = require(ReplicatedStorage.Datas.ServerData)

local SelectBrainrotSelect = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Select")
local SelectBrainrotReady = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Ready")
local SelectBrainrotAccept = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Accept")
local SelectBrainrotCancel = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Cancel")
local SelectBrainrotAnimation = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Animation")
local SelectBrainrotWinnerScreen = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/WinnerScreen")
local SetDevice = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/SetDevice")

local DuelsRounds = ReplicatorServer.new("DuelsRounds")
local SelectBrainrots = ReplicatorServer.new("SelectBrainrots")

local SELECTION_TIME = 30
local READY_TIME = 5
local ROUND_DURATION = 180
local ROUNDS_TO_WIN = 2
local COUNTDOWN_DURATION = 3

local CurrentMatch = nil
local PlayerDevices = {}
local SelectionPhase = {
	active = false,
	startTime = 0,
	players = {},
	lastChange = 0
}

local DuelsMachineMatchService = {}

local function initializeMatch(player1, player2)
	CurrentMatch = {
		player1 = player1.UserId,
		player2 = player2.UserId,
		roundWins = {
			[tostring(player1.UserId)] = 0,
			[tostring(player2.UserId)] = 0
		},
		currentRound = 0,
		roundTimer = ROUND_DURATION,
		expectedPlayers = {player1.UserId, player2.UserId}
	}
	
	DuelsRounds:SetData(CurrentMatch)
	workspace:SetAttribute("DuelsMatchActive", true)
end

local function startSelectionPhase()
	if not CurrentMatch then return end
	
	SelectionPhase.active = true
	SelectionPhase.startTime = workspace:GetServerTimeNow()
	SelectionPhase.lastChange = workspace:GetServerTimeNow()
	SelectionPhase.players = {}
	
	for _, userId in ipairs(CurrentMatch.expectedPlayers) do
		SelectionPhase.players[tostring(userId)] = {
			indexOnPlot = nil,
			brainrot = nil,
			ready = false,
			accepted = false
		}
	end
	
	SelectBrainrots:SetData({
		players = SelectionPhase.players,
		lastChange = SelectionPhase.lastChange
	})
	
	workspace:SetAttribute("DuelsSelectBrainrotActive", true)
	
	task.delay(SELECTION_TIME, function()
		if SelectionPhase.active then
			for userId, data in pairs(SelectionPhase.players) do
				if not data.ready and data.brainrot then
					data.ready = true
				end
			end
			
			SelectBrainrots:SetData({
				players = SelectionPhase.players,
				lastChange = workspace:GetServerTimeNow()
			})
		end
	end)
end

local function endSelectionPhase()
	SelectionPhase.active = false
	workspace:SetAttribute("DuelsSelectBrainrotActive", false)
	SelectBrainrots:SetData(nil)
end

local function checkAllPlayersReady()
	if not SelectionPhase.active then return false end
	
	for _, data in pairs(SelectionPhase.players) do
		if not data.ready or not data.brainrot then
			return false
		end
	end
	
	return true
end

local function checkAllPlayersAccepted()
	if not SelectionPhase.active then return false end
	
	for _, data in pairs(SelectionPhase.players) do
		if not data.accepted then
			return false
		end
	end
	
	return true
end

local function startCountdown()
	for _, userId in ipairs(CurrentMatch.expectedPlayers) do
		local player = Players:GetPlayerByUserId(userId)
		if player then
			SelectBrainrotAnimation:FireClient(player, COUNTDOWN_DURATION)
		end
	end
	
	task.wait(COUNTDOWN_DURATION)
end

local function startRound()
	if not CurrentMatch then return end
	
	CurrentMatch.currentRound = CurrentMatch.currentRound + 1
	CurrentMatch.roundTimer = ROUND_DURATION
	
	task.spawn(function()
		while CurrentMatch and CurrentMatch.roundTimer > 0 do
			task.wait(1)
			if CurrentMatch then
				CurrentMatch.roundTimer = CurrentMatch.roundTimer - 1
				DuelsRounds:SetData(CurrentMatch)
			end
		end
		
		if CurrentMatch then
			DuelsMachineMatchService.EndRound(nil)
		end
	end)
	
	DuelsRounds:SetData(CurrentMatch)
end

function DuelsMachineMatchService.EndRound(winnerId)
	if not CurrentMatch then return end
	
	if winnerId then
		local winnerKey = tostring(winnerId)
		CurrentMatch.roundWins[winnerKey] = (CurrentMatch.roundWins[winnerKey] or 0) + 1
		
		if CurrentMatch.roundWins[winnerKey] >= ROUNDS_TO_WIN then
			DuelsMachineMatchService.EndMatch(winnerId)
			return
		end
	end
	
	task.wait(3)
	startSelectionPhase()
end

function DuelsMachineMatchService.EndMatch(winnerId)
	if not CurrentMatch then return end
	
	for _, userId in ipairs(CurrentMatch.expectedPlayers) do
		local player = Players:GetPlayerByUserId(userId)
		if player then
			SelectBrainrotWinnerScreen:FireClient(player, winnerId)
		end
	end
	
	task.wait(10)
	workspace:SetAttribute("DuelsMatchActive", false)
	CurrentMatch = nil
	DuelsRounds:SetData(nil)
end

SelectBrainrotSelect.OnServerEvent:Connect(function(player, indexOnPlot, brainrotData)
	if not SelectionPhase.active then return end
	if not CurrentMatch then return end
	
	local userId = tostring(player.UserId)
	local playerData = SelectionPhase.players[userId]
	
	if not playerData then return end
	
	local syncData = Synchronizer:Wait(player)
	if not syncData then return end
	
	local animalPodiums = syncData:Get("AnimalPodiums")
	if not animalPodiums then return end
	
	local actualBrainrot = animalPodiums[indexOnPlot]
	
	if not actualBrainrot or actualBrainrot.UUID ~= brainrotData.UUID then
		return
	end
	
	playerData.indexOnPlot = indexOnPlot
	playerData.brainrot = brainrotData
	playerData.ready = false
	playerData.accepted = false
	
	SelectionPhase.lastChange = workspace:GetServerTimeNow()
	
	SelectBrainrots:SetData({
		players = SelectionPhase.players,
		lastChange = SelectionPhase.lastChange
	})
end)

SelectBrainrotReady.OnServerEvent:Connect(function(player)
	if not SelectionPhase.active then return end
	if not CurrentMatch then return end
	
	local userId = tostring(player.UserId)
	local playerData = SelectionPhase.players[userId]
	
	if not playerData or not playerData.brainrot then return end
	
	playerData.ready = true
	playerData.accepted = false
	
	SelectBrainrots:SetData({
		players = SelectionPhase.players,
		lastChange = SelectionPhase.lastChange
	})
	
	if checkAllPlayersReady() then
		SelectionPhase.lastChange = workspace:GetServerTimeNow()
		
		SelectBrainrots:SetData({
			players = SelectionPhase.players,
			lastChange = SelectionPhase.lastChange
		})
		
		task.delay(READY_TIME, function()
			if SelectionPhase.active and checkAllPlayersReady() then
				for _, data in pairs(SelectionPhase.players) do
					data.accepted = true
				end
				
				SelectBrainrots:SetData({
					players = SelectionPhase.players,
					lastChange = SelectionPhase.lastChange
				})
				
				endSelectionPhase()
				startCountdown()
				startRound()
			end
		end)
	end
end)

SelectBrainrotAccept.OnServerEvent:Connect(function(player)
	if not SelectionPhase.active then return end
	if not CurrentMatch then return end
	if not checkAllPlayersReady() then return end
	
	local userId = tostring(player.UserId)
	local playerData = SelectionPhase.players[userId]
	
	if not playerData or not playerData.ready then return end
	
	playerData.accepted = true
	
	SelectBrainrots:SetData({
		players = SelectionPhase.players,
		lastChange = SelectionPhase.lastChange
	})
	
	if checkAllPlayersAccepted() then
		endSelectionPhase()
		startCountdown()
		startRound()
	end
end)

SelectBrainrotCancel.OnServerEvent:Connect(function(player)
	if not SelectionPhase.active then return end
	if not CurrentMatch then return end
	
	local userId = tostring(player.UserId)
	local playerData = SelectionPhase.players[userId]
	
	if not playerData then return end
	
	playerData.ready = false
	playerData.accepted = false
	
	SelectBrainrots:SetData({
		players = SelectionPhase.players,
		lastChange = SelectionPhase.lastChange
	})
end)

SetDevice.OnServerEvent:Connect(function(player, deviceType)
	if deviceType == "PC" or deviceType == "Console" or deviceType == "Mobile" then
		PlayerDevices[player.UserId] = deviceType
		player:SetAttribute("Device", deviceType)
	end
end)

Players.PlayerAdded:Connect(function(player)
	if CurrentMatch then
		local isParticipant = false
		for _, userId in ipairs(CurrentMatch.expectedPlayers) do
			if userId == player.UserId then
				isParticipant = true
				break
			end
		end
		
		if not isParticipant and ServerData.IsDuelsServer and ServerData.IsDuelsServer() then
			player:Kick("This is a private duel server")
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if not CurrentMatch then return end
	
	for _, userId in ipairs(CurrentMatch.expectedPlayers) do
		if userId == player.UserId then
			local opponentId
			if CurrentMatch.player1 == player.UserId then
				opponentId = CurrentMatch.player2
			else
				opponentId = CurrentMatch.player1
			end
			
			DuelsMachineMatchService.EndMatch(opponentId)
			break
		end
	end
	
	PlayerDevices[player.UserId] = nil
end)

function DuelsMachineMatchService.StartMatch(player1, player2)
	if ServerData.IsDuelsServer and not ServerData.IsDuelsServer() then
		return false
	end
	
	if CurrentMatch then
		return false
	end
	
	initializeMatch(player1, player2)
	task.wait(2)
	startSelectionPhase()
	
	return true
end

function DuelsMachineMatchService.GetCurrentMatch()
	return CurrentMatch
end

function DuelsMachineMatchService.IsMatchActive()
	return CurrentMatch ~= nil
end

task.spawn(function()
	ReplicatorServer.init()
end)

return DuelsMachineMatchService