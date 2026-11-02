local FastCast = {}


local Signal = require(script:WaitForChild("Signal")) 
local RunService = game:GetService("RunService")


function FastCast.new()
	
	local Caster = {}
	local CMeta = {}
	setmetatable(Caster, CMeta)
	
	local IgnoreDescendantsInstance = nil
	local Gravity = 0
	local ExtraForce = Vector3.new()
	
	local RayHit = Signal:CreateNewSignal()
	local LengthChanged = Signal:CreateNewSignal()
	
	local function UsingPhysics()
		return (Gravity ~= 0) or (ExtraForce.Magnitude ~= 0)
	end
	
	local function Cast(Origin, Direction)
		local CastRay = Ray.new(Origin, Direction)
		return workspace:FindPartOnRay(CastRay, IgnoreDescendantsInstance)
	end
	
	
	local function CastWhitelist(Origin, Direction, Whitelist)
		if not Whitelist or typeof(Whitelist) ~= "table" then
			
			error("Call in CastWhitelist failed! Whitelist table is either nil, or is not actually a table.", 0)
		end
		local CastRay = Ray.new(Origin, Direction)
		return workspace:FindPartOnRayWithWhitelist(CastRay, Whitelist)
	end
	
	
	local function CastBlacklist(Origin, Direction, Blacklist)
		if not Blacklist or typeof(Blacklist) ~= "table" then
			--Faulty array. Throw an error.
			error("Call in CastBlacklist failed! Blacklist table is either nil, or is not actually a table.", 0)
		end
		
		local CastRay = Ray.new(Origin, Direction)
		return workspace:FindPartOnRayWithIgnoreList(CastRay, Blacklist)
	end
	
	
	local function GetPositionAtTime(Time, Origin, InitialVelocity, Acceleration)
		local Gravity = Gravity * -1 
		local Force = Vector3.new((Acceleration.X * Time^2) / 2,(Acceleration.Y * Time^2) / 2, (Acceleration.Z * Time^2) / 2)
		local GravForce = Vector3.new(0, (Gravity * (Time^2))/2, 0)
		return Origin + (InitialVelocity * Time) + Force + GravForce
	end
	
	
	local function MainCastFire(Origin, Direction, Velocity, Function, CosmeticBulletObject, List, BulletAcceleration)
		
		if type(Velocity) == "number" then
			Velocity = Direction.Unit * Velocity
		end
		
		local Distance = Direction.Magnitude
		local NormalizedDir = Direction / Distance
		local UpgradedDir = (NormalizedDir + Velocity).Unit
		local InitialVelocity = (UpgradedDir * Velocity.Magnitude)
		
		local TotalDelta = 0
		local DistanceTravelled = 0
		local LastPoint = Origin
		while DistanceTravelled <= Distance do
			local Delta = RunService.Heartbeat:Wait()
			TotalDelta = TotalDelta + Delta
			local At = GetPositionAtTime(TotalDelta, Origin, InitialVelocity, BulletAcceleration or ExtraForce)
			
			local ATDifference = (At - LastPoint)
			local ATDirection = ATDifference.Unit
			local ATDistance = ATDifference.Magnitude
			local RayDir = ATDirection * Velocity.Magnitude * Delta
			local Hit, Point, Normal, Material = Function(LastPoint, RayDir, List)
			
			
			local LastToCurrent_Distance = (LastPoint - At).Magnitude
	
			
			LengthChanged:Fire(Origin, LastPoint, RayDir.Unit, LastToCurrent_Distance, CosmeticBulletObject)
			LastPoint = At
			if Hit then
				
				if Hit ~= CosmeticBulletObject then
					
					RayHit:Fire(Hit, Point, Normal, Material, CosmeticBulletObject)
					return
				end
				
			end
			DistanceTravelled = DistanceTravelled + LastToCurrent_Distance
		end
		
		RayHit:Fire(nil, LastPoint, nil, nil, CosmeticBulletObject)
	end
	
	
	local function MainCastFireNoPhys(Origin, Direction, Velocity, Function, CosmeticBulletObject, List)
		if type(Velocity) == "number" then
			Velocity = Direction.Unit * Velocity
		end
		
		local Distance = Direction.Magnitude
		local NormalizedDir = Direction / Distance
		
		local LastPoint = Origin
		local DistanceTravelled = 0
		while DistanceTravelled <= Distance do
			local Delta = RunService.Heartbeat:Wait()
			local UpgradedDir = (NormalizedDir + Velocity).Unit
			local Start = Origin + (UpgradedDir.Unit * DistanceTravelled)
			local RayDir = UpgradedDir * Velocity.Magnitude * Delta
			local Hit, Point, Normal, Material = Function(Start, RayDir, List)
			
			local ExtraDistance = (Start - Point).Magnitude
			local ModifiedDistance = DistanceTravelled + ExtraDistance
			
			
			LengthChanged:Fire(Origin, LastPoint, RayDir.Unit, ExtraDistance, CosmeticBulletObject)
			
			
			LastPoint = Point
			if Hit then
				if Hit ~= CosmeticBulletObject then
					RayHit:Fire(Hit, Point, Normal, Material, CosmeticBulletObject)
					return
				end
				ExtraDistance = RayDir.Magnitude
			end
			DistanceTravelled = DistanceTravelled + ExtraDistance
		end
		RayHit:Fire(nil, LastPoint, nil, nil, CosmeticBulletObject)
	end
	
	
	function Caster:Fire(Origin, Direction, Velocity, CosmeticBulletObject, BulletAcceleration)
		assert(Caster == self, "Expected ':' not '.' calling member function Fire")
		
		spawn(function ()
			if UsingPhysics() or BulletAcceleration then
				MainCastFire(Origin, Direction, Velocity, Cast, CosmeticBulletObject, nil, BulletAcceleration)
			else
				MainCastFireNoPhys(Origin, Direction, Velocity, Cast, CosmeticBulletObject)
			end
		end)
	end
	
	
	function Caster:FireWithWhitelist(Origin, Direction, Velocity, Whitelist, CosmeticBulletObject, BulletAcceleration)
		assert(Caster == self, "Expected ':' not '.' calling member function FireWithWhitelist")
		spawn(function ()
			if UsingPhysics() or BulletAcceleration then
				MainCastFire(Origin, Direction, Velocity, CastWhitelist, CosmeticBulletObject, Whitelist, BulletAcceleration)
			else
				MainCastFireNoPhys(Origin, Direction, Velocity, CastWhitelist, CosmeticBulletObject, Whitelist)
			end
		end)
	end
	
	
	function Caster:FireWithBlacklist(Origin, Direction, Velocity, Blacklist, CosmeticBulletObject, BulletAcceleration)
		assert(Caster == self, "Expected ':' not '.' calling member function FireWithBlacklist")
		spawn(function ()
			if UsingPhysics() or BulletAcceleration then
				MainCastFire(Origin, Direction, Velocity, CastBlacklist, CosmeticBulletObject, Blacklist, BulletAcceleration)
			else
				MainCastFireNoPhys(Origin, Direction, Velocity, CastBlacklist, CosmeticBulletObject, Blacklist)
			end
		end)
	end
	
	
	
	CMeta.__index = function (Table, Index)
		if Table == Caster then
			if Index == "IgnoreDescendantsInstance" then
				return IgnoreDescendantsInstance
			elseif Index == "RayHit" then
				return RayHit
			elseif Index == "LengthChanged" then
				return LengthChanged
			elseif Index == "Gravity" then
				return Gravity
			elseif Index == "ExtraForce" then
				return ExtraForce
			elseif Index == "HasPhysics" then
				return UsingPhysics()
			end
		end
	end
	
	local IgnoreMode = false 
	CMeta.__newindex = function (Table, Index, Value)
		if IgnoreMode then return end
		if Table == Caster then
			if Index == "IgnoreDescendantsInstance" then
				assert(Value == nil or typeof(Value) == "Instance", "Bad argument \"" .. Index .. "\" (Instance expected, got " .. typeof(Value) .. ")")
				IgnoreDescendantsInstance = Value
			elseif Index == "Gravity" then
				assert(typeof(Value) == "number", "Bad argument \"" .. Index .. "\" (number expected, got " .. typeof(Value) .. ")")
				Gravity = Value			
			elseif Index == "ExtraForce" then
				assert(typeof(Value) == "Vector3", "Bad argument \"" .. Index .. "\" (Vector3 expected, got " .. typeof(Value) .. ")")
				ExtraForce = Value
			elseif Index == "RayHit" or Index == "LengthChanged" or Index == "HasPhysics" then
				error("Can't set value", 0)
			end
		end
	end

	
	IgnoreMode = true
	Caster.RayHit = RayHit
	Caster.LengthChanged = LengthChanged
	Caster.IgnoreDescendantsInstance = IgnoreDescendantsInstance
	Caster.Gravity = Gravity
	Caster.ExtraForce = ExtraForce
	Caster.HasPhysics = UsingPhysics()
	IgnoreMode = false
	
	
	CMeta.__metatable = "FastCaster"
	
	return Caster
end

return FastCast