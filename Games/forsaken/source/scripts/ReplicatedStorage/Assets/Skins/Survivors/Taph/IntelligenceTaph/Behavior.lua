-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    OnAbilityUsed = function(v0, _) --[[ Line: 3 ]] --[[ Name: OnAbilityUsed ]]
        if game["Run Service"]:IsServer() then
            local l_SubspaceTripmine_0 = v0.Rig.SubspaceTripmine;
            local v3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));
            for _, v5 in pairs(l_SubspaceTripmine_0:GetChildren()) do
                v5.Color = v3;
            end;
        end;
    end, 
    CreateTripwireHooks = function(_, v7, v8) --[[ Line: 13 ]] --[[ Name: CreateTripwireHooks ]]
        if game["Run Service"]:IsServer() then
            local l_Attribute_0 = v7.Rig:GetAttribute("TripwireOrigin");
            local l_Attribute_1 = v7.Rig:GetAttribute("TripwireEnding");
            local v11 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));
            local v12 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));
            local v13 = v7.Config.TripwireTemplate:Clone();
            v13.Name = "Hook1";
            v13.Parent = v8;
            v13.CFrame = CFrame.lookAt(l_Attribute_0.Position, l_Attribute_1.Position);
            v13.Color = v11;
            local v14 = v7.Config.TripwireTemplate:Clone();
            v14.Name = "Hook2";
            v14.Parent = v8;
            v14.CFrame = CFrame.lookAt(l_Attribute_1.Position, l_Attribute_0.Position);
            v14.Color = v12;
            return v13, v14;
        else
            return;
        end;
    end
};