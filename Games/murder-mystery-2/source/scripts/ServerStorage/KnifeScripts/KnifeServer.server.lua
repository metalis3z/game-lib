-- Written proudly by Quenty

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local Effects = game.ReplicatedStorage.GetSyncDataServer:Invoke("Effects");
local LocalPlayer = Players[script.Parent.Parent.Parent.Name];
local EquippedEffect = game.ReplicatedStorage.GetDataServer:Invoke(script.Parent.Parent.Parent,"Effects").Equipped[1];



if Effects[EquippedEffect] ~= nil and EquippedEffect ~= "None" then
	pcall(function()require(Effects[EquippedEffect]["KnifeModule"])(script.Parent);end)
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

local function CheckPlayer(Player)
	--- Makes sure a player has all necessary components.
	-- @return Boolean If the player has all the right components

	return Player and Player:IsA("Player") and Player:IsDescendantOf(Players)
end
game.ReplicatedStorage.DestroyKnife.Event:Connect(function()
	script.Parent:Destroy()
end)
game.ReplicatedStorage.EndRound.Event:Connect(function()
	for _,Part in pairs(script.Parent:GetChildren()) do
		if Part:IsA("BasePart") or Part:IsA("Decal") then
			Part.Transparency = 0
		end
	end
	script.Disabled = true
	
end)
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


local function Make(ClassType, Properties)
	-- Using a syntax hack to create a nice way to Make new items.  

	return Modify(Instance.new(ClassType), Properties)
end

local function DrawPoint(Position, Color, Parent)
	--- FOR DEBUGGING

	local NewDraw = Make("Part", {
		Parent        = Parent or workspace;
		Size          = Vector3.new(1, 1, 1);
		Transparency  = 0.5;
		BrickColor    = Color or BrickColor.new("Bright red");
		Name          = "PointRender";
		Archivable    = false;
		Anchored      = true;
		CanCollide    = false;
		TopSurface    = "Smooth";
		BottomSurface = "Smooth";
		Shape         = "Ball";
	})
	NewDraw.CFrame = CFrame.new(Position);

	return NewDraw
end



local Knife = script.Parent
local Handle = WaitForChild(Knife, "Handle")

local PlayerData = game.ReplicatedStorage.GetPlayerData_REMOTE:Invoke();


local KnifeServer = script
local FlingKnifeEvent = WaitForChild(KnifeServer, "FlingKnifeEvent")
local SetKnifeGoneTime = WaitForChild(KnifeServer, "SetKnifeGoneTime")
local SlashStart = WaitForChild(KnifeServer, "SlashStart")

local ThrowingKinfeHandlerScript = WaitForChild(script, "ThrowingKinfeHandlerScript")

local MakeMaid = require(WaitForChild(Knife, "Maid")).MakeMaids
local MakeFlyingHandle = require(WaitForChild(Knife, "MakeFlyingHandle"))
local MakeFlyingClientHandle = require(WaitForChild(Knife, "MakeFlyingHandleClone"))

local function FlingKnife(Player, Direction, GUID)
	local FlyingHandle = MakeFlyingHandle(Handle, Direction)
	
	local Ray1 = Ray.new(FlyingHandle.Position,(Direction.p-FlyingHandle.Position).unit)
	local V = Ray1.Direction*1.3;
	FlyingHandle.VelocityV.Value = V;
	Instance.new("BodyPosition",FlyingHandle);
	
	FlyingHandle.Parent = game.Workspace;
	
	local Script = ThrowingKinfeHandlerScript:Clone()
	Script.creator.Value = Player
	Script.Parent = FlyingHandle
	Script.Disabled = false
	FlingKnifeEvent:FireClient(Player, GUID)
end


--local Stealthed = false;

local function Fade(Player,In)
	if Player ~= LocalPlayer then return end;
	local Frames = 10;
	for i = 1,Frames do
		Handle.Transparency = (In and (Handle.Transparency + 1/Frames)) or (Handle.Transparency - 1/Frames);
		for _,Obj in pairs(Handle:GetChildren()) do 
			local Effect = pcall(function() return Obj["Enabled"] end)
			if Effect then Obj.Enabled = not In; end;
		end;
	end
end


local FakeActive = false;
game.ReplicatedStorage.Remotes.Gameplay.FakeGun.OnServerEvent:connect(function(Player,Activate)
	FakeActive = Activate;
end);

script.Parent.ChildAdded:connect(function(Child)
	if Child.Name == "Dual" and FakeActive then
		wait();
		Child:Destroy();
	end
end)

