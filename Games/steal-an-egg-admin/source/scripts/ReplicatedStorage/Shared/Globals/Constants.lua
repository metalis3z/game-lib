-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local v1 = RunService:IsServer()
local v2 = RunService:IsStudio()
local v3 = if UserInputService.TouchEnabled then not UserInputService.MouseEnabled else UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled
local v4 = {
    TARGET_RADIUS = 300,
    DELETE_COUNT_BUFFER = 50,
    DELETE_COUNT_BUFFER_FAST = 75,
    INSERT_DELETE_COUNT_BUFFER = 550,
    CREATE_INSTANCE_COUNT_BUFFER = 550,
    STREAM_DIR_STACKING_WEIGHT_BUFFER = 950,
    STREAM_DIR_REPLICATION_WEIGHT_BUFFER = 950
}
local v5 = v4.TARGET_RADIUS * 2.4

v4.COLLECTABLES_RANGE_BY_TYPE = {
    Star = {
        NormalMode = v5 * 2,
        PerfMode = v5 * 2
    },
    Default = {
        NormalMode = v5,
        PerfMode = v5 * 0.85
    }
}

local v6 = {
    IS_SERVER = v1,
    IS_CLIENT = not v1,
    IS_STUDIO = v2,
    IS_MOBILE = v3
}

v6.IS_PRIVATE_SERVER = v1 and game.PrivateServerId ~= ""
v6.TAGS_MAP = {
    Traps = {
        PLACED_TRAP = "PlacedTrap",
        UNPLACE_PROMPT = "TrapUnplacePrompt"
    },
    Gameplay = {
        COLLISION_PART = "CollisionPart",
        SAFE_ZONE = "SafeZone"
    }
}
v6.STREAMING = v4
v6.BUTTON_FX = {
    BUTTON_MOUSE_DOWN_SOUND = "rbxassetid://123387115021464",
    BUTTON_CLOSE_SOUND = "rbxassetid://74634397427992"
}
v6.BACKPACK = {
    LIMIT = 250,
    HARD_LIMIT = 250,
    MAX_POWDERS = 120
}
v6.OFFLINE_ASSETS = {
    MAX_DURATION_SECONDS = 36000,
    MONEY_RATE_MULTIPLIER = 0.1,
    MIN_CLAIM_MONEY = 5
}
v6.BASE_FRAME_RATE = 60

if v2 then
    v6.STUDIO_YIELD_TIMEOUT = 60
else
    v6.STUDIO_YIELD_TIMEOUT = 9999999
end
v6.STUDIO_RESET_PLAYER_DATA_ON_UNLOAD = false
v6.GROUP_ID = 825735094
v6.MAIN_DEV_ID = 4035869470
v6.OWNER_ID = 10779916047
v6.TEST_PLACE_ID = 98345564489939
v6.JOIN_BADGE = 2590480615884365
v6.MIN_PLACE_GRID_SIZE = 3
v6.CLIENT_OVERLAP_MARGIN = 0.95
v6.SERVER_REDUCTION_FACTOR = 0.75
v6.SERVER_MIN_GRID_SIZE = 2.25
v6.MAX_PET_EXTRA_SLOTS = 5
v6.MAX_INVENTORY_SLOTS_PURCHASE = 5
v6.INVENTORY_SLOT_PURCHASE_INCREMENT = 5
v6.BRAINROT_MAX_HATCH_PER_REQUEST = 24
v6.ASSET_BALANCING_PROGRESS_INCREMENT_PERCENT = 13
v6.ASSET_BALANCING_GIGA_MULTIPLIER = 1
v6.BLOODLIT_EVENT_WEIGHT_REQ = 5
v6.BLOODLIT_BACKPACK_BONUS = 50
v6.BASE_ASSETS_WALK_SPEED = 13
v6.BASE_WALK_SPEED = 16
v6.BASE_JUMP_HEIGHT = 7
v6.BASE_CARRY_POWER = 1
v6.DEFAULT_BASE_LOCK_DURATION = 120
v6.LUCKY_BLOCK_TOOL_NAME = "LuckyBlockTool"
v6.ROBUX_ICON_STR = "\238\128\130"
return v6
