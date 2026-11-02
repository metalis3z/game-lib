--credit to leon games studio
local t = {}

game:GetService("CollectionService")

local RunService = game:GetService("RunService")
local t2 = {}

function t.Init(p1) --[[ Init | Line: 9 ]] end
function t.Start(p1) --[[ Start | Line: 12 | Upvalues: t2 (copy), RunService (copy) ]]
	for v1, v2 in workspace:GetDescendants() do
		if v2:IsA("BasePart") and v2:GetAttribute("VELOCITY") ~= nil then
			p1:RegisterConveyor(v2)
		end
	end

	workspace.DescendantAdded:Connect(function(p12) --[[ Line: 21 | Upvalues: p1 (copy) ]]
		if not p12:IsA("BasePart") or p12:GetAttribute("VELOCITY") == nil then
			return
		end

		p1:RegisterConveyor(p12)
	end)
	workspace.DescendantRemoving:Connect(function(p1) --[[ Line: 27 | Upvalues: t2 (ref) ]]
		t2[p1] = nil
	end)
	RunService.Heartbeat:Connect(function() --[[ Line: 32 | Upvalues: t2 (ref) ]]
		debug.profilebegin("Controllers/ConveyorController/Heartbeat")

		for v1, v2 in t2 do
			local v3 = v1:GetAttribute("VELOCITY")

			if v3 then
				v1.AssemblyLinearVelocity = v1.CFrame.LookVector * v3
			end
		end

		debug.profileend()
	end)
end
function t.RegisterConveyor(p1, p2) --[[ RegisterConveyor | Line: 44 | Upvalues: t2 (copy) ]]
	t2[p2] = true
	p2:GetAttributeChangedSignal("VELOCITY"):Connect(function() --[[ Line: 48 | Upvalues: p2 (copy), t2 (ref) ]]
		if p2:GetAttribute("VELOCITY") == nil then
			t2[p2] = nil
		else
			t2[p2] = true
		end
	end)
end

return t