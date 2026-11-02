

local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local v2 = require("./app");
local v3 = require("../roblox_packages/conch");
local v4 = require("./state");
local v5 = require("../roblox_packages/vide");
local v6 = false;
local l_opened_0 = v4.opened;
local l_focused_0 = v4.focused;
local function v9()
    if v6 then
        return;
    else
        v6 = true;
        return v5.mount(v2, l_Players_0.LocalPlayer:WaitForChild("PlayerGui"));
    end;
end;
local function v13(v10)
    if not v6 then
        v6 = true;
        local _ = v5.mount(v2, l_Players_0.LocalPlayer:WaitForChild("PlayerGui"));
    end;
    l_UserInputService_0.InputBegan:Connect(function(v12)
        if v12.KeyCode ~= v10 and v12.UserInputType ~= v10 then
            return;
        else
            l_opened_0(not l_opened_0());
            l_focused_0(l_opened_0());
            return;
        end;
    end);
end;
return {
    app = v2, 
    mount = v9, 
    opened = l_opened_0, 
    bind_to = v13, 
    conch = v3
};