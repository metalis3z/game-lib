local Heal = {};

-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Private Variables -> --
local SurvivorFolder = workspace.PLAYERS.ALIVE
local ActiveHeals = setmetatable({}, {__mode = 'k'});

-- <- Private Functions -> --
local function StopTrack(Track)
	if Track then
		Track:Stop();
	end
end

local function GetHealState(Character: Model)
	local State = ActiveHeals[Character]
	if State then
		return State
	end

	State = {}
	ActiveHeals[Character] = State
	return State
end

local function ClearHealState(Character: Model, ClearBusy: boolean)
	local State = ActiveHeals[Character]
	ActiveHeals[Character] = nil
	if not State then
		if ClearBusy then
			AbilityUtil.ClearBusy(Character);
		end
		return
	end

	if State.Connection then
		State.Connection:Disconnect();
	end
	if State.Prompt and State.Prompt.Parent then
		State.Prompt:Destroy();
	end
	if State.Highlight and State.Highlight.Parent then
		State.Highlight:Destroy();
	end
	if ClearBusy then
		AbilityUtil.ClearBusy(Character);
		if State.Target and State.Target.Parent then
			AbilityUtil.ClearBusy(State.Target);
		end
	end
end

local function NeedsHealing(Character: Model, OverhealCap: number)
	local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
	if not Humanoid or Humanoid.Health <= 0 then
		return false
	end

	local BaseMaxHealth = Character:GetAttribute('BaseMaxHealth') or Humanoid.MaxHealth
	local ShieldMax = Character:GetAttribute('ShieldMax') or 0
	local Shield = Character:GetAttribute('Dodges') or 0
	return Humanoid.Health < (BaseMaxHealth + OverhealCap) or (ShieldMax > 0 and Shield < ShieldMax)
end

local function CanHealTarget(MedicCharacter: Model, TargetCharacter: Model, OverhealCap: number)
	if not TargetCharacter then
		return false
	elseif TargetCharacter == MedicCharacter then
		return false
	elseif TargetCharacter.Parent ~= SurvivorFolder then
		return false
	elseif TargetCharacter:GetAttribute('Character') == 'Survivor-Medic' then
		return false
	end

	return NeedsHealing(TargetCharacter, OverhealCap);
end

local function CreatePrompt(Parent: Instance, HoldDuration: number, MaxDistance: number)
	local Prompt = Instance.new('ProximityPrompt');
	Prompt.ActionText = 'Get Healed'
	Prompt.ObjectText = 'Medic'
	Prompt.HoldDuration = HoldDuration
	Prompt.KeyboardKeyCode = Enum.KeyCode.F
	Prompt.MaxActivationDistance = MaxDistance
	Prompt.RequiresLineOfSight = false
	Prompt.Style = Enum.ProximityPromptStyle.Custom
	Prompt.Parent = Parent
	return Prompt
end

local function CreateHighlight(Character: Model)
	local Highlight = Instance.new('Highlight');
	Highlight.FillColor = Color3.fromRGB(91, 255, 146)
	Highlight.FillTransparency = 0.35
	Highlight.OutlineTransparency = 1
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Parent = Character
	return Highlight
end

local function CanContinueHeal(CasterCharacter: Model, TargetCharacter: Model, TargetOrigin: Vector3, HealDistance: number, HealCancelDistance: number)
	local CasterRoot = ServerUtil.GetRoot(CasterCharacter);
	local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
	local TargetHumanoid = ServerUtil.GetHumanoid(TargetCharacter);
	if not CasterRoot or not TargetRoot or not TargetHumanoid then
		return false
	elseif TargetHumanoid.Health <= 0 then
		return false
	elseif (CasterRoot.Position - TargetRoot.Position).Magnitude > HealDistance then
		return false
	elseif (TargetRoot.Position - TargetOrigin).Magnitude > HealCancelDistance then
		return false
	elseif TargetHumanoid.MoveDirection.Magnitude > 0.1 then
		return false
	end

	return true
end

