local ToggleBtn = script.Parent.Toggle
local ChallengeList = script.Parent.ChallengeList

ToggleBtn.Visible = true

ToggleBtn.Activated:connect(function()
	ChallengeList.Visible = not ChallengeList.Visible
	ToggleBtn.TextLabel.Text = (ChallengeList.Visible and "Hide" or "Show") .. " Daily Challenges"
end)

local Player = game.Players.LocalPlayer

function updChallengeDisplay(Challenge)
	script.Parent.Visible = true
	for _, child in ipairs(ChallengeList:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	local challengeType = "master"
	local challengesDid = {}
	for _, challenge in ipairs(Challenge.standard) do
		if challenge.amtCurrent >= challenge.amtRequired then
			table.insert(challengesDid, challenge)
		end
	end
	if #challengesDid >= #Challenge.standard then
		challengeType = "master"
	else
		challengeType = "standard"
	end
	local promotionText
	if challengeType == "standard" then
		promotionText = "Get <font color=\"#3498DB\">2 Gems</font> Per Challenge; Master Challenges Unlock Afterwards!"
	else
		promotionText = "Get <font color=\"#3498DB\">2 Gems</font> Per Challenge; Complete All Master Challenges For <font color=\"#3498DB\">8 Gems</font>!"
	end
	ChallengeList.MasterPromotion.Text = promotionText
	local challenges = {}
	for index, challenge in ipairs(Challenge[challengeType]) do
		local challengeFrame = script.ChallengeFrame:Clone()
		if challenge.allOrNothing ~= true and challenge.amtRequired == 1 then
			challengeFrame.Amount.Visible = false
			challengeFrame.Title.Size = UDim2.new(0.9, 0, 1, 0)
		else
			challengeFrame.Title.Size = UDim2.new(0.9, 0, 1, 0)
		end
		if challengeType == "standard" then
			challengeFrame.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
		elseif challengeType == "master" then
			challengeFrame.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
		end
		challengeFrame.Title.Text = challenge.desc
		if 100 < challenge.amtRequired then
			challengeFrame.Amount.Text = math.floor(challenge.amtCurrent / challenge.amtRequired * 100) .. "%"
		else
			challengeFrame.Amount.Text = challenge.amtCurrent .. "/" .. challenge.amtRequired
		end
		challengeFrame.ProgressBar.Percent.Size = UDim2.new(challenge.amtCurrent / challenge.amtRequired, 0, 1, 0)
		if challenge.amtRequired <= challenge.amtCurrent then
			challengeFrame.ProgressBar.Percent.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
			challengeFrame.Amount.TextColor3 = Color3.fromRGB(156, 255, 198)
			challengeFrame.Title.TextColor3 = Color3.fromRGB(156, 255, 198)
		end
		challengeFrame.PremiumOnly.Visible = challenge.isPremium == true and Player.MembershipType ~= Enum.MembershipType.Premium
		challengeFrame.LayoutOrder = index
		challengeFrame.Parent = ChallengeList
		if challenge.amtCurrent < challenge.amtRequired then
			table.insert(challenges, challenge)
		end
	end
	ChallengeList.CycleChallenges.Visible = Challenge.cycledChallenges ~= true and #challenges <= 0
	ChallengeList.MasterPromotion.Visible = #challenges > 0
end

local PreviousChallenges = nil;
game.ReplicatedStorage.Remote.UpdPlayerData.OnClientEvent:connect(function(PlayerData, ToUpdate)
	if PlayerData.dailyChallenges ~= PreviousChallenges then
		updChallengeDisplay(PlayerData.dailyChallenges)
	end
	if ToUpdate == true then
		script.UpdateSnd:Play()
		ToggleBtn.Woosh.Position = UDim2.new(-1, 0, 0, 0)
		ToggleBtn.Woosh:TweenPosition(UDim2.new(1, 0, 0, 0), "Out", "Linear", 0.5, false)
	end
	PreviousChallenges = PlayerData.dailyChallenges
end)

local lastClickTime = tick()

ChallengeList.CycleChallenges.MouseButton1Click:Connect(function()

	if tick() - 1 < lastClickTime then
		game.ReplicatedStorage.Remote.CycleNewChallenges:FireServer()
		lastClickTime = 0
		return
	end
	lastClickTime = tick()
	ChallengeList.CycleChallenges.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
	while true do
		wait()
		if lastClickTime < tick() - 1 then
			break
		end
	end
	ChallengeList.CycleChallenges.BackgroundColor3 = Color3.fromRGB(241, 219, 128)
end);
