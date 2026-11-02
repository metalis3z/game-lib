local l_MessagingService_0 = game:GetService("MessagingService");
local l_TeleportService_0 = game:GetService("TeleportService");
local v2 = require(game.ReplicatedStorage.Modules.Network);
local _ = {};
local v14 = {
    Title = "Follow Player", 
    LayoutOrder = -7, 
	Executable = true, 
	ResetOnExecution = true, 
	AllowedInVIP = false,
	RequiredRank = "Moderator",
    Parameters = {
        [1] = {
            Title = "Player Username", 
            Type = "Textbox", 
            DefaultValue = ""
        }
    }, 
    Executed = function(_, v5, v6) --[[ Line: 26 ]] --[[ Name: Executed ]]
        -- upvalues: v2 (copy), l_TeleportService_0 (copy), l_MessagingService_0 (copy)
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 28 ]]
            -- upvalues: v6 (copy)
            return game.Players:GetUserIdFromNameAsync(v6);
        end);
        if not l_status_0 then
            v2:FireClientConnection(v5, "SendNotif", "REMOTE_EVENT", ("user does not exist or is terminated (%*)"):format(l_result_0), Color3.new(1, 0.5, 0.5));
            return;
        else
            local v9, v10, _, _, v13 = pcall(function() --[[ Line: 37 ]]
                -- upvalues: l_TeleportService_0 (ref), l_result_0 (copy)
                return l_TeleportService_0:GetPlayerPlaceInstanceAsync(l_result_0);
            end);
            if not v9 then
                v2:FireClientConnection(v5, "SendNotif", "REMOTE_EVENT", ("this player is not ingame (%*)"):format(v10), Color3.new(1, 0.5, 0.5));
                return;
            elseif not v13 then
                v2:FireClientConnection(v5, "SendNotif", "REMOTE_EVENT", "this player is not ingame", Color3.new(1, 0.5, 0.5));
                return;
            else
                v2:FireClientConnection(v5, "SendNotif", "REMOTE_EVENT", "player found! teleporting...", Color3.new(0.5, 1, 0.5));
                l_MessagingService_0:PublishAsync("PlayerFinder", {
                    JobId = v13, 
                    Player = v6
                });
                wait(1.5);
                l_TeleportService_0:TeleportToPlaceInstance(game.PlaceId, tostring(v13), v5);
                return;
            end;
        end;
    end
};
if game["Run Service"]:IsServer() then
    l_MessagingService_0:SubscribeAsync("PlayerFinder", function(v15) --[[ Line: 63 ]]
        local l_Data_0 = v15.Data;
        local v17 = l_Data_0 and l_Data_0.JobId;
        local v18 = l_Data_0 and l_Data_0.Player;
        if game.JobId == v17 and #game.Players:GetPlayers() >= game.Players.MaxPlayers then
            for _, v20 in ipairs(game.Players:GetPlayers()) do
                if v20.Name ~= v18 then
                    local v21 = 0;
                    pcall(function() --[[ Line: 73 ]]
						-- upvalues: v21 (ref), v20 (copy)
						v21 = v20:GetAttribute("Rank") or 0
                    end);
                    if v21 > 15 then
                        --[[ close >= 9 ]]
                    else
                        v20:Kick("Server space required. Sorry.");
                        return;
                    end;
                end;
            end;
        end;
    end);
end;
return v14;