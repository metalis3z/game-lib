--[[
	@Author: @42devy
	@CreationDate: 2026-04-21
	@Version: 1.8.2
	@License: MIT
	@Twitter: @42devy
	@Description: Handles vote pads and map selection for the lobby. This Script also handles the ability
	to use commands eg. "/map SnowballFight".
]]--
repeat task.wait() until workspace:FindFirstChild("Lobby")

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Database = require(game.ServerScriptService.Modules.MapModule)

local VoteConfigs = {
	VotePad1 = script:WaitForChild("VotePad1"),
	VotePad2 = script:WaitForChild("VotePad2"),
	VotePad3 = script:WaitForChild("VotePad3"),
}

local PlayersVotes = {
	VotePad1 = {},
	VotePad2 = {},
	VotePad3 = {},
}

local BoundPads = {}
local VotingSessionActive = false

local function RefreshCounts()
	for PadName, PlayersForPad in pairs(PlayersVotes) do
		VoteConfigs[PadName].Votes.Value = #PlayersForPad
	end
end

local function ClearTables()
	for PadName in pairs(PlayersVotes) do
		PlayersVotes[PadName] = {}
	end
end

local function AnyPadVoting()
	for _, Config in pairs(VoteConfigs) do
		if Config.Voting.Value then
			return true
		end
	end
	return false
end

local function StartVotingSession()
	if VotingSessionActive then
		return
	end

	VotingSessionActive = true
	ClearTables()
	RefreshCounts()
end

local function FinishVotingSessionIfDone()
	if not VotingSessionActive or AnyPadVoting() then
		return
	end

	VotingSessionActive = false
	ClearTables()
	RefreshCounts()
end

local function RemovePlayerVote(Player)
	for _, PlayersForPad in pairs(PlayersVotes) do
		for Index = #PlayersForPad, 1, -1 do
			if PlayersForPad[Index] == Player then
				table.remove(PlayersForPad, Index)
			end
		end
	end
	RefreshCounts()
end

local function GetMapImage(Map)
	local Icon = Map:FindFirstChild("IconSq")
	if Icon and Icon:IsA("Decal") then
		return Icon.Texture
	end

	local MapInfo = Database[Map.Name]
	return MapInfo and MapInfo.MapImage or ""
end

local function UpdateMapDisplay(PadModel, PadName)
	local Map = VoteConfigs[PadName].Map.Value
	if not Map then
		return
	end

	local MapInfo = Database[Map.Name]
	PadModel.VoteInfoGui.Container.MapName.Text = MapInfo and MapInfo.MapName or Map.Name
	PadModel.MapInfoGui.MapIcon.Image = GetMapImage(Map)
end

local function UpdateVotingDisplay(PadModel, PadName)
	local IsVoting = VoteConfigs[PadName].Voting.Value
	PadModel.MapInfoGui.Enabled = IsVoting
	PadModel.VoteInfoGui.Enabled = IsVoting
	PadModel.VoteInfoGui.Container.Votes.Text = "Votes: " .. VoteConfigs[PadName].Votes.Value

	if IsVoting then
		StartVotingSession()
	else
		FinishVotingSessionIfDone()
	end
end

local function BindPad(PadModel)
	if not PadModel:IsA("Model") or not PadModel:IsDescendantOf(workspace) then
		return
	end

	local PadName = PadModel.Name
	local Config = VoteConfigs[PadName]
	if not Config or BoundPads[PadModel] then
		return
	end

	BoundPads[PadModel] = true

	Config.Votes.Changed:Connect(function()
		PadModel.VoteInfoGui.Container.Votes.Text = "Votes: " .. Config.Votes.Value
	end)

	Config.Map.Changed:Connect(function()
		UpdateMapDisplay(PadModel, PadName)
	end)

	Config.Voting.Changed:Connect(function()
		UpdateVotingDisplay(PadModel, PadName)
	end)

	PadModel.Pad.Touched:Connect(function(Hit)
		if not Config.Voting.Value then
			return
		end

		local Character = Hit.Parent
		local Player = Players:GetPlayerFromCharacter(Character)
		if not Player then
			return
		end

		for _, ExistingPlayer in ipairs(PlayersVotes[PadName]) do
			if ExistingPlayer == Player then
				return
			end
		end

		RemovePlayerVote(Player)
		table.insert(PlayersVotes[PadName], Player)
		RefreshCounts()
	end)

	UpdateMapDisplay(PadModel, PadName)
	UpdateVotingDisplay(PadModel, PadName)
end

local function BindCurrentPads()
	local Lobby = workspace:FindFirstChild("Lobby")
	local VotePadsFolder = Lobby and Lobby:FindFirstChild("VotePads")
	if VotePadsFolder then
		for _, PadModel in ipairs(VotePadsFolder:GetChildren()) do
			BindPad(PadModel)
		end
	end

	for _, PadModel in ipairs(CollectionService:GetTagged("VotePad")) do
		BindPad(PadModel)
	end
end

BindCurrentPads()
CollectionService:GetInstanceAddedSignal("VotePad"):Connect(BindPad)
Players.PlayerRemoving:Connect(RemovePlayerVote)
