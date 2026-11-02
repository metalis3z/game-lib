-- Written proudly by Quenty

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local InputService = game:GetService("UserInputService");
local Phone = (InputService.TouchEnabled)-- and not InputService.KeyboardEnabled);

local GameGUI = game.Players.LocalPlayer.PlayerGui.MainGUI;
if InputService.TouchEnabled then
	if GameGUI.Game:FindFirstChild("Knife") then
		GameGUI.Game.Knife.Visible = true
		--GameGUI.Game.Knife.ImageLabel.Image = "http://www.roblox.com/asset/?id=197518111";
	end;
end

local function WaitForChild(Parent, Name, TimeLimit)
	-- Waits for a child to appear. Not efficient, but it shoudln't have to be. It helps with debugging. 
	-- Useful when ROBLOX lags out, and doesn't replicate quickly.
	-- @param TimeLimit If TimeLimit is given, then it will return after the timelimit, even if it hasn't found the child.

	assert(Parent ~= nil, "Parent is nil")
	assert(type(Name) == "string", "Name is not a string.")

	local Child     = Parent:FindFirstChild(Name)
	local StartTime = tick()
	local Warned    = false

	while not Child and Parent do
		wait(0)
		Child = Parent:FindFirstChild(Name)
		if not Warned and StartTime + (TimeLimit or 5) <= tick() then
			Warned = true
			warn("Infinite yield possible for WaitForChild(" .. Parent:GetFullName() .. ", " .. Name .. ")")
			if TimeLimit then
				return Parent:FindFirstChild(Name)
			end
		end
	end

	if not Parent then
		warn("Parent became nil.")
	end

	return Child
end

local function GetCharacter(Descendant)
	-- Returns the Player and Charater that a descendent is part of, if it is part of one.
	-- @param Descendant A child of the potential character. 

	local Charater = Descendant
	local Player   = Players:GetPlayerFromCharacter(Charater)

	while not Player do
		if Charater.Parent then
			Charater = Charater.Parent
			Player   = Players:GetPlayerFromCharacter(Charater)
		else
			return nil
		end
	end

	-- Found the player, character must be true.
	return Charater, Player
end

local function GetHumanoid(Descendant)
	-- Return's a humanoid in the parent structure if it can find it. Intended to be used in workspace	 only.
	-- Useful for weapon scripts, and all that, especially to work on non player targets.
	-- Will scan *up* to workspace	. If workspace	 has a humanoid in it, it won't find it.

	-- Will work even if there are non-humanoid objects named "Humanoid"
	-- However, only works on objects named "Humanoid" (this is intentional)

	-- @param Descendant The child you're searching up from. Really, this is for weapon scripts. 
	-- @return Humanoid, or nil. 
	
	while true do
		local Humanoid = Descendant:FindFirstChild("Humanoid")

		if Humanoid then
			if Humanoid:IsA("Humanoid") then
				return Humanoid
			else -- Incase there are other humanoids in there.
				for _, Item in pairs(Descendant:GetChildren()) do
					if Item.Name == "Humanoid" and Item:IsA("Humanoid") then
						return Item
					end
				end
			end
		end

		if Descendant.Parent and Descendant:IsDescendantOf(workspace	) then
			Descendant = Descendant.Parent
		else
			return nil
		end
	end
end

local function Modify(Instance, Values)
	-- Modifies an Instance by using a table.  

	assert(type(Values) == "table", "Values is not a table");

	for Index, Value in next, Values do
		if type(Index) == "number" then
			Value.Parent = Instance
		else
			Instance[Index] = Value
		end
	end
	return Instance
end

local function CheckPlayer(Player)
	--- Makes sure a player has all necessary components.
	-- @return Boolean If the player has all the right components

	return Player and Player:IsA("Player") and Player:IsDescendantOf(Players)
end

local function CheckCharacter(Player)
	-- Makes sure a character has all the right "parts"
	
	if CheckPlayer(Player) then
		local Character = Player.Character;

		if Character then
			
			return Character.Parent
				and Character:FindFirstChild("Humanoid")
				and Character:FindFirstChild("HumanoidRootPart")
				and Character:FindFirstChild("UpperTorso") 
				and Character:FindFirstChild("Head") 
				and Character.Humanoid:IsA("Humanoid")
				and Character.Head:IsA("BasePart")
				and Character.UpperTorso:IsA("BasePart")
				and true
		end
	else
		warn("[CheckCharacter] - Character Check failed!")
	end

	return nil
