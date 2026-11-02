local AbilityUtil = {};

-- <- Services -> --
local Players = game:GetService('Players');
local Debris = game:GetService('Debris');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local AssetManager = require('@game/ServerStorage/Modules/Managers/AssetManager');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local VFXHandler = require('@game/ReplicatedStorage/Modules/VFXHandler');

-- <- Public Variables -> --
local AliveFolder = workspace.PLAYERS.ALIVE
local KillerFolder = workspace.PLAYERS.KILLER
local GameMapFolder = workspace.MAPS['GAME MAP']

-- <- Private Variables -> --
local LocateModule = ReplicatedStorage.Modules.Moves.Locate
local BlindnessModule = ReplicatedStorage.Modules.BlindnessModule
local DeafnessModule = ReplicatedStorage.Modules.DeafnessModule

local TimedTags = setmetatable({}, {__mode = 'k'});
local TimedAttributes = setmetatable({}, {__mode = 'k'});

-- <- Private Functions -> --
local function GetBucket(Store, Key)
	local Bucket = Store[Key]
	if not Bucket then
		Bucket = {}
		Store[Key] = Bucket
	end

	return Bucket
end

local function NextToken(Store, Key, Entry)
	local Bucket = GetBucket(Store, Key);
	Bucket[Entry] = (Bucket[Entry] or 0) + 1

	return Bucket[Entry]
end

local function GetFlatDirection(Direction)
	if typeof(Direction) ~= 'Vector3' then
		return nil
	end

	local FlatDirection = Vector3.new(Direction.X, 0, Direction.Z);
	if FlatDirection.Magnitude <= 0.001 then
		return nil
	end

	return FlatDirection.Unit
end

-- <- Public Functions -> --
function AbilityUtil.AbilityResult(Success: boolean?, Cooldown: number?, Information: {}?)
	local ReturnInformation = Information or {}
	ReturnInformation.Success = Success ~= false
	if Cooldown ~= nil then
		ReturnInformation.Cooldown = Cooldown
	end

	return ReturnInformation
end

function AbilityUtil.GetCharacter(Target)
	return ServerUtil.GetCharacter(Target)
end

function AbilityUtil.GetPlayer(Target)
	return ServerUtil.GetPlayer(Target)
end

function AbilityUtil.GetHumanoid(Target)
	return ServerUtil.GetHumanoid(Target)
end

function AbilityUtil.GetRoot(Target)
	return ServerUtil.GetRoot(Target)
end

function AbilityUtil.GetAnimator(Target)
	return ServerUtil.GetAnimator(Target)
end

function AbilityUtil.GetMousePosition(Player, Origin, MaximumDistance, Timeout)
	return ServerUtil.GetMousePosition(Player, Origin, MaximumDistance, Timeout)
end

function AbilityUtil.GetFlatLookVector(Target, Player, MaximumDistance)
	return ServerUtil.GetFlatLookVector(Target, Player, MaximumDistance)
end

function AbilityUtil.FaceTowardsPosition(Target, Position)
	return ServerUtil.FaceTowardsPosition(Target, Position)
end

function AbilityUtil.GetAssetMeta(Player)
	if typeof(Player) ~= 'Instance' or not Player:IsA('Player') then
		return nil
	end

	return AssetManager.Player[Player]
end

function AbilityUtil.GetAsset(AssetMeta, AssetName: string, Clone: boolean?, FolderName: string?)
	if not AssetMeta or not AssetName then
		return nil
	end

	local Asset = AssetMeta:RequestAsset(AssetName, Clone == true);
	if Asset then
		return Asset
	end

	if not FolderName or not AssetMeta.AssetFolder then
		return nil
	end

	local Folder = AssetMeta.AssetFolder:FindFirstChild(FolderName);
	if not Folder then
		return nil
	end

	local NestedAsset = Folder:FindFirstChild(AssetName);
	if not NestedAsset then
		return nil
	end

	return Clone and NestedAsset:Clone() or NestedAsset
end

function AbilityUtil.SendMove(Player: Player | boolean, ModuleScript: ModuleScript, FunctionName: string, ...): ()
	ServerUtil.SendMove(Player, ModuleScript, FunctionName, ...);
end

function AbilityUtil.RefreshAbility(AbilityMeta, Character)
	if not AbilityMeta then
		return
	end

	if Character and Character.Parent then
		AbilityMeta:RefreshCard(Character);
	end
