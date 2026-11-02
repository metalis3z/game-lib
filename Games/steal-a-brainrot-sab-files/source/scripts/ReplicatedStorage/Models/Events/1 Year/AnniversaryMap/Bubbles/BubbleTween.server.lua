
if not script:IsDescendantOf(workspace) then
	return
end

local RunService = game:GetService("RunService")
local t1 = {}

for _, v4 in script.Parent:GetChildren() do
	if v4:IsA("Model") then
		local OuterSphere = v4:FindFirstChild("OuterSphere")

		if OuterSphere and OuterSphere:IsA("BasePart") then
			local Pivot = v4:GetPivot()

			for _, v8 in v4:GetChildren() do
				if v8:FindFirstChild("AnimationController") then
					local RootPart = v8:FindFirstChild("RootPart", true)

					if RootPart and RootPart:IsA("BasePart") and RootPart ~= OuterSphere then
						RootPart.Anchored = false

						local WeldConstraint = Instance.new("WeldConstraint")

						WeldConstraint.Part0 = OuterSphere
						WeldConstraint.Part1 = RootPart
						WeldConstraint.Parent = RootPart
					end
				else
					if v8:IsA("BasePart") and v8 ~= OuterSphere then
						v8.Anchored = false

						local WeldConstraint = Instance.new("WeldConstraint")

						WeldConstraint.Part0 = OuterSphere
						WeldConstraint.Part1 = v8
						WeldConstraint.Parent = v8
					end

					for _, v13 in v8:QueryDescendants("BasePart") do
						if v13 ~= OuterSphere then
							v13.Anchored = false

							local WeldConstraint = Instance.new("WeldConstraint")

							WeldConstraint.Part0 = OuterSphere
							WeldConstraint.Part1 = v13
							WeldConstraint.Parent = v13
						end
					end
				end
			end

			for _, v16 in v4:QueryDescendants("BasePart") do
				v16.Anchored = false
			end

			OuterSphere.Anchored = false

			local Part = Instance.new("Part")

			Part.Name = "BubbleAnchor"
			Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
			Part.Transparency = 1
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.Massless = true
			Part.Anchored = true
			Part.CFrame = Pivot
			Part.Parent = v4

			local Motor6D = Instance.new("Motor6D")

			Motor6D.Part0 = Part
			Motor6D.Part1 = OuterSphere
			Motor6D.C0 = CFrame.identity
			Motor6D.C1 = OuterSphere.CFrame:ToObjectSpace(Pivot)
			Motor6D.Parent = Part
			t1[v4] = {
				Motor = Motor6D,
				Offset = math.random() * 3.141592653589793 * 2
			}
		end
	end
end

RunService.PreRender:Connect(function()
	for _, v23 in t1 do
		local v24 = os.clock() + v23.Offset

		v23.Motor.Transform = CFrame.new(0, math.sin(v24 * 2) * 5, 0) * CFrame.Angles(0, math.rad(math.sin(v24 * 4) * 8), 0)
	end
end)
