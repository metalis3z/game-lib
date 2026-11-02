-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
require(ReplicatedStorage.Shared.Eggs.Types)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = Color3.fromRGB(166, 255, 111)
local v2 = TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local v3 = {}

local function stopPulse(v4) -- line 13
    local PulseTween = v4.PulseTween
    v4.PulseTween = nil
    if PulseTween ~= nil then
        PulseTween:Cancel()
        PulseTween:Destroy()
    end
    v4.HatchButton.BackgroundColor3 = v4.OriginalHatchColor
end

local function startPulse(v5) -- line 22 | captures: TweenService, v1, v2
    if v5.PulseTween ~= nil then
        return
    end
    local v6 = TweenService:Create(v5.HatchButton, v2, { BackgroundColor3 = v1 })
    v5.PulseTween = v6
    v6:Play()
end

local function updateButtonState(v7, v8, v9) -- line 30 | captures: TweenService, v1, v2
    if v7.HatchButton == v7.GrowButton then
        local GrowButton = v7.GrowButton
        GrowButton.Visible = v8 or v9
        GrowButton.Active = v8 or v9
    else
        v7.GrowButton.Visible = not v8 and v9
        v7.GrowButton.Active = not v8 and v9
        v7.HatchButton.Visible = v8
        v7.HatchButton.Active = v8
    end
    v7.Ready = v8
    if v8 then
        if v7.PulseTween == nil then
            local v10 = TweenService:Create(v7.HatchButton, v2, { BackgroundColor3 = v1 })
            v7.PulseTween = v10
            v10:Play()
        end
    else
        local PulseTween = v7.PulseTween
        v7.PulseTween = nil
        if PulseTween ~= nil then
            PulseTween:Cancel()
            PulseTween:Destroy()
        end
        v7.HatchButton.BackgroundColor3 = v7.OriginalHatchColor
    end
end

function v3.Mount(v11, v12, v13, v14, v15) -- line 60 | captures: Trove
    local v16 = v11:Clone()
    v16.Name = v13
    v16.Visible = true
    v16.Parent = v12
    local Skip = v16.Spacer.Skip
    local v17 = v16.Spacer:FindFirstChild("Open") or Skip
    if v17 ~= Skip then
        v17.Visible = false
    end
    local v18 = Trove.new()
    local v19 = {
        Ready = false,
        Uid = v13,
        Root = v16,
        GrowButton = Skip,
        HatchButton = v17,
        OriginalHatchColor = v17.BackgroundColor3,
        Trove = v18
    }
    v18:Add(v16)
    v18:Add(function() -- line 81 | captures: v19
        local PulseTween = v19.PulseTween
        v19.PulseTween = nil
        if PulseTween ~= nil then
            PulseTween:Cancel()
            PulseTween:Destroy()
        end
        v19.HatchButton.BackgroundColor3 = v19.OriginalHatchColor
    end)
    if v17 == Skip then
        v18:Connect(Skip.Activated, function() -- line 92 | captures: v13, v14, v15, v19
            if v19.Ready then
                v15(v13)
            else
                v14(v13)
            end
        end)
    else
        v18:Connect(Skip.Activated, function() -- line 101 | captures: v13, v14
            v14(v13)
        end)
        v18:Connect(v17.Activated, function() -- line 104 | captures: v13, v15
            v15(v13)
        end)
    end
    return v19
end

function v3.Update(v20, v21, v22, v23, v24, v25) -- line 109 | captures: updateButtonState
    local Spacer = v20.Root.Spacer
    Spacer.Icon.Image = v21
    Spacer.Progress.Fill.Size = UDim2.fromScale(v22, 1)
    Spacer.Progress.TextLabel.Text = v23
    Spacer.Progress.Visible = not v24
    updateButtonState(v20, v24, v25)
end

function v3.Destroy(v26) -- line 117
    v26.Trove:Destroy()
end

return v3
