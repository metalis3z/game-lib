-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBHNob3cEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB1BsYXllcnMHcmVxdWlyZQdNb2R1bGVzDFdhaXRGb3JDaGlsZBNOb3RpZmljYXRpb25NYW5hZ2VyBkV2ZW50cxBTaG93Tm90aWZpY2F0aW9uBXByaW50MFtOb3RpZmljYXRpb25Db250cm9sbGVyXSBMaXN0ZW5pbmcgZm9yIGV2ZW50cy4uLg1PbkNsaWVudEV2ZW50B0Nvbm5lY3QAAgUCAQAABwQAAAUCAwMH+wIAAE0CArgAAAAAUgMAAFIEAQCfAgMBggABAAEDAQARAAEYAAAAAAAAARMAAAAACAAAAQIALKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQG8FBwC8AwDTCAAAAJ8DAwJvBQkAvAMD0wgAAACfAwMAnwIAAm8FCgC8AwDTCAAAAJ8DAwJvBgsAvAQD0wgAAACfBAMCpAUNAAAAwEBvBg4AnwUCAU0FBIwPAAAAwAcQABIAAgC8BQXHEQAAAJ8FAwGCAAEAEgMCBAAAAEADAwMEAwUDBgQAAFBAAwcDCAMJAwoDCwMMBAAAwEADDQMOBgADDwEAAQABGAADAAAAAAABAAAAAAADAAAAAAAAAAAAAAMAAAABAAAAAgAAAAMAAAAAAAADAQAAAAABv4P1dY46gTLqbtPIZIbutc+b4gGNR590

-- decompilation:
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players");
local l_NotificationManager_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("NotificationManager"));
local l_ShowNotification_0 = l_ReplicatedStorage_0:WaitForChild("Events"):WaitForChild("ShowNotification");
print("[NotificationController] Listening for events...");
l_ShowNotification_0.OnClientEvent:Connect(function(v4, v5) --[[ Line: 17 ]]
    -- upvalues: l_NotificationManager_0 (copy)
    l_NotificationManager_0.show(v4, v5);
end);
