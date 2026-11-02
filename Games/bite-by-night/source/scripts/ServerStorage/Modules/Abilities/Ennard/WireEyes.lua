local WireEyes = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Ennard/Shared');

-- <- Public Functions -> --
function WireEyes.Use(Player: Player, Character: Model, Configuration, AssetMeta)
	if not AbilityUtil.CanUseAbility(Character) or Shared.IsDisguised(Character) then
		return AbilityUtil.AbilityResult(false);
	end

	AbilityUtil.SetBusy(Character, 1.2);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 0.65);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'MinionSpawning');

	local SummonAnimation = Shared.GetBaseAsset(AssetMeta, 'Ennard_Spawn_Minion');
	Shared.BroadcastMove(true, Shared.GetMoveModule(AssetMeta, 'EnnardSummon'), {
		Character,
		SummonAnimation,
	});

	task.delay(0.65, function()
		if not Character.Parent then
			return
		end

		local Root = ServerUtil.GetRoot(Character);
		if not Root then
			return
		end

		Shared.SpawnMinion(Player, Character, AssetMeta, Shared.GetMinionSpawnCFrame(Root, -3, 5), 1);
		Shared.SpawnMinion(Player, Character, AssetMeta, Shared.GetMinionSpawnCFrame(Root, 3, 5), 2);
	end);

	return AbilityUtil.AbilityResult(true, Configuration.WireEyesCooldown or 15);
end


-- <- Return -> --
return WireEyes