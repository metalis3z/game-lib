-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GroupService = game:GetService("GroupService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PlayerJoinedGroup = script.Parent.Parent:WaitForChild("Events"):WaitForChild("PlayerJoinedGroup");
local u1 = {
    PlayerJoinedGroup = PlayerJoinedGroup.Event,
    _mockIsJoined = nil
};

function u1.IsJoined() -- Line: 17
    -- upvalues: u1 (copy), LocalPlayer (copy)
    if u1._mockIsJoined ~= nil then
        return u1._mockIsJoined;
    end;

    local success, result = pcall(function() -- Line: 22
        -- upvalues: LocalPlayer (ref)
        return LocalPlayer:IsInGroup(585759509);
    end);

    if success == true then
        return result;
    end;

    warn("Failed to check group membership:", result);

    return false;
end;

function u1.PromptJoin() -- Line: 34
    -- upvalues: u1 (copy), PlayerJoinedGroup (copy), GroupService (copy), ReplicatedStorage (copy)
    if u1._mockIsJoined ~= nil then
        u1._mockIsJoined = true;
        PlayerJoinedGroup:Fire();

        return true, Enum.GroupMembershipStatus.Joined;
    end;

    local success, result = pcall(function() -- Line: 41
        -- upvalues: GroupService (ref)
        return GroupService:PromptJoinAsync(585759509);
    end);

    if success == false then
        warn("Failed to prompt group join:", result);

        return false;
    end;

    if result == Enum.GroupMembershipStatus.Joined then
        PlayerJoinedGroup:Fire();
        pcall(function() -- Line: 52
            -- upvalues: ReplicatedStorage (ref)
            ReplicatedStorage.Remotes.GroupJoinConfirmed:FireServer();
        end);
    end;

    return success, result;
end;

return u1;