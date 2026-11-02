-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LogService = game:GetService("LogService")
local Stats = game:GetService("Stats")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")
local DeviceForm = require(ReplicatedStorage.UserGenerated.Roblox.DeviceForm)
local MicroProfilerConfig = require(ReplicatedStorage.UserGenerated.Analytics.MicroProfilerConfig)
local DataModel = require(ReplicatedStorage.UserGenerated.DataModel)
local LocalPlayer = Players.LocalPlayer

local function diag(...) -- line 18
end

local function diagWarn(...) -- line 19
end

diag("script running; userId =", LocalPlayer.UserId)

local function WaitRemote(v1) -- line 21 | captures: diag, diagWarn
    local v2 = script.Parent:WaitForChild(v1, 10)
    if v2 then
        diag("resolved remote:", v1, (("(%*)"):format(v2.ClassName)))
    else
        diagWarn("MISSING remote (WaitForChild timed out after 10s):", v1)
    end
    return v2
end

local v3 = script.Parent:WaitForChild("Fps", 10)

if v3 then
    diag("resolved remote:", "Fps", (("(%*)"):format(v3.ClassName)))
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "Fps")
end
local v4 = script.Parent:WaitForChild("LibMPDevice", 10)

if v4 then
    diag("resolved remote:", "LibMPDevice", (("(%*)"):format(v4.ClassName)))
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPDevice")
end
local v5 = script.Parent:WaitForChild("LibMPRequiring", 10)

if v5 then
    diag("resolved remote:", "LibMPRequiring", (("(%*)"):format(v5.ClassName)))
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPRequiring")
end
local v6 = script.Parent:WaitForChild("LibMPRequired", 10)

if v6 then
    diag("resolved remote:", "LibMPRequired", (("(%*)"):format(v6.ClassName)))
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPRequired")
end
local v7 = script.Parent:WaitForChild("LibMPFrame", 10)

if v7 then
    diag("resolved remote:", "LibMPFrame", (("(%*)"):format(v7.ClassName)))
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPFrame")
end
local v8 = script.Parent:WaitForChild("LiveRequest", 10)

if v8 then
    diag("resolved remote:", "LiveRequest", (("(%*)"):format(v8.ClassName)))
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LiveRequest")
end
local v9 = script.Parent:WaitForChild("LiveResponse", 10)

if v9 then
    diag("resolved remote:", "LiveResponse", (("(%*)"):format(v9.ClassName)))
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LiveResponse")
end
local Control
local v10 = table.create(60, 0)
local v11 = table.create(60, 0)
local v12 = -1
RunService.RenderStepped:Connect(function(v13) -- line 88 | captures: v12, v10, v11
    local v14 = os.clock()
    local v15 = math.floor(v14) % 60 + 1
    if v15 ~= v12 then
        v10[v15] = 0
        v11[v15] = 0
        v12 = v15
    end
    v10[v15] += 1
    v11[v15] += v13
end)

local function getRecentAvgFps() -- line 100 | captures: v10, v11
    local v16 = 0
    local v17 = 0
    for v18 = 1, 60 do
        v16, v17 = v16 + v10[v18], v17 + v11[v18]
    end
    if v17 <= 0 then
        return 0
    end
    return v16 / v17
end

local v19 = {}

local function GetBucket(v20) -- line 115 | captures: v19
    local v21 = v19[v20]
    if not v21 then
        v19[v20] = {
            Frames = 0,
            Time = 0,
            Spikes = 0
        }
    end
    return v21
end

table.create(60, 0)
table.create(60, 0)

local function GetMedian() -- line 130
    return 0
end

local function ReportBucket(v22) -- line 142 | captures: diag, v3, v19
    local v23 = v19[v22]
    if not v23 or v23.Time <= 0 then
        return
    end
    local v24 = v23.Frames / v23.Time
    v3:FireServer(v22, v24, v23.Spikes)
    local v25 = math.round(v24)
    diag("fired Fps: minute", v22, "avgFps", v25, "spikes", v23.Spikes)
end

