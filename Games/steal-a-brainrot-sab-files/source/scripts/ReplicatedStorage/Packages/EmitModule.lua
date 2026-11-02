
local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = require(script.mod.logger)
local v_u_4 = require(script.mod.utility)
local v_u_5 = require(script.effects.beam)
local v_u_6 = require(script.effects.spin)
local v_u_7 = require(script.effects.mesh)
local v_u_8 = require(script.effects.bezier)
local v_u_9 = require(script.effects.screen)
local v_u_10 = require(script.effects.particle)
local v_u_11 = require(script.effects.camera_shake)
local v_u_12 = require(script.effects.tween_property)
local v_u_13 = require(script.effects.shockwave_ring)
local v_u_14 = require(script.effects.shockwave_line)
local v_u_15 = require(script.effects.shockwave_debris)
local v_u_16 = require(script.pkg.Promise)
local v_u_17 = require(script.obj.ObjectCache)
local v_u_18 = script:FindFirstAncestorOfClass("Plugin")
local v_u_19 = v_u_1:IsServer() or v_u_18
local v_u_20 = {
    ["scope"] = {},
    ["setup"] = false
}
local function v_u_30(p21, p22)
    if not v_u_20.setup then
        v_u_3.error("API not initialized")
    end
    local v_u_23 = v_u_4.getRanomId()
    if not p21:IsA("Part") then
        local v24 = p21:Clone()
        v24.Archivable = false
        v24.Locked = true
        v24.Parent = workspace.Terrain
        table.insert(p22, v24)
        return v24
    end
    local v25 = v_u_20.caches.shared_part:get(v_u_23)
    v25.CFrame = p21.CFrame
    local v26 = v25._getReal()
    v_u_4.copyProperties(p21, v26, v_u_4.COPY_PART_PROPERTIES)
    v_u_4.copyProperties(p21, v26, v_u_4.COPY_EXTENDED_PART_PROPERTIES)
    local v27 = p21:Clone()
    for _, v28 in v27:GetChildren() do
        v28.Parent = v26
    end
    v27:Destroy()
    local function v29()
        v_u_20.caches.shared_part:free(v_u_23)
    end
    table.insert(p22, v29)
    return v25