end

local function Make(ClassType, Properties)
	-- Using a syntax hack to create a nice way to Make new items.  

	return Modify(Instance.new(ClassType), Properties)
end

local Knife = script.Parent
local Handle = WaitForChild(Knife, "Handle")
local KnifeServer = WaitForChild(Knife, "KnifeServer")
local SlashStart = WaitForChild(KnifeServer, "SlashStart")
local Lock = WaitForChild(KnifeServer,"Lock")
local RemoteDestroy = WaitForChild(KnifeServer, "DestroyEvent")


local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local MakeMaid = require(WaitForChild(Knife, "Maid")).MakeMaid

local SoundPlayer = {} do
	local SoundNames = {
		"Ting";
		"Gunshot";
		"Woosh";
		"Kill";
	}
	
	local Sounds = {}
	for _, SoundName in pairs(SoundNames) do
		local Sound = Handle:FindFirstChild("Sound_" .. SoundName)
		if not Sound then
			Sound = WaitForChild(script, SoundName):Clone()
			Sound.Parent = Handle
			Sound.Name = "Sound_" .. SoundName
		end
		Sounds[SoundName] = Sound
	end
	
	function SoundPlayer:PlaySound(SoundName)
		if Sounds[SoundName] then
			Sounds[SoundName]:Play()
		else
			print("Could not find sound")
		end
	end
end

local AnimationManager = {} do
	local AnimationNames = {
		"DownStab";
		"StabPunch";
		"Throw";
		"ThrowCharge";
	}
	
	local Animations = {}
	
	assert(coroutine.resume(coroutine.create(function()
		while not CheckCharacter(LocalPlayer) and Knife:IsDescendantOf(game) do
			wait()
		end
		local Humanoid = LocalPlayer.Character.Humanoid
		
		for _, AnimationName in pairs(AnimationNames) do
			Animations[AnimationName] = Humanoid:LoadAnimation(WaitForChild(script, AnimationName))
		end
	end)))
	
	function AnimationManager:PlayAnimation(AnimationName)
		if Animations[AnimationName] then
			Animations[AnimationName]:Play()
		else
			warn("Could not find animation", AnimationName)
		end
	end
	
	function AnimationManager:StopAnimation(AnimationName)
		if Animations[AnimationName] then
			Animations[AnimationName]:Stop()
		else
			warn("Could not find animation", AnimationName)
		end
	end
end
--------

local Maid = MakeMaid()
local LocalRender = workspace:FindFirstChild("LocalKnifeRender") or Make("Camera", {
	Name = "LocalKnifeRender";
	Parent = workspace;
	Archivable = false;
})

-- Clean up any messed up knifes that didn't get GC for some reason...
for _, Item in pairs(LocalRender:GetChildren()) do
	Item.Parent = nil
end

local KnifeInFirstPersonHijacker = {} do
	-- Mwhahaah. Such hack, very wow
	local AnimationId = 0
	local CurrentFakeHandle 
	
	function KnifeInFirstPersonHijacker:SetTransparency(NewTransparency)
		if CurrentFakeHandle then
			CurrentFakeHandle.Transparency = NewTransparency
		end
	end
	
	function KnifeInFirstPersonHijacker:Enable()
		local LocalAnimationId = AnimationId + 1
		AnimationId = LocalAnimationId
		
		assert(coroutine.resume(coroutine.create(function()
			local FakeHandle = Handle:Clone()
			FakeHandle.Anchored = true
			FakeHandle.Parent = LocalRender
			FakeHandle.Transparency = 1
			for i,v in pairs(FakeHandle:GetDescendants()) do
				if v:IsA("Decal") then
					v.Transparency = 1
				end
			end
			CurrentFakeHandle = FakeHandle
			
			for i,e in pairs(Handle:GetChildren()) do
				if e:IsA("Decal") then
					e.Transparency = 0
				end
			end
			
			while AnimationId == LocalAnimationId do
				if CheckCharacter(LocalPlayer) then
					
					-- Transpose CFrames. :D
					local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
					local NormalCameraPosition = (HumanoidRootPart.CFrame + Vector3.new(0, 1.5, 0)) * CFrame.new(0, 0, 0.5)
					local RelativeKnifePosition = NormalCameraPosition:toObjectSpace(Handle.CFrame)
					
					-- FE, you better work.
					Handle.Transparency = 0
					FakeHandle.CFrame = workspace.CurrentCamera.CoordinateFrame:toWorldSpace(RelativeKnifePosition)
					for i,c in pairs(Handle:GetChildren()) do
						if c:IsA("Decal") then
							c.Transparency = 0
						end
					end
				end
				RunService.RenderStepped:wait()
			end
			FakeHandle:Destroy()
			CurrentFakeHandle = nil
			Handle.Transparency = 0;
			
			for i,e in pairs(Handle:GetChildren()) do
				if e:IsA("Decal") then
					e.Transparency = 0
				end
			end
		end)))
	end	
	
	function KnifeInFirstPersonHijacker:Disable()
		AnimationId = AnimationId + 1
	end	
