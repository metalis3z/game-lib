--credit to leon games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local t8 = {}
local t9 = {}
local t10 = {}
local t11 = {}
local t12 = {}
local t13 = {}
local t14 = {}
local t15 = {}
local t16 = {}
local t17 = {}
local t18 = {}
local t19 = {}
local t20 = {}
local t21 = {}
local t22 = {}
local t23 = {}

local function SafeInvokeCallback(p1, ...) --[[ SafeInvokeCallback | Line: 35 ]]
	local ok, result = pcall(p1, ...)

	if ok then
		return
	end

	warn((("[GardenSyncController] Garden sync callback errored: %*"):format(result)))
end

local function normalizeUserId(p1) --[[ normalizeUserId | Line: 42 ]]
	return tonumber(p1) or p1
end

function t.Init(p1) --[[ Init | Line: 46 ]] end
function t.Start(p1) --[[ Start | Line: 49 | Upvalues: Networking (copy), Players (copy) ]]
	Networking.Garden.SyncAllGardens.OnClientEvent:Connect(function(p12) --[[ Line: 50 | Upvalues: p1 (copy) ]]
		p1:HandleGardensSync(p12)
	end)
	task.spawn(function() --[[ Line: 59 | Upvalues: Networking (ref) ]]
		Networking.Garden.RequestGardens:Fire()
	end)
	Networking.Garden.PlantAdded.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 63 | Upvalues: p1 (copy) ]]
		p1:HandlePlantAdded(tonumber(p12) or p12, p2, p3)
	end)
	Networking.Garden.PlantRemoved.OnClientEvent:Connect(function(p12, p2) --[[ Line: 67 | Upvalues: p1 (copy) ]]
		p1:HandlePlantRemoved(tonumber(p12) or p12, p2)
	end)
	Networking.Garden.PlantGrowthUpdated.OnClientEvent:Connect(function(p12, p2, p3, p4) --[[ Line: 71 | Upvalues: p1 (copy) ]]
		p1:HandlePlantGrowthUpdated(tonumber(p12) or p12, p2, p3, p4)
	end)
	Networking.Garden.PlantAgeSync.OnClientEvent:Connect(function(p12, p2) --[[ Line: 75 | Upvalues: p1 (copy) ]]
		p1:HandlePlantAgeSync(tonumber(p12) or p12, p2)
	end)
	Networking.Garden.SprinklerAdded.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 79 | Upvalues: p1 (copy) ]]
		p1:HandleSprinklerAdded(tonumber(p12) or p12, p2, p3)
	end)
	Networking.Garden.SprinklerRemoved.OnClientEvent:Connect(function(p12, p2) --[[ Line: 83 | Upvalues: p1 (copy) ]]
		p1:HandleSprinklerRemoved(tonumber(p12) or p12, p2)
	end)
	Networking.Garden.RakeAdded.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 87 | Upvalues: p1 (copy) ]]
		p1:HandleRakeAdded(tonumber(p12) or p12, p2, p3)
	end)
	Networking.Garden.RakeRemoved.OnClientEvent:Connect(function(p12, p2) --[[ Line: 91 | Upvalues: p1 (copy) ]]
		p1:HandleRakeRemoved(tonumber(p12) or p12, p2)
	end)
	Networking.Garden.FruitAdded.OnClientEvent:Connect(function(p12, p2, p3, p4) --[[ Line: 95 | Upvalues: p1 (copy) ]]
		p1:HandleFruitAdded(tonumber(p12) or p12, p2, p3, p4)
	end)
	Networking.Garden.FruitRemoved.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 99 | Upvalues: p1 (copy) ]]
		p1:HandleFruitRemoved(tonumber(p12) or p12, p2, p3)
	end)
	Networking.Garden.FruitGrowthUpdated.OnClientEvent:Connect(function(p12, p2, p3, p4, p5) --[[ Line: 103 | Upvalues: p1 (copy) ]]
		p1:HandleFruitGrowthUpdated(tonumber(p12) or p12, p2, p3, p4, p5)
	end)
	Networking.Garden.FruitAgeSync.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 107 | Upvalues: p1 (copy) ]]
		p1:HandleFruitAgeSync(tonumber(p12) or p12, p2, p3)
	end)
	Networking.Garden.FruitOvertimeGrowthUpdated.OnClientEvent:Connect(function(p12, p2, p3, p4) --[[ Line: 111 | Upvalues: p1 (copy) ]]
		p1:HandleFruitOvertimeGrowthUpdated(tonumber(p12) or p12, p2, p3, p4)
	end)
	Networking.Prop.PropPlaced.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 115 | Upvalues: p1 (copy) ]]
		p1:HandlePropAdded(tonumber(p12) or p12, p2, p3)
	end)
	Networking.Prop.PropRemoved.OnClientEvent:Connect(function(p12, p2) --[[ Line: 119 | Upvalues: p1 (copy) ]]
		p1:HandlePropRemoved(tonumber(p12) or p12, p2)
	end)
	Networking.Prop.PropExtraDataUpdated.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 123 | Upvalues: p1 (copy) ]]
		p1:HandlePropExtraDataUpdated(tonumber(p12) or p12, p2, p3)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 127 | Upvalues: p1 (copy) ]]
		p1:CleanupPlayerGarden(p12.UserId)
	end)
