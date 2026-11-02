local SkinStealerThrow = {};

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Ennard/Shared');

-- <- Public Functions -> --
function SkinStealerThrow.Use(Player: Player, Character: Model, Configuration, AssetMeta)
	if not Shared.IsDisguised(Character) or not AbilityUtil.CanUseAbility(Character) then
		return AbilityUtil.AbilityResult(false);
	end

	local DisguiseConfiguration = Shared.GetDisguiseConfiguration();
	AbilityUtil.SetBusy(Character, 0.9);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Release');

	local ThrowAnimation = Shared.GetDisguiseAsset(AssetMeta, 'Disguise_Throw');
	local ProjectileAnimation = Shared.GetDisguiseAsset(AssetMeta, 'Disguise_Throw_Minion');
	local ThrowTrack = ServerUtil.LoadAnimation(Character, ThrowAnimation);
	if ThrowTrack then
		ThrowTrack:Play();
	end

	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return AbilityUtil.AbilityResult(false);
	end

	local ThrowRange = 35
	local AimPosition = ServerUtil.GetMousePosition(Player, Root.Position, ThrowRange, 0.15)
	local ThrowDirection = AimPosition and (AimPosition - Root.Position)
	if not ThrowDirection or ThrowDirection.Magnitude <= 0.1 then
		ThrowDirection = Root.CFrame.LookVector * ThrowRange
	end
	local LandingPosition = Root.Position + ThrowDirection.Unit * math.min(ThrowDirection.Magnitude, ThrowRange)

	local Projectile = Shared.GetBaseAsset(AssetMeta, 'Minion_Projectile', true);
	if not Projectile then
		local Fallback = ReplicatedStorage.Characters.Ennard.Normal.Assets:FindFirstChild('Minion_Projectile');
		if Fallback then
			Projectile = Fallback:Clone()
		end
	end
	if Projectile then
		Projectile.Name = string.format('%s_DisguiseThrow', Player.Name)
		Projectile.Parent = workspace.IGNORE
		Projectile:PivotTo(CFrame.lookAt(Root.Position + Vector3.new(0, 1.25, 0), LandingPosition));
		Shared.BroadcastMove(true, Shared.GetMoveModule(AssetMeta, 'EnnardMinionThrow'), {
			Character,
			Shared.GetPathPayload(Projectile),
			ThrowAnimation,
			ProjectileAnimation,
		});
		task.delay(1.2, function()
			if Projectile and Projectile.Parent then
				Projectile:Destroy();
			end
		end);
	end

	local TargetCharacter = Shared.GetForwardTarget(Character, ThrowRange, 0.45);
	if TargetCharacter then
		local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
		if TargetRoot then
			local Result = AbilityUtil.ApplyDamage(Character, TargetCharacter, DisguiseConfiguration.Damage and DisguiseConfiguration.Damage.Explode or 25, {
				IgnoreParry = true,
				StunDuration = 1,
			});
			if Result.Died then
				Shared.RegisterDisguise(Character, TargetCharacter);
			end
			Shared.ExplodeAtPosition(Character, TargetRoot.Position, DisguiseConfiguration.Hitbox and DisguiseConfiguration.Hitbox['Minion Throw'] or 5, 0);
		end
	else
		task.delay(0.9, function()
			if not Character.Parent then
				return
			end

			Shared.SpawnMinion(Player, Character, AssetMeta, LandingPosition, 3);
		end);
	end

	return AbilityUtil.AbilityResult(true, Configuration.ThrowCooldown or 15);
end


-- <- Return -> --
return SkinStealerThrow