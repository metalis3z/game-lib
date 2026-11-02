-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v4 = require(l_Packages_0.Input);
local v5 = require(l_Packages_0.Signal);
local v6 = require(l_Packages_0.Net);
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local _ = require(l_Classes_0.ClickEffect);
local v9 = v6:RemoteEvent("TeleportService/Reconnect");
local _ = l_Players_0.LocalPlayer;
local v11 = {
    Mouse = v4.Mouse.new(), 
    Gamepad = v4.Gamepad.new(), 
    Touch = v4.Touch.new(), 
    Keyboard = v4.Keyboard.new()
};
local v12 = {
    OnMouseLeftBegan = v5.new()
};
return {
    Events = function(_, v14)
        return v12[v14];
    end, 
    Get = function(_, v16)
        return v11[v16];
    end, 
    Start = function(_)
        local v18 = os.clock();
        l_UserInputService_0.InputBegan:Connect(function(v19, v20)
            v18 = os.clock();
            if v19.UserInputType == Enum.UserInputType.MouseButton1 then
                v12.OnMouseLeftBegan:Fire(v19, v20);
            end;
        end);
        task.spawn(function()
            while task.wait(5) do
                if os.clock() - v18 >= 1140 then
                    v9:FireServer();
                end;
            end;
        end);
    end
};