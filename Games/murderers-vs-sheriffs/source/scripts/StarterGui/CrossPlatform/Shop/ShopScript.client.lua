-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopScript, time of decompilation: Fri Feb 13 19:21:20 2026 ]]
local _ = script.Parent;
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("DeviceService"));
local l_GuiService_0 = game:GetService("GuiService");
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_ShopPhone_0 = script:WaitForChild("ShopPhone");
local l_ShopDesktop_0 = script:WaitForChild("ShopDesktop");
local l_ShopConsole_0 = script:WaitForChild("ShopConsole");
(function() --[[ Line: 12 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_GuiService_0 (copy), l_ShopPhone_0 (copy), l_ShopConsole_0 (copy), l_ShopDesktop_0 (copy)
    while l_LocalPlayer_0.PlayerGui:GetAttribute("Device") == nil do
        task.wait();
    end;
    while not l_LocalPlayer_0.PlayerGui:FindFirstChild("MainGUI") do
        task.wait();
    end;
    local v9 = l_LocalPlayer_0.PlayerGui:GetAttribute("Device") == "Phone";
    local v10 = l_GuiService_0:IsTenFootInterface();
    if v9 then
        l_ShopPhone_0.Enabled = true;
        return;
    elseif v10 then
        l_ShopConsole_0.Enabled = true;
        return;
    else
        l_ShopDesktop_0.Enabled = true;
        return;
    end;
end)();