-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Wedge_PRESET_0 = script.Wedge_PRESET;
local l_abs_0 = math.abs;
return table.freeze({
    Generate3DTriangle = function(_, v3, v4) --[[ Line: 10 ]] --[[ Name: Generate3DTriangle ]]
        -- upvalues: l_abs_0 (copy), l_Wedge_PRESET_0 (copy)
        assert(v3, "bad points, must be { BasePart }");
        assert(v4, "bad parent, must be Instance");
        local function _(v5) --[[ Line: 14 ]] --[[ Name: __flattenY ]]
            -- upvalues: v3 (copy)
            return (Vector3.new(v5.X, v3[1].Position.Y, v5.Z));
        end;
        local l_Position_0 = v3[1].Position;
        local v8 = Vector3.new(l_Position_0.X, v3[1].Position.Y, l_Position_0.Z);
        l_Position_0 = v3[2].Position;
        local v9 = Vector3.new(l_Position_0.X, v3[1].Position.Y, l_Position_0.Z);
        l_Position_0 = v3[3].Position;
        local v10 = Vector3.new(l_Position_0.X, v3[1].Position.Y, l_Position_0.Z);
        l_Position_0 = v9 - v8;
        local v11 = v10 - v8;
        local v12 = v10 - v9;
        local v13 = l_Position_0:Dot(l_Position_0);
        local v14 = v11:Dot(v11);
        local v15 = v12:Dot(v12);
        if v14 < v13 and v15 < v13 then
            local l_v8_0 = v8;
            v8 = v10;
            v10 = l_v8_0;
        elseif v13 < v14 and v15 < v14 then
            local l_v9_0 = v9;
            v9 = v8;
            v8 = l_v9_0;
        end;
        l_Position_0 = v9 - v8;
        v11 = v10 - v8;
        v12 = v10 - v9;
        local l_Unit_0 = v11:Cross(l_Position_0).Unit;
        local l_Unit_1 = v12:Cross(l_Unit_0).Unit;
        local l_Unit_2 = v12.Unit;
        local v21 = l_abs_0((l_Position_0:Dot(l_Unit_1)));
        local v22 = l_Wedge_PRESET_0:Clone();
        v22.Size = Vector3.new(100, v21, (l_abs_0((l_Position_0:Dot(l_Unit_2)))));
        v22.CFrame = CFrame.fromMatrix((v8 + v9) / 2, l_Unit_0, l_Unit_1, l_Unit_2);
        v22.Parent = v4;
        local v23 = l_Wedge_PRESET_0:Clone();
        v23.Size = Vector3.new(100, v21, (l_abs_0((v11:Dot(l_Unit_2)))));
        v23.CFrame = CFrame.fromMatrix((v8 + v10) / 2, -l_Unit_0, l_Unit_1, -l_Unit_2);
        v23.Parent = v4;
        return {
            v22, 
            v23
        };
    end
});