end
function t.OnPlantMutationUpdated(p1, p2) --[[ OnPlantMutationUpdated | Line: 132 | Upvalues: Networking (copy) ]]
	Networking.Garden.PlantMutationUpdated.OnClientEvent:Connect(p2)
end
function t.OnFruitMutationUpdated(p1, p2) --[[ OnFruitMutationUpdated | Line: 136 | Upvalues: Networking (copy) ]]
	Networking.Garden.FruitMutationUpdated.OnClientEvent:Connect(p2)
end

local t24 = {}
local v1 = false
local v2 = 0
local v3 = 0
local v4 = 0

function t.EnqueueSpawnEntries(p1, p2, p3) --[[ EnqueueSpawnEntries | Line: 152 | Upvalues: v1 (ref), LocalPlayer (copy), t24 (copy), v2 (ref) ]]
	if p3 == 0 then
		return
	end

	if p3 <= 5 and not v1 then
		for v12, v22 in p2 do
			v22.fn()
		end
	else
		local UserId = LocalPlayer.UserId

		for v3, v4 in p2 do
			if v4.userId == UserId then
				table.insert(t24, v4)
			end
		end

		for v6, v7 in p2 do
			if v7.userId ~= UserId then
				table.insert(t24, v7)
			end
		end

		v2 = v2 + p3

		if v1 then
			LocalPlayer:SetAttribute("GardenLoadingTotal", v2)
		else
			p1:StartQueueProcessing()
		end
	end
end
function t.StartQueueProcessing(p1) --[[ StartQueueProcessing | Line: 185 | Upvalues: v1 (ref), LocalPlayer (copy), v2 (ref), v4 (ref), t24 (copy), v3 (ref) ]]
	v1 = true
	task.spawn(function() --[[ Line: 188 | Upvalues: LocalPlayer (ref), v2 (ref), v4 (ref), t24 (ref), v3 (ref), v1 (ref) ]]
		LocalPlayer:SetAttribute("GardenLoadingTotal", v2)
		LocalPlayer:SetAttribute("GardenLoadingProgress", 0)
		v4 = 0

		local v12 = os.clock()

		while v4 < #t24 do
			v4 = v4 + 1

			local v22 = t24[v4]

			v22.fn()
			v3 = v3 + v22.entityCount

			local v32 = if LocalPlayer:GetAttribute("LoadingScreenActive") == true then 0.04 else 0.004

			if v4 < #t24 and v32 <= os.clock() - v12 then
				LocalPlayer:SetAttribute("GardenLoadingProgress", v3)
				LocalPlayer:SetAttribute("GardenLoadingTotal", v2)
				task.wait()
				v12 = os.clock()
			end
		end

		LocalPlayer:SetAttribute("GardenLoadingTotal", nil)
		LocalPlayer:SetAttribute("GardenLoadingProgress", nil)
		table.clear(t24)
		v1 = false
		v2 = 0
		v3 = 0
		v4 = 0
	end)
