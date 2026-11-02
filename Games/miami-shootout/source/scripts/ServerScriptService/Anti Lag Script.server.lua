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