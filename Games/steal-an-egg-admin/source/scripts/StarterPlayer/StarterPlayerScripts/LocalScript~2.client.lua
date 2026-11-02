-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
local AvatarEditorService = game:GetService("AvatarEditorService")
task.wait(1)
AvatarEditorService:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true)
