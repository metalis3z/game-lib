local SkinStealerExplode = {};

-- <- Services -> --
local Players = game:GetService('Players');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local Shared = require('@game/ServerStorage/Modules/Abilities/Ennard/Shared');

-- <- Public Functions -> --
function SkinStealerExplode.Use(Character: Model, Configuration, AssetMeta)
	if not Shared.IsDisguised(Character) then
		return AbilityUtil.AbilityResult(false);
	end

	local State = Shared.GetDisguiseState(Character);
	local SourceCharacter = State and State.Source
	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return AbilityUtil.AbilityResult(false);
	end

	AbilityUtil.SetBusy(Character, 0.95);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 0.35);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'Release');

	local ExplodeAnimation = Shared.GetBaseAsset(AssetMeta, 'Ennard_Explode');
	local VictimAnimation = Shared.GetBaseAsset(AssetMeta, 'Victim_Explode');
	local WireAnimation = Shared.GetBaseAsset(AssetMeta, 'Wire_Explode');
	local Track = ServerUtil.LoadAnimation(Character, ExplodeAnimation);
	if Track then
		Track:Play();
	end

	local WiresModel = Shared.GetBaseAsset(AssetMeta, 'Wires', true);
	if not WiresModel then
		local Fallback = ReplicatedStorage.Characters.Ennard.Normal.Assets:FindFirstChild('Wires');
		if Fallback then
			WiresModel = Fallback:Clone()
		end
	end
	if WiresModel then
		WiresModel.Name = string.format('%s_Wires', Character.Name)
		WiresModel.Parent = workspace.IGNORE
		WiresModel:PivotTo(Root.CFrame);
	end

	Shared.BroadcastMove(true, Shared.GetMoveModule(AssetMeta, 'EnnardExplode'), {
		Players:GetPlayers(),
		{Character},
		Shared.GetPathPayload(SourceCharacter),
		Shared.GetPathPayload(WiresModel),
		ExplodeAnimation,
		VictimAnimation,
		WireAnimation,
	});

	task.delay(0.35, function()
		if not Character.Parent then
			return
		end

		Shared.ClearDisguise(Character, Configuration);
		Shared.ExplodeAtPosition(Character, Root.Position, Configuration.Hitbox and Configuration.Hitbox.Explode or 12, Configuration.Damage and Configuration.Damage.Explode or 25);
		if WiresModel and WiresModel.Parent then
			task.delay(2, function()
				if WiresModel.Parent then
					WiresModel:Destroy();
				end
			end);
		end
	end);

	return AbilityUtil.AbilityResult(true, Configuration.ExplodeCooldown or 3);
end


-- <- Return -> --
return SkinStealerExplode