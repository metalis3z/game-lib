local SelfHeal = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Functions -> --
local function StopTrack(Track)
	if Track then
		Track:Stop();
	end
end


-- <- Public Functions -> --
function SelfHeal.Use(Character: Model, Humanoid: Humanoid, Animator: Animator, AssetMeta, Configuration)
	if not Character or not Humanoid or not Animator or not AssetMeta or not Configuration then
		return false
	elseif Humanoid.Health <= 0 then
		return false
	end

	local BaseMaxHealth = Character:GetAttribute('BaseMaxHealth') or Humanoid.MaxHealth
	if Humanoid.Health >= BaseMaxHealth then
		return false
	end

	local SelfHealTicks = Configuration.SelfHealTicks or 8
	local TickRate = math.max(0.35, Configuration.SelfHealRate or 1);
	local TotalDuration = TickRate * SelfHealTicks
	local LastHealth = Humanoid.Health

	Character:SetAttribute('Running', false);
	AbilityUtil.SetBusy(Character, TotalDuration + 0.5);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', TotalDuration);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SelfHead_Start_SFX');

	local StartTrack = ServerUtil.LoadAnimation(Animator, AssetMeta:RequestAsset('SelfHeal_Start'));
	local LoopTrack = ServerUtil.LoadAnimation(Animator, AssetMeta:RequestAsset('SelfHeal_Loop'));
	local EndTrack = ServerUtil.LoadAnimation(Animator, AssetMeta:RequestAsset('SelfHeal_End'));
	if StartTrack then
		StartTrack:Play();
	end

	task.spawn(function()
		task.wait(0.35);
		if LoopTrack then
			LoopTrack:Play();
		end
		AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SelfHead_Loop_SFX');

		for _ = 1, SelfHealTicks do
			if not Character.Parent or Humanoid.Health <= 0 then
				break
			elseif Humanoid.Health < LastHealth then
				break
			elseif Humanoid.Health >= BaseMaxHealth then
				break
			end

			AbilityUtil.HealCharacter(Character, Configuration.SelfHeal or 5, 0);
			LastHealth = Humanoid.Health
			task.wait(TickRate);
		end

		StopTrack(LoopTrack);
		AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SelfHead_End_SFX');
		if EndTrack then
			EndTrack:Play();
		end
		AbilityUtil.ClearBusy(Character);
	end);

	return true
end


-- <- Return -> --
return SelfHeal