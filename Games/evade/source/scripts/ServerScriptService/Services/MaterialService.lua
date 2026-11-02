local MaterialService = {}

local MS = game:GetService("MaterialService")

function MaterialService:Start()
	for _, material: MaterialVariant in pairs(script:GetChildren()) do
		material.Parent = MS
	end
end

return MaterialService