end
function t.IsLocalGardenLoaded(p1) --[[ IsLocalGardenLoaded | Line: 222 | Upvalues: LocalPlayer (copy), t2 (copy), v1 (ref), v4 (ref), t24 (copy) ]]
	local UserId = LocalPlayer.UserId

	if not t2[UserId] then
		return false
	end

	if not v1 then
		return true
	end

	for i = v4 + 1, #t24 do
		if t24[i].userId == UserId then
			return false
		end
	end

	return true
end
function t.WaitForLocalGardenLoaded(p1) --[[ WaitForLocalGardenLoaded | Line: 238 ]]
	while not p1:IsLocalGardenLoaded() do
		task.wait()
	end
end
function t.HandleGardensSync(p1, p2) --[[ HandleGardensSync | Line: 244 | Upvalues: t2 (copy), t3 (copy), t4 (copy), t5 (copy), t6 (copy), SafeInvokeCallback (copy), t14 (copy), t19 (copy), t18 (copy), t10 (copy), t12 (copy), t21 (copy) ]]
	local t = {}
	local sum = 0

	for v1, v2 in p2 do
		local v3 = tonumber(v1) or v1

		if not t2[v3] then
			t2[v3] = {}
		end

		if not t3[v3] then
			t3[v3] = {}
		end

		if not t4[v3] then
			t4[v3] = {}
		end

		if not t5[v3] then
			t5[v3] = {}
		end

		if v2.Plants then
			for v4, v5 in v2.Plants do
				local v6 = t2[v3][v4]
				local v7 = t2[v3][v4] and v6.Fruits or {}

				t2[v3][v4] = v5

				if v6 then
					for v8, v9 in t19 do
						task.spawn(SafeInvokeCallback, v9, v3, v4, v5)
					end

					if v5.Fruits then
						for v10, v11 in v5.Fruits do
							if v7[v10] then
								local v13 = v11.OvertimeGrowth or 1

								if math.floor((v7[v10].OvertimeGrowth or 1) * 100) ~= math.floor(v13 * 100) then
									t2[v3][v4].Fruits[v10] = v11

									local t7 = {
										entityCount = 0,
										userId = v3,
										fn = function() --[[ fn | Line: 320 | Upvalues: t18 (ref), SafeInvokeCallback (ref), v3 (copy), v4 (copy), v10 (copy), v13 (copy) ]]
											for v1, v2 in t18 do
												task.spawn(SafeInvokeCallback, v2, v3, v4, v10, v13)
											end
										end
									}

									table.insert(t, t7)
								end

								continue
							end

							local t7 = {
								entityCount = 1,
								userId = v3,
								fn = function() --[[ fn | Line: 304 | Upvalues: t14 (ref), SafeInvokeCallback (ref), v3 (copy), v4 (copy), v10 (copy), v11 (copy) ]]
									for v1, v2 in t14 do
										task.spawn(SafeInvokeCallback, v2, v3, v4, v10, v11)
									end
								end
							}

							table.insert(t, t7)
							sum = sum + 1
						end
					end

					continue
				end

				local t7 = {}

				if v5.Fruits then
					for v14, v15 in v5.Fruits do
						table.insert(t7, {
							fruitId = v14,
							fruitData = v15
						})
					end
				end

				local v16 = #t7 + 1
				local t8 = {
					userId = v3,
					entityCount = v16,
					fn = function() --[[ fn | Line: 282 | Upvalues: t6 (ref), SafeInvokeCallback (ref), v3 (copy), v4 (copy), v5 (copy), t7 (copy), t14 (ref) ]]
						for v1, v2 in t6 do
							task.spawn(SafeInvokeCallback, v2, v3, v4, v5)
						end

						for v32, v42 in t7 do
							for v52, v6 in t14 do
								task.spawn(SafeInvokeCallback, v6, v3, v4, v42.fruitId, v42.fruitData)
							end
						end
					end
				}

				table.insert(t, t8)
				sum = sum + v16
			end
		end

		if v2.Sprinklers then
			for v17, v18 in v2.Sprinklers do
				if t3[v3][v17] then
					t3[v3][v17] = v18

					continue
				end

				t3[v3][v17] = v18

				local t7 = {
					entityCount = 1,
					userId = v3,
					fn = function() --[[ fn | Line: 342 | Upvalues: t10 (ref), SafeInvokeCallback (ref), v3 (copy), v17 (copy), v18 (copy) ]]
						for v1, v2 in t10 do
							task.spawn(SafeInvokeCallback, v2, v3, v17, v18)
						end
					end
				}

				table.insert(t, t7)
				sum = sum + 1
			end
		end

		if v2.Rakes then
			for v19, v20 in v2.Rakes do
				if t4[v3][v19] then
					t4[v3][v19] = v20

					continue
				end

				t4[v3][v19] = v20

				local t7 = {
					entityCount = 1,
					userId = v3,
					fn = function() --[[ fn | Line: 362 | Upvalues: t12 (ref), SafeInvokeCallback (ref), v3 (copy), v19 (copy), v20 (copy) ]]
						for v1, v2 in t12 do
							task.spawn(SafeInvokeCallback, v2, v3, v19, v20)
						end
					end
				}

				table.insert(t, t7)
				sum = sum + 1
			end
		end

		if v2.Props then
			for v21, v22 in v2.Props do
				if t5[v3][v21] then
					t5[v3][v21] = v22

					continue
				end

				t5[v3][v21] = v22

				local t7 = {
					entityCount = 1,
					userId = v3,
					fn = function() --[[ fn | Line: 382 | Upvalues: t21 (ref), SafeInvokeCallback (ref), v3 (copy), v21 (copy), v22 (copy) ]]
						for v1, v2 in t21 do
							task.spawn(SafeInvokeCallback, v2, v3, v21, v22)
						end
					end
				}

				table.insert(t, t7)
				sum = sum + 1
			end
		end
	end

	p1:EnqueueSpawnEntries(t, sum)
