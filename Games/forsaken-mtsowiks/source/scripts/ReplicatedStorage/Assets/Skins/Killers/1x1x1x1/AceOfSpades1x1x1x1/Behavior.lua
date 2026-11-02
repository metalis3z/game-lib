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
function v1.GetZombie(p3)
	local v4 = not p3.isRareZombieSpawned
	if v4 then
		v4 = math.random(100) == 1
	end
	local v5 = v4 and "SpecialZombieTemplate" or "ZombieTemplate"
	if v4 then
		p3.isRareZombieSpawned = true
	end
	return p3.Config[v5]:GetChildren()[math.random(#p3.Config[v5]:GetChildren())]:Clone()
end
return v1