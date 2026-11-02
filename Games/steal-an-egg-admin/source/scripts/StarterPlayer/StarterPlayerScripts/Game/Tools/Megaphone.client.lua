-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolSetup = require(ReplicatedStorage.Client.Util.ToolSetup)
local t = require(ReplicatedStorage.Packages.t)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Megaphone = require(ReplicatedStorage.Data.Gears).Directory.Megaphone
local COOLDOWN = Megaphone.COOLDOWN
local v2 = false
local v3 = {}

local function _stopVFX(v4) -- line 16 | captures: v3
    if v4 then
        local v5 = v3[v4]
        if v5 and v5.Parent then
            v5:Destroy()
            v3[v4] = nil
        end
    end
end

local function startEffectWindow() -- line 26 | captures: v2
    v2 = v2 or true
end

local Attach = ToolSetup.Attach
local DisplayName = Megaphone.DisplayName
local v6 = {}

function v6.onActivated(v7) -- line 33 | captures: v2, Remotes
    if not v2 then
        Remotes.MegaphoneGadget.Rouse:FireServer()
    end
end

function v6.onUnequipped() -- line 39 | captures: v2
    v2 = v2 and false
end

local v8 = Attach(DisplayName, v6)
Remotes.MegaphoneGadget.EmitFx.OnClientEvent:Connect(function(v9, v10) -- line 46 | captures: t, v1, Megaphone, v3
    t.strict(t.instanceIsA("Model"))(v9)
    local v11 = v10:FindFirstChildWhichIsA("ParticleEmitter", true)
    if v11 then
        v11.Enabled = true
        v3[v9] = v11
        task.delay(Megaphone.EFFECT_DURATION, function() -- line 57 | captures: v9, v11, v3
            if v3[v9] == v11 then
                v3[v9] = nil
                if v11.Parent then
                    v11.Enabled = false
                end
            end
        end)
    else
        local Name = v9.Name
        v1:AtWarning():Log((("[Megaphone] No VFX found for %*"):format(Name)))
    end
end)
Remotes.MegaphoneGadget.EmitSfx.OnClientEvent:Connect(function(v12) -- line 67 | captures: t, Megaphone
    t.strict(t.instanceIsA("Model"))(v12)
    if Megaphone.SFX_ID ~= "rbxassetid://0" then
        local v13 = v12.PrimaryPart or v12:FindFirstChild("HumanoidRootPart")
        if v13 and v13:IsA("BasePart") then
            local Sound = Instance.new("Sound")
            Sound.SoundId = Megaphone.SFX_ID
            Sound.Parent = v13
            Sound:Play()
            task.delay(5, function() -- line 80 | captures: Sound
                if Sound.Parent then
                    Sound:Destroy()
                end
            end)
        end
    end
end)
Remotes.MegaphoneGadget.OpenEffectWindow.OnClientEvent:Connect(function() -- line 88 | captures: v2, ToolSetup, COOLDOWN, v8
    v2 = v2 or true
    ToolSetup.ApplyCooldown(v8, COOLDOWN)
end)
Remotes.MegaphoneGadget.CloseEffectWindow.OnClientEvent:Connect(function() -- line 94 | captures: v2
    v2 = v2 and false
end)
