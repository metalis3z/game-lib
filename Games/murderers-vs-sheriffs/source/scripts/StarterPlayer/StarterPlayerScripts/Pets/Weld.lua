-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return function(v0)
    local function _(v1, v2)
        local v3 = Instance.new("ManualWeld", v1);
        v3.C0 = v1.CFrame:inverse() * v2.CFrame;
        v3.Part0 = v1;
        v3.Part1 = v2;
        v1.Anchored = false;
        v2.Anchored = false;
        v1.CanCollide = false;
        v2.CanCollide = false;
        return v3;
    end;
    for _, v6 in pairs(v0:GetChildren()) do
        if v6:IsA("BasePart") then
            local v7 = Instance.new("ManualWeld", v6);
            v7.C0 = v6.CFrame:inverse() * v0.CFrame;
            v7.Part0 = v6;
            v7.Part1 = v0;
            v6.Anchored = false;
            v0.Anchored = false;
            v6.CanCollide = false;
            v0.CanCollide = false;
        end;
        if v6:IsA("Model") then
            for _, v9 in pairs(v0:GetChildren()) do
                if v9:IsA("BasePart") then
                    local v10 = Instance.new("ManualWeld", v9);
                    v10.C0 = v9.CFrame:inverse() * v0.CFrame;
                    v10.Part0 = v9;
                    v10.Part1 = v0;
                    v9.Anchored = false;
                    v0.Anchored = false;
                    v9.CanCollide = false;
                    v0.CanCollide = false;
                end;
            end;
        end;
    end;
end;