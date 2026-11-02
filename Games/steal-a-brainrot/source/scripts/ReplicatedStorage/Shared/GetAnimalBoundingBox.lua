-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v18(v0, v1) --[[ Line: 2 ]] --[[ Name: GetBoundingBox ]]
    local v2 = 1e999;
    local v3 = 1e999;
    local v4 = 1e999;
    local v5 = -1e999;
    local v6 = -1e999;
    local v7 = -1e999;
    for _, v9 in v0:GetDescendants() do
        if v9:IsA("BasePart") and v9.Transparency < 1 and not v1[v9] then
            local l_CFrame_0 = v9.CFrame;
            local v11 = v9.Size * 0.5;
            for v12 = -1, 1, 2 do
                for v13 = -1, 1, 2 do
                    for v14 = -1, 1, 2 do
                        local v15 = l_CFrame_0:PointToWorldSpace((Vector3.new(v11.X * v12, v11.Y * v13, v11.Z * v14)));
                        v2 = math.min(v2, v15.X);
                        v3 = math.min(v3, v15.Y);
                        v4 = math.min(v4, v15.Z);
                        v5 = math.max(v5, v15.X);
                        v6 = math.max(v6, v15.Y);
                        v7 = math.max(v7, v15.Z);
                    end;
                end;
            end;
        end;
    end;
    local v16 = Vector3.new(v5 - v2, v6 - v3, v7 - v4);
    local v17 = Vector3.new((v2 + v5) / 2, (v3 + v6) / 2, (v4 + v7) / 2);
    return CFrame.new(v17), v16;
end;
return function(v19, v20) --[[ Line: 37 ]]
    -- upvalues: v18 (copy)
    local v21 = {};
    if v19 == "Los Noobinis" then
        v21[v20["Cube.003"]] = true;
    end;
    local l_FakeRootPart_0 = v20:FindFirstChild("FakeRootPart");
    if l_FakeRootPart_0 then
        v21[l_FakeRootPart_0] = true;
    end;
    if v19 == "Tacorita Bicicleta" then
        local l_RootPart_0 = v20:FindFirstChild("RootPart");
        if l_RootPart_0 then
            v21[l_RootPart_0] = true;
        end;
    end;
    local v24, v25 = v18(v20, v21);
    return v24, v25;
end;