task.spawn(function() -- line 153 | captures: DeviceForm, diag, diagWarn, v4
    for v26 = 1, 5 do
        local v27 = DeviceForm.Get()
        local v28 = if v27 then v27.Name else "nil"
        diag("device report attempt", v26, "->", v28)
        if v27 then
            v4:FireServer(v27)
            diag("fired LibMPDevice:", v27.Name)
            return
        end
        task.wait(1)
    end
    diagWarn("device never resolved after 5 attempts; LibMPDevice was NOT fired")
end)
local v29 = false

local function StartCapture(v30) -- line 175 | captures: Control, v29, RunService, MicroProfilerConfig, diag, diagWarn, v5, v6, v7
    if v29 then
        return
    end
    v29 = true
    diag("StartCapture: module delivered ->", v30:GetFullName())
    v5:FireServer()
    diag("fired LibMPRequiring")
    local v31, v32 = pcall(require, v30)
    if not (v31 and type(v32) == "table") then
        diagWarn("require(LibMP) failed:", v32)
    else
        diag("require(LibMP) ok")
        v6:FireServer()
        diag("fired LibMPRequired")
        local v33 = MicroProfilerConfig.FramesBefore:Get()
        local v34 = MicroProfilerConfig.FramesAfter:Get()
        local Control_2 = v32.Control
        local v35 = os.clock()
        while not Control_2:IsBackendReady() do
            if os.clock() - v35 > 30 then
                diagWarn("LibMP backend not ready after 30s; capture disabled")
                return
            end
            task.wait()
        end
        local v36, v37 = pcall(function() -- line 204 | captures: v33, v34, Control_2
            Control_2:SetFrameLimit(v33 + v34 + 1)
            Control_2:EnableProfiler(true)
            Control_2:EnableCapture(true)
        end)
        if v36 then
            Control = Control_2
            diag("LibMP capture armed; window =", v33, "+1+", v34)
            local v38 = 0
            local v39 = (-1/0)
            local v40 = 0
            local TickStartCpu, FrameAbsoluteId
            task.spawn(function() -- line 220 | captures: v38, v39, v40, TickStartCpu, FrameAbsoluteId, v32, v34, Control_2, RunService, MicroProfilerConfig, diag, diagWarn, v7
                task.wait(2)
                local v41 = v32.Session.OpenFromLiveData()
                if v41 and v41:IsValid() then
                    while v38 < MicroProfilerConfig.MaxFramesPerSession:Get() do
                        task.wait(0.03)
                        pcall(function() -- line 232 | captures: v41, v38, v39, v40, TickStartCpu, FrameAbsoluteId, v34, Control_2, RunService, MicroProfilerConfig, diag, diagWarn, v7
                            v41:SetSyncRequired()
                            local v42 = v41:FetchGlobalDesc()
                            local TickToMsCpu = v42.TickToMsCpu
                            local TickToMsGpu = v42.TickToMsGpu
                            local v43 = v41:GetFrameIdMin()
                            local v44 = v41:GetFrameIdMax()
                            if not (v44 ~= 0) or not (type(TickToMsCpu) == "number") or TickToMsCpu <= 0 then
                                return
                            end
                            local v45 = v40 + 1
                            local v46 = math.max(v43, v45)
                            local v47 = 0
                            local v48 = 0
                            local v49 = 0
                            local v50 = 0
                            local v51 = 0
                            local v52 = 0
                            for v53 = v46, v44 do
                                local v54 = v41:FetchFrameDesc(v53)
                                local FrameAbsoluteId_2, v55, v56, v57, v58, v59, v60, v61, v62, v63
                                if v54 then
                                    FrameAbsoluteId_2 = v54.FrameAbsoluteId
                                    if v54.IsPaused then
                                        v57 = v47
                                        v58 = v48
                                        v59 = v49
                                        v60 = v50
                                        v56 = v51
                                        v61 = v52
                                        v63 = true
                                    else
                                        v55 = (v54.TickEndCpu - v54.TickStartCpu) * TickToMsCpu
                                        if type(TickToMsGpu) == "number" and TickToMsGpu > 0 then
                                            local v64 = (v54.TickEndGpu - v54.TickStartGpu) * TickToMsGpu
                                            v62 = math.max(v64, 0)
                                        else
                                            v62 = 0
                                        end
                                        v63 = false
                                    end
                                else
                                    v57 = v47
                                    v58 = v48
                                    v59 = v49
                                    v60 = v50
                                    v56 = v51
                                    v61 = v52
                                    v63 = true
                                end
                                if not v63 then
                                    local v65 = if TickStartCpu == nil or FrameAbsoluteId == nil then false else FrameAbsoluteId_2 == FrameAbsoluteId + 1
                                    if not (v65 and TickStartCpu) then
                                        v56 = 0
                                    else
                                        v56 = (v54.TickStartCpu - TickStartCpu) * TickToMsCpu
                                    end
                                    TickStartCpu = v54.TickStartCpu
                                    FrameAbsoluteId = FrameAbsoluteId_2
                                    v57 = math.max(v55, v56)
                                    if v47 < v57 then
                                        v58 = v53
                                        v59 = v55
                                        v60 = v62
                                        v61 = FrameAbsoluteId_2
                                    else
                                        v57 = v47
                                        v58 = v48
                                        v59 = v49
                                        v60 = v50
                                        v56 = v51
                                        v61 = v52
                                    end
                                end
                                v47 = v57
                                v48 = v58
                                v49 = v59
                                v50 = v60
                                v51 = v56
                                v52 = v61
                            end
                            if v46 <= v44 then
                                v40 = v44
                            end
                            if v47 < MicroProfilerConfig.LaggyFrameMs:Get() then
                                return
                            end
                            local v66 = string.format("%.2f", v47)
                            local v67 = string.format("%.2f", v49)
                            local v68 = string.format("%.2f", v50)
                            local v69 = string.format("%.2f", v51)
                            diag("laggy frame", v48, "abs", v52, "peakMs", v66, "[ cpu", v67, "gpu", v68, "interval", v69, "]")
                            if not (os.clock() - v39 < MicroProfilerConfig.MinFrameInterval:Get()) then
                                for v70 = 1, v34 do
                                    RunService.RenderStepped:Wait()
                                end
                                local v71 = Control_2:CaptureToBufferSync()
                                if typeof(v71) == "buffer" then
                                    local v72 = buffer.len(v71)
                                    if MicroProfilerConfig.MaxDumpBytes:Get() < v72 then
                                        diagWarn("dump over MaxDumpBytes; size =", buffer.len(v71))
                                    else
                                        v38 += 1
                                        v39 = os.clock()
                                        v7:FireServer(v71, v47)
                                        local v73 = buffer.len(v71)
                                        local v74 = string.format("%.2f", v47)
                                        diag("fired LibMPFrame; size =", v73, "peakMs =", v74, "windowsSent =", v38)
                                    end
                                else
                                    diagWarn("CaptureToBufferSync produced no buffer; got", (typeof(v71)))
                                end
                            end
                        end)
                    end
                    v41:Dispose()
                else
                    diagWarn("OpenFromLiveData failed; client laggy-frame capture disabled")
                    if v41 then
                        v41:Dispose()
                    end
                end
            end)
        else
            diagWarn("LibMP setup failed:", v37)
        end
    end
