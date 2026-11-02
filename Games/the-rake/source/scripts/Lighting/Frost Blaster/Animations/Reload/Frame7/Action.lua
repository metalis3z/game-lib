return function(Tool)
	local deb = game:GetService("Debris")
	for a = 0,5 do
		local s1 = Tool.GunModel["Bullet" .. a]
		local s2 = Tool.GunModel["EmptyShell" .. a]
		
		if (s1.Transparency == 0) then
			local c1 = s1:clone()
			c1.CanCollide = true
			c1.Parent = workspace
			
			deb:AddItem(c1,60)
		else
			local c2 = s2:clone()
			c2.CanCollide = true
			c2.Parent = workspace
			deb:AddItem(c2,60)
		end
		
		s1.Transparency = 1
		s2.Transparency = 1
	end
end