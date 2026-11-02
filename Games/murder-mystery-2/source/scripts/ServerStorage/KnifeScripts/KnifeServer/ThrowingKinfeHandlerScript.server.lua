-- Written proudly by Quenty

local Blade = script.Parent
local Blade2 = script.Parent:Clone()
Blade2.ThrowingKinfeHandlerScript:Destroy()
Blade2.Name = "ThrowingKnife"
Blade2.Parent = workspace
Blade2.Transparency = 0
for _,Part in pairs(Blade2:GetChildren()) do
	if (Part:IsA("Decal") or Part:IsA("BasePart")) and Part.Name ~= "Vector2" then
		Part.Transparency = 0
	end
end
local TouchPart = Instance.new("Part",Blade)
TouchPart.Name = "Vector2"
TouchPart.Size = Vector3.new(0.1,0.5,0.1)
TouchPart.Transparency = 1
TouchPart.CFrame = Blade.CFrame
local Weld = Instance.new('Weld')
Weld.Part0 = TouchPart
Weld.Part1 = Blade
Weld.Parent = script.Parent
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

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


local function Make(ClassType, Properties)
	-- Using a syntax hack to create a nice way to Make new items.  

	return Modify(Instance.new(ClassType), Properties)
end

local function WeldTogether(Part0, Part1, JointType, WeldParent)
	--- Weld's 2 parts together
	-- @param Part0 The first part
	-- @param Part1 The second part (Dependent part most of the time).
	-- @param [JointType] The type of joint. Defaults to weld.
	-- @param [WeldParent] Parent of the weld, Defaults to Part0 (so GC is better).
	-- @return The weld created.

	JointType = JointType or "Weld"

	local NewWeld = Make(JointType, {
		Part0  = Part0;
		Part1  = Part1;
		C0     = CFrame.new();--Part0.CFrame:inverse();
		C1     = Part1.CFrame:toObjectSpace(Part0.CFrame); --Part1.CFrame:inverse() * Part0.CFrame;-- Part1.CFrame:inverse();
		Parent = WeldParent or Part0;
	})

	return NewWeld
end


local creator = WaitForChild(script, "creator")
local Event

local Flying = true;

Event = TouchPart.Touched:connect(function(Part)
	if Part.Name == "KnifeThru" then return; end;
	if Part.Name == "Trigger" then return end;
	local DoRemove = true
	local Character, Player = GetCharacter(Part)	
	
	-- For lcoal testing
	if Part and Part.Parent and Part.Parent.Name == "LocalKnifeRender" then
		DoRemove = false
	end
	
	--local NewCreator
	local Stuck = false;
	local HitPlayer = false;
	
	local Humanoid = GetHumanoid(Part)
	if Humanoid then
		if Player and Character and creator.Value and Player == creator.Value then
			--print("[ThrowingKinfeHandlerScript] - Hit creator, will not damage or remove.")
			DoRemove = false
		else
			--NewCreator = creator:Clone()
			--NewCreator.Name = "Creator2";
			--NewCreator.Parent = Humanoid;
			if Humanoid.Health > 0 then
				Stuck = true;
			end
			--Debris:AddItem(NewCreator, 5)
			HitPlayer = true;
		end
	end
	
	if DoRemove then
		Flying = false;
		Blade.Transparency = 0
		Blade2:Destroy()
		for _,Part in pairs(Blade:GetChildren()) do
			if (Part:IsA("Decal") or Part:IsA("BasePart")) and Part.Name ~= "Vector2" then
				Part.Transparency = 0
			end
		end
		Blade.BodyPosition:Destroy();
		
		if Event then
			Event:disconnect()
			Event = nil
		end
		

		local HitPart, HitPosition = workspace:FindPartOnRayWithIgnoreList(
			Ray.new(Blade.Position-Blade.VelocityV.Value+(Blade.VelocityV.Value/2), Blade.VelocityV.Value), --Part.Position - Blade.Position),
			{Blade}
		)
		Blade.CFrame = CFrame.new(HitPosition, HitPosition + Blade.VelocityV.Value) * CFrame.Angles(math.rad(-120),0,0);
		
		Blade.Anchored = true;
		
		if HitPlayer then
			game.ReplicatedStorage.Remotes.Gameplay.KnifeKill:Fire(creator.Value,game.Players:GetPlayerFromCharacter(Humanoid.Parent),Humanoid,"Throwing")
			Blade.Parent = Humanoid.Parent;
			Blade.Name = "Blade";
			Blade:Destroy()
		end

		if not Stuck then
			wait(3);
			Blade:Destroy()
		end;
	end
end)

while Flying do
	Blade.CFrame = script.Parent.CFrame * CFrame.Angles(-math.pi/15,0,0) + Blade.VelocityV.Value;
	Blade.BodyPosition.position = Blade.Position;
	Blade.Anchored = false;
	game:GetService("RunService").Heartbeat:wait();
end

-- Written proudly by Quenty
