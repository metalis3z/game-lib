-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2, v3) -- line 6
    local Attachment = Instance.new("Attachment")
    Attachment.CFrame = v1.CFrame:ToObjectSpace(v2)
    v3.Parent = Attachment
    Attachment.Parent = v1
    v3.Ended:Connect(function() -- line 11 | captures: Attachment
        Attachment:Destroy()
    end)
    v3:Play()
end
