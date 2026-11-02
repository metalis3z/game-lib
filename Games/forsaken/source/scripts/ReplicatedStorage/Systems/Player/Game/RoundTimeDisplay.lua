-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local v2 = script.RoundTimer:Clone();
        local l_Main_0 = v2.Main;
        v2.Parent = l_LocalPlayer_0.PlayerGui;
        local l_RoundTimer_0 = game.ReplicatedStorage:WaitForChild("RoundTimer");
        local function v10() --[[ Line: 16 ]] --[[ Name: updateTime ]]
            -- upvalues: l_Main_0 (copy), l_RoundTimer_0 (copy)
            local l_Time_0 = l_Main_0.Time;
            local l_Title_0 = l_Main_0.Title;
            local l_Value_0 = l_RoundTimer_0.Value;
            local v8 = l_RoundTimer_0:GetAttribute("TimeLeft") or 0;
            local v9 = string.format("%i:%02i", v8 / 60, v8 % 60);
            l_Title_0.Text = l_Value_0 and l_Value_0 or "";
            l_Time_0.Text = v9;
        end;
        local l_Time_1 = l_Main_0.Time;
        local l_Title_1 = l_Main_0.Title;
        local l_Value_1 = l_RoundTimer_0.Value;
        local v14 = l_RoundTimer_0:GetAttribute("TimeLeft") or 0;
        local v15 = string.format("%i:%02i", v14 / 60, v14 % 60);
        l_Title_1.Text = l_Value_1 and l_Value_1 or "";
        l_Time_1.Text = v15;
        l_RoundTimer_0:GetPropertyChangedSignal("Value"):Connect(v10);
        l_RoundTimer_0:GetAttributeChangedSignal("TimeLeft"):Connect(v10);
        l_Time_1 = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
        l_Time_1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 35 ]]
            -- upvalues: v2 (copy), l_Time_1 (copy)
            v2.Enabled = l_Time_1.Enabled;
        end);
    end
};