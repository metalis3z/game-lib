-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 3 ]] --[[ Name: Start ]]
        task.spawn(function() --[[ Line: 5 ]]
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local l_VersionInfo_0 = game.ReplicatedStorage:WaitForChild("VersionInfo");
            local v3 = script.Version:Clone();
            v3.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
            v3.Text = ("Version: %* %*"):format(l_VersionInfo_0.PlaceVersion.Value, l_VersionInfo_0.IsOutdated.Value and "(Outdated)" or "(Latest)");
            l_VersionInfo_0.IsOutdated:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 13 ]]
                -- upvalues: v3 (copy), l_VersionInfo_0 (copy)
                v3.Text = ("Version: %* %*"):format(l_VersionInfo_0.PlaceVersion.Value, l_VersionInfo_0.IsOutdated.Value and "(Outdated)" or "(Latest)");
            end);
            local l_FirstChild_0 = l_LocalPlayer_0.PlayerData:FindFirstChild("DebugMode", true);
            v3.Visible = l_FirstChild_0.Value;
            l_FirstChild_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 19 ]]
                -- upvalues: v3 (copy), l_FirstChild_0 (copy)
                v3.Visible = l_FirstChild_0.Value;
            end);
        end);
    end
};