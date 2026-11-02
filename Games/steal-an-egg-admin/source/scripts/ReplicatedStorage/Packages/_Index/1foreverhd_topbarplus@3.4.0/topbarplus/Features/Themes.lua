-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local Utility = require(script.Parent.Parent.Utility)
local Default = require(script.Default)

local function getThemeValue(v2, v3, v4, v5) -- line 9
    if v2 then
        for v6, v7 in pairs(v2) do
            local v8, v9, v10 = unpack(v7)
            if v3 == v8 and v4 == v9 then
                return v10
            end
        end
    end
    return nil
end

v1.getThemeValue = getThemeValue

local function getInstanceValue(v11, v12) -- line 22
    local v13, v14 = pcall(function() -- line 24 | captures: v11, v12
        return v11[v12]
    end)
    if not v13 then
        v14 = v11:GetAttribute(v12)
    end
    return v14
end

v1.getInstanceValue = getInstanceValue

local function getRealInstance(v15) -- line 32
    if v15:GetAttribute("IsAClippedClone") then
        local OriginalInstance = v15:FindFirstChild("OriginalInstance")
        if OriginalInstance then
            return OriginalInstance.Value
        end
    end
end

v1.getRealInstance = getRealInstance

local function getClippedClone(v16) -- line 42
    if v16:GetAttribute("HasAClippedClone") then
        local ClippedClone = v16:FindFirstChild("ClippedClone")
        if ClippedClone then
            return ClippedClone.Value
        end
    end
end

v1.getClippedClone = getClippedClone

function v1.refresh(v17, v18, v19) -- line 52 | captures: v1
    if v19 then
        local v20 = v17:getStateGroup()
        local v21 = v1.getThemeValue(v20, v18.Name, v19) or v1.getInstanceValue(v18, v19)
        v1.apply(v17, v18, v19, v21, true)
    else
        local v22 = v17:getStateGroup()
        if v22 then
            local v23 = {}
            v23[v18.Name] = v18
            for v24, v25 in pairs(v18:GetDescendants()) do
                local Collective = v25:GetAttribute("Collective")
                if Collective then
                    v23[Collective] = v25
                end
                v23[v25.Name] = v25
            end
            for v26, v27 in pairs(v22) do
                local v28, v29, v30 = unpack(v27)
                local v31 = v23[v28]
                if v31 then
                    v1.apply(v17, v31.Name, v29, v30, true)
                end
            end
        end
    end
end

function v1.apply(v32, v33, v34, v35, v36) -- line 84 | captures: v1
    local v37 = {}
    if v32.isDestroyed then
        return
    end
    local v38, v39
    if typeof(v33) == "Instance" then
        v39, v38 = { v33 }, v33.Name
    else
        v39 = v32:getInstanceOrCollective(v33)
        v38 = v33
    end
    local v40 = v32.customBehaviours[v38 .. "-" .. v34]
    for v41, v42 in pairs(v39) do
        local v43 = v1.getClippedClone(v42)
        if v43 then
            table.insert(v39, v43)
        end
    end
    local v44 = v37
    for v45, v46 in pairs(v39) do
        if not (v34 == "Position" and v1.getClippedClone(v46) or v34 == "Size" and v1.getRealInstance(v46) or not v36 and v35 == v1.getInstanceValue(v46, v34)) then
            v44[1] = v35
            if v40 then
                local v47 = v40(v35, v46, v34)
                if v47 ~= nil then
                    v44[1] = v47
                end
            end
            local pcall_2 = pcall
            local v48 = v46
            if not pcall_2(((function(v49)
                    return function() -- line 123 | captures: v49, v34, v48
                        v48[v34] = v49[1]
                    end
                end)(v44))) then
                v46:SetAttribute(v34, v44[1])
            end
            local v50 = v44[1]
            local v51 = {}
            v51[1] = v50
            v44 = v51
        end
    end
end

local function getModifications(v52) -- line 131
    local v53 = v52[1]
    if typeof(v53) == "table" then
        return v52
    end
    return { v52 }
end

v1.getModifications = getModifications

function v1.merge(v54, v55, v56) -- line 140 | captures: v1
    local v57, v58, v59, v60 = table.unpack(v55)
    local v61, v62, v63, v64 = table.unpack(v54)
    _ = v63
    local v65
    if v57 == v61 and v58 == v62 and v1.statesMatch(v60, v64) then
        v54[3] = v59
        if v56 then
            v56(v54)
        end
        v65 = false
    else
        v65 = true
    end
    return not v65
end