end

task.spawn(function() -- line 317 | captures: MicroProfilerConfig, LocalPlayer, diag, StartCapture
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    diag("waiting for LibMP module:", MicroProfilerConfig.ModuleName)
    task.spawn(function(v75) -- line 320 | captures: PlayerGui, MicroProfilerConfig, diag, StartCapture
        local v76 = PlayerGui:WaitForChild(v75, (1/0)):WaitForChild(MicroProfilerConfig.ModuleName, (1/0))
        if v76:IsA("ModuleScript") then
            diag("found LibMP module via", v75)
            StartCapture(v76)
        end
    end, MicroProfilerConfig.ContainerName)
    local v77 = PlayerGui:WaitForChild("__UG_LiveLibMPGui", (1/0)):WaitForChild(MicroProfilerConfig.ModuleName, (1/0))
    if v77:IsA("ModuleScript") then
        diag("found LibMP module via", "__UG_LiveLibMPGui")
        StartCapture(v77)
    end
end)

local function ensureArmed(v78) -- line 335 | captures: Control
    if not Control then
        local v79 = os.clock()
        while not Control do
            if v78 <= os.clock() - v79 then
                break
            end
            task.wait(0.1)
        end
    end
    return Control
end

local function collectClientLogs() -- line 348 | captures: LogService
    local v80 = LogService:GetLogHistory()
    local v81 = {}
    local v82 = #v80
    local v83 = #v80 - 400 + 1
    local v84 = math.max(1, v83)
    for v85 = v84, v82 do
        local v86 = v80[v85]
        local message = v86.message
        local v87 = tostring(message)
        if #v87 > 1000 then
            v87 = string.sub(v87, 1, 1000) .. "\226\128\166"
        end
        local v88 = { message = v87 }
        local messageType = v86.messageType
        if typeof(messageType) == "EnumItem" then
            v88.messageType = v86.messageType.Name
        else
            local messageType = v86.messageType
            v88.messageType = tostring(messageType)
        end
        v88.timestamp = v86.timestamp
        table.insert(v81, v88)
    end
    return v81