end
function t.HandlePlantAdded(p1, p2, p3, p4) --[[ HandlePlantAdded | Line: 401 | Upvalues: t2 (copy), t6 (copy), SafeInvokeCallback (copy), t14 (copy) ]]
	if not t2[p2] then
		t2[p2] = {}
	end

	t2[p2][p3] = p4

	for v1, v2 in t6 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4)
	end

	if not p4.Fruits then
		return
	end

	for v3, v4 in p4.Fruits do
		for v5, v6 in t14 do
			task.spawn(SafeInvokeCallback, v6, p2, p3, v3, v4)
		end
	end
end
function t.HandlePlantRemoved(p1, p2, p3) --[[ HandlePlantRemoved | Line: 419 | Upvalues: t2 (copy), t7 (copy), SafeInvokeCallback (copy) ]]
	if t2[p2] then
		t2[p2][p3] = nil
	end

	for v1, v2 in t7 do
		task.spawn(SafeInvokeCallback, v2, p2, p3)
	end
end
function t.HandlePlantGrowthUpdated(p1, p2, p3, p4, p5) --[[ HandlePlantGrowthUpdated | Line: 428 | Upvalues: t2 (copy), t8 (copy), SafeInvokeCallback (copy) ]]
	if t2[p2] and t2[p2][p3] then
		t2[p2][p3].Age = p4
	end

	for v1, v2 in t8 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4, p5)
	end
end
function t.HandlePlantAgeSync(p1, p2, p3) --[[ HandlePlantAgeSync | Line: 438 | Upvalues: t2 (copy), t9 (copy), SafeInvokeCallback (copy) ]]
	if not t2[p2] then
		t2[p2] = {}
	end

	for v1, v2 in p3 do
		if t2[p2][v1] then
			t2[p2][v1].Age = v2
		end
	end

	for v3, v4 in t9 do
		task.spawn(SafeInvokeCallback, v4, p2, p3)
	end
end
function t.HandleSprinklerAdded(p1, p2, p3, p4) --[[ HandleSprinklerAdded | Line: 457 | Upvalues: t3 (copy), t10 (copy), SafeInvokeCallback (copy) ]]
	if not t3[p2] then
		t3[p2] = {}
	end

	t3[p2][p3] = p4

	for v1, v2 in t10 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4)
	end
