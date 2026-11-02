--	This script will lower the time required to load a map in online mode. Just leave it in the map. -Gamer3D
function breakAnchored(model)
	if (model.className == "Part") or (model.className == "Seat") or (model.className == "SpawnLocation") then
		if model.Anchored then
			model:BreakJoints()
		end
	else
		local child = model:GetChildren()
		for n = 1, #child do
			breakAnchored(child[n])
		end
	end
end

function makeUnanchored(model)
	if (model.className == "Part") or (model.className == "Seat") or (model.className == "SpawnLocation") then
		if not model.Anchored then
			model:MakeJoints()
		end
	else
		local child = model:GetChildren()
		for n = 1, #child do
			makeUnanchored(child[n])
		end
	end
end

wait()

breakAnchored(workspace)
makeUnanchored(workspace)