-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local function v8(v1) --[[ Line: 4 ]] --[[ Name: inMemoriam ]]
    if game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("InMemoriam") then
        return;
    else
        v1 = v1 or 3;
        local v2 = script.InMemoriam:Clone();
        v2.Shedletsky.ImageTransparency = 1;
        v2.Parent = game.Players.LocalPlayer.PlayerGui.TemporaryUI;
        game.Debris:AddItem(v2, v1);
        for _, v4 in pairs(game.SoundService:GetChildren()) do
            if v4:IsA("SoundGroup") and v4.Volume > 0 then
                local l_Volume_0 = v4.Volume;
                v4.Volume = 0;
                v2.AncestryChanged:Connect(function(_, v7) --[[ Line: 19 ]]
                    -- upvalues: v4 (copy), l_Volume_0 (copy)
                    if not v7 then
                        v4.Volume = l_Volume_0;
                    end;
                end);
            end;
        end;
        task.delay(0.5, function() --[[ Line: 27 ]]
            -- upvalues: v2 (copy)
            game.TweenService:Create(v2.Shedletsky, TweenInfo.new(0.75), {
                ImageTransparency = 0
            }):Play();
        end);
        return;
    end;
end;
v0.CreatedPost = function(_, v10) --[[ Line: 32 ]] --[[ Name: CreatedPost ]]
    -- upvalues: v8 (copy)
    if game["Run Service"]:IsClient() and v10.Rig == game.Players.LocalPlayer.Character then
        local v11 = v10.Rig:WaitForChild("Humanoid", 2);
        v11.HealthChanged:Connect(function(v12) --[[ Line: 36 ]]
            -- upvalues: v8 (ref)
            if v12 <= 0 then
                v8(3);
            end;
        end);
        local l_PrimaryPart_0 = v10.Rig.PrimaryPart;
        if l_PrimaryPart_0 then
            l_PrimaryPart_0:GetPropertyChangedSignal("Anchored"):Connect(function() --[[ Line: 45 ]]
                -- upvalues: l_PrimaryPart_0 (copy), v8 (ref), v11 (copy)
                if l_PrimaryPart_0.Anchored then
                    v8(10);
                    return;
                else
                    if v11 and v11.Health > 0 then
                        local l_InMemoriam_0 = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("InMemoriam");
                        while l_InMemoriam_0 do
                            l_InMemoriam_0:Destroy();
                            l_InMemoriam_0 = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("InMemoriam");
                        end;
                    end;
                    return;
                end;
            end);
        end;
    end;
end;
return v0;