-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local OverlayRoot = require(ReplicatedStorage.Client.UI.VFX.OverlayRoot)

local function quintOut(v1, v2) -- line 10
    return TweenInfo.new(v1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, v2 or 0)
end

local v3 = {
    pitch = 1,
    lensWide = 100,
    lensResting = 70,
    cues = {
        {
            id = 93026295733507,
            volume = 0.8
        },
        {
            id = 112792997660073,
            volume = 1
        }
    },
    sheetProperties = {
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(255, 175, 0),
        Size = UDim2.new(1, 0, 1, 0)
    },
    sheetFade = TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.05),
    lensPush = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.05),
    lensSettle = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
}

local function stage(v4, v5, v6) -- line 26 | captures: TweenService
    return TweenService:Create(v4, v5, v6)
end

return function() -- line 29 | captures: TweenService, Audio, OverlayRoot, v3
    for v7, v8 in v3.cues do
        Audio.Play(v8.id, script, {
            PlaybackSpeed = v3.pitch,
            Volume = v8.volume
        })
    end
    local Frame = Instance.new("Frame")
    for v9, v10 in v3.sheetProperties do
        Frame[v9] = v10
    end
    Frame.Parent = OverlayRoot()
    local CurrentCamera = workspace.CurrentCamera
    local v11 = TweenService:Create(CurrentCamera, v3.lensSettle, { FieldOfView = v3.lensResting })
    local v12 = TweenService:Create(CurrentCamera, v3.lensPush, { FieldOfView = v3.lensWide })
    local v13 = TweenService:Create(Frame, v3.sheetFade, { BackgroundTransparency = 1 })
    v12.Completed:Once(function() -- line 48 | captures: v11
        v11:Play()
    end)
    v13.Completed:Once(function() -- line 51 | captures: Frame
        Frame:Destroy()
    end)
    v12:Play()
    v13:Play()
end