end

local function captureClientMicroprofiler(v89) -- line 373 | captures: RunService, MicroProfilerConfig, diag, diagWarn, ensureArmed
    local v90 = ensureArmed(8)
    if v90 then
        diag("captureClientMicroprofiler: armed; capturing", v89, "frames")
        local v91 = MicroProfilerConfig.FramesBefore:Get() + MicroProfilerConfig.FramesAfter:Get() + 1
        local v92, v93 = pcall(function() -- line 383 | captures: v89, v90
            v90:SetFrameLimit(v89)
            v90:EnableProfiler(true)
            v90:EnableCapture(true)
        end)
        if v92 then
            local v94 = v89 + 12
            for v95 = 1, v94 do
                RunService.RenderStepped:Wait()
            end
            local v96 = v90:CaptureToBufferSync()
            pcall(function() -- line 398 | captures: v90, v91
                v90:SetFrameLimit(v91)
            end)
            if typeof(v96) == "buffer" then
                diag("captureClientMicroprofiler: dump buffer size =", buffer.len(v96))
                return v96
            end
            diagWarn("captureClientMicroprofiler: CaptureToBufferSync gave", (typeof(v96)))
        else
            diagWarn("captureClientMicroprofiler: enable/setFrameLimit failed:", v93)
        end
    else
        diagWarn("captureClientMicroprofiler: ensureArmed(8) returned nil (LibMP not armed)")
    end
    return nil
end

local Name

local function getDeviceName() -- line 409 | captures: Name, DeviceForm
    if not Name then
        local v97 = DeviceForm.Get()
        if v97 then
            Name = v97.Name
        end
    end
    return Name
end

local function getClientMemoryMb() -- line 419 | captures: Stats
    local v98, v99 = pcall(function() -- line 421 | captures: Stats
        return Stats:GetTotalMemoryUsageMb()
    end)
    if v98 and type(v99) == "number" then
        return v99
    end
    return nil
end

local function getClientMeta() -- line 432 | captures: Name, GuiService, Workspace, DeviceForm, getRecentAvgFps
    local v100 = { avgFps = getRecentAvgFps() }
    if not Name then
        local v101 = DeviceForm.Get()
        if v101 then
            Name = v101.Name
        end
    end
    v100.device = Name
    v100.engineVersion = version()
    pcall(function() -- line 446 | captures: v100, Workspace
        local CurrentCamera = Workspace.CurrentCamera
        if not CurrentCamera then
            return
        end
        local ViewportSize = CurrentCamera.ViewportSize
        local v102 = {}
        local X = ViewportSize.X
        v102.x = math.round(X)
        local Y = ViewportSize.Y
        v102.y = math.round(Y)
        v100.renderResolution = v102
    end)
    pcall(function() -- line 453 | captures: v100, GuiService
        local ViewportDisplaySize = GuiService.ViewportDisplaySize
        local v103 = {}
        local X = ViewportDisplaySize.X
        v103.x = math.round(X)
        local Y = ViewportDisplaySize.Y
        v103.y = math.round(Y)
        v100.displaySize = v103
    end)
    pcall(function() -- line 457 | captures: v100
        v100.savedQualityLevel = UserSettings().GameSettings.SavedQualityLevel.Value
    end)
    return v100
