-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

task.wait(3);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("MarketplaceService");
local _ = game:GetService("Players");
local l_TextChatService_0 = game:GetService("TextChatService");
local v5 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local _ = require(l_ReplicatedStorage_0.Packages.Net);
local l_Frame_0 = script.Parent.Hide.Frame;
local l_Teleport_0 = script.Parent.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons:WaitForChild("Teleport");
local function v10(v9) --[[ Line: 19 ]] --[[ Name: setState ]]
    -- upvalues: l_Frame_0 (copy), l_Teleport_0 (copy)
    if v9 then
        l_Frame_0.Toggle.ImageColor3 = Color3.fromRGB(255, 255, 255);
        l_Frame_0.Toggle.Price.Text = "ON";
        l_Teleport_0.Visible = false;
        return;
    else
        l_Frame_0.Toggle.ImageColor3 = Color3.fromRGB(255, 0, 0);
        l_Frame_0.Toggle.Price.Text = "OFF";
        l_Teleport_0.Visible = true;
        return;
    end;
end;
local v11 = false;
local v12 = v5.new(l_Frame_0.Toggle);
v12:Animate();
v12.OnActivated:Connect(function() --[[ Line: 35 ]]
    -- upvalues: v11 (ref), v10 (copy)
    v11 = not v11;
    v10(v11);
end);
l_TextChatService_0:WaitForChild("KiwiGames"):WaitForChild("Teleport").Enabled = true;
l_TextChatService_0:WaitForChild("KiwiGames"):WaitForChild("Teleport").AutocompleteVisible = true;
l_TextChatService_0:WaitForChild("KiwiGames"):WaitForChild("Teleport").Triggered:Connect(function() --[[ Line: 43 ]]
    -- upvalues: v11 (ref), v10 (copy)
    v11 = false;
    v10(v11);
end);