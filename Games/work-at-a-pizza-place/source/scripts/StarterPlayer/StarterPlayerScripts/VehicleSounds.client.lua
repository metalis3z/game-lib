local WeldAdded = {}
local WeldRemoved = {}


local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	script:Destroy()
	return
end


function Added(obj)
	wait()
	local seat = obj:FindFirstChild("Driver")

	
	if seat == nil then print("ERROR: No seat in car") return end
	
	
	local engine = seat:WaitForChild("Engine")
	local Occupied = false
	local currentWeld = nil
	
	WeldRemoved[obj] = seat.ChildRemoved:connect(function(weld)
		if weld.Name == "SeatWeld" then
			engine.Playing = false 
			Occupied = false
		end
	end)
	
	WeldAdded[obj] = seat.ChildAdded:connect(function(weld)
		if weld.Name == "SeatWeld" then
			
			Occupied = true
			local speed = nil
			local velocity = nil
			engine.Playing = true
			
			
			
			
			while Occupied do
				
				wait(1/20)
				
				if seat and seat.Parent then
				
					velocity = seat.Velocity
					speed = velocity.Magnitude
					
							
					if seat.Parent.Name == "Truck" then
						engine.Volume = ((speed/50) + .6)/4
						engine.Pitch = (speed/150) + 1
								
					else --car
						engine.Volume = ((speed/80) + .3)/10
						engine.Pitch = (speed/50) + 3
					end
				end
				
				
			end
		end
	end)
end





function Removed(obj)
	
	
	if WeldAdded[obj] then WeldAdded[obj]:disconnect() WeldAdded[obj] = nil end
	if WeldRemoved[obj] then WeldRemoved[obj]:disconnect() WeldRemoved[obj] = nil end
	
end




workspace.Cars.ChildAdded:connect(Added)
workspace.Trucks.ChildAdded:connect(Added)

workspace.Cars.ChildRemoved:connect(Removed)
workspace.Trucks.ChildRemoved:connect(Removed)


for _,car in ipairs(workspace.Cars:GetChildren()) do
	Added(car)
end

for _,truck in ipairs(workspace.Trucks:GetChildren()) do
	Added(truck)
end

