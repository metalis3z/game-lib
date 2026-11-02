-- Reference copy for study. Game: bite-by-night
-- Original: ServerStorage/Modules/Abilities/Fighter/Swing.lua  (ModuleScript, 94 lines)
-- What it does: Spends stored parry charges, dashes toward the mouse, opens a hitbox that keeps polling for 0.2 s, stuns the target, and applies extra slow / daze / confusion depending on how many charges were spent.

local Swing = {};

-- <- Modules -> --
local HitboxManager = require('@game/ServerStorage/Modules/Managers/HitboxManager');
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local KillerFolder = workspace.PLAYERS.KILLER

-- <- Private Functions -> --
local function ApplyChargeEffects(TargetCharacter: Model, Charges: number, Configuration)
	local ChargeEffectDuration = Configuration.ChargeEffectDuration or 6
	local ChargeSlowSpeed = Configuration.ChargeSlowSpeed or 10

	if Charges >= 1 then
		AbilityUtil.ApplyCustomSpeed(TargetCharacter, ChargeSlowSpeed, ChargeEffectDuration);
	end
	if Charges >= 2 then
		AbilityUtil.ApplyDazed(TargetCharacter, ChargeEffectDuration);
	end
	if Charges >= 3 then
		AbilityUtil.ApplyTimedTag(TargetCharacter, 'Confusion', ChargeEffectDuration);
	end
end


-- <- Public Functions -> --
function Swing.Use(Character: Model, Animator: Animator, AssetMeta, Configuration)
	if not Character or not Animator or not AssetMeta or not Configuration then
		return false
	end

	local ChargesMax = Character:GetAttribute('ParryChargesMax') or Configuration.ParryChargesMax or 3
	local Charges = math.clamp(Character:GetAttribute('ParryCharges') or 0, 0, ChargesMax);
	if Charges <= 0 then
		return false
	end

	local Animation = AssetMeta:RequestAsset('Swing');
	if not Animation then
		return false
	end

	Character:SetAttribute('ParryCharges', 0);
	AbilityUtil.SetBusy(Character, 1.05);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'SwingSFX');

	local Track = ServerUtil.LoadAnimation(Animator, Animation);
	if Track then
		Track:Play();
	end

	AbilityUtil.DashTowardMouse(ServerUtil.GetPlayer(Character), Character, Character:GetAttribute('SwingSpeed') or Configuration.SwingSpeed or 16, 0.12, 18);

	task.delay(0.1, function()
		if not Character.Parent then
			return
		end

		local Hitbox = HitboxManager.new(Character, Configuration, 'Swing', {
			TargetFolder = KillerFolder,
			ContinueUntilFind = true,
			ContinueTimeout = 0.2,
			PollInterval = 0.03,
			DebugLifetime = 0.08,
			SortByDistance = true,
		});
		if not Hitbox then
			return
		end

		local HitModel = Hitbox:Activate();
		if typeof(HitModel) == 'table' then
			HitModel = HitModel[1]
		end
		if not HitModel then
			return
		end

		local Result = AbilityUtil.ApplyDamage(Character, HitModel, 0, {
			StunDuration = Configuration.SwingStun or 5,
		});
		if Result.Hit and not Result.Parried and Result.Target then
			ApplyChargeEffects(Result.Target, Charges, Configuration);
		end
	end);

	return true
end


-- <- Return -> --
return Swing
