local Debounce = false
local Distance = 26
local BlindAnim = game.ReplicatedStorage.ReplicatedAnimations.RakeBlindAnimation
local BlindPart = script.Parent.Light
while true do
	wait()
	if workspace.Blinded.Value == false then
		local MonsterTorso = workspace.The_Rake.Torso
		if (MonsterTorso.Position - BlindPart.Position).magnitude < Distance and Debounce == false then
			Debounce = true
			local Monster = workspace:FindFirstChild("The_Rake")
			local AddBlind = script.Blind:Clone()
			AddBlind.Parent = Monster
			AddBlind.Disabled = false
			workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 120
			wait(1)
			Debounce = false 
			end
	end
end