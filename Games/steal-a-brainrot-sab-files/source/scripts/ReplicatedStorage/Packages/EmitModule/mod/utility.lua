
local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("PhysicsService")
local v_u_3 = require("./logger")
local v_u_4 = {
    ["DEG_TO_RAD"] = 0.017453292519943295,
    ["BEZIER_TAG"] = "BezierParticle",
    ["SHOCKWAVE_TAG"] = "Shockwave",
    ["SCREENSHAKE_TAG"] = "CameraShake",
    ["ENABLED_VFX_TAG"] = "ConstantVFX",
    ["TEXTURE_LOAD_TAG"] = "LoadVFXTextures",
    ["RENDER_PRIORITY"] = Enum.RenderPriority.Camera.Value + 1
}
local v5 = {
    ["StudioSelectable"] = {},
    ["ForgeDebris"] = {
        ["ForgeDebris"] = false
    },
    ["ForgeMouseIgnore"] = {
        ["StudioSelectable"] = false
    }
}
v_u_4.COLLISION_GROUPS = v5
v_u_4.COPY_SPECIALMESH_PROPERTIES = {
    "MeshId",
    "MeshType",
    "Offset",
    "Scale",
    "TextureId",
    "VertexColor"
}
v_u_4.COPY_PART_PROPERTIES = {
    "CastShadow",
    "Color",
    "Material",
    "MaterialVariant",
    "Reflectance",
    "Shape",
    "FrontSurface",
    "BackSurface",
    "LeftSurface",
    "RightSurface",
    "TopSurface",
    "BottomSurface"
}
v_u_4.COPY_EXTENDED_PART_PROPERTIES = {
    "Size",
    "Transparency",
    "CanCollide",
    "CanQuery",
    "CanTouch",
    "CollisionGroup"
}
local v_u_6 = setmetatable({}, {
    ["__mode"] = "k"
})
function v_u_4.lock(p7)
    if v_u_6[p7] then
        return true
    end
    v_u_6[p7] = coroutine.running()
    return false
end
function v_u_4.unlock(p8, p9)
    local v10 = v_u_6[p8]
    if coroutine.running() ~= v10 and p9 ~= v10 then
        v_u_3.error("attempt to unlock an instance owned by a different thread")
    end
    v_u_6[p8] = nil
end
function v_u_4.setCollisionGroups(p11)
    local v12 = {}
    for v13, v14 in p11 do
        v_u_2:RegisterCollisionGroup(v13)
        if not v13:match("Studio") or v_u_1:IsStudio() then
            v12[v13] = v14
        end
    end
    for v15, v16 in v12 do
        for v17, v18 in v16 do
            if not v17:match("Studio") or v_u_1:IsStudio() then
                v_u_2:CollisionGroupSetCollidable(v15, v17, v18)
            end
        end
    end
end
local v_u_19 = 0
function v_u_4.getRanomId()
    v_u_19 = v_u_19 + 1
    local v20 = v_u_19
    return tostring(v20)
end
function v_u_4.copyProperties(p21, p22, p23)
    for _, v24 in p23 do
        p22[v24] = p21[v24]
    end
end
function v_u_4.lerp(p25, p26, p27)
    return p25 + (p26 - p25) * p27
end
function v_u_4.try(p_u_28, p29, ...)
    local v31 = { xpcall(p29, function(p30)
            v_u_3.warn(string.format(p_u_28, p30))
        end, ...) }
    return v31[1], table.unpack(v31, 2)
end
function v_u_4.reboundfn(p_u_32, p_u_33)
    local v_u_34 = nil
    return function(...)
        if v_u_34 then
            task.cancel(v_u_34)
        end
        local v_u_35 = { ... }
        v_u_34 = task.delay(p_u_32, function()
            v_u_34 = nil
            local v36 = v_u_35
            p_u_33(table.unpack(v36))
        end)
    end
end
function v_u_4.randomUnitVector(p37, p38, p39)
    local v40 = p39 or Random.new()
    local v41 = v40:NextNumber(p37.X, p38.X)
    local v42 = v40:NextNumber(p37.Y, p38.Y)
    local v43 = p37.Z
    local v44 = p38.Z
    return Vector3.new(v41, v42, v40:NextNumber(v43, v44))
end
function v_u_4.getImpulseForce(p45, p46, p47)
    local v48 = (p46 - p45) / p47
    local v49 = workspace.Gravity * p47 * 0.5
    return v48 + Vector3.new(0, v49, 0)
