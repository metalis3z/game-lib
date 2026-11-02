local leftArm = script.Parent.Parent:WaitForChild("Left Arm")
local glowout = script.Parent:WaitForChild("gloveouter")

local weld = Instance.new("Weld")
weld.Parent = glowout
weld.Part0 = glowout
weld.Part1 = leftArm

weld.C0 = CFrame.Angles(0,math.rad(90),0)
