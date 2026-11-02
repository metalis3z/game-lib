-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local v1 = CFrame.Angles(0, 0, 3.141592653589793)
local v2 = { "Size", "CFrame", "PivotOffset", "RootPriority", "CollisionGroup" }
local v3 = {
    Transparency = 1,
    CastShadow = false,
    Anchored = true,
    CanCollide = false,
    CanQuery = false,
    CanTouch = false,
    Massless = true
}
local v4 = {}

local function childOfClass(v5, v6, v7) -- line 27
    local v8 = v5:FindFirstChild(v6)
    local v9 = ("%* lacks %*"):format(v5:GetFullName(), v6)
    local v10 = assert(v8, v9)
    local v11 = v10:IsA(v7)
    local v12 = ("%* should have been a %*"):format(v10:GetFullName(), v7)
    assert(v11, v12)
    return v10
end

local function parkWelds(v13) -- line 36
    local v14 = {}
    for v15, v16 in v13:GetDescendants() do
        if v16:IsA("WeldConstraint") then
            v14[v16] = v16.Enabled
            v16.Enabled = false
        end
    end
    return v14
end

local function unparkWelds(v17) -- line 46
    for v18, v19 in v17 do
        v18.Enabled = v19
    end
end

local function assertStill(v20, v21, v22) -- line 54
    local v23 = v20.XVector:Dot(v21.XVector)
    local v24 = v20.YVector:Dot(v21.YVector)
    local v25 = v20.ZVector:Dot(v21.ZVector)
    local v26 = if (v20.Position - v21.Position).Magnitude <= 0.00001 and v23 >= 0.99999 and v24 >= 0.99999 then v25 < 0.99999 else true
    local v27 = not v26
    local v28 = ("%* shifted during the flip"):format(v22)
    assert(v27, v28)
end

local function standInFor(v29, v30) -- line 61 | captures: v2, v3
    local Part = Instance.new("Part")
    Part.Name = "HumanoidRootPart"
    for v31, v32 in v2 do
        Part[v32] = v29[v32]
    end
    for v33, v34 in v3 do
        Part[v33] = v34
    end
    Part.Parent = v30
    return Part
end

function v4.Invert(v35) -- line 79 | captures: t, ModelBounds, v1, v2, v3, childOfClass, parkWelds, assertStill
    t.strict(t.instanceIsA("Model"))(v35)
    local BasePart = childOfClass(v35, "HumanoidRootPart", "BasePart")
    local BasePart_2 = childOfClass(v35, "CENTER", "BasePart")
    local Model = childOfClass(v35, "Model", "Model")
    local WeldConstraint = childOfClass(BasePart, "AssetWeld", "WeldConstraint")
    local WeldConstraint_2 = childOfClass(BasePart_2, "CenterWeld", "WeldConstraint")
    local v36 = ModelBounds(v35)
    local v37 = v36:ToObjectSpace(Model:GetPivot())
    local v38 = parkWelds(v35)
    local v39 = v38[WeldConstraint] ~= nil
    assert(v39, "AssetWeld escaped the parking sweep")
    local v40 = v38[WeldConstraint_2] ~= nil
    assert(v40, "CenterWeld escaped the parking sweep")
    Model:PivotTo(v36 * v1 * v37)
    BasePart.Name = "InvertedModelOriginalRoot"
    local Part = Instance.new("Part")
    Part.Name = "HumanoidRootPart"
    for v41, v42 in v2 do
        Part[v42] = BasePart[v42]
    end
    for v43, v44 in v3 do
        Part[v43] = v44
    end
    Part.Parent = v35
    BasePart.Anchored = false
    local WeldConstraint_3 = Instance.new("WeldConstraint")
    WeldConstraint_3.Name = "InvertedModelRootWeld"
    WeldConstraint_3.Part0 = Part
    WeldConstraint_3.Part1 = BasePart
    WeldConstraint_3.Parent = Part
    v35.PrimaryPart = Part
    for v45, v46 in v38 do
        v45.Enabled = v46
    end
    assertStill(Part.CFrame, BasePart.CFrame, "the stand-in HumanoidRootPart")
    assertStill(BasePart_2.CFrame, BasePart_2.CFrame, "CENTER")
end

return v4
