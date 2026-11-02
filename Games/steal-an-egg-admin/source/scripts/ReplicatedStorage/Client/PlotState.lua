-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Log = require(ReplicatedStorage.Packages.Log)
local Plots = require(ReplicatedStorage.Shared.Types.Plots)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Streamable = require(ReplicatedStorage.Packages.Streamable).Streamable
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.instanceIsA("Player"))
local v2 = t.strict(t.Vector3)
local v3 = t.strict(t.instanceIsA("BasePart"))
local v4 = t.strict(t.instanceIsA("Attachment"))
local v5 = t.strict(t.instanceIsA("BillboardGui"))
local v6 = t.strict(t.instanceIsA("Folder"))
local v7 = Log.new()
local LocalPlayer = Players.LocalPlayer
local v8 = {}
local v9 = {}
local v10 = {}
local v11 = {}
local v12
local v13 = {
    LocalPlotChanged = Signal.new(),
    PlotChanged = Signal.new(),
    FolderChanged = Signal.new()
}
local Plots_2 = Streamable.new(Workspace, "Plots")

local function localSlot() -- line 29 | captures: LocalPlayer, v8
    for v14, v15 in v8 do
        if v15 == LocalPlayer.UserId then
            return v14
        end
    end
    return nil
end

local function announce(v16) -- line 40 | captures: LocalPlayer, v8, v13
    v13.PlotChanged:Fire(v16, v8[v16])
    local v17
    for v18, v19 in v8 do
        if v19 == LocalPlayer.UserId then
            v17 = v18
            break
        end
        v17 = nil
    end
    if v17 == v16 then
        v13.LocalPlotChanged:Fire(v16)
    end
end

local function follow(v20, v21, v22, v23) -- line 56 | captures: Streamable
    local v24 = Streamable.new(v20, v21)
    v22:Add(function() -- line 58 | captures: v24
        v24:Destroy()
    end)
    v24:Observe(v23)
end

