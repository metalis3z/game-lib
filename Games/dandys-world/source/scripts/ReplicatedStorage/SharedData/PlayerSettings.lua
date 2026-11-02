--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMqC011c2ljU291cmNlCUdldFRhZ2dlZAVwYWlycwpTb3VuZEdyb3VwA0lzQQVNdXRlZAxTZXRBdHRyaWJ1dGUGVm9sdW1lDk9uQ2hhbmdlQ2xpZW50BGdhbWURQ29sbGVjdGlvblNlcnZpY2UKR2V0U2VydmljZQ9TdGlja2VyU2V0dGluZ3MLQmxpbmtUb2dnbGUPSGlnaGxpZ2h0VG9nZ2xlDUxvYWRvdXRUb2dnbGULTXVzaWNUb2dnbGUOUGFydGljbGVUb2dnbGUMU3ByaW50VG9nZ2xlE01vdmluZ1RleHR1cmVUb2dnbGURVGFpbEVmZmVjdHNUb2dnbGUMSGFwdGljU2xpZGVyC0NoYXRFbmFibGVkClNob3dXaW5kb3cLRGlzcGxheVRleHQUU3RpY2tlcnMgSW4gQ2hhdDogJXMLTGF5b3V0T3JkZXIEVHlwZQdib29sZWFuDkhpZGVGcm9tUGxheWVyF1N0aWNrZXIgR2FtZSBXaW5kb3c6ICVzEEJsaW5rIEVmZmVjdDogJXMUSGlnaGxpZ2h0IEFycm93czogJXMTVG9nZ2xlIExvYWRvdXRzOiAlcw5NdXRlIE11c2ljOiAlcw1QYXJ0aWNsZXM6ICVzEVNwcmludCBUb2dnbGU6ICVzE01vdmluZyBUZXh0dXJlczogJXMSRHlsZSBUYWlsIChSUCk6ICVzFEhhcHRpYyBJbnRlbnNpdHk6ICVzBnNsaWRlcgZTbmFwVG8AAwsBAQAABgMAAAUBASD7AQAAbwMAALwBAQUBAAAAnwEDAqQCAwAAACBAUgMBAJ8CAgQXAhMAbwkEALwHBv4FAAAAnwcDAg4HDgBvCQYAKgACAAEAAACpCgABqQoBALwHBi4HAAAAnwcEAQ4AAgCMBwAAZQABAIwHAQAwBwZLCAAAAG4C7P8CAAAAggABAAkDAQMCAwMEAAAgQAMEAwUDBgMHAwgAJQkBGAAAAAAAAQAAAAABAAAAAAEAAAAAAAAAAQAAAAAA/QAFJgAAAAABAQAAAAYDAAAFAQEBggABAAAASAkBGABKAAAAAAQAAAECADSjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC4gEOAOICEQDiAxoAMAMC2A8AAADiAx0AMAMC5xAAAAAwAgHzBAAAAOICHwAwAgHlBQAAAOICIQAwAgGpBgAAAOICJAAwAgF3BwAAAOICKADAAykAEgAAADADAh8nAAAAMAIBKAgAAADiAiwAMAIBfAkAAADiAi8AMAIBYgoAAADiAjIAMAIBuAsAAADiAjUAMAIBgQwAAADiAjoAwAM7ADADAh8nAAAAMAIBSA0AAACCAQIAPAMKBAAAAEADCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYFCgQFBgcICQoLDA0DFwMYBQIPEAMZAxoDGwIAAAAAAADwPwMcAx0DHgEBCAQSEwAAABQVAAAAFhcAAAAYGQAAAAMfAgAAAAAAAABACAMSGwAAABQcAAAAFhcAAAADIAgDEh4AAAAUFQAAABYXAAAAAyEIAxIgAAAAFBwAAAAWFwAAAAMiAgAAAAAAAAhACAMSIgAAABQjAAAAFhcAAAADIwIAAAAAAAAQQAMJCAQSJQAAABQmAAAAFhcAAAAn/////wYAAyQCAAAAAAAAFEAIAxIqAAAAFCsAAAAWFwAAAAMlAgAAAAAAABhACAMSLQAAABQuAAAAFhcAAAADJgIAAAAAAAAcQAgDEjAAAAAUMQAAABYXAAAAAycCAAAAAAAAIEAIBBIzAAAAFDQAAAAWFwAAABgZAAAAAygCAAAAAAAAIkADKQMqCAUSNgAAABQ3AAAAFjgAAAA5KwAAACf/////BgECAAEBAAEYAAEAAAAAAAIBAQAABgAA+QANAAAFAAAFAAAFBAAAAPwADQAABQAABQAABQAABgUAAPsADAEAAAAAAoYeChT517FMRmgX6AzpTW32Bh1gtNpgFQ==

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")

return {
	StickerSettings = {
		ChatEnabled = {
			DisplayText = "Stickers In Chat: %s",
			LayoutOrder = 1,
			Type = "boolean",
			HideFromPlayer = true
		},
		ShowWindow = {
			DisplayText = "Sticker Game Window: %s",
			LayoutOrder = 2,
			Type = "boolean"
		}
	},
	BlinkToggle = {
		DisplayText = "Blink Effect: %s",
		LayoutOrder = 1,
		Type = "boolean"
	},
	HighlightToggle = {
		DisplayText = "Highlight Arrows: %s",
		LayoutOrder = 2,
		Type = "boolean"
	},
	LoadoutToggle = {
		DisplayText = "Toggle Loadouts: %s",
		LayoutOrder = 3,
		Type = "boolean"
	},
	MusicToggle = {
		DisplayText = "Mute Music: %s",
		LayoutOrder = 4,
		Type = "boolean",
		OnChangeClient = function(p1) --[[ OnChangeClient | Line: 37 | Upvalues: CollectionService (copy) ]]
			for k, v in pairs((CollectionService:GetTagged("MusicSource"))) do
				if v:IsA("SoundGroup") then
					v:SetAttribute("Muted", p1 == true)
					v.Volume = if p1 then 0 else 1
				end
			end
		end
	},
	ParticleToggle = {
		DisplayText = "Particles: %s",
		LayoutOrder = 5,
		Type = "boolean"
	},
	SprintToggle = {
		DisplayText = "Sprint Toggle: %s",
		LayoutOrder = 6,
		Type = "boolean"
	},
	MovingTextureToggle = {
		DisplayText = "Moving Textures: %s",
		LayoutOrder = 7,
		Type = "boolean"
	},
	TailEffectsToggle = {
		DisplayText = "Dyle Tail (RP): %s",
		LayoutOrder = 8,
		Type = "boolean",
		HideFromPlayer = true
	},
	HapticSlider = {
		DisplayText = "Haptic Intensity: %s",
		LayoutOrder = 9,
		Type = "slider",
		SnapTo = 5,
		OnChangeClient = function(p1) --[[ OnChangeClient | Line: 72 ]] end
	}
}