end

function AbilityUtil.SetAbilityCooldown(AbilityMeta, Character, Duration)
	if not AbilityMeta then
		return
	end

	AbilityMeta:SetCooldown(Duration);
	AbilityUtil.RefreshAbility(AbilityMeta, Character);
end

function AbilityUtil.GetCharacterAbility(CharacterMeta, AbilityIdentifier)
	if not CharacterMeta or not CharacterMeta.Abilities then
		return nil
	end

	if typeof(AbilityIdentifier) == 'number' then
		return CharacterMeta.Abilities[AbilityIdentifier]
	elseif typeof(AbilityIdentifier) ~= 'string' then
		return nil
	end

	for _, AbilityMeta in CharacterMeta.Abilities do
		if AbilityMeta and AbilityMeta.AbilityName == AbilityIdentifier then
			return AbilityMeta
		end
	end

	return nil
end

function AbilityUtil.SetLinkedAbilityCooldown(CharacterMeta, Character, AbilityIdentifier, Duration)
	local AbilityMeta = AbilityUtil.GetCharacterAbility(CharacterMeta, AbilityIdentifier);
	if not AbilityMeta then
		return nil
	end

	AbilityUtil.SetAbilityCooldown(AbilityMeta, Character, Duration);
	return AbilityMeta
end

function AbilityUtil.GetEnemyFolder(Target)
	return ServerUtil.GetEnemyFolder(Target)
end

function AbilityUtil.GetEnemyCharacters(Target, Filter)
	return ServerUtil.GetEnemyCharacters(Target, Filter)
end

function AbilityUtil.GetTargetsInRadius(Origin, Radius, TargetFolder, Filter)
	return ServerUtil.GetTargetsInRadius(Origin, Radius, TargetFolder, Filter)
end

function AbilityUtil.GetNearestTarget(Origin, Radius, TargetFolder, Filter)
	return ServerUtil.GetNearestTarget(Origin, Radius, TargetFolder, Filter)
end

function AbilityUtil.CanUseAbility(Target, Options)
	Options = Options or {}

	local Character = ServerUtil.GetCharacter(Target);
	local Humanoid = ServerUtil.GetHumanoid(Target);
	if not Character or not Humanoid or Humanoid.Health <= 0 then
		return false
	end

	if not Options.AllowBusy and Character:GetAttribute('InAbility') then
		return false
	end

	if not Options.AllowWhileStunned and (Character:GetAttribute('Stun') or Character:HasTag('CantMove')) then
		return false
	end

	if not Options.IgnoreSilence and Character:GetAttribute('Silenced') then
		return false
	end

	return true
end

