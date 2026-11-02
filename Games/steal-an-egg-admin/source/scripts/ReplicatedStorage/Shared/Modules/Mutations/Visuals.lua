-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bounds = require(ReplicatedStorage.Shared.Utils.Spatial).Bounds
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Crc32 = require(ReplicatedStorage.Shared.Utils.Codec).Crc32
local v1 = require(ReplicatedStorage.Packages.Log).new()
local t = require(ReplicatedStorage.Packages.t)
local v2 = {
    Darker = Color3.fromRGB(216, 158, 0),
    Lighter = Color3.fromRGB(251, 255, 0)
}
local v4 = {
    Darker = Color3.fromRGB(134, 134, 134),
    Lighter = Color3.fromRGB(192, 192, 192)
}
local v5 = Random.new()
local v7
local v8 = {}

local function getFxContainer(v9) -- line 17 | captures: ReplicatedStorage
    local Mutations = ReplicatedStorage:FindFirstChild("Mutations")
    assert(Mutations, "Mutations folder is missing from ReplicatedStorage")
    local v10 = Mutations:FindFirstChild(v9)
    local v11 = ("Mutation FX container \"%*\" not found in Mutations"):format(v9)
    assert(v10, v11)
    return v10
end

local function shouldSkipColoring(v12) -- line 24
    if v12:GetAttribute("MutationsDontModify") == true then
        return true
    end
    if v12:GetAttribute("DontAddTexture") == true then
        return true
    end
    if v12:GetAttribute("IsEye") == true then
        return true
    end
    return v12:GetAttribute("MutationFXDontRender") == true
end

local function ensureUnionUsePartColor(v13) -- line 28
    if v13:IsA("UnionOperation") then
        if v13:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
            v13:SetAttribute("Cleanup_OriginalUserPartColor", v13.UsePartColor)
        end
        v13.UsePartColor = true
    end
end

local function restoreUnionUsePartColor(v14) -- line 37
    if v14:IsA("UnionOperation") then
        local Cleanup_OriginalUserPartColor = v14:GetAttribute("Cleanup_OriginalUserPartColor")
        if typeof(Cleanup_OriginalUserPartColor) == "boolean" then
            v14.UsePartColor = Cleanup_OriginalUserPartColor
            v14:SetAttribute("Cleanup_OriginalUserPartColor", nil)
        end
    end
end

local function rollColor(v15, v16) -- line 48
    return v16.Darker:Lerp(v16.Lighter, v15:NextNumber())
end

local function applyPaletteColor(v17, v18) -- line 51 | captures: v7, v5
    if v17:IsA("UnionOperation") then
        if v17:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
            v17:SetAttribute("Cleanup_OriginalUserPartColor", v17.UsePartColor)
        end
        v17.UsePartColor = true
    end
    local v19 = v7 or v5
    v17.Color = v18.Darker:Lerp(v18.Lighter, v19:NextNumber())
end

local function getMaterialByName(v20) -- line 64
    for v21, v22 in Enum.Material:GetEnumItems() do
        if v22.Name == v20 then
            return v22
        end
    end
    return nil
end

local function getStoredOriginalMaterial(v23) -- line 72
    for v24, v25 in { "Mutation_OriginalMaterial", "OriginalMaterial", "Original_Material" } do
        local v26 = v23:GetAttribute(v25)
        if typeof(v26) == "string" then
            for v27, v28 in Enum.Material:GetEnumItems() do
                if v28.Name == v26 then
                    if v28 then
                        return v28
                    end
                    break
                end
            end
        elseif typeof(v26) == "EnumItem" and v26.EnumType == Enum.Material then
            return v26
        end
    end
    return nil
end

local function getStoredOriginalMaterialVariant(v29) -- line 97
    local Mutation_OriginalMaterialVariant = v29:GetAttribute("Mutation_OriginalMaterialVariant")
    if typeof(Mutation_OriginalMaterialVariant) == "string" then
        return Mutation_OriginalMaterialVariant
    end
    return nil
end

