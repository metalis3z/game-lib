-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent;
local l_TweenService_0 = game:GetService("TweenService");
local v4 = nil;
local v5 = "PC";
local v6 = {
    PC = l_Parent_0:WaitForChild("Desktop"), 
    Tablet = l_Parent_0:WaitForChild("Mobile"), 
    Phone = l_Parent_0:WaitForChild("Mobile"), 
    Gamepad = l_Parent_0:WaitForChild("Console")
};
local _ = script:WaitForChild("Click");
local l_Ding_0 = script:WaitForChild("Ding");
local l_ClickSounds_0 = script:WaitForChild("ClickSounds");
local function v31(v10) --[[ Line: 26 ]] --[[ Name: showRoleSelect ]]
    task.wait(0.3);
    local l_v4_0 = v4;
    local l_Roles_0 = v10.Roles;
    local l_SelectedRole_0 = v10.SelectedRole;
    local v14 = v10.ChanceRole or "Murderer";
    local l_Chance_0 = v10.Chance;
    local v16 = {};
    for v17, _ in l_Roles_0 do
        table.insert(v16, v17);
    end;
    l_v4_0.Chance.Visible = l_Chance_0 ~= nil;
	l_v4_0.Title.Text = "You Are";
	if game.ReplicatedStorage.Remotes.Gameplay.RoundState.CurrentGamemode.Value == "Infection" then
		l_v4_0.Title.Text = "Everyone is a"
	end
    l_v4_0.BackgroundTransparency = 0.3;
    l_v4_0.Visible = true;
    if l_Chance_0 ~= nil then
        l_v4_0.Chance.Text = "Your chance to be " .. string.lower(v14) .. ": " .. l_Chance_0 .. "%";
	end;
	if game.ReplicatedStorage.Remotes.Gameplay.RoundState.CurrentGamemode.Value == "SnowballFight" then
		l_v4_0.Chance.Visible = false
	end
    if #v16 > 1 then
        local v19 = 1;
        local v20 = 1;
        local l_l_ClickSounds_0_Children_0 = l_ClickSounds_0:GetChildren();
        for v22 = 1, 24 do
            v19 = v19 + 1;
            if #v16 < v19 then
                v19 = 1;
            end;
            local v23 = v16[v19];
            local v24 = l_Roles_0[v23];
            local v25 = false;
            if v23 == l_SelectedRole_0 then
                v25 = v22 > 14;
            end;
            if v25 then
                l_Ding_0:Play();
            else
                if v20 > 6 then
                    v20 = 1;
                end;
                l_l_ClickSounds_0_Children_0[v20]:Play();
                v20 = v20 + 1;
            end;
			l_v4_0.Role.Text = (game.ReplicatedStorage.Remotes.Gameplay.RoundState.CurrentGamemode.Value == "SnowballFight" and (v23 == "Red" and "Red Team" or v23 == "Blue" and "Blue Team" or v23)) or v23;
            l_v4_0.Role.TextColor3 = v24;
            task.wait(0.1);
            if v25 then
                break;
            end;
        end;
    else
        local l_SelectedRole_1 = v10.SelectedRole;
        local v27 = l_Roles_0[l_SelectedRole_1];
        l_v4_0.Role.Text = l_SelectedRole_1;
        l_v4_0.Role.TextColor3 = v27;
        task.wait(1.5);
    end;
    wait(2.5);
    local v28 = v10.GameplayText or "Game starts in...";
    l_v4_0.Title.Text = v28;
    l_v4_0.Role.TextColor3 = Color3.fromRGB(255, 255, 255);
    l_v4_0.Chance.Visible = false;
    local v29 = v10.CountdownLength or 10;
    for v30 = 1, v29 do
        l_v4_0.Role.Text = v29 + 1 - v30;
        if v30 == 3 then
            l_TweenService_0:Create(l_v4_0, v0, {
                Position = UDim2.new(0.5, 0, 0, l_v4_0.AbsoluteSize.Y / 2), 
                BackgroundTransparency = 1
            }):Play();
        end;
        task.wait(1);
    end;
    l_v4_0.Visible = false;
    l_v4_0.Position = UDim2.new(0.5, 0, 0.5, 0);
end;
local function v33() --[[ Line: 122 ]] --[[ Name: UpdateDevice ]]
    local v32 = l_LocalPlayer_0.PlayerGui:GetAttribute("Device") or "PC";
    v4 = v6[v32];
    v5 = v32;
end;
local v34 = l_LocalPlayer_0.PlayerGui:GetAttribute("Device") or "PC";
v4 = v6[v34];
v5 = v34;
l_LocalPlayer_0.PlayerGui:GetAttributeChangedSignal("Device"):Connect(v33);
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("ShowRoleSelectNew").OnClientEvent:Connect(v31);