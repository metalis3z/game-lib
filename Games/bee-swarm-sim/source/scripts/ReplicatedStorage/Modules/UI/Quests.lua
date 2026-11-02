local Quests = {}; do
	local TweenService = game:GetService("TweenService")
	local Remotes = game.ReplicatedStorage.Remotes
	local Player = game.Players.LocalPlayer
	local UI = Player.PlayerGui:WaitForChild("UI")
	local DialogueFrame = UI.Dialogue
	local QuestsMenu = UI.Tabs.Quests
	local Camera = workspace.CurrentCamera
	local Utils = require(game.ReplicatedStorage.Modules.Utils)
	local Controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	Quests.Talking = false

	local function GetTaskName(Task: {})
		if Task.Type == "CollectPollen" then
			return string.format("Collect %s%s Pollen%s", Task.Amount, Task.Color and " "..Task.Color or "", Task.Field and " from "..Task.Field.." Field" or "")
		elseif Task.Type == "CollectPollenFrom" then
			return string.format("Collect %s%s Pollen%s%s%s", Task.Amount, Task.Color and " "..Task.Color or "", Task.Field and " from "..Task.Field.." Field" or "", Task.Tool == "Any Tool" and " with "..Task.Tool or "", Task.Bee == "Any Bee" and " with "..Task.Bee.."s" or Task.Bee and " with "..Task.Bee.." Bees" or "")
		elseif Task.Type == "ConvertPollen" then
			return string.format("Convert %s Pollen %s", Task.Amount, Task.Bee and "from "..Task.Bee.." Bee" or "")
		elseif Task.Type == "UseItem" then
			return string.format("Use %s %s time%s %s", Task.Item or "Any Item", Task.Amount, Task.Amount ~= 1 and "s" or "", Task.Field and " in "..Task.Field.." Field" or "")
		elseif Task.Type == "CollectToken" then
			return string.format("Collect %s%s Token%s%s", Task.Amount, " "..Task.Token or "", Task.Amount ~= 1 and "s" or "", Task.Bee and " from "..Task.Bee.." Bee" or "")
		end
		return "Unknown Task"
	end

	local function GetNPCIcon(NPC: string): string
		local Table = {
			--["Black Bear"] = "",
		}
		return Table[NPC] or "rbxassetid://18190727850"
	end

	function Quests.Update(NPC: string)
		local PlayerData = _G.PData

		-- Remove Quest
		if not PlayerData.Quests[NPC].Claimed then
			local PreviousQuest = require(game.ReplicatedStorage.Modules.Quests[NPC][PlayerData.Quests[NPC].Quest - 1])
			local QuestFrame = QuestsMenu.Icon.List:FindFirstChild(PreviousQuest.Quest)
			if QuestFrame then
				QuestFrame:Destroy()
			end
			if #QuestsMenu.Icon.List:GetChildren() - 1 == 0 then
				QuestsMenu.Icon.NoQuests.Visible = true
			end
			return
		end

		-- Create and Update Quest

		local QuestData = game.ReplicatedStorage.Modules.Quests:FindFirstChild(NPC):FindFirstChild(PlayerData.Quests[NPC].Quest)
		if not QuestData then
			return
		end
		QuestData = require(QuestData)

		local QuestFrame = QuestsMenu.Icon.List:FindFirstChild(QuestData.Quest)
		QuestsMenu.Icon.NoQuests.Visible = false
		if not QuestFrame then
			QuestFrame = UI.Client.Quest:Clone()
			QuestFrame.Name = QuestData.Quest
			QuestFrame.QName.Text = QuestData.Quest
			QuestFrame.NPC.Image = GetNPCIcon(NPC)
			QuestFrame.Parent = QuestsMenu.Icon.List
			for Index, Task in QuestData.Tasks do
				local TaskFrame = UI.Client.Task:Clone()
				TaskFrame.Name = Index
				TaskFrame.LayoutOrder = Index
				TaskFrame.QName.Text = GetTaskName(Task)
				TaskFrame.Parent = QuestFrame.Tasks
			end
		end

		for Index, Task  in QuestData.Tasks do
			local TaskFrame = QuestFrame.Tasks:FindFirstChild(Index)
			if TaskFrame then
				local function Truncate(x)
					return x-x%0.01
				end
				TaskFrame.Bar.Amount.Text = string.format("%s / %s", Utils:CommaNumber(math.round(PlayerData.Quests[NPC].Tasks[Index]) or 0), Utils:CommaNumber(math.round(Task.Amount)))
				TaskFrame.Bar.Amount.Amount.Text = TaskFrame.Bar.Amount.Text
				TaskFrame.Bar.Percentage.Text = string.format("%s", Truncate((math.round(PlayerData.Quests[NPC].Tasks[Index]) or 0) / math.round(Task.Amount)) < 100 and (Truncate((math.round(PlayerData.Quests[NPC].Tasks[Index]) or 0) / (math.round(Task.Amount)))*100).."%" or "Completed!" )
				TaskFrame.Bar.Percentage.Percentage.Text = TaskFrame.Bar.Percentage.Text
				TweenService:Create(TaskFrame.Bar.Fill, TweenInfo.new(0.2), {
					Size = UDim2.fromScale(PlayerData.Quests[NPC].Tasks[Index] / Task.Amount, 1)
				}):Play()
			end
		end
	end

	-- Dialogues

	local function AnimateText(Text: string)
		DialogueFrame.TextLabel.MaxVisibleGraphemes = 0
		DialogueFrame.TextLabel.TextLabel.MaxVisibleGraphemes = 0
		DialogueFrame.TextLabel.Text = Text
		DialogueFrame.TextLabel.TextLabel.Text = Text
		for i = 1, string.len(Text) do
			if DialogueFrame.TextLabel.Text ~= Text and DialogueFrame.TextLabel.TextLabel.Text ~= Text then
				break
			end
			DialogueFrame.TextLabel.MaxVisibleGraphemes = i
			DialogueFrame.TextLabel.TextLabel.MaxVisibleGraphemes = i
			task.wait(0.01)
		end
		DialogueFrame.TextLabel.MaxVisibleGraphemes = -1
		DialogueFrame.TextLabel.TextLabel.MaxVisibleGraphemes = -1
	end

	local function GetQuestType(NPC: string)
		local PlayerData = _G.PData
		if not PlayerData.Quests[NPC].Claimed then
			return "Start"
		elseif PlayerData.Quests[NPC].Claimed and not PlayerData.Quests[NPC].Completed then
			return "During"
		else
			return "Finish"
		end
	end

	local function FinishDialogue(NPC: string)
		TweenService:Create(DialogueFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			Position = UDim2.new(0.5, 0, 1.5, 0)
		}):Play()
		TweenService:Create(UI.Hotbar, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = UDim2.fromScale(0.5, 0.97)
		}):Play()
		Camera.CameraType = Enum.CameraType.Custom
		Controls:Enable()
		Quests.Talking = false

		Remotes.ClaimQuest:FireServer(NPC)
	end

	function Quests.StartDialogue(NPC: string)
		local PlayerData = _G.PData
		local QuestGiverData = game.ReplicatedStorage.Modules.Quests[NPC]
		local QuestData = QuestGiverData:FindFirstChild(PlayerData.Quests[NPC].Quest)
		if QuestData then
			QuestData = require(QuestData)
		end
		local Dialogue = {}
		if not QuestData then
			Dialogue = {"I don't have more quests right now!", "Return latter to claim quest"}
		else
			Dialogue = QuestData.Dialogues[GetQuestType(NPC)]
			--Dialogue = require(QuestGiverData[PlayerData.Quests[NPC].Quest]).Dialogue
		end

		TweenService:Create(DialogueFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5,0,1,0)
		}):Play()
		Camera.CameraType = Enum.CameraType.Scriptable
		TweenService:Create(Camera, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = CFrame.new(workspace.Quests[NPC].Camera.View.WorldPosition, workspace.Quests[NPC].Camera.Position)
		}):Play()
		TweenService:Create(UI.Hotbar, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			Position = UDim2.fromScale(0.5, 1.5)
		}):Play()
		Controls:Disable()
		Quests.Talking = true
		local ClickConnection = nil
		local SkipConnection = nil

		local Index = 1
		--DialogueFrame.TextLabel.Text = Dialogue[Index]

		SkipConnection = DialogueFrame.Skip.MouseButton1Click:Connect(function()
			SkipConnection:Disconnect()
			if ClickConnection then
				ClickConnection:Disconnect()
			end
			FinishDialogue(NPC)
		end)

		AnimateText(Dialogue[1])

		ClickConnection = game.UserInputService.InputBegan:Connect(function(input, gpe)
			if not gpe and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				if DialogueFrame.TextLabel.MaxVisibleGraphemes == -1 then
					Index = Index + 1
					if not Dialogue[Index] then
						ClickConnection:Disconnect()
						FinishDialogue(NPC)
						if SkipConnection then
							SkipConnection:Disconnect()
						end
					else
						AnimateText(Dialogue[Index])
					end
				end
			end
		end)
	end
end

return Quests