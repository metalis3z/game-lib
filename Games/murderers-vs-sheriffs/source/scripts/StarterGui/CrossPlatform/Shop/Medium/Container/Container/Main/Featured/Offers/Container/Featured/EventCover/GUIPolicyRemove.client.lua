-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GUIPolicyRemove, time of decompilation: Fri Feb 13 19:21:22 2026 ]]
if require(game.ReplicatedFirst:WaitForChild("ChinaPolicyService")):IsActive() then
    script.Parent.Visible = false;
    script.Parent.Changed:Connect(function() --[[ Line: 6 ]]
        script.Parent.Visible = false;
    end);
end;