end
function v_u_20.init(_)
    if v_u_20.setup then
        return
    else
        if v_u_19 then
            task.spawn(function()
                local v31 = 0
                while true do
                    v31 = v31 + 1
                    local v32, v33 = pcall(v_u_4.setCollisionGroups, v_u_4.COLLISION_GROUPS)
                    if not v32 then
                        task.wait(v31)
                    end
                    if v32 or v31 >= 5 then
                        if not v32 then
                            v_u_3.warn((("couldn\'t register necessary collision groups after %* tries with the last error being: %*"):format(v31, v33)))
                        end
                        return
                    end
                end
            end)
        end
        v_u_20.setup = true
        if not v_u_1:IsServer() or v_u_18 then
            shared.vfx = v_u_20
            local v34 = Instance.new("Part")
            v34.Transparency = 1
            v34.Anchored = true
            v34.CanCollide = false
            v34.CanQuery = false
            v34.Locked = true
            local v35 = Instance.new("Folder")
            v35.Name = "DO_NOT_REMOVE_ForgeSharedPartCache"
            v35.Archivable = false
            v35.Parent = workspace.Terrain
            v_u_4.protectParent(v_u_20.scope, v35)
            local v_u_38 = v_u_17.new(v34, v35, {
                ["size"] = 150,
                ["on_free"] = function(p36)
                    local v37 = p36.value
                    v37.Transparency = 1
                    v37.Anchored = true
                    v37.CanQuery = false
                    v37.CanCollide = false
                    v37.CollisionGroup = "ForgeMouseIgnore"
                    v37.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    v37.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    v37:ClearAllChildren()
                end
            })
            v_u_20.caches = {
                ["shared_part"] = v_u_38
            }
            local v39 = v_u_20.scope
            local function v40()
                v_u_38:destroy()
            end
            table.insert(v39, v40)
            v_u_11.init()
            v_u_8.init(v_u_38)
            v_u_13.init(v_u_38)
            v_u_14.init(v_u_38)
            v_u_15.init(v_u_38)
            local v41 = Instance.new("Decal")
            local v42 = Instance.new("Part")
            v42.Name = "DO_NOT_REMOVE_ForgeTextureCache"
            v42.Transparency = 1
            v42.Size = Vector3.new(0, 0, 0)
            v42.Archivable = false
            v42.Anchored = true
            v42.CanCollide = false
            v42.CanQuery = false
            v42.Locked = true
            v42.Parent = workspace.Terrain
            v_u_4.protectParent(v_u_20.scope, v42)
            local v_u_44 = v_u_17.new(v41, v42, {
                ["size"] = 360,
                ["on_free"] = function(p43)
                    p43.value.Texture = ""
                end
            })
            local v_u_45 = {}
            local function v80(p_u_46)
                if p_u_46:IsDescendantOf(workspace.Terrain) then
                    return
                elseif v_u_4.isMeshVFX(p_u_46) then
                    local v_u_47 = p_u_46:FindFirstChild("Start")
                    if v_u_47 and v_u_47:IsA("BasePart") then
                        local v48 = {}
                        local v_u_49 = {}
                        table.insert(v48, v_u_49)
                        local function v64()
                            v_u_4.cleanupScope(v_u_49)
                            local v50, v51 = v_u_4.getMeshDecals(p_u_46, v_u_47)
                            for _, v_u_53 in v50 do
                                if typeof(v_u_53) == "Instance" then
                                    local v_u_53 = v_u_53.Texture or v_u_53
                                end
                                if v_u_53 ~= "" then
                                    v_u_44:get(v_u_53).Texture = v_u_53
                                    local v54 = v_u_49
                                    local function v55()
                                        v_u_44:free(v_u_53)
                                    end
                                    table.insert(v54, v55)
                                end
                            end
                            for v56, v57 in v51 do
                                local v58 = false
                                if v_u_18 then
                                    for _, v59 in v_u_2:GetTags(v56) do
                                        if v59:match("^_local_flipbook_") then
                                            v58 = true
                                            break
                                        end
                                    end
                                end
                                for _, v60 in v57 do
                                    local v_u_61 = ("%*%*"):format(v58 and "rbxtemp://" or "rbxassetid://", v60)
                                    if typeof(v_u_61) == "Instance" then
                                        v_u_61 = v_u_61.Texture or v_u_61
                                    end
                                    if v_u_61 ~= "" then
                                        v_u_44:get(v_u_61).Texture = v_u_61
                                        local v62 = v_u_49
                                        local function v63()
                                            v_u_44:free(v_u_61)
                                        end
                                        table.insert(v62, v63)
                                    end
                                end
                            end
                        end
                        v64()
                        if v_u_18 then
                            local v65 = v_u_4.reboundfn(1, v64)
                            local v66 = v_u_47.DescendantAdded
                            table.insert(v48, v66:Connect(v65))
                            local v67 = v_u_47.DescendantRemoving
                            table.insert(v48, v67:Connect(v65))
                        end
                        v_u_45[p_u_46] = v48
                    end
                else
                    local v68 = {}
                    local v_u_69 = {}
                    table.insert(v68, v_u_69)
                    local function v76()
                        v_u_4.cleanupScope(v_u_69)
                        local function v74(p70)
                            if p70:IsA("ParticleEmitter") then
                                local v_u_71 = p70.Texture
                                if v_u_71 ~= "" then
                                    v_u_44:get(v_u_71).Texture = v_u_71
                                    local v72 = v_u_69
                                    local function v73()
                                        v_u_44:free(v_u_71)
                                    end
                                    table.insert(v72, v73)
                                end
                            else
                                return
                            end
                        end
                        v74(p_u_46)
                        for _, v75 in p_u_46:GetDescendants() do
                            v74(v75)
                        end
                    end
                    v76()
                    if v_u_18 then
                        local v77 = v_u_4.reboundfn(1, v76)
                        local v78 = p_u_46.DescendantAdded
                        table.insert(v68, v78:Connect(v77))
                        local v79 = p_u_46.DescendantRemoving
                        table.insert(v68, v79:Connect(v77))
                    end
                    v_u_45[p_u_46] = v68
                    return
                end
            end
            for _, v81 in v_u_2:GetTagged(v_u_4.TEXTURE_LOAD_TAG) do
                v80(v81)
            end
            v_u_2:GetInstanceAddedSignal(v_u_4.TEXTURE_LOAD_TAG):Connect(v80)
            v_u_2:GetInstanceRemovedSignal(v_u_4.TEXTURE_LOAD_TAG):Connect(function(p82)
                local v83 = v_u_45[p82]
                if v83 then
                    v_u_4.cleanupScope(v83)
                    v_u_45[p82] = nil
                end
            end)
            local v84 = v_u_20.scope
            local function v86()
                v_u_44:destroy()
                for _, v85 in v_u_45 do
                    v_u_4.cleanupScope(v85)
                end
            end
            table.insert(v84, v86)
            local v_u_87 = {}
            local function v90(p88)
                local v89 = v_u_87[p88]
                if v89 then
                    v_u_4.cleanupScope(v89)
                end
                v_u_87[p88] = nil
            end
            local function v_u_116(p_u_91)
                local v_u_92 = v_u_4.isMeshVFX(p_u_91)
                local v_u_93 = p_u_91:HasTag(v_u_4.BEZIER_TAG)
                if v_u_92 or v_u_93 then
                    local v94 = {}
                    local v_u_95 = {}
                    table.insert(v94, v_u_95)
                    v_u_87[p_u_91] = v94
                    local v96 = p_u_91.AncestryChanged
                    local function v99()
                        if p_u_91:IsDescendantOf(workspace) or p_u_91.Parent and p_u_91.Parent:HasTag("AllowEmitting") then
                            if not v_u_87[p_u_91] then
                                v_u_116(p_u_91)
                                return
                            end
                        else
                            local v97 = p_u_91
                            local v98 = v_u_87[v97]
                            if v98 then
                                v_u_4.cleanupScope(v98)
                            end
                            v_u_87[v97] = nil
                        end
                    end
                    table.insert(v94, v96:Connect(v99))
                    if not p_u_91:IsDescendantOf(workspace) then
                        local v100
                        if p_u_91.Parent then
                            v100 = not p_u_91.Parent:HasTag("AllowEmitting")
                        else
                            v100 = false
                        end
                        if v100 then
                            return
                        end
                    end
                    local function v114()
                        if v_u_4.getAttribute(p_u_91, "Enabled", true) then
                            local v_u_101 = 0
                            local v102 = v_u_95
                            local v103 = v_u_1.RenderStepped
                            local function v113()
                                local v104 = v_u_4.getAttribute(p_u_91, "Rate", 5)
                                local v105 = p_u_91:GetAttribute("SpeedOverride") or 1
                                if v105 == 0 then
                                    return
                                elseif os.clock() - v_u_101 > 1 / v104 / v105 then
                                    local v_u_106 = {
                                        ["depth"] = 0
                                    }
                                    local function v107()
                                        v_u_4.cleanupScope(v_u_106)
                                    end
                                    local v108 = v_u_20.scope
                                    table.insert(v108, v107)
                                    if v_u_92 then
                                        local v109 = p_u_91:FindFirstChild("Start")
                                        if not v109 then
                                            p_u_91:RemoveTag(v_u_4.ENABLED_VFX_TAG)
                                            return
                                        end
                                        v_u_101 = os.clock()
                                        for _ = 1, v_u_4.getAttribute(p_u_91, "EmitCount", 1) do
                                            v_u_4.try(("failed to emit mesh \'%*\' with error: %%s"):format((p_u_91:GetFullName())), v_u_7.emit, p_u_91, v_u_30(v109, v_u_106), v_u_106, 1, true)
                                        end
                                    elseif v_u_93 then
                                        local v110 = p_u_91:FindFirstChildOfClass("Part")
                                        if not v110 then
                                            return
                                        end
                                        v_u_101 = os.clock()
                                        local v111 = v110:Clone()
                                        v111.Locked = true
                                        table.insert(v_u_106, v111)
                                        v_u_4.try(("failed to emit bezier \'%*\' with error: %%s"):format((p_u_91:GetFullName())), v_u_8.emit, p_u_91, v111, v_u_106, true)
                                    end
                                    local v112 = table.find(v_u_20.scope, v107)
                                    if v112 then
                                        table.remove(v_u_20.scope, v112)
                                    end
                                    v_u_4.cleanupScope(v_u_106)
                                end
                            end
                            table.insert(v102, v103:Connect(v113))
                        else
                            v_u_4.cleanupScope(v_u_95)
                        end
                    end
                    local v115 = p_u_91:GetAttributeChangedSignal("Enabled")
                    table.insert(v94, v115:Connect(v114))
                    v114()
                end
            end
            for _, v117 in v_u_2:GetTagged(v_u_4.ENABLED_VFX_TAG) do
                v_u_116(v117)
            end
            v_u_2:GetInstanceAddedSignal(v_u_4.ENABLED_VFX_TAG):Connect(v_u_116)
            v_u_2:GetInstanceRemovedSignal(v_u_4.ENABLED_VFX_TAG):Connect(v90)
            local v118 = v_u_20.scope
            local function v120()
                for _, v119 in v_u_87 do
                    v_u_4.cleanupScope(v119)
                end
            end
            table.insert(v118, v120)
        end
    end
