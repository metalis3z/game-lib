--[[local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

spp = model

door1 = spp.Door1
door2 =spp.Door2

hinge  =spp.Hinge

handle1 = spp.Handle1
handle2 = spp.Handle2

force1 = handle1.BodyPosition
force2 = handle2.BodyPosition

pos1 = handle1.Position
pos2 = handle2.Position

cframe = {[door1] = door1.CFrame, [door2] = door2.CFrame,[handle1] = handle1.CFrame,[handle2] = handle2.CFrame}
door_open = false
function anchor(a,type)
	if type == 1 then
		door1.Anchored = a
		handle1.Anchored = a
	else
		door2.Anchored = a
		handle2.Anchored = a
	end
end

function findFood(player)
	for _,i in ipairs(player.Backpack:GetChildren()) do
		if i:FindFirstChild("Food") ~= nil then
			return true
		end
	end
	return false
end
	
function click(player)
	if not door_open then
		door_open = true
		anchor(false,1)
		force1.position = hinge.Position + (hinge.CFrame.lookVector * 15)
		
		wait(.7)
		anchor(true,1)
		wait(2)
		if not findFood(player) then
			local m = math.random(1,5)
			if m == 1 then
				--game.ServerStorage.Gear["Turkey Leg"]:clone().Parent = player.Backpack
			elseif m == 2 then
				game.ServerStorage.Gear["Pizza"]:clone().Parent = player.Backpack
			elseif m == 3 then
				game.ServerStorage.Gear["Ham"]:clone().Parent = player.Backpack
			elseif m == 4 then
				game.ServerStorage.Gear["Bloxy Cola"]:clone().Parent = player.Backpack
			elseif m == 5 then
				game.ServerStorage.Gear["Hot Dog"]:clone().Parent = player.Backpack
			end
		end
		wait(1)
		door1.CFrame = cframe[door1]
		
		handle1.CFrame = cframe[handle1]
		
		door_open = false
	end
end
door1.ClickDetector.MouseClick:connect(click)


door2_open = false
function click(player)
	if not door2_open then
		door2_open = true
		anchor(false,2)
		
		force2.position = hinge.Position + (hinge.CFrame.lookVector * 15)
		wait(.7)
		anchor(true,2)
		wait(2)
		if not findFood(player) then
			game.ServerStorage.Gear["Ice Cream"]:clone().Parent = player.Backpack
		end
		wait(1)
		
		door2.CFrame = cframe[door2]
		
		handle2.CFrame = cframe[handle2]
		door2_open = false
	end
end
door2.ClickDetector.MouseClick:connect(click)]]

