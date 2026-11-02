-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v3 = {};
local v4 = 0;
local function _(v5, v6) --[[ Line: 13 ]] --[[ Name: LogError ]]
    -- upvalues: v3 (copy)
    v3[v5] = v6;
end;
local function v13(v8) --[[ Line: 17 ]] --[[ Name: RequireAndInitModule ]]
    -- upvalues: v3 (copy), v4 (ref)
    local l_status_0, l_result_0 = pcall(require, v8);
    if not l_status_0 then
        v3[v8] = l_result_0;
        return;
    else
        v4 = v4 + 1;
        if type(l_result_0) == "table" and type(l_result_0.Init) == "function" then
            local l_status_1, l_result_1 = pcall(l_result_0.Init, l_result_0);
            if not l_status_1 then
                v3[v8] = l_result_1;
            end;
        end;
        return;
    end;
end;
local function v17(v14) --[[ Line: 37 ]] --[[ Name: LoadContainer ]]
    -- upvalues: v13 (copy)
    if not v14 or not v14:IsA("Folder") then
        return;
    else
        for _, v16 in ipairs(v14:GetChildren()) do
            if not v16:FindFirstChild("DISABLED") and v16:IsA("ModuleScript") then
                v13(v16);
            end;
        end;
        return;
    end;
end;
local v18 = os.clock();
local l_Parent_0 = script.Parent;
v17(l_Parent_0:FindFirstChild("Modules"));
local l_Controllers_0 = l_Parent_0:FindFirstChild("Controllers");
if l_Controllers_0 and l_Controllers_0:IsA("Folder") then
    l_Knit_0.AddControllers(l_Controllers_0);
end;
l_Knit_0.Start():andThen(function() --[[ Line: 65 ]]
    -- upvalues: v18 (copy), v3 (copy), v4 (ref)
    local v21 = os.clock() - v18;
    if next(v3) == nil then
        print((("[ClientBootStrap] Client successfully loaded %* modules in %*s"):format(v4, v21)));
        print("[ClientBootStrap] Knit started successfully");
        return;
    else
        local v22 = "";
        for v23, v24 in pairs(v3) do
            v22 = v22 .. ("[Module=%*] - %*\n"):format(v23:GetFullName(), (tostring(v24)));
        end;
        warn((("[ClientBootStrap] Client partially loaded %* modules in %*s\nErrors:\n%*"):format(v4, v21, v22)));
        print("[ClientBootStrap] Knit started successfully");
        return;
    end;
end):catch(function(v25) --[[ Line: 80 ]]
    -- upvalues: v18 (copy)
    local v26 = os.clock() - v18;
    warn((("[ClientBootStrap] Knit failed to start after %*s: %*"):format(v26, (tostring(v25)))));
end);