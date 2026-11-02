-- Where the original server kept its EnemyService. Shared modules still require it here
-- (GameplayUtility:GetEntityFromModel on the server), so this hands them the rebuild's.

return require(game:GetService("ServerScriptService"):WaitForChild("Server"):WaitForChild("EnemyService"))
