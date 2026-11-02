-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local v1 = GUI.RollbackReward()
local Main = v1.Main
local Contents = Main.Contents
local Title = Contents.Title
local Description = Contents.Description
local ImageHolder = Contents.ImageHolder
local ImageLabel = ImageHolder.ImageLabel

local function hideModal() -- line 16 | captures: v1
    v1.Enabled = false
end

local function showNotice(v2, v3, v4, v5) -- line 19 | captures: v1, Title, Description, ImageHolder, ImageLabel
    Title.Text = v2 or ""
    Description.Text = v3 or ""
    ImageLabel.Image = v4 or ""
    local UIGradient = ImageHolder:FindFirstChildOfClass("UIGradient")
    if UIGradient then
        UIGradient:Destroy()
    end
    if v5 then
        v5:Clone().Parent = ImageHolder
    end
    v1.Enabled = true
end

v1.Enabled = false
GUI.ButtonActivated(Main.Close, function() -- line 34 | captures: v1
    v1.Enabled = false
end)
GUI.ButtonActivated(Contents.Ok, function() -- line 37 | captures: v1
    v1.Enabled = false
end)
Remotes.RollbackRewards.ShowNotice.OnClientEvent:Connect(function(v6, v7, v8, v9) -- line 40 | captures: v1, Title, Description, ImageHolder, ImageLabel
    local v10
    if not (typeof(v9) == "Instance" and v9:IsA("UIGradient")) then
    else
        v10 = v9
    end
    Title.Text = v6 or ""
    Description.Text = v7 or ""
    ImageLabel.Image = v8 or ""
    local UIGradient = ImageHolder:FindFirstChildOfClass("UIGradient")
    if UIGradient then
        UIGradient:Destroy()
    end
    if v10 then
        v10:Clone().Parent = ImageHolder
    end
    v1.Enabled = true
end)
