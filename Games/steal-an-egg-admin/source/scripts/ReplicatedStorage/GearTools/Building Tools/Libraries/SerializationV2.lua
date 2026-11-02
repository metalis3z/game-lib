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
    Model = 15
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
    Model = "Model"
}

local function SerializeModel(v3) -- line 46 | captures: SupportLibrary, v1, v2
    local v4 = {}
    for v5, v6 in ipairs(v3) do
        local v7 = v1[v6.ClassName] and v6 or nil
        table.insert(v4, v7)
    end
    local v8 = SupportLibrary.FlipTable(v4)
    local v9 = {
        Version = 2,
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
            v12[19] = v11.BrickColor.Number
            v12[20] = v11.Material.Value
            if v11.Anchored then
                v12[21] = 1
            else
                v12[21] = 0
            end
            if v11.CanCollide then
                v12[22] = 1
            else
                v12[22] = 0
            end
            v12[23] = v11.Reflectance
            v12[24] = v11.Transparency
            v12[25] = v11.TopSurface.Value
            v12[26] = v11.BottomSurface.Value
            v12[27] = v11.FrontSurface.Value
            v12[28] = v11.BackSurface.Value
            v12[29] = v11.LeftSurface.Value
            v12[30] = v11.RightSurface.Value
            v9.Items[v10] = v12
        end
        if v11.ClassName == "Part" then
            v9.Items[v10][31] = v11.Shape.Value
        end
        if v11.ClassName == "VehicleSeat" then
            local v13 = v9.Items[v10]
            v13[31] = v11.MaxSpeed
            v13[32] = v11.Torque
            v13[33] = v11.TurnSpeed
        end
        if v11.ClassName == "TrussPart" then
            v9.Items[v10][31] = v11.Style.Value
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
        if v10 % 100 == 0 then
            wait(0.01)
        end
    end
    return HttpService:JSONEncode(v9)
end

Serialization.SerializeModel = SerializeModel

local function InflateBuildData(v24) -- line 242 | captures: SupportLibrary, v1, v2
    local function v25(...)
        return unpack(...)
    end

    local function v26(...)
        return (Vector3.new(...))
    end

    local function v27(...)
        return unpack(...)
    end

    local function v28(...)
        return unpack(...)
    end

    local function v29(...)
        return (Vector3.new(...))
    end

    local function v30(...)
        return unpack(...)
    end

    local function v31(...)
        return (Vector3.new(...))
    end

    local function v32(...)
        return unpack(...)
    end

    local function v33(...)
        return (Vector3.new(...))
    end

    local function v34(...)
        return unpack(...)
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

    local v39 = {}
    local v40 = {}
    for v41, v42 in ipairs(v24.Items) do
        if v42[1] == v1.Part or v42[1] == v1.WedgePart or v42[1] == v1.CornerWedgePart or v42[1] == v1.VehicleSeat or v42[1] == v1.Seat or v42[1] == v1.TrussPart then
            local v43 = Instance.new(SupportLibrary.FindTableOccurrence(v1, v42[1]))
            v43.Size = v26(v25(SupportLibrary.Slice(v42, 4, 6)))
            v43.CFrame = CFrame.new(v27(SupportLibrary.Slice(v42, 7, 18)))
            v43.BrickColor = BrickColor.new(v42[19])
            v43.Material = v42[20]
            v43.Anchored = v42[21] == 1
            v43.CanCollide = v42[22] == 1
            v43.Reflectance = v42[23]
            v43.Transparency = v42[24]
            v43.TopSurface = v42[25]
            v43.BottomSurface = v42[26]
            v43.FrontSurface = v42[27]
            v43.BackSurface = v42[28]
            v43.LeftSurface = v42[29]
            v43.RightSurface = v42[30]
            v40[v41] = v43
        end
        if v42[1] == v1.Part then
            v40[v41].Shape = v42[31]
        end
        if v42[1] == v1.VehicleSeat then
            local v44 = v40[v41]
            v44.MaxSpeed = v42[31]
            v44.Torque = v42[32]
            v44.TurnSpeed = v42[33]
        end
        if v42[1] == v1.TrussPart then
            v40[v41].Style = v42[31]
        end
        if v42[1] == v1.SpecialMesh then
            local SpecialMesh = Instance.new("SpecialMesh")
            SpecialMesh.MeshType = v42[4]
            SpecialMesh.MeshId = v42[5]
            SpecialMesh.TextureId = v42[6]
            SpecialMesh.Offset = v29(v28(SupportLibrary.Slice(v42, 7, 9)))
            SpecialMesh.Scale = v31(v30(SupportLibrary.Slice(v42, 10, 12)))
            SpecialMesh.VertexColor = v33(v32(SupportLibrary.Slice(v42, 13, 15)))
            v40[v41] = SpecialMesh
        end
        if v42[1] == v1.Decal or v42[1] == v1.Texture then
            local v45 = Instance.new(SupportLibrary.FindTableOccurrence(v1, v42[1]))
            v45.Texture = v42[4]
            v45.Transparency = v42[5]
            v45.Face = v42[6]
            v40[v41] = v45
        end
        if v42[1] == v1.Texture then
            local v46 = v40[v41]
            v46.StudsPerTileU = v42[7]
            v46.StudsPerTileV = v42[8]
        end
        if v42[1] == v1.PointLight or v42[1] == v1.SpotLight or v42[1] == v1.SurfaceLight then
            local v47 = Instance.new(SupportLibrary.FindTableOccurrence(v1, v42[1]))
            v47.Brightness = v42[4]
            v47.Color = Color3.new(v34(SupportLibrary.Slice(v42, 5, 7)))
            v47.Enabled = v42[8] == 1
            v47.Shadows = v42[9] == 1
            v40[v41] = v47
        end
        if v42[1] == v1.PointLight then
            v40[v41].Range = v42[10]
        end
        if v42[1] == v1.SpotLight then
            local v48 = v40[v41]
            v48.Range = v42[10]
            v48.Angle = v42[11]
            v48.Face = v42[12]
        end
        if v42[1] == v1.SurfaceLight then
            local v49 = v40[v41]
            v49.Range = v42[10]
            v49.Angle = v42[11]
            v49.Face = v42[12]
        end
        if v42[1] == v1.Smoke then
            local Smoke = Instance.new("Smoke")
            Smoke.Enabled = v42[4] == 1
            Smoke.Color = Color3.new(v35(SupportLibrary.Slice(v42, 5, 7)))
            Smoke.Size = v42[8]
            Smoke.RiseVelocity = v42[9]
            Smoke.Opacity = v42[10]
            v40[v41] = Smoke
        end
        if v42[1] == v1.Fire then
            local Fire = Instance.new("Fire")
            Fire.Enabled = v42[4] == 1
            Fire.Color = Color3.new(v36(SupportLibrary.Slice(v42, 5, 7)))
            Fire.SecondaryColor = Color3.new(v37(SupportLibrary.Slice(v42, 8, 10)))
            Fire.Heat = v42[11]
            Fire.Size = v42[12]
            v40[v41] = Fire
        end
        if v42[1] == v1.Sparkles then
            local Sparkles = Instance.new("Sparkles")
            Sparkles.Enabled = v42[4] == 1
            Sparkles.SparkleColor = Color3.new(v38(SupportLibrary.Slice(v42, 5, 7)))
            v40[v41] = Sparkles
        end
        if v42[1] == v1.Model then
            v40[v41] = Instance.new("Model")
        end
    end
    for v50, v51 in pairs(v24.Items) do
        local v52 = v40[v50]
        if v52 then
            if v51[1] <= 15 then
                v52.Name = v51[3] == "" and v2[v52.ClassName] or v51[3]
                if v51[2] == 0 then
                    table.insert(v39, v52)
                else
                    v52.Parent = v40[v51[2]]
                end
            end
            if v51[1] == 15 then
                v52.PrimaryPart = v51[4] ~= 0 and v40[v51[4]] or nil
            end
        end
    end
    return v39
end

Serialization.InflateBuildData = InflateBuildData
return Serialization
