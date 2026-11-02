local Shared = {};

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local HitboxManager = require('@game/ServerStorage/Modules/Managers/HitboxManager');
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local MoveFolder = ReplicatedStorage.Modules.Moves
local DigMove = MoveFolder:FindFirstChild('Dig-Mimic');
local HeldVictims = setmetatable({}, {__mode = 'k'});
local DrillStates = setmetatable({}, {__mode = 'k'});

-- <- Public Functions -> --
function Shared.GetMode(Character: Model)
	if Character:GetAttribute('MimicSpeed') then
		return 'Speed'
	elseif Character:GetAttribute('MimicStealth') then
		return 'Stealth'
	end

	return 'Strength'
end


function Shared.GetModeStats(Configuration, Mode: string)
	local Defaults = {
		Strength = {
			Speed = 12,
			RunSpeed = 22,
			Stamina = 65,
			Regen = 16,
			StaminaDrain = 16,
			SwingDamage = 40,
		},
		Speed = {
			Speed = 15,
			RunSpeed = 27.5,
			Stamina = 55,
			Regen = 8,
			StaminaDrain = 16,
			SwingDamage = 6,
		},
		Stealth = {
			Speed = 13.2,
			RunSpeed = 24.2,
			Stamina = 65,
			Regen = 16,
			StaminaDrain = 16,
			SwingDamage = 25,
		},
	}

	local Modes = Configuration.Modes or {}
	return Modes[Mode] or Defaults[Mode] or Modes.Strength or Defaults.Strength
end


function Shared.ApplyMode(Character: Model, Configuration, Mode: string)
	local ModeStats = Shared.GetModeStats(Configuration, Mode);
	Character:SetAttribute('MimicStrength', Mode == 'Strength' and true or nil);
	Character:SetAttribute('MimicSpeed', Mode == 'Speed' and true or nil);
	Character:SetAttribute('MimicStealth', Mode == 'Stealth' and true or nil);
	Character:SetAttribute('WalkSpeed', ModeStats.Speed or Configuration.Speed or 12);
	Character:SetAttribute('RunSpeed', ModeStats.RunSpeed or Configuration.RunSpeed or 22);
	Character:SetAttribute('Regen', ModeStats.Regen or Configuration.Regen or 16);
	Character:SetAttribute('StaminaDrain', ModeStats.StaminaDrain or Configuration.StaminaDrain or 16);

	local MaxStamina = ModeStats.Stamina or Configuration.Stamina or 65
	Character:SetAttribute('MaxStamina', MaxStamina);
	Character:SetAttribute('Stamina', math.min(Character:GetAttribute('Stamina') or MaxStamina, MaxStamina));

	if Mode == 'Stealth' or Character:GetAttribute('MimicDrilling') then
		if not Character:HasTag('UNDETECTABLE') then
			Character:AddTag('UNDETECTABLE');
		end
	else
		if Character:HasTag('UNDETECTABLE') then
			Character:RemoveTag('UNDETECTABLE');
		end
		if Character:HasTag('TRUE_UNDETECTABLE') then
			Character:RemoveTag('TRUE_UNDETECTABLE');
		end
	end
end


function Shared.EnsureMode(Character: Model, Configuration)
	if not Character:GetAttribute('MimicStrength') and not Character:GetAttribute('MimicSpeed') and not Character:GetAttribute('MimicStealth') then
		Shared.ApplyMode(Character, Configuration, 'Strength');
	end

	return Shared.GetMode(Character);
end


function Shared.ClearSelection(Player: Player, Character: Model)
	local PlayerGui = Player and Player:FindFirstChildOfClass('PlayerGui')
	if PlayerGui then
		local SelectionGui = PlayerGui:FindFirstChild('Selection');
		if SelectionGui then
			SelectionGui:Destroy();
		end
	end

	if Character:HasTag('Selecting') then
		Character:RemoveTag('Selecting');
	end
end


function Shared.OpenSelection(Player: Player, Character: Model, AssetMeta)
	if Character:HasTag('Selecting') then
		return false
	end

	local PlayerGui = Player and Player:FindFirstChildOfClass('PlayerGui')
	if not PlayerGui then
		return false
	end

	local SelectionGui = AssetMeta and AssetMeta:RequestAsset('Selection', true)
	if not SelectionGui then
		return false
	end

	SelectionGui.Name = 'Selection'
	SelectionGui.Parent = PlayerGui
	Character:AddTag('Selecting');
	return true
end


