-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Updated = function(v0, v1) --[[ Line: 3 ]] --[[ Name: Updated ]]
        if v0.Connection then
            v0.Connection:Disconnect();
        end;
        v0.Connection = workspace.DescendantAdded:Connect(function(v2) --[[ Line: 8 ]]
            -- upvalues: v1 (copy)
            if v2:IsA("ProximityPrompt") then
                v2.KeyboardKeyCode = Enum.KeyCode[v1];
            end;
        end);
        for _, v4 in pairs(workspace:GetDescendants()) do
            if v4:IsA("ProximityPrompt") then
                v4.KeyboardKeyCode = Enum.KeyCode[v1];
            end;
        end;
    end
};