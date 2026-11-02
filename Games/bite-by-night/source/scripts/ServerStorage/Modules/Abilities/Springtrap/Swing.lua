local SwingModule = {};

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local HitboxManager = require('@game/ServerStorage/Modules/Managers/HitboxManager');
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');

-- <- Private Variables -> --
local KillsCutscenes = ReplicatedStorage.Modules.CutscenesFolder.Kills

-- <- Private Functions -> --
local function PlayCutscene(KillerPlayer: Player, KilledPlayer: Player?, AssetMeta, KilledModel: Model)
	local KillerModel = KillerPlayer.Character
	if not KillerModel or not KilledModel then
		return
	end

	local Axeless = KillerModel:GetAttribute('Axeless');
	local IsLMS = workspace.GAME.LMS.Value
	local CutscenePath = Axeless and KillsCutscenes.SpringtrapAxeless or (IsLMS and KillsCutscenes.SpringtrapLMS or KillsCutscenes.Springtrap)
	local KillerAnimation = AssetMeta and AssetMeta:RequestAsset(Axeless and 'SwingKill AXELESS' or (IsLMS and 'SwingKillLMS' or 'SwingKill'));
	local VictimAnimation = AssetMeta and AssetMeta:RequestAsset(Axeless and 'SwingKillEnemy AXELESS' or (IsLMS and 'SwingKillEnemyLMS' or 'SwingKillEnemy'));
	if not CutscenePath or not KillerAnimation or not VictimAnimation then
		return
	end

	ServerUtil.SendChange(KillerPlayer, {
		'Module',
		CutscenePath,
		'Activate',
		{
			{
				KilledModel,
				KillerModel,
			},
			KillerAnimation,
		},
	});

	if KilledPlayer then
		ServerUtil.SendChange(KilledPlayer, {
			'Module',
			CutscenePath,
			'Activate',
			{
				{
					KilledModel,
					KillerModel,
				},
				VictimAnimation,
			},
		});
	end
end

-- <- Public Functions -> --
function SwingModule.Swing(Player: Player, CharacterMeta, AssetMeta)
	local Character = Player.Character
	if not Character or not CharacterMeta or not CharacterMeta.Configuration then
		return
	end
	if not AbilityUtil.CanUseAbility(Character) then
		return
	end

	local Axeless = Character:GetAttribute('Axeless') and true or false
	local MoveName = Axeless and 'SwingAxeless' or 'Swing'
	local AnimationName = Axeless and 'AxelessSwing' or 'Swing'
	local SoundName = Axeless and 'axelessSwing' or 'SwingSFX'
	local Damage = CharacterMeta.Configuration.Damage and CharacterMeta.Configuration.Damage[MoveName] or 0

	AbilityUtil.SetBusy(Character, 0.85);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, SoundName);

	local Track = ServerUtil.LoadAnimation(Character, AssetMeta and AssetMeta:RequestAsset(AnimationName));
	if Track then
		Track:Play();
	end

	if Axeless then
		AbilityUtil.DashTowardMouse(Player, Character, 36, 0.12, 18);
	end

	task.delay(0.12, function()
		if not Character.Parent then
			return
		end

		local Hitbox = HitboxManager.new(Character, CharacterMeta.Configuration, MoveName, {
			ContinueUntilFind = true,
			ContinueTimeout = 0.18,
			PollInterval = 0.03,
			SortByDistance = true,
		});
		if not Hitbox then
			return
		end

		local Target = Hitbox:Activate();
		if typeof(Target) == 'table' then
			Target = Target[1]
		end
		if not Target then
			return
		end

		local AppliedDamage = Target:GetAttribute('ChargeRagdolled') and 5 or Damage
		local Result = AbilityUtil.ApplyDamage(Character, Target, AppliedDamage, {});
		if Result.Died then
			PlayCutscene(Player, ServerUtil.GetPlayer(Target), AssetMeta, Target);
		end
	end);
end

-- <- Return -> --
return SwingModule