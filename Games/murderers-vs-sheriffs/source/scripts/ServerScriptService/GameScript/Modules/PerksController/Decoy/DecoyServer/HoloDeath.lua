-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(v0) --[[ Line: 1 ]]
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.SoundId = "http://www.roblox.com/asset/?id=177045481";
    l_Sound_0.Volume = 0.2;
    l_Sound_0.PlayOnRemove = false;
    local v2 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2);
    local v3 = {
        Transparency = 1, 
        Color = Color3.fromRGB(255, 255, 255)
    };
    local v4 = {
        Transparency = 1
    };
    for _, v6 in pairs(v0:GetDescendants()) do
        if v6:IsA("CharacterAppearance") then
            v6:Destroy();
        end;
        if v6:IsA("Decal") then
            game:GetService("TweenService"):Create(v6, v2, v4):Play();
        end;
        if v6:FindFirstChild("Mesh") then
            v6.Mesh.TextureId = "";
            v6.Mesh.VertexColor = Vector3.new(175, 221, 255, 0);
        end;
        if v6:IsA("BasePart") then
            v6.BrickColor = BrickColor.new("Pastel light blue");
            if v6:IsA("MeshPart") then
                v6.TextureID = "";
            end;
            game:GetService("TweenService"):Create(v6, v2, v3):Play();
            local v7 = script.Frost:Clone();
            v7.Parent = v6;
            v7.Enabled = true;
            spawn(function() --[[ Line: 33 ]]
                -- upvalues: v7 (copy)
                wait(0.25);
                v7.Enabled = false;
            end);
        end;
    end;
    v0.Name = "";
    game.Debris:AddItem(v0, 2);
end;