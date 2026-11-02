local Local_Player = game.Players.LocalPlayer
local CL_MAIN_GameScript = Local_Player.PlayerScripts.CL_MAIN_GameScript
local FE2Library = require(game.ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("FE2Library"))
local UI = Local_Player.PlayerGui.GameGui.Waiting.UI
local Content = UI.Content
local VoteFrame = script.VoteFrame
local Content_Voting = script.Parent.Window.Frame.Content.MainVotes
local MapInfos = nil
local ButtonFunction = {}
local Buttons = {}
local Local_Data = {}
local HasPlayerVoted = false
local LastButtons = nil
local CanPress = false
local CanPressMapVote = false
local ConfirmColors = {
	["Confrim"] = Color3.fromRGB(241, 196, 15),
	["Default"] = Color3.fromRGB(22, 31, 40),
}
local BtnColors = {
	["Confrim"] = Color3.fromRGB(241, 219, 129),
	["Default"] = Color3.fromRGB(44, 62, 80)
}
local LastButton 
local aaaa = 0
local lastMapInfos
local muti = 1

function changeBorderColor(p5, p6)
	p5.BackgroundColor3 = p6
end
function changeStuff(p5, p6, p7)
	p5.SpecialMap.Text = p6
	p5.SpecialMap.BackgroundColor3 = p7
	p5.SpecialMap.Visible = true
end
function getVoteCost(p4, v1)
	if v1 then
		return math.clamp(v1.extraVoteCost + (p4 - 1) * 10, 0, 50)
	end
	return 0
end

local function vote()
	LastButton = nil
	CanPress = false
	CanPressMapVote = false
	aaaa = 0
	local hasAllMaps = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Local_Player.UserId, 14112023)
	if MapInfos == nil then
		MapInfos = game.ReplicatedStorage.Remote.GetVotingData:InvokeServer()
		for index = 1, #MapInfos, 1 do
			local NewVote = VoteFrame:Clone()
			NewVote.Parent = Content_Voting
			if MapInfos[index].locked == true then
				MapInfos[index].locked = not hasAllMaps
			end
			if MapInfos[index].cooldown then
				NewVote.VoteBtn.ActionInfo.VoteStatus.CooldownIcon.Visible = true
				local LockFrame = Instance.new("Frame")
				LockFrame.Name = "Locked_Frame"
				LockFrame.Parent = NewVote
				LockFrame.Size = UDim2.new(1, 0, 1, 0)
				LockFrame.BackgroundColor3 = Color3.new(0, 0, 0)
				LockFrame.Transparency = 0.5
				NewVote.VoteBtn.ActionInfo.VoteAction.Text = "Cooldown"
			elseif MapInfos[index].locked and hasAllMaps == false then
				NewVote.VoteBtn.ActionInfo.VoteStatus.LockIcon.Visible = true
				local LockFrame = Instance.new("Frame")
				LockFrame.Name = "Locked_Frame"
				LockFrame.Parent = NewVote
				LockFrame.Size = UDim2.new(1, 0, 1, 0)
				LockFrame.BackgroundColor3 = Color3.new(0, 0, 0)
				LockFrame.Transparency = 0.5
				NewVote.VoteBtn.ActionInfo.VoteAction.Text = tostring(MapInfos[index].unlockCost) .. " Coins"
			else
				NewVote.VoteBtn.BackgroundTransparency = 0
			end
			NewVote.VoteBtn.Image = "rbxassetid://" .. tostring(MapInfos[index].imgID)
			NewVote.VoteBtn.StarRating.RatingNumber.Text = tostring(MapInfos[index].difficulty)
			NewVote.VoteBtn.MapName.Text = MapInfos[index].name
			if not MapInfos[index].cooldown and not MapInfos[index].locked then
				NewVote.VoteCount.TextTransparency = 0
				NewVote.VoteCount.Text = tostring(MapInfos[index].voteCount)
			else
				NewVote.VoteCount.TextTransparency = 1
			end
			if MapInfos[index].specialMapName ~= nil and MapInfos[index].specialMapColor ~= nil then
				changeBorderColor(NewVote, MapInfos[index].specialMapColor)
				changeStuff(NewVote, MapInfos[index].specialMapName, MapInfos[index].specialMapColor)	
			end
			Buttons[index] = NewVote
			NewVote.VoteBtn.MouseButton1Click:Connect(function()
				aaaa = 0
				for index, item in ipairs(Content_Voting:GetChildren()) do
					if item:IsA("Frame") and item.BackgroundColor3 == BtnColors.Confrim then
						item.BackgroundColor3 = BtnColors.Default
					end
				end
				if CanPress == true then
					CanPress = false
					for index, item in ipairs(Content_Voting:GetChildren()) do
						if item:IsA("Frame") and item.BackgroundColor3 == BtnColors.Confrim then
							item.BackgroundColor3 = BtnColors.Default
						end
					end
				end
				if not MapInfos[index].cooldown then
					if HasPlayerVoted == false then
						if MapInfos[index].locked then
							NewVote.BackgroundColor3 = BtnColors.Confrim
							Content_Voting.Parent.Parent.Confirm.BackgroundColor3 = ConfirmColors.Confrim
							Content_Voting.Parent.Parent.Confirm.Text = "Unlock & Add Vote"
							CanPress = true
							aaaa = index
						else
							NewVote.BackgroundColor3 = BtnColors.Confrim
							Content_Voting.Parent.Parent.Confirm.BackgroundColor3 = ConfirmColors.Confrim
							Content_Voting.Parent.Parent.Confirm.Text = "Add Free Vote"
							CanPress = true
							aaaa = index
						end
					end
				end
			end)
		end
	end
	script.Parent.Visible = true
	UI.Visible = false
	script.Parent.Position = UDim2.new(-1, 0, 0, 0)
	script.Parent:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Sine", 0.3, true)
