-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType"));
local l_ActiveEvents_0 = game:GetService("ReplicatedStorage"):WaitForChild("ActiveEvents");
local v2 = {};
local v7 = {
    EventAdded = Instance.new("BindableEvent"), 
    EventChanged = Instance.new("BindableEvent"), 
    EventUpdated = Instance.new("RemoteEvent"), 
    GetMainEvent = function(_) --[[ Line: 12 ]] --[[ Name: GetMainEvent ]]
        -- upvalues: v2 (copy)
        for _, v5 in v2 do
            if v5.Priority == "Main" then
                return v5;
            end;
        end;
        return nil;
    end, 
    GetActiveEvents = function(_) --[[ Line: 22 ]] --[[ Name: GetActiveEvents ]]
        -- upvalues: v2 (copy)
        return v2;
    end
};
v7.BindClient = function(_) --[[ Line: 27 ]] --[[ Name: BindClient ]]
    -- upvalues: v7 (copy), v2 (copy)
    v7.EventUpdated.OnClientEvent:Connect(function(v9, v10) --[[ Line: 28 ]]
        -- upvalues: v2 (ref), v7 (ref)
        v2[v9] = v10;
        v7.EventChanged:Fire(v9);
    end);
end;
local function _(v11) --[[ Line: 35 ]] --[[ Name: onEventAdded ]]
    -- upvalues: v2 (copy), v7 (copy)
    local l_Name_0 = v11.Name;
    v2[l_Name_0] = require(v11);
    v7.EventAdded:Fire(l_Name_0);
    v7.EventChanged:Fire(l_Name_0);
end;
(function() --[[ Line: 43 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_ActiveEvents_0 (copy), v2 (copy), v7 (copy)
    for _, v15 in l_ActiveEvents_0:GetChildren() do
        local l_Name_1 = v15.Name;
        v2[l_Name_1] = require(v15);
        v7.EventAdded:Fire(l_Name_1);
        v7.EventChanged:Fire(l_Name_1);
    end;
    l_ActiveEvents_0.ChildAdded:Connect(function(v17) --[[ Line: 47 ]]
        -- upvalues: v2 (ref), v7 (ref)
        if not v17:IsA("ModuleScript") then
            return;
        else
            local l_Name_2 = v17.Name;
            v2[l_Name_2] = require(v17);
            v7.EventAdded:Fire(l_Name_2);
            v7.EventChanged:Fire(l_Name_2);
            return;
        end;
    end);
end)();
return v7;