-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Die = function() --[[ Line: 7 ]] --[[ Name: Die ]]
        local l_SFX_0 = script.Parent.SFX;
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local v2 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Humanoid");
        if v2 then
            v2.Health = 0;
        end;
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Name = "GameOverBlackout";
        l_Frame_0.BackgroundColor3 = Color3.new();
        l_Frame_0.Size = UDim2.fromScale(2, 2);
        l_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
        l_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
        l_Frame_0.ZIndex = 1000;
        l_Frame_0.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
        local v4 = script.slenderstatic:Clone();
        v4.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
        local v5 = require(game.ReplicatedStorage.Modules.Sounds);
        local _ = v5:Play(l_SFX_0.gameover.gameoverbass);
        local v7 = v5:Play(l_SFX_0.gameover.gameoverstatic);
        while task.wait() and v7.Parent do
            l_Frame_0.Visible = v7.PlaybackLoudness <= 200;
        end;
        local l_static_0 = l_LocalPlayer_0.PlayerGui.TemporaryUI:FindFirstChild("static");
        if l_static_0 then
            l_static_0:Destroy();
        end;
        v4:Destroy();
        task.wait(2);
        game.TweenService:Create(l_Frame_0, TweenInfo.new(2), {
            BackgroundTransparency = 1
        }):Play();
        game.Debris:AddItem(l_Frame_0, 2);
    end
};