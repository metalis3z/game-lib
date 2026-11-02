-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local _Index = script._Index
local NETWORK_MAP = require(_Index.NETWORK_MAP)
local t = {
	IS_SERVER = RunService:IsServer()
}
t.IS_CLIENT = not t.IS_SERVER
t.IS_STUDIO = RunService:IsStudio()
t.IS_MOBILE = UserInputService.TouchEnabled and not UserInputService.MouseEnabled or (UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled)
t.IS_PRIVATE_SERVER = t.IS_SERVER and game.PrivateServerId ~= ""
t.ANIMATIONTRACK_PLAY_PARAMS = require(_Index.ANIMATIONTRACK_PLAY_PARAMS)
t.SORTED_ANIMATION_PRIORITY = require(_Index.SORTED_ANIMATION_PRIORITY)
t.CLIENT_SETTINGS = require(_Index.CLIENT_SETTINGS)
NETWORK_MAP.GuardTutorial = require(_Index.NETWORK_MAP.Endpoints.GuardTutorial)
t.NETWORK_MAP = NETWORK_MAP
t.SIGNALS_MAP = require(_Index.SIGNALS_MAP)
t.TAGS_MAP = require(_Index.TAGS_MAP)
t.TIME_FORMAT = require(_Index.TIME_FORMAT)
t.STREAMING = require(_Index.STREAMING)
t.BUTTON_FX = require(_Index.BUTTON_FX)
t.BACKPACK = require(_Index.BACKPACK)
t.MURDER_MYSTERY_WEAPONS = require(_Index.MURDER_MYSTERY_WEAPONS)
t.OFFLINE_ASSETS = require(_Index.OFFLINE_ASSETS)
t.VIP_OFFER = require(_Index.VIP_OFFER)
t.BASE_FRAME_RATE = 60
t.STUDIO_YIELD_TIMEOUT = if t.IS_STUDIO then 60 else 9999999
t.STUDIO_RESET_PLAYER_DATA_ON_UNLOAD = false
t.GROUP_ID = 15518815
t.MAIN_DEV_ID = 10410180699
t.TEST_PLACE_ID = 98345564489939
t.JOIN_BADGE = 2590480615884365
t.OWNER_ID = 10410180699
t.MIN_PLACE_GRID_SIZE = 3
t.CLIENT_OVERLAP_MARGIN = 0.95
t.SERVER_REDUCTION_FACTOR = 0.75
t.SERVER_MIN_GRID_SIZE = t.MIN_PLACE_GRID_SIZE * t.SERVER_REDUCTION_FACTOR
t.MAX_PET_EXTRA_SLOTS = 5
t.MAX_INVENTORY_SLOTS_PURCHASE = 5
t.INVENTORY_SLOT_PURCHASE_INCREMENT = 5
t.BRAINROT_MAX_HATCH_PER_REQUEST = 24
t.ASSET_BALANCING_PROGRESS_INCREMENT_PERCENT = 13
t.ASSET_BALANCING_GIGA_MULTIPLIER = 1
t.BLOODLIT_EVENT_WEIGHT_REQ = 5
t.BLOODLIT_BACKPACK_BONUS = 50
t.BASE_ASSETS_WALK_SPEED = 13
t.BASE_WALK_SPEED = 16
t.BASE_JUMP_HEIGHT = 7

local IS_STUDIO = t.IS_STUDIO

t.BASE_CARRY_POWER = 1
t.SUPPORTED_GIFTS_TYPES = {
	Asset = "Asset",
	LuckyBlock = "LuckyBlock"
}
t.EXCLUDED_GEAR_NAMES_FROM_GIFTING = { "Slap", "DirtSlap", "DemonSlap", "DiamondSlap", "EmeraldSlap", "GoldenSlap" }
t.DEFAULT_BASE_LOCK_DURATION = 120
t.LUCKY_BLOCK_TOOL_NAME = "LuckyBlockTool"
t.ROBUX_ICON_STR = "\238\128\130"

return t