-- Graveyard for asset IDs that the experience does NOT have access permission
-- to load. Putting them here keeps the IDs in source control (so they can be
-- re-imported later when access is granted) while the live Animation instances
-- they used to live on are blanked out -- that's the only way to silence the
-- repeated "Failed to load animation with sanitized ID ..." + "experience
-- doesn't have access permission to use asset id ..." errors that spam the
-- console every time an Animator:LoadAnimation hits one of these.
--
-- This module is never required at runtime; it exists as documentation.

return {
	Animations = {
		-- 5x CactoHipopotamo mutation Idle. Originally lived on:
		--   ReplicatedStorage.Brainrots.Common.Golden.CactoHipopotamo.Idle
		--   ReplicatedStorage.Brainrots.Common.Diamond.CactoHipopotamo.Idle
		--   ReplicatedStorage.Brainrots.Common.Prismatic.CactoHipopotamo.Idle
		--   ReplicatedStorage.Brainrots.Common.Chromatic.CactoHipopotamo.Idle
		--   ReplicatedStorage.Brainrots.Common.Cursed.CactoHipopotamo.Idle
		CactoHipopotamoIdle = "rbxassetid://118214985891441",
	},
}
