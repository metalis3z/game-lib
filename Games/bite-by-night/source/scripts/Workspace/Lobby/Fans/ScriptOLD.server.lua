-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
while task.wait(0.01) do
    for _, v1 in script.Parent:GetChildren() do
        if v1:IsA("MeshPart") then
            v1:PivotTo(v1:GetPivot() * v1:GetAttribute("Rotation"))
        end
    end
end