end

local function stopVote()
	for index, item in next, Buttons do
		Buttons[index]:Destroy()
		Buttons[index] = nil
	end
	for index, item in next, ButtonFunction do
		ButtonFunction[index] = nil
	end
	for index, item in next, Local_Data do
		Local_Data[index] = nil
	end
	ButtonFunction = {}
	Buttons = {}
	Local_Data = {}
	CanPressMapVote = false
	MapInfos = nil
	muti = 1
	HasPlayerVoted = false
	LastButtons = nil
	LastButton = nil
	lastMapInfos = nil
	script.Parent.Visible = false
	local state = CL_MAIN_GameScript.GetPlayerData:Invoke()
	--what the hell is this
	if state.PlayerState ~= "Playing" and state.PlayerState ~= "Lobby" and state.PlayerState ~= "Won" and state.PlayerState ~= "Waiting" then
		UI.Visible = true
		UI.Content.Buttons.MapVote.Visible = false
		UI.Content.Buttons.Intensity.Visible = true
	else
		--print("me!")
		UI.Visible = false
		UI.Content.Buttons.MapVote.Visible = false
		UI.Content.Buttons.Intensity.Visible = true
	end
end

--CL_MAIN_GameScript.PlayerWon.Event:Connect(vote)
CL_MAIN_GameScript.CancelVoting.Event:Connect(stopVote)
Content.Buttons.MapVote.MouseButton1Click:Connect(vote)

game.ReplicatedStorage.Remote.StartVotingWon.OnClientEvent:Connect(vote)

