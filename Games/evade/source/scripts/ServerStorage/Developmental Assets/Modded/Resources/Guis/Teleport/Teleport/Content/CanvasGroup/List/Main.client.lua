-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("TeleportService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Packages.Net);
local v3 = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local v4 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v5 = v2:RemoteFunction("TeleportService/TeleportToPrivate");
local v6 = v2:RemoteEvent("TeleportService/TeleportToGame");
local v7 = {
    ["Main Game"] = {
        Place = game.PlaceId
    }, 
    ["Three Roads"] = {
        Place = 86030288739907, 
		OnlyAllow = {
			"brodyherman"
        }
    }
};
for v8, v9 in pairs(v7) do
    if v9.OnlyAllow then
        local v10 = false;
        for _, v12 in ipairs(v9.OnlyAllow) do
            if v12:lower() == game.Players.LocalPlayer.Name:lower() then
                v10 = true;
                break;
            end;
        end;
        if not v10 then
            continue;
        end;
    end;
    local v13 = script.Template:Clone();
    v13.Parent = script.Parent;
    v13.Frame.Text.Text = v8;
    local v14 = v4.new(v13.Frame.Public);
    v14:Animate();
    v14.OnActivated:Connect(function() --[[ Line: 107 ]]
        -- upvalues: v6 (copy), v9 (copy)
        v6:FireServer(v9.Place);
    end);
    local v15 = v4.new(v13.Frame.Private);
    v15:Animate();
    v15.OnActivated:Connect(function() --[[ Line: 113 ]]
        -- upvalues: v5 (copy), v9 (copy), v13 (copy), v3 (copy)
        local _, v17 = v5:InvokeServer(v9.Place, v13.Frame.Input.Text);
        v3:Notify(v17);
    end);
end;
if not script.Parent:FindFirstChild("Template") then
    script.Parent.Parent.Parent.Parent.Parent:Destroy();
end;