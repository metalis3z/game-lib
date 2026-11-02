-- <- Services -> --
local TweenService = game:GetService('TweenService');
local Workspace = game:GetService('Workspace');

-- <- Public Variables -> --
local GateModel = script.Parent
local Gate1: MeshPart = GateModel:WaitForChild('Gate1');
local Gate2: MeshPart = GateModel:WaitForChild('Gate2');

local OpenAt = 360
local OpenDistance = math.max(Gate1.Size.Z, Gate2.Size.Z) * 0.65
local GateTweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local ClosedGate1CFrame = Gate1.CFrame
local ClosedGate2CFrame = Gate2.CFrame
local OpenGate1CFrame = ClosedGate1CFrame * CFrame.new(0, 0, OpenDistance)
local OpenGate2CFrame = ClosedGate2CFrame * CFrame.new(0, 0, -OpenDistance)

local IsOpened = false
local TimerConnection: RBXScriptConnection? = nil

-- <- Private Functions -> --
local function OpenGates(): ()
	if IsOpened then
		return
	end
	
	IsOpened = true
	Gate1.CanCollide = false;
	Gate2.CanCollide = false;
	
	TweenService:Create(Gate1, GateTweenInfo, {
		CFrame = OpenGate1CFrame
	}):Play();
	TweenService:Create(Gate2, GateTweenInfo, {
		CFrame = OpenGate2CFrame
	}):Play();
	
	if TimerConnection then
		TimerConnection:Disconnect();
		TimerConnection = nil
	end
end

local function CheckTimer(Timer: NumberValue): ()
	if Timer.Value < OpenAt then
		return
	end
	
	OpenGates();
end

-- <- Init -> --
Gate1.Anchored = true;
Gate2.Anchored = true;

if not GateModel:FindFirstAncestor('Workspace') then
	return
end

local GameFolder = Workspace:WaitForChild('GAME');
local Timer: NumberValue = GameFolder:WaitForChild('TIMER');

TimerConnection = Timer:GetPropertyChangedSignal('Value'):Connect(function(): ()
	CheckTimer(Timer);
end);

CheckTimer(Timer);