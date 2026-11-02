--!strict

local LikeService = {}
local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local GameData = require(ReplicatedStorage.Datas.Game)

local LikeBoard = workspace.Map.Codes.Main.SurfaceGui.MainFrame.ProgressBar.Bar
local CurrentMilestoneIndex = 1
local HasInitialized = false

local function FormatNumber(n: number): string
	local s = tostring(n)
	local result = s
	while true do
		local k
		result, k = string.gsub(result, "^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then
			break
		end
	end
	return result
end

function LikeService.Get()
	local Success, Response = pcall(function()
		local RawResponse = HttpService:GetAsync("https://games.roproxy.com/v1/games/".. game.GameId .."/votes")
		return HttpService:JSONDecode(RawResponse)
	end)

	if Success and Response and typeof(Response) == "table" and Response.upVotes then
		local CurrentLikes = Response.upVotes

		if not HasInitialized then
			for i, Milestone in pairs(GameData.Milestones) do
				if CurrentLikes < Milestone.RequiredLikes then
					CurrentMilestoneIndex = i
					break
				end
			end
			if CurrentLikes >= GameData.Milestones[#GameData.Milestones].RequiredLikes then
				CurrentMilestoneIndex = #GameData.Milestones + 1
			end
			HasInitialized = true
		end

		local CurrentMilestone = GameData.Milestones[CurrentMilestoneIndex]
		while CurrentMilestone and CurrentLikes >= CurrentMilestone.RequiredLikes do
			if CurrentMilestone.RewardType == "Animal" then
				AnimalService.randomAnimal(CurrentMilestone.RewardText)
			end
			CurrentMilestoneIndex += 1
			CurrentMilestone = GameData.Milestones[CurrentMilestoneIndex]
		end

		if CurrentMilestone then
			local PreviousMilestone = CurrentMilestoneIndex == 1 and {RequiredLikes = 0} or GameData.Milestones[CurrentMilestoneIndex - 1]
			local ProgressInSegment = CurrentLikes - PreviousMilestone.RequiredLikes
			local SegmentSize = CurrentMilestone.RequiredLikes - PreviousMilestone.RequiredLikes
			local ProgressScale = math.clamp(ProgressInSegment / SegmentSize, 0, 1)

			LikeBoard.ProgressText.Text = string.format("%s / %s", FormatNumber(CurrentLikes), FormatNumber(CurrentMilestone.RequiredLikes))
			LikeBoard.Parent.Parent.Message.RequiredLikes.Text = string.format("%s LIKES!", FormatNumber(CurrentMilestone.RequiredLikes))
			LikeBoard.Progress.Size = UDim2.new(ProgressScale, 0, 1, 0)
		else
			local LastMilestone = GameData.Milestones[#GameData.Milestones]
			LikeBoard.ProgressText.Text = string.format("%s / %s", FormatNumber(CurrentLikes), FormatNumber(LastMilestone.RequiredLikes))
			LikeBoard.Parent.Parent.Message.RequiredLikes.Text = string.format("%s LIKES!", FormatNumber(LastMilestone.RequiredLikes))
			LikeBoard.Progress.Size = UDim2.new(1, 0, 1, 0)
		end
	end
end

function LikeService:Start()
	if game.PrivateServerId ~= "" then
		LikeBoard.Parent.Parent.Message.Visible = false
		LikeBoard.Parent.Parent.ProgressBar.Visible = false
		LikeBoard.Parent.Parent.PrivateServerMessage.Visible = true
		return
	end

	LikeService.Get()
	while true do
		task.wait(60)
		LikeService.Get()
	end
end

return LikeService
