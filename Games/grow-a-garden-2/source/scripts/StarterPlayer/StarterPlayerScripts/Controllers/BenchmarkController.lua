--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local BenchmarkPackets = require(ReplicatedStorage.SharedModules.BenchmarkPackets)
local v1 = false

local function SafeNumber(p1, p2) --[[ SafeNumber | Line: 45 ]]
	local ok, result = pcall(p1)

	if ok and type(result) == "number" then
		return result
	end

	return p2
end

local function TakeStatSample() --[[ TakeStatSample | Line: 53 | Upvalues: Stats (copy) ]]
	local t = {}

	local function f1() --[[ Line: 55 | Upvalues: Stats (ref) ]]
		return Stats.SceneDrawcallCount
	end

	local ok, result = pcall(f1)

	t.Drawcalls = if ok and type(result) == "number" then result else 0

	local function f3() --[[ Line: 56 | Upvalues: Stats (ref) ]]
		return Stats.SceneTriangleCount
	end

	local ok2, result2 = pcall(f3)

	t.Triangles = if ok2 and type(result2) == "number" then result2 else 0

	local function f5() --[[ Line: 57 | Upvalues: Stats (ref) ]]
		return Stats.InstanceCount
	end

	local ok3, result3 = pcall(f5)

	t.InstanceCount = if ok3 and type(result3) == "number" then result3 else 0

	local function f7() --[[ Line: 58 | Upvalues: Stats (ref) ]]
		return Stats:GetTotalMemoryUsageMb()
	end

	local ok4, result4 = pcall(f7)

	t.MemoryMb = if ok4 and type(result4) == "number" then result4 else 0

	local ok5, result5 = pcall(function() --[[ Line: 59 ]]
		return workspace:GetRealPhysicsFPS()
	end)

	t.PhysicsFps = if ok5 and type(result5) == "number" then result5 else 0

	local ok6, result6 = pcall(function() --[[ Line: 60 ]]
		return workspace:GetNumAwakeParts()
	end)

	t.AwakeParts = if ok6 and type(result6) == "number" then result6 else 0

	local function f11() --[[ Line: 61 | Upvalues: Stats (ref) ]]
		return Stats.HeartbeatTime * 1000
	end

	local ok7, result7 = pcall(f11)

	t.HeartbeatMs = if ok7 and type(result7) == "number" then result7 else 0

	local function f13() --[[ Line: 62 | Upvalues: Stats (ref) ]]
		return Stats.RenderCPUFrameTime
	end

	local ok8, result8 = pcall(f13)

	t.RenderCpuMs = if ok8 and type(result8) == "number" then result8 else 0

	local function f15() --[[ Line: 63 | Upvalues: Stats (ref) ]]
		return Stats.RenderGPUFrameTime
	end

	local ok9, result9 = pcall(f15)

	t.RenderGpuMs = if ok9 and type(result9) == "number" then result9 else 0

	return t
end

local function Percentile(p1, p2) --[[ Percentile | Line: 67 ]]
	local v1 = #p1

	if v1 == 0 then
		return 0
	end

	return p1[math.clamp(math.ceil(p2 * v1), 1, v1)]
end

local function Average(p1) --[[ Average | Line: 74 ]]
	local v1 = #p1

	if v1 == 0 then
		return 0
	end

	local sum = 0

	for v2, v3 in p1 do
		sum = sum + v3
	end

	return sum / v1
end

local function OnePercentLowFps(p1) --[[ OnePercentLowFps | Line: 85 ]]
	local v1 = #p1

	if v1 == 0 then
		return 0
	end

	local v3 = math.max(1, (math.floor(v1 * 0.01)))
	local sum = 0

	for i = v1 - v3 + 1, v1 do
		sum = sum + p1[i]
	end

	local v4 = sum / v3

	if v4 <= 0 then
		return 0
	end

	return 1 / v4
end

