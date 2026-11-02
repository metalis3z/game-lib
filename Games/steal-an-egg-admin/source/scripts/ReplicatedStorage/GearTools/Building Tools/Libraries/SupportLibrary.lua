-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

SupportLibrary = {}

local function FindTableOccurrences(v1, v2) -- line 3
    local v3 = {}
    for v4, v5 in pairs(v1) do
        if v5 == v2 then
            table.insert(v3, v4)
        end
    end
    return v3
end

SupportLibrary.FindTableOccurrences = FindTableOccurrences

local function FindTableOccurrence(v6, v7) -- line 18
    for v8, v9 in pairs(v6) do
        if v9 == v7 then
            return v8
        end
    end
    return nil
end

SupportLibrary.FindTableOccurrence = FindTableOccurrence

local function IsInTable(v10, v11) -- line 33
    for v12, v13 in pairs(v10) do
        if v13 == v11 then
            return true
        end
    end
    return false
end

SupportLibrary.IsInTable = IsInTable

local function DoTablesMatch(v14, v15) -- line 47
    for v16 in pairs(v14) do
        if v14[v16] ~= v15[v16] then
            return false
        end
    end
    for v17 in pairs(v15) do
        if v15[v17] ~= v14[v17] then
            return false
        end
    end
    return true
end

SupportLibrary.DoTablesMatch = DoTablesMatch

local function Round(v18, v19) -- line 68
    if type(v18) ~= "number" then
        return
    end
    local v20 = 10 ^ (v19 or 0)
    local v21 = v18 * v20 + 0.5
    return math.floor(v21) / v20
end

SupportLibrary.Round = Round

local function CloneTable(v22) -- line 84
    local v23 = {}
    for v24, v25 in pairs(v22) do
        v23[v24] = v25
    end
    return v23
end

SupportLibrary.CloneTable = CloneTable

local function Merge(v26, ...) -- line 98
    local v27 = { ... }
    for v28, v29 in ipairs(v27) do
        for v30, v31 in pairs(v29) do
            v26[v30] = v31
        end
    end
    return v26
end

SupportLibrary.Merge = Merge

local v32 = newproxy(true)

SupportLibrary.Blank = v32

getmetatable(v32).__tostring = function() -- line 117
    return "Symbol(Blank)"
end

local function MergeWithBlanks(v33, ...) -- line 121 | captures: v32
    local v34 = { ... }
    for v35, v36 in ipairs(v34) do
        for v37, v38 in pairs(v36) do
            if v38 == v32 then
                v33[v37] = nil
            else
                v33[v37] = v38
            end
        end
    end
    return v33
end

SupportLibrary.MergeWithBlanks = MergeWithBlanks

local function GetAllDescendants(v39) -- line 141
    local v40 = {}
    for v41, v42 in pairs(v39:GetChildren()) do
        table.insert(v40, v42)
        for v43, v44 in pairs(SupportLibrary.GetAllDescendants(v42)) do
            table.insert(v40, v44)
        end
    end
    return v40
end

SupportLibrary.GetAllDescendants = GetAllDescendants

