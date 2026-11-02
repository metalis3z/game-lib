-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
game:GetService("Workspace")

local function toMMSS(v1) -- line 9
    return string.format("%02i:%02i", v1 / 60 % 60, v1 % 60)
end

local function ParsePath(v2) -- line 17 | captures: Lighting, Players
    local v3 = v2:split(".")
    local v4
    for v5, v6 in v3 do
        if v5 == #v3 then
            return v4, v6
        end
        if v4 then
            v4 = v4[v6]
        elseif v6 == "game" then
            v4 = game
        elseif v6 == "workspace" or v6 == "Workspace" then
            v4 = workspace
        elseif v6 == "Terrain" then
            v4 = workspace.Terrain
        elseif v6 == "Lighting" then
            v4 = Lighting
        elseif v6 == "Player" or v6 == "player" then
            v4 = Players.LocalPlayer
        elseif v6 == "PlayerGui" then
            v4 = Players.LocalPlayer.PlayerGui
        end
    end
    error(("[%s] Invalid Path: %s"):format(script.Name, v2))
end

local function SetProperty(v7, v8) -- line 42 | captures: ParsePath
    local v9 = v8
    return function() -- line 43 | captures: v9, v7, ParsePath
        local v10, v11 = ParsePath(v7)
        if v11 == "CFrame" and v10:GetAttribute("OffsetCFrame") then
            v9 *= v10:GetAttribute("OffsetCFrame")
        end
        if v10:IsA("Model") and v11 == "CFrame" then
            v10:PivotTo(v9)
        else
            v10[v11] = v9
        end
    end
end

local function TweenProperty(v12, v13, v14) -- line 60 | captures: TweenService, ParsePath
    local v15 = v14
    return function() -- line 61 | captures: v15, v12, v13, TweenService, ParsePath
        local v16, v17 = ParsePath(v12)
        if v17 == "CFrame" and v16:GetAttribute("OffsetCFrame") then
            v15 *= v16:GetAttribute("OffsetCFrame")
        end
        if not (v17 == "CFrame" and v16:IsA("Model")) then
            local v18 = {}
            v18[v17] = v15
            TweenService:Create(v16, v13, v18):Play()
        else
            local CFrameValue = Instance.new("CFrameValue")
            CFrameValue.Value = v16:GetPivot()
            TweenService:Create(CFrameValue, v13, { Value = v15 }):Play()
            CFrameValue.Changed:Connect(function() -- line 76 | captures: v16, CFrameValue
                v16:PivotTo(CFrameValue.Value)
            end)
        end
    end
end

local function LoadAnimationIntoRig(v19, v20) -- line 86
    local v21 = v19:FindFirstChild("AnimationController") or v19:FindFirstChildOfClass("Humanoid")
    if not v21 then
        error(("No usable animation controller or humanoid exists for %s"):format(v19:GetFullName()))
    end
    local Animator = v21:FindFirstChildOfClass("Animator")
    if not Animator then
        Animator = Instance.new("Animator")
        Animator.Parent = v21
    end
    local Animation = Instance.new("Animation")
    Animation.AnimationId = v20
    return Animator:LoadAnimation(Animation)
end

