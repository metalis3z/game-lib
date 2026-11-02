-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Updated = function(_, v1) --[[ Line: 3 ]] --[[ Name: Updated ]]
        local l_Character_0 = game.Players.LocalPlayer.Character;
        local v3 = l_Character_0 and l_Character_0:FindFirstChild("FOVMultipliers");
        local v4 = v3 and v3:FindFirstChild("FOVSetting");
        if v4 then
            game.TweenService:Create(v4, TweenInfo.new(0.125), {
                Value = v1 / 70
            }):Play();
        end;
    end
};