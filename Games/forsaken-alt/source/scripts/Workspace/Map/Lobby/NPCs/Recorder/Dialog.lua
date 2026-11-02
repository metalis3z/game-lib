-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Config = {
        FacePlayer = false
    }, 
    Interacted = function(v0) --[[ Line: 7 ]]
        v0:CreateDialog({
            Text = "Escape this realm and take to heart the things you've learned from every part."
        });
        v0:CreateDialog({
            Text = "In a club unknown, where secrets are sown, recite your tale in its depths alone."
        });
        game.Players.LocalPlayer:SetAttribute("TapeRecorder", true);
    end
};