-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAdWRVJTSU9ODWdldEFwcFZlcnNpb24QZ2V0TGF0ZXN0VmVyc2lvbgppc1VwVG9EYXRlCElzU3R1ZGlvBXByaW50M/CfjY0gUnVubmluZyBUb3BiYXJQbHVzICUqIGJ5IEBGb3JldmVySEQgJiBIRCBBZG1pbgZmb3JtYXQEd2Fybl9BIG5ldyB2ZXJzaW9uIG9mIFRvcGJhclBsdXMgKCUqKSBpcyBhdmFpbGFibGU6IGh0dHBzOi8vZGV2Zm9ydW0ucm9ibG94LmNvbS90L3RvcGJhcnBsdXMvMTAxNzQ4NQR0YXNrBWRlZmVyAAIKAAAAAAAxpAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQICSwkAAACfAQICTQIBlwoAAACfAgECTQMBMwsAAACfAwECTQUBSgwAAACfBQECVgQFALwFAAoNAAAAnwUCAisFCQCkBQ8AAADgQG8HEABSCQIAvAcHjREAAACfBwMCUgYHAJ8FAgEOBAkApAUTAAAAIEFvBxQAUgkDALwHB40RAAAAnwcDAlIGBwCfBQIBggABABUDAQQAAABAAwIDAwMEBAAAQEADBQQAAGBAAwYDBwMIAwkDCgMLAwwEAADgQAMNAw4DDwQAACBBAxAAFQABGAAAAAAAAAEAAAAAAAAAAAEAAAEAAAEAAAABAAAAAQAAAAAAAAAAAgEAAAAAAAAAAAIWAAAAAAIAAAECAAijAAAApAACAAAEAIDAAQMAnwACAf8AAAAAAAAAggACAAQDEQMSBAAEAIAGAAEAAQABGAAUAAAADgAAAQAAAAABhlxf+BJtPitZgmJ2FXPKC/ZESIy0mDX5

-- decompilation:
task.defer(function() --[[ Line: 21 ]]
    local l_RunService_0 = game:GetService("RunService");
    local v1 = require(script.Parent.VERSION);
    local v2 = v1.getAppVersion();
    local v3 = v1.getLatestVersion();
    local v4 = not v1.isUpToDate();
    if not l_RunService_0:IsStudio() then
        print((("\240\159\141\141 Running TopbarPlus %* by @ForeverHD & HD Admin"):format(v2)));
    end;
    if v4 then
        warn((("A new version of TopbarPlus (%*) is available: https://devforum.roblox.com/t/topbarplus/1017485"):format(v3)));
    end;
end);
return {};
