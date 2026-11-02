-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("ShowTeammates").OnClientEvent:Connect(function(v0)
    for _, v2 in v0 do
        local l_FirstChild_0 = game.Players:FindFirstChild(v2);
        if l_FirstChild_0 and l_FirstChild_0 ~= game.Players.LocalPlayer then
            local l_Character_0 = l_FirstChild_0.Character;
            if not l_Character_0 then
                return;
            else
                local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
                if not l_HumanoidRootPart_0 then
                    return;
                else
                    local v6 = script.TeamMate:Clone();
                    v6.Enabled = true;
                    v6.Parent = l_HumanoidRootPart_0;
                end;
            end;
        end;
    end;
end);