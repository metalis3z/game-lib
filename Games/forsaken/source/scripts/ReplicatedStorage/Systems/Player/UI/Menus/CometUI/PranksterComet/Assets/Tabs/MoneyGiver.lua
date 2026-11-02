-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Utility);
local l_MoneyGiver_0 = script.Parent.Parent.Parent.Main.Frames.MoneyGiver;
local l_TextButton_0 = l_MoneyGiver_0.TextButton;
l_TextButton_0.Text = "Money";
l_TextButton_0.BackgroundColor3 = v0.OnColor;
l_TextButton_0.MouseButton1Down:Connect(function() --[[ Line: 10 ]]
    -- upvalues: l_TextButton_0 (copy), v0 (copy)
    if l_TextButton_0.Text == "Money" then
        l_TextButton_0.Text = "Malice";
        l_TextButton_0.BackgroundColor3 = v0.OffColor;
        return;
    else
        l_TextButton_0.Text = "Money";
        l_TextButton_0.BackgroundColor3 = v0.OnColor;
        return;
    end;
end);
local v3 = {
    Data = {}
};
v3.Data.Segments = {
    "SelectPlayer", 
    "FireButton"
};
v3.Data.Description = "Give money or malice to a player.";
v3.Fire = function() --[[ Line: 26 ]]
    -- upvalues: v0 (copy), l_MoneyGiver_0 (copy), l_TextButton_0 (copy)
    local l_v0_PlayersFromSelection_0 = v0:GetPlayersFromSelection();
    local l_Text_0 = l_MoneyGiver_0.TextBox.Text;
    v0:Fire({
        Players = l_v0_PlayersFromSelection_0, 
        Amount = tonumber(l_Text_0), 
        Type = l_TextButton_0.Text == "Money" and "Money" or "KillerChance"
    });
end;
return v3;