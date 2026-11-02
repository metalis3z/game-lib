-- <- Services -> --
local UserInputService = game:GetService('UserInputService');
local TweenService = game:GetService('TweenService');
local RunService = game:GetService('RunService');
local Players = game:GetService('Players');
local GamepadService = game:GetService('GamepadService');

-- <- Variables -> --
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse();

local Interface = script.Parent
local SFX = Interface.SFX
local MainFrame = Interface.MainFrame
local Generator = MainFrame.Generator

local LeverFrame = Generator.Lever
local SwitchFrame = Generator.Switch
local WireFrame = Generator.Wires

local PuzzleState = {
	Lever = false,
	Switches = false,
	Wires = false,
}

local ConnectedWires = table.create(4, false);
local SwitchStates = table.create(5, false);

local ActiveWire = nil
local IsPointerDown = false
local IsPullingLever = false
local IsUsingGamepad = false
local IsPullDebounced = false
local SwitchShown = false
local LeverShown = false

local LeverProgress = 0
local PullStartY = 0
local LastPullY = 0

local SwitchOnImage = 'rbxassetid://78906959431606'
local SwitchOffImage = 'rbxassetid://133499480186899'

local LightOnColor = Color3.fromRGB(255, 255, 255)
local LightOffColor = Color3.fromRGB(34, 34, 34)

-- <- Init -> --
GamepadService:EnableGamepadCursor(MainFrame);

-- <- Private Functions -> --
local function PlaySound(SoundName: string)
	local SoundTemplate = SFX:FindFirstChild(SoundName);
	if not SoundTemplate then
		return
	end

	local Sound = SoundTemplate:Clone();
	Sound.Parent = Interface
	Sound:Play();

	task.delay(1, function()
		if not Sound.Parent then
			return
		end

		local Duration = Sound.TimeLength / math.max(Sound.PlaybackSpeed, 0.01)
		task.delay(Duration, Sound.Destroy, Sound);
	end);

	return Sound
end

local function WaitForChildren(Parent: Instance, Amount: number)
	local Children = Parent:GetChildren();

	while #Children < Amount do
		task.wait();
		Children = Parent:GetChildren();
	end

	return Children
end

local function IsTableCompleted(List: {})
	for _, Value in next, List do
		if not Value then
			return false
		end
	end

	return true
end

local function Tween(Object: Instance, Time: number, Properties: {})
	local TweenObject = TweenService:Create(Object, TweenInfo.new(Time), Properties);
	TweenObject:Play();

	return TweenObject
end

local function GetMouseGuiObjects()
	return Player.PlayerGui:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y);
end

local function IsMouseOver(Object: GuiObject)
	for _, GuiObject in next, GetMouseGuiObjects() do
		if GuiObject == Object or GuiObject:IsDescendantOf(Object) then
			return true
		end
	end

	return false
end

local function SetSwitchState(Button: ImageButton, State: boolean, Animated: boolean?)
	Button.Image = State and SwitchOnImage or SwitchOffImage

	local Light = SwitchFrame.Light:FindFirstChild(Button.Name);
	if not Light then
		return
	end

	local Properties = {
		ImageColor3 = State and LightOnColor or LightOffColor,
	}

	if Animated then
		Tween(Light, 0.25, Properties);
	else
		Light.ImageColor3 = Properties.ImageColor3
	end
end

local function FadeInInterface()
	local FadeProperties = {}

	for _, Object in next, MainFrame:GetDescendants() do
		if Object:IsA('GuiObject') then
			local Properties = {
				BackgroundTransparency = Object.BackgroundTransparency,
			}

			if Object:IsA('ImageButton') or Object:IsA('ImageLabel') then
				Properties.ImageTransparency = Object.ImageTransparency
				Object.ImageTransparency = 1
			end
			if Object:IsA('TextButton') or Object:IsA('TextLabel') or Object:IsA('TextBox') then
				Properties.TextTransparency = Object.TextTransparency
				Object.TextTransparency = 1
			end

			Object.BackgroundTransparency = 1
			FadeProperties[Object] = Properties
		end
	end

	MainFrame.Position = UDim2.fromScale(0.5, 0.75)

	for Object, Properties in next, FadeProperties do
		Tween(Object, 0.5, Properties);
	end

	Tween(MainFrame, 0.5, {
		Position = UDim2.fromScale(0.5, 0.5),
	});
end

