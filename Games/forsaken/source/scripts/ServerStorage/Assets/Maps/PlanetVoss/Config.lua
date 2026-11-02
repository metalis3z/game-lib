-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Planet Voss", 
    Description = "i like to play with trains and draw", 
    Render = "rbxassetid://120306049205195", 
    Ambience = "rbxassetid://125336504279737", 
    AmbienceProperties = {
        Volume = 0.35
	},
	Variants = {
		Normal = 40, 
		Aurora = 60
		},
    Created = function(v0) --[[ Line: 15 ]] --[[ Name: Created ]]
        task.spawn(function() --[[ Line: 16 ]]
            -- upvalues: v0 (copy)
            local l_Conveyors_0 = v0.Map.MapBoundaries.Conveyors;
            while task.wait(0.1) and l_Conveyors_0.Parent do
                for _, v3 in pairs(l_Conveyors_0:GetChildren()) do
                    v3.AssemblyLinearVelocity = v3.CFrame.LookVector * 50;
                end;
            end;
        end);
    end
};