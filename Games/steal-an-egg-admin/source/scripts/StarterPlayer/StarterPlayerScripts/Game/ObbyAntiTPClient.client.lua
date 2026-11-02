-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local LocalPlayer = Players.LocalPlayer
local v1
local v2 = {}
local Position, v3, v4, v5
local v6 = false
local v7
local v8 = 0
local v9 = 16
local v10 = 0
local v11 = 0
local v12 = 0
local v13 = 0
local v14
local v15 = false

local function debugEnabled() -- line 29 | captures: Workspace
    return Workspace:GetAttribute("ClientObbyAntiTpDebug") == true
end

local function dprint(v16) -- line 33 | captures: Workspace
    if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
        print("[ObbyAntiTP] " .. v16)
    end
end

local function nowClock() -- line 39
    return os.clock()
end

local function parseRegionAttribute() -- line 42 | captures: Workspace
    local AnticheatSuspendedRegion = Workspace:GetAttribute("AnticheatSuspendedRegion")
    if typeof(AnticheatSuspendedRegion) == "string" then
        local v17 = {}
        for v18 in string.gmatch(AnticheatSuspendedRegion, "[^,]+") do
            local v19 = tonumber(v18)
            if v19 == nil then
                return nil
            end
            table.insert(v17, v19)
        end
        if #v17 == 6 then
            local v20 = {}
            local v21 = v17[1]
            local v22 = v17[2]
            local v23 = v17[3]
            v20.Min = Vector3.new(v21, v22, v23)
            local v24 = v17[4]
            local v25 = v17[5]
            local v26 = v17[6]
            v20.Max = Vector3.new(v24, v25, v26)
            return v20
        end
    end
    return nil
end

local function regionFromMap(v27) -- line 61
    local v28, v29
    for v30, v31 in v27:GetDescendants() do
        if v31:IsA("BasePart") then
            local Position = v31.Position
            local v32 = v31.Size * 0.5
            local v33 = Position - v32
            local v34 = Position + v32
            if v28 then
                local X = v28.X
                local X_2 = v33.X
                local v35 = math.min(X, X_2)
                local Y = v28.Y
                local Y_2 = v33.Y
                local v36 = math.min(Y, Y_2)
                local Z = v28.Z
                local Z_2 = v33.Z
                local v37 = math.min(Z, Z_2)
                v28 = Vector3.new(v35, v36, v37)
            else
                v28 = v33
            end
            if v29 then
                local X = v29.X
                local X_2 = v34.X
                local v38 = math.max(X, X_2)
                local Y = v29.Y
                local Y_2 = v34.Y
                local v39 = math.max(Y, Y_2)
                local Z = v29.Z
                local Z_2 = v34.Z
                local v40 = math.max(Z, Z_2)
                v29 = Vector3.new(v38, v39, v40)
            else
                v29 = v34
            end
        end
    end
    if v28 == nil or v29 == nil then
        return nil
    end
    return {
        Min = v28 - Vector3.new(25, 25, 25),
        Max = v29 + Vector3.new(25, 25, 25)
    }
end

local function collectMapLandmarks(v41) -- line 92 | captures: Position, v2
    table.clear(v2)
    Position = nil
    if v41 == nil then
        return
    end
    local WinParts = v41:FindFirstChild("WinParts")
    if WinParts ~= nil then
        for v42, v43 in WinParts:GetChildren() do
            if v43:IsA("BasePart") then
                local Position = v43.Position
                table.insert(v2, Position)
            end
        end
    end
    local ObbyRespawn = v41:FindFirstChild("ObbyRespawn")
    if ObbyRespawn ~= nil and ObbyRespawn:IsA("BasePart") then
        Position = ObbyRespawn.Position
    end
end

