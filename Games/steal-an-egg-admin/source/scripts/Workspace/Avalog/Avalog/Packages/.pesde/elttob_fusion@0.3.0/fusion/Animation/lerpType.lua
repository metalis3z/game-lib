-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Oklab = require(script.Parent.Parent.Colour.Oklab)

local function lerpType(v1, v2, v3) -- line 15 | captures: Oklab
    local v4 = typeof(v1)
    if typeof(v2) == v4 then
        if v4 == "number" then
            return (v2 - v1) * v3 + v1
        end
        if v4 == "CFrame" then
            return v1:Lerp(v2, v3)
        end
        if v4 == "Color3" then
            local v5 = Oklab.fromSRGB(v1)
            local v6 = Oklab.fromSRGB(v2)
            return Oklab.toSRGB(v5:Lerp(v6, v3), false)
        end
        if v4 == "ColorSequenceKeypoint" then
            local v7 = Oklab.fromSRGB(v1.Value)
            local v8 = Oklab.fromSRGB(v2.Value)
            return ColorSequenceKeypoint.new((v2.Time - v1.Time) * v3 + v1.Time, Oklab.toSRGB(v7:Lerp(v8, v3), false))
        end
        if v4 == "DateTime" then
            return DateTime.fromUnixTimestampMillis((v2.UnixTimestampMillis - v1.UnixTimestampMillis) * v3 + v1.UnixTimestampMillis)
        end
        if v4 == "NumberRange" then
            return NumberRange.new((v2.Min - v1.Min) * v3 + v1.Min, (v2.Max - v1.Max) * v3 + v1.Max)
        end
        if v4 == "NumberSequenceKeypoint" then
            return NumberSequenceKeypoint.new((v2.Time - v1.Time) * v3 + v1.Time, (v2.Value - v1.Value) * v3 + v1.Value, (v2.Envelope - v1.Envelope) * v3 + v1.Envelope)
        end
        if v4 == "PhysicalProperties" then
            return PhysicalProperties.new((v2.Density - v1.Density) * v3 + v1.Density, (v2.Friction - v1.Friction) * v3 + v1.Friction, (v2.Elasticity - v1.Elasticity) * v3 + v1.Elasticity, (v2.FrictionWeight - v1.FrictionWeight) * v3 + v1.FrictionWeight, (v2.ElasticityWeight - v1.ElasticityWeight) * v3 + v1.ElasticityWeight)
        end
        if v4 == "Ray" then
            return Ray.new(v1.Origin:Lerp(v2.Origin, v3), v1.Direction:Lerp(v2.Direction, v3))
        end
        if v4 == "Rect" then
            return Rect.new(v1.Min:Lerp(v2.Min, v3), v1.Max:Lerp(v2.Max, v3))
        end
        if v4 == "Region3" then
            local v9 = v1.CFrame.Position:Lerp(v2.CFrame.Position, v3)
            local v10 = v1.Size:Lerp(v2.Size, v3) / 2
            return Region3.new(v9 - v10, v9 + v10)
        end
        if v4 == "Region3int16" then
            return Region3int16.new(Vector3int16.new((v2.Min.X - v1.Min.X) * v3 + v1.Min.X, (v2.Min.Y - v1.Min.Y) * v3 + v1.Min.Y, (v2.Min.Z - v1.Min.Z) * v3 + v1.Min.Z), Vector3int16.new((v2.Max.X - v1.Max.X) * v3 + v1.Max.X, (v2.Max.Y - v1.Max.Y) * v3 + v1.Max.Y, (v2.Max.Z - v1.Max.Z) * v3 + v1.Max.Z))
        end
        if v4 == "UDim" then
            return UDim.new((v2.Scale - v1.Scale) * v3 + v1.Scale, (v2.Offset - v1.Offset) * v3 + v1.Offset)
        end
        if v4 == "UDim2" then
            return v1:Lerp(v2, v3)
        end
        if v4 == "Vector2" then
            return v1:Lerp(v2, v3)
        end
        if v4 == "Vector2int16" then
            return Vector2int16.new((v2.X - v1.X) * v3 + v1.X, (v2.Y - v1.Y) * v3 + v1.Y)
        end
        if v4 == "Vector3" then
            return v1:Lerp(v2, v3)
        end
        if v4 == "Vector3int16" then
            return Vector3int16.new((v2.X - v1.X) * v3 + v1.X, (v2.Y - v1.Y) * v3 + v1.Y, (v2.Z - v1.Z) * v3 + v1.Z)
        end
    end
    if v3 < 0.5 then
        return v1
    end
    return v2
end

return lerpType
