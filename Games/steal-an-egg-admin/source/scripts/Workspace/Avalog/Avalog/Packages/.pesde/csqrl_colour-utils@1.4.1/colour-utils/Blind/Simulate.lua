-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Configs = require(script.Configs)
local Enum = require(script.Parent.Enum)

local function RGBtoXYZ(v1) -- line 20 | captures: Configs
    local RGB_XYZ = Configs.Matrix.RGB_XYZ
    local R = v1.R
    local G = v1.G
    local B = v1.B
    local v2 = if R > 0.04 then ((R + 0.055) / 1.055) ^ 2.4 else R / 12.92
    local v3 = if G > 0.04 then ((G + 0.055) / 1.055) ^ 2.4 else G / 12.92
    local v4 = if B > 0.04 then ((B + 0.055) / 1.055) ^ 2.4 else B / 12.92
    local v5 = v2 * RGB_XYZ[1] + v3 * RGB_XYZ[4] + v4 * RGB_XYZ[7]
    local v6 = v2 * RGB_XYZ[2] + v3 * RGB_XYZ[5] + v4 * RGB_XYZ[8]
    local v7 = v2 * RGB_XYZ[3] + v3 * RGB_XYZ[6] + v4 * RGB_XYZ[9]
    return (Vector3.new(v5, v6, v7))
end

local function XYZtoXyY(v8) -- line 34
    local v9 = v8.X + v8.Y + v8.Z
    if v9 == 0 then
        return {
            X = 0,
            y = 0,
            Y = v8.Y
        }
    end
    return {
        X = v8.X / v9,
        y = v8.Y / v9,
        Y = v8.Y
    }
end

local function Anomalise(v10, v11, v12) -- line 52
    local v13 = if type(v12) == "number" then v12 else 1.75
    local v14 = v13 + 1
    return Color3.new((v13 * v11.R + v10.R) / v14, (v13 * v11.G + v10.G) / v14, (v13 * v11.B + v10.B) / v14)
end

local function SimulateBlinder(v15, v16) -- line 72 | captures: Configs, Enum, RGBtoXYZ, XYZtoXyY, Anomalise
    local v17 = typeof(v15) == "Color3"
    assert(v17, "Color must be a Color3")
    local v18 = typeof(v16) == "number"
    assert(v18, "Blinder must be a number (see Enums.Blind)")
    local v19 = Configs.Groups[v16]
    local v20 = Configs.Anomalised[v16]
    if v19 == Enum.Group.Trichroma then
        return v15
    end
    if v19 == Enum.Group.Achroma then
        local v21 = v15.R * 0.213 + v15.G * 0.715 + v15.B * 0.072
        local v22 = Color3.new(v21, v21, v21)
        if v20 then
            return Anomalise(v15, v22)
        end
        return v22
    end
    local v23 = Configs.Blinder[v19]
    local v24 = XYZtoXyY((RGBtoXYZ(v15)))
    local v25 = (v24.y - v23.Y) / (v24.X - v23.X)
    local v26 = v24.y - v24.X * v25
    local v27 = (v23.YI - v26) / (v25 - v23.M)
    local v28 = v25 * v27 + v26
    local v29 = {
        X = v27 * v24.Y / v28,
        Y = v24.Y,
        Z = (1 - (v27 + v28)) * v24.Y / v28
    }
    local v30 = v24.Y * 0.313 / 0.329
    local v31 = v24.Y * 0.358 / 0.329 - v29.Z
    local v32 = v30 - v29.X
    local XYZ_RGB = Configs.Matrix.XYZ_RGB
    local v33 = v32 * XYZ_RGB[1] + 0 * XYZ_RGB[4] + v31 * XYZ_RGB[7]
    local v34 = v32 * XYZ_RGB[2] + 0 * XYZ_RGB[5] + v31 * XYZ_RGB[8]
    local v35 = v32 * XYZ_RGB[3] + 0 * XYZ_RGB[6] + v31 * XYZ_RGB[9]
    v29.R = v29.X * XYZ_RGB[1] + v29.Y * XYZ_RGB[4] + v29.Z * XYZ_RGB[7]
    v29.G = v29.X * XYZ_RGB[2] + v29.Y * XYZ_RGB[5] + v29.Z * XYZ_RGB[8]
    v29.B = v29.X * XYZ_RGB[3] + v29.Y * XYZ_RGB[6] + v29.Z * XYZ_RGB[9]
    local v36 = if v29.R < 0 then 0 else 1
    local v37 = (v36 - v29.R) / v33
    local v38 = if v29.G < 0 then 0 else 1
    local v39 = (v38 - v29.G) / v34
    local v40 = if v29.B < 0 then 0 else 1
    local v41 = (v40 - v29.B) / v35
    if v37 > 1 or v37 < 0 then
        v37 = 0
    end
    if v39 > 1 or v39 < 0 then
        v39 = 0
    end
    if v41 > 1 or v41 < 0 then
        v41 = 0
    end
    if not (v39 < v37) then
        v37 = v39
    end
    if not (v37 < v41) then
        v41 = v37
    end
    v29.R += v41 * v33
    v29.G += v41 * v34
    v29.B += v41 * v35
    local v42
    if v29.R <= 0 then
        v42 = 0
    elseif v29.R >= 1 then
        v42 = 1
    else
        v42 = v29.R ^ (1 / Configs.Gamma_Correct)
    end
    v29.R = 255 * v42
    local v43
    if v29.G <= 0 then
        v43 = 0
    elseif v29.G >= 1 then
        v43 = 1
    else
        v43 = v29.G ^ (1 / Configs.Gamma_Correct)
    end
    v29.G = 255 * v43
    local v44
    if v29.B <= 0 then
        v44 = 0
    elseif v29.B >= 1 then
        v44 = 1
    else
        v44 = v29.B ^ (1 / Configs.Gamma_Correct)
    end
    v29.B = 255 * v44
    local v45 = Color3.fromRGB(v29.R or 0, v29.G or 0, v29.B or 0)
    if v20 then
        return Anomalise(v15, v45)
    end
    return v45
end

return SimulateBlinder
