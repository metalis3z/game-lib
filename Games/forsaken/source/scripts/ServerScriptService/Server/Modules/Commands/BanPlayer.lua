-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Ban Player", 
    LayoutOrder = 8, 
    Executable = true, 
	ResetOnExecution = true, 
	AllowedInVIP = false,
	RequiredRank = "Moderator",
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
            Title = "Player Username (Optional)", 
            Type = "Textbox", 
            DefaultValue = ""
        }, 
        [3] = {
            Title = "Ban Reason", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = "Inappropriate Avatar|Exploiting|Glitch Abuse|Teaming|Toxicity (Minor)|Toxicity (Excessive)|Other (use ban duration!)"
            }
        }, 
        [4] = {
            Title = "Ban Duration (Optional)", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = "1 Hour|1 Day|1 Week|1 Month|6 Months|FOREVER"
            }
        }, 
        [5] = {
            Title = "Evidence (Separate links with spaces!)", 
            Type = "Textbox", 
            DefaultValue = ""
        }
    }, 
    Executed = function(_, v1, v2, v3, v4, v5, v6) --[[ Line: 41 ]] --[[ Name: Executed ]]
        local v7 = require(game.ReplicatedStorage.Modules.Network);
        local function _(v8, v9) --[[ Line: 43 ]] --[[ Name: sendClientMsg ]]
            -- upvalues: v7 (copy), v1 (copy)
            v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", v8, v9);
        end;
        local v11 = {
            ["1 Hour"] = 3600, 
            ["1 Day"] = 86400, 
            ["1 Week"] = 604800, 
            ["1 Month"] = 2592000, 
            ["6 Months"] = 15552000, 
            FOREVER = 13245120000
        };
        local v12 = {
            ["Inappropriate Avatar"] = v11["1 Day"], 
            Exploiting = v11.FOREVER, 
            ["Glitch Abuse"] = v11["1 Week"], 
            ["Toxicity (Minor)"] = v11["1 Day"], 
            ["Toxicity (Excessive)"] = v11["1 Week"], 
            Teaming = v11["1 Week"]
        };
        local v13 = v11[v5] or v12[v4];
        local v14 = v4 ~= "..." and v4 or "Unspecified";
        if v14 == "Other (use ban duration!)" then
            v14 = "Other";
        end;
        local v15 = nil;
        local l_FirstChild_0 = game.Players:FindFirstChild((tostring(v2)));
        if l_FirstChild_0 then
            v15 = l_FirstChild_0.UserId;
        end;
        if v3 and v2 ~= "" then
            local _, l_result_0 = pcall(function() --[[ Line: 83 ]]
                -- upvalues: v15 (ref), v3 (copy)
                v15 = game.Players:GetUserIdFromNameAsync(v3);
            end);
            if l_result_0 then
                v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", "An error occurred while trying to get the player's username.\nThis is likely a fault on Roblox's end, so just try banning them again!", (Color3.fromRGB(255, 120, 120)));
                return;
            end;
        end;
        if not v13 then
            v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", "Must specify ban duration!", (Color3.fromRGB(255, 120, 120)));
            return;
        elseif not v15 then
            v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", "Must specify user properly!", (Color3.fromRGB(255, 120, 120)));
            return;
        else
            local v19 = false;
            pcall(function() --[[ Line: 95 ]]
                -- upvalues: v15 (ref), v19 (ref)
                local l_GroupsAsync_0 = game.GroupService:GetGroupsAsync(v15);
                for _, v22 in pairs(l_GroupsAsync_0) do
                    if v22.Id == 33548380 and v22.Rank >= 100 then
                        v19 = true;
                    end;
                end;
            end);
            if v19 then
                warn("dont try to ban moderators, kid!");
                v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", "Dude are u serious", (Color3.fromRGB(255, 120, 120)));
                return;
            else
                local v23 = {
                    UserIds = {
                        v15
                    }, 
                    Duration = v13, 
                    DisplayReason = ("You've been banned for %*."):format(tostring(v14):find("Other") and "an unknown reason" or tostring(v14)), 
                    PrivateReason = tostring(v14)
                };
                local _, l_result_1 = pcall(function() --[[ Line: 120 ]]
                    -- upvalues: v23 (copy)
                    game.Players:BanAsync(v23);
                end);
                if l_result_1 then
                    v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", ("An error occurred while attempting to ban user.\nInfo: \"%*\""):format(l_result_1), (Color3.fromRGB(255, 120, 120)));
                    return;
                else
                    local v26 = "[UNKNOWN]";
                    pcall(function() --[[ Line: 131 ]]
                        -- upvalues: v26 (ref), v15 (ref)
                        v26 = game.Players:GetNameFromUserIdAsync(v15);
                    end);
                    local function v33(v27) --[[ Line: 134 ]] --[[ Name: formatTime ]]
                        local v28 = math.floor(v27 / 31536000);
                        v27 = v27 % 31536000;
                        local v29 = math.floor(v27 / 2592000);
                        v27 = v27 % 2592000;
                        local v30 = math.floor(v27 / 604800);
                        v27 = v27 % 604800;
                        local v31 = math.floor(v27 / 86400);
                        v27 = v27 % 86400;
                        local v32 = {};
                        if v28 > 0 then
                            table.insert(v32, v28 .. " year" .. (v28 > 1 and "s" or ""));
                        end;
                        if v29 > 0 then
                            table.insert(v32, v29 .. " month" .. (v29 > 1 and "s" or ""));
                        end;
                        if v30 > 0 then
                            table.insert(v32, v30 .. " week" .. (v30 > 1 and "s" or ""));
                        end;
                        if v31 > 0 then
                            table.insert(v32, v31 .. " day" .. (v31 > 1 and "s" or ""));
                        end;
                        if #v32 == 0 then
                            return "Less than a day";
                        else
                            return (("%*%*"):format(table.concat(v32, ", "), v28 >= 10 and " (FOREVER)" or ""));
                        end;
                    end;
                    local function v37(v34) --[[ Line: 162 ]] --[[ Name: getAvatarIcon ]]
                        local l_status_2, l_result_2 = pcall(function() --[[ Line: 163 ]]
                            -- upvalues: v34 (copy)
                            return game.HttpService:JSONDecode(game.HttpService:GetAsync("https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds=" .. v34 .. "&size=150x150&format=Png"));
                        end);
                        if l_status_2 and l_result_2 and l_result_2.data and l_result_2.data[1] and l_result_2.data[1].imageUrl then
                            return l_result_2.data[1].imageUrl;
                        else
                            return "https://t3.rbxcdn.com/9fc30fe577bf95e045c9a3d4abaca05d";
                        end;
                    end;
                    local v38 = v37(v1.UserId);
                    local v39 = v37(v15);
                    local l_Value_0 = game.ServerStorage.WebhookLinks.Bans.Value;
                    local v41 = {
                        content = "** **", 
                        embeds = {
                            {
                                title = "User Banned!", 
                                url = ("https://www.roblox.com/users/%*/profile"):format(v15), 
                                type = "rich", 
                                color = tonumber(15220543), 
                                thumbnail = {
                                    url = v39
                                }, 
                                author = {
                                    name = "\240\159\154\171"
                                }, 
                                footer = {
                                    icon_url = v38, 
                                    text = ("Banned by: %* | User ID: %*"):format(tostring(v1), (tostring(v1.UserId)))
                                }, 
                                fields = {
                                    {
                                        name = "Banned Player:", 
                                        value = ("%* (User ID: %*)"):format(tostring(v26), (tostring(v15))), 
                                        inline = false
                                    }, 
                                    {
                                        name = "Ban Reason:", 
                                        value = ("*%**"):format((tostring(v14))), 
                                        inline = true
                                    }, 
                                    {
                                        name = "Ban Duration:", 
                                        value = ("*%**"):format((tostring((v33(v13))))), 
                                        inline = true
                                    }, 
                                    {
                                        name = "Evidence:", 
                                        value = ("*%**"):format(v6 and v6 ~= "" and string.gsub(v6, " ", "\n") or "No evidence attached"), 
                                        inline = false
                                    }, 
                                    {
                                        name = "Join Server:", 
                                        value = "[Server Link](https://www.roblox.com/games/start?launchData=%7B%22giftTarget%22%3A%22roblox%22%7D&placeId=" .. game.PlaceId .. "&jobId=" .. game.JobId .. ")", 
                                        inline = false
                                    }
                                }
                            }
                        }
                    };
                    local v42 = 0;
                    local v43 = nil;
                    local v44 = nil;
                    while v42 < 3 and not v43 do
                        local l_status_3, l_result_3 = pcall(function() --[[ Line: 229 ]]
                            -- upvalues: v41 (copy), l_Value_0 (copy)
                            local v45 = game.HttpService:JSONEncode(v41);
                            game.HttpService:PostAsync(l_Value_0, v45);
                        end);
                        v43 = l_status_3;
                        v44 = l_result_3;
                        task.wait(1);
                        v42 = v42 + 1;
                    end;
                    local v48 = {
                        "Also also!! Moderating can be stressful sometimes so be sure 2 take breaks!! <3", 
                        "Be sure to take breaks whenever u need them!! Don't overwork urself <3", 
                        "This means a lot 2 me because I can't moderate for the life of me, so thank u <3", 
                        "You're doin great!! Be sure to keep ur hydration in check, brush ur teeth, & shower! <3", 
                        "Keep up the amazing work dood,, genuinely thank you for helping make the game a safer (and more fun) place <3", 
                        "Seriously thank you for taking the time out of ur day to do stuff like this.\nW/o u the game would suck a lot b/c of exploiters n stuff so im rlly thankful to have u here <3"
                    };
                    if v43 then
                        v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", ("Successfully banned user & logged the ban!\n%*"):format(v48[math.random(1, #v48)]), nil);
                    else
                        v7:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", ("Successfully banned user, but an error occurred while logging it.\nInfo: \"%*\""):format((tostring(v44))), (Color3.fromRGB(255, 255, 120)));
                    end;
                    return;
                end;
            end;
        end;
    end
};