                                                                                                                                                                          --[[


Scripted by ItsLeeeroy 

youtube.com/c/ItsLeeeroy 

Roblox: @ItsLeeeroy

Roblox Profile: web.roblox.com/users/369345052/profile/


 ToyKey Script                                                                                                                                                            ]]

Tool = script.Parent
Handle = Tool:WaitForChild("Handle")
local Color1 = BrickColor.new() -- this is Orange. You can Change this -> (255,85,0).

local ChromaChance = math.random(1,1)

-- DONT TOUCH/REMOVE THIS BELOW!


function Equipped()
	
	
	print("Equipped")
	
	Color1 = BrickColor.Random()
	
		Handle.BrickColor = Color1
		
			ChromaChance =  math.random(1,250)
		
		print("ChromaCandyChance = ".. ChromaChance)
		
		
		if ChromaChance == 250 then
				
				script.Parent.Handle.ChromaScript.Disabled = false
				print("ChromaCandyChance = ".. ChromaChance)
			else
				
				script.Parent.Handle.ChromaScript.Disabled = true
		
				
			
		
	
			wait(.1)
		end
	end


function Unequipped()
	
			script.Parent.Handle.ChromaScript.Disabled = true

	wait(.1)
end


function Activated()

	print("Equipped")
	
	Color1 = BrickColor.Random()
	
		Handle.BrickColor = Color1
		
			ChromaChance =  math.random(1,250)
		
		print("ChromaCandyChance = ".. ChromaChance)
		
		
		if ChromaChance == 250 then
				
				script.Parent.Handle.ChromaScript.Disabled = false
				print("ChromaCandyChance = ".. ChromaChance)
			else
				
				script.Parent.Handle.ChromaScript.Disabled = true
		
				
			
		
	
			wait(.1)
		end
	end

-- This runs the functions. DO NOT REMOVE THESE!
Tool.Equipped:Connect(Equipped)
Tool.Unequipped:Connect(Unequipped)
Tool.Activated:Connect(Activated)

Connection = Handle.Touched:Connect()