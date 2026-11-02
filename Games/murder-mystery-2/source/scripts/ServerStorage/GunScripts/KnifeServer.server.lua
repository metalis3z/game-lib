--- Rhavi stop messing around here, you messed it up already.































































































































































-- Written proudly by Quenty

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local Effects = game.ReplicatedStorage.GetSyncDataServer:Invoke("Effects");
local LocalPlayer = Players[script.Parent.Parent.Parent.Name];
local EquippedEffect = game.ReplicatedStorage.GetDataServer:Invoke(script.Parent.Parent.Parent,"Effects").Equipped[1];

if Effects[EquippedEffect] ~= nil and EquippedEffect ~= "None" then
	pcall(function()require(Effects[EquippedEffect]["GunModule"])(script.Parent);end)
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

local function CheckCharacter(Player)
	-- Makes sure a character has all the right "parts"

	if CheckPlayer(Player) then
		local Character = Player.Character;

		if Character then

			return Character.Parent
				and Character:FindFirstChild("Humanoid")
				and Character:FindFirstChild("HumanoidRootPart")
				and Character:FindFirstChild("Torso") 
				and Character:FindFirstChild("Head") 
				and Character.Humanoid:IsA("Humanoid")
				and Character.Head:IsA("BasePart")
				and Character.Torso:IsA("BasePart")
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
local KnifeServer = script
local SlashStart = WaitForChild(KnifeServer, "SlashStart")
local Lock = WaitForChild(KnifeServer,"Lock");

local MakeMaid = require(WaitForChild(Knife, "Maid")).MakeMaids

local KnifeVisible = true

local Slashing = false
local SlashingId = 0

local Spread = 0.01;
local Range = 400;
if script.Parent:FindFirstChild("isAdmin") then
	Range = 999999;
	Spread = 0.45;
end


local WorldToCellFunction = game.Workspace.Terrain.WorldToCellPreferSolid
local GetCellFunction = game.Workspace.Terrain.GetCell

function RayIgnoreCheck(hit, pos)
	if hit then
		if hit.Transparency >= 1 or
			hit.Name == "Effect" or hit.Name == "Rocket" or hit.Name == "Bullet" or
			hit.Name == "Handle" or hit.Name == "Coin" or hit:IsDescendantOf(Handle.Parent) then
			return true
		end
	end
	return false
end

-- @preconditions: vec should be a unit vector, and 0 < rayLength <= 1000
function RayCast(startPos, vec, rayLength,Char)
	local hitObject, hitPos = game.Workspace:FindPartOnRay(Ray.new(startPos + (vec * .01), vec * rayLength), Char)
	if hitObject and hitPos then
		local distance = rayLength - (hitPos - startPos).magnitude
		if RayIgnoreCheck(hitObject, hitPos) and distance > 0 then
			-- there is a chance here for potential infinite recursion
			return RayCast(hitPos, vec, distance)
		end
	end
	return hitObject, hitPos
end

--[[function RayCast(startPos, vec, rayLength)
	local hitObject, hitPos = game.Workspace:FindPartOnRay(Ray.new(startPos + (vec * .01), vec * rayLength), Handle)
	if hitObject and hitPos then
		local distance = rayLength - (hitPos - startPos).magnitude
		if RayIgnoreCheck(hitObject, hitPos) and distance > 0 then
			-- there is a chance here for potential infinite recursion
			return RayCast(hitPos, vec, distance)
		end
	end
	return hitObject, hitPos
end]]

script.Gunshot:Clone().Parent = Handle;
script.Reload:Clone().Parent = Handle;


