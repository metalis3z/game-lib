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
    if v32.isDestroyed then
        return
    end
    local v37, v38
    if typeof(v33) == "Instance" then
        v38, v37 = { v33 }, v33.Name
    else
        v38 = v32:getInstanceOrCollective(v33)
        v37 = v33
    end
    local v39 = v32.customBehaviours[v37 .. "-" .. v34]
    for v40, v41 in pairs(v38) do
        local v42 = v1.getClippedClone(v41)
        if v42 then
            table.insert(v38, v42)
        end
    end
    local v43 = v35
    for v44, v45 in pairs(v38) do
        if v34 == "Position" then
            if v1.getClippedClone(v45) then
            end
        elseif v34 == "Size" then
            if v1.getRealInstance(v45) then
            end
        elseif v36 then
            if v39 then
                local v46 = v39(v43, v45, v34)
                if v46 ~= nil then
                    v43 = v46
                end
            end
            local pcall_2 = pcall
            local v47 = v45
            if not pcall_2(function() -- line 114 | captures: v43, v34, v47
                    v47[v34] = v43
                end) then
                v45:SetAttribute(v34, v43)
            end
        else
            local v48 = v1.getInstanceValue(v45, v34)
            if v43 == v48 then
            end
        end
    end
end

local function getModifications(v49) -- line 128
    local v50 = v49[1]
    if typeof(v50) == "table" then
        return v49
    end
    return { v49 }
end

v1.getModifications = getModifications

function v1.merge(v51, v52, v53) -- line 137 | captures: v1
    local v54, v55, v56, v57 = table.unpack(v52)
    local v58, v59, v60, v61 = table.unpack(v51)
    _ = v60
    local v62
    if v54 == v58 and v55 == v59 and v1.statesMatch(v57, v61) then
        v51[3] = v56
        if v53 then
            v53(v51)
        end
        v62 = false
    else
        v62 = true
    end
    return not v62
end

function v1.modify(v63, v64, v65) -- line 150 | captures: v1, Utility
    local v66 = v64
    local v67 = v65
    task.spawn(function() -- line 151 | captures: v66, v67, v63, v1, Utility
        v67 = v67 or Utility.generateUID()
        v66 = v1.getModifications(v66)
        for v68, v69 in pairs(v66) do
            local v70, v71, v72, v73 = table.unpack(v69)
            u23 = v70
            u24 = v71
            u25 = v72
            if v73 == nil then
                v1.modify(v63, { u23, u24, u25, "Selected" }, v67)
                v1.modify(v63, { u23, u24, u25, "Viewing" }, v67)
            end
            local v74 = Utility.formatStateName(v73 or "Deselected")
            local v75 = v63:getStateGroup(v74)
            local v76 = {}
            v76[1] = v74;
            (function(v77)
                local function nowSetIt() -- line 167 | captures: v77, v63, v1
                    if v77[1] == v63.activeState then
                        v1.apply(v63, u23, u24, u25)
                    end
                end

                return nowSetIt
            end)(v76)
            local v78 = false
            for v79, v80 in pairs(v75) do
                local merge = v1.merge
                if merge(v80, v69, function(v81) -- line 175 | captures: v74, v67, v63, v1
                        v81[5] = v67
                        if v74 == v63.activeState then
                            v1.apply(v63, u23, u24, u25)
                        end
                    end) then
                    v78 = true
                    break
                end
            end
            if not v78 then
                local v82 = { u23, u24, u25, v74, v67 }
                table.insert(v75, v82)
                if v74 == v63.activeState then
                    v1.apply(v63, u23, u24, u25)
                end
            end
        end
    end)
    return v67
end

function v1.remove(v83, v84) -- line 201 | captures: v1
    for v85, v86 in pairs(v83.appearance) do
        local v87 = #v86
        for v88 = v87, 1, -1 do
            if v86[v88][5] == v84 then
                table.remove(v86, v88)
            end
        end
    end
    v1.rebuild(v83)
end

function v1.removeWith(v89, v90, v91, v92) -- line 215 | captures: v1
    for v93, v94 in pairs(v89.appearance) do
        if v92 == v93 then
            local v95 = #v94
            for v96 = v95, 1, -1 do
                local v97 = v94[v96]
                if v97[1] == v90 and v97[2] == v91 then
                    table.remove(v94, v96)
                end
            end
        end
    end
    v1.rebuild(v89)
end

function v1.change(v98) -- line 232 | captures: v1
    local v99 = v98:getStateGroup()
    for v100, v101 in pairs(v99) do
        local v102, v103, v104 = unpack(v101)
        v1.apply(v98, v102, v103, v104)
    end
end

function v1.set(v105, v106) -- line 240 | captures: v1
    local themesJanitor = v105.themesJanitor
    themesJanitor:clean()
    themesJanitor:add(v105.stateChanged:Connect(function() -- line 244 | captures: v105, v1
        v1.change(v105)
    end))
    local v107
    if typeof(v106) == "Instance" and v106:IsA("ModuleScript") then
        v107 = require(v106)
    else
        v107 = v106
    end
    v105.appliedTheme = v107
    v1.rebuild(v105)
end

local function statesMatch(v108, v109) -- line 257
    if (v108 and string.lower(v108)) == (v109 and string.lower(v109)) then
        return true
    end
    return not v108 or not v109
end

v1.statesMatch = statesMatch

function v1.rebuild(v110) -- line 275 | captures: v1, Utility, Default
    local appliedTheme = v110.appliedTheme
    local v111 = { "Deselected", "Selected", "Viewing" }
    for v112, v113 in pairs(v111) do
        local v114 = {}

        local updateDetails = function(v115, v116) -- updateDetails | line 282 | captures: v114, v1, Utility
            if v115 then
                for v117, v118 in pairs(v115) do
                    if v1.statesMatch(v116, v118[4]) then
                        local v119 = v118[1] .. "-" .. v118[2]
                        local v120 = Utility.copyTable(v118)
                        v120[5] = v118[5]
                        v114[v119] = v120
                    end
                end
            end
        end

        if v113 == "Selected" then
            updateDetails(Default, "Deselected")
        end
        updateDetails(Default, "Empty")
        updateDetails(Default, v113)
        if appliedTheme ~= Default then
            if v113 == "Selected" then
                updateDetails(appliedTheme, "Deselected")
            end
            updateDetails(Default, "Empty")
            updateDetails(appliedTheme, v113)
        end
        local v121 = {}
        local v122 = v110.appearance[v113]
        if v122 then
            for v123, v124 in pairs(v122) do
                local v125 = v124[5]
                if v125 ~= nil then
                    local v126 = {
                        v124[1],
                        v124[2],
                        v124[3],
                        v113,
                        v125
                    }
                    table.insert(v121, v126)
                end
            end
        end
        updateDetails(v121, v113)
        local v127 = {}
        for v128, v129 in pairs(v114) do
            table.insert(v127, v129)
        end
        v110.appearance[v113] = v127
    end
    v1.change(v110)
end

return v1