local function BuildReport(p1, p2, p3, p4, p5, p6) --[[ BuildReport | Line: 98 ]]
	table.sort(p3)

	local v1 = #p3
	local v2

	if v1 == 0 then
		v2 = 0
	else
		local sum = 0

		for v3, v4 in p3 do
			sum = sum + v4
		end

		v2 = sum / v1
	end

	local v5 = if v2 > 0 then 1 / v2 else 0
	local v6 = if #p3 > 0 then p3[#p3] else 0
	local v8 = #p3
	local v11 = (if v8 == 0 then 0 else p3[math.clamp(math.ceil(v8 * 0.5), 1, v8)]) * 1000
	local v12 = #p3
	local v15 = (if v12 == 0 then 0 else p3[math.clamp(math.ceil(v12 * 0.99), 1, v12)]) * 1000
	local v16 = #p3
	local v17

	if v16 == 0 then
		v17 = 0
	else
		local v19 = math.max(1, (math.floor(v16 * 0.01)))
		local sum = 0

		for i = v16 - v19 + 1, v16 do
			sum = sum + p3[i]
		end

		local v20 = sum / v19

		v17 = if v20 <= 0 then 0 else 1 / v20
	end

	local t = {}
	local t2 = {}
	local t3 = {}
	local t4 = {}
	local t5 = {}
	local t6 = {}
	local t7 = {}
	local t8 = {}
	local t9 = {}

	for v21, v22 in p4 do
		table.insert(t7, v22.Drawcalls)
		table.insert(t8, v22.Triangles)
		table.insert(t9, v22.InstanceCount)
		table.insert(t, v22.MemoryMb)
		table.insert(t2, v22.PhysicsFps)
		table.insert(t3, v22.AwakeParts)
		table.insert(t4, v22.HeartbeatMs)
		table.insert(t5, v22.RenderCpuMs)
		table.insert(t6, v22.RenderGpuMs)
	end

	local v23 = if #t9 > 0 then t9[#t9] else p5
	local v24 = if #t > 0 then t[#t] else p6
	local v25 = math.max(50, 1000 / p2 * 1.5)
	local t10 = {
		Scenario = p1,
		TargetFps = p2,
		Verdict = if (if p2 <= v5 then true else false) and (if v15 <= v25 then true else false) then "PASS" else "FAIL",
		Frames = #p3,
		AvgFps = v5,
		MinFps = if v6 > 0 then 1 / v6 else 0,
		OnePercentLowFps = v17,
		P50FrameMs = v11,
		P99FrameMs = v15,
		P99BudgetMs = v25
	}
	local v29 = #t7
	local v30

	if v29 == 0 then
		v30 = 0
	else
		local sum = 0

		for v31, v32 in t7 do
			sum = sum + v32
		end

		v30 = sum / v29
	end

	t10.AvgDrawcalls = v30

	local v33 = #t8
	local v34

	if v33 == 0 then
		v34 = 0
	else
		local sum = 0

		for v35, v36 in t8 do
			sum = sum + v36
		end

		v34 = sum / v33
	end

	t10.AvgTriangles = v34

	local v37 = #t9
	local v38

	if v37 == 0 then
		v38 = 0
	else
		local sum = 0

		for v39, v40 in t9 do
			sum = sum + v40
		end

		v38 = sum / v37
	end

	t10.AvgInstanceCount = v38
	t10.InstanceDelta = v23 - p5

	local v41 = #t
	local v42

	if v41 == 0 then
		v42 = 0
	else
		local sum = 0

		for v43, v44 in t do
			sum = sum + v44
		end

		v42 = sum / v41
	end

	t10.AvgMemoryMb = v42
	t10.MemoryDeltaMb = v24 - p6

	local v45 = #t2
	local v46

	if v45 == 0 then
		v46 = 0
	else
		local sum = 0

		for v47, v48 in t2 do
			sum = sum + v48
		end

		v46 = sum / v45
	end

	t10.AvgPhysicsFps = v46

	local v49 = #t3
	local v50

	if v49 == 0 then
		v50 = 0
	else
		local sum = 0

		for v51, v52 in t3 do
			sum = sum + v52
		end

		v50 = sum / v49
	end

	t10.AvgAwakeParts = v50

	local v53 = #t4
	local v54

	if v53 == 0 then
		v54 = 0
	else
		local sum = 0

		for v55, v56 in t4 do
			sum = sum + v56
		end

		v54 = sum / v53
	end

	t10.AvgHeartbeatMs = v54

	local v57 = #t5
	local v58

	if v57 == 0 then
		v58 = 0
	else
		local sum = 0

		for v59, v60 in t5 do
			sum = sum + v60
		end

		v58 = sum / v57
	end

	t10.AvgRenderCpuMs = v58

	local v61 = #t6
	local v62

	if v61 == 0 then
		v62 = 0
	else
		local sum = 0

		for v63, v64 in t6 do
			sum = sum + v64
		end

		v62 = sum / v61
	end

	t10.AvgRenderGpuMs = v62

	return t10
end