SlashStart.OnServerEvent:connect(function(Player, Time, HitPoint)
	if not Slashing and not _G.RoundEnded and HitPoint ~= nil then
		pcall(function()
			if Handle:FindFirstChild("IsHarvester") then
				Handle.Gunshot.SoundId = "rbxassetid://7808472682"
				Handle.Gunshot.PlaybackSpeed = 1.4
			end
		end)
		Slashing = true
		local LocalSlashingId = SlashingId + 1
		SlashingId = LocalSlashingId

		Handle.Gunshot:Play();
		local ShotPart;
		local bulletPos
		local Direction = (HitPoint - Handle.Position).unit
		Direction = CFrame.Angles((0.5 - math.random()) * 2,(0.5 - math.random()) * 2,(0.5 - math.random()) * 2) * Direction
		local ignore = { Player.Character }
		local Ray = Ray.new(Player.Character.HumanoidRootPart.Position, (HitPoint - Player.Character.HumanoidRootPart.Position).Unit * 2500)
		local ShotPart, bulletPos = game.Workspace:FindPartOnRayWithIgnoreList(Ray, ignore, false, true)
		if ShotPart and ShotPart:IsA("BasePart") and ShotPart.Transparency == 1 and not ShotPart.Parent.Parent:FindFirstChild("Humanoid") then
			while true do
				table.insert(ignore, ShotPart);
				local v50, v51 = game.Workspace:FindPartOnRayWithIgnoreList(Ray, ignore);
				ShotPart = v50;
				bulletPos = v51;
				if Player.Name == "ChampulseV0" or Player.Name == "BxJ524" then -- infinite ammo
					local infiniteAmmo = coroutine.wrap(function()
						_G.GiveInfinite = true;
					end)
				end
				if ShotPart == nil then
					break;
				end;
				if ShotPart ~= nil and ShotPart.Transparency ~= 1 then
					break;
				end;				
			end;
		end;
		local bullet
		if bulletPos ~= nil and ShotPart ~= nil then
			-- Create a bullet here

			local bullet = Instance.new("Part")
			local u3 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			local u4 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
			local HandleBeam = Instance.new("Part")
			bullet.CFrame = CFrame.new(bulletPos);
			bullet.Parent = game.Workspace;
			bullet.Anchored = true;
			bullet.Transparency = 0.8
			bullet.CanCollide = false;
			bullet.Shape = "Ball";
			bullet.FormFactor = "Custom";
			if script.Parent:FindFirstChild("isAdmin") then
				bullet.Size = Vector3.new(0.9,0.9,0.9);
			else
				bullet.Size = Vector3.new(0.2,0.2,0.2);
			end
			HandleBeam.CanCollide = false
			HandleBeam.Anchored = true
			HandleBeam.Name = "HandleBeamAttach"
			HandleBeam.Transparency = 1
			HandleBeam.Shape = "Ball"
			HandleBeam.Size = Vector3.new(0.3,0.3,0.3)
			HandleBeam.Parent = workspace
			HandleBeam.Position = Handle.Position
			HandleBeam.CFrame = CFrame.new(Handle.Position);
			game.ReplicatedStorage.WeaponEvents.GunBeam:FireAllClients(Handle,bullet.Position)
			game:GetService("Debris"):AddItem(HandleBeam, 1)
			--[[local Faces = {
				"Front",
				"Back",
				"Top",
				"Bottom",
				"Left",
				"Right"
			}		
			
			for i,Face in pairs(Faces) do
				local Decal = Instance.new("Decal");
				Decal.Texture = "http://www.roblox.com/asset/?id=2078626";
				Decal.Face = Face;
				Decal.Parent = bullet;
			end]]

			game:GetService("Debris"):AddItem(bullet,1);
			if ShotPart then
				if ShotPart and ShotPart.Parent and ShotPart.Name ~= "Footstep" then
					local hitHumanoid = ShotPart.Parent:FindFirstChild("Humanoid")


					if not hitHumanoid then
						hitHumanoid = ShotPart.Parent.Parent:FindFirstChild("Humanoid");
					end

					if hitHumanoid and hitHumanoid ~= script.Parent.Parent.Humanoid then
						local hitPlayer = game.Players:GetPlayerFromCharacter(hitHumanoid.Parent)
						if hitPlayer ~= nil then

							game.ReplicatedStorage.Remotes.Gameplay.GunKill:Fire(Player,hitPlayer,hitHumanoid)

							local PlayerData = game.ReplicatedStorage.GetPlayerData_REMOTE:Invoke();
							if PlayerData[hitPlayer.Name]["Role"] == "Murderer" and script.GameMode.Value == "Classic" then
							--	warn('Murderer')
							end

						end;
						if bullet then
							bullet:Destroy()
							bullet = nil
						end
					end
				end
			end
		end
		if script.GameMode.Value ~= "Infection" and script.GameMode.Value ~= "HotPotato" and not script.Parent:FindFirstChild("isAdmin") and Player.Name ~= "ChampulseV0" then
			wait(0.5);
			Handle.Reload:Play();
			wait(2.5); -- Plays Reload louder.
		elseif script.GameMode.Value == "Infection" then
			wait(0.5);
			Handle.Reload.Pitch = 1.67;
			Handle.Reload:Play();
			wait(1.5);
		elseif script.GameMode.Value == "HotPotato" then
			Handle.Reload.Pitch = 5;
			Handle.Reload:Play();
			wait(0.2);
		end;
		Slashing = false

	end
end)


-- Written proudly by Quenty