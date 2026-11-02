local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")

local player = Players.LocalPlayer
local GROUP_ID = 286964047

print("=== SCRIPT GROUPE DEMARRE ===")

task.wait(5)

while true do

	local success, isMember = pcall(function()
		return player:IsInGroup(GROUP_ID)
	end)

	if not success then
		warn("Erreur IsInGroup :", isMember)
	else
		print("Dans le groupe :", isMember)

		if not isMember then

			print("Tentative du vrai prompt Roblox...")

			local promptSuccess, result = pcall(function()
				return GroupService:PromptJoinAsync(GROUP_ID)
			end)

			print("PromptSuccess :", promptSuccess)
			print("PromptResult :", result)

		else
			print("Joueur déjà dans le groupe -> aucun prompt")
		end
	end

	task.wait(5)
end