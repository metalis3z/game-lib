local StaminaManager = {
	Started = false,
	Characters = setmetatable({}, {__mode = 'k'}),
}

-- <- Services -> --
local Players = game:GetService('Players');
local RunService = game:GetService('RunService');

-- <- Private Variables -> --
local DefaultRegenDelay = 1
local ExhaustionDuration = 4
local RequiredMovementDot = 0.45
local MinimumMovementSpeed = 1.5

-- <- Private Functions -> --
local function GetCharacterState(Character: Model)
	local State = StaminaManager.Characters[Character]
	if State then
		return State
	end

	State = {
		LastPosition = nil,
		LastStamina = nil,
		RegenAt = 0,
		ExhaustedUntil = 0,
		CanRunBeforeExhaustion = true,
	}
	StaminaManager.Characters[Character] = State

	return State
end

local function ClampStamina(Character: Model)
	local MaxStamina = Character:GetAttribute('MaxStamina');
	if not MaxStamina then
		return
	end

	local Stamina = Character:GetAttribute('Stamina');
	if Stamina == nil then
		Character:SetAttribute('Stamina', MaxStamina);
		return
	end

	Character:SetAttribute('Stamina', math.clamp(Stamina, 0, MaxStamina));
end

local function GetFlatVelocity(Root: BasePart, State, DeltaTime: number)
	local CurrentPosition = Root.Position
	local LastPosition = State.LastPosition or CurrentPosition
	State.LastPosition = CurrentPosition

	if DeltaTime <= 0 then
		return Vector3.zero, 0
	end

	local Delta = CurrentPosition - LastPosition
	local DeltaVelocity = Vector3.new(Delta.X, 0, Delta.Z) / DeltaTime
	local AssemblyVelocity = Root.AssemblyLinearVelocity
	local FlatAssemblyVelocity = Vector3.new(AssemblyVelocity.X, 0, AssemblyVelocity.Z);
	if FlatAssemblyVelocity.Magnitude > DeltaVelocity.Magnitude then
		DeltaVelocity = FlatAssemblyVelocity
	end

	return DeltaVelocity, DeltaVelocity.Magnitude
end

local function GetDrainMultiplier(Character: Model)
	local DrainMultiplier = Character:GetAttribute('StaminaDrainMultiplier') or 1
	if Character:GetAttribute('Character') == 'Springtrap' and Character:GetAttribute('Axeless') then
		DrainMultiplier *= 1.35
	end

	return DrainMultiplier
end

local function GetRegenMultiplier(Character: Model)
	return Character:GetAttribute('StaminaRegenMultiplier') or 1
end

local function CanDrainStamina(Character: Model, Humanoid: Humanoid, Root: BasePart, FlatVelocity: Vector3, Speed: number)
	if Humanoid.Health <= 0 then
		return false
	elseif not Character:GetAttribute('Running') then
		return false
	elseif Character:GetAttribute('CanRun') == false then
		return false
	elseif Character:HasTag('CantMove') then
		return false
	elseif Character:GetAttribute('Ragdoll') then
		return false
	elseif Speed <= MinimumMovementSpeed then
		return false
	elseif FlatVelocity.Magnitude <= 0.001 then
		return false
	end

	local Look = Root.CFrame.LookVector
	local FlatLook = Vector3.new(Look.X, 0, Look.Z);
	if FlatLook.Magnitude <= 0.001 then
		return false
	end

	return FlatLook.Unit:Dot(FlatVelocity.Unit) >= RequiredMovementDot
end

local function RefreshExhaustion(Character: Model, State, Now: number)
	if State.ExhaustedUntil > Now then
		Character:SetAttribute('CanRun', false);
		Character:SetAttribute('Exhausted', true);
		Character:SetAttribute('Exhaustion', true);
		return
	end

	if State.ExhaustedUntil > 0 then
		State.ExhaustedUntil = 0
		Character:SetAttribute('Exhausted', nil);
		Character:SetAttribute('Exhaustion', nil);
		if Character:GetAttribute('Team') ~= 'Lobby' then
			Character:SetAttribute('CanRun', State.CanRunBeforeExhaustion ~= false);
		end
	end
