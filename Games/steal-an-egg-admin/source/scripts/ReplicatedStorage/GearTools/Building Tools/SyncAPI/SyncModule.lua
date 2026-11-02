-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

SyncAPI = script.Parent
Tool = SyncAPI.Parent
Player = nil
Security = require(Tool.Core.Security)
RegionModule = require(Tool.Libraries.Region)
Support = require(Tool.Libraries.SupportLibrary)
Serialization = require(Tool.Libraries.SerializationV3)
Support.ImportServices()
Options = {
    DisallowLocked = false,
    StreamingCloneTagLifetime = 2
}
CreatedInstances = {}
LastParents = {}

local v1 = {}

if Tool.Parent:IsA("Plugin") then
    ToolMode = "Plugin"
else
    ToolMode = "Tool"
end
local v2
local v3 = {
    RecolorHandle = function(v4) -- line 45
        Tool.Handle.BrickColor = v4
    end
}

function v3.Clone(v5, v6) -- line 50 | captures: Workspace, v1
    local v7 = type(v5) == "table"
    assert(v7, "Invalid items")
    local v8 = typeof(v6) == "Instance"
    assert(v8, "Invalid parent")
    local v9 = Security.IsLocationAllowed(v6, Player)
    assert(v9, "Permission denied for client")
    if CanModifyItems(v5) then
        local v10 = GetPartsFromSelection(v5)
        if Security.ArePartsViolatingAreas(v10, Player, false) then
            return {}
        end
        local v11 = {}
        local v12
        if not (Player and Workspace.StreamingEnabled) then
        else
            v12 = math.random(-1073741824, 1073741824)
        end
        for v13, v14 in pairs(v5) do
            local v15 = v14:Clone()
            if v12 then
                v15:SetAttribute("BTStreamingCloneID", v12)
                v15:AddTag("BTStreamingClone")
                v1[v15] = true
            end
            v15.Parent = v6
            table.insert(v11, v15)
            CreatedInstances[v14] = v14
        end
        if v12 then
            task.delay(Options.StreamingCloneTagLifetime, function() -- line 95 | captures: v11, v1
                for v16, v17 in v11 do
                    v17:RemoveTag("BTStreamingClone")
                    v17:SetAttribute("BTStreamingCloneID", nil)
                    v1[v17] = nil
                end
            end)
            return nil, v12, #v11
        end
        return v11
    end
    return {}
end

function v3.CreatePart(v18, v19, v20) -- line 109 | captures: Workspace
    local v21 = typeof(v20) == "Instance"
    assert(v21, "Invalid parent")
    local v22 = Security.IsLocationAllowed(v20, Player)
    assert(v22, "Permission denied for client")
    local v23 = CreatePart(v18)
    v23.CFrame = v19
    local v24 = Security.GetPermissions(Security.GetSelectionAreas({ v23 }), Player)
    if Security.ArePartsViolatingAreas({ v23 }, Player, false, v24) then
        return
    end
    if Player and Workspace.StreamingEnabled then
        v23.Parent = Player
    end
    v23.Parent = v20
    CreatedInstances[v23] = v23
    return v23
end

function v3.CreateGroup(v25, v26, v27) -- line 146
    local v28 = ({
            Model = true,
            Folder = true
        })[v25]
    assert(v28, "Invalid group type")
    local v29 = typeof(v26) == "Instance"
    assert(v29, "Invalid parent")
    local v30 = Security.IsLocationAllowed(v26, Player)
    assert(v30, "Permission denied for client")
    if not CanModifyItems(v27) then
        return
    end
    local v31 = GetPartsFromSelection(v27)
    local v32 = Security.GetPermissions(Security.GetSelectionAreas(v31), Player)
    if Security.ArePartsViolatingAreas(v31, Player, true, v32) then
        return
    end
    local v33 = Instance.new(v25)
    for v34, v35 in pairs(v27) do
        v35.Parent = v33
    end
    v33.Parent = v26
    if v25 == "Model" then
        v33:MakeJoints()
    elseif v25 == "Folder" then
        local BasePart = Support.GetDescendantsWhichAreA(v33, "BasePart")
        for v36, v37 in pairs(BasePart) do
            v37:MakeJoints()
        end
    end
    return v33
end