end
function v_u_4.isMeshVFX(p50)
    local v51 = p50 and (p50:IsA("Model") and p50:FindFirstChild("Start") and (p50.Start:IsA("BasePart") and p50:FindFirstChild("End")))
    if v51 then
        v51 = p50.End:IsA("BasePart")
    end
    return v51
end
function v_u_4.cleanupScope(p52)
    for _, v53 in p52 do
        local v54 = typeof(v53)
        if v54 == "Instance" then
            v53:Destroy()
        elseif v54 == "RBXScriptConnection" then
            v53:Disconnect()
        elseif v54 == "thread" then
            if coroutine.status(v53) ~= "dead" then
                task.cancel(v53)
            end
        elseif v54 == "function" then
            task.spawn(v53)
        elseif v54 == "table" then
            v_u_4.cleanupScope(v53)
        end
    end
    table.clear(p52)
end
function v_u_4.protectParent(p55, p_u_56)
    local v57 = p_u_56.AncestryChanged
    table.insert(p55, v57:Connect(function(_, _)
        if p_u_56.Parent ~= workspace.Terrain then
            p_u_56.Parent = workspace.Terrain
        end
    end))
end
function v_u_4.findFirstClassWithTag(p58, p59, p60)
    if p58 and p58.Parent ~= game then
        if p58.ClassName == p59 and p58:HasTag(p60) then
            return p58
        else
            return v_u_4.findFirstClassWithTag(p58.Parent, p59, p60)
        end
    else
        return
    end
end
function v_u_4.cloneParticleAncestry(p_u_61, p_u_62)
    if p_u_61:FindFirstAncestorWhichIsA("BasePart") or p_u_61:FindFirstAncestorOfClass("Attachment") then
        local function v_u_64(p63)
            if p63.Parent and (p63.Parent:IsA("BasePart") or p63.Parent:IsA("Attachment")) then
                p63 = v_u_64(p63.Parent)
            end
            return p63
        end
        local function v_u_73(p65)
            local v66 = p_u_62[p65]
            if v66 then
                if p65 == p_u_61 then
                    return v66, p_u_62[p65.Parent]
                end
                local v67 = p_u_62
                local v68 = p65.Parent
                if v68.Parent and (v68.Parent:IsA("BasePart") or v68.Parent:IsA("Attachment")) then
                    v68 = v_u_64(v68.Parent)
                end
                return v66, v67[v68] or p_u_62[p65]
            end
            local v69 = Instance.fromExisting(p65)
            v69.Archivable = false
            if v69:IsA("BasePart") then
                v69.Locked = true
            end
            if p_u_62 then
                p_u_62[p65] = v69
            end
            local v70
            if p65.Parent and (p65.Parent:IsA("BasePart") or p65.Parent:IsA("Attachment")) then
                local v71, v72 = v_u_73(p65.Parent)
                v70 = v72 or v69
                if v71 then
                    v69.Parent = v71
                end
            else
                v70 = v69
            end
            return v69, v70
        end
        return v_u_73(p_u_61.Parent)
    end
end
function v_u_4.getAttribute(p74, p75, p76, p77)
    local v78 = p74:GetAttribute(p75)
    if v78 ~= nil and typeof(v78) == typeof(p76) then
        p76 = v78
    end
    if not p77 then
        p74:SetAttribute(p75, p76)
    end
    return p76
end
function v_u_4.getRangeAttribute(p79, p80, p81, p82, p83)
    local v84 = p79:GetAttribute(p80)
    if typeof(v84) ~= "NumberRange" then
        v84 = p81
    end
    if p82 then
        local v85 = NumberRange.new
        local v86 = v84.Min
        local v87 = p82.Min
        local v88 = p82.Max
        local v89 = math.clamp(v86, v87, v88)
        local v90 = v84.Max
        local v91 = p82.Min
        local v92 = p82.Max
        v84 = v85(v89, (math.clamp(v90, v91, v92)))
    end
    if not p83 then
        p79:SetAttribute(p80, v84)
    end
    return v84
end
function v_u_4.getEnumAttribute(p93, p94, p95, p96, p97)
    local v98 = p93:GetAttribute(p94)
    if v98 ~= nil and table.find(p96, v98) then
        p95 = v98
    end
    if not p97 then
        p93:SetAttribute(p94, p95)
    end
    return p95