function AbilityUtil.SetBusy(Target, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return nil
	end

	local Token = NextToken(TimedAttributes, Character, '__Busy');
	Character:SetAttribute('InAbility', true);

	if Duration and Duration > 0 then
		task.delay(Duration, function()
			local Bucket = TimedAttributes[Character]
			if not Character.Parent or not Bucket or Bucket.__Busy ~= Token then
				return
			end

			Character:SetAttribute('InAbility', false);
		end);
	end

	return Token
end

function AbilityUtil.ClearBusy(Target)
	local Character = ServerUtil.GetCharacter(Target);
	if Character then
		Character:SetAttribute('InAbility', false);
	end
end

function AbilityUtil.ApplyTimedTag(Target, TagName, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return nil
	end

	local Token = NextToken(TimedTags, Character, TagName);
	if not Character:HasTag(TagName) then
		Character:AddTag(TagName);
	end

	if Duration and Duration > 0 then
		task.delay(Duration, function()
			local Bucket = TimedTags[Character]
			if not Character.Parent or not Bucket or Bucket[TagName] ~= Token then
				return
			end

			if Character:HasTag(TagName) then
				Character:RemoveTag(TagName);
			end
		end);
	end

	return Token
end

function AbilityUtil.ClearTimedTag(Target, TagName)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return
	end

	local Bucket = TimedTags[Character]
	if Bucket then
		Bucket[TagName] = nil
	end

	if Character:HasTag(TagName) then
		Character:RemoveTag(TagName);
	end
end

function AbilityUtil.ApplyTimedAttribute(Target, AttributeName, Value, Duration, RestoreValue)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return nil
	end

	local Key = '__Attr_' .. AttributeName
	local Token = NextToken(TimedAttributes, Character, Key);
	Character:SetAttribute(AttributeName, Value);

	if Duration and Duration > 0 then
		task.delay(Duration, function()
			local Bucket = TimedAttributes[Character]
			if not Character.Parent or not Bucket or Bucket[Key] ~= Token then
				return
			end

			Character:SetAttribute(AttributeName, RestoreValue);
		end);
	end

	return Token
end

function AbilityUtil.ApplyStatOverride(Target, Overrides, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return
	end

	for AttributeName, Value in Overrides do
		local Key = '__Stat_' .. AttributeName
		local Token = NextToken(TimedAttributes, Character, Key);
		local Previous = Character:GetAttribute(AttributeName);
		Character:SetAttribute(AttributeName, Value);

		if Duration and Duration > 0 then
			task.delay(Duration, function()
				local Bucket = TimedAttributes[Character]
				if not Character.Parent or not Bucket or Bucket[Key] ~= Token then
					return
				end

				Character:SetAttribute(AttributeName, Previous);
			end);
		end
	end
end

function AbilityUtil.ApplyCustomSpeed(Target, Speed, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return
	end

	local Token = NextToken(TimedAttributes, Character, '__CustomSpeed');
	Character:SetAttribute('CustomSpeed', Speed);
	if not Character:HasTag('CustomSpeed') then
		Character:AddTag('CustomSpeed');
	end

	if Duration and Duration > 0 then
		task.delay(Duration, function()
			local Bucket = TimedAttributes[Character]
			if not Character.Parent or not Bucket or Bucket.__CustomSpeed ~= Token then
				return
			end

			Character:SetAttribute('CustomSpeed', nil);
			if Character:HasTag('CustomSpeed') then
				Character:RemoveTag('CustomSpeed');
			end
		end);
	end
end

function AbilityUtil.ApplyStun(Target, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character or Duration <= 0 then
		return
	end

	local Token = NextToken(TimedAttributes, Character, '__Stun');
	Character:SetAttribute('Running', false);
	Character:SetAttribute('Stun', true);
	if not Character:HasTag('CantMove') then
		Character:AddTag('CantMove');
	end

	task.delay(Duration, function()
		local Bucket = TimedAttributes[Character]
		if not Character.Parent or not Bucket or Bucket.__Stun ~= Token then
			return
		end

		Character:SetAttribute('Stun', false);
		if Character:HasTag('CantMove') then
			Character:RemoveTag('CantMove');
		end
	end);
end

function AbilityUtil.ApplySilence(Target, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character or Duration <= 0 then
		return
	end

	AbilityUtil.ApplyTimedAttribute(Character, 'Silenced', true, Duration, false);
end

function AbilityUtil.ApplyBlindness(Target, Intensity, Duration)
	local Player = ServerUtil.GetPlayer(Target);
	if not Player then
		return
	end

	ServerUtil.SendMove(Player, BlindnessModule, 'Activate', Intensity or 1);
	task.delay(Duration or 5, function()
		if Player.Parent then
			ServerUtil.SendMove(Player, BlindnessModule, 'Clear');
		end
	end);
end

function AbilityUtil.ApplyDeafness(Target, Duration)
	local Player = ServerUtil.GetPlayer(Target);
	if not Player then
		return
	end

	ServerUtil.SendMove(Player, DeafnessModule, 'Activate', 0);
	task.delay(Duration or 5, function()
		if Player.Parent then
			ServerUtil.SendMove(Player, DeafnessModule, 'Clear');
		end
	end);
end

function AbilityUtil.ApplyDazed(Target, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character or Duration <= 0 then
		return
	end

	AbilityUtil.ApplyTimedAttribute(Character, 'Dazed', true, Duration, nil);
	AbilityUtil.ApplyBlindness(Character, 0.35, Duration);
	AbilityUtil.ApplyDeafness(Character, Duration);
end

function AbilityUtil.ApplyWeakness(Target, Level, Duration)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character or Duration <= 0 then
		return
	end

	AbilityUtil.ApplyTimedAttribute(Character, 'Weakness', Level or 1, Duration, nil);
end

function AbilityUtil.AddStamina(Target, Amount)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return nil
	end

	local MaxStamina = Character:GetAttribute('MaxStamina') or 0
	if MaxStamina <= 0 then
		return nil
	end

	local Stamina = math.min(MaxStamina, (Character:GetAttribute('Stamina') or MaxStamina) + math.max(0, Amount or 0));
	Character:SetAttribute('Stamina', Stamina);
	return Stamina
end

function AbilityUtil.RemoveStamina(Target, Amount)
	local Character = ServerUtil.GetCharacter(Target);
	if not Character then
		return nil
	end

	local MaxStamina = Character:GetAttribute('MaxStamina') or 0
	if MaxStamina <= 0 then
		return nil
	end

	local Stamina = math.max(0, math.min(MaxStamina, (Character:GetAttribute('Stamina') or MaxStamina) - math.max(0, Amount or 0)));
	Character:SetAttribute('Stamina', Stamina);
	return Stamina
end

function AbilityUtil.ApplyBleed(Target, Duration, TickDamage)
	local Character = ServerUtil.GetCharacter(Target);
	local Humanoid = ServerUtil.GetHumanoid(Target);
	if not Character or not Humanoid or Humanoid.Health <= 0 then
		return
	end

	local Token = NextToken(TimedAttributes, Character, '__Bleed');
	Character:SetAttribute('Bleeding', true);

	task.spawn(function()
		local Elapsed = 0
		while Character.Parent and Humanoid.Parent and Humanoid.Health > 0 do
			local Bucket = TimedAttributes[Character]
			if not Bucket or Bucket.__Bleed ~= Token or Elapsed >= Duration then
				break
			end

			task.wait(1);
			Elapsed += 1
			if Humanoid.Health > 0 then
				Humanoid.Health = math.max(0, Humanoid.Health - (TickDamage or 1))
			end
		end

		local Bucket = TimedAttributes[Character]
		if Character.Parent and Bucket and Bucket.__Bleed == Token then
			Character:SetAttribute('Bleeding', false);
		end
	end);
end

function AbilityUtil.LoadAnimation(Target, Animation)
	return ServerUtil.LoadAnimation(Target, Animation)
end

function AbilityUtil.PlayAssetSound(AssetMeta, Parent, AssetName, FolderName)
	local Sound = AbilityUtil.GetAsset(AssetMeta, AssetName, true, FolderName);
	if not Sound then
		return nil
	end

	Sound.Parent = Parent
	Sound:Play();
	Debris:AddItem(Sound, math.max(Sound.TimeLength, 2));
	return Sound
end

function AbilityUtil.ResolveParry(Attacker, Target)
	local AttackerCharacter = ServerUtil.GetCharacter(Attacker);
	local TargetCharacter = ServerUtil.GetCharacter(Target);
	if not AttackerCharacter or not TargetCharacter or not TargetCharacter:GetAttribute('ParryWindow') then
		return false
	end

	TargetCharacter:SetAttribute('ParryWindow', false);
	local Charges = math.clamp((TargetCharacter:GetAttribute('ParryCharges') or 0) + 1, 0, 3);
	TargetCharacter:SetAttribute('ParryCharges', Charges);
	AbilityUtil.ApplyStun(AttackerCharacter, TargetCharacter:GetAttribute('ParryStun') or 1.5);
	VFXHandler.TweenHighlight(AttackerCharacter, Color3.fromRGB(255, 255, 255), 0.75, Enum.HighlightDepthMode.AlwaysOnTop, 0.45);

	local TargetPlayer = Players:GetPlayerFromCharacter(TargetCharacter);
	local AssetMeta = TargetPlayer and AssetManager.Player[TargetPlayer]
	if AssetMeta then
		AbilityUtil.PlayAssetSound(AssetMeta, TargetCharacter, 'ParryHit');
	end

	return true
end

function AbilityUtil.ApplyDamage(Attacker, Target, Amount, Options)
	Options = Options or {}

	local TargetCharacter = ServerUtil.GetCharacter(Target);
	local TargetHumanoid = ServerUtil.GetHumanoid(Target);
	if not TargetCharacter or not TargetHumanoid or TargetHumanoid.Health <= 0 then
		return {Hit = false}
	end

	local PreviousHealth = TargetHumanoid.Health
	local AttackerCharacter = ServerUtil.GetCharacter(Attacker);
	if AttackerCharacter and not Options.IgnoreParry and AbilityUtil.ResolveParry(AttackerCharacter, TargetCharacter) then
		return {
			Hit = false,
			Parried = true,
			Target = TargetCharacter,
		}
	end

	local Remaining = math.max(0, Amount or 0);
	local Weakness = TargetCharacter:GetAttribute('Weakness') or 0
	if Weakness > 0 then
		Remaining *= 1 + (0.1 * Weakness)
	end

	if not Options.IgnoreShield then
		local Shield = TargetCharacter:GetAttribute('Dodges') or 0
		if Shield > 0 then
			local Absorbed = math.min(Shield, Remaining);
			TargetCharacter:SetAttribute('Dodges', math.max(0, Shield - Absorbed));
			Remaining -= Absorbed

			if TargetCharacter:GetAttribute('ShieldBlocksOverflow') and Shield < (Amount or 0) then
				Remaining = 0
			end
		end
	end

	if Remaining > 0 then
		TargetHumanoid.Health = math.max(0, TargetHumanoid.Health - Remaining)
	end

	local BaseMaxHealth = TargetCharacter:GetAttribute('BaseMaxHealth') or TargetHumanoid.MaxHealth
	TargetHumanoid.MaxHealth = math.max(BaseMaxHealth, TargetHumanoid.Health)

	if AttackerCharacter and KillerFolder:IsAncestorOf(AttackerCharacter) and AliveFolder:IsAncestorOf(TargetCharacter) and TargetHumanoid.Health < PreviousHealth then
		AbilityUtil.ApplyTimedAttribute(AttackerCharacter, 'StaminaDrainMultiplier', 0.5, 14, nil);
	end

	if Options.StunDuration and TargetHumanoid.Health > 0 then
		AbilityUtil.ApplyStun(TargetCharacter, Options.StunDuration);
	end

	if Options.DazedDuration and TargetHumanoid.Health > 0 then
		AbilityUtil.ApplyDazed(TargetCharacter, Options.DazedDuration);
	end

	if Options.ConfusionDuration and TargetHumanoid.Health > 0 then
		AbilityUtil.ApplyTimedTag(TargetCharacter, 'Confusion', Options.ConfusionDuration);
	end

	if Options.SilenceDuration and TargetHumanoid.Health > 0 then
		AbilityUtil.ApplySilence(TargetCharacter, Options.SilenceDuration);
	end

	if Options.BlindDuration and TargetHumanoid.Health > 0 then
		AbilityUtil.ApplyBlindness(TargetCharacter, Options.BlindIntensity or 1, Options.BlindDuration);
		AbilityUtil.ApplyDeafness(TargetCharacter, Options.BlindDuration);
	end

	if Options.SlowDuration and TargetHumanoid.Health > 0 then
		AbilityUtil.ApplyCustomSpeed(TargetCharacter, Options.SlowSpeed or 8, Options.SlowDuration);
	end

	if Options.BleedDuration and TargetHumanoid.Health > 0 then
		AbilityUtil.ApplyBleed(TargetCharacter, Options.BleedDuration, Options.BleedTick);
	end

	return {
		Hit = true,
		Target = TargetCharacter,
		Humanoid = TargetHumanoid,
		Died = TargetHumanoid.Health <= 0,
		RemainingHealth = TargetHumanoid.Health,
	}
end

function AbilityUtil.HealCharacter(Target, Amount, OverhealCap)
	local Character = ServerUtil.GetCharacter(Target);
	local Humanoid = ServerUtil.GetHumanoid(Target);
	if not Character or not Humanoid or Humanoid.Health <= 0 then
		return nil
	end

	local BaseMaxHealth = Character:GetAttribute('BaseMaxHealth');
	if not BaseMaxHealth then
		BaseMaxHealth = Humanoid.MaxHealth
		Character:SetAttribute('BaseMaxHealth', BaseMaxHealth);
	end

	local RemainingHeal = math.max(0, Amount or 0);
	if RemainingHeal > 0 and Humanoid.Health < BaseMaxHealth then
		local PreviousHealth = Humanoid.Health
		Humanoid.Health = math.min(BaseMaxHealth, Humanoid.Health + RemainingHeal)
		RemainingHeal -= Humanoid.Health - PreviousHealth
	end

	local ShieldMax = Character:GetAttribute('ShieldMax') or 0
	if RemainingHeal > 0 and ShieldMax > 0 then
		local CurrentShield = Character:GetAttribute('Dodges') or 0
		local NewShield = math.min(ShieldMax, CurrentShield + RemainingHeal);
		RemainingHeal -= NewShield - CurrentShield
		Character:SetAttribute('Dodges', NewShield);
	end

	local MaxHealth = BaseMaxHealth + math.max(0, OverhealCap or 0)
	if RemainingHeal > 0 and Humanoid.Health < MaxHealth then
		local PreviousHealth = Humanoid.Health
		Humanoid.MaxHealth = MaxHealth
		Humanoid.Health = math.min(MaxHealth, Humanoid.Health + RemainingHeal)
		RemainingHeal -= Humanoid.Health - PreviousHealth
	end

	Humanoid.MaxHealth = math.max(BaseMaxHealth, Humanoid.Health)
	return Humanoid.Health
end

function AbilityUtil.DashInDirection(Target, Speed, Duration, Direction)
	local Character = ServerUtil.GetCharacter(Target);
	local FlatDirection = GetFlatDirection(Direction);
	if not Character or not FlatDirection then
		return
	end

	VFXHandler.SetVelocity(Character, FlatDirection * Speed, Duration);
end

function AbilityUtil.DashForward(Target, Speed, Duration)
	local Root = ServerUtil.GetRoot(Target);
	if not Root then
		return
	end

	AbilityUtil.DashInDirection(Target, Speed, Duration, Root.CFrame.LookVector);
end

function AbilityUtil.DashTowardMouse(Player, Target, Speed, Duration, MaximumDistance)
	local Direction, AimPosition = ServerUtil.GetFlatLookVector(Target, Player, MaximumDistance);
	if not Direction then
		AbilityUtil.DashForward(Target, Speed, Duration);
		return nil
	end

	if AimPosition then
		ServerUtil.FaceTowardsPosition(Target, AimPosition);
	end

	AbilityUtil.DashInDirection(Target, Speed, Duration, Direction);
	return Direction
end

function AbilityUtil.LocateForPlayer(Player, Target)
	local TargetCharacter = ServerUtil.GetCharacter(Target);
	if not Player or not TargetCharacter then
		return
	end

	ServerUtil.SendMove(Player, LocateModule, 'Activate', TargetCharacter);
end

function AbilityUtil.GetClosestMapCamera(Target)
	local TargetRoot = ServerUtil.GetRoot(Target);
	if not TargetRoot then
		return nil
	end

	local CurrentMap = GameMapFolder:GetChildren()[1]
	if not CurrentMap then
		return nil
	end

	local Cameras = CurrentMap:FindFirstChild('Cameras');
	if not Cameras then
		return nil
	end

	local ClosestCamera = nil
	local ClosestDistance = math.huge
	for _, CameraModel in Cameras:GetChildren() do
		local CameraPart = CameraModel:FindFirstChild('Camera') or CameraModel.PrimaryPart or CameraModel:FindFirstChildWhichIsA('BasePart', true)
		if CameraPart then
			local Distance = (CameraPart.Position - TargetRoot.Position).Magnitude
			if Distance < ClosestDistance then
				ClosestDistance = Distance
				ClosestCamera = CameraPart
			end
		end
	end

	return ClosestCamera
end

function AbilityUtil.PeekThroughCamera(Player, CameraPart, FocusTarget, Duration, SkipLocate)
	local FocusRoot = ServerUtil.GetRoot(FocusTarget);
	if not Player or not CameraPart or not FocusRoot then
		return
	end

	ServerUtil.SendChange(Player, {'Camera', 'CameraType', Enum.CameraType.Scriptable});
	ServerUtil.SendChange(Player, {'Camera', 'CFrame', CFrame.lookAt(CameraPart.Position, FocusRoot.Position)});
	if not SkipLocate then
		AbilityUtil.LocateForPlayer(Player, FocusRoot.Parent);
	end

	task.delay(Duration or 4, function()
		if not Player.Parent then
			return
		end

		ServerUtil.SendChange(Player, {'Camera', 'CameraType', Enum.CameraType.Custom});
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
		if Humanoid then
			ServerUtil.SendChange(Player, {'CameraSubject', Humanoid});
		end
	end);
end

-- <- Return -> --
return AbilityUtil
