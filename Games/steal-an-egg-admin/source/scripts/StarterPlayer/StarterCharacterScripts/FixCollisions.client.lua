-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = { "UpperTorso", "LowerTorso" }

local function processDescendant(v2) -- line 7 | captures: v1
    if v2:IsA("BasePart") and table.find(v1, v2.Name) then
        v2.CanCollide = false
    end
end

local function disableCollisions(v3) -- line 12 | captures: v1
    for v4, v5 in ipairs(v3:GetDescendants()) do
        if v5:IsA("BasePart") and table.find(v1, v5.Name) then
            v5.CanCollide = false
        end
    end
end

while task.wait(0.4) do
    for v6, v7 in ipairs(script.Parent:GetDescendants()) do
        if v7:IsA("BasePart") and table.find(v1, v7.Name) then
            v7.CanCollide = false
        end
    end
end
