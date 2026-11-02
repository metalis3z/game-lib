-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Give Player Money", 
    LayoutOrder = 21, 
    Executable = true, 
    RequiredRank = "HeadModerator", 
    Parameters = {
        [1] = {
            Title = "Chosen Player", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                AllPlayersOptionDisabled = true
            }
        }, 
        [2] = {
            Title = "Amount Of Money", 
            Type = "Number", 
            DefaultValue = 0, 
            Metadata = {
                MinValue = -25000, 
                MaxValue = 25000, 
                Step = 1000
            }
        }
    }, 
    Executed = function(_, _, v2, v3) --[[ Line: 24 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "string" then
            return;
        elseif typeof(v3) ~= "number" then
            return;
        else
            local l_FirstChild_0 = game.Players:FindFirstChild(v2);
            if l_FirstChild_0 then
                local l_FirstChild_1 = l_FirstChild_0.PlayerData:FindFirstChild("Money", true);
                local l_FirstChild_2 = l_FirstChild_0.PlayerData:FindFirstChild("NetWorth", true);
                if l_FirstChild_1 and l_FirstChild_2 then
                    if v3 > 0 then
                        l_FirstChild_1.Value = l_FirstChild_1.Value + v3;
                        l_FirstChild_2.Value = l_FirstChild_2.Value + v3;
                        return;
                    else
                        l_FirstChild_1.Value = math.clamp(l_FirstChild_1.Value + v3, 0, 999999);
                    end;
                end;
            end;
            return;
        end;
    end
};