local function watchSlot(v25, v26) -- line 63 | captures: Streamable, Trove, v3, v4, v5, LocalPlayer, v8, v10, v11, v13
    if v11[v25] then
        return
    end
    local v27 = Trove.new()
    local v28 = Streamable.new(v26, (tostring(v25)))
    local v29 = {
        plot = v28,
        trove = v27
    }
    v11[v25] = v29
    v27:Add(function() -- line 71 | captures: v28
        v28:Destroy()
    end)
    v27:Add(function() -- line 74 | captures: v25, v29, v11
        if v11[v25] == v29 then
            v11[v25] = nil
        end
    end)

    local function ping() -- line 80 | captures: v25, LocalPlayer, v8, v13
        v13.PlotChanged:Fire(v25, v8[v25])
        local v30
        for v31, v32 in v8 do
            if v32 == LocalPlayer.UserId then
                v30 = v31
                break
            end
            v30 = nil
        end
        if v30 == v25 then
            v13.LocalPlotChanged:Fire(v25)
        end
    end

    v27:Add(v28:Observe(function(v33, v34) -- line 97 | captures: v25, v29, ping, Streamable, v3, v4, v5, LocalPlayer, v8, v10, v11, v13
        if v33:IsA("Folder") then
            v13.PlotChanged:Fire(v25, v8[v25])
            local v35
            for v36, v37 in v8 do
                if v37 == LocalPlayer.UserId then
                    v35 = v36
                    break
                end
                v35 = nil
            end
            if v35 == v25 then
                v13.LocalPlotChanged:Fire(v25)
            end
            v34:Add(ping)
            local CenterPoint = Streamable.new(v33, "CenterPoint")
            v34:Add(function() -- line 116 | captures: CenterPoint
                CenterPoint:Destroy()
            end)
            CenterPoint:Observe(function(v38, v39) -- line 119 | captures: v25, ping, v3, LocalPlayer, v8, v13
                v3(v38)
                v13.PlotChanged:Fire(v25, v8[v25])
                local v40
                for v41, v42 in v8 do
                    if v42 == LocalPlayer.UserId then
                        v40 = v41
                        break
                    end
                    v40 = nil
                end
                if v40 == v25 then
                    v13.LocalPlotChanged:Fire(v25)
                end
                v39:Add(ping)
            end)
            local SpawnPoint = Streamable.new(v33, "SpawnPoint")
            v34:Add(function() -- line 139 | captures: SpawnPoint
                SpawnPoint:Destroy()
            end)
            SpawnPoint:Observe(function(v43, v44) -- line 142 | captures: v25, v29, v3, LocalPlayer, v8, v10, v11, v13
                v3(v43)
                v10[v25] = v43.CFrame + Vector3.new(0, 0, 0)
                v13.PlotChanged:Fire(v25, v8[v25])
                local v45
                for v46, v47 in v8 do
                    if v47 == LocalPlayer.UserId then
                        v45 = v46
                        break
                    end
                    v45 = nil
                end
                if v45 == v25 then
                    v13.LocalPlotChanged:Fire(v25)
                end
                v44:Add(function() -- line 160 | captures: v25, v29, LocalPlayer, v8, v11, v13
                    if v11[v25] ~= v29 then
                        return
                    end
                    v13.PlotChanged:Fire(v25, v8[v25])
                    local v48
                    for v49, v50 in v8 do
                        if v50 == LocalPlayer.UserId then
                            v48 = v49
                            break
                        end
                        v48 = nil
                    end
                    if v48 == v25 then
                        v13.LocalPlotChanged:Fire(v25)
                    end
                end)
            end)
            local ToUpdate = Streamable.new(v33, "ToUpdate")
            v34:Add(function() -- line 182 | captures: ToUpdate
                ToUpdate:Destroy()
            end)
            ToUpdate:Observe(function(v51, v52) -- line 185 | captures: v25, ping, Streamable, v3, LocalPlayer, v8, v13
                if not v51:IsA("Model") then
                    return
                end
                v13.PlotChanged:Fire(v25, v8[v25])
                local v53
                for v54, v55 in v8 do
                    if v55 == LocalPlayer.UserId then
                        v53 = v54
                        break
                    end
                    v53 = nil
                end
                if v53 == v25 then
                    v13.LocalPlotChanged:Fire(v25)
                end
                v52:Add(ping)
                local PetArea = Streamable.new(v51, "PetArea")
                v52:Add(function() -- line 204 | captures: PetArea
                    PetArea:Destroy()
                end)
                PetArea:Observe(function(v56, v57) -- line 207 | captures: v25, ping, v3, LocalPlayer, v8, v13
                    v3(v56)
                    v13.PlotChanged:Fire(v25, v8[v25])
                    local v58
                    for v59, v60 in v8 do
                        if v60 == LocalPlayer.UserId then
                            v58 = v59
                            break
                        end
                        v58 = nil
                    end
                    if v58 == v25 then
                        v13.LocalPlotChanged:Fire(v25)
                    end
                    v57:Add(ping)
                end)
            end)
            local PlotSign = Streamable.new(v33, "PlotSign")
            v34:Add(function() -- line 229 | captures: PlotSign
                PlotSign:Destroy()
            end)
            PlotSign:Observe(function(v61, v62) -- line 232 | captures: v25, ping, Streamable, v4, v5, LocalPlayer, v8, v13
                v13.PlotChanged:Fire(v25, v8[v25])
                local v63
                for v64, v65 in v8 do
                    if v65 == LocalPlayer.UserId then
                        v63 = v64
                        break
                    end
                    v63 = nil
                end
                if v63 == v25 then
                    v13.LocalPlotChanged:Fire(v25)
                end
                v62:Add(ping)
                local Attachment = Streamable.new(v61, "Attachment")
                v62:Add(function() -- line 250 | captures: Attachment
                    Attachment:Destroy()
                end)
                Attachment:Observe(function(v66, v67) -- line 253 | captures: v25, ping, Streamable, v4, v5, LocalPlayer, v8, v13
                    v4(v66)
                    v13.PlotChanged:Fire(v25, v8[v25])
                    local v68
                    for v69, v70 in v8 do
                        if v70 == LocalPlayer.UserId then
                            v68 = v69
                            break
                        end
                        v68 = nil
                    end
                    if v68 == v25 then
                        v13.LocalPlotChanged:Fire(v25)
                    end
                    v67:Add(ping)
                    local YourBase = Streamable.new(v66, "YourBase")
                    v67:Add(function() -- line 272 | captures: YourBase
                        YourBase:Destroy()
                    end)
                    YourBase:Observe(function(v71, v72) -- line 275 | captures: v25, ping, v5, LocalPlayer, v8, v13
                        v5(v71)
                        v13.PlotChanged:Fire(v25, v8[v25])
                        local v73
                        for v74, v75 in v8 do
                            if v75 == LocalPlayer.UserId then
                                v73 = v74
                                break
                            end
                            v73 = nil
                        end
                        if v73 == v25 then
                            v13.LocalPlotChanged:Fire(v25)
                        end
                        v72:Add(ping)
                    end)
                end)
            end)
            local BaseUpgrade = Streamable.new(v33, "BaseUpgrade")
            v34:Add(function() -- line 297 | captures: BaseUpgrade
                BaseUpgrade:Destroy()
            end)
            BaseUpgrade:Observe(function(v76, v77) -- line 300 | captures: v25, ping, Streamable, LocalPlayer, v8, v13
                v13.PlotChanged:Fire(v25, v8[v25])
                local v78
                for v79, v80 in v8 do
                    if v80 == LocalPlayer.UserId then
                        v78 = v79
                        break
                    end
                    v78 = nil
                end
                if v78 == v25 then
                    v13.LocalPlotChanged:Fire(v25)
                end
                v77:Add(ping)
                local Sign = Streamable.new(v76, "Sign")
                v77:Add(function() -- line 318 | captures: Sign
                    Sign:Destroy()
                end)
                Sign:Observe(function(v81, v82) -- line 321 | captures: v25, ping, LocalPlayer, v8, v13
                    v13.PlotChanged:Fire(v25, v8[v25])
                    local v83
                    for v84, v85 in v8 do
                        if v85 == LocalPlayer.UserId then
                            v83 = v84
                            break
                        end
                        v83 = nil
                    end
                    if v83 == v25 then
                        v13.LocalPlotChanged:Fire(v25)
                    end
                    v82:Add(ping)
                end)
            end)
        elseif v33:IsA("Model") then
        end
    end))
