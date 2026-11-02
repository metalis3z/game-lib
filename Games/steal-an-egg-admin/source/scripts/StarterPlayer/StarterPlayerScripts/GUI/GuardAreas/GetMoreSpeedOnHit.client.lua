-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = Color3.fromRGB(255, 64, 64)
local v2 = Color3.fromRGB(48, 255, 105)
local v3 = Log.new()
local v4 = GUI.GetMoreSpeedOnHit()
local Frame = v4.Frame
local Frame_2 = Frame:IsA("Frame")
assert(Frame_2, "PlayerGui.GetMoreSpeedOnHit.Frame must be a Frame")
local Button = Frame.Button
local GuiButton = Button:IsA("GuiButton")
assert(GuiButton, "PlayerGui.GetMoreSpeedOnHit.Frame.Button must be a GuiButton")
local Frame_3 = Button.Frame
local Frame_4 = Frame_3:IsA("Frame")
assert(Frame_4, "PlayerGui.GetMoreSpeedOnHit.Frame.Button.Frame must be a Frame")
local Title = Frame_3.Title
local TextLabel = Title:IsA("TextLabel")
assert(TextLabel, "PlayerGui.GetMoreSpeedOnHit.Frame.Button.Frame.Title must be a TextLabel")
local v5 = require(ReplicatedStorage.Shared.Utils.Layout).EnsureScale(Frame_3)
local Position = Frame.Position
local v6 = UDim2.new(Position.X.Scale, Position.X.Offset, -0.4, Position.Y.Offset)
local TextColor3 = Title.TextColor3
local Scale = v5.Scale
local v7, v8, v9
local v10 = 0

local function playPositionTween(v11, v12) -- line 42 | captures: v7, Tween, Frame
    if v7 ~= nil then
        v7:Cancel()
    end
    v7 = Tween(Frame, { Position = v11 }, { 0.4, "Back", v12 })
    return v7
end

local function stopTitlePulse() -- line 49 | captures: v8
    local v13 = v8
    if v13 ~= nil then
        v8 = nil
        v13:Destroy()
    end
end

local function startTitlePulse() -- line 57 | captures: v8, Trove, Tween, v2, Title, v5, TextColor3, Scale
    local v14 = v8
    if v14 ~= nil then
        v8 = nil
        v14:Destroy()
    end
    Title.TextColor3 = TextColor3
    v5.Scale = Scale
    local v15 = Trove.new()
    v8 = v15
    v15:Add(function() -- line 67 | captures: Title, v5, TextColor3, Scale
        Title.TextColor3 = TextColor3
        v5.Scale = Scale
    end)
    local spawn = task.spawn
    v15:Add(spawn(function() -- line 71 | captures: v15, v8, Tween, v2, Title, v5, TextColor3, Scale
        while true do
            if v8 == v15 then
                Title.TextColor3 = TextColor3
                v5.Scale = Scale
                local v16 = Tween(Title, { TextColor3 = v2 }, {
                    0.28,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                })
                local v17 = Tween(v5, { Scale = Scale * 1.3 }, {
                    0.28,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                })
                v15:Add(v16)
                v15:Add(v17)
                v17.Completed:Wait()
                if v8 == v15 then
                    local v18 = Tween(Title, { TextColor3 = TextColor3 }, {
                        0.62,
                        Enum.EasingStyle.Elastic,
                        Enum.EasingDirection.Out
                    })
                    local v19 = Tween(v5, { Scale = Scale }, {
                        0.62,
                        Enum.EasingStyle.Elastic,
                        Enum.EasingDirection.Out
                    })
                    v15:Add(v18)
                    v15:Add(v19)
                    v19.Completed:Wait()
                    Title.TextColor3 = TextColor3
                    v5.Scale = Scale
                    continue
                end
            end
            break
        end
    end))
end

v4.Enabled = false
Title.TextColor3 = TextColor3
v5.Scale = Scale
ButtonFX(Button, nil, function() -- line 97 | captures: v9, PromptPurchase, v3
    local v20 = v9
    if v20 == nil then
        v3:AtWarning():Log("GetMoreSpeedOnHit button activated without an active product")
    else
        PromptPurchase.Prompt(v20, true)
    end
end)
Remotes.GuardPatrol.SpeedTollWarning.OnClientEvent:Connect(function() -- line 105 | captures: Message, v1
    Message.Bottom({
        Message = "You don't have enough speed!",
        Time = 2,
        Color = v1
    })
end)
Remotes.GuardPatrol.SpeedTollOffer.OnClientEvent:Connect(function(v21, v22) -- line 108 | captures: v8, v9, v10, Simple, v4, Frame, Title, Position, v6, playPositionTween, startTitlePulse
    v10 += 1
    local v23 = v10
    v9 = v21
    Title.Text = ("+%*"):format((Simple.FormatCompact(v22, ".#")))
    Frame.Position = v6
    startTitlePulse()
    v4.Enabled = true
    playPositionTween(Position, "Out")
    task.delay(6, function() -- line 117 | captures: v23, v8, v9, v10, v4, v6, playPositionTween
        if v23 == v10 then
            playPositionTween(v6, "In").Completed:Once(function() -- line 121 | captures: v23, v8, v9, v10, v4
                if v23 ~= v10 then
                    return
                end
                local v24 = v8
                if v24 ~= nil then
                    v8 = nil
                    v24:Destroy()
                end
                v9 = nil
                v4.Enabled = false
            end)
        end
    end)
end)
