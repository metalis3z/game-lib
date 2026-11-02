--EEwwwwww gross

seat = script.Parent
s = script
---------------------------------------------------------------
function onChildAdded(child)
	if child.Name == "SeatWeld" then
		local human = child.part1.Parent:findFirstChild("Humanoid") 
		if (human ~= nil) then
			print("Human IN")
			--seat.SirenControl.Control.CarName.Value = human.Parent.Name.."'s Car"
			--seat.Parent.Name = human.Parent.Name.."'s Car"
			--s.Parent.SirenControl:clone().Parent = game.Players:findFirstChild(human.Parent.Name).PlayerGui
			seat.Start:Play()
			wait(1)
			seat.Start:Stop()
			seat.Engine:Play()
		end
	end
end

function onChildRemoved(child)
	if (child.Name == "SeatWeld") then	
		local human = child.part1.Parent:findFirstChild("Humanoid") 
		if (human ~= nil) then
			print("Human OUT")
			--seat.Parent.Name = "Empty Car"
			--seat.SirenControl.Control.CarName.Value = "Empty Car"
			game.Players:findFirstChild(human.Parent.Name).PlayerGui.SirenControl:remove()
			seat.Engine:Stop()
		end
	end
end


script.Parent.ChildAdded:connect(onChildAdded)
script.Parent.ChildRemoved:connect(onChildRemoved)
