-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = {}
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local _ = game.ReplicatedStorage.Modules
local m_MeshEmit = require(script.MeshEmit)
local _ = workspace.CurrentCamera
Random.new()
local RunService = game:GetService("RunService")
local m_BoatTween = require(script.BoatTween)
function v_u_1.CreateTween(p7, p8)
    return m_BoatTween.Create(p7, p8)
end
function v_u_1.Clone(p9, p10, p11)
    local v12 = p9:Clone()
    if typeof(p11) == "Vector3" then
        if v12:IsA("BasePart") then
            v12.Position = p11
        elseif v12:IsA("Model") then
            v12:PivotTo(CFrame.new(p11))
        end
    elseif typeof(p11) == "CFrame" then
        if v12:IsA("Model") then
            v12:PivotTo(p11)
        else
            v12.CFrame = p11
        end
    end
    v12.Parent = p10
    return v12
end
function v_u_1.DelayDestruction(p13, p_u_14)
    task.delay(p13, function()
        p_u_14:Destroy()
    end)
end
function v_u_1.IsTableEmpty()
    -- failed to decompile
end
function v_u_1.DeepCloneTable(p15)
    local v16 = {}
    for v17, v18 in p15 do
        if type(v18) == "table" then
            v16[v17] = v_u_1.DeepCloneTable(v18)
        else
            v16[v17] = v18
        end
    end
    return v16
end
function v_u_1.Weld(p19, p20)
    local v21 = Instance.new("WeldConstraint")
    v21.Part0 = p19
    v21.Part1 = p20
    v21.Parent = p19
    return v21
end

function v_u_1.SetVelocity(p22, p23, p24)
    if p22 and p22:FindFirstChild("HumanoidRootPart") then
        local HumanoidRootPart = p22.HumanoidRootPart
        local v26 = Instance.new("Attachment")
        v26.Name = "VelocityAttachment"
        v26.Parent = HumanoidRootPart
        local v27 = Instance.new("LinearVelocity")
        v27.Name = "CharacterVelocity"
        v27.MaxForce = (1 / 0)
        v27.VectorVelocity = p23
        v27.Attachment0 = v26
        v27.Parent = HumanoidRootPart
        Debris:AddItem(v27, p24)
    else
        warn("Character or HumanoidRootPart not found")
    end
end

function v_u_1.toggleAllEmitters(p28, p29)
    for _, v30 in p28:GetDescendants() do
        if v30:IsA("ParticleEmitter") then
            v30.Enabled = p29 or false
        end
    end
end
function v_u_1.doEmitCount(p31)
    for _, v_u_32 in pairs(p31:GetDescendants()) do
        if v_u_32:IsA("ParticleEmitter") then
            if v_u_32:GetAttribute("EmitDuration") then
                v_u_32.Enabled = true
                task.delay(v_u_32:GetAttribute("EmitDuration"), function()
                    v_u_32.Enabled = false
                end)
            end
            if v_u_32:GetAttribute("EmitDelay") then
                task.spawn(function()
                    task.wait(v_u_32:GetAttribute("EmitDelay"))
                    v_u_32:Emit(v_u_32:GetAttribute("EmitCount") or 0)
                end)
            else
                v_u_32:Emit(v_u_32:GetAttribute("EmitCount") or 0)
            end
        end
    end
end
function v_u_1.MeshHandler()
    -- failed to decompile
end
function v_u_1.TweenBeams(p33, p_u_34, p35)
    local v_u_36 = p33.Parent:Clone()
    v_u_36.Parent = workspace.MeshSpawn
    local CFrame = p35 or v_u_36.CFrame
    for _, v_u_38 in v_u_36:GetDescendants() do
        if v_u_38:IsA("Beam") then
            v_u_38.Enabled = true
            local v_u_39 = {
                ["Width0"] = v_u_38.Width0,
                ["Width1"] = v_u_38.Width1,
                ["TextureSpeed"] = v_u_38.TextureSpeed,
                ["Brightness"] = v_u_38.Brightness
            }
            local v40 = TweenService:Create(v_u_38, TweenInfo.new(p_u_34.Duration, Enum.EasingStyle[p_u_34.Easing], Enum.EasingDirection[p_u_34.EasingDirection]), p_u_34.Properties)
            v40:Play()
            v40.Completed:Once(function()
                v_u_38.Enabled = false
                for v41, v42 in v_u_39 do
                    v_u_38[v41] = v42
                end
            end)
        end
    end
    TweenService:Create(v_u_36, TweenInfo.new(p_u_34.Duration, Enum.EasingStyle[p_u_34.Easing], Enum.EasingDirection[p_u_34.EasingDirection]), {
        ["Position"] = (CFrame * p_u_34.Offset).Position
    }):Play()
    local v_u_43 = 0
    local v_u_44 = nil
    v_u_44 = RunService.Heartbeat:Connect(function(p45)
        local v46 = v_u_36
        local CFrame_0 = v46.CFrame
        local Angles = CFrame.Angles
        local RotationSpeed = p_u_34.RotationSpeed
        v46.CFrame = CFrame_0 * Angles(0, 0, (math.rad(RotationSpeed)))
        v_u_43 = v_u_43 + p45
        if v_u_43 > 5 and v_u_44 then
            v_u_44:Disconnect()
        end
    end)
    Debris:AddItem(v_u_36, 5)
end
function v_u_1.TweenHighlight(p50, p51, p52, p53, p54)
    local v55 = Instance.new("Highlight")
    v55.Parent = p50
    v55.Adornee = p50
    v55.DepthMode = p53 or Enum.HighlightDepthMode.Occluded
    v55.FillColor = p51 or Color3.new(1, 1, 1)
    v55.OutlineColor = p51 or Color3.new(1, 1, 1)
    v55.FillTransparency = p54
    v55.OutlineTransparency = 0
    TweenService:Create(v55, TweenInfo.new(p52 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["FillTransparency"] = 1,
        ["OutlineTransparency"] = 1
    }):Play()
    Debris:AddItem(v55, p52)
    return v55
end
function v_u_1.TweenPartSize(p56, p57)
    if p56 and p56:IsA("BasePart") then
        local v58 = TweenService:Create(p56, TweenInfo.new(p57 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Size"] = Vector3.new(0, 0, 0)
        })
        v58:Play()
        return v58
    end
end
warn("VFXUtilities Module loaded successfully!")
return v_u_1
