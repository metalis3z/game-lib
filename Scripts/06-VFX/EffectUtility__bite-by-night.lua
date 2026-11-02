-- Reference copy for study. Game: bite-by-night
-- Original: ReplicatedStorage/Modules/EffectUtility.lua  (ModuleScript, 148 lines)
-- What it does: Emit every ParticleEmitter under an attachment using EmitCount / EmitDelay attributes, toggle emitters for a duration, and tween a Beam's transparency keypoints over time.

local EffectUtility = {};

local RunService = game:GetService('RunService');
local TweenService = game:GetService('TweenService');

function EffectUtility.ToggleAttachment(Attachment: Instance, Enabled: boolean, Duration: number?)
	for _, Descendant in ipairs(Attachment:GetDescendants()) do
		if Descendant:IsA('ParticleEmitter') then
			Descendant.Enabled = Enabled;
		end;
	end;

	if Duration and Duration > 0 then
		task.delay(Duration, EffectUtility.ToggleAttachment, Attachment, false);
	end;
end;

function EffectUtility.EmitAttachment(Attachment: Instance)
	for _, Descendant in ipairs(Attachment:GetDescendants()) do
		if not Descendant:IsA('ParticleEmitter') then
			continue;
		end;

		local EmitCount = Descendant:GetAttribute('EmitCount') or 1;
		local EmitDelay = Descendant:GetAttribute('EmitDelay') or 0;

		if EmitDelay > 0 then
			task.delay(EmitDelay, Descendant.Emit, Descendant, EmitCount);
		else
			Descendant:Emit(EmitCount);
		end;
	end;
end;

function EffectUtility._BeamTransparencyTween(Beam: Beam, Transparency, Duration: number, EasingStyle, EasingDirection, Speed: number)
	local StartTransparency = nil;
	local EndTransparency = nil;

	if typeof(Transparency) == 'number' then
		StartTransparency = Transparency;
		EndTransparency = Transparency;
	elseif typeof(Transparency) == 'string' then
		local StartValue, EndValue = Transparency:match('([^,]+),([^,]+)');
		StartTransparency = tonumber(StartValue);
		EndTransparency = tonumber(EndValue);
	end;

	if not StartTransparency then
		return nil;
	end;

	if Beam.Enabled then
		warn('BEAM MUST BE DISABLED TO AVOID OVERWRITING ORIGINAL BEAM VALUES!');
		return nil;
	end;

	Beam.Enabled = true;

	local OriginalSpeed = Beam.TextureSpeed;
	local OriginalTransparency = Beam.Transparency;
	local Keypoints = OriginalTransparency.Keypoints;
	local KeypointCount = #Keypoints;
	local Easing = EasingStyle or Enum.EasingStyle.Linear;
	local Direction = EasingDirection or Enum.EasingDirection.In;
	local InitialValues = table.create(KeypointCount);
	local TargetValues = table.create(KeypointCount);

	for Index, Keypoint in ipairs(Keypoints) do
		InitialValues[Index] = Keypoint.Value;
		TargetValues[Index] = StartTransparency + (EndTransparency - StartTransparency) * Keypoint.Time;
	end;

	TweenService:Create(Beam, TweenInfo.new(Duration, Easing, Direction), {
		TextureSpeed = Speed;
	}):Play();

	local Elapsed = 0;
	local Connection = nil;

	Connection = RunService.Heartbeat:Connect(function(DeltaTime)
		Elapsed += DeltaTime;

		if Elapsed > Duration then
			Connection:Disconnect();
			Connection = nil;
			return;
		end;

		local Alpha = TweenService:GetValue(math.clamp(Elapsed / Duration, 0, 1), Easing, Direction);
		local NewKeypoints = table.create(KeypointCount);

		for Index, Keypoint in ipairs(Keypoints) do
			local Value = InitialValues[Index] + (TargetValues[Index] - InitialValues[Index]) * Alpha;
			NewKeypoints[Index] = NumberSequenceKeypoint.new(Keypoint.Time, Value, Keypoint.Envelope);
		end;

		Beam.Transparency = NumberSequence.new(NewKeypoints);
	end);

	return function()
		if Connection then
			Connection:Disconnect();
		end;

		Beam.Enabled = false;
		Beam.TextureSpeed = OriginalSpeed;
		Beam.Transparency = OriginalTransparency;
	end;
end;

function EffectUtility.EmitAndToggle(Attachment: Instance, Parent: Instance, Duration: number?)
	local Clone = Attachment:Clone();
	Clone.Parent = Parent;

	EffectUtility.EmitAttachment(Clone);
	EffectUtility.ToggleAttachment(Clone, true, Duration);

	return Clone;
end;

function EffectUtility.TweenBeamTransparency(Attachment: Instance, Config)
	Config = Config or {};

	if not Config then
		warn('Missing Config for TweenBeamTransparency, defaulting to base values');
	end;

	for _, Descendant in Attachment:GetDescendants() do
		if not Descendant:IsA('Beam') then
			continue;
		end;

		local Reset = EffectUtility._BeamTransparencyTween(
			Descendant,
			Config.transparency or 1,
			Config.duration or 2,
			Config.beamEasingStyle or Enum.EasingStyle.Sine,
			Config.beamEasingDirection or Enum.EasingDirection.Out,
			Config.speed or 0
		);

		if Reset then
			task.delay((Config.duration or 2) + 0.15, Reset);
		end;
	end;
end;

return EffectUtility;
