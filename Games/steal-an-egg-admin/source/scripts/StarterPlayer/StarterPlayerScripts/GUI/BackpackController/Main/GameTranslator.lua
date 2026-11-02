-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
game.Players.LocalPlayer.PlayerGui:WaitForChild("BackpackGui")
local v1, LocalPlayer, LocaleId, v2
local BindableEvent = Instance.new("BindableEvent")

local function handlePlayerOrLocaleChanged() -- line 14 | captures: LocalPlayer, LocaleId, BindableEvent
    if LocalPlayer and LocalPlayer.LocaleId ~= LocaleId then
        LocaleId = LocalPlayer.LocaleId
        BindableEvent:Fire(LocaleId)
    end
end

local function reset() -- line 20 | captures: v1, LocalPlayer, v2
    v1 = nil
    LocalPlayer = nil
    if v2 then
        v2:Disconnect()
        v2 = nil
    end
end

local function getTranslator() -- line 28 | captures: v1, LocalPlayer, LocaleId, v2, LocalizationService, Players, BindableEvent, handlePlayerOrLocaleChanged
    local v3
    if v1 then
        v3 = true
    else
        LocalPlayer = Players.LocalPlayer
        if LocalPlayer then
            v1 = LocalizationService:GetTranslatorForPlayer(LocalPlayer)
            if LocalPlayer and LocalPlayer.LocaleId ~= LocaleId then
                LocaleId = LocalPlayer.LocaleId
                BindableEvent:Fire(LocaleId)
            end
            v3 = false
        else
            v3 = true
        end
    end
    if not v3 then
        v2 = LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(handlePlayerOrLocaleChanged)
    end
    return v1
end

local v4 = {}

local function unregisterGui(v5) -- line 44 | captures: v4
    v4[v5].connection:Disconnect()
    v4[v5] = nil
end

local function makeAncestryChangedHandler(v6, v7) -- line 48 | captures: v4
    return function(v8, v9) -- line 49 | captures: v6, v7, v4
        if game:IsAncestorOf(v6) then
            v7.hasBeenAdded = true
        elseif v7.hasBeenAdded then
            v4[v6].connection:Disconnect()
            v4[v6] = nil
        end
    end
end

local function updateRegistryInfo(v10, v11, v12) -- line 62
    v10.context = v11
    v10.text = v12
end

local function makeRegistryInfo(v13, v14, v15) -- line 66 | captures: v4
    local v16 = {
        hasBeenAdded = game:IsAncestorOf(v13),
        context = v14,
        text = v15
    }
    local AncestryChanged = v13.AncestryChanged
    v16.connection = AncestryChanged:Connect(function(v17, v18) -- line 68 | captures: v13, v16, v4
        if game:IsAncestorOf(v13) then
            v16.hasBeenAdded = true
        elseif v16.hasBeenAdded then
            v4[v13].connection:Disconnect()
            v4[v13] = nil
        end
    end)
    return v16
end

local function registerGui(v19, v20, v21) -- line 82 | captures: v4, makeRegistryInfo
    if v4[v19] == nil then
        v4[v19] = makeRegistryInfo(v19, v20, v21)
    else
        local v22 = v4[v19]
        v22.context = v20
        v22.text = v21
    end
end

local v23 = {
    LocaleChanged = BindableEvent.Event,
    TranslateGameText = function(v24, v25, v26) -- TranslateGameText | line 93
        return v26
    end
}

local function retranslateAll() -- line 97 | captures: v4, v23
    for v27, v28 in pairs(v4) do
        v27.Text = v23:TranslateGameText(v28.context, v28.text)
    end
end

local function TranslateAndRegister(v29, v30, v31, v32) -- line 102
    return v32
end

v23.TranslateAndRegister = TranslateAndRegister
return v23
