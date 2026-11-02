local rs = game:GetService("RunService")
local char = script.Parent
local human = char:WaitForChild("Humanoid")

function makeVisible(part)
	part.LocalTransparencyModifier = 0
end

rs.RenderStepped:Connect(function()
	if human.Health >= 1 then
		if human.RigType == Enum.HumanoidRigType.R6 then
			-- Arms
			makeVisible(char["Left Arm"])
			makeVisible(char["Right Arm"])
			-- Legs
			makeVisible(char["Left Leg"])
			makeVisible(char["Right Leg"])
		elseif human.RigType == Enum.HumanoidRigType.R15 then
			-- Arms
			makeVisible(char.LeftUpperArm)
			makeVisible(char.LeftLowerArm)
			makeVisible(char.LeftHand)
			makeVisible(char.RightUpperArm)
			makeVisible(char.RightLowerArm)
			makeVisible(char.RightHand)
			-- Legs
			makeVisible(char.LeftUpperLeg)
			makeVisible(char.LeftLowerLeg)
			makeVisible(char.LeftFoot)
			makeVisible(char.RightUpperLeg)
			makeVisible(char.RightLowerLeg)
			makeVisible(char.RightFoot)
		end
	end
end)