local function GetDescendantsWhichAreA(v45, v46) -- line 161
    local v47 = {}
    for v48, v49 in pairs(v45:GetDescendants()) do
        if v49:IsA(v46) then
            v47[#v47 + 1] = v49
        end
    end
    return v47
end

SupportLibrary.GetDescendantsWhichAreA = GetDescendantsWhichAreA

local function FilterArray(v50, v51) -- line 178
    local v52 = {}
    for v53, v54 in ipairs(v50) do
        if v51(v54, v53) then
            table.insert(v52, v54)
        end
    end
    return v52
end

SupportLibrary.FilterArray = FilterArray

local function FilterMap(v55, v56) -- line 193
    local v57 = {}
    for v58, v59 in ipairs(v55) do
        if v56(v59, v58) then
            v57[v58] = v59
        end
    end
    return v57
end

SupportLibrary.FilterMap = FilterMap

local function GetDescendantCount(v60) -- line 208
    local v61 = 0
    for v62, v63 in pairs(v60:GetChildren()) do
        v61 = v61 + 1 + SupportLibrary.GetDescendantCount(v63)
    end
    return v61
end

SupportLibrary.GetDescendantCount = GetDescendantCount

local function CloneParts(v64) -- line 226
    local v65 = {}
    for v66, v67 in pairs(v64) do
        v65[v66] = v67:Clone()
    end
    return v65
end

SupportLibrary.CloneParts = CloneParts

local function SplitString(v68, v69) -- line 239
    local v70 = {}
    v68:gsub(("([^%s]+)"):format(v69), function(v71) -- line 246 | captures: v70
        table.insert(v70, v71)
    end)
    return v70
end

SupportLibrary.SplitString = SplitString

local function GetChildOfClass(v72, v73, v74) -- line 253
    if v74 then
        for v75, v76 in pairs(v72:GetChildren()) do
            if v76:IsA(v73) then
                return v76
            end
        end
    else
        for v77, v78 in pairs(v72:GetChildren()) do
            if v78.ClassName == v73 then
                return v78
            end
        end
    end
    return nil
end

SupportLibrary.GetChildOfClass = GetChildOfClass

local function GetChildrenOfClass(v79, v80, v81) -- line 275
    local v82 = {}
    if v81 then
        for v83, v84 in pairs(v79:GetChildren()) do
            if v84:IsA(v80) then
                table.insert(v82, v84)
            end
        end
    else
        for v85, v86 in pairs(v79:GetChildren()) do
            if v86.ClassName == v80 then
                table.insert(v82, v86)
            end
        end
    end
    return v82
end

SupportLibrary.GetChildrenOfClass = GetChildrenOfClass

local function HSVToRGB(v87, v88, v89) -- line 298
    if v88 == 0 then
        return v89
    end
    local v90 = v87 / 60
    local v91 = math.floor(v90)
    local v92 = v87 / 60 - v91
    local v93 = v89 * (1 - v88)
    local v94 = v89 * (1 - v88 * v92)
    local v95 = v89 * (1 - v88 * (1 - v92))
    if v91 == 0 then
        return v89, v95, v93
    end
    if v91 == 1 then
        return v94, v89, v93
    end
    if v91 == 2 then
        return v93, v89, v95
    end
    if v91 == 3 then
        return v93, v94, v89
    end
    if v91 == 4 then
        return v95, v93, v89
    end
    if v91 == 5 then
        return v89, v93, v94
    end
end

SupportLibrary.HSVToRGB = HSVToRGB

local function RGBToHSV(v96, v97, v98) -- line 330
    local v99 = math.min(v96, v97, v98)
    local v100 = math.max(v96, v97, v98)
    local v101 = v100 - v99
    if v100 == 0 then
        return -1, 0, v100
    end
    local v102 = v101 / v100
    local v103
    if v96 == v100 then
        v103 = (v97 - v98) / v101
    elseif v97 == v100 then
        v103 = 2 + (v98 - v96) / v101
    else
        v103 = 4 + (v96 - v97) / v101
    end
    local v104 = v103 * 60
    if v104 < 0 then
        v104 += 360
    end
    return v104, v102, v100
end

SupportLibrary.RGBToHSV = RGBToHSV

local function IdentifyCommonItem(v105) -- line 370
    local v106
    for v107, v108 in pairs(v105) do
        if v107 == 1 then
            v106 = v108
        elseif v108 ~= v106 then
            return nil
        end
    end
    return v106
end

SupportLibrary.IdentifyCommonItem = IdentifyCommonItem

local function IdentifyCommonProperty(v109, v110) -- line 396
    local v111 = {}
    for v112, v113 in pairs(v109) do
        local v114 = v113[v110]
        table.insert(v111, v114)
    end
    return SupportLibrary.IdentifyCommonItem(v111)
end

SupportLibrary.IdentifyCommonProperty = IdentifyCommonProperty

local function GetPartCorners(v115) -- line 411
    local insert = table.insert
    local toWorldSpace = CFrame.new().toWorldSpace
    local new = CFrame.new
    local CFrame_2 = v115.CFrame
    local v116 = v115.Size.x / 2
    local v117 = v115.Size.y / 2
    local v118 = v115.Size.z / 2
    local v119 = {}
    insert(v119, toWorldSpace(CFrame_2, new(v116, v117, v118)))
    insert(v119, toWorldSpace(CFrame_2, new(-v116, v117, v118)))
    insert(v119, toWorldSpace(CFrame_2, new(v116, -v117, v118)))
    insert(v119, toWorldSpace(CFrame_2, new(v116, v117, -v118)))
    insert(v119, toWorldSpace(CFrame_2, new(-v116, v117, -v118)))
    insert(v119, toWorldSpace(CFrame_2, new(-v116, -v117, v118)))
    insert(v119, toWorldSpace(CFrame_2, new(v116, -v117, -v118)))
    insert(v119, toWorldSpace(CFrame_2, new(-v116, -v117, -v118)))
    return v119
end

SupportLibrary.GetPartCorners = GetPartCorners

local function ImportServices() -- line 437
    local v120 = getfenv(2)
    v120.Workspace = Game:GetService("Workspace")
    v120.Players = Game:GetService("Players")
    v120.MarketplaceService = Game:GetService("MarketplaceService")
    v120.ContentProvider = Game:GetService("ContentProvider")
    v120.SoundService = Game:GetService("SoundService")
    v120.UserInputService = Game:GetService("UserInputService")
    v120.SelectionService = Game:GetService("Selection")
    v120.CoreGui = Game:GetService("CoreGui")
    v120.HttpService = Game:GetService("HttpService")
    v120.ChangeHistoryService = Game:GetService("ChangeHistoryService")
    v120.ReplicatedStorage = Game:GetService("ReplicatedStorage")
    v120.GroupService = Game:GetService("GroupService")
    v120.ServerScriptService = Game:GetService("ServerScriptService")
    v120.ServerStorage = Game:GetService("ServerStorage")
    v120.StarterGui = Game:GetService("StarterGui")
    v120.RunService = Game:GetService("RunService")
end

SupportLibrary.ImportServices = ImportServices

local function GetListMembers(v121, v122) -- line 462
    local v123 = {}
    for v124, v125 in ipairs(v121) do
        v123[v124] = v125[v122]
    end
    return v123
end

SupportLibrary.GetListMembers = GetListMembers

local function GetMemberMap(v126, v127) -- line 477
    local v128 = {}
    for v129, v130 in ipairs(v126) do
        v128[v130] = v130[v127]
    end
    return v128
end

SupportLibrary.GetMemberMap = GetMemberMap

local function AddUserInputListener(v131, v132, v133, v134) -- line 492
    local v135 = {}
    local v136 = v135
    if type(v132) == "string" then
        v135[v132] = true
    elseif type(v132) == "table" then
        v136 = SupportLibrary.FlipTable(v132)
    end
    return Game:GetService("UserInputService")["Input" .. v131]:Connect(function(v137, v138) -- line 504 | captures: v136, v133, v134
        if (not v138 or v133) and v136[v137.UserInputType.Name] and not (InputType == Enum.UserInputType.Keyboard and Game:GetService("UserInputService"):GetFocusedTextBox()) then
            v134(v137)
        end
    end)
end

SupportLibrary.AddUserInputListener = AddUserInputListener

local function AddGuiInputListener(v139, v140, v141, v142, v143) -- line 528
    local v144 = {}
    local v145 = v144
    if type(v141) == "string" then
        v144[v141] = true
    elseif type(v141) == "table" then
        v145 = SupportLibrary.FlipTable(v141)
    end
    return v139["Input" .. v140]:Connect(function(v146, v147) -- line 540 | captures: v145, v142, v143
        if (not v147 or v142) and v145[v146.UserInputType.Name] then
            v143(v146)
        end
    end)
end

SupportLibrary.AddGuiInputListener = AddGuiInputListener

local function AreKeysPressed(...) -- line 559
    local KeyCode = SupportLibrary.GetListMembers(Game:GetService("UserInputService"):GetKeysPressed(), "KeyCode")
    local v148 = 0
    for v149, v150 in pairs({ ... }) do
        if SupportLibrary.IsInTable(KeyCode, v150) then
            v148 += 1
        end
    end
    return v148 == #{ ... }
end

SupportLibrary.AreKeysPressed = AreKeysPressed

local function ConcatTable(v151, ...) -- line 582
    local v152 = { ... }
    for v153, v154 in ipairs(v152) do
        for v155, v156 in ipairs(v154) do
            table.insert(v151, v156)
        end
    end
    return v151
end

SupportLibrary.ConcatTable = ConcatTable

local function ClearTable(v157) -- line 598
    for v158 in pairs(v157) do
        v157[v158] = nil
    end
    return v157
end

SupportLibrary.ClearTable = ClearTable

local function Values(v159) -- line 610
    local v160 = {}
    for v161, v162 in pairs(v159) do
        table.insert(v160, v162)
    end
    return v160
end

SupportLibrary.Values = Values

local function Keys(v163) -- line 624
    local v164 = {}
    for v165 in pairs(v163) do
        table.insert(v164, v165)
    end
    return v164
end

SupportLibrary.Keys = Keys

local function Call(v166, ...) -- line 638
    local v167 = { ... }
    return function(...) -- line 641 | captures: v166, v167
        local function v168(...)
            return unpack(...)
        end

        return v166(v168(SupportLibrary.ConcatTable({}, v167, { ... })))
    end
end

SupportLibrary.Call = Call

local function Trim(v169) -- line 648
    return (v169:gsub("^%s*(.-)%s*$", "%1"))
end

SupportLibrary.Trim = Trim

local function ChainCall(...) -- line 653
    local v170 = { ... }
    return function(...) -- line 660 | captures: v170
        local v171 = { ... }
        for v172, v173 in ipairs(v170) do
            v171 = { v173(unpack(v171)) }
        end
        return unpack(v171)
    end
end

SupportLibrary.ChainCall = ChainCall

local function CountKeys(v174) -- line 677
    local v175 = 0
    for v176 in pairs(v174) do
        v175 += 1
    end
    return v175
end

SupportLibrary.CountKeys = CountKeys

local function Slice(v177, v178, v179) -- line 692
    local v180 = {}
    for v181 = v178, v179 do
        local v182 = v177[v181]
        table.insert(v180, v182)
    end
    return v180
end

SupportLibrary.Slice = Slice

local function FlipTable(v183) -- line 707
    local v184 = {}
    for v185, v186 in pairs(v183) do
        v184[v186] = v185
    end
    return v184
end

SupportLibrary.FlipTable = FlipTable

local function ScheduleRecurringTask(v187, v188) -- line 722
    local v189 = {
        Running = true,
        Stop = function(v190) -- Stop | line 732
            v190.Running = false
        end,
        TaskFunction = v187,
        Interval = v188
    }
    coroutine.wrap(function(v191) -- line 742
        while wait(v191.Interval) and v191.Running do
            v191.TaskFunction()
        end
    end)(v189)
    return v189
end

SupportLibrary.ScheduleRecurringTask = ScheduleRecurringTask

local function Loop(v192, v193, ...) -- line 756
    local v194 = { ... }
    local v195 = true

    local function v196() -- line 763 | captures: v195
        v195 = nil
    end

    coroutine.wrap(function() -- line 768 | captures: v195, v192, v193, v194
        while wait(v192) and v195 do
            v193(unpack(v194))
        end
    end)()
    return v196
end

SupportLibrary.Loop = Loop

local function Clamp(v197, v198, v199) -- line 778
    if v198 and v197 < v198 then
        return v198
    end
    if v199 and v199 < v197 then
        return v199
    end
    return v197
end

SupportLibrary.Clamp = Clamp

local function ReverseTable(v200) -- line 793
    local v201 = {}
    for v202, v203 in ipairs(v200) do
        v201[#v200 - v202 + 1] = v203
    end
    return v201
end

SupportLibrary.ReverseTable = ReverseTable

local function CreateConsecutiveCallDeferrer(v204) -- line 808
    local v205

    local function ShouldExecuteCall() -- line 812 | captures: v205, v204
        local v206 = tick()
        v205 = v206
        wait(v204)
        return v205 == v206
    end

    return ShouldExecuteCall
end

SupportLibrary.CreateConsecutiveCallDeferrer = CreateConsecutiveCallDeferrer
return SupportLibrary
