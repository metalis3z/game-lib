--credit to prince games studio
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local v1 = script.Name
local t = {}
local t2 = {}

for v2, v3 in CollectionService:GetTagged(v1) do
	if v3:IsA("BasePart") then
		table.insert(t, v3)
	end
end

CollectionService:GetInstanceAddedSignal(v1):Connect(function(p1) --[[ Line: 18 | Upvalues: t (copy) ]]
	if not p1:IsA("BasePart") then
		return
	end

	table.insert(t, p1)
end)
function t2.Start(p1) --[[ Start | Line: 24 | Upvalues: RunService (copy), t (copy) ]]
	RunService.Heartbeat:Connect(function() --[[ Line: 25 | Upvalues: t (ref) ]]
		local v1 = tick()

		for v2, v3 in t do
			if v3.Parent then
				v3.Color = Color3.fromHSV(0, 1, (math.sin((v3.Position.Y - v1 * 0.5) / 1 * math.pi * 2) + 1) / 2 * 0.55 + 0.35)
			end
		end
	end)
end

return t2