-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Give Player Money", 
    LayoutOrder = 21, 
    Executable = true, 
	AllowedInVIP = false,
	RequiredRank = "HeadModerator",
    Parameters = {
        [1] = {
            Title = "Chosen Player", 
            Type = "String", 
            DefaultValue = "...", 
        }, 
        [2] = {
            Title = "Amount Of Money", 
			Type = "Textbox",
			DefaultValue = "0"
        }
    }, 
    Executed = function(_, _, v2, v3) --[[ Line: 24 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "string" then
            return;
        elseif typeof(v3) ~= "string" then
            return;
		elseif tonumber(v3) == nil then
			return
		else
			v3 = tonumber(v3)
			local players = {
				v2
			}
			if v2 == "All" then
				players = {}
				for i, v in ipairs(game.Players:GetPlayers()) do
					table.insert(players, v)
				end
			end
			for i, v in ipairs(players) do
				local l_FirstChild_0 = typeof(v) == "Instance" and v:IsA("Player") and v or game.Players:FindFirstChild(v)
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
			end
            return;
        end;
    end
};