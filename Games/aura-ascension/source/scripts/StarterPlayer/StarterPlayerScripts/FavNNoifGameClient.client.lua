-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_AvatarEditorService_0 = game:GetService("AvatarEditorService");
local l_ExperienceNotificationService_0 = game:GetService("ExperienceNotificationService");
local l_Remotes_0 = l_ReplicatedStorage_0:WaitForChild("Remotes");
local l_Functions_0 = l_Remotes_0:WaitForChild("Functions");
local l_Events_0 = l_Remotes_0:WaitForChild("Events");
local l_GetShownFavNoti_0 = l_Functions_0:WaitForChild("GetShownFavNoti");
local l_SetShownFavNoti_0 = l_Events_0:WaitForChild("SetShownFavNoti");
local l_GetShownNotifNoti_0 = l_Functions_0:WaitForChild("GetShownNotifNoti");
local l_SetShownNotifNoti_0 = l_Events_0:WaitForChild("SetShownNotifNoti");
local function _(v10) --[[ Line: 18 ]] --[[ Name: safeInvoke ]]
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 19 ]]
        -- upvalues: v10 (copy)
        return v10:InvokeServer();
    end);
    if l_status_0 then
        return l_result_0 == true;
    else
        return false;
    end;
end;
local function _() --[[ Line: 28 ]] --[[ Name: canPromptOptIn ]]
    -- upvalues: l_ExperienceNotificationService_0 (copy)
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 29 ]]
        -- upvalues: l_ExperienceNotificationService_0 (ref)
        return l_ExperienceNotificationService_0:CanPromptOptInAsync();
    end);
    return l_status_1 and l_result_1 == true;
end;
task.wait(60);
local l_status_2, l_result_2 = pcall(function() --[[ Line: 19 ]]
    -- upvalues: l_GetShownFavNoti_0 (copy)
    return l_GetShownFavNoti_0:InvokeServer();
end);
if not if l_status_2 then l_result_2 == true else false then
    pcall(function() --[[ Line: 39 ]]
        -- upvalues: l_AvatarEditorService_0 (copy)
        l_AvatarEditorService_0:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true);
    end);
    l_SetShownFavNoti_0:FireServer();
end;
task.wait(60);
local v19;
l_result_2, v19 = pcall(function() --[[ Line: 19 ]]
    -- upvalues: l_GetShownNotifNoti_0 (copy)
    return l_GetShownNotifNoti_0:InvokeServer();
end);
if if l_result_2 then v19 == true else false then
    return;
else
    local v20;
    v19, v20 = pcall(function() --[[ Line: 29 ]]
        -- upvalues: l_ExperienceNotificationService_0 (copy)
        return l_ExperienceNotificationService_0:CanPromptOptInAsync();
    end);
    if v19 and v20 == true then
        pcall(function() --[[ Line: 58 ]]
            -- upvalues: l_ExperienceNotificationService_0 (copy)
            l_ExperienceNotificationService_0:PromptOptIn();
        end);
        l_SetShownNotifNoti_0:FireServer();
        return;
    else
        l_SetShownNotifNoti_0:FireServer();
        return;
    end;
end;