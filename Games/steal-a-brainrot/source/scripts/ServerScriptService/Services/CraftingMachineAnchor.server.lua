-- CraftingMachineAnchor
-- S'exécute en priorité absolue dès le démarrage du serveur
-- Force la machine à sa position correcte avant tout autre script

local TARGET_CFRAME = CFrame.fromMatrix(
	Vector3.new(-382.99, -0.815, -131.384),
	Vector3.new( 0,  0, -1), -- RightVector
	Vector3.new( 0,  1,  0), -- UpVector
	Vector3.new( 1,  0,  0)  -- BackVector
)

-- Repositionner immédiatement sans aucun wait
local cm = workspace:FindFirstChild("CraftingMachine")
if cm then
	cm:PivotTo(TARGET_CFRAME)
end

-- Repositionner aussi au frame suivant pour écraser tout ce qui pourrait la bouger
task.defer(function()
	local cm2 = workspace:FindFirstChild("CraftingMachine")
	if cm2 then
		cm2:PivotTo(TARGET_CFRAME)
	end
end)

-- Et une troisième fois après 1 frame pour être sûr
task.delay(0, function()
	local cm3 = workspace:FindFirstChild("CraftingMachine")
	if cm3 then
		cm3:PivotTo(TARGET_CFRAME)
	end
end)
