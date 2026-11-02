local Interactions = workspace:WaitForChild("Interactions")

for _, Object in next, Interactions:GetChildren() do
	for _, ObjectModule in next, script:GetChildren() do
		if ObjectModule.Name == Object.Name then
			ObjectModule = require(ObjectModule)
			ObjectModule:Hook(Object)
		end
	end
end

return nil