end


local FlingDebounce = false
local StabDebounce = false -- Players can still fling while stabbing. 
local KnifeFlingReloadTime = 1.5

local function GetGripWeld()
	if CheckCharacter(LocalPlayer) then
		if LocalPlayer.Character:FindFirstChild("Right Hand") then
			return LocalPlayer.Character["Right Hand"]:FindFirstChild("RightGrip")
		end
	end
end

local function StabKnife(Part)
	if not FlingDebounce and not StabDebounce then
		_G.LockTarget = nil;
		StabDebounce = true
		local Pos = (Part==nil and Mouse.Hit.p) or Part.Position;
		SlashStart:FireServer(1,Pos) -- 1.0 is the time it takes to slash, appprox. 
		local GripWeld = GetGripWeld()
		local OldC1
		
		--SoundPlayer:PlaySound("Gunshot")
		
		--AnimationManager:PlayAnimation("DownStab")
		wait(0.01);
		StabDebounce = false
	end
end

local FirstPerson = _G.IsFirstPerson
local LockTarget = nil;
local Locked = nil;

local function CheckTapPosition(TouchPositions)
	local Pos = (type(TouchPositions)=="table" and TouchPositions[1]) or TouchPositions;
	local FrameTable = {};
	for _,Frame in pairs(LocalPlayer.PlayerGui.TouchGui.TouchControlFrame:GetChildren()) do
		if Frame.Visible then table.insert(FrameTable,Frame) end;
	end;
	
	
	
	for _,Frame in pairs(FrameTable) do
		local S,P = Frame.AbsoluteSize,Frame.AbsolutePosition;
		local X1,X2,Y1,Y2 = P.X, P.X + math.abs(S.X), P.Y, P.Y + math.abs(S.Y);
		if Pos.X >= X1 and Pos.X <=X2 and Pos.Y >= Y1 and Pos.Y<=Y2 then 
			return nil;
		end;
	end;
	
	return Pos;
end
_G.LockTarget = nil;
local InputService = game:GetService("UserInputService");
Knife.Equipped:connect(function(Mouse)
	if FirstPerson then
		KnifeInFirstPersonHijacker:Enable()
	end;
	SoundPlayer:PlaySound("Ting")
	
	Mouse.Icon = "http://www.roblox.com/asset/?id=79658449"
	
	if not Phone then
		Maid.MouseButton1Down = Mouse.Button1Down:connect(function()
			StabKnife()
		end)
	else
		Maid.TouchTap = InputService.TouchTap:connect(function(TouchPositions)
			if not FirstPerson then
				local Pos = CheckTapPosition(TouchPositions);
				if Pos then
					local ScreenRay =  game.Workspace.CurrentCamera:ScreenPointToRay(Pos.X,Pos.Y);
					local Ray = Ray.new(ScreenRay.Origin,ScreenRay.Direction*900)
					local Part = game.Workspace:FindPartOnRay(Ray,game.Players.LocalPlayer.Character)
					if Part then 
						if Part.Parent and Part.Parent.Parent then
							local Player = game.Players:GetPlayerFromCharacter(Part.Parent) or game.Players:GetPlayerFromCharacter(Part.Parent.Parent);
							if Player and Player ~= LocalPlayer then
								StabKnife(Player.Character.UpperTorso);
							end
						end;
					end;
				end;
			end;
		end)
		
		Maid.TouchStarted = InputService.TouchStarted:connect(function(Input)
			wait();
			local TapPosition = CheckTapPosition(Input.Position)
			if TapPosition then
				_G.LockTarget = nil;
			end;
		end)
		
		Maid.TouchEnded = InputService.TouchEnded:connect(function()
			if LockTarget and FirstPerson then
				_G.LockTarget = LockTarget;
	
			end
		end);
	end;
	
	--[[local TouchStab = 0;
	Maid.Touch = InputService.InputBegan:connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch then
			TouchStab = tick();
		end
	end)
	Maid.UnTouch = InputService.InputEnded:connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch then
			if tick()-TouchStab <= 0.3 then
				StabKnife();
			end;	
		end;
	end)]]
	
