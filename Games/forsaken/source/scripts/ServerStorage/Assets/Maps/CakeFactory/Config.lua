-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Cake Factory", 
    Description = "Make a cake and feed the giant noob!", 
    Render = "rbxassetid://81983515415764", 
    Ambience = "rbxassetid://108477928107830", 
    AmbienceProperties = {
        Volume = 0.175
    }, 
    Created = function(v0) --[[ Line: 15 ]] --[[ Name: Created ]]
        task.spawn(function() --[[ Line: 18 ]]
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