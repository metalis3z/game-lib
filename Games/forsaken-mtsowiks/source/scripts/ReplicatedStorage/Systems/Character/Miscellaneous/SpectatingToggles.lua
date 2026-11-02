-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_Character_0 = game.Players.LocalPlayer.Character;
        local function v2() --[[ Line: 10 ]] --[[ Name: toggleSpectating ]]
            -- upvalues: l_Character_0 (copy)
            if l_Character_0 and l_Character_0.Parent ~= workspace.Players.Spectating then
                require(game.ReplicatedStorage.Modules.Spectating):Toggle(false);
            end;
        end;
        if l_Character_0 and l_Character_0.Parent ~= workspace.Players.Spectating then
            require(game.ReplicatedStorage.Modules.Spectating):Toggle(false);
        end;
        l_Character_0:GetPropertyChangedSignal("Parent"):Connect(v2);
    end
};