end

local function DrainStamina(Character: Model, State, Amount: number, Now: number)
	local MaxStamina = Character:GetAttribute('MaxStamina') or 0
	if MaxStamina <= 0 then
		return
	end

	local Stamina = math.max(0, math.min(MaxStamina, (Character:GetAttribute('Stamina') or MaxStamina) - math.max(0, Amount)))
	Character:SetAttribute('Stamina', Stamina);
	State.RegenAt = Now + (Character:GetAttribute('StaminaRegenDelay') or DefaultRegenDelay)
	if Stamina > 0 then
		return
	end

	State.CanRunBeforeExhaustion = Character:GetAttribute('CanRun') ~= false
	State.ExhaustedUntil = Now + ExhaustionDuration
	State.RegenAt = State.ExhaustedUntil
	Character:SetAttribute('Running', false);
	Character:SetAttribute('CanRun', false);
	Character:SetAttribute('Exhausted', true);
	Character:SetAttribute('Exhaustion', true);
end

local function RegenerateStamina(Character: Model, State, DeltaTime: number, Now: number)
	local MaxStamina = Character:GetAttribute('MaxStamina') or 0
	if MaxStamina <= 0 then
		return
	elseif Character:GetAttribute('Running') then
		return
	elseif State.ExhaustedUntil > Now then
		return
	elseif State.RegenAt > Now then
		return
	end

	local Stamina = Character:GetAttribute('Stamina') or MaxStamina
	if Stamina >= MaxStamina then
		Character:SetAttribute('Stamina', MaxStamina);
		return
	end

	local Regen = Character:GetAttribute('Regen') or 0
	Character:SetAttribute('Stamina', math.min(MaxStamina, Stamina + (Regen * GetRegenMultiplier(Character) * DeltaTime)));
end

local function UpdateCharacter(Character: Model, DeltaTime: number, Now: number)
	if not Character.Parent then
		StaminaManager.Characters[Character] = nil
		return
	end

	local Humanoid = Character:FindFirstChildOfClass('Humanoid');
	local Root = Character:FindFirstChild('HumanoidRootPart') or Character.PrimaryPart
	if not Humanoid or not Root then
		return
	elseif Character:GetAttribute('Team') == 'Lobby' then
		return
	elseif Character:GetAttribute('MaxStamina') == nil then
		return
	end

	local State = GetCharacterState(Character);
	ClampStamina(Character);
	RefreshExhaustion(Character, State, Now);

	local CurrentStamina = Character:GetAttribute('Stamina') or 0
	if State.LastStamina and CurrentStamina < State.LastStamina then
		State.RegenAt = math.max(State.RegenAt, Now + (Character:GetAttribute('StaminaRegenDelay') or DefaultRegenDelay))
	end

	local FlatVelocity, Speed = GetFlatVelocity(Root, State, DeltaTime);
	if CanDrainStamina(Character, Humanoid, Root, FlatVelocity, Speed) then
		local StaminaDrain = Character:GetAttribute('StaminaDrain') or Character:GetAttribute('Regen') or 20
		DrainStamina(Character, State, StaminaDrain * GetDrainMultiplier(Character) * DeltaTime, Now);
	else
		if Character:GetAttribute('Running') and (Character:GetAttribute('CanRun') == false or CurrentStamina <= 0 or Character:HasTag('CantMove') or Character:GetAttribute('Ragdoll')) then
			Character:SetAttribute('Running', false);
		end

		RegenerateStamina(Character, State, DeltaTime, Now);
	end

	State.LastStamina = Character:GetAttribute('Stamina') or 0
end

-- <- Public Functions -> --
function StaminaManager.Init()
	if StaminaManager.Started then
		return
	end

	StaminaManager.Started = true
	RunService.Heartbeat:Connect(function(DeltaTime: number)
		local Now = os.clock();
		for _, Player in Players:GetPlayers() do
			local Character = Player.Character
			if Character then
				UpdateCharacter(Character, DeltaTime, Now);
			end
		end
	end);
end

-- <- Return -> --
return StaminaManager