end)

if Phone then
	
	--local Gyro = Instance.new("BodyGyro",LocalPlayer.Character.UpperTorso);

	for _,Player in pairs(game.Workspace:GetChildren()) do
		if Player:FindFirstChild("Humanoid") and Player:FindFirstChild("UpperTorso") and Player.Name ~= LocalPlayer.Name then
			script.Target:Clone().Parent = Player.UpperTorso;
		end
	end;
	


	game:GetService("RunService"):BindToRenderStep("Stabber",1,function()
		LockTarget = nil;
		for _,Player in pairs(game.Workspace:GetChildren()) do
			if Player:FindFirstChild("Humanoid") and Player:FindFirstChild("UpperTorso") and Player.UpperTorso:FindFirstChild("Target") and Player.Name ~= LocalPlayer.Name and game.Players:GetPlayerFromCharacter(Player) then
				Player.UpperTorso.Target.Enabled = false;
				Player.UpperTorso.Target.AlwaysOnTop = false;
				local _,CanSee = game.Workspace.CurrentCamera:WorldToScreenPoint(Player.UpperTorso.Position);
				if CanSee then
					local HeadPosition = LocalPlayer.Character.Head.Position;
					local Ray1 = Ray.new(HeadPosition,(Player.UpperTorso.Position-HeadPosition).unit * 300)
					local Part = game.Workspace:FindPartOnRay(Ray1,LocalPlayer.Character);
					if Part.Parent == Player or Part.Parent.Parent == Player then
						Player.UpperTorso.Target.Enabled = true;
						Player.UpperTorso.Target.AlwaysOnTop = true;
						--local Pos = LocalPlayer.PlayerGui.MainMobile.Center.AbsolutePosition;
						local Size = LocalPlayer.PlayerGui.MainGUI.AbsoluteSize
						local Pos = Vector2.new(Size.X/2,Size.Y/2);-- Pos.X = Pos.X/2; Pos.Y = Pos.Y/2;
						local ScreenRay =  game.Workspace.CurrentCamera:ScreenPointToRay(Pos.X,Pos.Y);
						local Ray2 = Ray.new(ScreenRay.Origin,ScreenRay.Direction*900)
						local Part2 = game.Workspace:FindPartOnRay(Ray2,game.Players.LocalPlayer.Character)
						if Part2.Parent == Player then
							LockTarget = Player;
							if not _G.LockTarget then
								Player.UpperTorso.Target.Icon.ImageColor3 = Color3.new(1,1,1);
							else
								Player.UpperTorso.Target.Icon.ImageColor3 = Color3.new(0,1,0);
							end;
						else
							Player.UpperTorso.Target.Icon.ImageColor3 = Color3.new(1,0,0);
						end;
					end
				end;
			elseif Player:FindFirstChild("UpperTorso") and Player:FindFirstChild("UpperTorso"):FindFirstChild("Target") then
				Player.UpperTorso.Target:Destroy();
			end;
		end;
	end)
end

Knife.Unequipped:connect(function()
	SoundPlayer:PlaySound("Ting")
	
	Maid.MouseButton1Down = nil
	Maid.MouseButton2Down = nil
	Maid.MouseButton2Up = nil
	Maid.TouchTap = nil;
	Maid.TouchEnded = nil;
	Lock:FireServer(nil);
	KnifeInFirstPersonHijacker:Disable()
end)

RemoteDestroy.OnClientEvent:connect(function()
	KnifeInFirstPersonHijacker:Disable();
end)




local FirstPersonLast = FirstPerson;
game:GetService("RunService"):BindToRenderStep("FirstPerson",0,function()
	FirstPerson = _G.IsFirstPerson;	
	
	if FirstPerson and not FirstPersonLast then
		KnifeInFirstPersonHijacker:Enable();
	elseif not FirstPerson and FirstPersonLast then
		KnifeInFirstPersonHijacker:Disable();
	end;
	
	FirstPersonLast = FirstPerson;
end);





local SoundDe = false

-- Written proudly by Quenty








