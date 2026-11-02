-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasiteEligibility = require(ReplicatedStorage.Shared.Util.MonsterParasiteEligibility)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
require(ReplicatedStorage.Packages.Networking)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local MonsterParasite_3 = Remotes.MonsterParasite
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = Trove.new()
local v2 = { Active = false }
local v3 = v2

v2.EndsAt = MonsterParasite.EndsAt
v2.ServerTime = os.time()

local v4 = 0
local v5, v6, v7, v8, v9
local v10 = false
local v11 = {}
local v12
local v13 = true
local v14 = 0
local v15 = 0
local v16
local v17 = 0
local v18
local v19 = false
local v20 = 0
local Charge, v21
local v22 = {}
local v23

local function formatRemaining(v24) -- line 45
    local v25 = math.floor(v24)
    local v26 = math.max(v25, 0)
    local v27 = v26 // 86400
    local v28 = v26 % 86400 // 3600
    local v29 = v26 % 3600 // 60
    if v27 > 0 then
        return (("%*d %*h"):format(v27, v28))
    end
    return (("%*h %*m"):format(v28, v29))
end

local function getOwnedMonster() -- line 56 | captures: Workspace, MonsterParasite, LocalPlayer
    local v30 = Workspace:FindFirstChild(MonsterParasite.WorldFolderName)
    if v30 ~= nil and v30:IsA("Folder") then
        for v31, v32 in v30:GetChildren() do
            if v32:IsA("Model") and v32:GetAttribute("OwnerUserId") == LocalPlayer.UserId then
                return v32
            end
        end
    end
    return nil
end

local function resolveTemplate() -- line 72 | captures: v10, ReplicatedStorage
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v33
    if Assets then
        v33 = Assets:FindFirstChild("Extra")
    end
    local v34
    if v33 then
        v34 = v33:FindFirstChild("MonsterBillboardAttachment")
    end
    if v34 ~= nil and v34:IsA("Attachment") then
        return v34
    end
    if not v10 then
        v10 = true
        warn("[MonsterCharge] Missing ReplicatedStorage.Assets.Extra.MonsterBillboardAttachment; the monster billboard is skipped")
    end
    return nil
end

local function resolveMonsterTemplate(v35) -- line 101 | captures: ReplicatedStorage, MonsterParasite
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v36
    if Assets then
        v36 = Assets:FindFirstChild("Models")
    end
    local v37
    if v36 then
        v37 = v36:FindFirstChild(MonsterParasite.AssetsFolderName)
    end
    local v38 = MonsterParasite.MonsterModelNames[v35]
    local v39
    if v37 and v38 then
        v39 = v37:FindFirstChild(v38)
    end
    if v39 and v39:IsA("Model") and v39.PrimaryPart then
        return v39
    end
    return nil
end

local function measureHeadHeight(v40) -- line 130
    local PrimaryPart = v40.PrimaryPart
    if PrimaryPart == nil then
        return nil
    end
    local v41, v42 = v40:GetBoundingBox()
    local v43 = v41.Position + Vector3.new(0, 1, 0) * (v42.Y * 0.5)
    return PrimaryPart.CFrame:PointToObjectSpace(v43).Y
end

local function resolveBillboardHeight(v44, v45) -- line 140 | captures: MonsterParasite, v11, resolveMonsterTemplate
    local v46 = v44:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
    if typeof(v46) ~= "number" then
        v46 = nil
    end
    local v47 = if v46 then v11[v46] else nil
    local v48
    if v47 == nil then
        local v49
        if v46 then
            v49 = resolveMonsterTemplate(v46)
        end
        if v49 then
            local PrimaryPart = v49.PrimaryPart
            if PrimaryPart == nil then
            else
                local v50, v51 = v49:GetBoundingBox()
                local v52 = v50.Position + Vector3.new(0, 1, 0) * (v51.Y * 0.5)
                v48 = PrimaryPart.CFrame:PointToObjectSpace(v52).Y
            end
        end
        if not v48 then
            local PrimaryPart = v44.PrimaryPart
            if PrimaryPart == nil then
                v48 = nil
            else
                local v53, v54 = v44:GetBoundingBox()
                local v55 = v53.Position + Vector3.new(0, 1, 0) * (v54.Y * 0.5)
                v48 = PrimaryPart.CFrame:PointToObjectSpace(v55).Y
            end
        end
        if v48 ~= nil and v46 ~= nil then
            v11[v46] = v48
        end
    else
        v48 = v47
    end
    if v48 == nil then
        return 8.5
    end
    local v56 = if v45 then v45.Size.Y.Scale * 0.5 else 2
    return v48 + v56 + 0.75
end