end

local function forgetSlot(v86) -- line 346 | captures: v10, v11
    local v87 = v11[v86]
    if v87 == nil then
        return
    end
    v10[v86] = nil
    v11[v86] = nil
    v87.trove:Destroy()
end

local function forgetEverySlot() -- line 354 | captures: v10, v11
    local v88 = {}
    for v89 in v11 do
        table.insert(v88, v89)
    end
    for v90, v91 in v88 do
        local v92 = v11[v91]
        if v92 ~= nil then
            v10[v91] = nil
            v11[v91] = nil
            v92.trove:Destroy()
        end
    end
end

local function slotFor(v93) -- line 375 | captures: v1, LocalPlayer, v8
    local v94 = v93 or LocalPlayer
    v1(v94)
    local v95
    if v94 == LocalPlayer then
        for v96, v97 in v8 do
            if v97 == LocalPlayer.UserId then
                v95 = v96
                break
            end
            v95 = nil
        end
    end
    for v98, v99 in v8 do
        if v95 == nil and v99 == v94.UserId then
            v95 = v98
        end
    end
    return v95, v94
end

function v13.ReadOwners() -- line 407 | captures: v8
    return table.clone(v8)
end

function v13.LookupOwner(v100) -- line 410 | captures: v8
    return v8[v100]
end

function v13.ResolveLocalSlot() -- line 413 | captures: LocalPlayer, v8
    for v101, v102 in v8 do
        if v102 == LocalPlayer.UserId then
            return v101
        end
    end
    return nil
end

function v13.ResolveFolder() -- line 426 | captures: v12
    return v12
end

function v13.ResolvePlot(v103) -- line 429 | captures: v12, v10, slotFor
    local v104 = slotFor(v103)
    local v105 = v12
    local v106
    if v104 == nil or v105 == nil then
    else
        v106 = v105:FindFirstChild((tostring(v104)))
    end
    local v107
    if v106 == nil then
    else
        v107 = v106:FindFirstChild("ToUpdate")
    end
    local v108
    if v107 == nil then
    elseif v107:IsA("Model") then
        v108 = v107:FindFirstChild("PetArea")
    end
    local v109
    if v106 == nil then
    else
        v109 = v106:FindFirstChild("CenterPoint")
    end
    local BasePart
    if v108 == nil then
        BasePart = false
    else
        BasePart = v108:IsA("BasePart")
        if BasePart then
            if v109 == nil then
                BasePart = false
            else
                BasePart = v109:IsA("BasePart")
            end
        end
    end
    if BasePart then
        local SpawnPoint = v106:FindFirstChild("SpawnPoint")
        local v110
        if SpawnPoint == nil then
            v110 = v10[v104]
        elseif SpawnPoint:IsA("BasePart") then
            v110 = SpawnPoint.CFrame + Vector3.new(0, 0, 0)
        else
            v110 = v10[v104]
        end
        v10[v104] = v110
        return {
            Slot = v104,
            PlotFolder = v106,
            PetArea = v108,
            CenterPoint = v109,
            RespawnPointCFrame = v10[v104]
        }
    end
    return nil
