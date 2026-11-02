local Lib = require(game.ReplicatedStorage.Lib)
local Players = game:GetService("Players")
local Frame = Lib.UI.Get("PlayerDied"):WaitForChild("Frame")
local LocalPlayer = Players.LocalPlayer
local playagain = Frame.playagain
local reviveall = Frame.reviveall
local selfrevive = Frame.selfrevive
local counter = Frame.counter
local v1 = false
local v2 = false

local function GetPlayAgainVotes() --[[ GetPlayAgainVotes | Line: 16 | Upvalues: Lib (copy) ]]
	return #Lib.CS:GetTagged("PlayAgain")
end

local function UpdatePlayAgainButton() --[[ UpdatePlayAgainButton | Line: 20 | Upvalues: Players (copy), Lib (copy), playagain (copy), LocalPlayer (copy) ]]
	local v1 = #Players:GetPlayers()
	local v2 = #Lib.CS:GetTagged("PlayAgain")
	local v3 = playagain:FindFirstChild("text") or playagain

	v3.Text = string.format((if LocalPlayer:HasTag("PlayAgain") then "Voted!" else "Vote play again") .. " (%d/%d)", v2, v1)
end

local function GetAlivePlayers() --[[ GetAlivePlayers | Line: 29 | Upvalues: Players (copy), Lib (copy) ]]
	return #Players:GetPlayers() - #Lib.CS:GetTagged("DeadPlayer")
end

