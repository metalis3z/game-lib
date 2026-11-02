-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local ChatMsg = require(ReplicatedStorage.Client.Types.ChatMsg)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local v1 = Color3.fromRGB(255, 255, 255)
local GothamBold = Enum.Font.GothamBold
local Size18 = Enum.FontSize.Size18
local v2 = {
    MessageDecorators = {}
}
local JSONDecode = HttpService.JSONDecode
local TextChannel = Instance.new("TextChannel")
local v3 = {}
for v4, v5 in { "Secret", "Eternal", "Divine" } do
    v3[v5] = Rarity.Rarities[v5].RarityGradient
end

local function freshProperties() -- line 23 | captures: TextChatService
    return TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
end

local function badgedPrefix(v6) -- line 26 | captures: Players
    local TextSource = v6.TextSource
    local v7
    if TextSource then
        v7 = Players:GetPlayerByUserId(TextSource.UserId)
    end
    if v7 ~= nil and v7:GetAttribute("MonetizationVipProductOwned") == true then
        return (("<font color='#FFC700'>[VIP-OG]</font> %*"):format(v6.PrefixText))
    end
    return nil
end

local function prefixOnly(v8) -- line 40 | captures: TextChatService
    if v8 == nil then
        return nil
    end
    local v9 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
    v9.PrefixText = v8
    return v9
end

local function decodeRarity(v10) -- line 48 | captures: HttpService, JSONDecode
    local v11, v12 = pcall(JSONDecode, HttpService, v10)
    if v11 then
        return v12.rarity
    end
    return nil
end

function v2.Announce(v13) -- line 56 | captures: TextChatService, v1, GothamBold, Size18, TextChannel
    task.spawn(function() -- line 57 | captures: v13, TextChatService, v1, GothamBold, Size18, TextChannel
        local Body = v13.Body
        local v14
        if v13.SkipTint then
        else
            v14 = v13.Tint or v1
        end
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            if v14 ~= nil then
                local v15 = v14:ToHex()
                Body = string.format("<font color='#%s'>%s</font>", v15, Body)
            end
            TextChannel:DisplaySystemMessage(Body, v13.Payload or "")
        else
            local v16 = { Color = v14 }
            v16.Font = v13.Face or GothamBold
            v16.FontSize = v13.PointSize or Size18
            v16.Text = Body
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", v16)
        end
    end)
end

TextChannel.Name = "GameSystem"
TextChannel.Parent = TextChatService

local function baseIncomingMessage(v17) -- line 97 | captures: HttpService, Players, TextChatService, v1, JSONDecode, v3
    local TextSource = v17.TextSource
    local v18
    if TextSource then
        v18 = Players:GetPlayerByUserId(TextSource.UserId)
    end
    local v19
    if v18 ~= nil and v18:GetAttribute("MonetizationVipProductOwned") == true then
        v19 = ("<font color='#FFC700'>[VIP-OG]</font> %*"):format(v17.PrefixText)
    end
    local Metadata = v17.Metadata
    local rarity
    if Metadata then
        local v20, v21 = pcall(JSONDecode, HttpService, Metadata)
        if v20 then
            rarity = v21.rarity
        end
    end
    local v22
    if rarity == nil then
    else
        v22 = v3[rarity]
    end
    if v22 == nil then
        if v19 == nil then
            return nil
        end
        local v23 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
        v23.PrefixText = v19
        return v23
    end
    local v24 = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
    local v25 = v17.Text:gsub("!", "")
    if v19 then
        v25 = ("<font color='#FFC700'>[VIP-OG]</font> %*"):format(v25)
    end
    v24.PrefixText = v25
    v24.Text = "!"
    v24.TextColor3 = v1
    v24.PrefixTextProperties = TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
    v24.PrefixTextProperties.TextColor3 = v1
    local v26 = v22:Clone()
    v26.Parent = v24.PrefixTextProperties
    v17.ChatWindowMessageProperties = v24
    task.delay(10, function() -- line 148 | captures: v26
        v26.Enabled = false
    end)
    return v24
end

function TextChatService.OnIncomingMessage(v27) -- line 153 | captures: v2, baseIncomingMessage
    local v28 = baseIncomingMessage(v27)
    for v29, v30 in ipairs(v2.MessageDecorators) do
        local v31, v32 = pcall(v30, v27, v28)
        if v31 then
            if v32 ~= nil then
                v28 = v32
            end
        else
            warn("[ChatMsg] Message decorator failed:", v32)
        end
    end
    return v28
end

Remotes.ChatFeed.ShowFromRecord.OnClientEvent:Connect(function(v33) -- line 167 | captures: ChatMsg, v2
    local function v34(...)
        assert(...)
    end

    v34(ChatMsg.AnnounceData(v33))
    v2.Announce({
        Body = v33.message,
        Face = v33.font,
        Payload = v33.metadata,
        PointSize = v33.fontSize,
        SkipTint = v33.omitColor,
        Tint = v33.color
    })
end)
Remotes.ChatFeed.ShowFromArgs.OnClientEvent:Connect(function(v35, v36, v37, v38, v39, v40) -- line 178 | captures: v2
    v2.Announce({
        Body = v35,
        Face = v37,
        Payload = v40,
        PointSize = v38,
        SkipTint = v39,
        Tint = v36
    })
end)
Remotes.ChatFeed.ShowPlain.OnClientEvent:Connect(function(v41, v42, v43, v44) -- line 188 | captures: v2
    v2.Announce({
        SkipTint = true,
        Body = v41,
        Face = v42,
        Payload = v44,
        PointSize = v43
    })
end)
return v2
