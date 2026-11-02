function onTouched(hit)
	local human = hit.Parent:FindFirstChild("NPC") 
        
	if (human ~= nil) then 
		human.Health = 1905
		workspace.The_Rake.NPC.PlatformStand = false

	end
end

if (script.Parent ~= nil) and (script.Parent.className == "Part") then 
	connection = script.Parent.Touched:connect(onTouched)
end