function v1.modify(v66, v67, v68) -- line 153 | captures: v1, Utility
    local v69 = v67
    local v70 = v68
    task.spawn(function() -- line 154 | captures: v69, v70, v66, v1, Utility
        local v71 = {}
        local v72 = {}
        local v73 = {}
        v70 = v70 or Utility.generateUID()
        v69 = v1.getModifications(v69)
        local v74 = v71
        local v75 = v72
        local v76 = v73
        for v77, v78 in pairs(v69) do
            local v79, v80, v81, v82 = table.unpack(v78)
            v74[1] = v79
            v75[1] = v80
            v76[1] = v81
            if v82 == nil then
                v1.modify(v66, { v79, v80, v81, "Selected" }, v70)
                v1.modify(v66, { v79, v80, v81, "Viewing" }, v70)
            end
            local v83 = Utility.formatStateName(v82 or "Deselected")
            local v84 = v66:getStateGroup(v83)
            local v85 = {}
            v85[1] = v83;
            (function(v86, v87, v88, v89)
                local function nowSetIt() -- line 171 | captures: v86, v87, v88, v89, v66, v1
                    if v86[1] == v66.activeState then
                        v1.apply(v66, v87[1], v88[1], v89[1])
                    end
                end

                return nowSetIt
            end)(v85, v74, v75, v76)
            local v90 = false
            for v91, v92 in pairs(v84) do
                local merge = v1.merge
                if merge(v92, v78, ((function(v93, v94, v95)
                        return function(v96) -- line 179 | captures: v93, v94, v95, v83, v70, v66, v1
                            v96[5] = v70
                            if v83 == v66.activeState then
                                v1.apply(v66, v93[1], v94[1], v95[1])
                            end
                        end
                    end)(v74, v75, v76))) then
                    v90 = true
                    break
                end
            end
            if not v90 then
                local v97 = {
                    v74[1],
                    v75[1],
                    v76[1],
                    v83,
                    v70
                }
                table.insert(v84, v97)
                if v83 == v66.activeState then
                    v1.apply(v66, v74[1], v75[1], v76[1])
                end
            end
            local v98 = v74[1]
            local v99 = {}
            v99[1] = v98
            local v100 = v75[1]
            local v101 = {}
            v101[1] = v100
            local v102 = v76[1]
            local v103 = {}
            v103[1] = v102
            v74 = v99
            v75 = v101
            v76 = v103
        end
    end)
    return v70
end

function v1.remove(v104, v105) -- line 205 | captures: v1
    for v106, v107 in pairs(v104.appearance) do
        local v108 = #v107
        for v109 = v108, 1, -1 do
            if v107[v109][5] == v105 then
                table.remove(v107, v109)
            end
        end
    end
    v1.rebuild(v104)
end

function v1.removeWith(v110, v111, v112, v113) -- line 219 | captures: v1
    for v114, v115 in pairs(v110.appearance) do
        if v113 == v114 then
            local v116 = #v115
            for v117 = v116, 1, -1 do
                local v118 = v115[v117]
                if v118[1] == v111 and v118[2] == v112 then
                    table.remove(v115, v117)
                end
            end
        end
    end
    v1.rebuild(v110)
end

function v1.change(v119) -- line 236 | captures: v1
    local v120 = v119:getStateGroup()
    for v121, v122 in pairs(v120) do
        local v123, v124, v125 = unpack(v122)
        v1.apply(v119, v123, v124, v125)
    end
end

function v1.set(v126, v127) -- line 244 | captures: v1
    local themesJanitor = v126.themesJanitor
    themesJanitor:clean()
    themesJanitor:add(v126.stateChanged:Connect(function() -- line 248 | captures: v126, v1
        v1.change(v126)
    end))
    local v128
    if typeof(v127) == "Instance" and v127:IsA("ModuleScript") then
        v128 = require(v127)
    else
        v128 = v127
    end
    v126.appliedTheme = v128
    v1.rebuild(v126)
end

local function statesMatch(v129, v130) -- line 261
    if (v129 and string.lower(v129)) == (v130 and string.lower(v130)) then
        return true
    end
    return not v129 or not v130
end

v1.statesMatch = statesMatch

function v1.rebuild(v131) -- line 279 | captures: v1, Utility, Default
    local appliedTheme = v131.appliedTheme
    local v132 = { "Deselected", "Selected", "Viewing" }
    for v133, v134 in pairs(v132) do
        local v135 = {}

        local updateDetails = function(v136, v137) -- updateDetails | line 286 | captures: v135, v1, Utility
            if v136 then
                for v138, v139 in pairs(v136) do
                    if v1.statesMatch(v137, v139[4]) then
                        local v140 = v139[1] .. "-" .. v139[2]
                        local v141 = Utility.copyTable(v139)
                        v141[5] = v139[5]
                        v135[v140] = v141
                    end
                end
            end
        end

        if v134 == "Selected" then
            updateDetails(Default, "Deselected")
        end
        updateDetails(Default, "Empty")
        updateDetails(Default, v134)
        if appliedTheme ~= Default then
            if v134 == "Selected" then
                updateDetails(appliedTheme, "Deselected")
            end
            updateDetails(Default, "Empty")
            updateDetails(appliedTheme, v134)
        end
        local v142 = {}
        local v143 = v131.appearance[v134]
        if v143 then
            for v144, v145 in pairs(v143) do
                local v146 = v145[5]
                if v146 ~= nil then
                    local v147 = {
                        v145[1],
                        v145[2],
                        v145[3],
                        v134,
                        v146
                    }
                    table.insert(v142, v147)
                end
            end
        end
        updateDetails(v142, v134)
        local v148 = {}
        for v149, v150 in pairs(v135) do
            table.insert(v148, v150)
        end
        v131.appearance[v134] = v148
    end
    v1.change(v131)
end

return v1
