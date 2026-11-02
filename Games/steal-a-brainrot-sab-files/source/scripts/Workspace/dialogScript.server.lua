-- services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--modules
local DialogModule = require(ReplicatedStorage.DialogModule)

--references
local player = game.Players.LocalPlayer
local npc = script.Parent -- Reference to the NPC model
local npcGui = npc:WaitForChild("Head"):WaitForChild("gui")
local prompt = npc:WaitForChild("ProximityPrompt")

local dialogObject = DialogModule.new("Showcase NPC", npc, prompt)
dialogObject:addDialog("Salut ! Je suis le dev du jeux Comment Je peux t'aider", {"C'est quoi le serveur discord ?"})

--

-- what happens when triggered
prompt.Triggered:Connect(function(player)
	dialogObject:triggerDialog(player, 1)
end)

-- logic to go through dialogs
dialogObject.responded:Connect(function(responseNum, dialogNum)
	if dialogNum == 1 then
		if responseNum == 1 then
			dialogObject:hideGui("Le serveur discord est https://discord.gg/CbJUarCaJ !")
		end
	end
end)