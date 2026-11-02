-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ReplicatePrivateNPC, time of decompilation: Fri Nov 28 21:12:38 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v2 = require(l_ReplicatedStorage_0.Modules.Network);
local v3 = l_RunService_0:IsStudio();
return {
    Start = function(_) --[[ Line: 13 ]] --[[ Name: Start ]]
        -- upvalues: v2 (copy), v3 (copy)
        local l_Lobby_0 = workspace.Map:FindFirstChild("Lobby");
        if l_Lobby_0 then
            local v6 = v2:FireServerConnection("GetCustomNPCs", "REMOTE_FUNCTION") or {};
            for _, v8 in v6 do
                if v3 then
                    warn((("[%*]: Got custom NPC: %*, replicated to: %*"):format(script, v8, (l_Lobby_0.NPCs:GetFullName()))));
                end;
                v8.Parent = l_Lobby_0.NPCs;
            end;
        end;
    end
};