local function UpdateButtonVisibility() --[[ UpdateButtonVisibility | Line: 33 | Upvalues: Players (copy), Lib (copy), selfrevive (copy), reviveall (copy), playagain (copy), counter (copy), UpdatePlayAgainButton (copy) ]]
	local v1 = #Players:GetPlayers() - #Lib.CS:GetTagged("DeadPlayer")

	game.Players:HasTag("GameOverWith3Deaths")

	if (v1 > 0 or #game.Players:GetPlayers() == 1) and not game.Players:HasTag("GameOverWith3Deaths") then
		selfrevive.Visible = #game.Players:GetPlayers() ~= 1
		reviveall.Visible = #game.Players:GetPlayers() == 1
		playagain.Visible = #game.Players:GetPlayers() == 1
		counter.Visible = true
	else
		selfrevive.Visible = false
		reviveall.Visible = true
		playagain.Visible = true
		UpdatePlayAgainButton()
	end

	if not Lib.IsConsole then
		return
	end

	local GuiService = game:GetService("GuiService")
	local SelectedObject = GuiService.SelectedObject

	if SelectedObject and (SelectedObject.Visible and (SelectedObject == playagain or (SelectedObject == reviveall or SelectedObject == selfrevive))) then
		return
	end

	GuiService.GuiNavigationEnabled = true
	GuiService.SelectedObject = selfrevive.Visible and selfrevive or (reviveall.Visible and reviveall or (playagain.Visible and playagain or nil))
end

local function ShowDeathScreen() --[[ ShowDeathScreen | Line: 66 | Upvalues: Frame (copy), Lib (copy), UpdateButtonVisibility (copy) ]]
	Frame.Visible = true
	Frame.Parent:WaitForChild("Background").Visible = true
	Lib.UI.ChangeGroupTransparency(Frame, 0, 0.5)
	UpdateButtonVisibility()
end

local function HideDeathScreen() --[[ HideDeathScreen | Line: 73 | Upvalues: Lib (copy), playagain (copy), reviveall (copy), selfrevive (copy), Frame (copy), v1 (ref) ]]
	if Lib.IsConsole then
		local GuiService = game:GetService("GuiService")

		if GuiService.SelectedObject == playagain or (GuiService.SelectedObject == reviveall or GuiService.SelectedObject == selfrevive) then
			GuiService.SelectedObject = nil
		end
	end

	Lib.UI.ChangeGroupTransparency(Frame, 1, 0.3)
	v1 = false
	task.wait(0.3)
	Frame.Visible = false
	Frame.Parent:WaitForChild("Background").Visible = false
end

local function StartCountdown() --[[ StartCountdown | Line: 87 | Upvalues: v1 (ref), LocalPlayer (copy), counter (copy), Players (copy), Lib (copy), UpdateButtonVisibility (copy), HideDeathScreen (copy) ]]
	if v1 then
		return
	end

	v1 = true
	LocalPlayer:HasTag("DeadPlayer")
	counter.Visible = true

	local count = 30

	while count > 0 and v1 do
		if #Players:GetPlayers() - #Lib.CS:GetTagged("DeadPlayer") == 0 then
			UpdateButtonVisibility()
		end

		counter.Text = "Returning in " .. count
		task.wait(1)
		count = count - 1
	end

	if not v1 then
		return
	end

	counter.Text = "Returning to lobby..."
	task.wait(3)

	if not (LocalPlayer:HasTag("DeadPlayer") or game.Players:HasTag("GameOverWith3Deaths")) then
		print("revived!")

		return
	end

	Lib.Network:FireServer("TeleportToLobby")
	task.wait(1)
	HideDeathScreen()
end

Lib.Buttons.OnActivate(playagain, function() --[[ Line: 123 | Upvalues: Lib (copy), playagain (copy), UpdatePlayAgainButton (copy) ]]
	Lib.Network:FireServer("PlayAgainVote")
	playagain.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	UpdatePlayAgainButton()
end)
Lib.Buttons.OnActivate(selfrevive, function() --[[ Line: 130 | Upvalues: v2 (ref), Lib (copy), LocalPlayer (copy) ]]
	if v2 then
		Lib.MS:PromptProductPurchase(LocalPlayer, Lib.Data.Get("Prods").revive_second.id)
	else
		Lib.MS:PromptProductPurchase(LocalPlayer, Lib.Data.Get("Prods").revive.id)
	end
end)
Lib.Buttons.OnActivate(reviveall, function() --[[ Line: 138 | Upvalues: Lib (copy), LocalPlayer (copy) ]]
	Lib.MS:PromptProductPurchase(LocalPlayer, Lib.Data.Get("Prods").revive_all.id)
end)
Lib.CS:GetInstanceAddedSignal("PlayAgain"):Connect(UpdatePlayAgainButton)
Lib.Inject("ShowGameOverScreen", function(p1, p2, p3) --[[ Line: 144 | Upvalues: Frame (copy), Lib (copy), UpdateButtonVisibility (copy), StartCountdown (copy) ]]
	local title = Frame:WaitForChild("Frame").title

	title.Text = if p1 then p1 else Frame:WaitForChild("Frame").title.Text

	local desc = Frame:WaitForChild("Frame").desc

	desc.Text = if p2 then p2 else Frame:WaitForChild("Frame").desc.Text
	Frame.Parent:WaitForChild("Background").BackgroundTransparency = p3 or 0.33
	Frame.Visible = true
	Frame.Parent:WaitForChild("Background").Visible = true
	Lib.UI.ChangeGroupTransparency(Frame, 0, 0.5)
	UpdateButtonVisibility()
	UpdateButtonVisibility()
	StartCountdown()
end)
Lib.Inject("HideDeathScreen", HideDeathScreen)
Lib.CS:GetInstanceAddedSignal("DeadPlayer"):Connect(function(p1) --[[ Line: 156 | Upvalues: Players (copy), Lib (copy), Frame (copy), UpdateButtonVisibility (copy), StartCountdown (copy), LocalPlayer (copy), v2 (ref) ]]
	if #Players:GetPlayers() - #Lib.CS:GetTagged("DeadPlayer") < 1 then
		Frame.Visible = true
		Frame.Parent:WaitForChild("Background").Visible = true
		Lib.UI.ChangeGroupTransparency(Frame, 0, 0.5)
		UpdateButtonVisibility()
		UpdateButtonVisibility()
		StartCountdown()

		return
	end

	if p1 ~= LocalPlayer then
		return
	end

	Frame.Visible = true
	Frame.Parent:WaitForChild("Background").Visible = true
	Lib.UI.ChangeGroupTransparency(Frame, 0, 0.5)
	UpdateButtonVisibility()
	StartCountdown()
	v2 = true
end)
Lib.CS:GetInstanceRemovedSignal("DeadPlayer"):Connect(function(p1) --[[ Line: 169 | Upvalues: LocalPlayer (copy), HideDeathScreen (copy) ]]
	if p1 ~= LocalPlayer then
		return
	end

	HideDeathScreen()

	local charges = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("charges")

	while charges do
		charges:Destroy()

		local charges2 = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("charges")

		task.wait(0.05)
		charges = charges2
	end
end)
Lib.Network:BindEvents({
	EnabledReviveOther = function(p1, p2) --[[ EnabledReviveOther | Line: 183 | Upvalues: LocalPlayer (copy), Lib (copy) ]]
		if p1 ~= LocalPlayer then
			p2.Enabled = true
			p2.Triggered:Connect(function() --[[ Line: 187 | Upvalues: Lib (ref), p1 (copy) ]]
				Lib.Network:FireServer("ReviveOther", p1)
			end)
		end
	end
})

return {}