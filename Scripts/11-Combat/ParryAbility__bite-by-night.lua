-- Reference copy for study. Game: bite-by-night
-- Original: ServerStorage/Modules/Abilities/Fighter/Parry.lua  (ModuleScript, 48 lines)
-- What it does: Opens a 0.8 s 'ParryWindow' attribute, roots you for 0.45 s, and if nothing was parried when it closes you get 'weakness' as a punishment.

local Parry = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local MissWeaknessDuration = 2

-- <- Public Functions -> --
function Parry.Use(Character: Model, Animator: Animator, AssetMeta, Configuration)
	if not Character or not Animator or not AssetMeta then
		return false
	end
	if Character:GetAttribute('ParryWindow') then
		return false
	end

	local Animation = AssetMeta:RequestAsset('Parry');
	if not Animation then
		return false
	end

	AbilityUtil.SetBusy(Character, 1);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 0.45);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'ParrySFX');
	AbilityUtil.ApplyTimedAttribute(Character, 'ParryWindow', true, 0.8, false);

	local Track = ServerUtil.LoadAnimation(Animator, Animation);
	if Track then
		Track:Play();
	end

	task.delay(0.8, function()
		if not Character.Parent or not Character:GetAttribute('ParryWindow') then
			return
		end

		Character:SetAttribute('ParryWindow', false);
		AbilityUtil.ApplyWeakness(Character, 1, Configuration and Configuration.ParryMissDuration or MissWeaknessDuration);
	end);

	return true
end


-- <- Return -> --
return Parry