end

function v13.FindLocalBaseSign() -- line 481 | captures: v13
    local v111 = v13.ResolvePlot()
    local v112
    if v111 then
        v112 = v111.PlotFolder:FindFirstChild("PlotSign")
    end
    local v113
    if v112 then
        v113 = v112:FindFirstChild("Attachment")
    end
    local v114
    if v113 == nil then
    elseif v113:IsA("Attachment") then
        v114 = v113:FindFirstChild("YourBase")
    end
    if v114 ~= nil and v114:IsA("BillboardGui") then
        return v114
    end
    return nil
end

function v13.FindRespawnCFrame(v115) -- line 509 | captures: v10, slotFor
    local v116 = slotFor(v115)
    if v116 == nil then
        return nil
    end
    return v10[v116]
end

function v13.ContainsLocalPoint(v117) -- line 516 | captures: v2, v13
    v2(v117)
    local v118 = v13.ResolvePlot()
    if v118 then
        local v119, v120 = v118.PlotFolder:GetBoundingBox()
        local v121 = v119:PointToObjectSpace(v117)
        local v122 = v120 * 0.5
        local X = v121.X
        if math.abs(X) <= v122.X then
            local Z = v121.Z
            return math.abs(Z) <= v122.Z
        end
        return false
    end
    return false
end

local function adoptOwner(v123, v124) -- line 534 | captures: LocalPlayer, v8, v13
    local v125
    for v126, v127 in v8 do
        if v127 == LocalPlayer.UserId then
            v125 = v126
            break
        end
        v125 = nil
    end
    v8[v123] = v124
    v13.PlotChanged:Fire(v123, v124)
    if v124 == LocalPlayer.UserId or v125 == v123 then
        v13.LocalPlotChanged:Fire(v123)
    end
end

local function acceptUpdate(v128) -- line 554 | captures: LocalPlayer, v8, v9, v13
    local v129 = v9[v128.Slot]
    if v129 == nil then
        v9[v128.Slot] = v128.Revision
        local Slot = v128.Slot
        local UserId = v128.UserId
        local v130
        for v131, v132 in v8 do
            if v132 == LocalPlayer.UserId then
                v130 = v131
                break
            end
            v130 = nil
        end
        v8[Slot] = UserId
        v13.PlotChanged:Fire(Slot, UserId)
        if UserId == LocalPlayer.UserId or v130 == Slot then
            v13.LocalPlotChanged:Fire(Slot)
        end
    elseif v128.Revision <= v129 then
    end
end

local function acceptSnapshot(v133) -- line 581 | captures: LocalPlayer, v8, v9, v13
    local v134 = {}
    for v135, v136 in v133.OwnersBySlot do
        local v137 = tonumber(v135)
        local v138 = ("plot snapshot carried a non-numeric slot: %*"):format(v135)
        local v139 = assert(v137, v138)
        v134[v139] = true
        local v140 = v9[v139]
        if v140 == nil then
            v9[v139] = v133.Revision
            local v141
            for v142, v143 in v8 do
                if v143 == LocalPlayer.UserId then
                    v141 = v142
                    break
                end
                v141 = nil
            end
            v8[v139] = v136
            v13.PlotChanged:Fire(v139, v136)
            if v136 == LocalPlayer.UserId then
                v13.LocalPlotChanged:Fire(v139)
            elseif v141 == v139 then
            end
        elseif v133.Revision <= v140 then
        end
    end
    local v144 = {}
    for v145 in v9 do
        table.insert(v144, v145)
    end
    for v146, v147 in v144 do
        local v148 = if v134[v147] == true then false else v9[v147] < v133.Revision
        local v149
        if v148 then
            v148 = v8[v147] ~= nil
            v149 = v133.Revision
        else
            v149 = v9[v147]
        end
        v9[v147] = v149
        if v148 then
            local v150
            for v151, v152 in v8 do
                if v152 == LocalPlayer.UserId then
                    v150 = v151
                    break
                end
                v150 = nil
            end
            v8[v147] = nil
            v13.PlotChanged:Fire(v147, nil)
            if LocalPlayer.UserId == nil then
                v13.LocalPlotChanged:Fire(v147)
            elseif v150 == v147 then
            end
        end
    end
