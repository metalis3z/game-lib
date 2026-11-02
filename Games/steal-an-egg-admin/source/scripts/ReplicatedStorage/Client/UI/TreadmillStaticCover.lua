-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local v1 = GUI.StaticTreadmillImageSurfaceGui()
local SurfaceGui = v1:IsA("SurfaceGui")
assert(SurfaceGui, "Static treadmill image GUI must be a SurfaceGui")
local v2 = {}

function v2.Create(v3, v4) -- line 14 | captures: v1
    local v5 = v1:Clone()
    v5.Name = v3
    v5.Adornee = v4
    v5.Enabled = true
    v5.Parent = v1.Parent
    return v5
end

local function SetEnabled(v6, v7) -- line 22
    v6.Enabled = v7
end

v2.SetEnabled = SetEnabled

function v2.ApplyMedia(v8, v9) -- line 25 | captures: TreadmillVideoController
    v8.VideoFrame.Image.Image = TreadmillVideoController.ResolveCoverImage(v9)
    v8.VideoFrame.StopPlay.Image = TreadmillVideoController.GetStoppedIconImage()
    v8.VideoFrame.StopPlay.Visible = true
end

function v2.ApplyFeed(v10, v11) -- line 31 | captures: TreadmillVideoController, v2
    v2.ApplyMedia(v10, TreadmillVideoController.GetCurrentMediaEntry(v11))
end

return v2
