-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
v0.Debug = function(_, ...) --[[ Line: 14 ]] --[[ Name: Debug ]]
--	warn(...)
end;
v0.LoadModules = function(_, v7, v8) --[[ Line: 21 ]] --[[ Name: LoadModules ]]
    -- upvalues: v0 (copy)
    if v0[v8] then
        for v9, v10 in pairs(v0[v8]) do
            if v10.Destroy then
                v0:Debug((("cleaning up the %*/%* module..."):format(v8, v9)));
                v10:Destroy();
            end;
        end;
        table.clear(v0[v8]);
        local function v11(v12) --[[ Line: 35 ]] --[[ Name: loadModules ]]
            -- upvalues: v0 (ref), v11 (copy), v8 (copy)
            for _, v14 in pairs(v12:GetChildren()) do
                if not v14:GetAttribute("NoInitializing") then
                    if v14:IsA("Folder") then
                        v0:Debug((("loading modules in %*/%*..."):format(tostring(v14.Parent), (tostring(v14)))));
                        v11(v14);
                        v0:Debug((("finished loading modules in %*/%*!"):format(tostring(v14.Parent), (tostring(v14)))));
                    else
                        v0:Debug((("requiring %*/%*..."):format(tostring(v14.Parent), (tostring(v14)))));
                        local v15 = require(v14);
                        v0[v8][v14.Name] = v15;
                        v0:Debug((("%*/%* required!"):format(tostring(v14.Parent), (tostring(v14)))));
                    end;
                end;
            end;
        end;
        v11(v7);
        for v16, v17 in pairs(v0[v8]) do
            if v17.Init then
                v0:Debug((("initializing %*..."):format(v16)));
                local _, l_result_0 = pcall(v17.Init, v17);
                if l_result_0 then
                    warn((("there was an error while initializing the %* module!! info displayed below:\n%*"):format(v16, (debug.traceback(l_result_0)))));
                end;
                v0:Debug((("%* initialized!"):format(v16)));
            end;
        end;
        for v20, v21 in pairs(v0[v8]) do
            if v21.Start then
                v0:Debug((("starting %*..."):format(v20)));
                local _, l_result_1 = pcall(v21.Start, v21);
                if l_result_1 then
                    warn((("there was an error while starting the %* module!! info displayed below:\n%*"):format(v20, (debug.traceback(l_result_1)))));
                end;
                v0:Debug((("%* started!"):format(v20)));
            end;
        end;
        v0:Debug((("finished loading modules in %*"):format(v8)));
    end;
end;
v0.Initialize = function(_) --[[ Line: 79 ]] --[[ Name: Initialize ]]
    -- upvalues: v0 (copy), v2 (copy), v3 (copy)
    setmetatable({}, v0);
    if v2 then
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        v0.Player = l_LocalPlayer_0;
        v0.Character = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
    end;
    v0.Modules = {};
    v0.PlayerSystems = {};
    v0.CharacterSystems = {};
    v0.ServerSystems = {};
    local v26 = tick();
    v0:Debug((("began starting %* systems"):format(v3 and "server" or "client")));
    local l_Modules_0 = game.ReplicatedStorage:WaitForChild("Modules");
    local l_Systems_0 = game.ReplicatedStorage:WaitForChild("Systems");
    local l_Player_0 = l_Systems_0:WaitForChild("Player");
    local l_Character_0 = l_Systems_0:WaitForChild("Character");
    local v31 = v3 and game.ServerStorage.ServerSystems;
    v0:LoadModules(l_Modules_0, "Modules");
    if v3 then
        v0:LoadModules(v31, "ServerSystems");
    end;
    if v2 then
        v0:LoadModules(l_Player_0, "PlayerSystems");
		v0:LoadModules(l_Character_0, "CharacterSystems");
        v0.Player.CharacterAdded:Connect(function() --[[ Line: 122 ]]
            -- upvalues: v0 (ref), l_Character_0 (copy)
            local l_TemporaryUI_0 = v0.Player.PlayerGui:FindFirstChild("TemporaryUI");
            if l_TemporaryUI_0 then
                l_TemporaryUI_0:ClearAllChildren();
			end;
			--
            v0.Character = v0.Player.Character;
            v0:LoadModules(l_Character_0, "CharacterSystems");
        end);
    end;
    local v33 = tick();
    v0:Debug((("%* initialized after %* seconds!"):format(v3 and "server" or "client", v33 - v26)));
    v0.Loaded = true;
    if v2 then
        task.delay(5, function() --[[ Line: 140 ]]
            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("PlayerLoaded", "REMOTE_EVENT");
        end);
    end;
end;
return v0;