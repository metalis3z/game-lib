-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Serialization = {}

local SupportLibrary = require(script.Parent.Parent.Libraries.SupportLibrary)
SupportLibrary.ImportServices()
local v1 = {
    Part = 0,
    WedgePart = 1,
    CornerWedgePart = 2,
    VehicleSeat = 3,
    Seat = 4,
    TrussPart = 5,
    SpecialMesh = 6,
    Texture = 7,
    Decal = 8,
    PointLight = 9,
    SpotLight = 10,
    SurfaceLight = 11,
    Smoke = 12,
    Fire = 13,
    Sparkles = 14,
    Model = 15,
    Folder = 18
}
local v2 = {
    Part = "Part",
    WedgePart = "Wedge",
    CornerWedgePart = "CornerWedge",
    VehicleSeat = "VehicleSeat",
    Seat = "Seat",
    TrussPart = "Truss",
    SpecialMesh = "Mesh",
    Texture = "Texture",
    Decal = "Decal",
    PointLight = "PointLight",
    SpotLight = "SpotLight",
    SurfaceLight = "SurfaceLight",
    Smoke = "Smoke",
    Fire = "Fire",
    Sparkles = "Sparkles",
    Model = "Model",
    Folder = "Folder"
}

local function SerializeModel(v3) -- line 48 | captures: SupportLibrary, v1, v2
    local v4 = {}
    for v5, v6 in ipairs(v3) do
        local v7 = v1[v6.ClassName] and v6 or nil
        table.insert(v4, v7)
    end
    local v8 = SupportLibrary.FlipTable(v4)
    local v9 = {
        Version = 3,
        Items = {}
    }
    for v10, v11 in pairs(v4) do
        if v11:IsA("BasePart") then
            local v12 = {}
            v12[1] = v1[v11.ClassName]
            v12[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v12[3] = ""
            else
                v12[3] = v11.Name
            end
            v12[4] = v11.Size.X
            v12[5] = v11.Size.Y
            v12[6] = v11.Size.Z
            SupportLibrary.ConcatTable(v12, { v11.CFrame:components() })
            v12[19] = v11.Color.r
            v12[20] = v11.Color.g
            v12[21] = v11.Color.b
            v12[22] = v11.Material.Value
            if v11.Anchored then
                v12[23] = 1
            else
                v12[23] = 0
            end
            if v11.CanCollide then
                v12[24] = 1
            else
                v12[24] = 0
            end
            v12[25] = v11.Reflectance
            v12[26] = v11.Transparency
            v12[27] = v11.TopSurface.Value
            v12[28] = v11.BottomSurface.Value
            v12[29] = v11.FrontSurface.Value
            v12[30] = v11.BackSurface.Value
            v12[31] = v11.LeftSurface.Value
            v12[32] = v11.RightSurface.Value
            v9.Items[v10] = v12
        end
        if v11.ClassName == "Part" then
            v9.Items[v10][33] = v11.Shape.Value
        end
        if v11.ClassName == "VehicleSeat" then
            local v13 = v9.Items[v10]
            v13[33] = v11.MaxSpeed
            v13[34] = v11.Torque
            v13[35] = v11.TurnSpeed
        end
        if v11.ClassName == "TrussPart" then
            v9.Items[v10][33] = v11.Style.Value
        end
        if v11.ClassName == "SpecialMesh" then
            local v14 = {}
            v14[1] = v1[v11.ClassName]
            v14[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v14[3] = ""
            else
                v14[3] = v11.Name
            end
            v14[4] = v11.MeshType.Value
            v14[5] = v11.MeshId
            v14[6] = v11.TextureId
            v14[7] = v11.Offset.X
            v14[8] = v11.Offset.Y
            v14[9] = v11.Offset.Z
            v14[10] = v11.Scale.X
            v14[11] = v11.Scale.Y
            v14[12] = v11.Scale.Z
            v14[13] = v11.VertexColor.X
            v14[14] = v11.VertexColor.Y
            v14[15] = v11.VertexColor.Z
            v9.Items[v10] = v14
        end
        if v11:IsA("Decal") then
            local v15 = {}
            v15[1] = v1[v11.ClassName]
            v15[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v15[3] = ""
            else
                v15[3] = v11.Name
            end
            v15[4] = v11.Texture
            v15[5] = v11.Transparency
            v15[6] = v11.Face.Value
            v9.Items[v10] = v15
        end
        if v11.ClassName == "Texture" then
            local v16 = v9.Items[v10]
            v16[7] = v11.StudsPerTileU
            v16[8] = v11.StudsPerTileV
        end
        if v11:IsA("Light") then
            local v17 = {}
            v17[1] = v1[v11.ClassName]
            v17[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v17[3] = ""
            else
                v17[3] = v11.Name
            end
            v17[4] = v11.Brightness
            v17[5] = v11.Color.r
            v17[6] = v11.Color.g
            v17[7] = v11.Color.b
            if v11.Enabled then
                v17[8] = 1
            else
                v17[8] = 0
            end
            if v11.Shadows then
                v17[9] = 1
            else
                v17[9] = 0
            end
            v9.Items[v10] = v17
        end
        if v11.ClassName == "PointLight" then
            v9.Items[v10][10] = v11.Range
        end
        if v11.ClassName == "SpotLight" then
            local v18 = v9.Items[v10]
            v18[10] = v11.Range
            v18[11] = v11.Angle
            v18[12] = v11.Face.Value
        end
        if v11.ClassName == "SurfaceLight" then
            local v19 = v9.Items[v10]
            v19[10] = v11.Range
            v19[11] = v11.Angle
            v19[12] = v11.Face.Value
        end
        if v11.ClassName == "Smoke" then
            local v20 = {}
            v20[1] = v1[v11.ClassName]
            v20[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v20[3] = ""
            else
                v20[3] = v11.Name
            end
            if v11.Enabled then
                v20[4] = 1
            else
                v20[4] = 0
            end
            v20[5] = v11.Color.r
            v20[6] = v11.Color.g
            v20[7] = v11.Color.b
            v20[8] = v11.Size
            v20[9] = v11.RiseVelocity
            v20[10] = v11.Opacity
            v9.Items[v10] = v20
        end
        if v11.ClassName == "Fire" then
            local v21 = {}
            v21[1] = v1[v11.ClassName]
            v21[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v21[3] = ""
            else
                v21[3] = v11.Name
            end
            if v11.Enabled then
                v21[4] = 1
            else
                v21[4] = 0
            end
            v21[5] = v11.Color.r
            v21[6] = v11.Color.g
            v21[7] = v11.Color.b
            v21[8] = v11.SecondaryColor.r
            v21[9] = v11.SecondaryColor.g
            v21[10] = v11.SecondaryColor.b
            v21[11] = v11.Heat
            v21[12] = v11.Size
            v9.Items[v10] = v21
        end
        if v11.ClassName == "Sparkles" then
            local v22 = {}
            v22[1] = v1[v11.ClassName]
            v22[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v22[3] = ""
            else
                v22[3] = v11.Name
            end
            if v11.Enabled then
                v22[4] = 1
            else
                v22[4] = 0
            end
            v22[5] = v11.SparkleColor.r
            v22[6] = v11.SparkleColor.g
            v22[7] = v11.SparkleColor.b
            v9.Items[v10] = v22
        end
        if v11.ClassName == "Model" then
            local v23 = {}
            v23[1] = v1[v11.ClassName]
            v23[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v23[3] = ""
            else
                v23[3] = v11.Name
            end
            v23[4] = v11.PrimaryPart and v8[v11.PrimaryPart] or 0
            v9.Items[v10] = v23
        end
        if v11.ClassName == "Folder" then
            local v24 = {}
            v24[1] = v1[v11.ClassName]
            v24[2] = v8[v11.Parent] or 0
            if v11.Name == v2[v11.ClassName] then
                v24[3] = ""
            else
                v24[3] = v11.Name
            end
            v9.Items[v10] = v24
        end
        if v10 % 100 == 0 then
            wait(0.01)
        end
    end
    return HttpService:JSONEncode(v9)
end

Serialization.SerializeModel = SerializeModel

local function InflateBuildData(v25) -- line 254 | captures: SupportLibrary, v1, v2
    local function v26(...)
        return unpack(...)
    end

    local function v27(...)
        return (Vector3.new(...))
    end

    local function v28(...)
        return unpack(...)
    end

    local function v29(...)
        return unpack(...)
    end

    local function v30(...)
        return (Vector3.new(...))
    end

    local function v31(...)
        return unpack(...)
    end

    local function v32(...)
        return (Vector3.new(...))
    end

    local function v33(...)
        return unpack(...)
    end

    local function v34(...)
        return (Vector3.new(...))
    end

    local function v35(...)
        return unpack(...)
    end

    local function v36(...)
        return unpack(...)
    end

    local function v37(...)
        return unpack(...)
    end

    local function v38(...)
        return unpack(...)
    end

    local function v39(...)
        return unpack(...)
    end

    local v40 = {}
    local v41 = {}
    for v42, v43 in ipairs(v25.Items) do
        if v43[1] == v1.Part or v43[1] == v1.WedgePart or v43[1] == v1.CornerWedgePart or v43[1] == v1.VehicleSeat or v43[1] == v1.Seat or v43[1] == v1.TrussPart then
            local v44 = Instance.new(SupportLibrary.FindTableOccurrence(v1, v43[1]))
            v44.Size = v27(v26(SupportLibrary.Slice(v43, 4, 6)))
            v44.CFrame = CFrame.new(v28(SupportLibrary.Slice(v43, 7, 18)))
            v44.Color = Color3.new(v43[19], v43[20], v43[21])
            v44.Material = v43[22]
            v44.Anchored = v43[23] == 1
            v44.CanCollide = v43[24] == 1
            v44.Reflectance = v43[25]
            v44.Transparency = v43[26]
            v44.TopSurface = v43[27]
            v44.BottomSurface = v43[28]
            v44.FrontSurface = v43[29]
            v44.BackSurface = v43[30]
            v44.LeftSurface = v43[31]
            v44.RightSurface = v43[32]
            v41[v42] = v44
        end
        if v43[1] == v1.Part then
            v41[v42].Shape = v43[33]
        end
        if v43[1] == v1.VehicleSeat then
            local v45 = v41[v42]
            v45.MaxSpeed = v43[33]
            v45.Torque = v43[34]
            v45.TurnSpeed = v43[35]
        end
        if v43[1] == v1.TrussPart then
            v41[v42].Style = v43[33]
        end
        if v43[1] == v1.SpecialMesh then
            local SpecialMesh = Instance.new("SpecialMesh")
            SpecialMesh.MeshType = v43[4]
            SpecialMesh.MeshId = v43[5]
            SpecialMesh.TextureId = v43[6]
            SpecialMesh.Offset = v30(v29(SupportLibrary.Slice(v43, 7, 9)))
            SpecialMesh.Scale = v32(v31(SupportLibrary.Slice(v43, 10, 12)))
            SpecialMesh.VertexColor = v34(v33(SupportLibrary.Slice(v43, 13, 15)))
            v41[v42] = SpecialMesh
        end
        if v43[1] == v1.Decal or v43[1] == v1.Texture then
            local v46 = Instance.new(SupportLibrary.FindTableOccurrence(v1, v43[1]))
            v46.Texture = v43[4]
            v46.Transparency = v43[5]
            v46.Face = v43[6]
            v41[v42] = v46
        end
        if v43[1] == v1.Texture then
            local v47 = v41[v42]
            v47.StudsPerTileU = v43[7]
            v47.StudsPerTileV = v43[8]
        end
        if v43[1] == v1.PointLight or v43[1] == v1.SpotLight or v43[1] == v1.SurfaceLight then
            local v48 = Instance.new(SupportLibrary.FindTableOccurrence(v1, v43[1]))
            v48.Brightness = v43[4]
            v48.Color = Color3.new(v35(SupportLibrary.Slice(v43, 5, 7)))
            v48.Enabled = v43[8] == 1
            v48.Shadows = v43[9] == 1
            v41[v42] = v48
        end
        if v43[1] == v1.PointLight then
            v41[v42].Range = v43[10]
        end
        if v43[1] == v1.SpotLight then
            local v49 = v41[v42]
            v49.Range = v43[10]
            v49.Angle = v43[11]
            v49.Face = v43[12]
        end
        if v43[1] == v1.SurfaceLight then
            local v50 = v41[v42]
            v50.Range = v43[10]
            v50.Angle = v43[11]
            v50.Face = v43[12]
        end
        if v43[1] == v1.Smoke then
            local Smoke = Instance.new("Smoke")
            Smoke.Enabled = v43[4] == 1
            Smoke.Color = Color3.new(v36(SupportLibrary.Slice(v43, 5, 7)))
            Smoke.Size = v43[8]
            Smoke.RiseVelocity = v43[9]
            Smoke.Opacity = v43[10]
            v41[v42] = Smoke
        end
        if v43[1] == v1.Fire then
            local Fire = Instance.new("Fire")
            Fire.Enabled = v43[4] == 1
            Fire.Color = Color3.new(v37(SupportLibrary.Slice(v43, 5, 7)))
            Fire.SecondaryColor = Color3.new(v38(SupportLibrary.Slice(v43, 8, 10)))
            Fire.Heat = v43[11]
            Fire.Size = v43[12]
            v41[v42] = Fire
        end
        if v43[1] == v1.Sparkles then
            local Sparkles = Instance.new("Sparkles")
            Sparkles.Enabled = v43[4] == 1
            Sparkles.SparkleColor = Color3.new(v39(SupportLibrary.Slice(v43, 5, 7)))
            v41[v42] = Sparkles
        end
        if v43[1] == v1.Model then
            v41[v42] = Instance.new("Model")
        end
        if v43[1] == v1.Folder then
            v41[v42] = Instance.new("Folder")
        end
    end
    for v51, v52 in pairs(v25.Items) do
        local v53 = v41[v51]
        if v53 then
            if v52[1] <= 18 then
                v53.Name = v52[3] == "" and v2[v53.ClassName] or v52[3]
                if v52[2] == 0 then
                    table.insert(v40, v53)
                else
                    v53.Parent = v41[v52[2]]
                end
            end
            if v52[1] == 15 then
                v53.PrimaryPart = v52[4] ~= 0 and v41[v52[4]] or nil
            end
        end
    end
    return v40
end

Serialization.InflateBuildData = InflateBuildData
return Serialization
