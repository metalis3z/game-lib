-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local Message = require(ReplicatedStorage.Client.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local v1

local function celebrate(v2, v3) -- line 10 | captures: Audio, Confetti, Message
    print(("[PurchaseDebug] CELEBRATE type=%s name=%s"):format(v2, (tostring(v3))))
    Audio.Play(100974209349588, script)
    Confetti.Burst()
    Message.Prompt("Purchase successful! Thank you so much! \240\159\152\132")
end

Remotes.PassGrants.Awarded.OnClientEvent:Connect(function(v4) -- line 16 | captures: Audio, Confetti, Message, Save
    print(("[PurchaseDebug] NOTIFICATION type=Gamepass name=%s"):format((tostring(v4))))
    if not Save.Get() then
        return
    end
    print(("[PurchaseDebug] CELEBRATE type=%s name=%s"):format("Gamepass", (tostring(v4))))
    Audio.Play(100974209349588, script)
    Confetti.Burst()
    Message.Prompt("Purchase successful! Thank you so much! \240\159\152\132")
end)

local function onProductBought(v5, v6) -- line 23 | captures: v1, Audio, Confetti, Message, Save
    local v7, v8
    if type(v6) == "table" then
        local ProductName = v6.ProductName
        if ProductName then
            v7 = ProductName
            v8 = true
        else
            local ProductId = v6.ProductId
            if ProductId then
                v7 = ProductId
                v8 = true
            else
                v8 = false
            end
        end
    else
        v8 = false
    end
    if not v8 then
        v7 = "DeveloperProduct"
    end
    print(("[PurchaseDebug] NOTIFICATION type=DeveloperProduct name=%s"):format((tostring(v7))))
    if not Save.Get() then
        return
    end
    local v9 = if type(v6) == "table" then v6.PurchaseId else nil
    if v9 ~= nil then
        if v1 == v9 then
            print(("[PurchaseDebug] DUPLICATE ignored purchaseId=%s"):format((tostring(v9))))
            return
        end
        v1 = v9
    end
    print(("[PurchaseDebug] CELEBRATE type=%s name=%s"):format("DeveloperProduct", (tostring(v7))))
    Audio.Play(100974209349588, script)
    Confetti.Burst()
    Message.Prompt("Purchase successful! Thank you so much! \240\159\152\132")
end

Remotes.Storefront.PurchaseSettled.OnClientEvent:Connect(onProductBought)
Remotes.Storefront.ReceiptCleared.OnClientEvent:Connect(onProductBought)
Remotes.Storefront.PurchaseRejected.OnClientEvent:Connect(function(v10) -- line 45 | captures: Message
    task.delay(120, function() -- line 46 | captures: Message
        Message.Prompt("ERROR: Purchase failed! If this continues to happen let us know! Roblox should be refunding you automatically. Sorry \240\159\152\138")
    end)
end)
return {}
