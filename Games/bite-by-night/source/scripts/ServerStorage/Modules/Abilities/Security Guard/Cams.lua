local Cams = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local AliveFolder = workspace.PLAYERS.ALIVE
local KillerFolder = workspace.PLAYERS.KILLER

-- <- Public Functions -> --
function Cams.Use(Player: Player, Character: Model, AssetMeta)
	if not Character or not AssetMeta then
		return false
	end

	AbilityUtil.SetBusy(Character, 3.8);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 3.2);

	local LocateAnimation = AssetMeta:RequestAsset('TabletLocate') or AssetMeta:RequestAsset('TabletEquip')
	local Track = ServerUtil.LoadAnimation(Character, LocateAnimation);
	if Track then
		Track:Play();
	end

	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Camera_Open');

	task.delay(0.25, function()
		if not Character.Parent then
			return
		end

		local Killer = ServerUtil.GetNearestTarget(Character, 9999, KillerFolder);
		if not Killer then
			return
		end

		local Disguised = Killer:GetAttribute('SkinStealer') or Killer:HasTag('Imitation')
		local CameraPart = AbilityUtil.GetClosestMapCamera(Killer) or ServerUtil.GetRoot(Killer)
		if CameraPart then
			AbilityUtil.PeekThroughCamera(Player, CameraPart, Killer, 3.2, true);
		end

		if not Disguised then
			for _, Survivor in AliveFolder:GetChildren() do
				local SurvivorPlayer = ServerUtil.GetPlayer(Survivor);
				if SurvivorPlayer then
					AbilityUtil.LocateForPlayer(SurvivorPlayer, Killer);
				end
			end
			AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Camera_Highlight');
		end
	end);

	task.delay(3.25, function()
		if not Character.Parent then
			return
		end

		AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Camera_Close');
		AbilityUtil.ClearBusy(Character);
	end);

	return true
end


-- <- Return -> --
return Cams