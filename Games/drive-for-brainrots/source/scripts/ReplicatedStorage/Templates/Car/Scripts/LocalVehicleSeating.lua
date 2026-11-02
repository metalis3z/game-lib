-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZCEV4aXRTZWF0D09uRXhpdEZ1bmN0aW9ucwV0YWJsZQZpbnNlcnQPT25TZWF0RXhpdEV2ZW50BmlwYWlycxtEaXNjb25uZWN0RnJvbVNlYXRFeGl0RXZlbnQFcGFpcnMLTG9jYWxQbGF5ZXIJQ2hhcmFjdGVyCEh1bWFub2lkFUZpbmRGaXJzdENoaWxkT2ZDbGFzcwRFbnVtEUh1bWFub2lkU3RhdGVUeXBlCUdldHRpbmdVcAtDaGFuZ2VTdGF0ZQRnYW1lB1BsYXllcnMKR2V0U2VydmljZQZzY3JpcHQGUGFyZW50B1JlbW90ZXMMV2FpdEZvckNoaWxkDU9uQ2xpZW50RXZlbnQHQ29ubmVjdAAFAAAAAAAAAYIAAQAAAAkBARgADAAAAAAEAQEAAAAK+wIAAE0CArAAAAAAnjQCBAAAAABSAwAApAEDAAAIEICfAQMBggABAAQDAgMDAwQEAAgQgAAOBQEYAAAAAAAAAAAAAQ8AAAAACgEBAAAAGP8BAAAAAAAApAIBAAAAAED7AwAATQMDsAIAAACfAgIEUQIJAPEGCAAAAAAAnjQBBQYAAABSCAEAUgkGAKQHBQAAEDCAnwcDAW4C9v8CAACA+wIAADABArACAAAAggABAAYDBgQAAABAAwIDAwMEBAAQMIAAEgcBGAAAAQAAAAAAAAEAAQAAAAAAAP4ABQAAARMAAAAACAECAAAAIKQBAQAAAABA+wIAAE0CArACAAAAnwECBBcBAwBSBgUAxgcAAJ8GAgFuAfz/AgAAAA4AEgD7AQEATQEBMQMAAABNAgFpBAAAAA4CBgBNAgFpBAAAAG8EBQC8AgK4BgAAAJ8CAwIOAgUApAUKAAkgcMC8AwIhCwAAAJ8DAwGCAAEADAMIBAAAAEADAgMJAwoDCwMMAw0DDgMPBAkgcMADEAAdAAEYAAAAAAAAAAEAAP8ABAEAAAEAAAAAAAAAAAEBAAAAAAMeAAAAAAcAAAECAC2jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEDAAAAAAD/AgAAAAAAADACAbAEAAAApAIGAAAAUEBNAgIkBwAAAE0CAiQHAAAAbwUIALwDAtMJAAAAnwMDAsAECgAwBAGoCwAAAMAEDAASAAEAMAQBnQ0AAADABA4AEgABADAEAQIPAAAATQQDqAsAAABNBASMEAAAAMAGEQASAAEAEgAAALwEBMcSAAAAnwQDAYIBAgATAxEEAAAAQAMSAxMDAgMUBAAAUEADFQMWAxcGAAMBBgEDBQYCAwcDGAYDAxkEAAECAwEAARgAAAAAAAAAAgABAAAAAgAAAAAAAQAAAAIAAAUAAAAEAAAACwAAAAAAAAAAAA4BAAAAAAQHFnXtTAjEMUuWs6RathWZdw5imTXSH+w=

-- decompilation:
local l_Players_0 = game:GetService("Players");
local v1 = {
    OnExitFunctions = {}
};
local l_Remotes_0 = script.Parent.Parent:WaitForChild("Remotes");
v1.ExitSeat = function() --[[ Line: 9 ]] --[[ Name: ExitSeat ]]

end;
v1.OnSeatExitEvent = function(v3) --[[ Line: 14 ]] --[[ Name: OnSeatExitEvent ]]
    -- upvalues: v1 (copy)
    table.insert(v1.OnExitFunctions, v3);
end;
v1.DisconnectFromSeatExitEvent = function(v4) --[[ Line: 18 ]] --[[ Name: DisconnectFromSeatExitEvent ]]
    -- upvalues: v1 (copy)
    local v5 = {};
    for _, v7 in ipairs(v1.OnExitFunctions) do
        if v7 ~= v4 then
            table.insert(v5, v7);
        end;
    end;
    v1.OnExitFunctions = v5;
end;
l_Remotes_0.ExitSeat.OnClientEvent:Connect(function(v8) --[[ Line: 29 ]]
    -- upvalues: v1 (copy), l_Players_0 (copy)
    for _, v10 in pairs(v1.OnExitFunctions) do
        v10(nil);
    end;
    if v8 then
        local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
        local v12 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
        if v12 then
            v12:ChangeState(Enum.HumanoidStateType.GettingUp);
        end;
    end;
end);
return v1;