end
function t.HandleSprinklerRemoved(p1, p2, p3) --[[ HandleSprinklerRemoved | Line: 467 | Upvalues: t3 (copy), t11 (copy), SafeInvokeCallback (copy) ]]
	if t3[p2] then
		t3[p2][p3] = nil
	end

	for v1, v2 in t11 do
		task.spawn(SafeInvokeCallback, v2, p2, p3)
	end
end
function t.HandleRakeAdded(p1, p2, p3, p4) --[[ HandleRakeAdded | Line: 479 | Upvalues: t4 (copy), t12 (copy), SafeInvokeCallback (copy) ]]
	if not t4[p2] then
		t4[p2] = {}
	end

	t4[p2][p3] = p4

	for v1, v2 in t12 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4)
	end
end
function t.HandleRakeRemoved(p1, p2, p3) --[[ HandleRakeRemoved | Line: 489 | Upvalues: t4 (copy), t13 (copy), SafeInvokeCallback (copy) ]]
	if t4[p2] then
		t4[p2][p3] = nil
	end

	for v1, v2 in t13 do
		task.spawn(SafeInvokeCallback, v2, p2, p3)
	end
end
function t.HandlePropAdded(p1, p2, p3, p4) --[[ HandlePropAdded | Line: 501 | Upvalues: t5 (copy), t21 (copy), SafeInvokeCallback (copy) ]]
	if not t5[p2] then
		t5[p2] = {}
	end

	t5[p2][p3] = p4

	for v1, v2 in t21 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4)
	end
end
function t.HandlePropRemoved(p1, p2, p3) --[[ HandlePropRemoved | Line: 511 | Upvalues: t5 (copy), t22 (copy), SafeInvokeCallback (copy) ]]
	if t5[p2] then
		t5[p2][p3] = nil
	end

	for v1, v2 in t22 do
		task.spawn(SafeInvokeCallback, v2, p2, p3)
	end
end
function t.HandlePropExtraDataUpdated(p1, p2, p3, p4) --[[ HandlePropExtraDataUpdated | Line: 520 | Upvalues: t5 (copy), t23 (copy), SafeInvokeCallback (copy) ]]
	if t5[p2] and t5[p2][p3] then
		t5[p2][p3].ExtraData = p4
	end

	for v1, v2 in t23 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4)
	end
end
function t.HandleFruitAdded(p1, p2, p3, p4, p5) --[[ HandleFruitAdded | Line: 532 | Upvalues: t2 (copy), t14 (copy), SafeInvokeCallback (copy) ]]
	if not t2[p2] then
		t2[p2] = {}
	end

	if not t2[p2][p3] then
		t2[p2][p3] = {}
	end

	if not t2[p2][p3].Fruits then
		t2[p2][p3].Fruits = {}
	end

	t2[p2][p3].Fruits[p4] = p5

	for v1, v2 in t14 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4, p5)
	end
end
function t.HandleFruitRemoved(p1, p2, p3, p4) --[[ HandleFruitRemoved | Line: 549 | Upvalues: t2 (copy), t15 (copy), SafeInvokeCallback (copy) ]]
	if t2[p2] and (t2[p2][p3] and t2[p2][p3].Fruits) then
		t2[p2][p3].Fruits[p4] = nil
	end

	for v1, v2 in t15 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4)
	end
end
function t.HandleFruitGrowthUpdated(p1, p2, p3, p4, p5, p6) --[[ HandleFruitGrowthUpdated | Line: 559 | Upvalues: t2 (copy), t16 (copy), SafeInvokeCallback (copy) ]]
	if t2[p2] and (t2[p2][p3] and (t2[p2][p3].Fruits and t2[p2][p3].Fruits[p4])) then
		t2[p2][p3].Fruits[p4].Age = p5
		t2[p2][p3].Fruits[p4].GrowRate = p6
	end

	for v1, v2 in t16 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4, p5, p6)
	end
end
function t.HandleFruitAgeSync(p1, p2, p3, p4) --[[ HandleFruitAgeSync | Line: 570 | Upvalues: t2 (copy), t17 (copy), SafeInvokeCallback (copy) ]]
	if not (t2[p2] and (t2[p2][p3] and t2[p2][p3].Fruits)) then
		return
	end

	for v1, v2 in p4 do
		if t2[p2][p3].Fruits[v1] then
			t2[p2][p3].Fruits[v1].Age = v2
		end
	end

	for v3, v4 in t17 do
		task.spawn(SafeInvokeCallback, v4, p2, p3, p4)
	end