local function PrintReport(p1) --[[ PrintReport | Line: 165 ]]
	local v1 = "?"

	pcall(function() --[[ Line: 167 | Upvalues: v1 (ref) ]]
		local SavedQualityLevel = UserSettings().GameSettings.SavedQualityLevel

		v1 = tostring(SavedQualityLevel)
	end)

	local v2 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.zero
	local t = {}
	local v3 = string.format("  BENCHMARK [%s]  %s", p1.Scenario, p1.Verdict)
	local v4 = string.format("  Quality:%s  Viewport:%dx%d  Frames:%d", v1, v2.X, v2.Y, p1.Frames)
	local v5 = string.format("  Avg FPS:        %.1f  (target %d)", p1.AvgFps, p1.TargetFps)
	local v6 = string.format("  1%% low FPS:     %.1f", p1.OnePercentLowFps)
	local v7 = string.format("  Min FPS:        %.1f", p1.MinFps)
	local v8 = string.format("  Frame p50:      %.1f ms", p1.P50FrameMs)
	local v9 = string.format("  Frame p99:      %.1f ms  (budget %.0f)", p1.P99FrameMs, p1.P99BudgetMs)
	local v10 = string.format("  Heartbeat:      %.2f ms", p1.AvgHeartbeatMs)
	local v11 = string.format("  Render CPU/GPU: %.1f / %.1f ms", p1.AvgRenderCpuMs, p1.AvgRenderGpuMs)
	local v12 = string.format("  Draw calls:     %d", (math.floor(p1.AvgDrawcalls)))
	local v13 = string.format("  Triangles:      %d", (math.floor(p1.AvgTriangles)))
	local v15 = string.format("  Instances:      %d  (%+d)", math.floor(p1.AvgInstanceCount), (math.floor(p1.InstanceDelta)))
	local v16 = string.format("  Memory:         %.0f MB  (%+.0f)", p1.AvgMemoryMb, p1.MemoryDeltaMb)
	local format4 = string.format

	t[1] = "========================================"
	t[2] = v3
	t[3] = "----------------------------------------"
	t[4] = v4
	t[5] = v5
	t[6] = v6
	t[7] = v7
	t[8] = v8
	t[9] = v9
	t[10] = v10
	t[11] = v11
	t[12] = v12
	t[13] = v13
	t[14] = v15
	t[15] = v16
	t[16] = format4("  Physics FPS:    %.0f  Awake parts: %d", p1.AvgPhysicsFps, (math.floor(p1.AvgAwakeParts)))
	t[17] = "========================================"

	local v17 = table.concat(t, "\n")

	if p1.Verdict == "FAIL" then
		warn(v17)
	else
		print(v17)
	end
end

local function RunSampling(p1, p2, p3) --[[ RunSampling | Line: 200 | Upvalues: v1 (ref), Stats (copy), TakeStatSample (copy), RunService (copy), BuildReport (copy), PrintReport (copy), BenchmarkPackets (copy) ]]
	if v1 then
		warn("[BenchmarkController] a benchmark is already running; ignoring new request")

		return
	end

	v1 = true

	local function f1() --[[ Line: 207 | Upvalues: Stats (ref) ]]
		return Stats.InstanceCount
	end

	local ok, result = pcall(f1)
	local v2 = if ok and type(result) == "number" then result else 0

	local function f3() --[[ Line: 208 | Upvalues: Stats (ref) ]]
		return Stats:GetTotalMemoryUsageMb()
	end

	local ok2, result2 = pcall(f3)
	local v4 = if ok2 and type(result2) == "number" then result2 else 0
	local t = {}
	local t2 = { (TakeStatSample()) }
	local v5 = 0

	print(string.format("[BenchmarkController] sampling %q for %ds (target %d FPS)...", p1, p2, p3))

	local v6 = os.clock() + p2
	local v7 = nil

	v7 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 218 | Upvalues: t (copy), v5 (ref), t2 (copy), TakeStatSample (ref), v6 (copy), v7 (ref), BuildReport (ref), p1 (copy), p3 (copy), v2 (copy), v4 (copy), PrintReport (ref), BenchmarkPackets (ref), v1 (ref) ]]
		table.insert(t, p12)
		v5 = v5 + p12

		if v5 >= 0.5 then
			v5 = 0
			table.insert(t2, (TakeStatSample()))
		end

		if not (v6 <= os.clock()) then
			return
		end

		v7:Disconnect()
		table.insert(t2, (TakeStatSample()))

		local v62 = BuildReport(p1, p3, t, t2, v2, v4)

		PrintReport(v62)
		pcall(function() --[[ Line: 230 | Upvalues: BenchmarkPackets (ref), p1 (ref), v62 (copy) ]]
			BenchmarkPackets.Result:Fire(p1, v62)
		end)
		v1 = false
	end)
end

return {
	Init = function(p1) --[[ Init | Line: 241 | Upvalues: RunService (copy), Players (copy), BenchmarkPackets (copy), RunSampling (copy) ]]
		if RunService:IsServer() then
			return
		end

		if Players.LocalPlayer then
			BenchmarkPackets.Start.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 245 | Upvalues: RunSampling (ref) ]]
				RunSampling(p1, p2, p3)
			end)
		end
	end
}