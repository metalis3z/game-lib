-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local AssetSizeClassification = require(ReplicatedStorage.Client.Util.AssetSizeClassification)
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Shared.Globals.Constants)
local FuseMachineMotion = require(ReplicatedStorage.Client.FuseMachineMotion)
local FuseMachineSignals = require(ReplicatedStorage.Client.FuseMachineSignals)
local FuseMachine = require(ReplicatedStorage.Shared.Types.FuseMachine)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Message)
local Message_2 = require(ReplicatedStorage.Client.Notifications.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local v1 = Log.new()
local Machines = Workspace:WaitForChild("__OBJECTS").Machines
local Folder = Machines:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS.Machines must be a Folder")
local FuseMachine_2 = Machines.FuseMachine
local Model = FuseMachine_2:IsA("Model")
assert(Model, "Workspace FuseMachine must be a Model")
local Machine = FuseMachine_2.Machine
local BasePart = Machine:IsA("BasePart")
assert(BasePart, "FuseMachine.Machine must be a BasePart")
local Attachment = Machine.Attachment
local Attachment_2 = Attachment:IsA("Attachment")
assert(Attachment_2, "FuseMachine.Machine.Attachment must be an Attachment")
local ProximityPrompt = Attachment.ProximityPrompt
local ProximityPrompt_2 = ProximityPrompt:IsA("ProximityPrompt")
assert(ProximityPrompt_2, "FuseMachine proximity prompt must be a ProximityPrompt")
local v2 = 0

local function notifyError(v3) -- line 37 | captures: Message_2
    Message_2.Bottom({
        Time = 3,
        Message = v3,
        Color = Color3.fromRGB(255, 0, 0)
    })
end

local function playFuseAndGrant(v4) -- line 40 | captures: v2, Directory, AssetSizeClassification, Audio, FuseMachineMotion, Message, Message_2, Remotes, Tabs, v1, FuseMachine_2, Machine, ProximityPrompt
    local AssetCategory = v4.AssetCategory
    local v5 = Directory[AssetCategory]
    if v5 == nil then
        v1:AtError():Log("Fuse result category has no asset config", { Category = AssetCategory })
    else
        local Egg = v5.Egg
        v2 += 1
        local v6 = v2
        ProximityPrompt.Enabled = false
        if FuseMachineMotion.Run(FuseMachine_2, Machine, function() -- line 52 | captures: v6, v2
                return v2 == v6
            end) then
            Audio.Play(103131639134026, script)
            local v7 = AssetSizeClassification.Classify(v4.AssetScale)
            local v8
            if v7 then
                v8 = ("%* "):format(v7.RichText)
            else
                v8 = ""
            end
            local v9 = ("You fused %*<font color=\"#%*\">%*</font>"):format(v8, v5.Rarity.Color:ToHex(), Egg.DisplayName)
            local v10 = {
                dontRestore = true,
                icon = Egg.Icon
            }
            Message.Prompt(v9, v10)
            local v11, v12 = Remotes.Fusery.FinishReveal:InvokeServer()
            if not v11 then
                local v13 = if typeof(v12) == "string" then v12 else "Failed to grant fused egg"
                Message_2.Bottom({
                    Time = 3,
                    Message = v13,
                    Color = Color3.fromRGB(255, 0, 0)
                })
            end
            ProximityPrompt.Enabled = true
            Tabs.Dismiss(true)
        else
            ProximityPrompt.Enabled = true
        end
    end
end

ProximityPrompt.ActionText = "Fuse Pets"
ProximityPrompt.Triggered:Connect(function() -- line 88 | captures: Tabs
    Tabs.Show("PetFuse")
end)
FuseMachineSignals.FuseStarted:Connect(function(v14) -- line 91 | captures: FuseMachine, playFuseAndGrant
    local v15 = FuseMachine.FuseResult(v14)
    assert(v15, "Fuse started signal requires a valid serialized reward egg")
    task.spawn(playFuseAndGrant, v14)
end)