FlingKnifeEvent.OnServerEvent:connect(function(Player, Direction, GUID)
	if GUID and Direction and CheckCharacter(Player) and Player.Character.Humanoid.Health > 0 then
		--if Stealthed then
			--Unstealth();
		--end
		FlingKnife(Player, Direction, GUID)
	else
		warn("No direction or invalid character or GUID.")
	end
end)

local KnifeVisible = true
SetKnifeGoneTime.OnServerEvent:connect(function(Player, Time)
	KnifeVisible = false
	for _,Part in pairs(Handle:GetChildren()) do
		if Part:IsA("BasePart") or Part:IsA("Decal") then
			Part.Transparency = 1
		end
	end
	Handle.Transparency= 1
	wait(Time)
	KnifeVisible = true
	for _,Part in pairs(Handle:GetChildren()) do
		if Part:IsA("BasePart") or Part:IsA("Decal") then
			Part.Transparency = 0
		end
	end
	Handle.Transparency = 0
end)


local Slashing = false
local SlashingId = 0
SlashStart.OnServerEvent:connect(function(Player, Time)
	--if Stealthed then
		--Unstealth();
	--end
	local LocalSlashingId = SlashingId + 1
	SlashingId = LocalSlashingId
	
	Slashing = true
	wait(Time)
	if LocalSlashingId == SlashingId then
		Slashing = false
	end
end)


--[[function Stealth()
	Stealthed = true;
	local Char = game.Players:GetPlayerFromCharacter(Knife.Parent).Character;
	script.Stealth:FireAllClients();
	for i = 1,10 do
		if Stealthed then
			for _,Part in pairs(Char:GetChildren()) do
				if Part:IsA("BasePart") then
					Part.Transparency = Part.Transparency + 0.1
					Handle.Transparency = Handle.Transparency + 0.1
				end;
			end
			Char.Head.face.Transparency = Char.Head.face.Transparency + 0.1;
			Handle.Transparency = Handle.Transparency + 0.1;
			wait(0.05);
		end
	end
	wait(4);
	Unstealth();
end]]

--[[function Unstealth()
	Stealthed = false;
	script.Unstealth:FireAllClients();
	local Char = game.Players:GetPlayerFromCharacter(Knife.Parent).Character;
	for i = 1,10 do
		for _,Part in pairs(Char:GetChildren()) do
			if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
				Part.Transparency = Part.Transparency - 0.1;
			end;
		end
		Char.Head.face.Transparency = Char.Head.face.Transparency - 0.1;
		Handle.Transparency = 0;
		wait(0.05);
	end
end

game.ReplicatedStorage.Invisible.OnServerEvent:connect(Stealth)]]

Handle.Touched:connect(function(Part)
	if KnifeVisible and Slashing then
		local Humanoid = GetHumanoid(Part)
		if Humanoid and game.Players:GetPlayerFromCharacter(Humanoid.Parent) then

			if game.Players:GetPlayerFromCharacter(Knife.Parent) ~= game.Players:GetPlayerFromCharacter(Humanoid.Parent) then
				local Killer = game.Players:GetPlayerFromCharacter(Knife.Parent);
				local Victim = game.Players:GetPlayerFromCharacter(Humanoid.Parent);
				game.ReplicatedStorage.Remotes.Gameplay.KnifeKill:Fire(Killer,Victim,Humanoid,"Melee");
				script.Kill:FireAllClients();
			end;
			

			--[[ then
				if script.GameMode.Value == "Classic" or script.GameMode.Value == "Massacre" or script.GameMode.Value == "Juggernaut" then
					local CreatorTag = Instance.new("ObjectValue")
					CreatorTag.Name = "Creator";
					CreatorTag.Value = game.Players:GetPlayerFromCharacter(Knife.Parent);
					CreatorTag.Parent = Humanoid;
					script.Kill:FireAllClients();
					Humanoid:TakeDamage(100)					
				elseif script.GameMode.Value == "Infection" then
					local char,NewZombie = GetCharacter(Humanoid);
					pcall(function()
						if char.Colors.UpperTorsoColor ~= BrickColor.new("Bright green") then
							game.ServerScriptService.GameScript.Set.PlayerData:Fire(NewZombie.Name,"Dead",true);
							game.ServerScriptService.GameScript.Set.PlayerData:Fire(NewZombie.Name,"Role","Murderer")
							game.ServerScriptService.GameScript.Set.PlayerData:Fire(NewZombie.Name,"Color",BrickColor.new("Bright green"))
						end;
					end);
				end;
			end;]]
		end
	end
end)


-- Written proudly by Quenty