local function RunHealLoop(CasterCharacter: Model, CasterAnimator: Animator, TargetCharacter: Model, AssetMeta, Configuration)
	local HealTicks = Configuration.HealTicks or 6
	local OverhealCap = Configuration.OverhealCap or 15
	local TickRate = math.max(0.5, Configuration.Rate or 2);
	local TotalDuration = TickRate * HealTicks
	local HealDistance = Configuration.HealDistance or 12
	local HealCancelDistance = Configuration.HealCancelDistance or 2.5
	local TargetHumanoid = TargetCharacter:FindFirstChildOfClass('Humanoid');
	local TargetAnimator = TargetHumanoid and TargetHumanoid:FindFirstChildOfClass('Animator')
	local TargetRoot = ServerUtil.GetRoot(TargetCharacter);
	if not TargetHumanoid or TargetHumanoid.Health <= 0 or not TargetRoot then
		ClearHealState(CasterCharacter, true);
		return
	end

	local TargetOrigin = TargetRoot.Position
	AbilityUtil.SetBusy(CasterCharacter, TotalDuration + 0.5);
	AbilityUtil.ApplyTimedTag(CasterCharacter, 'CantMove', TotalDuration);
	AbilityUtil.SetBusy(TargetCharacter, TotalDuration + 0.5);

	local StartTrack = ServerUtil.LoadAnimation(CasterAnimator, AssetMeta:RequestAsset('HealStart'));
	local LoopTrack = ServerUtil.LoadAnimation(CasterAnimator, AssetMeta:RequestAsset('HealLoop'));
	local EndTrack = ServerUtil.LoadAnimation(CasterAnimator, AssetMeta:RequestAsset('HealLoopEnd'));
	local VictimStartTrack = TargetAnimator and ServerUtil.LoadAnimation(TargetAnimator, AssetMeta:RequestAsset('HealStartVictim'))
	local VictimLoopTrack = TargetAnimator and ServerUtil.LoadAnimation(TargetAnimator, AssetMeta:RequestAsset('HealLoopVictim'))

	if StartTrack then
		StartTrack:Play();
	end
	if VictimStartTrack then
		VictimStartTrack:Play();
	end

	task.spawn(function()
		task.wait(0.35);
		if LoopTrack then
			LoopTrack:Play();
		end
		if VictimLoopTrack then
			VictimLoopTrack:Play();
		end

		for _ = 1, HealTicks do
			if not CasterCharacter.Parent or not TargetCharacter.Parent then
				break
			elseif not CanContinueHeal(CasterCharacter, TargetCharacter, TargetOrigin, HealDistance, HealCancelDistance) then
				break
			elseif not NeedsHealing(TargetCharacter, OverhealCap) then
				break
			end

			AbilityUtil.HealCharacter(TargetCharacter, Configuration.Heal or 5, OverhealCap);
			task.wait(TickRate);
		end

		StopTrack(LoopTrack);
		StopTrack(VictimLoopTrack);
		if EndTrack then
			EndTrack:Play();
		end

		ClearHealState(CasterCharacter, true);
	end);
end


-- <- Public Functions -> --
function Heal.Use(Player: Player, Character: Model, Animator: Animator, AssetMeta, Configuration)
	if ActiveHeals[Character] then
		return false
	end

	local Root = ServerUtil.GetRoot(Character);
	if not Root then
		return false
	end

	local HealPromptDuration = Configuration.HealPromptDuration or 5
	local HealPromptHoldDuration = Configuration.HealPromptHoldDuration or 0.15
	local HealDistance = Configuration.HealDistance or 12
	local OverhealCap = Configuration.OverhealCap or 15
	local State = GetHealState(Character);
	State.Prompt = CreatePrompt(Root, HealPromptHoldDuration, HealDistance)
	State.Highlight = CreateHighlight(Character)

	AbilityUtil.SetBusy(Character, HealPromptDuration + 0.5);
	AbilityUtil.ApplyTimedTag(Character, 'CantMove', HealPromptDuration);

	State.Connection = State.Prompt.Triggered:Connect(function(TargetPlayer)
		if TargetPlayer == Player or State.Target then
			return
		end

		local TargetCharacter = TargetPlayer.Character
		if not CanHealTarget(Character, TargetCharacter, OverhealCap) then
			return
		end

		State.Target = TargetCharacter
		if State.Prompt and State.Prompt.Parent then
			State.Prompt:Destroy();
			State.Prompt = nil
		end

		RunHealLoop(Character, Animator, TargetCharacter, AssetMeta, Configuration);
	end);

	task.delay(HealPromptDuration, function()
		if ActiveHeals[Character] ~= State or State.Target then
			return
		end

		ClearHealState(Character, true);
	end);

	return true
end


-- <- Return -> --
return Heal