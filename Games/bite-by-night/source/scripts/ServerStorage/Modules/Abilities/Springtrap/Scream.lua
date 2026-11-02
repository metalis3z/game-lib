local ScreamModule = {};

-- <- Services -> --
local Debris = game:GetService('Debris');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local VFXHandler = require('@game/ReplicatedStorage/Modules/VFXHandler');

-- <- Public Variables -> --
local AliveFolder = workspace.PLAYERS.ALIVE
local IgnoreFolder = workspace.IGNORE

-- <- Private Variables -> --
local ESPMove = ReplicatedStorage.Modules.Moves:FindFirstChild('ESP');

-- <- Private Functions -> --
local function GetBlindnessBasedOnDistance(CharacterA: Model, CharacterB: Model)
	local RootA = ServerUtil.GetRoot(CharacterA);
	local RootB = ServerUtil.GetRoot(CharacterB);
	if not RootA or not RootB then
		return 0
	end

	local Distance = (RootA.Position - RootB.Position).Magnitude
	return 1 - math.clamp(Distance / 50, 0, 1)
end

-- <- Public Functions -> --
function ScreamModule.Scream(Player: Player, AssetMeta)
	local Character = Player.Character
	if not Character or not AbilityUtil.CanUseAbility(Character) then
		return
	end

	local CurrentStamina = Character:GetAttribute('Stamina') or 0
	local MaxStamina = Character:GetAttribute('MaxStamina') or CurrentStamina or 70
	Character:SetAttribute('Stamina', math.min(MaxStamina, CurrentStamina + 25));

	AbilityUtil.SetBusy(Character, 1.8);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', 1.1);
	AbilityUtil.PlayAssetSound(AssetMeta, Character, 'ScreamSFX');

	local Effect = AssetMeta and AssetMeta:RequestAsset('screamVFX', true);
	if Effect then
		Effect.Parent = IgnoreFolder

		local Weld = Effect:FindFirstChild('Weld');
		local Root = ServerUtil.GetRoot(Character);
		if Weld and Root then
			Weld.Part0 = Root
		end

		Debris:AddItem(Effect, 8);
	end

	local function ReleaseScream()
		if Effect then
			VFXHandler.doEmitCount(Effect);
		end
		if ESPMove then
			ServerUtil.SendChange(Player, {
				'Module',
				ESPMove,
				'Activate',
			});
		end

		for _, Survivor in ipairs(AliveFolder:GetChildren()) do
			local Intensity = GetBlindnessBasedOnDistance(Survivor, Character);
			if Intensity > 0 then
				AbilityUtil.ApplyBlindness(Survivor, Intensity, 5);
			end
			AbilityUtil.ApplyDeafness(Survivor, 5);
		end
	end

	local Track = ServerUtil.LoadAnimation(Character, AssetMeta and AssetMeta:RequestAsset('Scream'));
	if Track then
		local Screamed = false
		Track:Play();
		Track:GetMarkerReachedSignal('Scream'):Once(function()
			Screamed = true
			ReleaseScream();
		end);
		Track:GetMarkerReachedSignal('End'):Once(function()
			Character:SetAttribute('Screamed', true);
		end);
		task.delay(math.max(0.6, Track.Length * 0.4), function()
			if not Screamed and Character.Parent then
				ReleaseScream();
			end
		end);
		task.delay(math.max(1.1, Track.Length), function()
			if Character.Parent then
				Character:SetAttribute('Screamed', true);
			end
		end);
	else
		task.delay(0.6, function()
			if Character.Parent then
				ReleaseScream();
				Character:SetAttribute('Screamed', true);
			end
		end);
	end
end

-- <- Return -> --
return ScreamModule