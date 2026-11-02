local lavaImg1 = script.Parent:WaitForChild("Holder"):WaitForChild("Frame") 

while game:GetService("RunService").Heartbeat:wait() do
	local sin, rad = math.sin, math.rad
	local t = tick()
	
	local alpha1 = ( -( (t * .05) - math.floor( (t * .05) ) ) )
	local alpha2 = ( -( (t * -.05) - math.floor( (t * -.05) ) ) )
	
	lavaImg1.Position = UDim2.new( alpha1, 0, alpha2, 0)
	end