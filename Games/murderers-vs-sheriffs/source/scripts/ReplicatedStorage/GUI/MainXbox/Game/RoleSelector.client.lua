-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_RoleSelector_0 = l_Parent_0:WaitForChild("RoleSelector");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
for _, v4 in pairs(script:GetChildren()) do
    game:GetService("ContentProvider"):Preload(v4.SoundId);
end;
game.ReplicatedStorage.Remotes.Gameplay.Fade.OnClientEvent:connect(function()
    game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0);
    for _ = 1, 30 do
        l_Parent_0.Fade.Transparency = l_Parent_0.Fade.Transparency - 0.03333333333333333;
        game:GetService("RunService").RenderStepped:wait();
    end;
end);
game.ReplicatedStorage.Remotes.Gameplay.LoadingMap.OnClientEvent:connect(function(_)

end);
local v7 = {
    Innocent = Color3.new(0, 1, 0), 
    Sheriff = Color3.new(0, 0, 1), 
    Murderer = Color3.new(1, 0, 0), 
    Zombie = Color3.new(0.09803921568627451, 0.6745098039215687, 0), 
    Survivor = Color3.new(0.16862745098039217, 0.6039215686274509, 0.9333333333333333), 
    Red = Color3.new(0.8509803921568627, 0.13725490196078433, 0.13725490196078433), 
    Blue = Color3.new(0.24705882352941178, 0.6901960784313725, 0.8784313725490196), 
    Juggernaut = Color3.new(0.8509803921568627, 0.13725490196078433, 0.13725490196078433), 
    Gladiator = Color3.new(0.24705882352941178, 0.6901960784313725, 0.8784313725490196)
};
local v8 = {
    Innocent = 13, 
    Sheriff = 14, 
    Murderer = 15
};
local v9 = {
    Classic = {
        "Innocent", 
        "Sheriff", 
        "Murderer"
    }, 
    Infection = {
        "Survivor", 
        "Zombie"
    }
};
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
l_Remotes_0.Gameplay.ShowRoleSelect.OnClientEvent:Connect(function()
    for _ = 1, 30 do
        l_Parent_0.Fade.Transparency = l_Parent_0.Fade.Transparency + 0.03333333333333333;
        game:GetService("RunService").RenderStepped:wait();
    end;
end);
l_Remotes_0.Gameplay.ShowRoleSelectNew.OnClientEvent:Connect(function()
    for _ = 1, 30 do
        l_Parent_0.Fade.Transparency = l_Parent_0.Fade.Transparency + 0.03333333333333333;
        game:GetService("RunService").RenderStepped:wait();
    end;
end);
game.ReplicatedStorage.Remotes.Gameplay.RoleSelect.OnClientEvent:connect(function(v13, v14, v15, v16, v17)
    for _ = 1, 30 do
        l_Parent_0.Fade.Transparency = l_Parent_0.Fade.Transparency + 0.03333333333333333;
        game:GetService("RunService").RenderStepped:wait();
    end;
    game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0.5);
    if v17 == "Classic" then
        l_RoleSelector_0.Chance.Text = "Your chance to be murderer: ";
        spawn(function()
            l_RoleSelector_0.Chance.Text = "Your chance to be murderer: " .. game.ReplicatedStorage.Remotes.Extras.GetChance:InvokeServer() .. "%";
        end);
    end;
    l_RoleSelector_0.Visible = true;
    if v17 == "Classic" then
        local v19 = v9[v17];
        for v20 = 1, v8[v13] do
            local v21 = v19[(v20 - 1) % #v19 + 1];
            if v20 ~= v8[v13] then
                script["Click" .. (v20 - 1) % #v19 + 1]:Play();
            else
                script.Ding:Play();
            end;
            wait(0.04);
            l_RoleSelector_0.Role.Text = v21;
            l_RoleSelector_0.Role.TextColor3 = v7[v21];
            wait(0.06);
        end;
        wait(2.5);
        if v13 == "Murderer" or v13 == "Sheriff" or v13 == "Zombie" or v13 == "Survivor" then
            l_RoleSelector_0.Title.Text = "You will receive your weapon in...";
            l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
            for v22 = 1, 10 do
                l_RoleSelector_0.Role.Text = 11 - v22;
                if v22 == 3 then
                    l_RoleSelector_0:TweenPosition(UDim2.new(0, 0, 0, 25), "Out", "Quad", 1, false);
                end;
                wait(1);
            end;
            l_RoleSelector_0.Visible = false;
        else
            l_RoleSelector_0.Title.Text = "Game starts in...";
            l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
            for v23 = 1, 10 do
                l_RoleSelector_0.Role.Text = 11 - v23;
                if v23 == 3 then
                    l_RoleSelector_0:TweenPosition(UDim2.new(0, 0, 0, 25), "Out", "Quad", 1, false);
                end;
                wait(1);
            end;
        end;
    end;
    if v17 == "Dodgeball" then
        l_RoleSelector_0.Title.Text = "You are on the";
        l_RoleSelector_0.Role.Text = v13 .. " Team";
        l_RoleSelector_0.Role.TextColor3 = v7[v13] or Color3.new();
        wait(3);
        l_RoleSelector_0.Title.Text = "Game starts in...";
        l_RoleSelector_0:TweenPosition(UDim2.new(0, 0, 0, 25), "Out", "Quad", 1, false);
        l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
        for v24 = 1, 5 do
            l_RoleSelector_0.Role.Text = 6 - v24;
            wait(1);
        end;
    elseif v17 == "Infection" then
        l_RoleSelector_0.Title.Text = "Everyone is a";
        l_RoleSelector_0.Role.Text = "Survivor";
        l_RoleSelector_0.Role.TextColor3 = v7.Survivor;
        wait(3);
        l_RoleSelector_0.Title.Text = "Someone will be infected in...";
        l_RoleSelector_0:TweenPosition(UDim2.new(0, 0, 0, 25), "Out", "Quad", 1, false);
        l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
        for v25 = 1, 5 do
            l_RoleSelector_0.Role.Text = 6 - v25;
            wait(1);
        end;
    elseif v17 == "Massacre" then
        l_RoleSelector_0.Title.Text = "Everyone is a";
        l_RoleSelector_0.Role.Text = "Murderer";
        l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 0, 0);
        wait(3);
        l_RoleSelector_0.Title.Text = "Massacre starts in...";
        l_RoleSelector_0:TweenPosition(UDim2.new(0, 0, 0, 25), "Out", "Quad", 1, false);
        l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
        for v26 = 1, 5 do
            l_RoleSelector_0.Role.Text = 6 - v26;
            wait(1);
        end;
    elseif v17 == "Juggernaut" then
        l_RoleSelector_0.Title.Text = "You are a";
        l_RoleSelector_0.Role.Text = v13;
        l_RoleSelector_0.Role.TextColor3 = v7[v13];
        wait(3);
        l_RoleSelector_0.Title.Text = "Battle begins in...";
        l_RoleSelector_0:TweenPosition(UDim2.new(0, 0, 0, 25), "Out", "Quad", 1, false);
        l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
        for v27 = 1, 5 do
            l_RoleSelector_0.Role.Text = 6 - v27;
            wait(1);
        end;
    end;
    l_RoleSelector_0.Visible = false;
    if v16 then
        game.Players.LocalPlayer.CameraMode = "LockFirstPerson";
    end;
    l_Parent_0.YourCodeName.Image = require(game.ReplicatedStorage.CodeImages)[v15];
    l_Parent_0.YourCodeName.ImageColor3 = v14.Color;
    local l_Weapon_0 = l_Parent_0.Weapon;
    local v29 = true;
    if v13 ~= "Murderer" then
        v29 = v13 == "Sheriff";
    end;
    l_Weapon_0.Visible = v29;
    l_Parent_0.Weapon.Knife.Visible = v13 == "Murderer";
    l_Parent_0.Weapon.Gun.Visible = v13 == "Sheriff";
    l_Parent_0.Weapon.WeaponIcon.Image = v13 == "Murderer" and "http://www.roblox.com/asset/?id=148256623" or v13 == "Sheriff" and "http://www.roblox.com/asset/?id=197518111" or "";
end);
local activeRoundTimer = 0;
local roundTimerToken = 0;
local function setRoundTimerText(seconds)
    activeRoundTimer = math.max(0, math.floor(tonumber(seconds) or activeRoundTimer or 0));
    l_Parent_0.Timer.Text = activeRoundTimer;
end;
game.ReplicatedStorage.Remotes.Gameplay.RoundStart.OnClientEvent:connect(function(v30)
    roundTimerToken = roundTimerToken + 1;
    local token = roundTimerToken;
    setRoundTimerText(v30);
    while token == roundTimerToken and wait(1) do
        setRoundTimerText(activeRoundTimer - 1);
    end;
end);
game.ReplicatedStorage.Remotes.Gameplay.RoundTimeUpdated.OnClientEvent:Connect(function(newTime)
    setRoundTimerText(newTime);
end);
while true do
    wait();
    if not (l_LocalPlayer_0.Character == nil) then
        break;
    end;
end;
wait();
l_LocalPlayer_0.CameraMode = "Classic";
l_LocalPlayer_0.CameraMinZoomDistance = 7;
wait(0.5);
l_LocalPlayer_0.CameraMinZoomDistance = 0.5;
game.StarterGui:SetCoreGuiEnabled("Health", false);
game.StarterGui:SetCoreGuiEnabled("PlayerList", false);