local function setAndSaveMaterial(v30, v31) -- line 104
    if not v30:GetAttribute("Mutation_OriginalMaterial") then
        v30:SetAttribute("Mutation_OriginalMaterial", v30.Material.Name)
    end
    v30.Material = v31
end

local function setAndSaveMaterialVariant(v32, v33) -- line 110
    if not v32:GetAttribute("Mutation_OriginalMaterialVariant") then
        v32:SetAttribute("Mutation_OriginalMaterialVariant", v32.MaterialVariant)
    end
    v32.MaterialVariant = v33
end

local function hasMetalVisual(v34) -- line 116
    return v34:HasTag("GoldenVisual") or v34:HasTag("SilverVisual")
end

local function setMetalMaterialVariant(v35) -- line 123
    if not v35:GetAttribute("Mutation_OriginalMaterialVariant") then
        v35:SetAttribute("Mutation_OriginalMaterialVariant", v35.MaterialVariant)
    end
    v35.MaterialVariant = "Custom Stud 100%"
end

local function getPartVolume(v36) -- line 129
    local Size = v36.Size
    return Size.X * Size.Y * Size.Z
end

local function collectMetalSizeGroups(v37) -- line 133
    local v38 = {}
    for v39, v40 in v37:GetDescendants() do
        if v40:IsA("BasePart") and v40.Transparency < 1 and not v40:HasTag("Effect") and not (v40:GetAttribute("MutationsDontModify") == true or v40:GetAttribute("DontAddTexture") == true or v40:GetAttribute("IsEye") == true or v40:GetAttribute("MutationFXDontRender") == true) then
            table.insert(v38, v40)
        end
    end
    table.sort(v38, function(v41, v42) -- line 144
        local Size = v41.Size
        local v43 = Size.X * Size.Y * Size.Z
        local Size_2 = v42.Size
        return Size_2.X * Size_2.Y * Size_2.Z < v43
    end)
    local v44 = {}
    local v45 = 0
    for v46, v47 in v38 do
        local Size = v47.Size
        local v48 = Size.X * Size.Y * Size.Z
        local v49 = v44[#v44]
        if v49 then
            local v50 = v49.PartVolume - v48
            if math.abs(v50) <= 0.001 then
                local Parts = v49.Parts
                table.insert(Parts, v47)
                v49.Weight += v48
            end
        else
            local v51 = {
                Parts = { v47 },
                PartVolume = v48,
                Weight = v48
            }
            table.insert(v44, v51)
        end
        v45 += v48
    end
    table.sort(v44, function(v52, v53) -- line 177
        return v53.Weight < v52.Weight
    end)
    return v44, v45
end

local function getSilverComboParts(v54, v55) -- line 183 | captures: v8, collectMetalSizeGroups
    local v56, v57 = collectMetalSizeGroups(v54)
    local v58 = Random.new(v8.SeedFor(v55, "GoldenSilverPartition"))
    local v59 = {}
    local v60, v61 = v57 / 2, v57 / 2
    for v62, v63 in v56 do
        local v64 = v60 - v61
        local v65 = if math.abs(v64) > 0.001 then v61 < v60 else v58:NextNumber() < 0.5
        if v65 then
            for v66, v67 in v63.Parts do
                v59[v67] = true
            end
            v60 -= v63.Weight
        else
            v61 -= v63.Weight
        end
    end
    return v59
end

local function getNamedSurfaceAppearance(v68, v69) -- line 215
    local v70
    for v71, v72 in v68:GetDescendants() do
        if v72:IsA("SurfaceAppearance") and v72.Name == v69 then
            local v73 = v70 == nil
            local v74 = ("%* contains multiple %* SurfaceAppearances"):format(v68:GetFullName(), v69)
            assert(v73, v74)
            v70 = v72
        end
    end
    local v75 = v70 ~= nil
    local v76 = ("%* must contain a %* SurfaceAppearance"):format(v68:GetFullName(), v69)
    assert(v75, v76)
    return v70
end

local function getTextureOverrideVisualModel(v77) -- line 232
    if v77.Name == "Model" then
        return v77
    end
    local Model = v77:FindFirstChild("Model")
    local v78
    if Model == nil then
        v78 = false
    else
        v78 = Model:IsA("Model")
    end
    local v79 = ("%* enables TexturesOverride but has no direct Model child"):format((v77:GetFullName()))
    assert(v78, v79)
    return Model
end

local function getOriginalSurfaceAppearance(v80, v81, v82, v83, v84) -- line 242
    local v85
    for v86, v87 in v80:GetDescendants() do
        if v87:IsA("SurfaceAppearance") and v87:GetAttribute("Mutation_OriginalSurfaceAppearance") == true then
            local v88 = v85 == nil
            local v89 = ("%* contains multiple original SurfaceAppearances"):format((v80:GetFullName()))
            assert(v88, v89)
            v85 = v87
        end
    end
    if v85 == nil then
        local v90 = v85
        for v91, v92 in v81:GetChildren() do
            if v92:IsA("SurfaceAppearance") and not (v92 == v82 or v92 == v83 or v92 == v84) then
                local v93 = v90 == nil
                local v94 = ("%* contains multiple original SurfaceAppearances"):format((v81:GetFullName()))
                assert(v93, v94)
                v90 = v92
            end
            v85 = v90
        end
    end
    local v95 = v85 ~= nil
    local v96 = ("%* must contain its original SurfaceAppearance"):format((v81:GetFullName()))
    assert(v95, v96)
    v85:SetAttribute("Mutation_OriginalSurfaceAppearance", true)
    return v85
end

local function getTextureOverrideBindings(v97) -- line 267 | captures: getNamedSurfaceAppearance, getOriginalSurfaceAppearance
    local v98 = {}
    if v97:IsA("Model") and v97:GetAttribute("TexturesOverride") == true then
        table.insert(v98, v97)
    end
    for v99, v100 in v97:GetDescendants() do
        if v100:IsA("Model") and v100:GetAttribute("TexturesOverride") == true then
            table.insert(v98, v100)
        end
    end
    if #v98 == 0 then
        return nil
    end
    local v101 = {}
    local v102 = {}
    for v103, v104 in v98 do
        local Model
        if v104.Name == "Model" then
            Model = v104
        else
            Model = v104:FindFirstChild("Model")
            local v105
            if Model == nil then
                v105 = false
            else
                v105 = Model:IsA("Model")
            end
            local v106 = ("%* enables TexturesOverride but has no direct Model child"):format((v104:GetFullName()))
            assert(v105, v106)
        end
        if not v102[Model] then
            v102[Model] = true
            local v107 = Model:FindFirstChildWhichIsA("MeshPart", true)
            local v108 = v107 ~= nil
            local v109 = ("%* must contain a MeshPart for texture overrides"):format((Model:GetFullName()))
            assert(v108, v109)
            local GoldTextureOverride = getNamedSurfaceAppearance(Model, "GoldTextureOverride")
            local SilverTextureOverride = getNamedSurfaceAppearance(Model, "SilverTextureOverride")
            local GoldSilverTextureOverride = getNamedSurfaceAppearance(Model, "GoldSilverTextureOverride")
            local v110 = {
                VisualModel = Model,
                TargetMesh = v107,
                Original = getOriginalSurfaceAppearance(Model, v107, GoldTextureOverride, SilverTextureOverride, GoldSilverTextureOverride),
                Golden = GoldTextureOverride,
                Silver = SilverTextureOverride,
                GoldenSilver = GoldSilverTextureOverride
            }
            table.insert(v101, v110)
        end
    end
    local v111 = #v101 > 0
    local v112 = ("%* enables TexturesOverride but has no texture override bindings"):format((v97:GetFullName()))
    assert(v111, v112)
    return v101
end

local function getActiveSurfaceAppearance(v113) -- line 319
    local v114
    for v115, v116 in v113.TargetMesh:GetChildren() do
        if v116:IsA("SurfaceAppearance") then
            local v117 = v114 == nil
            local v118 = ("%* contains multiple active SurfaceAppearances"):format((v113.TargetMesh:GetFullName()))
            assert(v117, v118)
            v114 = v116
        end
    end
    local v119 = v114 ~= nil
    local v120 = ("%* must contain one active SurfaceAppearance"):format((v113.TargetMesh:GetFullName()))
    assert(v119, v120)
    return v114
end

local function setActiveSurfaceAppearance(v121, v122) -- line 334 | captures: getActiveSurfaceAppearance
    local v123 = getActiveSurfaceAppearance(v121)
    if v123 == v122 then
        return
    end
    local Cleanup_Rainbow = v123:HasTag("Cleanup_Rainbow")
    if Cleanup_Rainbow then
        v123:RemoveTag("RainbowPart")
        v123:RemoveTag("Cleanup_Rainbow")
    end
    v123.Parent = v121.VisualModel
    v122.Parent = v121.TargetMesh
    if Cleanup_Rainbow then
        v122:AddTag("RainbowPart")
        v122:AddTag("Cleanup_Rainbow")
    end
end

local function applyMetalTextureOverride(v124, v125, v126) -- line 351 | captures: setActiveSurfaceAppearance
    for v127, v128 in v124 do
        local v129 = v125(v128)
        if v126 ~= nil then
            v129:AddTag(v126)
        end
        setActiveSurfaceAppearance(v128, v129)
    end
end

local function removeMetalTextureOverride(v130, v131, v132, v133, v134) -- line 365 | captures: setActiveSurfaceAppearance
    for v135, v136 in v130 do
        local v137 = v131(v136)
        if v137:HasTag(v133) then
            v137:RemoveTag(v133)
            local v138 = v132(v136)
            if v138:HasTag(v134) then
                setActiveSurfaceAppearance(v136, v138)
            else
                setActiveSurfaceAppearance(v136, v136.Original)
            end
        end
    end
end

local function hasVisualTag(v139, v140) -- line 383
    for v141, v142 in v139:GetDescendants() do
        if v142:HasTag(v140) then
            return true
        end
    end
    return false
end

local function getStoredOriginalColor(v143) -- line 391
    local OriginalColor = v143:GetAttribute("OriginalColor")
    if typeof(OriginalColor) == "Color3" then
        return OriginalColor
    end
    return nil
end

local function cloneFxInto(v144, v145, v146, v147) -- line 398 | captures: ReplicatedStorage, t
    t.strict(t.instanceIsA("BasePart"))(v144)
    t.strict(t.string)(v145)
    t.strict(t.string)(v146)
    local Mutations = ReplicatedStorage:FindFirstChild("Mutations")
    assert(Mutations, "Mutations folder is missing from ReplicatedStorage")
    local v148 = Mutations:FindFirstChild(v145)
    local v149 = ("Mutation FX container \"%*\" not found in Mutations"):format(v145)
    assert(v148, v149)
    for v150, v151 in v148:GetChildren() do
        local v152 = v151:Clone()
        v152.Parent = v144
        if v147 then
            v152.Enabled = true
        end
        v152:AddTag(v6)
        v152:AddTag("Effect")
    end
end

local function destroyTagged(v153, v154, v155) -- line 421
    local v156
    if v155 then
        v156 = v153:GetDescendants()
    else
        v156 = v153:GetChildren()
    end
    for v157, v158 in v156 do
        if v158:HasTag(v154) then
            v158:Destroy()
        end
    end
end

local v159 = {
    FxFolder = "Golden",
    CleanupTag = "Cleanup_GoldenFX",
    VisualTag = "GoldenVisual",
    PartnerVisualTag = "SilverVisual",
    Palette = v2,
    SelectAppearance = function(v160) -- SelectAppearance | line 443
        return v160.Golden
    end,
    SelectPartnerAppearance = function(v161) -- SelectPartnerAppearance | line 446
        return v161.Silver
    end
}
local v162 = {
    FxFolder = "Silver",
    CleanupTag = "Cleanup_SilverFX",
    VisualTag = "SilverVisual",
    PartnerVisualTag = "GoldenVisual",
    Palette = v4,
    SelectAppearance = function(v163) -- SelectAppearance | line 456
        return v163.Silver
    end,
    SelectPartnerAppearance = function(v164) -- SelectPartnerAppearance | line 459
        return v164.Golden
    end
}

local function clearMetal(v165, v166, v167) -- line 463 | captures: getStoredOriginalMaterial, getTextureOverrideBindings, removeMetalTextureOverride, destroyTagged
    if v166 then
        destroyTagged(v166, v167.CleanupTag)
    end
    local v168 = getTextureOverrideBindings(v165)
    if v168 == nil then
        for v169, v170 in v165:GetDescendants() do
            if v170:IsA("BasePart") and v170:HasTag(v167.VisualTag) then
                v170:RemoveTag(v167.VisualTag)
                local Mutation_OriginalColor = v170:GetAttribute("Mutation_OriginalColor")
                if typeof(Mutation_OriginalColor) == "Color3" then
                    v170.Color = Mutation_OriginalColor
                end
                local v171 = getStoredOriginalMaterial(v170)
                if v171 then
                    v170.Material = v171
                end
                local Mutation_OriginalMaterialVariant = v170:GetAttribute("Mutation_OriginalMaterialVariant")
                if typeof(Mutation_OriginalMaterialVariant) ~= "string" then
                    Mutation_OriginalMaterialVariant = nil
                end
                if Mutation_OriginalMaterialVariant then
                    v170.MaterialVariant = Mutation_OriginalMaterialVariant
                end
                if v170:IsA("UnionOperation") then
                    local Cleanup_OriginalUserPartColor = v170:GetAttribute("Cleanup_OriginalUserPartColor")
                    if typeof(Cleanup_OriginalUserPartColor) == "boolean" then
                        v170.UsePartColor = Cleanup_OriginalUserPartColor
                        v170:SetAttribute("Cleanup_OriginalUserPartColor", nil)
                    end
                end
            end
        end
    else
        removeMetalTextureOverride(v168, v167.SelectAppearance, v167.SelectPartnerAppearance, v167.VisualTag, v167.PartnerVisualTag)
    end
end

local function applyMetal(v172, v173, v174) -- line 504 | captures: v7, v5, getTextureOverrideBindings, applyMetalTextureOverride, cloneFxInto, clearMetal
    clearMetal(v172, v173, v174)
    if v173 then
        cloneFxInto(v173, v174.FxFolder, v174.CleanupTag)
    end
    local v175 = getTextureOverrideBindings(v172)
    if v175 == nil then
        for v176, v177 in v172:GetDescendants() do
            if v177:IsA("BasePart") then
                if not v177:HasTag("Effect") and not (v177:GetAttribute("MutationsDontModify") == true or v177:GetAttribute("DontAddTexture") == true or v177:GetAttribute("IsEye") == true or v177:GetAttribute("MutationFXDontRender") == true) then
                    local Palette = v174.Palette
                    if v177:IsA("UnionOperation") then
                        if v177:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
                            v177:SetAttribute("Cleanup_OriginalUserPartColor", v177.UsePartColor)
                        end
                        v177.UsePartColor = true
                    end
                    local v178 = v7 or v5
                    v177.Color = Palette.Darker:Lerp(Palette.Lighter, v178:NextNumber())
                    if not v177:GetAttribute("Mutation_OriginalMaterial") then
                        v177:SetAttribute("Mutation_OriginalMaterial", v177.Material.Name)
                    end
                    v177.Material = Enum.Material.SmoothPlastic
                    if not v177:GetAttribute("Mutation_OriginalMaterialVariant") then
                        v177:SetAttribute("Mutation_OriginalMaterialVariant", v177.MaterialVariant)
                    end
                    v177.MaterialVariant = "Custom Stud 100%"
                    v177:AddTag(v174.VisualTag)
                    if v177:IsA("MeshPart") then
                        v177.TextureID = ""
                    end
                end
            elseif v177:IsA("SurfaceAppearance") then
                local Parent = v177.Parent
                if Parent and not (Parent:GetAttribute("MutationsDontModify") == true or Parent:GetAttribute("DontAddTexture") == true or Parent:GetAttribute("IsEye") == true or Parent:GetAttribute("MutationFXDontRender") == true) then
                    v177:Destroy()
                end
            end
        end
    else
        applyMetalTextureOverride(v175, v174.SelectAppearance, v174.VisualTag)
    end
end

local function tintModel(v179, v180, v181) -- line 558
    for v182, v183 in v179:GetDescendants() do
        if v183:IsA("BasePart") and not v183:HasTag("NoTint") then
            local OriginalColor = v183:GetAttribute("OriginalColor")
            if typeof(OriginalColor) ~= "Color3" then
                OriginalColor = nil
            end
            if not OriginalColor then
                v183:SetAttribute("OriginalColor", v183.Color)
                OriginalColor = v183.Color
            end
            v183.Color = OriginalColor:Lerp(v180, v181)
            local SurfaceAppearance = v183:FindFirstChildOfClass("SurfaceAppearance")
            if SurfaceAppearance then
                if SurfaceAppearance:GetAttribute("Tint_OriginalSurfaceColor") == nil then
                    SurfaceAppearance:SetAttribute("Tint_OriginalSurfaceColor", SurfaceAppearance.Color)
                end
                SurfaceAppearance.Color = v180
            elseif v183:IsA("MeshPart") and v183.TextureID ~= "" then
                v183:SetAttribute("Tint_OriginalTextureId", v183.TextureID)
                v183.TextureID = ""
            end
        end
    end
end

local function clearTint(v184) -- line 590
    for v185, v186 in v184:GetDescendants() do
        if v186:IsA("BasePart") and not v186:HasTag("NoTint") then
            local OriginalColor = v186:GetAttribute("OriginalColor")
            if typeof(OriginalColor) ~= "Color3" then
                OriginalColor = nil
            end
            if OriginalColor then
                v186:SetAttribute("OriginalColor", nil)
                v186.Color = OriginalColor
            end
            local SurfaceAppearance = v186:FindFirstChildOfClass("SurfaceAppearance")
            if SurfaceAppearance then
                local v187 = SurfaceAppearance:GetAttribute("Tint_OriginalSurfaceColor")
                if typeof(v187) == "Color3" then
                    SurfaceAppearance.Color = v187
                    SurfaceAppearance:SetAttribute("Tint_OriginalSurfaceColor", nil)
                end
            end
            local Tint_OriginalTextureId = v186:GetAttribute("Tint_OriginalTextureId")
            if v186:IsA("MeshPart") and typeof(Tint_OriginalTextureId) == "string" then
                v186.TextureID = Tint_OriginalTextureId
                v186:SetAttribute("Tint_OriginalTextureId", nil)
            end
        end
    end
end

function v8.SeedFor(v188, v189) -- line 622 | captures: Crc32
    local v190 = Crc32((("MutationVisual/%*/%*"):format(v188, v189)))
    local v191 = math.abs(v190) % 2147483647
    if v191 > 0 then
        return v191
    end
    return 1
end

function v8.WithVisualRandom(v192, v193) -- line 629 | captures: v7
    if v192 ~= nil then
        v7 = v192
    end
    local v194, v195 = pcall(v193)
    if not v194 then
        error(v195, 0)
    end
end

function v8.GetFXPart(v196) -- line 640 | captures: Bounds, Constants, v1
    if v196 then
        local FXPart = v196:FindFirstChild("FXPart")
        if FXPart then
            if FXPart:IsA("BasePart") then
                return FXPart
            end
            return
        end
        local v197
        if v196:IsA("Tool") then
            v197 = v196:FindFirstChild("Handle") or v196:FindFirstChild("Segment1")
        elseif v196:IsA("Model") then
            v197 = v196.PrimaryPart
        end
        if v197 then
            local v198 = {}
            for v199, v200 in ipairs(v196:GetDescendants()) do
                if v200:IsA("BasePart") and v200.Transparency < 1 and v200:GetAttribute("MutationFXDontRender") ~= true then
                    table.insert(v198, v200)
                end
            end
            local v201, v202
            if #v198 <= 0 then
                v201, v202 = v196:GetBoundingBox()
            else
                v201, v202 = Bounds(v198)
            end
            local Part = Instance.new("Part")
            Part.Name = "FXPart"
            Part.CFrame = v201
            Part.Size = v202
            Part.Transparency = 1
            Part.CanCollide = false
            Part.CanTouch = false
            Part.CanQuery = false
            Part.Anchored = false
            Part.Massless = true
            Part.Parent = v196
            local WeldConstraint = Instance.new("WeldConstraint")
            WeldConstraint.Part0 = Part
            WeldConstraint.Part1 = v197
            WeldConstraint.Parent = Part
            return Part
        end
        local v203 = ("Mutations.Visuals.GetFXPart | No primary part found for item '%*'"):format(v196.Name)
        if Constants.IS_STUDIO then
            error(v203)
        else
            v1:AtError():Log(v203)
        end
    else
        warn("Mutations.Visuals.GetFXPart | No item given")
    end
    return nil
end

function v8.ApplyGolden(v204, v205) -- line 704 | captures: v159, applyMetal
    applyMetal(v204, v205, v159)
end

function v8.ClearGolden(v206, v207) -- line 707 | captures: v159, clearMetal
    clearMetal(v206, v207, v159)
end

function v8.ApplySilver(v208, v209) -- line 710 | captures: v162, applyMetal
    applyMetal(v208, v209, v162)
end

function v8.ClearSilver(v210, v211) -- line 713 | captures: v162, clearMetal
    clearMetal(v210, v211, v162)
end

local function ShouldApplyMetalCombo(v212, v213) -- line 716
    if v213 == "Golden" then
        for v214, v215 in v212:GetDescendants() do
            if v215:HasTag("SilverVisual") then
                return true
            end
        end
    elseif v213 == "Silver" then
        for v216, v217 in v212:GetDescendants() do
            if v217:HasTag("GoldenVisual") then
                return true
            end
        end
    end
    return false
end

v8.ShouldApplyMetalCombo = ShouldApplyMetalCombo

function v8.ApplyMetalCombo(v218, v219) -- line 735 | captures: v2, v4, v8, getSilverComboParts, getTextureOverrideBindings, setActiveSurfaceAppearance, v159, v162
    local v220 = getTextureOverrideBindings(v218)
    if v220 == nil then
        local v221 = getSilverComboParts(v218, v219)
        local v222 = Random.new(v8.SeedFor(v219, v159.FxFolder))
        local v223 = Random.new(v8.SeedFor(v219, v162.FxFolder))
        for v224, v225 in v218:GetDescendants() do
            if v225:IsA("BasePart") and not v225:HasTag("Effect") and not (v225:GetAttribute("MutationsDontModify") == true or v225:GetAttribute("DontAddTexture") == true or v225:GetAttribute("IsEye") == true or v225:GetAttribute("MutationFXDontRender") == true) then
                if v225:IsA("UnionOperation") then
                    if v225:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
                        v225:SetAttribute("Cleanup_OriginalUserPartColor", v225.UsePartColor)
                    end
                    v225.UsePartColor = true
                end
                if v221[v225] then
                    v225.Color = v4.Darker:Lerp(v4.Lighter, v223:NextNumber())
                else
                    v225.Color = v2.Darker:Lerp(v2.Lighter, v222:NextNumber())
                end
            end
        end
    else
        local function v3(v226) -- line 739
            return v226.GoldenSilver
        end

        for v227, v228 in v220 do
            setActiveSurfaceAppearance(v228, v228.GoldenSilver)
        end
    end
end

function v8.ApplyRainbow(v229, v230) -- line 775 | captures: v8, getTextureOverrideBindings, getActiveSurfaceAppearance, cloneFxInto
    v8.ClearRainbow(v229, v230)
    if v230 then
        cloneFxInto(v230, "Rainbow", "Cleanup_RainbowFX")
    end
    local v231 = getTextureOverrideBindings(v229)
    if v231 == nil then
        for v232, v233 in v229:GetDescendants() do
            if v233:IsA("BasePart") and v233:GetAttribute("DontAddTexture") ~= true then
                if v233:IsA("UnionOperation") then
                    if v233:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
                        v233:SetAttribute("Cleanup_OriginalUserPartColor", v233.UsePartColor)
                    end
                    v233.UsePartColor = true
                end
                v233:AddTag("RainbowPart")
                v233:AddTag("Cleanup_Rainbow")
                if v233:HasTag("GoldenVisual") or v233:HasTag("SilverVisual") then
                    if not v233:GetAttribute("Mutation_OriginalMaterialVariant") then
                        v233:SetAttribute("Mutation_OriginalMaterialVariant", v233.MaterialVariant)
                    end
                    v233.MaterialVariant = "Custom Stud 100%"
                end
            end
        end
    else
        for v234, v235 in v231 do
            local v236 = getActiveSurfaceAppearance(v235)
            v236:AddTag("RainbowPart")
            v236:AddTag("Cleanup_Rainbow")
        end
    end
end

function v8.ClearRainbow(v237, v238) -- line 816 | captures: getTextureOverrideBindings, destroyTagged
    if v238 then
        destroyTagged(v238, "Cleanup_RainbowFX")
    end
    local v239 = getTextureOverrideBindings(v237)
    if v239 == nil then
        for v240, v241 in v237:GetDescendants() do
            if v241:IsA("BasePart") and v241:HasTag("Cleanup_Rainbow") then
                if v241:IsA("UnionOperation") then
                    local Cleanup_OriginalUserPartColor = v241:GetAttribute("Cleanup_OriginalUserPartColor")
                    if typeof(Cleanup_OriginalUserPartColor) == "boolean" then
                        v241.UsePartColor = Cleanup_OriginalUserPartColor
                        v241:SetAttribute("Cleanup_OriginalUserPartColor", nil)
                    end
                end
                v241:RemoveTag("RainbowPart")
                v241:RemoveTag("Cleanup_Rainbow")
                if v241:HasTag("GoldenVisual") or v241:HasTag("SilverVisual") then
                    if not v241:GetAttribute("Mutation_OriginalMaterialVariant") then
                        v241:SetAttribute("Mutation_OriginalMaterialVariant", v241.MaterialVariant)
                    end
                    v241.MaterialVariant = "Custom Stud 100%"
                end
            end
        end
    else
        for v242, v243 in v239 do
            for v244, v245 in {
                    v243.Original,
                    v243.Golden,
                    v243.Silver,
                    v243.GoldenSilver
                } do
                if v245:HasTag("Cleanup_Rainbow") then
                    v245:RemoveTag("RainbowPart")
                    v245:RemoveTag("Cleanup_Rainbow")
                end
            end
        end
    end
end

function v8.ApplyTint(v246, v247, v248) -- line 864 | captures: tintModel
    tintModel(v246, v247, v248)
end

function v8.ClearTint(v249) -- line 867 | captures: clearTint
    clearTint(v249)
end

function v8.ApplyBloom(v250, v251, v252, v253, v254, v255) -- line 870 | captures: ReplicatedStorage, v8, cloneFxInto, tintModel
    v8.ClearBloom(v250, v251, v253)
    if v251 then
        local Mutations = ReplicatedStorage:FindFirstChild("Mutations")
        if Mutations and Mutations:FindFirstChild(v252) then
            cloneFxInto(v251, v252, v253, true)
        end
    end
    tintModel(v250, v254, v255 or 0.65)
end

function v8.ClearBloom(v256, v257, v258) -- line 884 | captures: destroyTagged, clearTint
    clearTint(v256)
    if v257 then
        destroyTagged(v257, v258, true)
    end
    destroyTagged(v256, v258, true)
end

return v8
