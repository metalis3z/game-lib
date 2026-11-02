-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(v0) --[[ Line: 3 ]]
    local v1 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2);
    local v2 = {
        Transparency = 1, 
        Color = Color3.fromRGB(255, 255, 255)
    };
    local v3 = {
        Transparency = 1
    };
    for _, v5 in pairs(v0:GetDescendants()) do
        if v5:IsA("CharacterAppearance") then
            v5:Destroy();
        end;
        if v5:IsA("Decal") then
            game:GetService("TweenService"):Create(v5, v1, v3):Play();
        end;
        if v5:FindFirstChild("Mesh") then
            v5.Mesh.TextureId = "";
            v5.Mesh.VertexColor = Vector3.new(175, 221, 255, 0);
        end;
        if v5:IsA("BasePart") then
            v5.CanCollide = false;
            v5.BrickColor = BrickColor.new("Pastel light blue");
            if v5:IsA("MeshPart") then
                v5.TextureID = "";
            end;
            game:GetService("TweenService"):Create(v5, v1, v2):Play();
            local v6 = script.Frost:Clone();
            v6.Parent = v5;
            v6.Enabled = true;
            spawn(function() --[[ Line: 32 ]]
                wait(0.25);
                v6.Enabled = false;
            end);
        end;
        if v5:IsA("BasePart") then
            game:GetService("PhysicsService"):SetPartCollisionGroup(v5, "AnchoredRagdolls");
        end;
    end;
end;