end
function t.HandleFruitOvertimeGrowthUpdated(p1, p2, p3, p4, p5) --[[ HandleFruitOvertimeGrowthUpdated | Line: 584 | Upvalues: t2 (copy), t18 (copy), SafeInvokeCallback (copy) ]]
	if t2[p2] and (t2[p2][p3] and (t2[p2][p3].Fruits and t2[p2][p3].Fruits[p4])) then
		t2[p2][p3].Fruits[p4].OvertimeGrowth = p5
	end

	for v1, v2 in t18 do
		task.spawn(SafeInvokeCallback, v2, p2, p3, p4, p5)
	end
end
function t.GetGarden(p1, p2) --[[ GetGarden | Line: 597 | Upvalues: t2 (copy) ]]
	return t2[tonumber(p2) or p2] or {}
end
function t.GetPlant(p1, p2, p3) --[[ GetPlant | Line: 601 | Upvalues: t2 (copy) ]]
	local v1 = tonumber(p2) or p2

	if t2[v1] then
		return t2[v1][p3]
	end

	return nil
end
function t.GetAllGardens(p1) --[[ GetAllGardens | Line: 607 | Upvalues: t2 (copy) ]]
	return t2
end
function t.GetSprinklers(p1, p2) --[[ GetSprinklers | Line: 611 | Upvalues: t3 (copy) ]]
	return t3[tonumber(p2) or p2] or {}
end
function t.GetSprinkler(p1, p2, p3) --[[ GetSprinkler | Line: 615 | Upvalues: t3 (copy) ]]
	local v1 = tonumber(p2) or p2

	if t3[v1] then
		return t3[v1][p3]
	end

	return nil
end
function t.GetAllSprinklers(p1) --[[ GetAllSprinklers | Line: 621 | Upvalues: t3 (copy) ]]
	return t3
end
function t.GetRakes(p1, p2) --[[ GetRakes | Line: 625 | Upvalues: t4 (copy) ]]
	return t4[tonumber(p2) or p2] or {}
end
function t.GetRake(p1, p2, p3) --[[ GetRake | Line: 629 | Upvalues: t4 (copy) ]]
	local v1 = tonumber(p2) or p2

	if t4[v1] then
		return t4[v1][p3]
	end

	return nil
end
function t.GetAllRakes(p1) --[[ GetAllRakes | Line: 635 | Upvalues: t4 (copy) ]]
	return t4
end
function t.GetProps(p1, p2) --[[ GetProps | Line: 639 | Upvalues: t5 (copy) ]]
	return t5[tonumber(p2) or p2] or {}
end
function t.GetProp(p1, p2, p3) --[[ GetProp | Line: 643 | Upvalues: t5 (copy) ]]
	local v1 = tonumber(p2) or p2

	if t5[v1] then
		return t5[v1][p3]
	end

	return nil
end
function t.GetAllProps(p1) --[[ GetAllProps | Line: 649 | Upvalues: t5 (copy) ]]
	return t5
end
function t.OnPlantAdded(p1, p2) --[[ OnPlantAdded | Line: 656 | Upvalues: t6 (copy) ]]
	local v1 = t6

	table.insert(v1, p2)

	return function() --[[ Line: 658 | Upvalues: t6 (ref), p2 (copy) ]]
		local v1 = table.find(t6, p2)

		if not v1 then
			return
		end

		table.remove(t6, v1)
	end
end
function t.OnPlantVisualCheck(p1, p2) --[[ OnPlantVisualCheck | Line: 666 | Upvalues: t19 (copy) ]]
	local v1 = t19

	table.insert(v1, p2)

	return function() --[[ Line: 668 | Upvalues: t19 (ref), p2 (copy) ]]
		local v1 = table.find(t19, p2)

		if not v1 then
			return
		end

		table.remove(t19, v1)
	end
