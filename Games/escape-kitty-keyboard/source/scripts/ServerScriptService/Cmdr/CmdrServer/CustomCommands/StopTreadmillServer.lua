local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NORMAL_GRAVITY = 196.2
local INACTIVE_Y = -26.891
local FIXED_X = -230.52
local FIXED_Z = 56.017

return function(context)
	-- Lit/écrit le même état partagé que le panel (BoolValue, pas de require)
	local stateValue = ReplicatedStorage:FindFirstChild("AbuseTreadmillActiveState")
	if not stateValue then
		stateValue = Instance.new("BoolValue")
		stateValue.Name = "AbuseTreadmillActiveState"
		stateValue.Value = false
		stateValue.Parent = ReplicatedStorage
	end
	stateValue.Value = false

	-- Redescend le tapis
	local treadmillFolder = Workspace:FindFirstChild("Treadmill")
	if treadmillFolder then
		local model = treadmillFolder:FindFirstChild("AbuseTreadmill")
		if model then
			local targetPosition = Vector3.new(FIXED_X, INACTIVE_Y, FIXED_Z)
			if model:IsA("Model") and model.PrimaryPart then
				model:SetPrimaryPartCFrame(CFrame.new(targetPosition))
			elseif model:IsA("BasePart") then
				model.Position = targetPosition
			else
				local firstPart = model:FindFirstChildWhichIsA("BasePart", true)
				if firstPart then
					local offset = targetPosition - firstPart.Position
					for _, part in pairs(model:GetDescendants()) do
						if part:IsA("BasePart") then
							part.Position = part.Position + offset
						end
					end
				end
			end
		else
			warn("⚠️ [StopTreadmill] Model 'AbuseTreadmill' introuvable.")
		end
	end

	-- Remet le ciel normal (retire tout Sky custom)
	for _, obj in ipairs(Lighting:GetChildren()) do
		if obj:IsA("Sky") then
			obj:Destroy()
		end
	end

	-- Remet la gravité normale
	Workspace.Gravity = NORMAL_GRAVITY

	return "✅ AbuseTreadmill désactivé : position, gravité et ciel remis à la normale."
end