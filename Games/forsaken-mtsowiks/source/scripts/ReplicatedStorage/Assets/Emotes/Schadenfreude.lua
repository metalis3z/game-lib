-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    ScoutLaugh = "rbxassetid://99907172493781", 
    PyroLaugh = "rbxassetid://81881589472757", 
    SoldierLaugh = "rbxassetid://114584473003045", 
    DemoLaugh = "rbxassetid://129252779856972", 
    HeavyLaugh = "rbxassetid://112263797681728", 
    EngineerLaugh = "rbxassetid://132961737774004", 
    MedicLaugh = "rbxassetid://84212549244283", 
    SniperLaugh = "rbxassetid://127466333676577", 
    SpyLaugh = "rbxassetid://89571344981581"
};
return {
    DisplayName = "Schadenfreude", 
    Description = "neener neener", 
    Credits = "Made By: ffPrankster", 
    RenderImage = "rbxassetid://83576021763587", 
    Price = 1250, 
    Uncancellable = true, 
    AssetID = {
        "rbxassetid://117301742787680", 
        "rbxassetid://116898799095144", 
        "rbxassetid://128599579590894", 
        "rbxassetid://93532538340821", 
        "rbxassetid://126042670356110", 
        "rbxassetid://110658165314041", 
        "rbxassetid://116548627328150", 
        "rbxassetid://79005934720784", 
        "rbxassetid://114739408207317"
    }, 
    SFXProperties = {
        Volume = 0.5, 
        Looped = false
    }, 
    CreatedServer = function(v1) --[[ Line: 43 ]] --[[ Name: CreatedServer ]]
        -- upvalues: v0 (copy)
        local v2 = v1.Character and v1.Character.PrimaryPart;
        local l_Emote_0 = v1.Emote;
        if v2 and l_Emote_0 then
            for v4, v5 in pairs(v0) do
                l_Emote_0:GetMarkerReachedSignal(v4):Connect(function() --[[ Line: 48 ]]
                    -- upvalues: v1 (copy), v5 (copy)
                    v1.SFX = require(game.ReplicatedStorage.Modules.Sounds):Play(v5, v1.SFXProperties);
                end);
            end;
        end;
    end, 
    DestroyedServer = function(v6) --[[ Line: 56 ]] --[[ Name: DestroyedServer ]]
        local l_SFX_0 = v6.SFX;
        if l_SFX_0 then
            l_SFX_0:Destroy();
        end;
    end
};