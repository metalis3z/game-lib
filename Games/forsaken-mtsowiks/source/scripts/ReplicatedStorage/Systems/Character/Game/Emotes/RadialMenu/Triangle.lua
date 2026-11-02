-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_WedgePart_0 = Instance.new("WedgePart");
l_WedgePart_0.Material = Enum.Material.SmoothPlastic;
l_WedgePart_0.Anchored = true;
l_WedgePart_0.CanCollide = false;
l_WedgePart_0.Color = Color3.new(1, 1, 1);
return function(v1, v2, v3, v4) --[[ Line: 7 ]]
    -- upvalues: l_WedgePart_0 (copy)
    local v5 = v3 - v2;
    local v6 = v4 - v2;
    local v7 = v4 - v3;
    local v8 = v5:Dot(v5);
    local v9 = v6:Dot(v6);
    local v10 = v7:Dot(v7);
    if v9 < v8 and v10 < v8 then
        local l_v2_0 = v2;
        v2 = v4;
        v4 = l_v2_0;
    elseif v10 < v9 and v8 < v9 then
        local l_v3_0 = v3;
        v3 = v2;
        v2 = l_v3_0;
    end;
    v5 = v3 - v2;
    v6 = v4 - v2;
    v7 = v4 - v3;
    local l_Unit_0 = v6:Cross(v5).Unit;
    local l_Unit_1 = v7:Cross(l_Unit_0).Unit;
    local l_Unit_2 = v7.Unit;
    local v16 = math.abs((v5:Dot(l_Unit_1)));
    local v17 = math.abs((v5:Dot(l_Unit_2)));
    local v18 = math.abs((v6:Dot(l_Unit_2)));
    local v19 = l_WedgePart_0:Clone();
    v19.Size = Vector3.new(0, v16, v17);
    v19.CFrame = CFrame.fromMatrix((v2 + v3) / 2, l_Unit_0, l_Unit_1, l_Unit_2);
    v19.Parent = v1;
    local v20 = l_WedgePart_0:Clone();
    v20.Size = Vector3.new(0, v16, v18);
    v20.CFrame = CFrame.fromMatrix((v2 + v4) / 2, -l_Unit_0, l_Unit_1, -l_Unit_2);
    v20.Parent = v1;
    return v19, v20;
end;