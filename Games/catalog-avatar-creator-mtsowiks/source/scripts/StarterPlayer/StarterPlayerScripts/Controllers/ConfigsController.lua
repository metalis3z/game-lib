-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local GetConfig = Remotes:WaitForChild("GetConfig");
local ConfigUpdated = Remotes:WaitForChild("ConfigUpdated");
local BindableEvent = Instance.new("BindableEvent");
local u1 = {
    Values = {},
    OnUpdated = BindableEvent.Event
};

function u1.GetValue(p2, p3) -- Line: 23
    -- upvalues: u1 (copy)
    local v4 = u1.Values[p2];

    if v4 == nil then
        return p3;
    end;

    return v4;
end;

local function mergeValues(p5) -- Line: 29
    -- upvalues: u1 (copy), BindableEvent (copy)
    if typeof(p5) ~= "table" then
        return;
    end;

    local v6 = false;

    for i, v in p5 do
        if u1.Values[i] ~= v then
            u1.Values[i] = v;
            v6 = true;
        end;
    end;

    for i in u1.Values do
        if p5[i] == nil then
            u1.Values[i] = nil;
            v6 = true;
        end;
    end;

    if v6 then
        BindableEvent:Fire();
    end;
end;

ConfigUpdated.OnClientEvent:Connect(function(p7) -- Line: 52
    -- upvalues: mergeValues (copy)
    mergeValues(p7);
end);
task.spawn(function() -- Line: 57
    -- upvalues: GetConfig (copy), mergeValues (copy)
    local success, result = pcall(function() -- Line: 58
        -- upvalues: GetConfig (ref)
        return GetConfig:InvokeServer();
    end);

    if success and typeof(result) == "table" then
        mergeValues(result);

        return;
    end;

    warn("[ConfigsController] initial GetConfig failed; staying empty until server broadcasts. err=", result);
end);

return u1;