function v3.Ungroup(v38) -- line 197
    local v39 = type(v38) == "table"
    assert(v39, "Invalid groups")
    if not CanModifyItems(v38) then
        return
    end
    local v40 = GetPartsFromSelection(v38)
    local v41 = Security.GetPermissions(Security.GetSelectionAreas(v40), Player)
    if Security.ArePartsViolatingAreas(v40, Player, true, v41) then
        return
    end
    local v42 = {}
    for v43, v44 in ipairs(v38) do
        local v45 = typeof(v44) == "Instance"
        assert(v45, "Invalid group")
        local v46 = {}
        v42[v43] = v46
        local Parent = v44.Parent
        for v47, v48 in pairs(v44:GetChildren()) do
            LastParents[v48] = v44
            v46[#v46 + 1] = v48
            v48.Parent = Parent
            if v48:IsA("BasePart") then
                v48:MakeJoints()
            elseif v48:IsA("Folder") then
                local BasePart = Support.GetDescendantsWhichAreA(v48, "BasePart")
                for v49, v50 in pairs(BasePart) do
                    v50:MakeJoints()
                end
            end
        end
        LastParents[v44] = v44.Parent
        CreatedInstances[v44] = v44
        v44.Parent = nil
    end
    return v42
end

function v3.SetParent(v51, v52) -- line 251
    local v53 = type(v51) == "table"
    assert(v53, "Invalid items")
    local v54 = if type(v52) == "table" then true else typeof(v52) == "Instance"
    assert(v54, "Invalid parent")
    if not CanModifyItems(v51) then
        return
    end
    local v55 = GetPartsFromSelection(v51)
    local v56 = Security.GetPermissions(Security.GetSelectionAreas(v55), Player)
    if not Security.ArePartsViolatingAreas(v55, Player, true, v56) then
        if type(v52) == "table" then
            for v57, v58 in pairs(v51) do
                local v59 = v52[v57]
                local v60 = Security.IsLocationAllowed(v59, Player)
                assert(v60, "Permission denied for client")
                v58.Parent = v59
                if v58:IsA("BasePart") then
                    v58:MakeJoints()
                elseif v58:IsA("Folder") then
                    local BasePart = Support.GetDescendantsWhichAreA(v58, "BasePart")
                    for v61, v62 in pairs(BasePart) do
                        v62:MakeJoints()
                    end
                end
            end
        elseif typeof(v52) == "Instance" then
            local v63 = Security.IsLocationAllowed(v52, Player)
            assert(v63, "Permission denied for client")
            for v64, v65 in pairs(v51) do
                v65.Parent = v52
                if v65:IsA("BasePart") then
                    v65:MakeJoints()
                elseif v65:IsA("Folder") then
                    local BasePart = Support.GetDescendantsWhichAreA(v65, "BasePart")
                    for v66, v67 in pairs(BasePart) do
                        v67:MakeJoints()
                    end
                end
            end
        end
    end
end

function v3.SetName(v68, v69) -- line 309
    local v70 = type(v68) == "table"
    assert(v70, "Invalid items")
    local v71 = if type(v69) == "table" then true else type(v69) == "string"
    assert(v71, "Invalid name")
    if not CanModifyItems(v68) then
        return
    end
    local v72 = GetPartsFromSelection(v68)
    local v73 = Security.GetPermissions(Security.GetSelectionAreas(v72), Player)
    if not Security.ArePartsViolatingAreas(v72, Player, true, v73) then
        if type(v69) == "table" then
            for v74, v75 in pairs(v68) do
                v75.Name = v69[v74]
            end
        elseif type(v69) == "string" then
            for v76, v77 in pairs(v68) do
                v77.Name = v69
            end
        end
    end
end

function v3.Remove(v78) -- line 343
    local v79 = {}
    for v80, v81 in pairs(v78) do
        if v81 then
            if v81:IsA("BasePart") then
                table.insert(v79, v81)
            elseif v81:IsA("Smoke") or v81:IsA("Fire") or v81:IsA("Sparkles") or v81:IsA("DataModelMesh") or v81:IsA("Decal") or v81:IsA("Texture") or v81:IsA("Light") then
                local Parent = v81.Parent
                table.insert(v79, Parent)
            elseif v81:IsA("Model") or v81:IsA("Folder") then
                Support.ConcatTable(v79, Support.GetDescendantsWhichAreA(v81, "BasePart"))
            end
        end
    end
    if CanModifyItems(v78) and not Security.ArePartsViolatingAreas(v79, Player, true) then
        for v82, v83 in pairs(v78) do
            LastParents[v83] = v83.Parent
            CreatedInstances[v83] = v83
            v83.Parent = nil
        end
    end
end

function v3.UndoRemove(v84) -- line 395
    local v85 = {}
    for v86, v87 in pairs(v84) do
        if v87 and LastParents[v87] then
            if v87:IsA("BasePart") then
                table.insert(v85, v87)
            elseif v87:IsA("Smoke") or v87:IsA("Fire") or v87:IsA("Sparkles") or v87:IsA("DataModelMesh") or v87:IsA("Decal") or v87:IsA("Texture") or v87:IsA("Light") then
                local Parent = v87.Parent
                table.insert(v85, Parent)
            elseif v87:IsA("Model") or v87:IsA("Folder") then
                Support.ConcatTable(v85, Support.GetDescendantsWhichAreA(v87, "BasePart"))
            end
        end
    end
    if CanModifyItems(v84) and not Security.ArePartsViolatingAreas(v85, Player, false) then
        for v88, v89 in pairs(v84) do
            local v90 = LastParents[v89]
            LastParents[v89] = v89.Parent
            CreatedInstances[v89] = v89
            v89.Parent = v90
            if v89:IsA("BasePart") then
                v89:MakeJoints()
            else
                local BasePart = Support.GetDescendantsWhichAreA(v89, "BasePart")
                for v91, v92 in pairs(BasePart) do
                    v92:MakeJoints()
                end
            end
        end
    end
end

function v3.SyncMove(v93) -- line 458
    local v94 = {}
    local v95 = {}
    for v96, v97 in pairs(v93) do
        if v97.Part then
            local Part = v97.Part
            table.insert(v94, Part)
        elseif v97.Model then
            local Model = v97.Model
            table.insert(v95, Model)
        end
    end
    if CanModifyItems(v94) and CanModifyItems(v95) then
        local v98 = Security.GetPermissions(Security.GetSelectionAreas(v94), Player)
        if not Security.ArePartsViolatingAreas(v94, Player, true, v98) then
            local v99 = {}
            local v100 = {}
            for v101, v102 in pairs(v93) do
                if v102.Part then
                    v102.InitialState = {
                        Anchored = v102.Part.Anchored,
                        CFrame = v102.Part.CFrame
                    }
                    v99[v102.Part] = v102
                elseif v102.Model then
                    v100[v102.Model] = v102.Pivot
                end
            end
            for v103, v104 in pairs(v99) do
                v104.Joints = PreserveJoints(v103, v99)
            end
            for v105, v106 in pairs(v99) do
                v105.Anchored = true
                v105:BreakJoints()
                v105.Velocity = Vector3.new()
                v105.RotVelocity = Vector3.new()
                v105.CFrame = v106.CFrame
            end
            for v107, v108 in pairs(v100) do
                v107.WorldPivot = v108
            end
            if Security.ArePartsViolatingAreas(v94, Player, false, v98) then
                for v109, v110 in pairs(v99) do
                    v109.CFrame = v110.InitialState.CFrame
                end
            end
            for v111, v112 in pairs(v99) do
                v111:MakeJoints()
                RestoreJoints(v112.Joints)
                v111.Anchored = v112.InitialState.Anchored
            end
        end
    end
end

function v3.SyncResize(v113) -- line 541
    local v114 = {}
    for v115, v116 in pairs(v113) do
        if v116.Part then
            local Part = v116.Part
            table.insert(v114, Part)
        end
    end
    if CanModifyItems(v114) then
        local v117 = Security.GetPermissions(Security.GetSelectionAreas(v114), Player)
        if not Security.ArePartsViolatingAreas(v114, Player, true, v117) then
            local v118 = {}
            for v119, v120 in pairs(v113) do
                if v120.Part then
                    v120.InitialState = {
                        Anchored = v120.Part.Anchored,
                        Size = v120.Part.Size,
                        CFrame = v120.Part.CFrame
                    }
                    v118[v120.Part] = v120
                end
            end
            for v121, v122 in pairs(v118) do
                v121.Anchored = true
                v121:BreakJoints()
                v121.Velocity = Vector3.new()
                v121.RotVelocity = Vector3.new()
                v121.Size = v122.Size
                v121.CFrame = v122.CFrame
            end
            if Security.ArePartsViolatingAreas(v114, Player, false, v117) then
                for v123, v124 in pairs(v118) do
                    v123.Size = v124.InitialState.Size
                    v123.CFrame = v124.InitialState.CFrame
                end
            end
            for v125, v126 in pairs(v118) do
                v125:MakeJoints()
                v125.Anchored = v126.InitialState.Anchored
            end
        end
    end
end

function v3.SyncRotate(v127) -- line 608
    local v128 = {}
    local v129 = {}
    for v130, v131 in pairs(v127) do
        if v131.Part then
            local Part = v131.Part
            table.insert(v128, Part)
        elseif v131.Model then
            local Model = v131.Model
            table.insert(v129, Model)
        end
    end
    if CanModifyItems(v128) and CanModifyItems(v129) then
        local v132 = Security.GetPermissions(Security.GetSelectionAreas(v128), Player)
        if not Security.ArePartsViolatingAreas(v128, Player, true, v132) then
            local v133 = {}
            local v134 = {}
            for v135, v136 in pairs(v127) do
                if v136.Part then
                    v136.InitialState = {
                        Anchored = v136.Part.Anchored,
                        CFrame = v136.Part.CFrame
                    }
                    v133[v136.Part] = v136
                elseif v136.Model then
                    v134[v136.Model] = v136.Pivot
                end
            end
            for v137, v138 in pairs(v133) do
                v138.Joints = PreserveJoints(v137, v133)
            end
            for v139, v140 in pairs(v133) do
                v139.Anchored = true
                v139:BreakJoints()
                v139.Velocity = Vector3.new()
                v139.RotVelocity = Vector3.new()
                v139.CFrame = v140.CFrame
            end
            for v141, v142 in pairs(v134) do
                v141.WorldPivot = v142
            end
            if Security.ArePartsViolatingAreas(v128, Player, false, v132) then
                for v143, v144 in pairs(v133) do
                    v143.CFrame = v144.InitialState.CFrame
                end
            end
            for v145, v146 in pairs(v133) do
                v145:MakeJoints()
                RestoreJoints(v146.Joints)
                v145.Anchored = v146.InitialState.Anchored
            end
        end
    end
end

function v3.SyncColor(v147) -- line 691
    local v148 = {}
    for v149, v150 in pairs(v147) do
        if v150.Part then
            local Part = v150.Part
            table.insert(v148, Part)
        end
    end
    if CanModifyItems(v148) then
        local v151 = Security.GetPermissions(Security.GetSelectionAreas(v148), Player)
        if not Security.ArePartsViolatingAreas(v148, Player, true, v151) then
            local v152 = {}
            for v153, v154 in pairs(v147) do
                if v154.Part then
                    v152[v154.Part] = v154
                end
            end
            for v155, v156 in pairs(v152) do
                v155.Color = v156.Color
                if v155.ClassName == "UnionOperation" then
                    v155.UsePartColor = v156.UnionColoring
                end
            end
        end
    end
end

function v3.SyncSurface(v157) -- line 738
    local v158 = {}
    for v159, v160 in pairs(v157) do
        if v160.Part then
            local Part = v160.Part
            local v161
            if typeof(Part) == "Instance" then
                v161 = v160.Part:IsA("BasePart")
            else
                v161 = false
            end
            assert(v161, "Invalid part")
            local Surfaces = v160.Surfaces
            local v162 = typeof(Surfaces) == "table"
            assert(v162, "Invalid surface dictionary")
            for v163, v164 in v160.Surfaces do
                local v165 = typeof(v163) == "string"
                assert(v165, "Invalid surface")
                local v166 = Enum.NormalId[v163]
                local v167 = typeof(v166) == "EnumItem"
                assert(v167, "Invalid surface")
                local v168 = typeof(v164) == "EnumItem"
                assert(v168, "Invalid surface type")
                local v169 = v164.EnumType == Enum.SurfaceType
                assert(v169, "Invalid surface type")
            end
            local Part_2 = v160.Part
            table.insert(v158, Part_2)
        end
    end
    if CanModifyItems(v158) then
        local v170 = Security.GetPermissions(Security.GetSelectionAreas(v158), Player)
        if not Security.ArePartsViolatingAreas(v158, Player, true, v170) then
            local v171 = {}
            for v172, v173 in pairs(v157) do
                if v173.Part then
                    v171[v173.Part] = v173
                end
            end
            for v174, v175 in pairs(v171) do
                for v176, v177 in pairs(v175.Surfaces) do
                    v174[v176 .. "Surface"] = v177
                end
            end
        end
    end
end

function v3.CreateLights(v178) -- line 793
    local v179 = {}
    for v180, v181 in pairs(v178) do
        if v181.Part then
            local Part = v181.Part
            table.insert(v179, Part)
        end
    end
    if not CanModifyItems(v179) then
        return
    end
    local v182 = Security.GetPermissions(Security.GetSelectionAreas(v179), Player)
    if Security.ArePartsViolatingAreas(v179, Player, true, v182) then
        return
    end
    local v183 = {}
    for v184, v185 in pairs(v178) do
        if v185.Part then
            v183[v185.Part] = v185
        end
    end
    local v186 = {
        PointLight = true,
        SurfaceLight = true,
        SpotLight = true
    }
    local v187 = {}
    for v188, v189 in pairs(v183) do
        if v186[v189.LightType] then
            local v190 = Instance.new(v189.LightType, v188)
            table.insert(v187, v190)
            CreatedInstances[v190] = v190
        end
    end
    return v187
end

function v3.SyncLighting(v191) -- line 853
    local v192 = {}
    for v193, v194 in pairs(v191) do
        if v194.Part then
            local Part = v194.Part
            table.insert(v192, Part)
        end
    end
    if CanModifyItems(v192) then
        local v195 = Security.GetPermissions(Security.GetSelectionAreas(v192), Player)
        if not Security.ArePartsViolatingAreas(v192, Player, true, v195) then
            local v196 = {}
            for v197, v198 in pairs(v191) do
                if v198.Part then
                    v196[v198.Part] = v198
                end
            end
            local v199 = {
                PointLight = true,
                SurfaceLight = true,
                SpotLight = true
            }
            for v200, v201 in pairs(v196) do
                if v199[v201.LightType] then
                    local v202 = Support.GetChildOfClass(v200, v201.LightType)
                    if v202 then
                        if v201.Range ~= nil then
                            v202.Range = v201.Range
                        end
                        if v201.Brightness ~= nil then
                            v202.Brightness = v201.Brightness
                        end
                        if v201.Color ~= nil then
                            v202.Color = v201.Color
                        end
                        if v201.Shadows ~= nil then
                            v202.Shadows = v201.Shadows
                        end
                        if v201.Face ~= nil then
                            v202.Face = v201.Face
                        end
                        if v201.Angle ~= nil then
                            v202.Angle = v201.Angle
                        end
                    end
                end
            end
        end
    end
end

function v3.CreateDecorations(v203) -- line 928
    local v204 = {}
    for v205, v206 in pairs(v203) do
        if v206.Part then
            local Part = v206.Part
            table.insert(v204, Part)
        end
    end
    if not CanModifyItems(v204) then
        return
    end
    local v207 = Security.GetPermissions(Security.GetSelectionAreas(v204), Player)
    if Security.ArePartsViolatingAreas(v204, Player, true, v207) then
        return
    end
    local v208 = {}
    for v209, v210 in pairs(v203) do
        if v210.Part then
            v208[v210.Part] = v210
        end
    end
    local v211 = {
        Smoke = true,
        Fire = true,
        Sparkles = true
    }
    local v212 = {}
    for v213, v214 in pairs(v208) do
        if v211[v214.DecorationType] then
            local v215 = Instance.new(v214.DecorationType, v213)
            table.insert(v212, v215)
            CreatedInstances[v215] = v215
        end
    end
    return v212
end

function v3.SyncDecorate(v216) -- line 988
    local v217 = {}
    for v218, v219 in pairs(v216) do
        if v219.Part then
            local Part = v219.Part
            table.insert(v217, Part)
        end
    end
    if CanModifyItems(v217) then
        local v220 = Security.GetPermissions(Security.GetSelectionAreas(v217), Player)
        if not Security.ArePartsViolatingAreas(v217, Player, true, v220) then
            local v221 = {}
            for v222, v223 in pairs(v216) do
                if v223.Part then
                    v221[v223.Part] = v223
                end
            end
            local v224 = {
                Smoke = true,
                Fire = true,
                Sparkles = true
            }
            for v225, v226 in pairs(v221) do
                if v224[v226.DecorationType] then
                    local v227 = Support.GetChildOfClass(v225, v226.DecorationType)
                    if v227 then
                        if v226.Color ~= nil then
                            v227.Color = v226.Color
                        end
                        if v226.Opacity ~= nil then
                            v227.Opacity = v226.Opacity
                        end
                        if v226.RiseVelocity ~= nil then
                            v227.RiseVelocity = v226.RiseVelocity
                        end
                        if v226.Size ~= nil then
                            v227.Size = v226.Size
                        end
                        if v226.Heat ~= nil then
                            v227.Heat = v226.Heat
                        end
                        if v226.SecondaryColor ~= nil then
                            v227.SecondaryColor = v226.SecondaryColor
                        end
                        if v226.SparkleColor ~= nil then
                            v227.SparkleColor = v226.SparkleColor
                        end
                    end
                end
            end
        end
    end
end

function v3.CreateMeshes(v228) -- line 1066
    local v229 = {}
    for v230, v231 in pairs(v228) do
        if v231.Part then
            local Part = v231.Part
            table.insert(v229, Part)
        end
    end
    if not CanModifyItems(v229) then
        return
    end
    local v232 = Security.GetPermissions(Security.GetSelectionAreas(v229), Player)
    if Security.ArePartsViolatingAreas(v229, Player, true, v232) then
        return
    end
    local v233 = {}
    for v234, v235 in pairs(v228) do
        if v235.Part then
            v233[v235.Part] = v235
        end
    end
    local v236 = {}
    for v237, v238 in pairs(v233) do
        local v239 = Instance.new("SpecialMesh", v237)
        table.insert(v236, v239)
        CreatedInstances[v239] = v239
    end
    return v236
end

function v3.SyncMesh(v240) -- line 1118
    local v241 = {}
    for v242, v243 in pairs(v240) do
        if v243.Part then
            local Part = v243.Part
            table.insert(v241, Part)
        end
    end
    if CanModifyItems(v241) then
        local v244 = Security.GetPermissions(Security.GetSelectionAreas(v241), Player)
        if not Security.ArePartsViolatingAreas(v241, Player, true, v244) then
            local v245 = {}
            for v246, v247 in pairs(v240) do
                if v247.Part then
                    v245[v247.Part] = v247
                end
            end
            for v248, v249 in pairs(v245) do
                local SpecialMesh = Support.GetChildOfClass(v248, "SpecialMesh")
                if SpecialMesh then
                    if v249.VertexColor ~= nil then
                        SpecialMesh.VertexColor = v249.VertexColor
                    end
                    if v249.MeshType ~= nil then
                        SpecialMesh.MeshType = v249.MeshType
                    end
                    if v249.Scale ~= nil then
                        SpecialMesh.Scale = v249.Scale
                    end
                    if v249.Offset ~= nil then
                        SpecialMesh.Offset = v249.Offset
                    end
                    if v249.MeshId ~= nil then
                        SpecialMesh.MeshId = v249.MeshId
                    end
                    if v249.TextureId ~= nil then
                        SpecialMesh.TextureId = v249.TextureId
                    end
                end
            end
        end
    end
end

function v3.CreateTextures(v250) -- line 1185
    local v251 = {}
    for v252, v253 in pairs(v250) do
        if v253.Part then
            local Part = v253.Part
            table.insert(v251, Part)
        end
    end
    if not CanModifyItems(v251) then
        return
    end
    local v254 = Security.GetPermissions(Security.GetSelectionAreas(v251), Player)
    if Security.ArePartsViolatingAreas(v251, Player, true, v254) then
        return
    end
    local v255 = {}
    for v256, v257 in pairs(v250) do
        if v257.Part then
            v255[v257.Part] = v257
        end
    end
    local v258 = {
        Texture = true,
        Decal = true
    }
    local v259 = {}
    for v260, v261 in pairs(v255) do
        if v258[v261.TextureType] then
            local v262 = Instance.new(v261.TextureType, v260)
            v262.Face = v261.Face
            table.insert(v259, v262)
            CreatedInstances[v262] = v262
        end
    end
    return v259
end

function v3.SyncTexture(v263) -- line 1246
    local v264 = {}
    for v265, v266 in pairs(v263) do
        if v266.Part then
            local Part = v266.Part
            table.insert(v264, Part)
        end
    end
    if CanModifyItems(v264) then
        local v267 = Security.GetPermissions(Security.GetSelectionAreas(v264), Player)
        if not Security.ArePartsViolatingAreas(v264, Player, true, v267) then
            local v268 = {}
            for v269, v270 in pairs(v263) do
                if v270.Part then
                    v268[v270.Part] = v270
                end
            end
            local v271 = {
                Texture = true,
                Decal = true
            }
            for v272, v273 in pairs(v268) do
                if v271[v273.TextureType] then
                    for v274, v275 in pairs(v272:GetChildren()) do
                        if v275.ClassName == v273.TextureType and v275.Face == v273.Face then
                            if v273.Texture ~= nil then
                                v275.Texture = v273.Texture
                            end
                            if v273.Transparency ~= nil then
                                v275.Transparency = v273.Transparency
                            end
                            if v273.StudsPerTileU ~= nil then
                                v275.StudsPerTileU = v273.StudsPerTileU
                            end
                            if v273.StudsPerTileV ~= nil then
                                v275.StudsPerTileV = v273.StudsPerTileV
                            end
                        end
                    end
                end
            end
        end
    end
end

function v3.SyncAnchor(v276) -- line 1314
    local v277 = {}
    for v278, v279 in pairs(v276) do
        if v279.Part then
            local Part = v279.Part
            table.insert(v277, Part)
        end
    end
    if CanModifyItems(v277) then
        local v280 = Security.GetPermissions(Security.GetSelectionAreas(v277), Player)
        if not Security.ArePartsViolatingAreas(v277, Player, true, v280) then
            local v281 = {}
            for v282, v283 in pairs(v276) do
                if v283.Part then
                    v281[v283.Part] = v283
                end
            end
            for v284, v285 in pairs(v281) do
                v284.Anchored = v285.Anchored
            end
        end
    end
end

function v3.SyncCollision(v286) -- line 1353
    local v287 = {}
    for v288, v289 in pairs(v286) do
        if v289.Part then
            local Part = v289.Part
            table.insert(v287, Part)
        end
    end
    if CanModifyItems(v287) then
        local v290 = Security.GetPermissions(Security.GetSelectionAreas(v287), Player)
        if not Security.ArePartsViolatingAreas(v287, Player, true, v290) then
            local v291 = {}
            for v292, v293 in pairs(v286) do
                if v293.Part then
                    v291[v293.Part] = v293
                end
            end
            for v294, v295 in pairs(v291) do
                v294.CanCollide = v295.CanCollide
            end
        end
    end
end

function v3.SyncMaterial(v296) -- line 1392
    local v297 = {}
    for v298, v299 in pairs(v296) do
        if v299.Part then
            local Part = v299.Part
            table.insert(v297, Part)
        end
    end
    if CanModifyItems(v297) then
        local v300 = Security.GetPermissions(Security.GetSelectionAreas(v297), Player)
        if not Security.ArePartsViolatingAreas(v297, Player, true, v300) then
            local v301 = {}
            for v302, v303 in pairs(v296) do
                if v303.Part then
                    v301[v303.Part] = v303
                end
            end
            for v304, v305 in pairs(v301) do
                if v305.Material ~= nil then
                    v304.Material = v305.Material
                end
                if v305.Transparency ~= nil then
                    v304.Transparency = v305.Transparency
                end
                if v305.Reflectance ~= nil then
                    v304.Reflectance = v305.Reflectance
                end
            end
        end
    end
end

function v3.CreateWelds(v306, v307) -- line 1439
    if not CanModifyItems(v306) then
        return
    end
    local v308 = Security.GetPermissions(Security.GetSelectionAreas(v306), Player)
    if Security.ArePartsViolatingAreas(v306, Player, true, v308) then
        return
    end
    local v309 = {}
    for v310, v311 in pairs(v306) do
        if v311 ~= v307 then
            local v312 = v311.CFrame:toObjectSpace(v307.CFrame)
            local Weld = Instance.new("Weld")
            Weld.Name = "BTWeld"
            Weld.Part0 = v307
            Weld.Part1 = v311
            Weld.C1 = v312
            Weld.Archivable = true
            Weld.Parent = v307
            CreatedInstances[Weld] = Weld
            table.insert(v309, Weld)
        end
    end
    return v309
end

function v3.RemoveWelds(v313) -- line 1487
    local v314 = {}
    for v315, v316 in pairs(v313) do
        if v316.ClassName == "Weld" then
            local Part0 = v316.Part0
            table.insert(v314, Part0)
            local Part1 = v316.Part1
            table.insert(v314, Part1)
        else
            return
        end
    end
    if not CanModifyItems(v314) then
        return
    end
    local v317 = Security.GetPermissions(Security.GetSelectionAreas(v314), Player)
    local v318 = 0
    for v319, v320 in pairs(v313) do
        local v321 = Security.ArePartsViolatingAreas({ v320.Part0 }, Player, true, v317)
        local v322 = Security.ArePartsViolatingAreas({ v320.Part1 }, Player, true, v317)
        if not (v321 and v322) then
            CreatedInstances[v320] = v320
            LastParents[v320] = v320.Parent
            v318 += 1
            v320.Parent = nil
        end
    end
    return v318
end

function v3.UndoRemovedWelds(v323) -- line 1542
    local v324 = {}
    for v325, v326 in pairs(v323) do
        if v326.ClassName == "Weld" and LastParents[v326] then
            local Part0 = v326.Part0
            table.insert(v324, Part0)
            local Part1 = v326.Part1
            table.insert(v324, Part1)
        else
            return
        end
    end
    if CanModifyItems(v324) then
        local v327 = Security.GetPermissions(Security.GetSelectionAreas(v324), Player)
        for v328, v329 in pairs(v323) do
            local v330 = Security.ArePartsViolatingAreas({ v329.Part0 }, Player, false, v327)
            local v331 = Security.ArePartsViolatingAreas({ v329.Part0 }, Player, false, v327)
            if v330 then
                if not v331 then
                    local v332 = LastParents[v329]
                    LastParents[v329] = v329.Parent
                    CreatedInstances[v329] = v329
                    v329.Parent = v332
                end
            else
                local v333 = LastParents[v329]
                LastParents[v329] = v329.Parent
                CreatedInstances[v329] = v329
                v329.Parent = v333
            end
        end
    end
end

function v3.Export(v334) -- line 1600 | captures: HttpService, RunService
    if not RunService:IsClient() or RunService:IsStudio() then
        local v335 = type(v334) == "table"
        assert(v335, "Invalid item table")
        if #v334 ~= 0 and CanModifyItems(v334) then
            local v336 = Security.GetPermissions(Security.GetSelectionAreas(v334), Player)
            if not Security.ArePartsViolatingAreas(v334, Player, true, v336) then
                local v337 = Support.CloneTable(v334)
                for v338, v339 in pairs(v334) do
                    Support.ConcatTable(v337, v339:GetDescendants())
                end
                local v340 = {
                    version = 3,
                    data = Serialization.SerializeModel(v337)
                }
                v340.userId = Player and Player.UserId
                local v341 = HttpService:JSONDecode(HttpService:PostAsync("http://f3xteam.com/bt/export", HttpService:JSONEncode(v340), Enum.HttpContentType.ApplicationJson, true))
                if v341.success then
                    return v341.id
                end
                error("Export failed due to server-side error", 2)
            end
        end
    else
        return SyncAPI.ServerEndpoint:InvokeServer("Export", v334)
    end
end

function v3.IsHttpServiceEnabled() -- line 1657 | captures: v2, HttpService, RunService
    if RunService:IsClient() then
        return SyncAPI.ServerEndpoint:InvokeServer("IsHttpServiceEnabled")
    end
    if v2 == nil then
        local v342, v343 = pcall(function() -- line 1671 | captures: HttpService
            return HttpService:GetAsync("https://google.com")
        end)
        if v342 then
            v2 = true
        elseif v343:match("Http requests are not enabled") then
            v2 = false
        end
        return v2 or false
    end
    return v2
end

function v3.ExtractMeshFromAsset(v344) -- line 1685 | captures: HttpService, RunService
    if not RunService:IsClient() or RunService:IsStudio() then
        local v345 = type(v344) == "number"
        assert(v345, "Invalid asset ID")
        return HttpService:JSONDecode(HttpService:GetAsync("http://f3xteam.com/bt/getFirstMeshData/" .. v344))
    end
    return SyncAPI.ServerEndpoint:InvokeServer("ExtractMeshFromAsset", v344)
end

function v3.ExtractImageFromDecal(v346) -- line 1703 | captures: HttpService, RunService
    if not RunService:IsClient() or RunService:IsStudio() then
        return HttpService:GetAsync("http://f3xteam.com/bt/getDecalImageID/" .. v346)
    end
    return SyncAPI.ServerEndpoint:InvokeServer("ExtractImageFromDecal", v346)
end

function v3.SetMouseLockEnabled(v347) -- line 1716 | captures: RunService
    if not RunService:IsClient() or RunService:IsStudio() then
        Player.DevEnableMouseLock = v347
    else
        return SyncAPI.ServerEndpoint:InvokeServer("SetMouseLockEnabled", v347)
    end
end

function v3.SetLocked(v348, v349) -- line 1729
    local v350 = type(v348) == "table"
    assert(v350, "Invalid items")
    local v351 = if type(v349) == "table" then true else type(v349) == "boolean"
    assert(v351, "Invalid lock state")
    if not CanModifyItems(v348) then
        return
    end
    local v352 = GetPartsFromSelection(v348)
    local v353 = Security.GetPermissions(Security.GetSelectionAreas(v352), Player)
    if not Security.ArePartsViolatingAreas(v352, Player, true, v353) then
        if type(v349) == "table" then
            for v354, v355 in pairs(v348) do
                v355.Locked = v349[v354]
            end
        elseif type(v349) == "boolean" then
            for v356, v357 in pairs(v348) do
                v357.Locked = v349
            end
        end
    end
end

Actions = v3

function CanModifyItems(v358) -- line 1766
    for v359, v360 in pairs(v358) do
        local v361 = Security.IsItemAllowed(v360, Player)
        local v362 = LastParents[v360]
        if not v361 and not v362 then
            return false
        end
        if Options.DisallowLocked and v360:IsA("BasePart") and v360.Locked then
            return false
        end
    end
    return true
end

function GetPartsFromSelection(v363) -- line 1791
    local v364 = {}
    for v365, v366 in pairs(v363) do
        if v366:IsA("BasePart") then
            v364[#v364 + 1] = v366
        else
            for v367, v368 in pairs(v366:GetDescendants()) do
                if v368:IsA("BasePart") then
                    v364[#v364 + 1] = v368
                end
            end
        end
    end
    return v364
end

local GetConnectedParts = Instance.new("Part").GetConnectedParts
local GetChildren = script.GetChildren

function GetPartJoints(v369, v370) -- line 1817 | captures: GetConnectedParts
    local v371 = {}
    for v372, v373 in pairs(SearchJoints(v369, v369, v370)) do
        v371[v372] = v373
    end
    for v374, v375 in pairs(GetConnectedParts(v369)) do
        for v376, v377 in pairs(SearchJoints(v375, v369, v370)) do
            v371[v376] = v377
        end
    end
    return v371
end

local v378 = Support.FlipTable({ "Weld", "ManualWeld", "ManualGlue", "Motor", "Motor6D" })

function SearchJoints(v379, v380, v381) -- line 1842 | captures: GetChildren, v378
    local v382 = {}
    for v383, v384 in pairs(GetChildren(v379)) do
        if v378[v384.ClassName] and v381[v384.Part0] and v381[v384.Part1] then
            v382[v384] = v384.Parent
        end
    end
    return v382
end

function RestoreJoints(v385) -- line 1866
    for v386, v387 in pairs(v385) do
        v386.Parent = v387
    end
end

function PreserveJoints(v388, v389) -- line 1876
    local v390 = GetPartJoints(v388, v389)
    for v391 in pairs(v390) do
        v391.Parent = nil
    end
    return v390
end

function CreatePart(v392) -- line 1892
    local Part
    if v392 == "Normal" then
        Part = Instance.new("Part")
        Part.Size = Vector3.new(4, 1, 2)
    elseif v392 == "Truss" then
        Part = Instance.new("TrussPart")
    elseif v392 == "Wedge" then
        Part = Instance.new("WedgePart")
        Part.Size = Vector3.new(4, 1, 2)
    elseif v392 == "Corner" then
        Part = Instance.new("CornerWedgePart")
    elseif v392 == "Cylinder" then
        Part = Instance.new("Part")
        Part.Shape = "Cylinder"
        Part.Size = Vector3.new(2, 2, 2)
    elseif v392 == "Ball" then
        Part = Instance.new("Part")
        Part.Shape = "Ball"
    elseif v392 == "Seat" then
        Part = Instance.new("Seat")
        Part.Size = Vector3.new(4, 1, 2)
    elseif v392 == "Vehicle Seat" then
        Part = Instance.new("VehicleSeat")
        Part.Size = Vector3.new(4, 1, 2)
    elseif v392 == "Spawn" then
        Part = Instance.new("SpawnLocation")
        Part.Size = Vector3.new(4, 1, 2)
    end
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Anchored = true
    return Part
end

if ToolMode == "Tool" then
    if Tool.Parent and Tool.Parent:IsA("Backpack") then
        Player = Tool.Parent.Parent
    elseif Tool.Parent and Tool.Parent:IsA("Model") then
        Player = Players:GetPlayerFromCharacter(Tool.Parent)
    else
        Player = nil
    end
    Tool.AncestryChanged:Connect(function(v393, v394) -- line 1960 | captures: v1
        if v393 == Tool then
            if not (v394 and v394:IsA("Backpack")) then
                if not (v394 and v394:IsA("Model")) then
                    Player = nil
                    for v395 in v1 do
                        v395:RemoveTag("BTStreamingClone")
                        v395:SetAttribute("BTStreamingCloneID", nil)
                        v1[v395] = nil
                    end
                else
                    Player = Players:GetPlayerFromCharacter(v394)
                end
            else
                Player = v394.Parent
            end
        end
    end)
end

return {
    Options = Options,
    PerformAction = function(v396, v397, ...) -- PerformAction | line 1998
        local v398 = Actions[v397]
        if v398 then
            if ToolMode == "Tool" then
                local v399 = Player and v396 == Player
                assert(v399, "Permission denied for client")
            end
            return v398(...)
        end
    end
}