function Shared.GetForwardTarget(Character: Model, MaxDistance: number, MinDot: number)
	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return nil
	end

	local Player = ServerUtil.GetPlayer(Character);
	local FlatLook = ServerUtil.GetFlatLookVector(Character, Player, MaxDistance);
	if not FlatLook then
		return nil
	end

	local BestTarget = nil
	local BestDistance = math.huge
	for _, TargetCharacter in ServerUtil.GetEnemyCharacters(Character) do
		local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
		if not TargetRoot then
			continue
		end

		local Offset = TargetRoot.Position - Root.Position
		local FlatOffset = Vector3.new(Offset.X, 0, Offset.Z);
		local Distance = FlatOffset.Magnitude
		if Distance <= 0.01 or Distance > MaxDistance then
			continue
		end

		local Dot = FlatOffset.Unit:Dot(FlatLook);
		if Dot >= MinDot and Distance < BestDistance then
			BestTarget = TargetCharacter
			BestDistance = Distance
		end
	end

	return BestTarget, BestDistance
end


function Shared.GetAttackTarget(Character: Model, Configuration, MoveName: string, Options)
	Options = Options or {}

	local Hitbox = HitboxManager.new(Character, Configuration, MoveName, {
		ContinueUntilFind = true,
		ContinueTimeout = Options.ContinueTimeout or 0.2,
		PollInterval = Options.PollInterval or 0.03,
		SortByDistance = Options.SortByDistance == nil and true or Options.SortByDistance,
		ModeOverride = Options.ModeOverride,
		ForcedSize = Options.ForcedSize,
		ForcedCFrame = Options.ForcedCFrame,
		ForcedRadius = Options.ForcedRadius,
		Projectile = Options.Projectile,
		TargetFolder = Options.TargetFolder,
		IgnoreList = Options.IgnoreList,
		Filter = Options.Filter,
		MaxParts = Options.MaxParts,
	});
	if not Hitbox then
		return
	end

	local HitModel = Hitbox:Activate();
	if typeof(HitModel) == 'table' then
		return HitModel[1]
	end

	return HitModel
end


function Shared.ReleaseHeldVictim(Character: Model)
	local State = HeldVictims[Character]
	HeldVictims[Character] = nil
	Character:SetAttribute('MimicHoldingVictim', nil);

	if not State or not State.Target or not State.Target.Parent then
		return
	end

	State.Target:SetAttribute('Stun', false);
	if State.Target:HasTag('CantMove') then
		State.Target:RemoveTag('CantMove');
	end
end


function Shared.GetHeldVictimState(Character: Model)
	return HeldVictims[Character]
end


function Shared.ResolveHeldVictim(Character: Model, Configuration, AssetMeta, FollowupUsed: boolean, Information)
	Information = Information or {}

	local State = HeldVictims[Character]
	if not State or not State.Target or not State.Target.Parent then
		Shared.ReleaseHeldVictim(Character);
		return false
	end
	if FollowupUsed and os.clock() < (State.FollowupReadyAt or 0) then
		return false
	end

	local Target = State.Target
	local Damage = Information.Damage or (Configuration.Damage and Configuration.Damage.Grab) or 25
	local ThrowDistance = Information.ThrowDistance
	if ThrowDistance == nil then
		ThrowDistance = FollowupUsed and 4 or 8
	end

	AbilityUtil.SetBusy(Character, Information.BusyDuration or (FollowupUsed and 0.75 or 0.9));

	local AttackTrack = ServerUtil.LoadAnimation(Character, Information.Animation or AbilityUtil.GetAsset(AssetMeta, 'Throw_Mimic') or AbilityUtil.GetAsset(AssetMeta, 'Throw') or AbilityUtil.GetAsset(AssetMeta, 'Swing'));
	if AttackTrack then
		AttackTrack:Play();
	end
	AbilityUtil.PlayAssetSound(AssetMeta, Character, Information.Sound or 'Throw Varient 2');

	local VictimTrack = ServerUtil.LoadAnimation(Target, Information.VictimAnimation or AbilityUtil.GetAsset(AssetMeta, 'Throw_Victim'));
	if VictimTrack then
		VictimTrack:Play();
	end

	local Cooldown = Information.Cooldown
	if Cooldown == nil then
		Cooldown = FollowupUsed and (Configuration.DrillStabCooldown or 4) or (Configuration.GrabAutoCooldown or 15)
	end
	if Cooldown and Cooldown > 0 then
		AbilityUtil.SetAbilityCooldown(State.AbilityMeta, Character, Cooldown);
	end

	task.delay(0.2, function()
		if Character.Parent and Target.Parent then
			AbilityUtil.ApplyDamage(Character, Target, Damage, {
				IgnoreParry = true,
				StunDuration = Information.StunDuration or 1,
			});

			local Root = ServerUtil.GetRoot(Character);
			local TargetRoot = ServerUtil.GetRoot(Target);
			if Root and TargetRoot then
				local ThrowPosition = Root.Position + Root.CFrame.LookVector * ThrowDistance
				Target:PivotTo(CFrame.lookAt(ThrowPosition, ThrowPosition + Root.CFrame.LookVector));
				if not Information.NoSplash then
					for _, Survivor in ServerUtil.GetTargetsInRadius(ThrowPosition, Information.SplashRadius or 4, workspace.PLAYERS.ALIVE) do
						if Survivor == Target then
							continue
						end

						AbilityUtil.ApplyDamage(Character, Survivor, Configuration.GrabThrowDamage or 12, {
							IgnoreParry = true,
							StunDuration = 1,
						});
						break
					end
				end
			end
		end

		Shared.ReleaseHeldVictim(Character);
		if Target.Parent then
			AbilityUtil.ApplyStun(Target, Information.StunDuration or 1);
		end
	end);

	return true
