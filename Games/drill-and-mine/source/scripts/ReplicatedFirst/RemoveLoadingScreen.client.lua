-- Dismiss Roblox's default join loading screen as early as possible.
-- The game's own custom LoadingScreen was removed entirely (2026-07-17,
-- backup in ServerStorage.__LoadingScreenBackup), so nothing replaces it.
game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()