end
function v_u_4.getMeshDecals(p99, p100)
    local v101 = {}
    local v102 = {}
    local v103 = {}
    local function v107(p104)
        local v105 = {}
        for _, v106 in p104 do
            if v106:IsA("Decal") then
                table.insert(v105, v106)
            end
        end
        return v105
    end
    if v_u_4.getAttribute(p99, "Flipbook", false, true) then
        return v107(p100:GetChildren()), v102, v103
    end
    local v108 = p99:FindFirstChild("End")
    local v109 = p99:FindFirstChild("Start")
    if v108 then
        for _, v110 in p100:GetChildren() do
            if v110:IsA("Decal") then
                local v111 = v108:FindFirstChild(v110.Name)
                if v111 and v111:IsA("Decal") then
                    table.insert(v101, v110)
                    v103[v110] = v111
                    if v110:GetAttribute("FlipbookEnabled") then
                        v102[v110] = v_u_4.deserializeFlipbook(v110:GetAttribute("FlipbookTextures"))
                    else
                        table.insert(v101, v110)
                    end
                end
            end
        end
        for _, v112 in v109:GetChildren() do
            if v112:IsA("Decal") then
                local v113 = v112:GetChildren()
                local v114 = 0
                for v115 = 1, #v113 do
                    local v116 = v115 - v114
                    if not v113[v116]:IsA("Decal") then
                        table.remove(v113, v116)
                        v114 = v114 + 1
                    end
                end
                if #v113 ~= 0 then
                    table.sort(v113, function(p117, p118)
                        local v119 = p117.Name
                        local v120 = tonumber(v119:match("%d+")) or 0
                        local v121 = p118.Name
                        return v120 < (tonumber(v121:match("%d+")) or 0)
                    end)
                    local v122 = {}
                    for _, v123 in v113 do
                        local v124 = v123.Texture
                        local v125 = tonumber(v124:match("%d+")) or 0
                        table.insert(v122, v125)
                        v123:Destroy()
                    end
                    local v126 = v_u_4.serializeFlipbook(v122)
                    v112:SetAttribute("FlipbookEnabled", true)
                    v112:SetAttribute("FlipbookTextures", buffer.tostring(v126))
                end
            end
        end
    end
    return v101, v102, v103
end
function v_u_4.getBezierPoints(p127, p128)
    local v129 = p127:GetChildren()
    table.sort(v129, function(p130, p131)
        local v132 = p130.Name
        local v133 = tonumber(v132)
        local v134 = p131.Name
        return v133 < tonumber(v134)
    end)
    local v135 = {}
    local v136 = {}
    local v137 = {}
    for v138, v139 in v129 do
        local v140 = v139:FindFirstChild("T0")
        local v141 = v139:FindFirstChild("T1")
        if v138 == 1 then
            local v142 = p127.WorldCFrame:PointToObjectSpace(v139.WorldPosition)
            local v143 = v142.X
            local v144 = v142.Y
            local v145 = v142.Z
            local v146 = vector.create(v143, v144, v145)
            table.insert(v135, v146)
            if p128 then
                v136[v139] = v146
                table.insert(v137, v139)
            end
        end
        if v138 ~= 1 then
            if v141 then
                local v147 = p127.WorldCFrame:PointToObjectSpace(v141.WorldPosition)
                local v148 = v147.X
                local v149 = v147.Y
                local v150 = v147.Z
                local v151 = vector.create(v148, v149, v150)
                table.insert(v135, v151)
                if p128 then
                    v136[v141] = v151
                    table.insert(v137, v141)
                end
            else
                local v152 = p127.WorldCFrame:PointToObjectSpace(v139.WorldPosition)
                local v153 = v152.X
                local v154 = v152.Y
                local v155 = v152.Z
                local v156 = vector.create(v153, v154, v155)
                table.insert(v135, v156)
                if p128 then
                    v136[v139] = v156
                    table.insert(v137, v139)
                end
            end
        end
        if v138 ~= 1 and v138 ~= #v129 then
            local v157 = p127.WorldCFrame:PointToObjectSpace(v139.WorldPosition)
            local v158 = v157.X
            local v159 = v157.Y
            local v160 = v157.Z
            local v161 = vector.create(v158, v159, v160)
            table.insert(v135, v161)
            if p128 then
                v136[v139] = v161
                table.insert(v137, v139)
            end
        end
        if v138 ~= #v129 then
            if v140 then
                local v162 = p127.WorldCFrame:PointToObjectSpace(v140.WorldPosition)
                local v163 = v162.X
                local v164 = v162.Y
                local v165 = v162.Z
                local v166 = vector.create(v163, v164, v165)
                table.insert(v135, v166)
                if p128 then
                    v136[v140] = v166
                    table.insert(v137, v140)
                end
            else
                local v167 = p127.WorldCFrame:PointToObjectSpace(v139.WorldPosition)
                local v168 = v167.X
                local v169 = v167.Y
                local v170 = v167.Z
                local v171 = vector.create(v168, v169, v170)
                table.insert(v135, v171)
                if p128 then
                    v136[v139] = v171
                    table.insert(v137, v139)
                end
            end
        end
        if v138 == #v129 then
            local v172 = p127.WorldCFrame:PointToObjectSpace(v139.WorldPosition)
            local v173 = v172.X
            local v174 = v172.Y
            local v175 = v172.Z
            local v176 = vector.create(v173, v174, v175)
            table.insert(v135, v176)
            if p128 then
                v136[v139] = v176
                table.insert(v137, v139)
            end
        end
    end
    return v135, v137, v136
