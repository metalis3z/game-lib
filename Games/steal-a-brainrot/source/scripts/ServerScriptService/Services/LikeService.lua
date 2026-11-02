local LikeService = {}

local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local GameData = require(ReplicatedStorage.Datas.Game)

local MainFrame = workspace.Map.Codes.Main.SurfaceGui.MainFrame
local LikeBoard = MainFrame.ProgressBar.Bar

local CurrentMilestoneIndex = 1
local HasInitialized = false
local LastLikes = 1

local MaxRetries = 5

local function FormatNumber(n: number): string
	local s = tostring(math.floor(n))
	return s:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local function FetchLikes()
	for _ = 1, MaxRetries do
		local success, response = pcall(function()
			return HttpService:GetAsync(
				"https://games.roproxy.com/v1/games/" .. game.GameId .. "/votes",
				true
			)
		end)

		if success then
			local ok, data = pcall(function()
				return HttpService:JSONDecode(response)
			end)

			if ok and data and typeof(data.upVotes) == "number" then
				return data.upVotes
			end
		end

		task.wait(2)
	end

	return nil
end

local function UpdateUI(CurrentLikes)
	local Milestones = GameData.Milestones
	local CurrentMilestone = Milestones[CurrentMilestoneIndex]

	if CurrentMilestone then
		local PreviousMilestone =
			CurrentMilestoneIndex == 1
			and { RequiredLikes = 0 }
			or Milestones[CurrentMilestoneIndex - 1]

		local ProgressInSegment = CurrentLikes - PreviousMilestone.RequiredLikes
		local SegmentSize = CurrentMilestone.RequiredLikes - PreviousMilestone.RequiredLikes
		local ProgressScale = math.clamp(ProgressInSegment / SegmentSize, 0, 1)

		LikeBoard.ProgressText.Text =
			FormatNumber(CurrentLikes) .. " / " .. FormatNumber(CurrentMilestone.RequiredLikes)

		MainFrame.Message.RequiredLikes.Text =
			FormatNumber(CurrentMilestone.RequiredLikes) .. " LIKES!"

		LikeBoard.Progress.Size = UDim2.new(ProgressScale, 0, 1, 0)
	else
		local LastMilestone = Milestones[#Milestones]

		LikeBoard.ProgressText.Text =
			FormatNumber(CurrentLikes) .. " / " .. FormatNumber(LastMilestone.RequiredLikes)

		MainFrame.Message.RequiredLikes.Text =
			FormatNumber(LastMilestone.RequiredLikes) .. " LIKES!"

		LikeBoard.Progress.Size = UDim2.new(1, 0, 1, 0)
	end
end

function LikeService.Get()
	local CurrentLikes = FetchLikes() or LastLikes
	LastLikes = CurrentLikes

	if not HasInitialized then
		for i, Milestone in ipairs(GameData.Milestones) do
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

	UpdateUI(CurrentLikes)
end

function LikeService:Start()
	if game.PrivateServerId ~= "" then
		MainFrame.Message.Visible = false
		MainFrame.ProgressBar.Visible = false
		MainFrame.PrivateServerMessage.Visible = true
		return
	end
	
	MainFrame.Visible = false

	MainFrame.Visible = true
	LikeService.Get()

	while true do
		task.wait(180)
		task.spawn(LikeService.Get)
	end
end

return LikeService