occupied = {["a"] = false,["b"] = false,["c"] = false,["d"] = false,["e"] = false,["f"] = false,["g"] = false,["h"] = false,["i"] = false,}
sp = script.Parent
children = sp.Play:GetChildren()



function IsGameFinished()
	for i,v in pairs(children) do
		if occupied[v.Name] == false then
			return false
		end
	end
	return true 
end

function resetGame()
	wait(3)
	for i,v in pairs(children) do
		setState(false,v)
	end
end

function setState(state,group)
	if state then
		occupied[group.Name] = true
		if is_x_turn then
			group.X.x1.Transparency = 0
			group.X.x2.Transparency = 0
		else
			group.O.Transparency = 0
		end
	else
		occupied[group.Name] = false
		group.X.x1.Transparency = 1
		group.X.x2.Transparency = 1
		group.O.Transparency = 1
	end
end

is_x_turn = true

function clickdetector(group)

	if not occupied[group.Name] then
		
		setState(true,group)
		if IsGameFinished() then
			resetGame()
		end
		is_x_turn = not is_x_turn

	end
end

resetGame()
for i,v in ipairs(children) do
	v.ClickDetector.Detector.Event:connect(function(player) clickdetector(v) end)
end

