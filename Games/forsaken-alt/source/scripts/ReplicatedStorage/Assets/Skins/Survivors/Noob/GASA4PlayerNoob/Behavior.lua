-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 4 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            v1.Rig.Torso.NameGui.Title.Text = tostring(v1.Player and v1.Player.DisplayName);
        end;
    end
};