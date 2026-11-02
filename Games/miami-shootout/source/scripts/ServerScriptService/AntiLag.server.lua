


while true do
	wait(45)

local children = workspace.OBJECTS:GetChildren()
for i = 1, #children do
	local child = children[i]
		

			
			child:Destroy()
			

		
	end
	
	print("Cleared")
	
end