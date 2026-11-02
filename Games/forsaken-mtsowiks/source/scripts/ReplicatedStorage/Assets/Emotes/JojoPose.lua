-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = require(l_ReplicatedStorage_0.Modules.Util);
local _ = game:GetService("CollectionService");
return {
    DisplayName = "Bizarre", 
    Description = "HOLY MACKEREL!!! IS THAT A MOTHER FLIPPIN' JOJO REFERENCE!!??", 
    Credits = "Made By: bruhmoment & vlad", 
    RenderImage = "rbxassetid://128245722773145", 
    Price = 1987, 
    CreatedServer = function(v3) --[[ Line: 14 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v3.Character;
        if l_Character_0 then
            local v5 = script.DismantleFX:Clone();
            v5.DismantleFX.Part0 = l_Character_0.PrimaryPart;
            v5.Parent = l_Character_0;
        end;
    end, 
    DestroyedServer = function(v6) --[[ Line: 23 ]] --[[ Name: DestroyedServer ]]
        local l_Character_1 = v6.Character;
        if l_Character_1 then
            for _, v9 in pairs(l_Character_1:GetChildren()) do
                if v9.Name == "DismantleFX" then
                    v9:Destroy();
                end;
            end;
        end;
    end, 
    AssetID = {
        "rbxassetid://128911592650352", 
        "rbxassetid://93401342721070", 
        "rbxassetid://94074930046514", 
        "rbxassetid://83490211241690", 
        "rbxassetid://123243040379028"
    }, 
    SFX = "rbxassetid://75631593769364", 
    SFXProperties = {
        Looped = true, 
        Volume = 1
    }, 
    SyncMusic = true, 
    SyncAnim = true
};