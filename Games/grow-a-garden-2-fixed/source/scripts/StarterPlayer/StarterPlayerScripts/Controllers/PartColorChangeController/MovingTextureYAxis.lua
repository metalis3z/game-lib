--credit to quartz games studio
local t = {}
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local v1 = script.Name
local t2 = {}
local t3 = {}
local t4 = {}
local v2 = 200
local v3 = 1 / 60
local v4 = 1

local function RegisterTexture(p1) --[[ RegisterTexture | Line: 31 | Upvalues: t3 (copy), t2 (copy), t4 (copy) ]]
	if not p1:IsA("Texture") then
		return
	end

	if not t3[p1] then
		p1.OffsetStudsV = math.random(1, 20)
		p1.OffsetStudsU = math.random(1, 20)
		table.insert(t2, p1)
		t3[p1] = #t2
		t4[p1] = os.clock()
	end
end

local function UnregisterTexture(p1) --[[ UnregisterTexture | Line: 43 | Upvalues: t3 (copy), t2 (copy), t4 (copy), v4 (ref) ]]
	local v1 = t3[p1]

	if not v1 then
		return
	end

	local v2 = #t2
	local v3 = t2[v2]

	t2[v1] = v3
	t3[v3] = v1
	t2[v2] = nil
	t3[p1] = nil
	t4[p1] = nil

	if not (#t2 < v4) then
		return
	end

	v4 = 1
end

for v5, v6 in CollectionService:GetTagged(v1) do
	RegisterTexture(v6)
end

CollectionService:GetInstanceAddedSignal(v1):Connect(RegisterTexture)
CollectionService:GetInstanceRemovedSignal(v1):Connect(UnregisterTexture)
function t.Start(p1) --[[ Start | Line: 69 | Upvalues: RunService (copy), t2 (copy), v3 (ref), v2 (ref), v4 (ref), t4 (copy) ]]
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 70 | Upvalues: t2 (ref), v3 (ref), v2 (ref), v4 (ref), t4 (ref) ]]
		local v1 = #t2

		if v1 == 0 then
			return
		end

		v3 = v3 + (p1 - v3) * 0.1
		v2 = if v3 > 0.019166666666666665 then math.max(20, (math.floor(v2 * 0.85))) else math.min(200, v2 + 2)

		local v6 = math.min(v1, v2)
		local v7 = os.clock()

		for i = 1, v6 do
			local v8 = t2[v4]

			if v8 and v8.Parent then
				local v9 = v7 - (t4[v8] or v7)

				t4[v8] = v7

				local v10 = v8.OffsetStudsV + 2 * v9
				local StudsPerTileV = v8.StudsPerTileV

				if StudsPerTileV > 0 then
					v10 = v10 % StudsPerTileV
				end

				v8.OffsetStudsV = v10
			end

			v4 = v4 + 1

			if v1 < v4 then
				v4 = 1
			end
		end
	end)
end

return t