end


function Shared.HoldVictim(Character: Model, TargetCharacter: Model, Configuration, AssetMeta, AbilityMeta)
	Shared.ReleaseHeldVictim(Character);

	local State = {
		Target = TargetCharacter,
		ReleaseAt = os.clock() + (Configuration.GrabDuration or 4),
		FollowupReadyAt = os.clock() + 0.4,
		AssetMeta = AssetMeta,
		AbilityMeta = AbilityMeta,
	}
	HeldVictims[Character] = State
	Character:SetAttribute('Running', false);
	Character:SetAttribute('MimicHoldingVictim', true);
	TargetCharacter:SetAttribute('Stun', true);
	if not TargetCharacter:HasTag('CantMove') then
		TargetCharacter:AddTag('CantMove');
	end

	local VictimTrack = ServerUtil.LoadAnimation(TargetCharacter, AbilityUtil.GetAsset(AssetMeta, 'HoldVictim'));
	if VictimTrack then
		VictimTrack:Play();
	end

	task.spawn(function()
		while HeldVictims[Character] == State and os.clock() <= State.ReleaseAt do
			local Root = ServerUtil.GetRoot(Character);
			local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
			if not Root or not TargetRoot then
				break
			end

			TargetCharacter:PivotTo(Root.CFrame * CFrame.new(0, 0, -2.6));
			task.wait(0.05);
		end
	end);

	task.delay(Configuration.GrabDuration or 4, function()
		if HeldVictims[Character] ~= State or not Character.Parent then
			return
		end

		Shared.ResolveHeldVictim(Character, Configuration, State.AssetMeta, false);
	end);
end


function Shared.SetDrillState(Player: Player, Character: Model, Configuration, Enabled: boolean)
	local State = DrillStates[Character]
	if not State then
		State = {}
		DrillStates[Character] = State
	end
	State.Token = (State.Token or 0) + 1

	Character:SetAttribute('MimicDrilling', Enabled and true or nil);
	if Enabled then
		local SpeedStats = Shared.GetModeStats(Configuration, 'Speed');
		Character:SetAttribute('WalkSpeed', SpeedStats.Speed or 15);
		Character:SetAttribute('RunSpeed', SpeedStats.RunSpeed or 27.5);
		Character:SetAttribute('Regen', SpeedStats.Regen or Configuration.Regen or 16);
		Character:SetAttribute('StaminaDrain', SpeedStats.StaminaDrain or Configuration.StaminaDrain or 16);
		if not Character:HasTag('UNDETECTABLE') then
			Character:AddTag('UNDETECTABLE');
		end
		if not Character:HasTag('TRUE_UNDETECTABLE') then
			Character:AddTag('TRUE_UNDETECTABLE');
		end
		if Player and DigMove then
			ServerUtil.SendMove(Player, DigMove, 'Activate');
		end
		return
	end

	if Player and DigMove then
		ServerUtil.SendMove(Player, DigMove, 'Deactivate');
	end
	if Character:HasTag('TRUE_UNDETECTABLE') then
		Character:RemoveTag('TRUE_UNDETECTABLE');
	end
	Shared.ApplyMode(Character, Configuration, 'Stealth');
end


function Shared.StartDrillRevealLoop(Player: Player, Character: Model)
	local State = DrillStates[Character]
	if not State then
		State = {}
		DrillStates[Character] = State
	end

	local Token = State.Token
	task.spawn(function()
		while Character.Parent and Character:GetAttribute('MimicDrilling') and DrillStates[Character] == State and State.Token == Token do
			for _, Target in ServerUtil.GetEnemyCharacters(Character) do
				AbilityUtil.LocateForPlayer(Player, Target);
			end
			task.wait(2);
		end
	end);
end


-- <- Return -> --
return Shared