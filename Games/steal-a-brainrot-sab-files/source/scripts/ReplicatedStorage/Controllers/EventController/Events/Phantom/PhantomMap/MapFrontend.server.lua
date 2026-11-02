
if not script:IsDescendantOf(workspace) then
	return
end

local RunService = game:GetService("RunService")
local t1 = {}

for _, child in script.Parent.Decor.FloatingIslands:GetChildren() do
	if child:IsA("Model") then
		table.insert(t1, {
			model = child,
			origin = child:GetPivot(),
			phase = math.random() * 3.141592653589793 * 2
		})
	end
end

local v5 = script.Parent:QueryDescendants("BasePart[Name=LightFlash]")
local n1 = -1

RunService.Heartbeat:Connect(function()
	local elapsed = os.clock()

	for _, v9 in t1 do
		local v10 = math.sin(elapsed * 0.5 + v9.phase) * 7.5
		local v11 = v9.origin + Vector3.new(0, v10, 0)

		if v9.model.Name == "BrokenRing" then
			v11 *= CFrame.Angles(0, elapsed * -0.06544984694978735, 0)
		end

		v9.model:PivotTo(v11)
	end

	local v12 = workspace:GetServerTimeNow() % 5.9
	local n2 = 0

	if not (v12 < 3) then
		if v12 < 3.9 then
			if (v12 - 2 - 1) % 0.3 < 0.15 then
				n2 = 1
			end
		else
			n2 = (1 - math.cos((v12 - 2 - 1 - 0.8999999999999999) / 2 * 3.141592653589793 * 2 * 2)) / 2
		end
	end

	if n2 ~= n1 then
		n1 = n2

		local v14 = (1 - n2) * 0.9

		for _, v16 in v5 do
			v16.Transparency = v14
		end
	end
end)
