local v2 = require(script.Parent.Parent);

v2.char:GetAttributeChangedSignal("Crouching"):Connect(function()
	for _, descendant in ipairs(workspace.CurrentRooms:GetDescendants()) do
		if descendant:GetAttribute("CrouchCollision") == true then

            descendant.CollisionGroup = "CrouchCollision"
			
			if v2.char:GetAttribute("Crouching", true) then
				descendant.CanCollide = false
			else
				descendant.CanCollide = true
			end
			
		end
	end
end)