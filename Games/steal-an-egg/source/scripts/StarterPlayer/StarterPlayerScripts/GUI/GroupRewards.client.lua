local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Library = ReplicatedStorage:WaitForChild("Library")
local Client = Library:WaitForChild("Client")

local Asserts = require(Library:WaitForChild("Asserts"))
local ButtonFX = require(Client:WaitForChild("GUIFX"):WaitForChild("ButtonFX"))
local Confetti = require(Client:WaitForChild("GUIFX"):WaitForChild("Confetti"))
local Constants = require(Library:WaitForChild("Globals"):WaitForChild("Constants"))
local GUI = require(Client:WaitForChild("GUI"))
local GroupReward = require(Library:WaitForChild("Types"):WaitForChild("GroupReward"))
local Lock = require(Library:WaitForChild("Functions"):WaitForChild("Lock"))
local Log = require(Library:WaitForChild("Modules"):WaitForChild("Packages"):WaitForChild("Log"))
local Message = require(Client:WaitForChild("Message"))
local Network = require(Client:WaitForChild("Network")) 
local Save = require(Client:WaitForChild("Save"))
local SpeedPower = require(Client:WaitForChild("RewardFeedback"):WaitForChild("SpeedPower"))
local TabController = require(Client:WaitForChild("TabController"))

local CLAIMED_COLOR = Color3.fromRGB(25, 151, 0)
local CLAIM_REWARD_EVENT = Network.NET_MAP.GroupReward.CLAIM_REWARD

local logger = Log.new()
local LocalPlayer = Players.LocalPlayer
local rewardGui = GUI.GroupReward()

local ClaimRewardButton = rewardGui.FrameReward.Main.ClaimReward
local Title = ClaimRewardButton.Title
local ProximityPrompt = Workspace.__OBJECTS.GroupReward.ProximityPrompt

local DefaultBackgroundColor = ClaimRewardButton.BackgroundColor3
local DefaultTitleText = Title.Text
local actionLock = Lock()

assert(ProximityPrompt:IsA("ProximityPrompt"), "Expected GroupReward.ProximityPrompt to be a ProximityPrompt")

local function renderClaimState(isClaimed)
	Asserts.boolean(isClaimed)
	ClaimRewardButton.BackgroundColor3 = if isClaimed then CLAIMED_COLOR else DefaultBackgroundColor
	Title.Text = if isClaimed then "CLAIMED" else DefaultTitleText
end

local function updateView()
	local saveData = Save.Get()

	if saveData == nil then
		return
	end

	local isClaimedGroupReward = saveData.ClaimedGroupReward == true

	Asserts.boolean(isClaimedGroupReward)
	ClaimRewardButton.BackgroundColor3 = if isClaimedGroupReward then CLAIMED_COLOR else DefaultBackgroundColor
	Title.Text = if isClaimedGroupReward then "CLAIMED" else DefaultTitleText
end

local function invokeClaim(isMember)
	Asserts.boolean(isMember)

	local success, errorMessage, rewardAmount = Network.Invoke(CLAIM_REWARD_EVENT, isMember)

	if not success then
		Message.New(errorMessage or "Failed to claim reward!")
		return false
	end

	Asserts.number(rewardAmount)

	if not TabController.IsOpen("GroupReward") then
		Asserts.boolean(true)
		ClaimRewardButton.BackgroundColor3 = CLAIMED_COLOR
		Title.Text = "CLAIMED"
		Message.New("REWARD CLAIMED!")
		Confetti.Play()
		SpeedPower.Show(rewardAmount)

		return true
	end

	TabController.CloseTab()
	Asserts.boolean(true)
	ClaimRewardButton.BackgroundColor3 = CLAIMED_COLOR
	Title.Text = "CLAIMED"
	Message.New("REWARD CLAIMED!")
	Confetti.Play()
	SpeedPower.Show(rewardAmount)

	return true
end

local function resolveClientMembership()
	local ok, isMember = pcall(function()
		return LocalPlayer:IsInGroupAsync(Constants.GROUP_ID)
	end)

	if not ok then
		Message.New("Failed to verify your group membership!")
		return false, false
	end

	if isMember then
		return true, true
	end

	local promptOk, promptStatus = pcall(function()
		return GroupService:PromptJoinAsync(Constants.GROUP_ID)
	end)

	if not promptOk then
		Message.New("Failed to open the group join prompt!")
		return false, false
	end

	if promptStatus == Enum.GroupMembershipStatus.Joined or promptStatus == Enum.GroupMembershipStatus.AlreadyMember then
		return true, true
	end

	if promptStatus == Enum.GroupMembershipStatus.JoinRequestPending then
		Message.New("Your request to join the group is pending approval.")
	else
		Message.New("You must join the group to claim this reward!")
	end

	return false, false
end

local function onClaimActivated()
	local saveData = Save.Get()

	if saveData == nil then
		Message.StandardError()
		return
	end

	if saveData.ClaimedGroupReward == true then
		Message.New("You already claimed this reward!")
		return
	end

	local isSuccess, isMember = resolveClientMembership()

	if isSuccess then
		invokeClaim(isMember)
	end
end

rewardGui.FrameReward.Main.ImageLabel.MPS.Text = GroupReward.GetDisplayName()

ButtonFX(ClaimRewardButton, nil, function()
	actionLock(onClaimActivated)
end)

ProximityPrompt.Triggered:Connect(function()
	TabController.ToggleTab("GroupReward")
end)

if Save.IsLocalDataLoaded() then
	local saveData = Save.Get()

	if saveData ~= nil then
		local isClaimedGroupReward = saveData.ClaimedGroupReward == true

		Asserts.boolean(isClaimedGroupReward)
		ClaimRewardButton.BackgroundColor3 = if isClaimedGroupReward then CLAIMED_COLOR else DefaultBackgroundColor
		Title.Text = if isClaimedGroupReward then "CLAIMED" else DefaultTitleText
	end
else
	Save.LoadedStats:Connect(updateView)
end

Save.ConnectForDataChanged({ "ClaimedGroupReward" }, updateView)
logger:AtInfo():Log("Group rewards client initialized")