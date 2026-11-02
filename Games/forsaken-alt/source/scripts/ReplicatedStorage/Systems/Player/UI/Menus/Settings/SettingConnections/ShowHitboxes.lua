-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Updated = function(v0, v1) --[[ Line: 3 ]] --[[ Name: Updated ]]
        if v1 then
            if not v0.Connection then
                v0.Connection = workspace:WaitForChild("Hitboxes").ChildAdded:Connect(function(v2) --[[ Line: 7 ]]
                    if v2:GetAttribute("Hidden") then
                        return;
                    else
                        v2.Material = Enum.Material.ForceField;
                        v2.Transparency = 0.65;
                        return;
                    end;
                end);
                return;
            end;
        elseif v0.Connection then
            v0.Connection:Disconnect();
            v0.Connection = nil;
        end;
    end
};