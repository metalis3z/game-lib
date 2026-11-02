-- Prevent executable scripts embedded in temporary catalog/cloud assets.
-- This runs before StarterPlayerScripts so unsafe preview models cannot start.
local function isTemporaryCloudAsset(instance)
    local current = instance.Parent;

    while current and current ~= game do
        if string.match(current.Name, "^cloud_%d+") then
            return true;
        end;

        current = current.Parent;
    end;

    return false;
end;

local function inspect(instance)
    if instance:IsA("BaseScript") and isTemporaryCloudAsset(instance) then
        instance:Destroy();
    end;
end;

game.DescendantAdded:Connect(inspect);

for _, descendant in game:GetDescendants() do
    inspect(descendant);
end;