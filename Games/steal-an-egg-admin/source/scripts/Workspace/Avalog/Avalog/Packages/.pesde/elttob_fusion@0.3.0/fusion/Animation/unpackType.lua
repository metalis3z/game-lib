-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Oklab = require(script.Parent.Parent.Colour.Oklab)

local function unpackType(v1, v2) -- line 14 | captures: Oklab
    if v2 == "number" then
        return { v1 }
    end
    if v2 == "CFrame" then
        local v3, v4 = v1:ToAxisAngle()
        return {
            v1.X,
            v1.Y,
            v1.Z,
            v3.X,
            v3.Y,
            v3.Z,
            v4
        }
    end
    if v2 == "Color3" then
        local v5 = Oklab.fromSRGB(v1)
        return {
            v5.X,
            v5.Y,
            v5.Z
        }
    end
    if v2 == "ColorSequenceKeypoint" then
        local v6 = Oklab.fromSRGB(v1.Value)
        return {
            v6.X,
            v6.Y,
            v6.Z,
            v1.Time
        }
    end
    if v2 == "DateTime" then
        return { v1.UnixTimestampMillis }
    end
    if v2 == "NumberRange" then
        return {
            v1.Min,
            v1.Max
        }
    end
    if v2 == "NumberSequenceKeypoint" then
        return {
            v1.Value,
            v1.Time,
            v1.Envelope
        }
    end
    if v2 == "PhysicalProperties" then
        return {
            v1.Density,
            v1.Friction,
            v1.Elasticity,
            v1.FrictionWeight,
            v1.ElasticityWeight
        }
    end
    if v2 == "Ray" then
        return {
            v1.Origin.X,
            v1.Origin.Y,
            v1.Origin.Z,
            v1.Direction.X,
            v1.Direction.Y,
            v1.Direction.Z
        }
    end
    if v2 == "Rect" then
        return {
            v1.Min.X,
            v1.Min.Y,
            v1.Max.X,
            v1.Max.Y
        }
    end
    if v2 == "Region3" then
        return {
            v1.CFrame.X,
            v1.CFrame.Y,
            v1.CFrame.Z,
            v1.Size.X,
            v1.Size.Y,
            v1.Size.Z
        }
    end
    if v2 == "Region3int16" then
        return {
            v1.Min.X,
            v1.Min.Y,
            v1.Min.Z,
            v1.Max.X,
            v1.Max.Y,
            v1.Max.Z
        }
    end
    if v2 == "UDim" then
        return {
            v1.Scale,
            v1.Offset
        }
    end
    if v2 == "UDim2" then
        return {
            v1.X.Scale,
            v1.X.Offset,
            v1.Y.Scale,
            v1.Y.Offset
        }
    end
    if v2 == "Vector2" then
        return {
            v1.X,
            v1.Y
        }
    end
    if v2 == "Vector2int16" then
        return {
            v1.X,
            v1.Y
        }
    end
    if v2 == "Vector3" then
        return {
            v1.X,
            v1.Y,
            v1.Z
        }
    end
    if v2 == "Vector3int16" then
        return {
            v1.X,
            v1.Y,
            v1.Z
        }
    end
    return {}
end

return unpackType
