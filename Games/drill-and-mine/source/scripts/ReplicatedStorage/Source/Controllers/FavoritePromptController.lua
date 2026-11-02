-- FavoritePromptController — DISABLED.
--
-- Roblox exposes no engine API to prompt a player to favorite an experience or
-- to read favorite status (AvatarEditorService favorites only avatar catalog
-- items; SocialService has invite/feedback prompts but no favorite prompt). The
-- only way to nudge favorites is a custom UI, which was not wanted here, so this
-- controller is intentionally a no-op (no Init = MainClient skips it).

local FavoritePromptController = {}

return FavoritePromptController
