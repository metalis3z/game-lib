local door = script:WaitForChild("ObjectPointer").Value

state = 1   --1 = closed,  2 = open


function click(player)
	if state == 1 then -- open door
		state = 2
		door.DoorClosed.DoorOpenSound:Play()
		door.KnobOpen.CanCollide = true
		door.KnobOpen.Transparency = 0
		
		door.DoorOpen.CanCollide = true
		door.DoorOpen.Transparency = 0
		
		door.KnobClosed.CanCollide = false
		door.KnobClosed.Transparency = 1
		
		door.DoorClosed.CanCollide = false
		door.DoorClosed.Transparency = 1
		
		wait(10)
		if state ~= 1 then --autoshut
			click(player)
		end
	else -- closed door
		state = 1
		door.DoorClosed.DoorClosedSound:Play()
		door.KnobOpen.CanCollide = false
		door.KnobOpen.Transparency = 1
		
		door.DoorOpen.CanCollide = false
		door.DoorOpen.Transparency = 1
		
		door.KnobClosed.CanCollide = true
		door.KnobClosed.Transparency = 0
		
		door.DoorClosed.CanCollide = true
		door.DoorClosed.Transparency = 0
	end
end
door.ClickDetector.MouseClick:connect(click)



function touched(hit)
	if state == 1 and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		click(nil)
	end
end


local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = door
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object == door.DoorClosed then
		touched(hit)
	end
end)