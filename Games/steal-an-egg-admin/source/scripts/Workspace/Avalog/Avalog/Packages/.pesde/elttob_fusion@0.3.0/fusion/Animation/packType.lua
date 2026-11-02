-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local Oklab = require(Parent.Colour.Oklab)

local function packType(v1, v2) -- line 15 | captures: Oklab
    if v2 == "number" then
        return v1[1]
    end
    if v2 == "CFrame" then
        local v3 = CFrame.new(v1[1], v1[2], v1[3])
        local fromAxisAngle = CFrame.fromAxisAngle
        local v4 = v1[4]
        local v5 = v1[5]
        local v6 = v1[6]
        return v3 * fromAxisAngle(Vector3.new(v4, v5, v6).Unit, v1[7])
    end
    if v2 == "Color3" then
        local toSRGB = Oklab.toSRGB
        local v7 = v1[1]
        local v8 = v1[2]
        local v9 = v1[3]
        return toSRGB(Vector3.new(v7, v8, v9), false)
    end
    if v2 == "ColorSequenceKeypoint" then
        local new = ColorSequenceKeypoint.new
        local v10 = v1[4]
        local toSRGB = Oklab.toSRGB
        local v11 = v1[1]
        local v12 = v1[2]
        local v13 = v1[3]
        return new(v10, toSRGB(Vector3.new(v11, v12, v13), false))
    end
    if v2 == "DateTime" then
        return DateTime.fromUnixTimestampMillis(v1[1])
    end
    if v2 == "NumberRange" then
        return NumberRange.new(v1[1], v1[2])
    end
    if v2 == "NumberSequenceKeypoint" then
        return NumberSequenceKeypoint.new(v1[2], v1[1], v1[3])
    end
    if v2 == "PhysicalProperties" then
        return PhysicalProperties.new(v1[1], v1[2], v1[3], v1[4], v1[5])
    end
    if v2 == "Ray" then
        local new = Ray.new
        local v14 = v1[1]
        local v15 = v1[2]
        local v16 = v1[3]
        local v17 = Vector3.new(v14, v15, v16)
        local v18 = v1[4]
        local v19 = v1[5]
        local v20 = v1[6]
        return new(v17, (Vector3.new(v18, v19, v20)))
    end
    if v2 == "Rect" then
        return Rect.new(v1[1], v1[2], v1[3], v1[4])
    end
    if v2 == "Region3" then
        local v21 = v1[1]
        local v22 = v1[2]
        local v23 = v1[3]
        local v24 = Vector3.new(v21, v22, v23)
        local v25 = v1[4] / 2
        local v26 = v1[5] / 2
        local v27 = v1[6] / 2
        local v28 = Vector3.new(v25, v26, v27)
        return Region3.new(v24 - v28, v24 + v28)
    end
    if v2 == "Region3int16" then
        return Region3int16.new(Vector3int16.new(v1[1], v1[2], v1[3]), Vector3int16.new(v1[4], v1[5], v1[6]))
    end
    if v2 == "UDim" then
        return UDim.new(v1[1], v1[2])
    end
    if v2 == "UDim2" then
        return UDim2.new(v1[1], v1[2], v1[3], v1[4])
    end
    if v2 == "Vector2" then
        return Vector2.new(v1[1], v1[2])
    end
    if v2 == "Vector2int16" then
        return Vector2int16.new(v1[1], v1[2])
    end
    if v2 == "Vector3" then
        local v29 = v1[1]
        local v30 = v1[2]
        local v31 = v1[3]
        return (Vector3.new(v29, v30, v31))
    end
    if v2 == "Vector3int16" then
        return Vector3int16.new(v1[1], v1[2], v1[3])
    end
    return nil
end

return packType
