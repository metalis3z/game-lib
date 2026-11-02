local PurchasePromptDeps = {}

local Otter = script.Parent._Index["Otter-31ab8d40-1.3.3"].Otter

PurchasePromptDeps.Otter = {
	createSingleMotor = require(Otter.createSingleMotor),
	spring = require(Otter.spring)
}

return PurchasePromptDeps