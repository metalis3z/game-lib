-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_SelectPlayer_0 = script.Parent.Parent.Parent.Main.Segments.SelectPlayer;
local l_Parameter_0 = l_SelectPlayer_0.Parameter;
local l_Assets_0 = script.Parent.Parent.Parent.Assets;
local v4 = require(l_Assets_0.Utility);
local v5 = require(l_Assets_0.Autofill).new(l_Parameter_0, {
    "HeeHee"
});
local v9 = {
    All = function() --[[ Line: 13 ]]
        -- upvalues: v5 (copy), l_Parameter_0 (copy)
        v5:UpdateSelection(nil);
        l_Parameter_0.Text = "";
        l_Parameter_0.TextEditable = false;
        l_Parameter_0.PlaceholderText = "No parameter required";
    end, 
    Team = function() --[[ Line: 21 ]]
        -- upvalues: v5 (copy), l_Parameter_0 (copy)
        v5:UpdateSelection({
            "Survivors", 
            "Killers", 
            "Spectating"
        });
        l_Parameter_0.Text = "Survivors";
        l_Parameter_0.TextEditable = true;
        l_Parameter_0.PlaceholderText = "Enter team name";
    end, 
    Player = function() --[[ Line: 28 ]]
        -- upvalues: v5 (copy), l_Parameter_0 (copy)
        local v6 = {};
        for _, v8 in ipairs(game.Players:GetChildren()) do
            table.insert(v6, v8.Name);
        end;
        v5:UpdateSelection(v6);
        l_Parameter_0.Text = game.Players.LocalPlayer.Name;
        l_Parameter_0.TextEditable = true;
        l_Parameter_0.PlaceholderText = "Enter a player's username";
    end, 
    Random = function() --[[ Line: 39 ]]
        -- upvalues: v5 (copy), l_Parameter_0 (copy)
        v5:UpdateSelection(nil);
        l_Parameter_0.Text = "1";
        l_Parameter_0.TextEditable = true;
        l_Parameter_0.PlaceholderText = "Enter a number";
    end
};
v0.SetModeTo = function(_, v11) --[[ Line: 47 ]] --[[ Name: SetModeTo ]]
    -- upvalues: l_SelectPlayer_0 (copy), v4 (copy), v0 (copy), v9 (copy)
    for _, v13 in ipairs(l_SelectPlayer_0.GroupSelector:GetChildren()) do
        if v13:IsA("TextButton") then
            if v13.Name == v11 then
                v13.BackgroundColor3 = v4.OnColor;
                v0.Mode = v13.Name;
            else
                v13.BackgroundColor3 = v4.OffColor;
            end;
        end;
    end;
    v9[v11]();
end;
for _, v15 in ipairs(l_SelectPlayer_0.GroupSelector:GetChildren()) do
    if v15:IsA("TextButton") then
        v15.MouseButton1Down:Connect(function() --[[ Line: 64 ]]
            -- upvalues: v0 (copy), v15 (copy)
            v0:SetModeTo(v15.Name);
        end);
    end;
end;
v0:SetModeTo("Player");
return v0;