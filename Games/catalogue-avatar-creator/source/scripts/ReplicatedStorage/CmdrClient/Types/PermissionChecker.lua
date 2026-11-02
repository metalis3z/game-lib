-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = nil;
local u2 = nil;

if RunService:IsServer() then
    u1 = game:GetService("ServerScriptService"):WaitForChild("Utilities").DataHandler.Action;
else
    u2 = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GetFlag");
end;

return function(p3) -- Line: 13
    -- upvalues: RunService (copy), u1 (ref), u2 (ref)
    p3:RegisterHook("BeforeRun", function(p4) -- Line: 14
        -- upvalues: RunService (ref), u1 (ref), u2 (ref)
        if p4.Group == "UserAlias" then
            return;
        end;

        local v5 = "Is" .. p4.Group;
        local Executor = p4.Executor;

        if RunService:IsServer() then
            if u1:Invoke("GetFlag", Executor, v5) ~= true then
                return "You do not have permission to run this command";
            end;
        else
            local v6, v7 = u2:InvokeServer(v5);

            if not v6 then
                return "Error checking permissions";
            end;

            if v7 ~= true then
                return "You do not have permission to run this command";
            end;
        end;
    end);
end;