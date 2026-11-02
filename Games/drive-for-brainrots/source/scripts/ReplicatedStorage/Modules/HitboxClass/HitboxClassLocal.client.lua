-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- decompilation:
local l_require_0 = require;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = l_require_0(script:WaitForChild("Signal"));
local l_HitboxClassRemote_0 = l_ReplicatedStorage_0:WaitForChild("HitboxClassRemote");
local v4 = l_require_0(script["HitboxClass Module"].Value);
local v5 = {};
l_HitboxClassRemote_0.OnClientEvent:Connect(function(v6, v7) --[[ Line: 11 ]]
    -- upvalues: v5 (copy), v4 (copy), l_HitboxClassRemote_0 (copy)
    if v6 == "Clr" then
        for v8, v9 in pairs(v5) do
            v9:Destroy();
            v5[v8] = nil;
        end;
        return;
    elseif v6 ~= "New" and not v5[v7._Tick] then
        warn("No hitbox found on the client for tick value sent. Don't change the tick value manually, change the ID instead. (HitboxClass)");
        return;
    else
        if v6 == "New" then
            local v10 = v4.new(v7);
            v5[v7._Tick] = v10;
            l_HitboxClassRemote_0:FireServer(v7._Tick);
        end;
        if v6 == "Start" then
            v5[v7._Tick]:Start();
        end;
        if v6 == "Stop" then
            v5[v7._Tick]:Stop();
        end;
        if v6 == "ClrTag" then
            v5[v7._Tick]:ClearTaggedChars();
        end;
        if v6 == "Weld" then
            v5[v7._Tick]:WeldTo(v7.WeldTo, v7.Offset);
        end;
        if v6 == "WeldOfs" then
            v5[v7._Tick]:ChangeWeldOffset(v7.Offset);
        end;
        if v6 == "Unweld" then
            v5[v7._Tick]:Unweld();
        end;
        if v6 == "PosCh" then
            v5[v7._Tick]:SetPosition(v7.Position);
        end;
        if v6 == "Dbg" then
            v5[v7._Tick]:SetDebug(v7.Debug);
        end;
        if v6 == "Des" then
            v5[v7._Tick]:Destroy();
            v5[v7._Tick] = nil;
        end;
        return;
    end;
end);
