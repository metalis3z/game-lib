local Quests = {}; do
	local Remotes = game.ReplicatedStorage.Remotes
	local Data = require(script.Parent.Data)
	local DataModifier = require(game.ServerScriptService.Functions.DataModifier)
	local Quests = game.ReplicatedStorage.Modules.Quests

	local function Complete(Player: Player, Type: string, Progress: {})
		local PlayerData = Data:Get(Player)
		for NPC, NPCData in PlayerData.Quests do
			if NPCData.Claimed and not NPCData.Completed then
				local QuestInfo = require(Quests[NPC][NPCData.Quest])
				for Index, Task in NPCData.Tasks do
					local TaskInfo = QuestInfo.Tasks[Index]
					if(TaskInfo == nil) then
						warn(" ")
						warn(" Quests|> TaskInfo is nil! Plese report this to developers")
						warn("discord.gg/DYvgxu95")
						warn(" ")
						continue;
					end
					local CollectDetection = {
						Tool = true,
						Bee = true
					}
					local function GetAnyString()
						if Progress.Bee ~= nil then
							return "Any Bee"
						else
							return "Any Tool"
						end
					end

					if TaskInfo.Type == Type then
						if Type == "CollectPollen" then
							--if not HasProhibitedItem(TaskInfo) then
							if not TaskInfo.Color and not TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress.White + Progress.Red + Progress.Blue)
							elseif TaskInfo.Color and not TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress[TaskInfo.Color] or 0)
							elseif not TaskInfo.Color and TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress.Field == TaskInfo.Field and (Progress.White + Progress.Red + Progress.Blue) or 0)
							elseif TaskInfo.Color and TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress.Field == TaskInfo.Field and Progress[TaskInfo.Color] or 0)
							end
							--end
						elseif Type == "CollectPollenFrom" then
							for TaskDetectionName,TaskDetection in pairs(CollectDetection) do
								if TaskDetection == true then
									if not TaskInfo.Color and not TaskInfo.Field and TaskInfo[TaskDetectionName] and Progress[TaskDetectionName] ~= nil then
										NPCData.Tasks[Index] += (((Progress[TaskDetectionName] == TaskInfo[TaskDetectionName]) or (GetAnyString() == TaskInfo[TaskDetectionName])) and (Progress.White + Progress.Red + Progress.Blue) or 0)
									elseif TaskInfo.Color and not TaskInfo.Field and TaskInfo[TaskDetectionName] and Progress[TaskDetectionName] ~= nil then
										NPCData.Tasks[Index] += (((Progress[TaskDetectionName] == TaskInfo[TaskDetectionName]) or (GetAnyString() == TaskInfo[TaskDetectionName])) and Progress[TaskInfo.Color] or 0)
									elseif not TaskInfo.Color and TaskInfo.Field and TaskInfo[TaskDetectionName] and Progress[TaskDetectionName] ~= nil then
										NPCData.Tasks[Index] += ((((Progress[TaskDetectionName] == TaskInfo[TaskDetectionName]) or (GetAnyString() == TaskInfo[TaskDetectionName])) and Progress.Field == TaskInfo.Field) and (Progress.White + Progress.Red + Progress.Blue) or 0)
									elseif TaskInfo.Color and TaskInfo.Field and TaskInfo[TaskDetectionName] and Progress[TaskDetectionName] ~= nil then
										NPCData.Tasks[Index] += ((((Progress[TaskDetectionName] == TaskInfo[TaskDetectionName]) or (GetAnyString() == TaskInfo[TaskDetectionName])) and Progress.Field == TaskInfo.Field) and Progress[TaskInfo.Color] or 0)
									end
								end
							end
						elseif Type == "ConvertPollen" then
							if TaskInfo.Bee then
								NPCData.Tasks[Index] += ((Progress.Bee == TaskInfo.Bee) and (Progress.Amount or 1) or 0)
							else
								NPCData.Tasks[Index] += Progress.Amount
							end
						elseif Type == "UseItem" then
							if TaskInfo.Item and TaskInfo.Field then
								NPCData.Tasks[Index] += ((Progress.Field == TaskInfo.Field and Progress.Item == TaskInfo.Item) and (Progress.Amount or 1) or 0)
							elseif TaskInfo.Item and not TaskInfo.Field and not Progress.Field then
								NPCData.Tasks[Index] += (Progress.Item == TaskInfo.Item and (Progress.Amount or 1) or 0)
							else
								NPCData.Tasks[Index] += Progress.Amount or 0
							end
						elseif Type == "CollectToken" then
							if TaskInfo.Token and TaskInfo.Bee then
								NPCData.Tasks[Index] += ((Progress.Token == TaskInfo.Token and Progress.Bee == TaskInfo.Bee) and 1 or 0)
							elseif TaskInfo.Token then
								NPCData.Tasks[Index] += (Progress.Token == TaskInfo.Token and 1 or 0)
							else
								NPCData.Tasks[Index] += 1
							end
						end
					end
					if NPCData.Tasks[Index] > TaskInfo.Amount then
						NPCData.Tasks[Index] = TaskInfo.Amount
					end
				end

				local Completed = 0
				for Index, Task in NPCData.Tasks do
					local TaskInfo = QuestInfo.Tasks[Index]
					if Task == TaskInfo.Amount then
						Completed += 1
					end
				end
				if Completed == #NPCData.Tasks then
					NPCData.Completed = true
				end
				Remotes.DataUpdated:FireClient(Player, {"Quests", NPC, PlayerData.Quests[NPC]})
			end
		end
	end

	local function Claim(Player: Player, QuestGiver: string)
		local PData = Data:Get(Player)
		local QuestsFolder = Quests:FindFirstChild(QuestGiver)
		if not QuestsFolder then return end
		if not PData.Quests[QuestGiver].Claimed and not PData.Quests[QuestGiver].Completed then
			local QuestData = QuestsFolder:FindFirstChild(PData.Quests[QuestGiver].Quest)
			if not QuestData then
				return warn("All quests completed!")
			end
			QuestData = require(QuestData)
			for i, Task in QuestData.Tasks do
				PData.Quests[QuestGiver].Tasks[i] = 0
			end
			PData.Quests[QuestGiver].Claimed = true
			Remotes.DataUpdated:FireClient(Player, {"Quests",  QuestGiver, PData.Quests[QuestGiver]})
		elseif PData.Quests[QuestGiver].Claimed and PData.Quests[QuestGiver].Completed then
			local QuestData = require(QuestsFolder[PData.Quests[QuestGiver].Quest])

			-- rewards

			for _, Reward in QuestData.Rewards do
				if Reward.Type == "Item" then
					DataModifier.InventoryChange(Player, {"+", Reward.Amount, Reward.Name, "from Quest", true})
				elseif Reward.Type == "Currency" then
					DataModifier.IStatsChange(Player, {"+", Reward.Amount, Reward.Name, "from Quest", true})
				end
			end

			PData.Quests[QuestGiver].Claimed = false
			PData.Quests[QuestGiver].Completed = false
			PData.Quests[QuestGiver].Tasks = {}
			PData.Quests[QuestGiver].Quest += 1
			PData.Badges.Quests.Amount += 1
			Remotes.DataUpdated:FireClient(Player, {"Badges", "Quests", PData.Badges.Quests})
			Remotes.DataUpdated:FireClient(Player, {"Quests", QuestGiver, PData.Quests[QuestGiver]})
		end
	end

	Remotes.ClaimQuest.OnServerEvent:Connect(Claim)
	_G.CompleteQuest = Complete
end

return Quests