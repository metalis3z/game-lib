return function(Tool)
	for a = 0,5 do
		local s1 = Tool.GunModel["Bullet" .. a]
		local s2 = Tool.GunModel["EmptyShell" .. a]
		
		s1.Transparency = 0
		s2.Transparency = 0
	end
end