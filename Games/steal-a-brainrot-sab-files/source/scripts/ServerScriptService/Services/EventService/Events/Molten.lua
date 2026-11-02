local Molten = {}
local isActive = false
function Molten.OnStart()
	if isActive then
		return
	end
	isActive = true
   game.ReplicatedStorage:SetAttribute("MoltenEvent", true)
end

function Molten.OnStop()
	if not isActive then
		return
	end
	isActive = false
	game.ReplicatedStorage:SetAttribute("MoltenEvent", false)
end

return Molten