local function FadeOutInterface()
	for _, Object in next, MainFrame:GetDescendants() do
		if Object:IsA('GuiObject') then
			local Properties = {
				BackgroundTransparency = 1,
			}

			if Object:IsA('ImageButton') or Object:IsA('ImageLabel') then
				Properties.ImageTransparency = 1
			end
			if Object:IsA('TextButton') or Object:IsA('TextLabel') or Object:IsA('TextBox') then
				Properties.TextTransparency = 1
			end

			Tween(Object, 0.5, Properties);
		elseif Object:IsA('Path2D') then
			Tween(Object, 0.5, {
				Thickness = 1,
			});

			task.delay(0.25, function()
				Object.Visible = false
			end);
		end
	end

	Tween(MainFrame, 0.5, {
		Position = UDim2.fromScale(0.5, 0.75),
	});
end

-- <- Wires -> --
local WireBoxes = WaitForChildren(WireFrame.WireBoxes, 4);
local WireLength = math.max(math.sqrt(WireFrame.AbsoluteSize.X ^ 2 + WireFrame.AbsoluteSize.Y ^ 2) * 1.15, 1)

for _, WireBox in next, WireBoxes do
	local OtherWireBox = WireBoxes[math.random(#WireBoxes)]
	local Position = WireBox.Position

	WireBox.Position = OtherWireBox.Position
	OtherWireBox.Position = Position
end

local function SetupWire(StartPoint: GuiObject)
	local WireBox = WireFrame.WireBoxes:FindFirstChild(StartPoint.Name);
	local EndPoint = WireFrame.WiresEnd:FindFirstChild(StartPoint.Name);
	local Path = WireFrame:FindFirstChild(StartPoint.Name);

	if not WireBox or not EndPoint or not Path or not Path:IsA('Path2D') then
		return
	end

	local Hitbox = EndPoint:FindFirstChild('Hitbox');
	if not Hitbox or not Hitbox:IsA('GuiButton') then
		return
	end

	local DefaultEndPosition = EndPoint.AbsolutePosition - WireFrame.AbsolutePosition + EndPoint.AbsoluteSize / 2
	local StartPosition = StartPoint.AbsolutePosition - WireFrame.AbsolutePosition + StartPoint.AbsoluteSize / 2

	local CanDrag = true
	local DragConnection = nil
	local ReturnConnection = nil
	local WireOffset = 0
	local WireVelocity = 0

	local function DrawWire(X: number, Y: number, DeltaTime: number)
		local ControlPoints = Path:GetControlPoints();
		local PointAmount = #ControlPoints

		if PointAmount < 2 then
			return
		end

		ControlPoints[1].Position = UDim2.fromOffset(StartPosition.X, StartPosition.Y)
		ControlPoints[PointAmount].Position = UDim2.fromOffset(X, Y)

		local DeltaX = X - StartPosition.X
		local DeltaY = Y - StartPosition.Y
		local DistanceRatio = math.sqrt(DeltaX ^ 2 + DeltaY ^ 2) / WireLength
		local PullAlpha = math.clamp(DistanceRatio, 0, 1)

		WireVelocity += ((1 - DistanceRatio) * 150 * PullAlpha - WireOffset) * 150 * DeltaTime
		WireVelocity *= math.exp(DeltaTime * -2)
		WireOffset += WireVelocity * DeltaTime

		local MiddlePoints = PointAmount - 2
		for Index = 1, MiddlePoints do
			local Alpha = Index / (MiddlePoints + 1)
			local PointX = DeltaX * Alpha + StartPosition.X
			local PointY = DeltaY * Alpha + StartPosition.Y + WireOffset * (Alpha * 4 * (1 - Alpha))

			PointX = math.clamp(PointX, 16, WireFrame.AbsoluteSize.X - EndPoint.AbsoluteSize.X - 16)
			PointY = math.clamp(PointY, 16, WireFrame.AbsoluteSize.Y - EndPoint.AbsoluteSize.Y - 16)

			ControlPoints[Index + 1].Position = UDim2.fromOffset(PointX, PointY)
		end

		Path:SetControlPoints(ControlPoints);
		Path.Visible = true
	end

	local function ReturnWire()
		if DragConnection then
			DragConnection:Disconnect();
			DragConnection = nil
		end
		if ReturnConnection then
			ReturnConnection:Disconnect();
			ReturnConnection = nil
		end

		if ActiveWire == StartPoint then
			ActiveWire = nil
		end

		local CurrentPosition = Vector2.new(EndPoint.Position.X.Offset, EndPoint.Position.Y.Offset)
		local Elapsed = 0

		ReturnConnection = RunService.Heartbeat:Connect(function(DeltaTime)
			Elapsed += DeltaTime

			local Alpha = math.clamp(Elapsed / 0.25, 0, 1)
			local Position = CurrentPosition:Lerp(DefaultEndPosition, 1 - (1 - Alpha) ^ 3)

			EndPoint.Position = UDim2.fromOffset(Position.X, Position.Y)
			DrawWire(Position.X, Position.Y, DeltaTime);

			if Alpha >= 1 then
				ReturnConnection:Disconnect();
				ReturnConnection = nil

				Path.Visible = false
				WireOffset = 0
				WireVelocity = 0
			end
		end);
	end

	local function ConnectWire(DeltaTime: number)
		CanDrag = false
		ActiveWire = nil

		local ConnectPosition = WireBox.ConnectHitbox.AbsolutePosition + Vector2.yAxis * WireBox.ConnectHitbox.AbsoluteSize.Y / 2 - WireFrame.AbsolutePosition

		Tween(EndPoint, 0.1, {
			Position = UDim2.fromOffset(ConnectPosition.X, ConnectPosition.Y),
		});

		DrawWire(EndPoint.Position.X.Offset, EndPoint.Position.Y.Offset, DeltaTime);

		local WireIndex = tonumber(WireBox.Name)
		if WireIndex then
			ConnectedWires[WireIndex] = true
		end

		PlaySound('WireConnect');
		WireVelocity += 120

		local Elapsed = 0
		local Connection = nil

		Connection = RunService.Heartbeat:Connect(function(HeartbeatDelta)
			Elapsed += HeartbeatDelta

			DrawWire(EndPoint.Position.X.Offset, EndPoint.Position.Y.Offset, HeartbeatDelta);

			if Elapsed >= 4 then
				Connection:Disconnect();
			end
		end);
	end

	Hitbox.MouseButton1Down:Connect(function()
		if not CanDrag or ActiveWire then
			return
		end

		if DragConnection then
			DragConnection:Disconnect();
			DragConnection = nil
		end
		if ReturnConnection then
			ReturnConnection:Disconnect();
			ReturnConnection = nil
		end

		IsPointerDown = true
		ActiveWire = StartPoint

		DragConnection = RunService.Heartbeat:Connect(function(DeltaTime)
			local MousePosition = Vector2.new(Mouse.X, Mouse.Y)
			local IsOverBox = IsMouseOver(WireBox)

			if IsPointerDown and not IsOverBox and ActiveWire == StartPoint then
				local Delta = MousePosition - (WireFrame.AbsolutePosition + StartPosition)
				local DeltaX = Delta.X
				local DeltaY = Delta.Y
				local Distance = math.sqrt(DeltaX ^ 2 + DeltaY ^ 2)

				if Distance > WireLength then
					local Scale = WireLength / Distance
					DeltaX *= Scale
					DeltaY *= Scale
				end

				local PositionX = math.clamp(DeltaX + StartPosition.X, 16, WireFrame.AbsoluteSize.X - EndPoint.AbsoluteSize.X - 16)
				local PositionY = math.clamp(DeltaY + StartPosition.Y, 16, WireFrame.AbsoluteSize.Y - EndPoint.AbsoluteSize.Y - 16)

				EndPoint.Position = UDim2.fromOffset(PositionX, PositionY)
				DrawWire(PositionX, PositionY, DeltaTime);

				return
			end

			DragConnection:Disconnect();
			DragConnection = nil

			if IsOverBox then
				ConnectWire(DeltaTime);
			else
				ReturnWire();
			end
		end);
	end);
end

for _, StartPoint in next, WireFrame.WiresStart:GetChildren() do
	if StartPoint:IsA('GuiObject') then
		SetupWire(StartPoint);
	end
end

-- <- Switches -> --
local SwitchPosition = SwitchFrame.Position
SwitchFrame.Position = WireFrame.Position
SwitchFrame.Visible = false

local SwitchButtons = WaitForChildren(SwitchFrame.Switches, 5);

for _, Button in next, SwitchButtons do
	if Button:IsA('ImageButton') then
		local SwitchIndex = tonumber(Button.Name)
		if SwitchIndex then
			SwitchStates[SwitchIndex] = math.random(2) == 1
			SetSwitchState(Button, SwitchStates[SwitchIndex], false);

			Button.MouseButton1Click:Connect(function()
				if PuzzleState.Switches or not PuzzleState.Wires then
					return
				end

				PlaySound('Switch');

				SwitchStates[SwitchIndex] = not SwitchStates[SwitchIndex]
				SetSwitchState(Button, SwitchStates[SwitchIndex], true);
			end);
		end
	end
end

if IsTableCompleted(SwitchStates) then
	SwitchStates[1] = false

	local FirstSwitch = SwitchFrame.Switches:FindFirstChild('1');
	if FirstSwitch and FirstSwitch:IsA('ImageButton') then
		SetSwitchState(FirstSwitch, false, false);
	end
end

local function ShowSwitches()
	if SwitchShown then
		return
	end
	SwitchShown = true

	SwitchFrame.Visible = true
	Tween(SwitchFrame, 0.5, {
		Position = SwitchPosition,
	});
end

-- <- Lever -> --
local LeverPosition = LeverFrame.Position
LeverFrame.Position = WireFrame.Position
LeverFrame.Visible = false

local RopePosition = LeverFrame.Rope.Position
local ProgressBarSize = UDim2.fromOffset(0, LeverFrame.ProgressBar.Fill.Bar.Size.Y.Offset)
LeverFrame.ProgressBar.Fill.Bar.Size = ProgressBarSize

local function ShowLever()
	if LeverShown then
		return
	end
	LeverShown = true

	LeverFrame.Visible = true
	Tween(LeverFrame, 0.5, {
		Position = LeverPosition,
	});
end

local function CompletePuzzle()
	if PuzzleState.Lever then
		return
	end
	PuzzleState.Lever = true

	PlaySound('PuzzleComplete');
	script.Event:FireServer(PuzzleState);

	GamepadService:DisableGamepadCursor();
	FadeOutInterface();
end

LeverFrame.Rope.Button.MouseButton1Down:Connect(function()
	IsPullingLever = true
	IsPointerDown = true

	PullStartY = Mouse.Y
	LastPullY = Mouse.Y
end);

LeverFrame.Rope.Button.MouseButton1Up:Connect(function()
	IsPullingLever = false
end);

-- <- Input -> --
UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
		IsPointerDown = false
		IsPullingLever = false
	end

	if Input.UserInputType == Enum.UserInputType.Gamepad1 then
		IsUsingGamepad = true
	end

	if Input.KeyCode == Enum.KeyCode.ButtonB then
		GamepadService:DisableGamepadCursor();
		script.Event:FireServer('Exit');
	end
end);

-- <- Runtime -> --
FadeInInterface();

RunService.Heartbeat:Connect(function()
	if not PuzzleState.Wires and IsTableCompleted(ConnectedWires) then
		PuzzleState.Wires = true
	end

	if PuzzleState.Wires then
		ShowSwitches();
	end

	if not PuzzleState.Switches and PuzzleState.Wires and IsTableCompleted(SwitchStates) then
		PuzzleState.Switches = true
	end

	if PuzzleState.Switches then
		ShowLever();
	end

	if not PuzzleState.Wires or not PuzzleState.Switches then
		return
	end

	local PullDelta = 0

	if IsPullingLever and LeverProgress < 100 then
		PullDelta = Mouse.Y - LastPullY

		local PullThreshold = IsUsingGamepad and 14 or 25
		local DebounceTime = IsUsingGamepad and 0.2 or 0.1

		if Mouse.Y - PullStartY > PullThreshold and PullDelta > 0 and not IsPullDebounced then
			IsPullDebounced = true
			LeverProgress += 10

			PlaySound('Pull');

			task.delay(DebounceTime, function()
				IsPullDebounced = false
			end);
		end
	end

	LastPullY = Mouse.Y

	Tween(LeverFrame.Rope, 0.05, {
		Position = RopePosition + UDim2.fromOffset(0, math.clamp(PullDelta, 0, 200)),
	});

	Tween(LeverFrame.ProgressBar.Fill.Bar, 0.05, {
		Size = ProgressBarSize + UDim2.fromScale(LeverProgress / 100, 0),
	});

	if LeverProgress >= 100 then
		CompletePuzzle();
	end
end);