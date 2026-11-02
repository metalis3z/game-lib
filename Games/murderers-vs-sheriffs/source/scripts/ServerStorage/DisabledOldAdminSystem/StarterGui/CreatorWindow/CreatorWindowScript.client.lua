-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Parent_0 = script.Parent;
local l_List_0 = l_Parent_0:WaitForChild("Commands"):WaitForChild("List");
local v4, v5 = l_Remotes_0:WaitForChild("Extras"):WaitForChild("GetCreatorStatus"):InvokeServer();
if not v4 then
    l_Parent_0:Destroy();
    return;
else
    l_Parent_0.Visible = false;
    for _, v7 in l_List_0:GetChildren() do
        if v7:IsA("Frame") then
            local v8 = true;
            if v5[v7.Name] ~= true then
                v8 = v5[v7.Name] == "PrivateServer";
            end;
            if v5[v7.Name] == "PrivateServer" then
                local v9 = script:WaitForChild("PrivateServer"):Clone();
                v9.Parent = v7.Title;
                v9.Visible = true;
            end;
            v7.Visible = v8;
        end;
    end;
    l_Parent_0:WaitForChild("Title"):WaitForChild("Close"):WaitForChild("Button").Activated:Connect(function() --[[ Line: 29 ]]
        l_Parent_0.Visible = false;
    end);
    l_WindowService_0:RegisterFrame(l_Parent_0, "CreatorWindow");
    return;
end;