end

local v104 = false

local function captureDataModelSnapshot(v105) -- line 463 | captures: DataModel, getRecentAvgFps
    if type(v105) == "table" then
        local v106 = getRecentAvgFps()
        local v107
        if v106 <= 0 then
        else
            v107 = 1 / v106
        end
        local v108, v109 = pcall(DataModel.capture, v105, v107)
        if not (v108 and type(v109) == "table") then
            return nil, nil
        end
        if v109.TimedOut then
            return { TimedOut = true }, nil
        end
        local Buffer = v109.Buffer
        if typeof(Buffer) == "buffer" then
            if buffer.len(v109.Buffer) > 67108864 then
                return { Truncated = true }, nil
            end
            return {
                    Classes = v109.Classes,
                    Props = v109.Props,
                    Truncated = v109.Truncated
                },
                v109.Buffer
        end
        return { Truncated = true }, nil
    end
    return nil, nil
end

v8.OnClientEvent:Connect(function(v110, v111, v112) -- line 490 | captures: Name, v104, Stats, DeviceForm, v9, getRecentAvgFps, collectClientLogs, captureClientMicroprofiler, getClientMeta, captureDataModelSnapshot
    if type(v110) == "string" and type(v111) == "string" then
        task.spawn(function() -- line 494 | captures: v110, v111, v112, Name, v104, Stats, DeviceForm, v9, getRecentAvgFps, collectClientLogs, captureClientMicroprofiler, getClientMeta, captureDataModelSnapshot
            if v111 == "fps" then
                local v113 = { fps = getRecentAvgFps() }
                if not Name then
                    local v114 = DeviceForm.Get()
                    if v114 then
                        Name = v114.Name
                    end
                end
                v113.device = Name
                local v115, v116 = pcall(function() -- line 508 | captures: Stats
                    return Stats:GetTotalMemoryUsageMb()
                end)
                if not (v115 and type(v116) == "number") then
                    v116 = nil
                end
                v113.memory = v116
                v9:FireServer(v110, v113)
            elseif v111 == "output" then
                v9:FireServer(v110, { logs = collectClientLogs() })
            elseif v111 == "microprofiler" then
                if v104 then
                    v9:FireServer(v110, { error = "busy" })
                else
                    v104 = true
                    local v117
                    if type(v112) == "table" then
                        local frames = v112.frames
                        if type(frames) == "number" then
                            v117 = v112.frames
                        end
                    else
                        v117 = 128
                    end
                    local v118 = math.floor(v117)
                    local v119 = if type(v112) == "table" then v112.dataModel else nil
                    local v120 = captureClientMicroprofiler((math.clamp(v118, 8, 256)))
                    local v121, v122
                    if v120 then
                        if buffer.len(v120) <= 67108864 then
                            v121 = {
                                ok = true,
                                meta = getClientMeta()
                            }
                            if v119 then
                                local v123
                                v123, v122 = captureDataModelSnapshot(v119)
                                if v123 then
                                    v121.snapshot = v123
                                else
                                    v122 = nil
                                end
                            end
                        else
                            v121 = { error = "Dump size over 64mb. Cannot be retrieved." }
                            v120 = nil
                        end
                    else
                        v121 = { error = "libmp_unavailable" }
                        v120 = nil
                    end
                    v104 = false
                    v9:FireServer(v110, v121, v120, v122)
                end
            end
        end)
    end
end)
