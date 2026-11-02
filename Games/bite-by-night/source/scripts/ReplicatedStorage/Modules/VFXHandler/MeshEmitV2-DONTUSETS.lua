-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local v_u_4 = {
    "Position",
    "Size",
    "Transparency",
    "Reflectance",
    "Color"
}
local v_u_5 = { "Offset", "Scale", "VertexColor" }
local v_u_6 = { "Color3", "ZIndex", "Transparency" }
local function v_u_23(p_u_7, p_u_8, p9, p10)
    local SpecialMesh = p_u_7:FindFirstChildOfClass("SpecialMesh")
    local Decal = p_u_7:FindFirstChildOfClass("Decal")
    if SpecialMesh or Decal then
        Decal.Transparency = p_u_7.Transparency
        local v_u_13 = {}
        local v_u_14 = {}
        for _, v15 in pairs(v_u_5) do
            v_u_13[v15] = p_u_7[v15]
        end
        for _, v16 in pairs(v_u_6) do
            v_u_14[v16] = p_u_7[v16]
        end
        local v17 = {}
        local v18 = {}
        for v19, v20 in pairs(p9) do
            if table.find(v_u_5, v19) then
                v17[v19] = v20
            end
            if table.find(v_u_6, v19) then
                v18[v19] = v20
            end
        end
        v17.Scale = p10.End:FindFirstChildOfClass("SpecialMesh").Scale
        TweenService:Create(SpecialMesh, TweenInfo.new(p_u_8.Duration, p_u_8.EasingStyle, p_u_8.EasingDirection), v17):Play()
        TweenService:Create(Decal, TweenInfo.new(p_u_8.Duration, p_u_8.EasingStyle, p_u_8.EasingDirection), v18):Play()
        if p_u_8.StayDuration then
            task.delay(p_u_8.StayDuration, function()
                TweenService:Create(SpecialMesh, TweenInfo.new(p_u_8.Duration, p_u_8.EasingStyle, p_u_8.EasingDirection), v_u_13):Play()
                TweenService:Create(Decal, TweenInfo.new(p_u_8.Duration, p_u_8.EasingStyle, p_u_8.EasingDirection), v_u_14):Play()
            end)
            return
        end
    else
        p9.Size = p10.End.Size
        local v_u_21 = {}
        for _, v22 in pairs(v_u_4) do
            v_u_21[v22] = p_u_7[v22]
        end
        TweenService:Create(p_u_7, TweenInfo.new(p_u_8.Duration, p_u_8.EasingStyle, p_u_8.EasingDirection), p9):Play()
        if p_u_8.StayDuration then
            task.delay(p_u_8.StayDuration, function()
                TweenService:Create(p_u_7, TweenInfo.new(p_u_8.Duration, p_u_8.EasingStyle, p_u_8.EasingDirection), v_u_21):Play()
            end)
        end
    end
end
function v1.PlayMesh(p_u_24, p25)
    print(p_u_24:GetAttributes())
    local v26 = {
        ["Duration"] = p_u_24:GetAttribute("TweenDuration_TweenParam"),
        ["EasingStyle"] = p_u_24:GetAttribute("EasingStyle_TweenParam") and Enum.EasingStyle[p_u_24:GetAttribute("EasingStyle_TweenParam")] or Enum.EasingStyle.Linear,
        ["EasingDirection"] = p_u_24:GetAttribute("EasingDirection_TweenParam") and Enum.EasingDirection[p_u_24:GetAttribute("EasingDirection_TweenParam")] or Enum.EasingDirection.Out,
        ["StayDuration"] = p_u_24:GetAttribute("StayDuration_TweenParam")
    }
    local v_u_27 = {
        ["SpinDuration"] = p_u_24:GetAttribute("SpinDuration_SpinParam"),
        ["SpinSpeed"] = p_u_24:GetAttribute("SpinSpeed_SpinParam") or 5
    }
    if p25 then
        for _, v28 in pairs(p_u_24:GetDescendants()) do
            if v28:IsA("BasePart") then
                local CFrame = v28.CFrame
                local Angles = CFrame.Angles
                local v31 = math.random(p25[1], p25[2])
                v28.CFrame = CFrame * Angles(0, (math.rad(v31)))
            end
        end
    end
    local v_u_32 = nil
    if v_u_27.SpinDuration then
        local v_u_42 = RunService.Stepped:Connect(function(p33)
            if p_u_24 then
                if p_u_24:IsA("Model") then
                    for _, v34 in pairs(p_u_24:GetChildren()) do
                        local CFrame_0 = v34.CFrame
                        local Angles_0 = CFrame.Angles
                        local SpinSpeed = v_u_27.SpinSpeed
                        v34.CFrame = CFrame_0 * Angles_0(0, math.rad(SpinSpeed), 0)
                        print(v_u_27.SpinSpeed * p33)
                    end
                    return
                elseif p_u_24:IsA("BasePart") then
                    local v38 = p_u_24
                    local CFrame_1 = v38.CFrame
                    local Angles_1 = CFrame.Angles
                    local SpinSpeed_0 = v_u_27.SpinSpeed
                    v38.CFrame = CFrame_1 * Angles_1(0, math.rad(SpinSpeed_0), 0)
                else
                    error("Mesh Type not supported")
                end
            else
                v_u_32:Disconnect()
                return
            end
        end)
        task.delay(v_u_27.SpinDuration, function()
            v_u_42:Disconnect()
        end)
    end
    local v43 = p_u_24:GetAttributes()
    local v44 = {}
    for v45, v46 in pairs(v43) do
        if string.find(v45, "_TweenProperty") then
            v44[string.split(v45, "_")[1]] = v46
        end
    end
    print(v44)
    if p_u_24:IsA("Model") then
        for _, v47 in pairs(p_u_24:GetChildren()) do
            if v47.Name ~= "End" then
                v_u_23(v47, v26, v44, p_u_24)
            end
        end
    elseif p_u_24:IsA("BasePart") then
        v_u_23(p_u_24, v26, v44)
    else
        error("Mesh Type not supported")
    end
end
return v1
