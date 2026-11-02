-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local v2 = require(l_ReplicatedStorage_0.Packages.Net);
local v3 = require(l_ReplicatedStorage_0.Packages.Signal);
local v4 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local l_PlayerGui_0 = l_Players_0.LocalPlayer.PlayerGui;
local v6 = v2:RemoteEvent("ConfirmationService/Show");
local l_Confirmation_0 = l_PlayerGui_0:WaitForChild("Confirmation");
local l_Template_0 = l_Confirmation_0:WaitForChild("Template");
local v9 = {};
local v10 = false;
v9.IsInPrompt = function(_) --[[ Line: 21 ]] --[[ Name: IsInPrompt ]]
    -- upvalues: v10 (ref)
    return v10;
end;
v9.Show = function(_, v13, v14) --[[ Line: 25 ]] --[[ Name: Show ]]
    -- upvalues: v10 (ref), v3 (copy), l_Template_0 (copy), l_Confirmation_0 (copy), v4 (copy)
    while v10 do
        task.wait();
    end;
    v10 = true;
    v13 = v13 or "Do you really want to do this?";
    local v15 = v3.new();
    local v16 = l_Template_0:Clone();
    v16.Name = "Confirmation";
    v16.Parent = l_Confirmation_0;
    v16.Visible = true;
    local l_Description_0 = v16.Content.Description;
    local l_Close_0 = v16.Close;
    local l_Yes_0 = v16.Yes;
    local l_No_0 = v16.No;
    l_Description_0.Text = v13;
    local function _() --[[ Line: 49 ]] --[[ Name: cleanup ]]
        -- upvalues: v16 (copy)
        v16:Destroy();
    end;
    local function _(v22) --[[ Line: 53 ]] --[[ Name: respond ]]
        -- upvalues: v15 (copy)
        v15:Fire(v22);
    end;
    local v24 = v4.new(l_Yes_0);
    v24:Animate();
    v24.OnActivated:Connect(function() --[[ Line: 59 ]]
        -- upvalues: v15 (copy)
        v15:Fire(true);
    end);
    local v25 = v4.new(l_No_0);
    v25:Animate();
    v25.OnActivated:Connect(function() --[[ Line: 65 ]]
        -- upvalues: v15 (copy)
        v15:Fire(false);
    end);
    local v26 = v4.new(l_Close_0);
    v26:Animate();
    v26.OnActivated:Connect(function() --[[ Line: 71 ]]
        -- upvalues: v15 (copy)
        v15:Fire(false);
    end);
    local v27 = nil;
    if v14 then
        v27 = task.delay(v14, function() --[[ Line: 77 ]]
            -- upvalues: v15 (copy)
            v15:Fire(false);
        end);
    end;
    local v28 = v15:Wait();
    v16:Destroy();
    v15:Destroy();
    if v27 and coroutine.status(v27) == "suspended" then
        pcall(task.cancel, v27);
    end;
	v10 = false;
    return v28;
end;
v9.Start = function(_) --[[ Line: 95 ]] --[[ Name: Start ]]
    -- upvalues: v6 (copy), v9 (copy)
    v6.OnClientEvent:Connect(function(v30, v31, v32) --[[ Line: 96 ]]
        -- upvalues: v9 (ref), v6 (ref)
        local v33 = v9:Show(v31, v32 - workspace:GetServerTimeNow());
        v6:FireServer(v30, v33);
    end);
end;
return v9;