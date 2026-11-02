-- Camera Shake Presets
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShakePresets.Bump
	CameraShakePresets.Explosion
	CameraShakePresets.Earthquake
	CameraShakePresets.BadTrip
	CameraShakePresets.HandheldCamera
	CameraShakePresets.Vibration
	CameraShakePresets.RoughDriving
	
--]]



local CameraShakeInstance = require(script.Parent.CameraShakeInstance)

local CameraShakePresets = {
	
	
	-- A high-magnitude, short, yet smooth shake.
	-- Should happen once.
	Bump = function()
		local c = CameraShakeInstance.new(2.5, 4, 0.1, 0.75)
		c.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
		c.RotationInfluence = Vector3.new(1, 1, 1)
		return c
	end;
	
	
	-- An intense and rough shake.
	-- Should happen once.
	Explosion = function()
		local c = CameraShakeInstance.new(5, 10, 0, 1.5)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(4, 1, 1)
		return c
	end;
	
	
	-- A continuous, rough shake
	-- Sustained.
	Earthquake = function()
		local c = CameraShakeInstance.new(0.6, 3.5, 2, 10)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(1, 1, 4)
		return c
	end;
	
	
	-- A bizarre shake with a very high magnitude and low roughness.
	-- Sustained.
	BadTrip = function()
		local c = CameraShakeInstance.new(10, 0.15, 5, 10)
		c.PositionInfluence = Vector3.new(0, 0, 0.15)
		c.RotationInfluence = Vector3.new(2, 1, 4)
		return c
	end;


	Hit = function()
		local c = CameraShakeInstance.new(20, 10, 0, 0.5)
		c.PositionInfluence = Vector3.new(0.5, 0.5, 0, 0)
		c.RotationInfluence = Vector3.new(0, 0.6000000238418579, 0.4000000059604645, 0)
		return c
	end;


	GunFire = function()
		local c = CameraShakeInstance.new(3, 5, 0, 0.75)
		c.PositionInfluence = Vector3.new(0.5, 0.5, 0.5, 0)
		c.RotationInfluence = Vector3.new(0, 0, 0, 0)
		return c
	end;
	
	
	-- A subtle, slow shake.
	-- Sustained.
	HandheldCamera = function()
		local c = CameraShakeInstance.new(1, 0.25, 5, 10)
		c.PositionInfluence = Vector3.new(0, 0, 0)
		c.RotationInfluence = Vector3.new(1, 0.5, 0.5)
		return c
	end;
	
	
	-- A very rough, yet low magnitude shake.
	-- Sustained.
	Vibration = function()
		local c = CameraShakeInstance.new(0.4, 20, 2, 2)
		c.PositionInfluence = Vector3.new(0, 0.15, 0)
		c.RotationInfluence = Vector3.new(1.25, 0, 4)
		return c
	end;


	RoughVibration = function()
		local c = CameraShakeInstance.new(0.75, 20, 0, 0.5)
		c.PositionInfluence = Vector3.new(0.25, 0.30000001192092896, 0, 0)
		c.RotationInfluence = Vector3.new(1.25, 0, 4, 0)
		return c
	end;


	VeryRoughVibration = function()
		local c = CameraShakeInstance.new(2, 20, 0, 0.5)
		c.PositionInfluence = Vector3.new(0.4000000059604645, 0.5, 0, 0)
		c.RotationInfluence = Vector3.new(1.25, 0, 4, 0)
		return c
	end;
	
	
	-- A slightly rough, medium magnitude shake.
	-- Sustained.
	RoughDriving = function()
		local c = CameraShakeInstance.new(1, 2, 1, 1)
		c.PositionInfluence = Vector3.new(0, 0, 0)
		c.RotationInfluence = Vector3.new(1, 1, 1)
		return c
	end;


	Injured = function()
		local c = CameraShakeInstance.new(0.5, 2, 1, 1)
		c.PositionInfluence = Vector3.new(1, 0.5, 0, 0)
		c.RotationInfluence = Vector3.new(0.10000000149011612, 0.10000000149011612, 0, 0)
		return c
	end;


	StepShake = function()
		local c = CameraShakeInstance.new(1, 2, 0.1, 0.5)
		c.PositionInfluence = Vector3.new(0.10000000149011612, 0.5, 0, 0)
		c.RotationInfluence = Vector3.new(0, 0, 0, 0)
		return c
	end;


	RunningShake = function()
		local c = CameraShakeInstance.new(2, 2, 0.1, 0.5)
		c.PositionInfluence = Vector3.new(1, 0.5, 0, 0)
		c.RotationInfluence = Vector3.new(0, 0, 0, 0)
		return c
	end;


	Bash = function()
		local c = CameraShakeInstance.new(1, 8, 0.1, 0.5)
		c.PositionInfluence = Vector3.new(1, 2, 1, 0)
		c.RotationInfluence = Vector3.new(0, 0, 0, 0)
		return c
	end;


	SecurityGuardShot = function()
		local c = CameraShakeInstance.new(8, 7, 0.05, 0.05)
		c.RotationInfluence = Vector3.new(1, 1, 1, 0)
		return c
	end;


	SecurityGuardShake = function()
		local c = CameraShakeInstance.new(1.3, 12, 0.2, 0.2)
		c.RotationInfluence = Vector3.new(1, 1, 1, 0)
		return c
	end;


	SpringtrapScream = function()
		local c = CameraShakeInstance.new(3, 8, 0.1, 1.5)
		c.PositionInfluence = Vector3.new(2, 2, 2, 0)
		c.RotationInfluence = Vector3.new(1, 2, 1, 0)
		return c
	end;


	Flashbang = function() 
		local c = CameraShakeInstance.new(15, 3, 0.1, 8)
		c.PositionInfluence = Vector3.new(0, 0, 0, 0)
		c.RotationInfluence = Vector3.new(2, 2, 2, 0)
		return c
	end;


	NUKE = function()
		local c = CameraShakeInstance.new(5, 100, 0.1, 5)
		c.PositionInfluence = Vector3.new(5, 5, 0, 0)
		c.RotationInfluence = Vector3.new(0, 1, 0, 0)
		return c
	end;
	
	
}


return setmetatable({}, {
	__index = function(t, i)
		local f = CameraShakePresets[i]
		if (type(f) == "function") then
			return f()
		end
		error("No preset found with index \"" .. i .. "\"")
	end;
})