
local v1 = script.WaveSpawnPart
local v_u_2 = v1:GetPivot().Rotation
local v15 = {
    ["waveSpawnPart"] = v1,
    ["initialUpgradeCost"] = 1000,
    ["initialSpeed"] = 20,
    ["getUpgradeCost"] = function(p3, p4)
        local v5 = 1.1625 ^ (p3 + p4) * 1000
        local v6 = math.floor(v5)
        return math.max(v6, 1)
    end,
	["getTotalSpeed"] = function(p7)
		if p7 then
            return 20 + p7
		else
			return 20
		end
    end,
	["getExtraSpeed"] = function(p8)
        return p8
    end,
    ["upgrades"] = { 1, 5, 10 },
    ["products"] = {
        [1] = 3520721003,
        [5] = 3520721005,
        [10] = 3520721004
    },
    ["getWavePositionAtTime"] = function(p9, p10)
        local v11 = p9.despawnsAt - p9.spawnedAt
        local v12 = CFrame.new
        local v13 = p9.initialPosition
        local v14 = p9.distance * (p10 - p9.spawnedAt) / v11
        return v12(v13 + Vector3.new(0, 0, v14)) * v_u_2
    end
}
return v15