local function refreshRegion() -- line 111 | captures: v1, Workspace, v2, parseRegionAttribute, regionFromMap, collectMapLandmarks
    local MonsterEventMap = Workspace:FindFirstChild("MonsterEventMap")
    local v44 = parseRegionAttribute()
    if v44 == nil and MonsterEventMap ~= nil then
        v44 = regionFromMap(MonsterEventMap)
    end
    v1 = v44
    collectMapLandmarks(MonsterEventMap)
    if v1 == nil then
        if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
            print("[ObbyAntiTP] disarmed: no event region")
        end
    else
        local Min = v1.Min
        local v45 = tostring(Min)
        local Max = v1.Max
        local v46 = ("armed: region %s -> %s, %d win gates"):format(v45, tostring(Max), #v2)
        if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
            print("[ObbyAntiTP] " .. v46)
        end
    end
end

local function inRegion(v47) -- line 136 | captures: v1
    local v48 = v1
    if v48 ~= nil and v48.Min.X <= v47.X and v47.X <= v48.Max.X and v48.Min.Y <= v47.Y and v47.Y <= v48.Max.Y and v48.Min.Z <= v47.Z then
        return v47.Z <= v48.Max.Z
    end
    return false
end

local function isEnabled() -- line 144 | captures: v1, Workspace
    if Workspace:GetAttribute("ClientObbyAntiTp") == false then
        return false
    end
    return v1 ~= nil
end

local function horizontal(v49, v50) -- line 148
    return ((v49 - v50) * Vector3.new(1, 0, 1)).Magnitude
end

local function grace(v51) -- line 151 | captures: v11
    local v52 = v11
    local v53 = os.clock() + v51
    v11 = math.max(v52, v53)
end

local function rebaseline(v54) -- line 154 | captures: v5, v7, v8
    local v55 = v5
    if v54 == nil then
        if v55 == nil then
            v7 = v54
        else
            v7 = v55.Position
        end
    else
        v7 = v54
    end
    v8 = os.clock()
end

local function jumpVelocity(v56) -- line 167 | captures: Workspace
    if v56.UseJumpPower then
        local JumpPower = v56.JumpPower
        return (math.max(JumpPower, 0))
    end
    local Gravity = Workspace.Gravity
    local v57 = math.max(Gravity, 0) * 2
    local JumpHeight = v56.JumpHeight
    local v58 = v57 * math.max(JumpHeight, 0)
    return (math.sqrt(v58))
end

local function nearWinPart(v59) -- line 174 | captures: v2
    for v60, v61 in v2 do
        if (v59 - v61).Magnitude <= 30 then
            return true
        end
    end
    return false
end

local function nearObbyRespawn(v62) -- line 185 | captures: Position
    local Position_2 = Position
    if Position_2 == nil then
        return false
    end
    return (v62 - Position_2).Magnitude <= 25
end

local function lagback(v63) -- line 190 | captures: v3, v4, v5, v7, v8, v11
    local v64 = v3
    local v65 = v5
    local v66 = v4
    if v64 == nil or v65 == nil or v66 == nil then
        return
    end
    v66.Sit = false
    v65.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    v65.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    v64:PivotTo(CFrame.new(v63) * v65.CFrame.Rotation)
    local v67 = v5
    if v63 == nil then
        if v67 == nil then
            v7 = v63
        else
            v7 = v67.Position
        end
    else
        v7 = v63
    end
    v8 = os.clock()
    local v68 = v11
    local v69 = os.clock() + 0.3
    v11 = math.max(v68, v69)
end

local function kill(v70) -- line 211 | captures: v4, v5, v6, Workspace
    local v71 = v5
    local v72 = v4
    v6 = true
    if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
        print("[ObbyAntiTP] " .. "KILL: " .. v70)
    end
    if v71 ~= nil then
        v71.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        v71.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end
    if v72 ~= nil then
        v72.Health = 0
        v72:ChangeState(Enum.HumanoidStateType.Dead)
    end
end

local function punish(v73, v74, v75, v76, v77) -- line 228 | captures: v4, v5, v6, v12, v13, Workspace, v2, lagback
    if v77 - v13 > 5 then
        v12 = 0
    end
    v12 += 1
    v13 = v77
    if v75 < 300 and v76 < 150 and v12 < 6 and v75 >= 100 then
        for v78, v79 in v2 do
            if (v73 - v79).Magnitude <= 30 then
                local v80 = " EXTREME"
                local v81 = ("flag #%d: moved %.0f (up %.0f)%s"):format(v12, v75, v76, v80)
                if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                    print("[ObbyAntiTP] " .. v81)
                end
                lagback(v74)
                v12 = 0
                local v82 = ("jump %.0f studs (up %.0f), flags %d"):format(v75, v76, v12)
                local v83 = v5
                local v84 = v4
                v6 = true
                if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                    print("[ObbyAntiTP] " .. "KILL: " .. v82)
                end
                if v83 ~= nil then
                    v83.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    v83.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
                if v84 ~= nil then
                    v84.Health = 0
                    v84:ChangeState(Enum.HumanoidStateType.Dead)
                end
                return
            end
        end
    end
end

Remotes.RigSync.Refresh.OnClientEvent:Connect(function(v85) -- line 289 | captures: v11, v14, HttpService, Workspace
    if typeof(v85) ~= "string" then
        return
    end
    local v86, v87 = pcall(function() -- line 294 | captures: v85, HttpService
        return HttpService:JSONDecode(v85)
    end)
    if not (v86 and typeof(v87) == "table") then
        return
    end
    local Action = v87.Action
    local Arguments = v87.Arguments
    if typeof(Arguments) ~= "table" then
        Arguments = {}
    end
    if Action == "Relocate" then
        local v88 = Arguments[1]
        local v89 = tonumber(v88)
        local v90 = Arguments[2]
        local v91 = tonumber(v90)
        local v92 = Arguments[3]
        local v93 = tonumber(v92)
        if v89 ~= nil and v91 ~= nil and v93 ~= nil then
            v14 = {
                Target = Vector3.new(v89, v91, v93),
                ExpiresAt = os.clock() + 8
            }
        end
        local v94 = v11
        local v95 = os.clock() + 1
        v11 = math.max(v94, v95)
        if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
            print("[ObbyAntiTP] grace: server relocation")
        end
    elseif Action == "BeginImpulse" then
        local v96 = v11
        local v97 = os.clock()
        local v98 = Arguments[1]
        local v99 = tonumber(v98) or 1
        local v100 = v97 + (math.clamp(v99, 1, 5) + 0.5)
        v11 = math.max(v96, v100)
        if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
            print("[ObbyAntiTP] " .. "grace: server " .. tostring(Action))
        end
    elseif Action ~= "BeginRagdoll" and Action == "EndRagdoll" then
        local v101 = v11
        local v102 = os.clock() + 1
        v11 = math.max(v101, v102)
    end
end)

local function onCharacter(v103) -- line 340 | captures: v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v14, v15, LocalPlayer
    v6 = false
    v12 = 0
    v14 = nil
    v15 = false
    v3 = v103
    v4 = nil
    v5 = nil
    v7 = nil
    local v104 = v103:WaitForChild("Humanoid", 10)
    local v105 = v103:WaitForChild("HumanoidRootPart", 10)
    local Position, v106
    if v104 == nil then
        v106 = true
    elseif v104:IsA("Humanoid") then
        if v105 == nil then
            v106 = true
        elseif v105:IsA("BasePart") and LocalPlayer.Character == v103 then
            v4 = v104
            v5 = v105
            local WalkSpeed = v104.WalkSpeed
            v9 = math.clamp(WalkSpeed, 2, 1000)
            v10 = 0
            local v107 = v11
            local v108 = os.clock() + 3
            v11 = math.max(v107, v108)
            Position = v105.Position
            local v109 = v5
            if Position == nil and v109 ~= nil then
                Position = v109.Position
            end
            v106 = false
        else
            v106 = true
        end
    else
        v106 = true
    end
    if v106 then
        return
    end
    v7 = Position
    v8 = os.clock()
    v104.Died:Connect(function() -- line 366 | captures: v6
        v6 = true
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacter)

if LocalPlayer.Character ~= nil then
    task.spawn(onCharacter, LocalPlayer.Character)
end
Workspace:GetAttributeChangedSignal("AnticheatSuspendedRegion"):Connect(refreshRegion)
Workspace.ChildAdded:Connect(function(v110) -- line 376 | captures: refreshRegion
    if v110.Name == "MonsterEventMap" then
        task.defer(refreshRegion)
    end
end)
Workspace.ChildRemoved:Connect(function(v111) -- line 381 | captures: refreshRegion
    if v111.Name == "MonsterEventMap" then
        task.defer(refreshRegion)
    end
end)
refreshRegion()
RunService.Heartbeat:Connect(function() -- line 387 | captures: v1, Position, v4, v5, v6, v7, v8, v9, v10, v11, v14, v15, Workspace, inRegion, punish
    local v112 = v5
    local v113 = v4
    if not (v112 ~= nil) or not (v113 ~= nil) or v6 or v113.Health <= 0 or not v112:IsDescendantOf(Workspace) then
        return
    end
    local v114 = os.clock()
    local v115 = v114 - v8
    if v115 < 0.1 then
        return
    end
    v8 = v114
    local Position_2 = v112.Position
    if Workspace:GetAttribute("ClientObbyAntiTp") ~= false and v1 ~= nil then
        local WalkSpeed = v113.WalkSpeed
        local v116 = math.clamp(WalkSpeed, 2, 1000)
        if v116 < v9 then
            v10 += math.min(v115, 0.4)
            if v10 >= 3 then
                v9 = v116
            end
        else
            v9 = v116
            v10 = 0
        end
        local v117 = inRegion(Position_2)
        if v117 and v15 then
            if v113.Sit then
                local v118 = v11
                local v119 = os.clock() + 1.5
                v11 = math.max(v118, v119)
                v7 = Position_2
            elseif v113.PlatformStand then
                local v120 = v11
                local v121 = os.clock() + 1.5
                v11 = math.max(v120, v121)
                v7 = Position_2
            else
                local v122 = v14
                local v123 = v122 == nil
                local v124, v125
                if v123 then
                    if v114 < v11 then
                        v7 = Position_2
                        return
                    end
                    if v115 > 1 then
                        v7 = Position_2
                        return
                    end
                    if v7 == nil then
                        v7 = Position_2
                        return
                    end
                    local v126 = math.min(v115, 0.4)
                    local v127 = v7
                    local AssemblyLinearVelocity = v112.AssemblyLinearVelocity
                    local Magnitude = (AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
                    local v128 = math.min(Magnitude, 400)
                    local Y = AssemblyLinearVelocity.Y
                    local v129 = math.clamp(Y, 0, 400)
                    local v130 = v9 * 1.7000000000000002 * v126 + 14
                    local Magnitude_2 = ((Position_2 - v127) * Vector3.new(1, 0, 1)).Magnitude
                    local v131
                    if v113.UseJumpPower then
                        local JumpPower = v113.JumpPower
                        v131 = math.max(JumpPower, 0)
                    else
                        local Gravity = Workspace.Gravity
                        local v132 = math.max(Gravity, 0) * 2
                        local JumpHeight = v113.JumpHeight
                        local v133 = v132 * math.max(JumpHeight, 0)
                        v131 = math.sqrt(v133)
                    end
                    local v134 = Position_2.Y - v127.Y
                    local v135 = v130 + v128 * v126 + 80 < Magnitude_2
                    v125 = math.max(v131, v129) * v126 + 14 + 60 < v134
                    if v135 then
                        local Position_3 = Position
                        if Position_3 ~= nil and (Position_2 - Position_3).Magnitude <= 25 then
                            v7 = Position_2
                        else
                            local v136 = math.max(v134, 0)
                            punish(Position_2, v127, Magnitude_2, v136, v114)
                        end
                        return
                    end
                else
                    if v122.ExpiresAt <= v114 then
                        v14 = nil
                        return
                    end
                    v124 = (Position_2 - v122.Target).Magnitude <= 15
                end
                if (not v123 or not v125) and (v123 or v124) then
                    if not v123 then
                        v14 = nil
                    end
                    v7 = Position_2
                end
            end
        else
            v15 = v117
            v7 = Position_2
        end
    else
        v7 = Position_2
        v15 = false
    end
end)
