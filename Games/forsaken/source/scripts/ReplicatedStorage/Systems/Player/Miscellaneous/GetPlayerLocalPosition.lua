-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        require(game.ReplicatedStorage.Modules.Network):SetConnection("GetLocalPosData", "REMOTE_FUNCTION", function() --[[ Line: 8 ]]
            local l_Character_0 = game.Players.LocalPlayer.Character;
            local v2 = l_Character_0 and l_Character_0.PrimaryPart;
            if v2 then
                local l_CFrame_0 = v2.CFrame;
                return (("%*/%*/%*/%*/%*/%*"):format(l_CFrame_0.Position.X, l_CFrame_0.Position.Y, l_CFrame_0.Position.Z, l_CFrame_0.LookVector.X, l_CFrame_0.LookVector.Y, l_CFrame_0.LookVector.Z));
            else
                return;
            end;
        end);
    end
};