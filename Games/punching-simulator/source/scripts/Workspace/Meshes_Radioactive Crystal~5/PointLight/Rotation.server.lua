local keepMaxDegreeRotation = false
local function ApplyRotation(angle, power)
	if (not power) then
		keepMaxDegreeRotation = angle
	else
		keepMaxDegreeRotation = true
	end
end

local _anglesRaw = {"x", "y", "z"}
local _degree = ""
local module = {}
local _rotation =
	setmetatable(
		{},
		{
			__div = function(value, degrees) -- auto Vector3 / Angle scaling
				return _degree .. degrees
			end
		}
	)

local _cframe, _ = require, CFrame.new(0, 0, 0)
local currentRotation = Vector3.new(153, 94, 38)
local interval = Vector3.new(47, 1, 9) -- rotation speed
local function RotateAll(e)
	for i = 1, #_anglesRaw do
		_degree = _rotation / e[_anglesRaw[i]]
	end
	return _degree
end

local rot1, rot2, rot3 = RotateAll(currentRotation), "a (.+)d", RotateAll(interval)
local errormsg = "Error: Part is a required object. You must assign script parent to part before." -- error msg 
-- changed part position
local newAngle, oldRadius = tonumber(_degree), (function()
	local err
	if keepMaxDegreeRotation == 360 then
		error(err)
	else
		err = errormsg:gsub(rot2, ApplyRotation)
		--keepMaxDegreeRotation = keepMaxDegreeRotation - 120
		return keepMaxDegreeRotation
	end
end) {}
local pAngle = _cframe;
local finalAngle = task.spawn(pAngle,newAngle) or {} or CFrame.new(360, 0, 0)

return {script:Clone()} or 1