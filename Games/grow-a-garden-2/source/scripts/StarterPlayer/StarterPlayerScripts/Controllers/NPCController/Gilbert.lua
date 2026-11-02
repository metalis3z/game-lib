--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TopText = require(ReplicatedStorage.ClientModules.TopText)
local NPC = require(ReplicatedStorage.ClientModules.NPC)
local LocalPlayer = Players.LocalPlayer

LocalPlayer:WaitForChild("PlayerGui")

local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local NotificationController = require(LocalPlayer.PlayerScripts.Controllers.NotificationController)
local ViewGuildProgressController = require(LocalPlayer.PlayerScripts.Controllers.ViewGuildProgressController)
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local t = { "View Guild", "View Leaderboard", "View Rewards", "Nevermind" }
local t2 = { "Create Guild", "View Leaderboard", "View Rewards", "What are guilds?", "Nevermind" }
local t3 = { "What can I do for you, member?", "Welcome back. How\'s the guild?" }
local t4 = { "Looking to start a guild?", "Need help with guilds?" }
local v2 = false
local v3 = nil

local function IsInGuild() --[[ IsInGuild | Line: 52 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer:GetAttribute("GuildId") ~= nil
end

local function PickRandom(p1) --[[ PickRandom | Line: 56 ]]
	return p1[math.random(1, #p1)]
end

local function SetHighlight(p1, p2) --[[ SetHighlight | Line: 60 | Upvalues: TweenService (copy), v1 (copy) ]]
	local DialogueHighlight = p1:FindFirstChild("DialogueHighlight")

	if not DialogueHighlight then
		local DialogueHighlight2 = Instance.new("Highlight")

		DialogueHighlight2.Name = "DialogueHighlight"
		DialogueHighlight2.DepthMode = Enum.HighlightDepthMode.Occluded
		DialogueHighlight2.FillTransparency = 1
		DialogueHighlight2.OutlineTransparency = 1
		DialogueHighlight2.Adornee = p1
		DialogueHighlight2.Parent = p1
		DialogueHighlight = DialogueHighlight2
	end

	assert(DialogueHighlight)
	TweenService:Create(DialogueHighlight, v1, {
		OutlineTransparency = p2
	}):Play()
end

local function OpenGuildShop(p1) --[[ OpenGuildShop | Line: 77 | Upvalues: GuiController (copy) ]]
	GuiController:Open("GuildShop")
end

local function WaitForSelection(p1, p2) --[[ WaitForSelection | Line: 81 | Upvalues: TopText (copy), v2 (ref) ]]
	local v1 = TopText.ShowChoices(p1, p2)

	if #v1 == 0 then
		return nil, nil
	end

	local function anyAlive() --[[ anyAlive | Line: 90 | Upvalues: v1 (copy) ]]
		for v12, v2 in v1 do
			if v2 and v2.Parent then
				return true
			end
		end

		return false
	end

	local t = {}
	local v22 = nil

	for v3, v4 in v1 do
		local Frame = v4:FindFirstChild("Frame")

		if Frame then
			local ImageButton = Frame:FindFirstChild("ImageButton")

			if ImageButton and ImageButton:IsA("GuiButton") then
				table.insert(t, ImageButton.MouseButton1Click:Connect(function() --[[ Line: 104 | Upvalues: v22 (ref), v3 (copy) ]]
					v22 = v3
				end))
			end
		end
	end

	local v5 = TopText.ConnectChoiceKeyboard(v1, function(p1) --[[ Line: 110 | Upvalues: v22 (ref) ]]
		if v22 ~= nil then
			return
		end

		v22 = p1
	end)

	while v22 == nil do
		if v2 then
			local v6 = false

			for v7, v8 in v1 do
				if v8 and v8.Parent then
					v6 = true

					break
				end
			end

			if v6 then
				task.wait(0.05)
			else
				for v9, v10 in t do
					v10:Disconnect()
				end

				v5()

				return nil, nil
			end
		else
			for v11, v12 in t do
				v12:Disconnect()
			end

			v5()
			TopText.RemovePlayerSideFrame(p1)

			return nil, nil
		end
	end

	for v13, v14 in t do
		v14:Disconnect()
	end

	v5()
	TopText.RemovePlayerSideFrame(p1)

	local v15 = p2[v22]

	if p1.Character then
		TopText.PlayerResponse(p1.Character, v15, true)
	end

	return v22, v15
end

local function HandleCreateGuild() --[[ HandleCreateGuild | Line: 149 | Upvalues: LocalPlayer (copy), NotificationController (copy), GuiController (copy) ]]
	if LocalPlayer:GetAttribute("GuildId") ~= nil then
		NotificationController:CreateNotification("You\'re already in a guild!")

		return
	end

	if GuiController:IsOpen("CreateGuild") then
		return
	end

	GuiController:Open("CreateGuild", nil, { "HUD" })
end

local function HandleViewGuild() --[[ HandleViewGuild | Line: 159 | Upvalues: LocalPlayer (copy), NotificationController (copy), GuiController (copy) ]]
	if not (LocalPlayer:GetAttribute("GuildId") ~= nil) then
		NotificationController:CreateNotification("You aren\'t in a guild")

		return
	end

	if GuiController:IsOpen("ViewGuildPage") then
		return
	end

	GuiController:Open("ViewGuildPage", nil, { "HUD" })
end

local function HandleViewLeaderboard(p1) --[[ HandleViewLeaderboard | Line: 169 | Upvalues: GuiController (copy) ]]
	if GuiController:IsOpen("ViewGuildLeaderboard") then
		return
	end

	GuiController:Open("ViewGuildLeaderboard", nil, { "HUD" })
end

local function HandleViewRewards() --[[ HandleViewRewards | Line: 175 | Upvalues: GuiController (copy), ViewGuildProgressController (copy) ]]
	if GuiController:IsOpen("ViewGuildProgress") then
		return
	end

	ViewGuildProgressController:SetNoReturn()
	GuiController:Open("ViewGuildProgress", nil, { "HUD" })
end

local function HandleNevermind() --[[ HandleNevermind | Line: 184 ]]
	task.wait(0.5)
end

local function HandleWhatAreGuilds(p1) --[[ HandleWhatAreGuilds | Line: 194 | Upvalues: TopText (copy), v2 (ref) ]]
	TopText.NpcText(p1, "You must be invited to join!", true)
	task.wait(2.5)

	if not v2 then
		return
	end

	TopText.NpcText(p1, "Get weekly exclusive prizes!", true)
	task.wait(2.5)

	if v2 then
		TopText.NpcText(p1, "Compete globally!", true)
		task.wait(2.5)
	end
end

local function EndConversation(p1, p2) --[[ EndConversation | Line: 206 | Upvalues: v2 (ref), TopText (copy), LocalPlayer (copy), NPC (copy), SetHighlight (copy) ]]
	v2 = false
	TopText.TakeAwayResponses(p1, LocalPlayer)
	TopText.RemovePlayerSideFrame(LocalPlayer)
	NPC.EndSpeaking(LocalPlayer)
	SetHighlight(p1, 1)
	task.wait(0.4)

	if not p2.Parent then
		return
	end

	p2.Enabled = true
end

local function StartConversation(p1, p2, p3) --[[ StartConversation | Line: 218 | Upvalues: v2 (ref), NPC (copy), LocalPlayer (copy), SetHighlight (copy), v3 (ref), TopText (copy), t3 (copy), t4 (copy), t (copy), t2 (copy), WaitForSelection (copy), HandleCreateGuild (copy), GuiController (copy), HandleViewGuild (copy), HandleViewRewards (copy), HandleWhatAreGuilds (copy), EndConversation (copy) ]]
	if v2 then
		return
	end

	if not NPC.CanSpeak(LocalPlayer) then
		return
	end

	v2 = true
	NPC.StartSpeaking(LocalPlayer)
	p3.Enabled = false
	SetHighlight(p1, 1)

	if v3 then
		v3:Play(0.1, 100, 1)
	end

	local v1 = task.spawn(function() --[[ Line: 234 | Upvalues: v2 (ref), LocalPlayer (ref), p2 (copy), TopText (ref), p1 (copy) ]]
		repeat
			if not v2 then
				return
			end

			task.wait(0.25)

			local Character = LocalPlayer.Character
			local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
		until v1 and (v1:IsA("BasePart") and (v1.Position - p2.Position).Magnitude > 10)

		TopText.NpcText(p1, "...", true)
		v2 = false
		TopText.RemovePlayerSideFrame(LocalPlayer)
	end)
	local v22 = false
	local v32 = LocalPlayer:GetAttributeChangedSignal("GuildId"):Connect(function() --[[ Line: 256 | Upvalues: v22 (ref), v2 (ref), TopText (ref), LocalPlayer (ref) ]]
		v22 = true
		v2 = false
		TopText.RemovePlayerSideFrame(LocalPlayer)
	end)
	local v4 = if LocalPlayer:GetAttribute("GuildId") == nil then false else true
	local v5

	if v4 then
		local v6 = t3

		v5 = v6[math.random(1, #v6)]
	else
		local v7 = t4

		v5 = v7[math.random(1, #v7)]
	end

	TopText.NpcText(p1, v5, true)
	task.wait(0.4)

	while v2 do
		local _, v10 = WaitForSelection(LocalPlayer, if if LocalPlayer:GetAttribute("GuildId") == nil then false else true then t else t2)

		if v22 or not v10 then
			break
		end

		if v10 == "Create Guild" then
			HandleCreateGuild()

			break
		elseif v10 == "View Guild Shop!" then
			GuiController:Open("GuildShop")

			break
		elseif v10 == "View Guild" then
			HandleViewGuild()

			break
		elseif v10 == "View Leaderboard" then
			if not GuiController:IsOpen("ViewGuildLeaderboard") then
				GuiController:Open("ViewGuildLeaderboard", nil, { "HUD" })
			end

			break
		elseif v10 == "View Rewards" then
			HandleViewRewards()

			break
		elseif v10 == "What are guilds?" then
			HandleWhatAreGuilds(p1)
		else
			if v10 == "Nevermind" then
				task.wait(0.5)
			end

			break
		end
	end

	v32:Disconnect()

	if coroutine.status(v1) == "dead" then
		EndConversation(p1, p3)

		return
	end

	task.cancel(v1)
	EndConversation(p1, p3)
end

return function() --[[ Line: 324 | Upvalues: v3 (ref), SetHighlight (copy), v2 (ref), LocalPlayer (copy), StartConversation (copy) ]]
	task.spawn(function() --[[ Line: 325 | Upvalues: v3 (ref), SetHighlight (ref), v2 (ref), LocalPlayer (ref), StartConversation (ref) ]]
		local NPCS = workspace:WaitForChild("NPCS", 30)

		if not NPCS then
			return
		end

		local Gilbert = NPCS:WaitForChild("Gilbert", 30)

		if not (Gilbert and Gilbert:IsA("Model")) then
			return
		end

		local HumanoidRootPart = Gilbert:WaitForChild("HumanoidRootPart", 10)

		if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
			return
		end

		local ProximityPrompt = HumanoidRootPart:WaitForChild("ProximityPrompt", 10)

		if not (ProximityPrompt and ProximityPrompt:IsA("ProximityPrompt")) then
			return
		end

		local Humanoid = Gilbert:WaitForChild("Humanoid", 10)
		local Animations = Gilbert:WaitForChild("Animations", 10)

		if not (Humanoid and (Humanoid:IsA("Humanoid") and Animations)) then
			ProximityPrompt.PromptShown:Connect(function() --[[ Line: 354 | Upvalues: SetHighlight (ref), Gilbert (copy) ]]
				SetHighlight(Gilbert, 0)
			end)
			ProximityPrompt.PromptHidden:Connect(function() --[[ Line: 357 | Upvalues: v2 (ref), SetHighlight (ref), Gilbert (copy) ]]
				if v2 then
					return
				end

				SetHighlight(Gilbert, 1)
			end)
			ProximityPrompt.Triggered:Connect(function(p1) --[[ Line: 362 | Upvalues: LocalPlayer (ref), StartConversation (ref), Gilbert (copy), HumanoidRootPart (copy), ProximityPrompt (copy) ]]
				if p1 == LocalPlayer then
					task.spawn(StartConversation, Gilbert, HumanoidRootPart, ProximityPrompt)
				end
			end)

			return
		end

		local Animator = Humanoid:WaitForChild("Animator", 10)
		local Interact = Animations:FindFirstChild("Interact")

		if not (Animator and (Animator:IsA("Animator") and (Interact and Interact:IsA("Animation")))) then
			ProximityPrompt.PromptShown:Connect(function() --[[ Line: 354 | Upvalues: SetHighlight (ref), Gilbert (copy) ]]
				SetHighlight(Gilbert, 0)
			end)
			ProximityPrompt.PromptHidden:Connect(function() --[[ Line: 357 | Upvalues: v2 (ref), SetHighlight (ref), Gilbert (copy) ]]
				if v2 then
					return
				end

				SetHighlight(Gilbert, 1)
			end)
			ProximityPrompt.Triggered:Connect(function(p1) --[[ Line: 362 | Upvalues: LocalPlayer (ref), StartConversation (ref), Gilbert (copy), HumanoidRootPart (copy), ProximityPrompt (copy) ]]
				if p1 == LocalPlayer then
					task.spawn(StartConversation, Gilbert, HumanoidRootPart, ProximityPrompt)
				end
			end)

			return
		end

		v3 = Animator:LoadAnimation(Interact)
		ProximityPrompt.PromptShown:Connect(function() --[[ Line: 354 | Upvalues: SetHighlight (ref), Gilbert (copy) ]]
			SetHighlight(Gilbert, 0)
		end)
		ProximityPrompt.PromptHidden:Connect(function() --[[ Line: 357 | Upvalues: v2 (ref), SetHighlight (ref), Gilbert (copy) ]]
			if v2 then
				return
			end

			SetHighlight(Gilbert, 1)
		end)
		ProximityPrompt.Triggered:Connect(function(p1) --[[ Line: 362 | Upvalues: LocalPlayer (ref), StartConversation (ref), Gilbert (copy), HumanoidRootPart (copy), ProximityPrompt (copy) ]]
			if p1 == LocalPlayer then
				task.spawn(StartConversation, Gilbert, HumanoidRootPart, ProximityPrompt)
			end
		end)
	end)
end