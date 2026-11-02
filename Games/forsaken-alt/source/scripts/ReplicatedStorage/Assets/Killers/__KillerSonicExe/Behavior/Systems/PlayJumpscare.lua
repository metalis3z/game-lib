-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Type = "Client", 
    Start = function(_, _) --[[ Line: 5 ]] --[[ Name: Start ]]
        local v2 = require(game.ReplicatedStorage.Modules.Network);
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local _ = script.Parent.Parent.Instances;
        v2:SetConnection("ExeJumpscare", "UREMOTE_EVENT", function() --[[ Line: 12 ]]
            -- upvalues: l_LocalPlayer_0 (copy)
            local l_TemporaryUI_0 = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
            local v6 = l_TemporaryUI_0 and l_TemporaryUI_0:FindFirstChild("static");
            if v6 then
                v6.ImageTransparency = 0;
                game.TweenService:Create(v6, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end;
        end);
    end, 
    Destroy = function(_) --[[ Line: 23 ]] --[[ Name: Destroy ]]
        require(game.ReplicatedStorage.Modules.Network):RemoveConnection("ExeJumpscare");
    end
};