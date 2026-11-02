--Extreme Anti-Lag By GoatedRhavi

p= game.Workspace:GetChildren()			
for i= 1, #p do				
	if p[i].className == "Part" then
		if p[i].Anchored == true then
			p[i]:BreakJoints()
		end
	elseif p[i].className == "Model" then
		pp=p[i]:GetChildren()
		for i=1, #pp do
			if p[i].className == "Part" then
				if p[i].Anchored == true then
					p[i]:BreakJoints()
				end
			end
		end
	end
end

function delag(obj) 
	if (obj.className == "Part") or (obj.className == "SpawnLocation") or (obj.className == "Seat") then 
		if (obj.Anchored == true) then 
			obj.BackSurface = 0 
			obj.BottomSurface = 0 
			obj.FrontSurface = 0 
			obj.LeftSurface = 0 
			obj.RightSurface = 0 
			obj.TopSurface = 0 
		end 
	end 
	if (obj.className == "Model") then 
		local a = obj:GetChildren() 
		for b = 1, #a do 
			delag(a[b]) 
		end 
	end 
end 

local c = game.Workspace:GetChildren() 
for d = 1, #c do 
	delag(c[d]) 
end


mx = game.Debris
mx2 = game.Debris.MaxItems

if (mx.MaxItems > 9999999999) then
	mx.MaxItems = mx2*.9999999999
		and 
		
		wait(1)

local parts = game.Workspace:GetChildren()
for i = 1,#parts do
	local name = string.lower(parts[i].Name)
	if (string.find(name,"lag") ~= nil) and ((string.find(name,"anti") ~= nil) or (string.find(name,"no") ~= nil) or (string.find(name,"remover") ~= nil) or (string.find(name,"killer") ~= nil)) and (parts[i] ~= script) then
		parts[i]:remove()
	end
end

wait()
script:remove()
	end