--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = nil
local v2 = nil

local function collectFromFolder(p1, p2) --[[ collectFromFolder | Line: 35 ]]
	if not p1 then
		return
	end

	for v1, v2 in p1:GetChildren() do
		if v2:IsA("StringValue") then
			local v4 = tonumber(string.match(v2.Value, "rbxassetid://(%d+)"))

			if v4 and v4 > 0 then
				p2[v4] = true
			end
		end
	end
end

local function build() --[[ build | Line: 46 | Upvalues: ReplicatedStorage (copy), collectFromFolder (copy), v1 (ref), v2 (ref) ]]
	local t = {}
	local SeedData = ReplicatedStorage.SharedModules:FindFirstChild("SeedData")

	if SeedData then
		collectFromFolder(SeedData:FindFirstChild("SeedImages"), t)
		collectFromFolder(SeedData:FindFirstChild("FruitImages"), t)
		collectFromFolder(SeedData:FindFirstChild("PlantImages"), t)
	end

	collectFromFolder(ReplicatedStorage.SharedModules:FindFirstChild("GearImages"), t)

	local t2 = {}

	for v12 in t do
		table.insert(t2, v12)
	end

	if #t2 == 0 then
		t[81520753924742] = true
		table.insert(t2, 81520753924742)
	end

	v1 = t2
	v2 = t
end

local function ensureBuilt() --[[ ensureBuilt | Line: 71 | Upvalues: v1 (ref), v2 (ref), build (copy) ]]
	if v1 and v2 then
		return v1, v2
	end

	build()

	return v1, v2
end

local t = {
	FALLBACK_ICON_ID = 81520753924742,
	DEFAULT_ICON_ID = 81520753924742,
	GetPool = function() --[[ GetPool | Line: 84 | Upvalues: v1 (ref), v2 (ref), build (copy) ]]
		if v1 and v2 then
			return v1
		end

		build()

		return v1
	end,
	Random = function() --[[ Random | Line: 89 | Upvalues: v1 (ref), v2 (ref), build (copy) ]]
		if v1 and v2 then
			local v12

			v12 = v1

			return v1[math.random(#v1)]
		end

		build()

		return v1[math.random(#v1)]
	end,
	IsPoolIcon = function(p1) --[[ IsPoolIcon | Line: 94 | Upvalues: v1 (ref), v2 (ref), build (copy) ]]
		if typeof(p1) ~= "number" then
			return false
		end

		if not (v1 and v2) then
			build()
		end

		return v2[p1] == true
	end
}

return table.freeze(t)