end
function v_u_20.deinit()
    if v_u_20.setup then
        v_u_20.setup = false
        shared.vfx = nil
        if not v_u_1:IsServer() or v_u_18 then
            v_u_4.cleanupScope(v_u_20.scope)
            v_u_8.deinit()
            v_u_11.deinit()
            v_u_13.deinit()
            v_u_14.deinit()
            v_u_15.deinit()
        end
    else
        return
    end
end
function v_u_20.emit(p121, ...)
    if not v_u_20.setup then
        v_u_3.error("not initialized")
    end
    local v_u_122 = {}
    local v_u_123 = {}
    local v_u_124 = 1
    local function v_u_144(p_u_125, p_u_126)
        return v_u_16.new(function(p127)
            (function()
                local v_u_128 = {
                    ["depth"] = p_u_126
                }
                if p_u_125:IsA("ParticleEmitter") then
                    if p_u_125:IsDescendantOf(workspace) then
                        v_u_4.try(("failed to emit particle \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_10.emit, p_u_125, p_u_125, v_u_128, v_u_124)
                        v_u_4.cleanupScope(v_u_128)
                    else
                        local v129, v130 = v_u_4.cloneParticleAncestry(p_u_125, v_u_123)
                        if not v129 then
                            return
                        end
                        table.insert(v_u_128, v130)
                        local v131 = p_u_125:Clone()
                        v131.Archivable = false
                        v131.Parent = v129
                        if not v_u_122[v130] then
                            v130.Parent = workspace.Terrain
                        end
                        if v_u_122[v130] then
                            local v132 = v_u_122
                            v132[v130] = v132[v130] + 1
                        else
                            v_u_122[v130] = 1
                        end
                        v_u_4.try(("failed to emit particle \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_10.emit, p_u_125, v131, v_u_128, v_u_124)
                        local v133 = v_u_122
                        v133[v130] = v133[v130] - 1
                        if v_u_122[v130] <= 0 then
                            v_u_4.cleanupScope(v_u_128)
                        end
                    end
                elseif p_u_125:IsA("Beam") then
                    local v134 = p_u_125:Clone()
                    v134.Archivable = false
                    v134.Parent = workspace.Terrain
                    table.insert(v_u_128, v134)
                    v_u_4.try(("failed to emit beam \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_5.emit, p_u_125, v134, v_u_128, v_u_124)
                    v_u_4.cleanupScope(v_u_128)
                elseif p_u_125:IsA("Trail") then
                    p_u_125.Enabled = true
                elseif p_u_125:HasTag(v_u_4.BEZIER_TAG) then
                    local v135 = p_u_125:FindFirstChildOfClass("Part")
                    if not v135 then
                        return
                    end
                    if p_u_125:GetAttribute("Enabled") then
                        p_u_125:SetAttribute("Enabled", false)
                    end
                    local v136 = v135:Clone()
                    v136.Locked = true
                    table.insert(v_u_128, v136)
                    v_u_4.try(("failed to emit bezier \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_8.emit, p_u_125, v136, v_u_128)
                    v_u_4.cleanupScope(v_u_128)
                elseif v_u_4.isMeshVFX(p_u_125) then
                    local v_u_137 = p_u_125:FindFirstChild("Start")
                    if not v_u_137 then
                        return
                    end
                    if p_u_125:GetAttribute("Enabled") then
                        p_u_125:SetAttribute("Enabled", false)
                    end
                    local v138 = {}
                    for _ = 1, v_u_4.getAttribute(p_u_125, "EmitCount", 1) do
                        local v139 = v_u_16.new
                        local function v141(p140)
                            v_u_4.try(("failed to emit mesh \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_7.emit, p_u_125, v_u_30(v_u_137, v_u_128), v_u_128, v_u_124)
                            p140()
                        end
                        table.insert(v138, v139(v141))
                    end
                    v_u_16.all(v138):await()
                    v_u_4.cleanupScope(v_u_128)
                elseif p_u_125:IsA("Model") then
                    if v_u_4.lock(p_u_125) then
                        return
                    end
                    v_u_4.try(("failed to emit spinning model \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_6.emit, p_u_125, v_u_128)
                    v_u_4.cleanupScope(v_u_128)
                    v_u_4.unlock(p_u_125)
                elseif p_u_125:IsA("RayValue") then
                    if p_u_125:HasTag(v_u_4.SCREENSHAKE_TAG) then
                        v_u_4.try(("failed to emit camera shake \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_11.emit, p_u_125, v_u_128)
                        v_u_4.cleanupScope(v_u_128)
                    else
                        if not p_u_125.Parent or v_u_4.lock(p_u_125) then
                            return
                        end
                        v_u_4.try(("failed to emit tween property \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_12.emit, p_u_125.Parent, p_u_125, v_u_128)
                        v_u_4.unlock(p_u_125)
                        v_u_4.cleanupScope(v_u_128)
                    end
                end
                local v142 = p_u_125:IsA("Part") and v_u_4.findFirstClassWithTag(p_u_125, "Attachment", v_u_4.SHOCKWAVE_TAG)
                if v142 then
                    local v143 = p_u_125.Parent.Name
                    if v143 == "Rings" then
                        v_u_4.try(("failed to emit shockwave ring \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_13.emit, v142, p_u_125, v_u_128)
                        v_u_4.cleanupScope(v_u_128)
                        return
                    end
                    if v143 == "Debris" then
                        v_u_4.try(("failed to emit shockwave debris \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_15.emit, v142, p_u_125, v_u_128)
                        v_u_4.cleanupScope(v_u_128)
                        return
                    end
                    if v143 == "Lines" then
                        v_u_4.try(("failed to emit shockwave line \'%*\' with error: %%s"):format((p_u_125:GetFullName())), v_u_14.emit, v142, p_u_125, v_u_128)
                        v_u_4.cleanupScope(v_u_128)
                    end
                end
            end)()
            p127()
        end)
    end
    local v145 = { ... }
    if typeof(p121) == "number" then
        v_u_124 = p121
    else
        table.insert(v145, p121)
    end
    local v_u_146 = {}
    local function v_u_159(p147, p148, p149)
        for _, v_u_150 in p148 do
            if v_u_150:IsA("BasePart") and (v_u_150:GetAttribute("Enabled") and not v_u_4.findFirstClassWithTag(v_u_150, "Attachment", v_u_4.SHOCKWAVE_TAG)) then
                if not v_u_4.lock(v_u_150) then
                    local v151 = v_u_150:FindFirstAncestorOfClass("Model")
                    if not v151 or v151:GetAttribute("SpinRotation") == Vector3.new(0, 0, 0) and (v151:GetAttribute("Scale_Start") == 1 and v151:GetAttribute("Scale_End") == 1) then
                        local v_u_152 = coroutine.running()
                        local v_u_153 = {
                            ["depth"] = p147
                        }
                        if v_u_4.try(("failed to emit screen effect \'%*\' with error: %%s"):format((v_u_150:GetFullName())), v_u_9.emit, v_u_150, v_u_153) then
                            if #v_u_150:GetDescendants() == 0 then
                                v_u_4.cleanupScope(v_u_153)
                                return
                            end
                            local v154 = {}
                            v_u_159(p147 + 1, v_u_150:GetChildren(), v154)
                            local v155 = v_u_146
                            local v156 = v_u_16.all(v154)
                            local function v157()
                                v_u_4.unlock(v_u_150, v_u_152)
                                v_u_4.cleanupScope(v_u_153)
                            end
                            table.insert(v155, v156:finally(v157))
                        end
                    end
                end
            else
                local v158 = v_u_144
                table.insert(p149, v158(v_u_150, p147))
                if not (v_u_150:HasTag(v_u_4.BEZIER_TAG) or (v_u_4.isMeshVFX(v_u_150) or v_u_150:IsA("BasePart") and v_u_4.findFirstClassWithTag(v_u_150, "Attachment", v_u_4.SHOCKWAVE_TAG))) then
                    v_u_159(p147 + 1, v_u_150:GetChildren(), p149)
                end
            end
        end
    end
    v_u_159(0, v145, v_u_146)
    return {
        ["Finished"] = v_u_16.all(v_u_146)
    }
end
v_u_20.init({})
return v_u_20