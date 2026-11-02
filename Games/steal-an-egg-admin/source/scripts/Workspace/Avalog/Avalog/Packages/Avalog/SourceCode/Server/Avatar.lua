-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Parent = script.Parent.Parent.Parent
local Future = require(Parent.Parent.Future)
local RateLimit = require(Parent.Parent.RateLimit)
local HumanoidDescriber = require(Parent.Parent.HumanoidDescriber)
local server = require(Parent.SourceCode.Shared.Zap.server)
local EnumSerDes = require(Parent.Parent.EnumSerDes)
local PlayerDataStore = require(Parent.SourceCode.Server.PlayerDataStorage.PlayerDataStore)
local Squash = require(Parent.Parent.Squash)
local AvatarData = require(Parent.SourceCode.Server.PlayerDataStorage.SerDes.AvatarData)
local v1 = require(Parent.Config):Get()
local v2 = {
    Update = RateLimit(3, 1),
    BulkPurchaseItems = RateLimit(1, 2)
}
local v3 = {
    Avatars = {}
}

function v3.HandleProfile(v4, v5, v6) -- line 24 | captures: Squash, AvatarData, v3
    if not v5:HasAppearanceLoaded() then
        v5.CharacterAppearanceLoaded:Wait()
    end
    v5.CharacterAppearanceLoaded:Connect(function() -- line 29 | captures: v5, v6, Squash, AvatarData, v3
        local v7 = v6.Data:Get()
        if v7.Avatar.Data == nil then
            return
        end
        local v8 = Squash.frombuffer(v7.Avatar.Data)
        local v9 = AvatarData.des(v8)
        v3:ApplyData(v5, v9)
    end)
    v6.Data:Observe(function(v10, v11) -- line 40 | captures: v5, Squash, AvatarData, v3
        if not v11.Avatar.Data then
            return
        end
        local v12 = Squash.frombuffer(v11.Avatar.Data)
        local v13 = AvatarData.des(v12)
        v3:ApplyData(v5, v13)
    end)
end

function v3.BulkPurchaseItems(v14, v15, v16) -- line 50 | captures: MarketplaceService, Future
    Future.Try(function() -- line 51 | captures: v15, v16, MarketplaceService
        return MarketplaceService:PromptBulkPurchase(v15, v16, {})
    end):After(function(v17, v18) -- line 53
        if not v17 then
            warn(v18)
        end
    end)
end

function v3.UpdateData(v19, v20, v21) -- line 60 | captures: PlayerDataStore, v3
    local v22 = PlayerDataStore:Get(v20)
    if v22 == nil then
        v3:ApplyData(v20, v21)
    else
        v22.Session:patch(PlayerDataStore.Actions.SetAvatarData, v21)
    end
end

function v3.ApplyData(v23, v24, v25) -- line 70 | captures: HumanoidDescriber, v3
    local v26, v27, v28 = v3:GetCharacterObjects(v24)
    if not (v27 and v28) then
        return
    end
    local v29 = HumanoidDescriber(v28)
    if v25.Clothing.Shirt == 0 then
        v25.Clothing.Shirt = 855777286
    end
    if v25.Clothing.Pants == 0 then
        v25.Clothing.Pants = 855782781
    end
    v29:UpdateData(function() -- line 82 | captures: v25
        return v25
    end)
    v3:Apply(v24, v28):Await()
    v29:Destroy()
end

function v3.Apply(v30, v31, v32) -- line 92 | captures: Future
    local Character = v31.Character
    local Humanoid
    if Character then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    if not Character or not Humanoid then
        return false
    end
    local Try = Future.Try
    local Humanoid_2 = Humanoid
    return Try(function() -- line 98 | captures: v32, Humanoid_2
        Humanoid_2:ApplyDescriptionReset(v32)
    end)
end

local function GetCharacterObjects(v33, v34) -- line 107
    local Character = v34.Character
    local Humanoid
    if Character then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    if not Character or not Humanoid then
        return nil
    end
    return Character, Humanoid, Humanoid:FindFirstChildOfClass("HumanoidDescription")
end

v3.GetCharacterObjects = GetCharacterObjects

function v3.Start(v35) -- line 120 | captures: server, EnumSerDes, PlayerDataStore, v1, v2, v3
    server.BulkPurchaseAvatarItems.SetCallback(function(v36, v37) -- line 121 | captures: EnumSerDes, v2, v3
        if v2.BulkPurchaseItems(v36.UserId) then
            local v38 = EnumSerDes.DeserializeTree(v37)
            return v3:BulkPurchaseItems(v36, v38)
        end
    end)
    server.UpdateAvatar.SetCallback(function(v39, v40) -- line 129 | captures: EnumSerDes, v1, v2, v3
        if v1.AvatarSavingAllowed and v2.Update(v39.UserId) then
            local v41 = EnumSerDes.DeserializeTree(v40)
            return v3:UpdateData(v39, v41)
        end
    end)
    PlayerDataStore.Loaded:Connect(function(v42, v43) -- line 141 | captures: v3
        v3:HandleProfile(v42, v43)
    end)
    for v44, v45 in pairs(PlayerDataStore.Profiles) do
        v3:HandleProfile(v44, v45)
    end
end

return v3
