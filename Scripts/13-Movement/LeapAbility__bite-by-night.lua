-- Reference copy for study. Game: bite-by-night
-- Original: ServerStorage/Modules/Abilities/Mimic/Leap.lua  (ModuleScript, 90 lines)
-- What it does: Server ability: stop running, lock movement briefly, play the leap animation, dash toward the mouse after 0.18 s, then a landing slam damages everyone in a radius; returns its cooldown.

local Leap = {};

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Mimic/Shared');

-- <- Private Variables -> --
local MoveFolder = ReplicatedStorage.Modules.Moves
local LeapMove = MoveFolder:FindFirstChild('Lunge-Mimic');
local LandMove = MoveFolder:FindFirstChild('Lunge-Land-Mimic');

-- <- Public Functions -> --
function Leap.Use(Player: Player, Character: Model, Configuration, AssetMeta)
	if not AbilityUtil.CanUseAbility(Character) or Character:GetAttribute('MimicDrilling') then
		return AbilityUtil.AbilityResult(false);
	end
	if Shared.EnsureMode(Character, Configuration) ~= 'Speed' then
		return AbilityUtil.AbilityResult(false);
	end

	local Humanoid = ServerUtil.GetHumanoid(Character);
	local LeapAnimation = AbilityUtil.GetAsset(AssetMeta, 'Leap');
	local LandAnimation = AbilityUtil.GetAsset(AssetMeta, 'LeapLand');

	Character:SetAttribute('Running', false);
	AbilityUtil.SetBusy(Character, 1.15);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 0.28);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'LeapSFX');

	local LeapTrack = ServerUtil.LoadAnimation(Character, LeapAnimation);
	if LeapTrack then
		LeapTrack:Play();
	end
	if LeapMove then
		ServerUtil.SendMove(true, LeapMove, 'Activate', {Player, Character, LeapAnimation});
	end

	if Humanoid then
		Humanoid.AutoRotate = false
	end

	task.delay(0.18, function()
		if not Character.Parent then
			return
		end

		AbilityUtil.DashTowardMouse(Player, Character, 95, 0.28, Configuration.LeapRange or 32);
	end);

	task.delay(0.52, function()
		if not Character.Parent then
			return
		end
		if Humanoid and Humanoid.Parent then
			Humanoid.AutoRotate = true
		end

		local LandTrack = ServerUtil.LoadAnimation(Character, LandAnimation);
		if LandTrack then
			LandTrack:Play();
		end
		if LandMove then
			ServerUtil.SendMove(true, LandMove, 'Activate', {Player, Character, LandAnimation});
		end
		AbilityUtil.PlayAssetSound(AssetMeta, Character, 'GroundSlamSFX');

		for _, Target in ServerUtil.GetTargetsInRadius(Character, Configuration.Hitbox and Configuration.Hitbox.Jump or 12) do
			AbilityUtil.ApplyDamage(Character, Target, Configuration.Damage and Configuration.Damage.Jump or 25, {
				IgnoreParry = true,
				StunDuration = 1,
			});
		end
	end);

	task.delay(0.85, function()
		if Humanoid and Humanoid.Parent then
			Humanoid.AutoRotate = true
		end
	end);

	return AbilityUtil.AbilityResult(true, Configuration.LeapCooldown or 25);
end


-- <- Return -> --
return Leap
