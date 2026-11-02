local currentRig
local currentActor
local chatcommands = require(game.ServerScriptService.Server.Systems.Core.PlayerManager.ChatCommands)
local statuses = require(game.ReplicatedStorage.Modules.Statuses)
local progress = 0

script.Parent.ProximityPrompt.Triggered:Connect(function(Player)
	if (not currentRig) or currentRig.Parent == nil then
		local fakePlayer, fakeActor = chatcommands["!actor"](Player, "Noli", "Killer", 1)
		fakePlayer.Character:PivotTo(script.HumanoidRootPart.CFrame)
		currentRig = fakePlayer.Character
		currentActor = fakeActor
	else
		local v64 = statuses:PlayerHasStatus(Player, "Hallucination");
		statuses:ApplyStatus(Player, "Hallucination", {
			Level = math.clamp((v64 and v64.Level or 0) + (progress >= 100 and 3 or 1), 1, 3), 
			Duration = 15, 
			Killer = currentActor
		})
		if progress > 100 then
			progress = 0
		else
			progress += 26
		end
	end
end)