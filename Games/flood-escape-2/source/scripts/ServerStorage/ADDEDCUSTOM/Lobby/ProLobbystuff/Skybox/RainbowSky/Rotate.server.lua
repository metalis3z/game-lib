local part = script.Parent

local lowerBound = part.Position - Vector3.new(0, 3, 0)
local upperBound = part.Position + Vector3.new(0, 3, 0)

local radiansPerSecond = math.rad(1) -- a quarter turn every second (we need to do this to maintain a consistent velocity), needs to be wrapped in math.rad as CFrame.Angles takes an arg in radians not degrees

local identityRotation = CFrame.identity.Rotation -- equivalent of CFrame.Angles(0, 0, 0)

local currentRotation = identityRotation -- our starting rotation

while true do
	local delta = task.wait()
	
	local now = tick()
	-- math.sin returns a value between -1 and 1 so we first need to add 1 to get a number between 0 and 2, then divide by 2 (multiply by 0.5) to get a number between 0 and 1 so it does not exceed the boundaries we set above
	local position = lowerBound:Lerp(upperBound, (math.sin(now) + 1) * 0.5)
	currentRotation *= CFrame.Angles(0, radiansPerSecond * delta, 0) -- delta how much time passed since the previous frame, multiplying it by degreesPerSecond gives us how much we should rotate based on time it took to render the frame
	
	-- finally apply our current CFrame to the part's CFrame
	part.CFrame = CFrame.new(position) * currentRotation
end