end

local function askState() -- line 662 | captures: Remotes
    return Remotes.Homestead.AskState:InvokeServer()
end

local function pullSnapshot() -- line 665 | captures: Plots, acceptSnapshot, askState
    local v153, v154 = pcall(askState)
    if v153 then
        local v155, v156 = Plots.SchemaValidation.PlotStateSnapshot(v154)
        if v155 then
            acceptSnapshot(v154)
            return true
        end
        return false, (("plot snapshot failed validation: %*"):format(v156))
    end
    return false, (tostring(v154))
end

local v157

function v157() -- line 678 | captures: v157, Plots, v7, acceptSnapshot, askState
    local v158, v159 = pcall(askState)
    local v160, v161
    if v158 then
        local v162, v163 = Plots.SchemaValidation.PlotStateSnapshot(v159)
        if v162 then
            acceptSnapshot(v159)
            v160 = true
        else
            v160, v161 = false, ("plot snapshot failed validation: %*"):format(v163)
        end
    else
        v160, v161 = false, tostring(v159)
    end
    if not v160 then
        v7:AtError():Log((("plot snapshot request did not land, retrying: %*"):format(v161)))
        task.delay(5, v157)
    end
end

Remotes.Homestead.StateShifted.OnClientEvent:Connect(function(v164) -- line 701 | captures: Plots, v7, LocalPlayer, v8, v9, v13
    local v165, v166 = Plots.SchemaValidation.PlotStateUpdate(v164)
    if v165 then
        local v167 = v9[v164.Slot]
        if v167 == nil then
            v9[v164.Slot] = v164.Revision
            local Slot = v164.Slot
            local UserId = v164.UserId
            local v168
            for v169, v170 in v8 do
                if v170 == LocalPlayer.UserId then
                    v168 = v169
                    break
                end
                v168 = nil
            end
            v8[Slot] = UserId
            v13.PlotChanged:Fire(Slot, UserId)
            if UserId == LocalPlayer.UserId or v168 == Slot then
                v13.LocalPlotChanged:Fire(Slot)
            end
        elseif v164.Revision <= v167 then
        end
    else
        v7:AtError():Log((("plot state update failed validation: %*"):format(v166)))
    end
end)
Plots_2:Observe(function(v171, v172) -- line 740 | captures: v12, v6, v10, v11, v13, watchSlot, forgetEverySlot
    v6(v171)
    v12 = v171
    v13.FolderChanged:Fire(v171)
    v172:Add(function() -- line 745 | captures: v171, v12, v13, forgetEverySlot
        if v12 == v171 then
            v12 = nil
        end
        forgetEverySlot()
        v13.FolderChanged:Fire(nil)
    end)

    local function watchIfNumbered(v173) -- line 752 | captures: v171, watchSlot
        local Name = v173.Name
        local v174 = tonumber(Name)
        if v174 ~= nil then
            watchSlot(v174, v171)
        end
    end

    for v175, v176 in v171:GetChildren() do
        local Name = v176.Name
        local v177 = tonumber(Name)
        if v177 ~= nil then
            watchSlot(v177, v171)
        end
    end
    v172:Connect(v171.ChildAdded, function(v178) -- line 764 | captures: v171, v13, watchSlot
        local Name = v178.Name
        local v179 = tonumber(Name)
        if v179 ~= nil then
            watchSlot(v179, v171)
        end
        v13.FolderChanged:Fire(v171)
    end)
    v172:Connect(v171.ChildRemoved, function(v180) -- line 771 | captures: v171, v10, v11, v13
        local Name = v180.Name
        local v181 = tonumber(Name)
        if v181 ~= nil then
            local v182 = v11[v181]
            if v182 ~= nil then
                v10[v181] = nil
                v11[v181] = nil
                v182.trove:Destroy()
            end
        end
        v13.FolderChanged:Fire(v171)
    end)
end)
task.spawn(v157)
Remotes.Homestead.AskNearbyPurchase.OnClientEvent:Connect(function(v183) -- line 785 | captures: PromptPurchase
    PromptPurchase.Prompt(v183, true)
end)
return v13
