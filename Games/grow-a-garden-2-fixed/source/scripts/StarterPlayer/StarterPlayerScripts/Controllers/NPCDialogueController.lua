--credit to quartz games studio
local TweenService = game:GetService("TweenService")

game:GetService("Debris")

local TopText = require(game.ReplicatedStorage.ClientModules.TopText)
local NPC = require(game.ReplicatedStorage.ClientModules.NPC)
local LocalPlayer = game.Players.LocalPlayer
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local t = {}

local function tweenHighlightTransparency(p1, p2) --[[ tweenHighlightTransparency | Line: 19 | Upvalues: t (copy), TweenService (copy), v1 (copy) ]]
	local v12 = t[p1]

	if v12 then
		v12:Cancel()
		v12:Destroy()
		t[p1] = nil
	end

	local v2 = TweenService:Create(p1, v1, {
		OutlineTransparency = p2
	})

	t[p1] = v2
	v2.Completed:Once(function() --[[ Line: 28 | Upvalues: t (ref), p1 (copy), v2 (copy) ]]
		if t[p1] == v2 then
			t[p1] = nil
		end

		v2:Destroy()
	end)
	v2:Play()
end

local t2 = {}
local v2 = false

function t2.DoDialogue(p1, p2) --[[ DoDialogue | Line: 87 | Upvalues: TopText (copy), v2 (ref), NPC (copy), tweenHighlightTransparency (copy) ]]
	local ProximityPrompt = p2.ProximityPrompt
	local SpeakingNPC = p2.SpeakingNPC
	local PromptList = p2.PromptList
	local OperationMap = p2.OperationMap
	local IntroLines = p2.IntroLines
	local LocalPlayer = game.Players.LocalPlayer
	local v1 = p2.RootPart or SpeakingNPC:FindFirstChild("HumanoidRootPart") or SpeakingNPC
	local DialogueHighlight = SpeakingNPC:FindFirstChild("DialogueHighlight")

	if not DialogueHighlight then
		DialogueHighlight = Instance.new("Highlight")

		if DialogueHighlight and DialogueHighlight:IsA("Highlight") then
			DialogueHighlight.Name = "DialogueHighlight"
			DialogueHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
			DialogueHighlight.FillTransparency = 1
			DialogueHighlight.OutlineTransparency = 1
			DialogueHighlight.Adornee = SpeakingNPC
			DialogueHighlight.Parent = SpeakingNPC
		end
	end

	local v22 = false
	local v3 = false
	local v4 = nil
	local t = {}

	local function IsDialogueEnabled() --[[ IsDialogueEnabled | Line: 126 | Upvalues: SpeakingNPC (copy) ]]
		if SpeakingNPC.Parent then
			return not SpeakingNPC:GetAttribute("DisableDialogue")
		end

		return false
	end

	local function EndConversation(p1) --[[ EndConversation | Line: 133 | Upvalues: TopText (ref), SpeakingNPC (copy), LocalPlayer (copy), v22 (ref), v4 (ref), t (copy), v3 (ref), v2 (ref), ProximityPrompt (copy), NPC (ref) ]]
		TopText.TakeAwayResponses(SpeakingNPC, LocalPlayer)
		TopText.RemovePlayerSideFrame(LocalPlayer)

		if not v22 then
			return
		end

		if v4 then
			task.cancel(v4)
		end

		for v1, v23 in t do
			v23:Disconnect()
		end

		table.clear(t)
		TopText.TakeAwayResponses(SpeakingNPC, LocalPlayer)
		TopText.RemovePlayerSideFrame(LocalPlayer)

		if p1.OnDialogueEnded then
			p1.OnDialogueEnded()
		end

		v3 = false
		v22 = false

		if SpeakingNPC.Parent then
			SpeakingNPC:SetAttribute("ConversationStarted", false)
		end

		v2 = false
		task.defer(function() --[[ Line: 168 | Upvalues: TopText (ref), SpeakingNPC (ref), LocalPlayer (ref) ]]
			TopText.TakeAwayResponses(SpeakingNPC, LocalPlayer)
			TopText.RemovePlayerSideFrame(LocalPlayer)
		end)
		task.wait(0.5)

		if not ProximityPrompt.Parent then
			NPC.EndSpeaking(LocalPlayer)

			return
		end

		ProximityPrompt.Enabled = if SpeakingNPC.Parent then not SpeakingNPC:GetAttribute("DisableDialogue") else false
		NPC.EndSpeaking(LocalPlayer)
	end

	local function StartConversation(p1) --[[ StartConversation | Line: 180 | Upvalues: v2 (ref), v22 (ref), SpeakingNPC (copy), NPC (ref), LocalPlayer (copy), v3 (ref), ProximityPrompt (copy), IntroLines (copy), TopText (ref), EndConversation (copy), PromptList (copy), t (copy), OperationMap (copy), v4 (ref) ]]
		if v2 then
			return
		end

		if v22 then
			return
		end

		if not (if SpeakingNPC.Parent then not SpeakingNPC:GetAttribute("DisableDialogue") else false) then
			return
		end

		v22 = true
		SpeakingNPC:SetAttribute("ConversationStarted", true)
		v2 = true
		NPC.StartSpeaking(LocalPlayer)
		v3 = false
		ProximityPrompt.Enabled = false

		if p1.OnDialogueStarted then
			p1.OnDialogueStarted()
		end

		if IntroLines and p1.RandomIntroLine then
			TopText.NpcText(SpeakingNPC, IntroLines[Random.new():NextInteger(1, #IntroLines)], true)
			task.wait(0.5)
		elseif IntroLines then
			for v32, v42 in IntroLines do
				TopText.NpcText(SpeakingNPC, v42, true)
				task.wait(0.5)
			end
		end

		if not v22 or v3 then
			EndConversation(p1)

			return
		end

		if #PromptList > 0 then
			local v5 = TopText.ShowChoices(LocalPlayer, PromptList)
			local v6 = ""

			if not v22 or v3 then
				TopText.TakeAwayResponses(SpeakingNPC, LocalPlayer)
				TopText.RemovePlayerSideFrame(LocalPlayer)

				return
			end

			table.clear(t)

			for v7, v8 in v5 do
				local Frame = v8:FindFirstChild("Frame")

				if Frame then
					local ImageButton = Frame:FindFirstChild("ImageButton")

					if ImageButton then
						table.insert(t, ImageButton.MouseButton1Click:Connect(function() --[[ Line: 243 | Upvalues: v6 (ref), Frame (copy) ]]
							v6 = Frame.Frame.Text_Element:GetAttribute("Text")
						end))
					end
				end
			end

			local v10 = TopText.ConnectChoiceKeyboard(v5, function(p1) --[[ Line: 252 | Upvalues: v6 (ref), v5 (copy) ]]
				if v6 ~= "" then
					return
				end

				local v1 = v5[p1]
				local v2 = if v1 then v1:FindFirstChild("Frame") else v1

				if not v2 then
					return
				end

				local Text_Element = v2.Frame:FindFirstChild("Text_Element")

				if Text_Element then
					v6 = Text_Element:GetAttribute("Text") or ""
				end
			end)

			if v22 and not v3 then
				repeat
					if v6 ~= "" then
						for v11, v12 in t do
							v12:Disconnect()
						end

						v10()
						TopText.RemovePlayerSideFrame(LocalPlayer)

						if LocalPlayer.Character then
							TopText.PlayerResponse(LocalPlayer.Character, v6, true)

							local v13 = OperationMap[v6]

							if v13 then
								v4 = task.spawn(v13)

								repeat
									task.wait()
								until coroutine.status(v4) == "dead"
							end
						end

						EndConversation(p1)

						return
					end

					task.wait()
				until v3 or not v22

				for v14, v15 in t do
					v15:Disconnect()
				end
			else
				for v16, v17 in t do
					v17:Disconnect()
				end
			end

			table.clear(t)
			v10()
			TopText.TakeAwayResponses(SpeakingNPC, LocalPlayer)
			TopText.RemovePlayerSideFrame(LocalPlayer)

			return
		end

		EndConversation(p1)
	end

	local v5 = ProximityPrompt.Triggered:Connect(function(p1) --[[ Line: 303 | Upvalues: StartConversation (copy), p2 (copy) ]]
		StartConversation(p2)
	end)
	local v6 = ProximityPrompt.MaxActivationDistance + 1
	local v7 = SpeakingNPC.Destroying:Connect(function() --[[ Line: 310 | Upvalues: v22 (ref), v3 (ref), EndConversation (copy), p2 (copy) ]]
		if not v22 then
			return
		end

		v3 = true
		EndConversation(p2)
	end)
	local v8 = task.spawn(function() --[[ Line: 318 | Upvalues: SpeakingNPC (copy), v22 (ref), EndConversation (copy), p2 (copy), LocalPlayer (copy), v1 (copy), v6 (copy), TopText (ref), v7 (ref) ]]
		local v12 = false

		while SpeakingNPC.Parent do
			task.wait(0.1)

			if not v12 and v22 then
				if if SpeakingNPC.Parent then not SpeakingNPC:GetAttribute("DisableDialogue") else false then
					if SpeakingNPC:IsDescendantOf(workspace) then
						if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
							local v3 = nil

							if v1 and v1.Parent then
								if v1:IsA("BasePart") then
									v3 = v1.Position
								elseif v1:IsA("Attachment") then
									v3 = v1.WorldPosition
								elseif v1:IsA("Model") then
									v3 = v1:GetPivot().Position
								end
							end

							if v3 and not ((LocalPlayer.Character.PrimaryPart.Position - v3).Magnitude < v6) then
								if p2.ExitLine then
									if p2.RandomExitLine and typeof(p2.ExitLine) == "table" then
										TopText.NpcText(SpeakingNPC, p2.ExitLine[Random.new():NextInteger(1, #p2.ExitLine)], true)
									else
										TopText.NpcText(SpeakingNPC, p2.ExitLine, true)
									end

									v12 = false
								end

								EndConversation(p2)
							else
								continue
							end
						else
							continue
						end
					else
						EndConversation(p2)
					end

					continue
				end

				EndConversation(p2)
			end
		end

		if not v7 then
			return
		end

		v7:Disconnect()
	end)
	local v9 = ProximityPrompt.PromptShown:Connect(function() --[[ Line: 374 | Upvalues: SpeakingNPC (copy), DialogueHighlight (ref), tweenHighlightTransparency (ref) ]]
		if if SpeakingNPC.Parent then not SpeakingNPC:GetAttribute("DisableDialogue") else false then
			assert(DialogueHighlight:IsA("Highlight"))
			tweenHighlightTransparency(DialogueHighlight, 0)
		end
	end)
	local v10 = ProximityPrompt.PromptHidden:Connect(function() --[[ Line: 380 | Upvalues: DialogueHighlight (ref), tweenHighlightTransparency (ref) ]]
		assert(DialogueHighlight:IsA("Highlight"))
		tweenHighlightTransparency(DialogueHighlight, 1)
	end)

	return {
		End = function(p1) --[[ End | Line: 387 | Upvalues: v22 (ref), v3 (ref), EndConversation (copy), p2 (copy) ]]
			if not v22 then
				return
			end

			v3 = true
			EndConversation(p2)
		end,
		Destroy = function(p1) --[[ Destroy | Line: 395 | Upvalues: v22 (ref), v3 (ref), EndConversation (copy), p2 (copy), v7 (ref), v8 (ref), v9 (ref), v10 (ref), v5 (ref) ]]
			if v22 then
				v3 = true
				EndConversation(p2)
			end

			if v7 then
				v7:Disconnect()
				v7 = nil
			end

			if v8 then
				task.cancel(v8)
				v8 = nil
			end

			if v9 then
				v9:Disconnect()
				v9 = nil
			end

			if v10 then
				v10:Disconnect()
				v10 = nil
			end

			if not v5 then
				return
			end

			v5:Disconnect()
			v5 = nil
		end,
		IsActive = function(p1) --[[ IsActive | Line: 424 | Upvalues: v22 (ref) ]]
			return v22
		end
	}
end

return t2