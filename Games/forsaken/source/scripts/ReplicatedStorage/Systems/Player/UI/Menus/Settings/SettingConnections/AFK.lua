-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Updated = function(v0, v1) --[[ Line: 3 ]] --[[ Name: Updated ]]
        if not v0.AFKTitle then
            v0.AFKTitle = script.AFKLabel:Clone();
            v0.AFKTitle.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI");
        end;
        v0.AFKTitle.Visible = v1;
    end
};