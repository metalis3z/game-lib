-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Unban Player", 
    LayoutOrder = -98, 
    Executable = true, 
    ResetOnExecution = true, 
    RequiredRank = "Moderator", 
    Parameters = {
        [1] = {
            Title = "Player Username", 
            Type = "Textbox", 
            DefaultValue = ""
        }, 
        [2] = {
            Title = "Unban Reason", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = "Joke Banned|Accidentally Banned|Falsely Banned|Appealed Successfully"
            }
        }
    }, 
    Executed = function(_, v1, v2, v3) --[[ Line: 24 ]] --[[ Name: Executed ]]
        local v4 = require(game.ReplicatedStorage.Modules.Network);
        local function _(v5, v6) --[[ Line: 26 ]] --[[ Name: sendClientMsg ]]
            -- upvalues: v4 (copy), v1 (copy)
            v4:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", v5, v6);
        end;
        local v8 = nil;
        pcall(function() --[[ Line: 32 ]]
            -- upvalues: v8 (ref), v2 (copy), v4 (copy), v1 (copy)
            local _, l_result_0 = pcall(function() --[[ Line: 33 ]]
                -- upvalues: v8 (ref), v2 (ref)
                v8 = game.Players:GetUserIdFromNameAsync(v2);
            end);
            if l_result_0 then
                local v11 = Color3.fromRGB(255, 120, 120);
                v4:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", "An error occurred while trying to get the player's username.\nThis is likely a fault on Roblox's end, so just try banning them again!", v11);
                return;
            else
                return;
            end;
        end);
        local v12 = v3 ~= "..." and v3 or "Unspecified";
        local v13 = {
            UserIds = {
                v8
            }, 
            ApplyToUniverse = true
        };
        game.Players:UnbanAsync(v13);
        local v14 = "[UNKNOWN]";
        pcall(function() --[[ Line: 53 ]]
            -- upvalues: v14 (ref), v8 (ref)
            v14 = game.Players:GetNameFromUserIdAsync(v8);
        end);
        local function v18(v15) --[[ Line: 56 ]] --[[ Name: getAvatarIcon ]]
            local l_status_1, l_result_1 = pcall(function() --[[ Line: 57 ]]
                -- upvalues: v15 (copy)
                return game.HttpService:JSONDecode(game.HttpService:GetAsync("https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds=" .. v15 .. "&size=150x150&format=Png"));
            end);
            if l_status_1 and l_result_1 and l_result_1.data and l_result_1.data[1] and l_result_1.data[1].imageUrl then
                return l_result_1.data[1].imageUrl;
            else
                return "https://t3.rbxcdn.com/9fc30fe577bf95e045c9a3d4abaca05d";
            end;
        end;
        local v19 = v18(v1.UserId);
        local v20 = v18(v8);
        local v21 = math.random(1, 50) == 1;
        local l_Value_0 = game.ServerStorage.WebhookLinks.Unbans.Value;
        local v23 = {
            content = "** **", 
            embeds = {
                {
                    title = "User Unbanned!", 
                    type = "rich", 
                    color = tonumber(6747998), 
                    thumbnail = {
                        url = v21 and "https://media.tenor.com/RO0EB0RxktMAAAAM/gorillaman.gif" or v20
                    }, 
                    author = {
                        name = "\226\156\133"
                    }, 
                    footer = {
                        icon_url = v21 and "https://media.tenor.com/RO0EB0RxktMAAAAM/gorillaman.gif" or v19, 
                        text = ("Unbanned by: %* | User ID: %*"):format(v21 and ("the walking gorilla (%*)"):format((tostring(v1))) or tostring(v1), (tostring(v1.UserId)))
                    }, 
                    fields = {
                        {
                            name = "Unbanned Player:", 
                            value = ("%* (User ID: %*)"):format(tostring(v14), (tostring(v8))), 
                            inline = false
                        }, 
                        {
                            name = "Unban Reason:", 
                            value = v21 and "dude what the hell is that" or ("*%**"):format((tostring(v12))), 
                            inline = true
                        }, 
                        {
                            name = "Join Server:", 
                            value = "[Server Link](https://www.roblox.com/games/start?launchData=%7B%22giftTarget%22%3A%22roblox%22%7D&placeId=" .. game.PlaceId .. "&jobId=" .. game.JobId .. ")", 
                            inline = true
                        }
                    }
                }
            }
        };
        local v24 = 0;
        local v25 = nil;
        local v26 = nil;
        while v24 < 3 and not v25 do
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 116 ]]
                -- upvalues: v23 (copy), l_Value_0 (copy)
                local v27 = game.HttpService:JSONEncode(v23);
                game.HttpService:PostAsync(l_Value_0, v27);
            end);
            v25 = l_status_2;
            v26 = l_result_2;
            task.wait(1);
            v24 = v24 + 1;
        end;
        local v30 = {
            "Also also!! Moderating can be stressful sometimes so be sure 2 take breaks!! <3", 
            "Be sure to take breaks whenever u need them!! Don't overwork urself <3", 
            "This means a lot 2 me because I can't moderate for the life of me, so thank u <3", 
            "You're doin great!! Be sure to keep ur hydration in check, brush ur teeth, & shower! <3", 
            "Keep up the amazing work dood,, genuinely thank you for helping make the game a safer (and more fun) place <3", 
            "Seriously thank you for taking the time out of ur day to do stuff like this.\nW/o u the game would suck a lot b/c of exploiters n stuff so im rlly thankful to have u here <3"
        };
        if v25 then
            v4:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", ("Successfully unbanned user & logged the unban!\n%*"):format(v30[math.random(1, #v30)]), nil);
        else
            v4:FireClientConnection(v1, "SendNotif", "REMOTE_EVENT", ("Successfully unbanned user, but an error occurred while logging it.\nInfo: \"%*\""):format((tostring(v26))), (Color3.fromRGB(255, 255, 120)));
        end;
    end
};