end
function v_u_4.scaleNumberSequence(p177, p178)
    if p178 == 1 then
        return p177
    end
    local v179 = {}
    for _, v180 in p177.Keypoints do
        local v181, v182
        if typeof(p178) == "function" then
            v181, v182 = p178(v180.Value, v180.Envelope)
        else
            v181 = v180.Value * p178
            v182 = v180.Envelope * p178
        end
        local v183 = NumberSequenceKeypoint.new
        local v184 = v180.Time
        table.insert(v179, v183(v184, v181, v182))
    end
    return NumberSequence.new(v179)
end
function v_u_4.serializePath(p185)
    local v186 = buffer.create(#p185 * 4 * 6)
    local v187 = 0
    for v188, v189 in p185 do
        local v190 = v189.Position.X.Scale
        local v191 = v189.Position.Y.Scale
        if v188 ~= 1 then
            local v192 = v190 + v189.LeftTangent.X.Scale
            buffer.writef32(v186, v187, v192)
            local v193 = v187 + 4
            local v194 = v191 + v189.LeftTangent.Y.Scale
            buffer.writef32(v186, v193, v194)
            v187 = v187 + 8
        end
        buffer.writef32(v186, v187, v190)
        local v195 = v187 + 4
        buffer.writef32(v186, v195, v191)
        v187 = v187 + 8
        if v188 ~= #p185 then
            local v196 = v190 + v189.RightTangent.X.Scale
            buffer.writef32(v186, v187, v196)
            local v197 = v187 + 4
            local v198 = v191 + v189.RightTangent.Y.Scale
            buffer.writef32(v186, v197, v198)
            v187 = v187 + 8
        end
    end
    return v186
end
function v_u_4.deserializePath(p199)
    if typeof(p199) == "string" then
        p199 = buffer.fromstring(p199) or p199
    end
    local v200 = buffer.len(p199) / 24
    local v201 = {}
    for v202 = 0, v200 - 1 do
        local v203 = v202 * 4 * 6
        local v204 = buffer.readf32(p199, v203)
        local v205 = v203 + 4
        local v206 = buffer.readf32(p199, v205)
        local v207 = vector.create(v204, v206)
        table.insert(v201, v207)
        if v202 ~= v200 - 1 then
            local v208 = v203 + 8
            local v209 = buffer.readf32(p199, v208)
            local v210 = v203 + 12
            local v211 = buffer.readf32(p199, v210)
            local v212 = v203 + 16
            local v213 = buffer.readf32(p199, v212)
            local v214 = v203 + 20
            local v215 = buffer.readf32(p199, v214)
            local v216 = vector.create(v209, v211)
            table.insert(v201, v216)
            local v217 = vector.create(v213, v215)
            table.insert(v201, v217)
        end
    end
    return v201
end
function v_u_4.serializeFlipbook(p218)
    local v219 = buffer.create(#p218 * 8)
    for v220, v221 in p218 do
        local v222 = (v220 - 1) * 8
        buffer.writef64(v219, v222, v221)
    end
    return v219
end
function v_u_4.deserializeFlipbook(p223)
    if typeof(p223) == "string" then
        p223 = buffer.fromstring(p223) or p223
    end
    local v224 = {}
    for v225 = 0, buffer.len(p223) / 8 - 1 do
        local v226 = v225 * 8
        local v227 = buffer.readf64(p223, v226)
        table.insert(v224, v227)
    end
    return v224
end
v_u_4.default_bezier = buffer.tostring(v_u_4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }))
v_u_4.linear_bezier = buffer.tostring(v_u_4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }))
return v_u_4