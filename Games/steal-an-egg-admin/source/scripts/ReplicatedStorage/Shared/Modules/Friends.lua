-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local v1 = {}

function v1.DidJoinFriend(v2) -- line 8 | captures: Players
    local v3 = {}
    local FollowUserId = v2.FollowUserId
    if FollowUserId ~= 0 then
        table.insert(v3, FollowUserId)
    end
    for v4, v5 in Players:GetPlayers() do
        if v5 ~= v2 and v5.UserId ~= FollowUserId then
            local pcall_2 = pcall
            local v6 = v5
            local v7, v8 = pcall_2(function() -- line 17 | captures: v2, v6
                return v2:IsFriendsWithAsync(v6.UserId)
            end)
            if v7 and v8 then
                local UserId = v5.UserId
                table.insert(v3, UserId)
            end
        end
    end
    if #v3 > 0 then
        return true, v3
    end
    return false, nil
end

return v1
