local SkinStealer = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Ennard/Shared');

-- <- Public Functions -> --
function SkinStealer.Use(Character: Model, Configuration, AssetMeta)
	if not AbilityUtil.CanUseAbility(Character) or Shared.IsDisguised(Character) then
		return AbilityUtil.AbilityResult(false);
	end

	local SourceCharacter = Shared.GetDisguiseSource(Character);
	if not SourceCharacter or not SourceCharacter.Parent then
		return AbilityUtil.AbilityResult(false);
	end

	AbilityUtil.SetBusy(Character, 1.1);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 0.3);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Possessing');

	local StartAnimation = Shared.GetDisguiseAsset(AssetMeta, 'Disguise_Start') or Shared.GetBaseAsset(AssetMeta, 'Ennard_Posses')
	local VictimAnimation = Shared.GetDisguiseAsset(AssetMeta, 'Disguise_Victim') or Shared.GetBaseAsset(AssetMeta, 'Victim_Posses')
	local Track = ServerUtil.LoadAnimation(Character, StartAnimation);
	if Track then
		Track:Play();
	end

	Shared.BroadcastMove(true, Shared.GetMoveModule(AssetMeta, 'EnnardPosses'), {
		true,
		Character,
		Shared.GetPathPayload(SourceCharacter),
		StartAnimation,
		VictimAnimation,
	});

	Shared.StartDisguise(Character, Configuration, SourceCharacter);
	return AbilityUtil.AbilityResult(true, nil, {
		UseCooldown = false,
	});
end


-- <- Return -> --
return SkinStealer