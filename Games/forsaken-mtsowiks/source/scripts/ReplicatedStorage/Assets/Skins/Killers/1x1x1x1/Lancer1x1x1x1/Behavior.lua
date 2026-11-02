-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
require(game.ReplicatedStorage.Modules.Sounds)
require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.Network)
function v1.SummonZombie(_, p2)
	if p2 then
		if p2.PrimaryPart then
			if not p2.PrimaryPart:FindFirstChild("Radius") then
				return
			end
			p2.PrimaryPart.Radius:Play()
		end
	end
end
return v1