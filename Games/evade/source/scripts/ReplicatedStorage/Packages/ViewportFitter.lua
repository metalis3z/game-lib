-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7
}
local v_u_2 = {
    0,
    1,
    3,
    4,
    5,
    7
}
local v_u_3 = {
    0,
    1,
    4,
    5,
    6
}
local function v_u_15(p4, p5, p6)
    local v7 = table.create(#p6)
    for v8, v9 in p6 do
        local v10 = v9 * 0.25
        local v11 = math.floor(v10) % 2 * 2 - 1
        local v12 = v9 * 0.5
        local v13 = math.floor(v12) % 2 * 2 - 1
        local v14 = v9 % 2 * 2 - 1
        v7[v8] = p4 * (p5 * Vector3.new(v11, v13, v14))
    end
    return v7
end
local function v_u_22(p16)
    -- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_1, (copy) v_u_15
    local v17 = p16:GetDescendants()
    local v18 = table.create(#v17 * 5)
    for _, v19 in v17 do
        if v19:IsA("BasePart") then
            local v20
            if v19:IsA("WedgePart") then
                v20 = v_u_2
            elseif v19:IsA("CornerWedgePart") then
                v20 = v_u_3
            else
                v20 = v_u_1
            end
            local v21 = v_u_15(v19.CFrame, v19.Size * 0.5, v20)
            table.move(v21, 1, #v21, #v18 + 1, v18)
        end
    end
    return v18
end
local function v_u_33(p23, p24, p25, p26)
    local v27 = (-1 / 0)
    local v28 = (1 / 0)
    for _, v29 in p23 do
        local v30 = p26 * (p25 - v29.Z)
        local v31 = v29[p24] + v30
        local v32 = v29[p24] - v30
        v27 = math.max(v27, v31, v32)
        v28 = math.min(v28, v31, v32)
    end
    return v27, v28
end
local v_u_34 = {}
v_u_34.__index = v_u_34
function v_u_34.new(p35, p36)
    -- upvalues: (copy) v_u_34
    local v37 = {
        ["Model"] = nil,
        ["ViewportFrame"] = p35,
        ["Camera"] = p36,
        ["_Points"] = {},
        ["_ModelCFrame"] = CFrame.identity,
        ["_ModelSize"] = Vector3.new(0, 0, 0),
        ["_ModelRadius"] = 0,
        ["_Viewport"] = nil
    }
    local v38 = v_u_34
    local v39 = setmetatable(v37, v38)
    v39:Calibrate()
    return v39
end
function v_u_34.SetModel(p40, p41)
    -- upvalues: (copy) v_u_22
    local v42, v43 = p41:GetBoundingBox()
    p40.Model = p41
    p40._Points = v_u_22(p41)
    p40._ModelCFrame = v42
    p40._ModelSize = v43
    p40._ModelRadius = v43.Magnitude * 0.5
end
function v_u_34.Calibrate(p44)
    local v45 = p44.ViewportFrame.AbsoluteSize
    local v46 = v45.X / v45.Y
    local v47 = p44.Camera.FieldOfView * 0.5
    local v48 = math.rad(v47)
    local v49 = math.tan(v48)
    local v50 = v49 * v46
    local v51 = math.atan(v50)
    local v52 = math.tan(v51)
    local v53 = math.atan(v49) * math.min(1, v46)
    p44._Viewport = {
        ["Aspect"] = v46,
        ["Y_Fov2"] = v48,
        ["TanY_Fov2"] = v49,
        ["X_Fov2"] = v51,
        ["TanX_Fov2"] = v52,
        ["C_Fov2"] = v53,
        ["SinC_Fov2"] = math.sin(v53)
    }
end
function v_u_34.GetFitDistance(p54, p55)
    local v56 = not p55 and 0 or (p55 - p54._ModelCFrame.Position).Magnitude
    return (p54._ModelRadius + v56) / p54._Viewport.SinC_Fov2
end
function v_u_34.GetMinimumFitCFrame(p57, p58)
    -- upvalues: (copy) v_u_33
    if not p57.Model then
        return CFrame.identity
    end
    local v59 = (p58 - p58.Position):Inverse()
    local v60 = p57._Points
    local v61 = table.create(#v60)
    local v62 = 0
    for v63, v64 in v60 do
        local v65 = v59 * v64
        local v66 = v65.Z
        v62 = math.min(v62, v66)
        v61[v63] = v65
    end
    local v67, v68 = v_u_33(v61, "X", v62, p57._Viewport.TanX_Fov2)
    local v69, v70 = v_u_33(v61, "Y", v62, p57._Viewport.TanY_Fov2)
    local v71 = (v67 - v68) * 0.5 / p57._Viewport.TanX_Fov2
    local v72 = (v69 - v70) * 0.5 / p57._Viewport.TanY_Fov2
    local v73 = math.max(v71, v72)
    return p58 * CFrame.new((v67 + v68) * 0.5, (v69 + v70) * 0.5, v62 + v73)
end
return v_u_34