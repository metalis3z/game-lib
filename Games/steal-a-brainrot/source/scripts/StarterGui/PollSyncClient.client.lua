-- PollSyncClient - mise à jour directe des votes sans passer par le Replicator
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")

local Net        = require(ReplicatedStorage.Packages.Net)
local SyncRemote = Net:RemoteEvent("PollService/Sync")
local LocalPlayer = Players.LocalPlayer

-- Trouver le PollUI dans le PlayerGui (ReplicatedGui est cloné dedans)
local function getPollUI()
    return LocalPlayer.PlayerGui:FindFirstChild("PollUI", true)
end

local function getPollFrame()
    local ui = getPollUI()
    if not ui then return nil end
    return ui:FindFirstChild("Poll")
end

local lastVotes = {A=0, B=0}

-- Mise à jour directe des labels de vote
local function updateVoteDisplay(votesA, votesB, voted)
    local frame = getPollFrame()
    if not frame then return end

    local total = math.max(1, votesA + votesB)
    local pctA  = math.floor((votesA / total) * 100)
    local pctB  = 100 - pctA

    -- Labels des boutons (Function = label de vote)
    local btn1 = frame.Buttons:FindFirstChild("1")
    local btn2 = frame.Buttons:FindFirstChild("2")

    if btn1 and btn1:FindFirstChild("Function") then
        btn1.Function.Text = votesA.." ("..pctA.."%)"
    end
    if btn2 and btn2:FindFirstChild("Function") then
        btn2.Function.Text = votesB.." ("..pctB.."%)"
    end

    -- Barre de progression
    local bar = frame:FindFirstChild("Bar")
    if bar then
        local fill = bar:FindFirstChild("Fill")
        local fill1Text = bar:FindFirstChild("Fill1Text")
        local fill2Text = bar:FindFirstChild("Fill2Text")

        if fill then
            TweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(pctA/100, 0, 1, 0)
            }):Play()
        end
        if fill1Text then fill1Text.Text = pctA.."%" end
        if fill2Text then fill2Text.Text = pctB.."%" end
    end

    lastVotes = {A=votesA, B=votesB}
end

-- Écouter les mises à jour directes
SyncRemote.OnClientEvent:Connect(function(pollID, votesA, votesB, voted)
    updateVoteDisplay(votesA, votesB, voted)
end)

-- Refresh toutes les secondes si le GUI est visible (backup)
task.spawn(function()
    while true do
        task.wait(1)
        local frame = getPollFrame()
        if frame and frame.Visible then
            -- Forcer un refresh si les valeurs ont changé
            updateVoteDisplay(lastVotes.A, lastVotes.B, {})
        end
    end
end)
