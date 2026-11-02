-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
require(ReplicatedStorage.Shared.Types.Plots)
local Streamable = require(ReplicatedStorage.Packages.Streamable).Streamable
local PlotSignHomeButtonFade = require(script.Parent.Parent.Parent.GUI.PlotSignHomeButtonFade)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = Trove.new()
local v2 = {}
local v3 = {}

local function clearRemotePlotSignBinding(v4) -- line 19 | captures: v3
    local v5 = v3[v4]
    if v5 ~= nil then
        v5:Destroy()
    end
end

local function bindRemotePlotSign(v6, v7) -- line 26 | captures: Players, PlotState, Streamable, Trove, LocalPlayer, v2, v3
    local v8 = v3[v6]
    if v8 ~= nil then
        v8:Destroy()
    end
    if not (v7 ~= nil and v7 ~= LocalPlayer.UserId) then
        return
    end
    local v9 = Players:GetPlayerByUserId(v7)
    if v9 ~= nil then
        local v10 = PlotState.ResolvePlot(v9)
        if v10 ~= nil then
            local v11 = Trove.new()
            v3[v6] = v11
            v11:Add(function() -- line 44 | captures: v6, v11, v3
                if v3[v6] == v11 then
                    v3[v6] = nil
                end
            end)
            local PlotSign = Streamable.new(v10.PlotFolder, "PlotSign")
            v11:Add(function() -- line 51 | captures: PlotSign
                PlotSign:Destroy()
            end)
            v11:Add(PlotSign:Observe(function(v12, v13) -- line 54 | captures: v6, v10, Streamable, v2
                local PlayerPlotSign = Streamable.new(v12, "PlayerPlotSign")
                v13:Add(function() -- line 56 | captures: PlayerPlotSign
                    PlayerPlotSign:Destroy()
                end)
                v13:Add(PlayerPlotSign:Observe(function(v14) -- line 59 | captures: v6, v10, v2
                    local BillboardGui = v14:IsA("BillboardGui")
                    assert(BillboardGui, "PlayerPlotSign must be a BillboardGui")
                    local v15 = {
                        PetArea = v10.PetArea,
                        PlayerPlotSign = v14
                    }
                    v2[v6] = v15
                    return function() -- line 64 | captures: v14, v15, v6, v2
                        if v2[v6] == v15 then
                            v2[v6] = nil
                        end
                        if v14.Parent ~= nil then
                            v14.AlwaysOnTop = false
                        end
                    end
                end))
            end))
        end
    end
end

local function rebindAllRemotePlotSigns() -- line 76 | captures: PlotState, v3, bindRemotePlotSign
    local v16 = {}
    for v17 in pairs(v3) do
        v16[#v16 + 1] = v17
    end
    for v18, v19 in ipairs(v16) do
        local v20 = v3[v19]
        if v20 ~= nil then
            v20:Destroy()
        end
    end
    for v21, v22 in pairs(PlotState.ReadOwners()) do
        bindRemotePlotSign(v21, v22)
    end
end

local function updateYourBaseTracker(v23) -- line 92 | captures: RunService, Streamable, PlotSignHomeButtonFade, LocalPlayer, v1
    v1:Clean()
    if not v23 then
        return
    end
    local CenterPoint = v23.CenterPoint
    local PlotSign = Streamable.new(v23.PlotFolder, "PlotSign")
    v1:Add(function() -- line 99 | captures: PlotSign
        PlotSign:Destroy()
    end)
    v1:Add(PlotSign:Observe(function(v24, v25) -- line 102 | captures: CenterPoint, RunService, Streamable, PlotSignHomeButtonFade, LocalPlayer
        local SignUI = Streamable.new(v24, "SignUI")
        v25:Add(function() -- line 104 | captures: SignUI
            SignUI:Destroy()
        end)
        v25:Add(SignUI:Observe(function(v26) -- line 107
            local BillboardGui = v26:IsA("BillboardGui")
            assert(BillboardGui, "SignUI must be a BillboardGui")
            local Enabled = v26.Enabled
            v26.Enabled = false
            return function() -- line 112 | captures: v26, Enabled
                if v26.Parent ~= nil then
                    v26.Enabled = Enabled
                end
            end
        end))
        local Attachment = Streamable.new(v24, "Attachment")
        v25:Add(function() -- line 119 | captures: Attachment
            Attachment:Destroy()
        end)
        v25:Add(Attachment:Observe(function(v27, v28) -- line 122 | captures: CenterPoint, RunService, Streamable, PlotSignHomeButtonFade, LocalPlayer
            local YourBase = Streamable.new(v27, "YourBase")
            v28:Add(function() -- line 124 | captures: YourBase
                YourBase:Destroy()
            end)
            v28:Add(YourBase:Observe(function(v29) -- line 127 | captures: v28, CenterPoint, RunService, PlotSignHomeButtonFade, LocalPlayer
                local BillboardGui = v29:IsA("BillboardGui")
                assert(BillboardGui, "YourBase must be a BillboardGui")
                local v30 = PlotSignHomeButtonFade.new(v29)
                v28:Add(function() -- line 131 | captures: v30
                    v30:Destroy()
                end)

                local function updateDistance() -- line 134 | captures: v29, v30, CenterPoint, LocalPlayer
                    local Character = LocalPlayer.Character
                    local v31 = Character and Character:FindFirstChild("HumanoidRootPart")
                    if v31 and v31:IsA("BasePart") then
                        v29.MaxDistance = 300
                        local v32 = (v31.Position - CenterPoint.Position).Magnitude > 50
                        v30:SetVisible(v32)
                    else
                        v30:SetVisible(false)
                    end
                end

                updateDistance()
                return RunService.Heartbeat:Connect(updateDistance)
            end))
        end))
    end))
end

updateYourBaseTracker(PlotState.ResolvePlot())
PlotState.LocalPlotChanged:Connect(function() -- line 155 | captures: PlotState, updateYourBaseTracker
    updateYourBaseTracker(PlotState.ResolvePlot())
end)
rebindAllRemotePlotSigns()
PlotState.PlotChanged:Connect(bindRemotePlotSign)
PlotState.FolderChanged:Connect(rebindAllRemotePlotSigns)
Players.PlayerAdded:Connect(rebindAllRemotePlotSigns)
Players.PlayerRemoving:Connect(function(v33) -- line 162 | captures: PlotState, v3
    for v34, v35 in pairs(PlotState.ReadOwners()) do
        if v35 == v33.UserId then
            local v36 = v3[v34]
            if v36 ~= nil then
                v36:Destroy()
            end
        end
    end
end)
RunService.Heartbeat:Connect(function() -- line 173 | captures: Player, LocalPlayer, v2
    local v37 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local Position
    if v37 == nil then
    else
        Position = v37.Position
    end
    for v38, v39 in pairs(v2) do
        local PlayerPlotSign = v39.PlayerPlotSign
        if PlayerPlotSign.Parent ~= nil then
            local PetArea = v39.PetArea
            local v40
            if Position == nil or PetArea.Parent == nil then
                v40 = false
            else
                local v41 = PetArea.CFrame:PointToObjectSpace(Position)
                local v42 = PetArea.Size * 0.5
                local X = v41.X
                if math.abs(X) <= v42.X then
                    local Z = v41.Z
                    v40 = math.abs(Z) <= v42.Z
                else
                    v40 = false
                end
            end
            if PlayerPlotSign.AlwaysOnTop ~= v40 then
                PlayerPlotSign.AlwaysOnTop = v40
            end
        end
    end
end)
