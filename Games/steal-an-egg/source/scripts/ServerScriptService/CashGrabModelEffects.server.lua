--!strict
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local cashGrabFolder = Workspace:FindFirstChild("CashGrabModels")
if not cashGrabFolder then
	warn("[CashGrabEffects] CashGrabModels folder not found")
	return
end

-- Collect all models with a PrimaryPart nested inside CashGrabModels
local models = {}
local function collectModels(parent: Instance)
	for _, child in ipairs(parent:GetChildren()) do
		if child:IsA("Model") then
			if child.PrimaryPart then
				local pivot = child:GetPivot()
				table.insert(models, {
					model = child,
					basePosition = pivot.Position,
					baseRotation = pivot - pivot.Position,
					phaseOffset = #models * 0.8, -- desync bobbing between models
				})
			end
			collectModels(child)
		end
	end
end
collectModels(cashGrabFolder)

if #models == 0 then
	warn("[CashGrabEffects] No models with PrimaryPart found in CashGrabModels")
	return
end

-- Effect parameters
local SPIN_SPEED = 0.6   -- radians per second
local FLOAT_AMPLITUDE = 2 -- studs up/down
local FLOAT_SPEED = 1.2   -- radians per second

local startTime = os.clock()

RunService.Heartbeat:Connect(function()
	local elapsed = os.clock() - startTime

	for _, entry in ipairs(models) do
		local t = elapsed + entry.phaseOffset
		local spinAngle = t * SPIN_SPEED
		local floatY = math.sin(t * FLOAT_SPEED) * FLOAT_AMPLITUDE

		local newPos = entry.basePosition + Vector3.new(0, floatY, 0)
		local newCFrame = CFrame.new(newPos) * CFrame.Angles(0, spinAngle, 0) * entry.baseRotation

		entry.model:PivotTo(newCFrame)
	end
end)