local function setLabelText(v57, v58, v59) -- line 199
    local v60 = v57:FindFirstChild(v58, true)
    if v60 ~= nil and v60:IsA("TextLabel") then
        v60.Text = v59
    end
end

local function resolveDebrisFolder() -- line 205 | captures: Workspace
    local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
    if __DEBRIS == nil then
        return Workspace
    end
    return __DEBRIS
end

local function createAnchor() -- line 212 | captures: Workspace
    local Part = Instance.new("Part")
    Part.Name = "MonsterBillboardAnchor"
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Massless = true
    Part.Locked = true
    Part.Archivable = false
    local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
    if __DEBRIS == nil then
        __DEBRIS = Workspace
    end
    Part.Parent = __DEBRIS
    return Part
end

local function destroyBillboard() -- line 235 | captures: v5, v6, v7, v8, v9, v12, v13
    if v5 ~= nil then
        v5:Destroy()
        v5 = nil
    end
    v6 = nil
    v7 = nil
    v8 = nil
    v9 = nil
    v12 = nil
    v13 = true
end

local function ensureBillboard(v61) -- line 247 | captures: v5, v6, v7, v8, v9, v12, v13, Workspace, MonsterParasite, resolveTemplate, resolveBillboardHeight
    local PrimaryPart = v61.PrimaryPart
    if PrimaryPart == nil then
        if v5 ~= nil then
            v5:Destroy()
            v5 = nil
        end
        v6 = nil
        v7 = nil
        v8 = nil
        v9 = nil
        v12 = nil
        v13 = true
        return nil
    end
    local v62 = resolveTemplate()
    if v62 == nil then
        if v5 ~= nil then
            v5:Destroy()
            v5 = nil
        end
        v6 = nil
        v7 = nil
        v8 = nil
        v9 = nil
        v12 = nil
        v13 = true
        return nil
    end
    local v63 = v5
    local v64, v65
    if v63 == nil then
        v64 = v63
        v65 = true
    elseif v63.Parent == nil then
        if v5 ~= nil then
            v5:Destroy()
            v5 = nil
        end
        v65 = false
    else
        v64 = v63
        v65 = true
    end
    if not v65 then
        v6 = nil
        v7 = nil
        v8 = nil
        v9 = nil
        v12 = nil
        v13 = true
        v64 = nil
    end
    local v66 = v6
    if v64 == nil then
        if v5 ~= nil then
            v5:Destroy()
            v5 = nil
        end
        v6 = nil
        v7 = nil
        v8 = nil
        v9 = nil
        v12 = nil
        v13 = true
        v64 = Instance.new("Part")
        v64.Name = "MonsterBillboardAnchor"
        v64.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
        v64.Transparency = 1
        v64.Anchored = true
        v64.CanCollide = false
        v64.CanQuery = false
        v64.CanTouch = false
        v64.CastShadow = false
        v64.Massless = true
        v64.Locked = true
        v64.Archivable = false
        local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
        if __DEBRIS == nil then
            __DEBRIS = Workspace
        end
        v64.Parent = __DEBRIS
        v66 = v62:Clone()
        v66.Parent = v64
        v5 = v64
        v6 = v66
        local v67 = v66:FindFirstChild("MonsterName", true)
        if v67 ~= nil and v67:IsA("TextLabel") then
            v67.Text = MonsterParasite.MonsterDisplayName
        end
        local v68 = v66:FindFirstChild("Progress", true)
        local v69, v70
        if v68 then
            v69 = v68:FindFirstChild("Fill")
            v70 = v68:FindFirstChild("Progress", true)
        end
        if not (v69 and v69:IsA("GuiObject")) then
            v69 = nil
        end
        v7 = v69
        if v70 then
            if not v70:IsA("TextLabel") then
                v70 = v69
            end
        else
            v70 = nil
        end
        v8 = v70
    end
    if v64.CFrame ~= PrimaryPart.CFrame then
        v64.CFrame = PrimaryPart.CFrame
    end
    local BillboardGui = v66:FindFirstChildWhichIsA("BillboardGui")
    local v71 = resolveBillboardHeight(v61, BillboardGui)
    v12 = v71
    if v13 then
        v13 = false
        v66.Position = Vector3.new(0, v71, 0)
    end
    v9 = v61
    return v66
end

local function refreshTargetAlpha() -- line 370 | captures: v14, v19, v21, MonsterParasite
    if v19 then
        v14 = 1
    else
        local v72 = (v21 or 0) / MonsterParasite.MaxCharge
        v14 = math.clamp(v72, 0, 1)
    end
end

