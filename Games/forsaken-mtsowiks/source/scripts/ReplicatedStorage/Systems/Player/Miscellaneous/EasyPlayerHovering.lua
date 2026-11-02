-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local function v2(v1) --[[ Line: 7 ]] --[[ Name: addQuery ]]
            if v1:IsA("BasePart") then
                v1.CanQuery = true;
            end;
        end;
        local l_Players_0 = workspace:WaitForChild("Players");
        for _, v5 in pairs(l_Players_0:GetDescendants()) do
            if v5:IsA("BasePart") then
                v5.CanQuery = true;
            end;
        end;
        l_Players_0.DescendantAdded:Connect(v2);
    end
};