end
function t.OnFruitVisualCheck(p1, p2) --[[ OnFruitVisualCheck | Line: 679 | Upvalues: t20 (copy) ]]
	local v1 = t20

	table.insert(v1, p2)

	return function() --[[ Line: 681 | Upvalues: t20 (ref), p2 (copy) ]]
		local v1 = table.find(t20, p2)

		if not v1 then
			return
		end

		table.remove(t20, v1)
	end
end
function t.ReconcileLocalGarden(p1) --[[ ReconcileLocalGarden | Line: 694 | Upvalues: LocalPlayer (copy), t2 (copy), t19 (copy), SafeInvokeCallback (copy), t20 (copy) ]]
	local UserId = LocalPlayer.UserId
	local v1 = t2[UserId]

	if not v1 then
		return 0
	end

	local count = 0

	for v2, v3 in v1 do
		count = count + 1

		for v4, v5 in t19 do
			task.spawn(SafeInvokeCallback, v5, UserId, v2, v3)
		end

		if v3.Fruits then
			for v6, v7 in v3.Fruits do
				for v8, v9 in t20 do
					task.spawn(SafeInvokeCallback, v9, UserId, v2, v6, v7)
				end
			end
		end
	end

	return count
end
function t.OnPlantRemoved(p1, p2) --[[ OnPlantRemoved | Line: 716 | Upvalues: t7 (copy) ]]
	local v1 = t7

	table.insert(v1, p2)

	return function() --[[ Line: 718 | Upvalues: t7 (ref), p2 (copy) ]]
		local v1 = table.find(t7, p2)

		if not v1 then
			return
		end

		table.remove(t7, v1)
	end
end
function t.OnPlantGrowthUpdated(p1, p2) --[[ OnPlantGrowthUpdated | Line: 726 | Upvalues: t8 (copy) ]]
	local v1 = t8

	table.insert(v1, p2)

	return function() --[[ Line: 728 | Upvalues: t8 (ref), p2 (copy) ]]
		local v1 = table.find(t8, p2)

		if not v1 then
			return
		end

		table.remove(t8, v1)
	end
end
function t.OnPlantAgeSync(p1, p2) --[[ OnPlantAgeSync | Line: 736 | Upvalues: t9 (copy) ]]
	local v1 = t9

	table.insert(v1, p2)

	return function() --[[ Line: 738 | Upvalues: t9 (ref), p2 (copy) ]]
		local v1 = table.find(t9, p2)

		if not v1 then
			return
		end

		table.remove(t9, v1)
	end
end
function t.OnSprinklerAdded(p1, p2) --[[ OnSprinklerAdded | Line: 746 | Upvalues: t10 (copy) ]]
	local v1 = t10

	table.insert(v1, p2)

	return function() --[[ Line: 748 | Upvalues: t10 (ref), p2 (copy) ]]
		local v1 = table.find(t10, p2)

		if not v1 then
			return
		end

		table.remove(t10, v1)
	end
end
function t.OnSprinklerRemoved(p1, p2) --[[ OnSprinklerRemoved | Line: 756 | Upvalues: t11 (copy) ]]
	local v1 = t11

	table.insert(v1, p2)

	return function() --[[ Line: 758 | Upvalues: t11 (ref), p2 (copy) ]]
		local v1 = table.find(t11, p2)

		if not v1 then
			return
		end

		table.remove(t11, v1)
	end
end
function t.OnRakeAdded(p1, p2) --[[ OnRakeAdded | Line: 766 | Upvalues: t12 (copy) ]]
	local v1 = t12

	table.insert(v1, p2)

	return function() --[[ Line: 768 | Upvalues: t12 (ref), p2 (copy) ]]
		local v1 = table.find(t12, p2)

		if not v1 then
			return
		end

		table.remove(t12, v1)
	end
end
function t.OnRakeRemoved(p1, p2) --[[ OnRakeRemoved | Line: 776 | Upvalues: t13 (copy) ]]
	local v1 = t13

	table.insert(v1, p2)

	return function() --[[ Line: 778 | Upvalues: t13 (ref), p2 (copy) ]]
		local v1 = table.find(t13, p2)

		if not v1 then
			return
		end

		table.remove(t13, v1)
	end