local function render() -- line 379 | captures: v3, v4, v5, v6, v7, v8, v9, v12, v13, v14, v15, v16, v19, Charge, v21, MonsterParasite, MonsterParasiteEligibility, Save, v22, getOwnedMonster, ensureBillboard
    local v73 = Save.Get()
    local v74
    if v73 == nil then
        v74 = false
    else
        v74 = MonsterParasiteEligibility.IsEligible(v73.SpeedPower)
    end
    local v75 = getOwnedMonster()
    if v73 ~= nil and v74 and v3.Active and v75 ~= nil then
        local v76 = ensureBillboard(v75)
        if v76 ~= nil then
            local MonsterParasite_2 = v73.MonsterParasite
            local Charge_2 = Charge
            Charge = MonsterParasite_2.Charge
            if v21 == nil then
                v21 = MonsterParasite_2.Charge
            elseif Charge_2 ~= nil and MonsterParasite_2.Charge ~= Charge_2 then
                local v77 = {}
                v77.Wrap = MonsterParasite_2.Charge < Charge_2
                v77.Since = os.clock()
                table.insert(v22, v77)
            end
            if v19 then
                v14 = 1
            else
                local v78 = (v21 or 0) / MonsterParasite.MaxCharge
                v14 = math.clamp(v78, 0, 1)
            end
            local v79 = os.time() + v4
            local v80 = v3.EndsAt - v79
            local v81 = math.floor(v80)
            local v82 = math.max(v81, 0)
            local v83 = v82 // 86400
            local v84 = v82 % 86400 // 3600
            local v85 = v82 % 3600 // 60
            local v86
            if v83 <= 0 then
                v86 = ("%*h %*m"):format(v84, v85)
            else
                v86 = ("%*d %*h"):format(v83, v84)
            end
            local v87 = ("Leaves in %*"):format(v86)
            local v88 = v76:FindFirstChild("Timer", true)
            if v88 ~= nil and v88:IsA("TextLabel") then
                v88.Text = v87
            end
        end
    else
        if v5 ~= nil then
            v5:Destroy()
            v5 = nil
        end
        v6 = nil
        v7 = nil
        v8 = nil
        v9 = nil
        v12 = nil
        v13 = true
        Charge = nil
        v21 = nil
        table.clear(v22)
        v19 = false
        v16 = nil
        v15 = 0
        v14 = 0
    end
end

local function startDrain() -- line 443 | captures: v14, v15, v16, v17, v19, Charge, v21, MonsterParasite
    v19 = false
    local v89 = v15
    local v90 = v14
    v16 = math.max(v89, v90)
    v17 = os.clock()
    v21 = Charge
    if v19 then
        v14 = 1
    else
        local v91 = (v21 or 0) / MonsterParasite.MaxCharge
        v14 = math.clamp(v91, 0, 1)
    end
end

local function releaseGain() -- line 456 | captures: v14, v19, v20, Charge, v21, MonsterParasite, v22
    local v92 = table.remove(v22, 1)
    if v92 ~= nil then
        if v92.Wrap then
            v21 = MonsterParasite.MaxCharge
            v19 = true
            v20 = os.clock()
            if v19 then
                v14 = 1
            else
                local v93 = (v21 or 0) / MonsterParasite.MaxCharge
                v14 = math.clamp(v93, 0, 1)
            end
        else
            if #v22 == 0 then
                v21 = Charge
            else
                local v94 = (v21 or 0) + MonsterParasite.ChargePerFeed
                local MaxCharge = MonsterParasite.MaxCharge
                v21 = math.clamp(v94, 0, MaxCharge)
            end
            if v19 then
                v14 = 1
            else
                local v95 = (v21 or 0) / MonsterParasite.MaxCharge
                v14 = math.clamp(v95, 0, 1)
            end
        end
    end
end

local function stepAnchor(v96) -- line 482 | captures: v5, v6, v9, v12
    local v97 = v5
    local v98 = v6
    local v99 = v12
    if v97 == nil or v98 == nil or v99 == nil then
        return
    end
    local v100 = v9
    local PrimaryPart
    if v100 == nil then
    else
        PrimaryPart = v100.PrimaryPart
    end
    if PrimaryPart ~= nil and v97.CFrame ~= PrimaryPart.CFrame then
        v97.CFrame = PrimaryPart.CFrame
    end
    local Y = v98.Position.Y
    local v101 = v99 - Y
    if math.abs(v101) >= 0.001 then
        local v102 = v99 - Y
        local v103 = v96 * 9
        local v104 = Y + v102 * math.min(v103, 1)
        v98.Position = Vector3.new(0, v104, 0)
    elseif Y ~= v99 then
        v98.Position = Vector3.new(0, v99, 0)
    end
end

