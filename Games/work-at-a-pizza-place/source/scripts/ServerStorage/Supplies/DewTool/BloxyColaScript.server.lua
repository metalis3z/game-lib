local Tool = script.Parent;

enabled = true

local drinkCount = 0


function onActivated()
	local player = game.Players:GetPlayerFromCharacter(Tool.Parent)
	if player and script.Parent.PlayerCustomer.Value == player then
		if not enabled  then
			return
		end
	
		enabled = false
		Tool.GripForward = Vector3.new(0,-.759,-.651)
		Tool.GripPos = Vector3.new(1.5,-.5,.3)
		Tool.GripRight = Vector3.new(1,0,0)
		Tool.GripUp = Vector3.new(0,.651,-.759)
	
	
		Tool.Handle.DrinkSound:Play()
	
		wait(3)
	
		Tool.GripForward = Vector3.new(-.976,0,-0.217)
		Tool.GripPos = Vector3.new(0.03,0,0)
		Tool.GripRight = Vector3.new(.217,0,-.976)
		Tool.GripUp = Vector3.new(0,1,0)
	
		enabled = true
		
		drinkCount = drinkCount + 1 
		if drinkCount == 3 then
			enabled = false
			local handle = script.Parent.Handle
			handle.Name = "NoHandle" --so you cant pick it up again
			script.Parent.Parent = workspace
			handle.CanCollide = true
			
			
		end
	end
end

function onEquipped()
	local player = game.Players:GetPlayerFromCharacter(Tool.Parent)
	if player and script.Parent.PlayerCustomer.Value == player then
		Tool.Handle.OpenSound:play()
	end
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
