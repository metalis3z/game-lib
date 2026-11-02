-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local PickWeightedWith = require(ReplicatedStorage.Shared.Utils.Numeric).PickWeightedWith
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = t.strict(t.Color3)
local v3 = t.strict(t.optional(t.number))
local v4 = t.strict(t.optional(t.string))
local v5 = t.strict(t.instanceIsA("Model"))
local v6 = t.strict(t.number)
local v7 = t.strict(t.string)
local v8 = {}

local function speciesEntry(v9) -- line 19 | captures: Assets
    local v10 = Assets.Directory[v9]
    local v11 = v10 ~= nil
    local v12 = ("Asset catalog carries no palette named %*"):format(v9)
    assert(v11, v12)
    return v10
end

local function wearsIris(v13) -- line 25
    if v13:GetAttribute("IsEye") == true then
        return true
    end
    local v14 = string.lower(v13.Name)
    return string.find(v14, "eye", 1, true) ~= nil
end

local function wearsBaseCoat(v15, v16) -- line 33
    local v17, v18, v19 = v15:ToHSV()
    local v20, v21, v22 = v16:ToHSV()
    local v23 = v18 < 0.16
    if v21 < 0.16 then
        if v23 then
            if v22 < 0.08 then
                return v19 <= 0.08
            end
            local v24 = v19 - v22
            return math.abs(v24) <= 0.18
        end
        return v23
    end
    local v25 = v17 - v20
    local v26 = math.abs(v25)
    local v27 = v19 / math.max(v22, 0.001)
    local v28 = not v23
    if v28 then
        local v29 = 1 - v26
        if math.min(v26, v29) <= 0.08 and v27 >= 0.08 then
            return v27 <= 1.6
        end
        v28 = false
    end
    return v28
end

local function tint(v30, v31, v32, v33, v34) -- line 63
    local v35, v36, v37 = v30.Color:ToHSV()
    _ = v35
    _ = v36
    local v38, v39, v40 = v31:ToHSV()
    _ = v38
    _ = v39
    local v41, v42, v43 = v32:ToHSV()
    if v40 >= 0.08 then
        v43 *= v37 / math.max(v40, 0.001)
    end
    local v44 = v43 * Random.new(v33 + 7919 + v34):NextNumber(0.8333333333333334, 1.2)
    v30.Color = Color3.fromHSV(v41, v42, (math.clamp(v44, 0, 1)))
    if v30:IsA("UnionOperation") then
        v30.UsePartColor = true
    end
end

function v8.DrawEyeColorHex(v45) -- line 79 | captures: t
    local v46 = t.Random(v45)
    assert(v46, "An iris draw needs a generator to draw from")
    local v47 = v45:NextNumber()
    local v48 = v45:NextNumber(0.35, 0.85)
    local v49 = v45:NextNumber(0.35, 0.9)
    return Color3.fromHSV(v47, v48, v49):ToHex()
end

function v8.DrawColorSeed(v50) -- line 87 | captures: t
    local v51 = t.Random(v50)
    assert(v51, "A colour seed draw needs a generator to draw from")
    return v50:NextInteger(1, 2147483647)
end

function v8.DrawColorIndex(v52, v53) -- line 92 | captures: Assets, t, PickWeightedWith, v7
    v7(v52)
    local v54 = t.Random(v53)
    assert(v54, "A palette slot draw needs a generator to draw from")
    local v55 = Assets.Directory[v52]
    local v56 = v55 ~= nil
    local v57 = ("Asset catalog carries no palette named %*"):format(v52)
    assert(v56, v57)
    local v58, v59, v60, v61 = PickWeightedWith(v53, v55.PossibleModelColors)
    _ = v58
    _ = v59
    _ = v60
    return v61
end

function v8.DrawFields(v62, v63) -- line 103 | captures: t, v7, v8
    v7(v62)
    local v64 = t.Random(v63)
    assert(v64, "A palette draw needs a generator to draw from")
    return {
        EyeColor = v8.DrawEyeColorHex(v63),
        ColorSeed = v8.DrawColorSeed(v63),
        ColorIndex = v8.DrawColorIndex(v62, v63)
    }
end

function v8.SettleFields(v65, v66, v67, v68) -- line 109 | captures: v3, v4, v7, v8
    v7(v65)
    v4(v66)
    v3(v67)
    v3(v68)
    local v69 = if v67 == nil then 1 else v67
    local v70
    if v66 == nil or v66 == "" then
        v70 = v8.DrawEyeColorHex(Random.new(v69))
    else
        v70 = v66
    end
    local v71 = {
        EyeColor = v70,
        ColorSeed = v69
    }
    if v68 == nil then
        v71.ColorIndex = 1
    else
        v71.ColorIndex = v68
    end
    return v71
end

function v8.ModelColorAt(v72, v73) -- line 136 | captures: Assets, Constants, v2, v6, v7
    v7(v72)
    v6(v73)
    local v74 = Assets.Directory[v72]
    local v75 = v74 ~= nil
    local v76 = ("Asset catalog carries no palette named %*"):format(v72)
    assert(v75, v76)
    local PossibleModelColors = v74.PossibleModelColors
    if #PossibleModelColors == 0 or v73 <= 0 then
        return nil
    end
    if Constants.IS_STUDIO then
        local v77 = PossibleModelColors[v73]
        local v78 = ("Palette for %* stops short of slot %*"):format(v72, v73)
        assert(v77, v78)
    end
    local v79 = PossibleModelColors[(v73 - 1) % #PossibleModelColors + 1][1]
    v2(v79)
    return v79
end

function v8.PaintModel(v80, v81, v82, v83, v84) -- line 153 | captures: Assets, v1, v5, v6, v7, v8, wearsBaseCoat, tint
    v5(v80)
    v7(v81)
    v7(v82)
    v6(v83)
    v6(v84)
    local v85 = Assets.Directory[v81]
    local v86 = v85 ~= nil
    local v87 = ("Asset catalog carries no palette named %*"):format(v81)
    assert(v86, v87)
    local v88 = Color3.fromHex(v82)
    local v89 = v8.ModelColorAt(v81, v84)
    local v90 = Random.new(v83):NextNumber() < 0.5
    local v91 = 0
    for v92, v93 in v80:GetDescendants() do
        local v94 = if v93:IsA("BasePart") then v93 else nil
        if not (v94 == nil or v94:GetAttribute("DontModify")) and v94.Transparency < 1 then
            v91 += 1
            local v95
            if v94:GetAttribute("IsEye") == true then
                v95 = true
            else
                local v96 = string.lower(v94.Name)
                v95 = string.find(v96, "eye", 1, true) ~= nil
            end
            if v95 then
                if v90 then
                    v94.Color = v88
                end
            elseif v89 ~= nil then
                if v89 == v1 then
                    if v85.AlbinosColorFullWhite then
                        v94.Color = v89
                    end
                elseif wearsBaseCoat(v94.Color, v85.BaseModelColor) then
                    tint(v94, v85.BaseModelColor, v89, v83, v91)
                end
            end
        end
    end
end

return v8
