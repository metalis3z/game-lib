-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Packages.Net);
return {
    Start = function(_)
        if not v1:Invoke("CommandsService/ViewCommands") then
            return;
        else
            local v3 = require(l_ReplicatedStorage_0.Packages.Conch);
            require(l_ReplicatedStorage_0.Shared.ConchTypes);
            v3.initiate_default_lifecycle();
            v3.ui.bind_to(Enum.KeyCode.F2);
            v1:Connect("CommandsService/OpenCommandBar", function()
                v3.ui.opened(true);
            end);
            return;
        end;
    end
};