local function MakeFallbackCamera(v22, v23) -- line 109
    local CFrame_2 = v22.CFrame
    local LookVector = CFrame_2.LookVector
    local Position
    if v23 then
        local Position_2
        local v24 = -1
        for v25, v26 in ipairs(v23:GetChildren()) do
            if v26 ~= v22.Parent and v26:IsA("Model") then
                local pcall_2 = pcall
                local v27 = v26
                local v28, v29 = pcall_2(function() -- line 117 | captures: v27
                    return (v27:GetBoundingBox())
                end)
                if v28 and v29 then
                    local v30 = v29.Position - CFrame_2.Position
                    if v30.Magnitude > 1 then
                        local v31 = v30.Unit:Dot(LookVector)
                        if v31 > 0.55 and v24 < v31 then
                            Position_2 = v29.Position
                            v24 = v31
                        end
                    end
                end
            end
            Position = Position_2
        end
    end
    local v32 = Position or CFrame_2.Position + LookVector * 60
    local Magnitude = (v32 - CFrame_2.Position).Magnitude
    local v33 = math.clamp(Magnitude, 6, 400)
    local v34 = v33 * 0.22
    local v35 = math.max(v34, 10)
    local v36 = v33 * 0.45
    local v37 = math.min(v35, v36)
    local v38 = v33 * 0.1
    local v39 = math.max(v38, 4)
    local v40 = v33 * 0.3
    local v41 = math.min(v39, v40)
    local v42 = v33 * 0.035
    local v43 = math.max(v42, 1.5)
    return function(v44, v45) -- line 142 | captures: CFrame_2, v32, v37, v41, v43
        local v46
        if v45 and v45 > 0 then
            local v47 = v44 / v45
            v46 = math.clamp(v47, 0, 1)
        else
            v46 = 0
        end
        local v48 = v46 * v46 * (3 - v46 * 2)
        local v49 = CFrame_2.Position + CFrame_2.LookVector * (v37 * v48) + CFrame_2.RightVector * (v41 * v48)
        local v50 = v43 * v48
        local v51 = v49 + Vector3.new(0, v50, 0)
        return CFrame.lookAt(v51, v32)
    end
end

local function SetVisibility(v52, v53) -- line 157
    for v54, v55 in v52:GetDescendants() do
        if v55:IsA("BasePart") then
            if v55:GetAttribute("OriginalTransparency") == nil then
                v55:SetAttribute("OriginalTransparency", v55.Transparency)
            end
            if v53 then
                v55.Transparency = v55:GetAttribute("OriginalTransparency")
            else
                v55.Transparency = 1
            end
        end
    end
end

local v56 = {}

function v56.GetHelperFunctions(v57) -- line 175 | captures: RunService, SoundService, TweenService, toMMSS, ParsePath, SetProperty, TweenProperty, LoadAnimationIntoRig, MakeFallbackCamera, SetVisibility
    local v58 = {
        toMMSS = toMMSS,
        ParsePath = ParsePath,
        SetProperty = SetProperty,
        TweenProperty = TweenProperty,
        LoadAnimationIntoRig = LoadAnimationIntoRig,
        MakeFallbackCamera = MakeFallbackCamera
    }

    function v58.CreateAndPlaySound(v59, v60, v61) -- line 183 | captures: v57
        local v62 = v60 or workspace:FindFirstChild("Terrain")
        local Sound = Instance.new("Sound")
        Sound.SoundId = v59
        Sound.Parent = v62
        Sound.Volume = v61 or 0.5
        Sound.RollOffMaxDistance = 9999
        Sound.RollOffMinDistance = 0
        Sound.RollOffMode = Enum.RollOffMode.Linear
        task.delay(0.1, function() -- line 195 | captures: Sound
            Sound:Play()
        end)
        v57:Add(Sound)
        return Sound
    end

    function v58.PlaySequenceAsync(v63, v64, v65) -- line 202 | captures: v57, RunService
        if v63 then
            v63:Play()
        end
        local v66 = {}
        local v67 = 0
        local v68 = RunService.Heartbeat:Connect(function(v69) -- line 209 | captures: v67, v64, v66
            v67 += v69
            for v70 = 0, 9 do
                local v71 = v67 * 60 - v70
                local v72 = math.floor(v71)
                if v64[v72] and not v66[v72] then
                    v66[v72] = true
                    for v73, v74 in v64[v72] do
                        task.spawn(v74)
                    end
                end
            end
        end)
        v57:Add(v68)
        task.wait(v65)
        v68:Disconnect()
    end

    v58.SetVisibility = SetVisibility

    function v58.TweenMuteBackgroundMusic() -- line 232 | captures: v57, SoundService, TweenService
        local v75 = TweenInfo.new(1)
        TweenService:Create(SoundService.Music.BackgroundMusic, v75, { Volume = 0 }):Play()
        v57:Add(function() -- line 235 | captures: SoundService, TweenService
            local v76 = TweenInfo.new(1)
            TweenService:Create(SoundService.Music.BackgroundMusic, v76, { Volume = 1 }):Play()
        end)
    end

    return v58
end

return v56