local function setEventState(v105) -- line 509 | captures: v3, v4, render
    v3 = v105
    v4 = v105.ServerTime - os.time()
    render()
end

v1:Connect(PlayerGui.ChildAdded, function(v106) -- line 514 | captures: MonsterParasite, PlayerGui
    local v107
    if v106 == nil then
        v107 = PlayerGui:FindFirstChild(MonsterParasite.HudName)
    else
        v107 = v106
    end
    if v107 ~= nil and v107.Name == MonsterParasite.HudName and v107:IsA("ScreenGui") then
        v107.Enabled = false
    end
end)
local v108 = PlayerGui:FindFirstChild(MonsterParasite.HudName)

if v108 ~= nil and v108.Name == MonsterParasite.HudName and v108:IsA("ScreenGui") then
    v108.Enabled = false
end
v1:Connect(Save.FieldSignal("MonsterParasite"), render)
v1:Connect(Save.FieldSignal("SpeedPower"), render)
v1:Connect(MonsterParasite_3.EventStateShifted.OnClientEvent, function(v109) -- line 534 | captures: v3, v4, MonsterParasite_2, render
    if not MonsterParasite_2.EventStateSchema(v109) then
        return
    end
    v3 = v109
    v4 = v109.ServerTime - os.time()
    render()
end)
v1:Connect(RunService.RenderStepped, function(v110) -- line 541 | captures: v7, v8, v9, v14, v15, v16, v17, v18, v19, v20, Charge, v21, v23, MonsterParasite, MonsterParasite_2, LocalPlayer, v22, releaseGain, stepAnchor
    stepAnchor(v110)
    local v111 = v7
    if v111 == nil then
        return
    end
    local v112 = LocalPlayer:GetAttribute(MonsterParasite_2.ChargeGainAttributeName)
    if typeof(v112) == "number" and v112 ~= v23 then
        v23 = v112
        releaseGain()
    end
    local v113 = v22[1]
    if v113 ~= nil then
        local v114 = os.clock() - v113.Since
        if MonsterParasite_2.ChargeGainCueTimeout < v114 then
            releaseGain()
        end
    end
    local v115 = v9
    local v116
    if v115 then
        v116 = v115:GetAttribute(MonsterParasite_2.ChargeDrainAttributeName)
    end
    if typeof(v116) == "number" then
        if v116 ~= v18 then
            v18 = v116
            v19 = false
            local v117 = v15
            local v118 = v14
            v16 = math.max(v117, v118)
            v17 = os.clock()
            v21 = Charge
            if v19 then
                v14 = 1
            else
                local v119 = (v21 or 0) / MonsterParasite.MaxCharge
                v14 = math.clamp(v119, 0, 1)
            end
        end
    elseif v19 and os.clock() - v20 > 6 then
        v19 = false
        local v120 = v15
        local v121 = v14
        v16 = math.max(v120, v121)
        v17 = os.clock()
        v21 = Charge
        if v19 then
            v14 = 1
        else
            local v122 = (v21 or 0) / MonsterParasite.MaxCharge
            v14 = math.clamp(v122, 0, 1)
        end
    end
    local v123 = v16
    if v123 == nil then
        local v124 = v15
        local v125 = v14 - v15
        local v126 = v110 * 14
        v15 = v124 + v125 * math.min(v126, 1)
        local v127 = v14 - v15
        if math.abs(v127) < 0.001 then
            v15 = v14
        end
    else
        local v128 = (os.clock() - v17) / MonsterParasite_2.ChargeDrainDuration
        local v129 = math.clamp(v128, 0, 1)
        v15 = v123 * (1 - v129 * v129 * (3 - v129 * 2))
        if v129 >= 1 then
            v16 = nil
            v15 = 0
        end
    end
    local v130 = v15
    local v131 = math.clamp(v130, 0, 1)
    v111.Size = UDim2.fromScale(v131, 1)
    local v132 = v8
    if v132 ~= nil then
        local v133 = v131 * 100
        v132.Text = ("%*%%"):format((math.round(v133)))
    end
end)
local v134 = Timer.new(0.15)
v1:Add(v134)
v1:Connect(v134.Tick, render)
v134:Start()
task.spawn(function() -- line 622 | captures: v3, v4, MonsterParasite_2, MonsterParasite_3, render
    local v135, v136 = pcall(function() -- line 624 | captures: MonsterParasite_3
        return MonsterParasite_3.AskSnapshot:InvokeServer()
    end)
    if not (v135 and MonsterParasite_2.SnapshotSchema(v136)) then
        return
    end
    local Event = v136.Event
    v3 = Event
    v4 = Event.ServerTime - os.time()
    render()
end)