end
function t.OnPropAdded(p1, p2) --[[ OnPropAdded | Line: 786 | Upvalues: t21 (copy) ]]
	local v1 = t21

	table.insert(v1, p2)

	return function() --[[ Line: 788 | Upvalues: t21 (ref), p2 (copy) ]]
		local v1 = table.find(t21, p2)

		if not v1 then
			return
		end

		table.remove(t21, v1)
	end
end
function t.OnPropRemoved(p1, p2) --[[ OnPropRemoved | Line: 796 | Upvalues: t22 (copy) ]]
	local v1 = t22

	table.insert(v1, p2)

	return function() --[[ Line: 798 | Upvalues: t22 (ref), p2 (copy) ]]
		local v1 = table.find(t22, p2)

		if not v1 then
			return
		end

		table.remove(t22, v1)
	end
end
function t.OnPropExtraDataUpdated(p1, p2) --[[ OnPropExtraDataUpdated | Line: 806 | Upvalues: t23 (copy) ]]
	local v1 = t23

	table.insert(v1, p2)

	return function() --[[ Line: 808 | Upvalues: t23 (ref), p2 (copy) ]]
		local v1 = table.find(t23, p2)

		if not v1 then
			return
		end

		table.remove(t23, v1)
	end
end
function t.OnFruitAdded(p1, p2) --[[ OnFruitAdded | Line: 816 | Upvalues: t14 (copy) ]]
	local v1 = t14

	table.insert(v1, p2)

	return function() --[[ Line: 818 | Upvalues: t14 (ref), p2 (copy) ]]
		local v1 = table.find(t14, p2)

		if not v1 then
			return
		end

		table.remove(t14, v1)
	end
end
function t.OnFruitRemoved(p1, p2) --[[ OnFruitRemoved | Line: 826 | Upvalues: t15 (copy) ]]
	local v1 = t15

	table.insert(v1, p2)

	return function() --[[ Line: 828 | Upvalues: t15 (ref), p2 (copy) ]]
		local v1 = table.find(t15, p2)

		if not v1 then
			return
		end

		table.remove(t15, v1)
	end
end
function t.OnFruitGrowthUpdated(p1, p2) --[[ OnFruitGrowthUpdated | Line: 836 | Upvalues: t16 (copy) ]]
	local v1 = t16

	table.insert(v1, p2)

	return function() --[[ Line: 838 | Upvalues: t16 (ref), p2 (copy) ]]
		local v1 = table.find(t16, p2)

		if not v1 then
			return
		end

		table.remove(t16, v1)
	end
end
function t.OnFruitAgeSync(p1, p2) --[[ OnFruitAgeSync | Line: 846 | Upvalues: t17 (copy) ]]
	local v1 = t17

	table.insert(v1, p2)

	return function() --[[ Line: 848 | Upvalues: t17 (ref), p2 (copy) ]]
		local v1 = table.find(t17, p2)

		if not v1 then
			return
		end

		table.remove(t17, v1)
	end
end
function t.OnFruitOvertimeGrowthUpdated(p1, p2) --[[ OnFruitOvertimeGrowthUpdated | Line: 856 | Upvalues: t18 (copy) ]]
	local v1 = t18

	table.insert(v1, p2)

	return function() --[[ Line: 858 | Upvalues: t18 (ref), p2 (copy) ]]
		local v1 = table.find(t18, p2)

		if not v1 then
			return
		end

		table.remove(t18, v1)
	end
end
function t.CleanupPlayerGarden(p1, p2) --[[ CleanupPlayerGarden | Line: 869 | Upvalues: t2 (copy), t3 (copy), t4 (copy), t5 (copy) ]]
	local v1 = tonumber(p2) or p2

	if t2[v1] then
		for v2 in t2[v1] do
			p1:HandlePlantRemoved(v1, v2)
		end

		t2[v1] = nil
	end

	if t3[v1] then
		for v3 in t3[v1] do
			p1:HandleSprinklerRemoved(v1, v3)
		end

		t3[v1] = nil
	end

	if t4[v1] then
		for v4 in t4[v1] do
			p1:HandleRakeRemoved(v1, v4)
		end

		t4[v1] = nil
	end

	if not t5[v1] then
		return
	end

	for v5 in t5[v1] do
		p1:HandlePropRemoved(v1, v5)
	end

	t5[v1] = nil
end

return t