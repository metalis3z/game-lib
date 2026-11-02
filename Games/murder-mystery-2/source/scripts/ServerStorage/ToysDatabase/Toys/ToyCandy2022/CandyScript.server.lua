                                                                                                                                                

Tool = script.Parent
Handle = Tool:WaitForChild("Handle")
local Color1 = Color3.fromRGB(255, 115, 0) -- this is Orange. You can Change this -> (255,85,0).
local Color2 = BrickColor.new("Lime green") --  You can Change this -> ("Hot pink").
local Color4 = BrickColor.new("Tr. Blue") --  You can Change this -> ("Teal").
local RandomChance = math.random(1,1)
local FireChance = math.random(1,1)
local ChromaChance = math.random(1,1)

-- DONT TOUCH/REMOVE THIS BELOW!


function Equipped()
	
	RandomChance = math.random(1,3)
	
	if RandomChance == 1 then
		Handle.Color = Color1
		FireChance = math.random(1,15)
			ChromaChance =  math.random(1,250)
		if FireChance == 15 then
			script.Parent.Handle.ColorFire.Enabled = true
			
		end
		
		if ChromaChance == 250 then
				script.Parent.Handle.ColorFire.ChromaScript.Disabled = false
				script.Parent.Handle.ChromaScript.Disabled = false
			else
				script.Parent.Handle.ColorFire.ChromaScript.Disabled = true
				script.Parent.Handle.ChromaScript.Disabled = true
		
				
			
		end
	else
		if RandomChance == 2 then
			Handle.BrickColor = Color2
			FireChance = math.random(1,15)
			ChromaChance =  math.random(1,250)
		if FireChance == 15 then
			script.Parent.Handle.ColorFire.Enabled = true
			
		end
		
		if ChromaChance == 250 then
				script.Parent.Handle.ColorFire.ChromaScript.Disabled = false
				script.Parent.Handle.ChromaScript.Disabled = false
			else
				script.Parent.Handle.ColorFire.ChromaScript.Disabled = true
				script.Parent.Handle.ChromaScript.Disabled = true
			
				
			
		end
		else
			if RandomChance == 3 then
				Handle.BrickColor = Color4
				FireChance = math.random(1,15)
			ChromaChance =  math.random(1,250)

		if FireChance == 15 then
			script.Parent.Handle.ColorFire.Enabled = true
		
		end
		
		if ChromaChance == 250 then
				script.Parent.Handle.ColorFire.ChromaScript.Disabled = false
				script.Parent.Handle.ChromaScript.Disabled = false
			else
				script.Parent.Handle.ColorFire.ChromaScript.Disabled = true
				script.Parent.Handle.ChromaScript.Disabled = true
			
			
		       end
			end
			wait(.1)
		end
	end
end

function Unequipped()
	
	if Handle.ColorFire.Enabled == true then
		Handle.ColorFire.Enabled = false
			  end

		
		if script.Parent.Handle.ColorFire.ChromaScript.Disabled == false then
			 
			script.Parent.Handle.ColorFire.ChromaScript.Disabled = true
			script.Parent.Handle.ChromaScript.Disabled = true
			end
			

	
		script.Parent.Handle.ColorFire.ChromaScript.Disabled = true
		script.Parent.Handle.ChromaScript.Disabled = true
		
		
		
	
	wait(.1)
end

-- This runs the functions. DO NOT REMOVE THESE!
Tool.Equipped:Connect(Equipped)
Tool.Unequipped:Connect(Unequipped)

Connection = Handle.Touched:Connect()