game.ReplicatedStorage.Remote.VoteUpdate.OnClientEvent:Connect(function(MapName : string, voteCount : string, i : number)
	lastMapInfos = MapInfos
	MapInfos = game.ReplicatedStorage.Remote.GetVotingData:InvokeServer()
	if MapInfos ~= nil then
		for index, item in next, Buttons do
			if index == i then
				if MapInfos[i].locked ~= lastMapInfos[i].locked and item:FindFirstChild("Locked_Frame") then
					item.Locked_Frame:Destroy()
					item.VoteBtn.ActionInfo.VoteStatus.LockIcon.Visible = false
				end
				--print(HasPlayerVoted)
				if HasPlayerVoted then
					if item:FindFirstChild("VoteCount") then
						item.VoteCount:Destroy()
					end
					for _, v in next, item:GetChildren() do
						if v:IsA("ImageLabel") then
							v.Visible = false
						end
					end
					--print(getVoteCost(voteCount, MapInfos[index]))
					MapInfos[index].extraVoteCost *= muti
					muti += 1
					if muti < 5 then
						item.VoteBtn.ActionInfo.VoteAction.Text = tostring(MapInfos[index].extraVoteCost) .. " Coins"
						item.VoteBtn.ActionInfo.VoteStatus.Text = voteCount	
						item.BackgroundColor3 = BtnColors.Confrim
						Content_Voting.Parent.Parent.Confirm.BackgroundColor3 = ConfirmColors.Confrim
						Content_Voting.Parent.Parent.Confirm.Text = "Add Extra Vote"
						CanPressMapVote = true
						aaaa = index	
					else
						item.VoteBtn.ActionInfo.VoteAction.Text = tostring(MapInfos[index].extraVoteCost) .. " Coins"
						item.VoteBtn.ActionInfo.VoteStatus.Text = voteCount	
						item.BackgroundColor3 = BtnColors.Default
						Content_Voting.Parent.Parent.Confirm.BackgroundColor3 = ConfirmColors.Default
						Content_Voting.Parent.Parent.Confirm.Text = "Added Max. Votes"
						CanPressMapVote = false
						aaaa = index	
					end
				else
					item.VoteCount.Text = voteCount
				end
			end
		end
	end
end)

game.ReplicatedStorage.Remote.VotingReset.OnClientEvent:Connect(stopVote)

Content_Voting.Parent.Parent.Close.MouseButton1Click:Connect(function()
	local state = CL_MAIN_GameScript.GetPlayerData:Invoke().PlayerState
	--print(state)
	if state == "Won" then
script.Parent.Position = UDim2.new(0, 0, 0, 0)
script.Parent:TweenPosition(UDim2.new(-1, 0, 0, 0), "Out", "Sine", 0.3, true)
		--script.Parent.Visible = false
		UI.Visible = false
	else
script.Parent.Position = UDim2.new(0, 0, 0, 0)
script.Parent:TweenPosition(UDim2.new(-1, 0, 0, 0), "Out", "Sine", 0.3, true)
		--script.Parent.Visible = false
		UI.Visible = true
	end
end)

game.Players.LocalPlayer.CharacterRemoving:Connect(stopVote)

game.Players.LocalPlayer.CharacterAdded:Connect(stopVote)

Content_Voting.Parent.Parent.Confirm.MouseButton1Click:Connect(function()
	if CanPress then
		--Content_Voting.Parent.Parent.Confirm.BackgroundColor3 = ConfirmColors.Default
		--Content_Voting.Parent.Parent.Confirm.Text = ""
		HasPlayerVoted = true
		CanPress = false
		game.ReplicatedStorage.Remote.VoteUpdate:FireServer(aaaa)
	elseif CanPressMapVote then
		if muti >= 2 then
			local v328 = MapInfos[aaaa].extraVoteCost
			game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.Notify:Fire("You have voted " .. muti .. " times. Add an extra vote for " .. v328 .. " Coins?", "Extra Vote", function()
				CL_MAIN_GameScript.VoteEvent:Fire()
			end, 636742339)
			CL_MAIN_GameScript.VoteEvent.Event:Connect(function()
				game.ReplicatedStorage.Remote.VoteUpdate:FireServer(aaaa, lastMapInfos[aaaa].extraVoteCost)
			end)
		else
			game.ReplicatedStorage.Remote.VoteUpdate:FireServer(aaaa, lastMapInfos[aaaa].extraVoteCost)
		end
		CanPressMapVote = false
		HasPlayerVoted = true
	end
end)

script.Parent.Window.Frame.Content.BuyMapVoteBoost.Activated:connect(function()
	(game:GetService("MarketplaceService")):PromptGamePassPurchase(Local_Player, 141376407)
end)