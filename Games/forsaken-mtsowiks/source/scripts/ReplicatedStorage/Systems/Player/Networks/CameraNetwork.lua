-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        require(game.ReplicatedStorage.Modules.Network):SetConnection("SetCameraSubject", "REMOTE_EVENT", function(v2) --[[ Line: 10 ]]
            -- upvalues: l_LocalPlayer_0 (copy)
            if v2 then
                workspace.CurrentCamera.CameraSubject = v2;
                return;
            else
                if l_LocalPlayer_0.Character then
                    workspace.CurrentCamera.CameraSubject = l_LocalPlayer_0.Character:FindFirstChild("Humanoid");
                end;
                return;
            end;
        end);
    end
};