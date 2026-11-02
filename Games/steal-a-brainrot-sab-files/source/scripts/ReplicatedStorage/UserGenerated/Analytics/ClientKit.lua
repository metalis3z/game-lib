

--!native
local v0 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local v1 = v0.Table({
    JoinSource = v0.Enum(Enum.JoinSource), 
    ItemType = v0.Optional(v0.Enum(Enum.AvatarItemType)), 
    AssetId = v0.Optional(v0.Pattern("^rbxassetid://%d+$")), 
    OutfitId = v0.Optional(v0.Pattern("^rbxassetid://%d+$")), 
    AssetType = v0.Optional(v0.Enum(Enum.AssetType))
});
local v2 = v0.Table({
    SourceGameId = v0.Optional(v0.Integer), 
    SourcePlaceId = v0.Optional(v0.Integer), 
    ReferredByPlayerId = v0.Optional(v0.Integer), 
    Members = v0.Optional(v0.UniqueArray(v0.Integer)), 
    TeleportData = v0.Optional(v0.Storable), 
    LaunchData = v0.Optional(v0.Storable), 
    GameJoinContext = v0.Optional(v1)
});
local v3 = {};
for _, v5 in ipairs(Enum.DeveloperMemoryTag:GetEnumItems()) do
    v3[v5.Name] = v0.FiniteNonNegative;
end;
local v6 = v0.Table({
    System = v0.Table({
        UWP = v0.Optional(v0.Boolean), 
        Windows = v0.Boolean, 
        Time = v0.Finite, 
        Clock = v0.Finite, 
        ElapsedTime = v0.Finite, 
        TimezoneOffset = v0.String, 
        Timezone = v0.String, 
        TimezoneDST = v0.Boolean, 
        HeapSize = v0.FiniteNonNegative
    }), 
    Game = v0.Table({
        LoadingDuration = v0.Optional(v0.FiniteNonNegative)
    }), 
    LocalPlayer = v0.Table({
        JoinData = v2, 
        NetworkPing = v0.Optional(v0.FinitePositive)
    }), 
    TeleportService = v0.Table({
        TeleportData = v0.Optional(v0.Storable)
    }), 
    Workspace = v0.Table({
        ServerTimeNow = v0.Finite, 
        RealPhysicsFPS = v0.FiniteNonNegative, 
        DistributedGameTime = v0.FiniteNonNegative, 
        NumAwakeParts = v0.FiniteNonNegative, 
        PhysicsThrottling = v0.IntegerRange(0, 100)
    }), 
    Stats = v0.Table({
        ContactsCount = v0.IntegerNonNegative, 
        DataReceiveKbps = v0.FiniteNonNegative, 
        DataSendKbps = v0.FiniteNonNegative, 
        FrameTime = v0.FiniteNonNegative, 
        HeartbeatTime = v0.FiniteNonNegative, 
        InstanceCount = v0.IntegerNonNegative, 
        MovingPrimitivesCount = v0.IntegerNonNegative, 
        PhysicsReceiveKbps = v0.FiniteNonNegative, 
        PhysicsSendKbps = v0.FiniteNonNegative, 
        PhysicsStepTime = v0.FiniteNonNegative, 
        PrimitivesCount = v0.IntegerNonNegative, 
        RenderCPUFrameTime = v0.FiniteNonNegative, 
        RenderGPUFrameTime = v0.FiniteNonNegative, 
        SceneDrawcallCount = v0.IntegerNonNegative, 
        SceneTriangleCount = v0.IntegerNonNegative, 
        ShadowsDrawcallCount = v0.IntegerNonNegative, 
        ShadowsTriangleCount = v0.IntegerNonNegative, 
        UI2DDrawcallCount = v0.IntegerNonNegative, 
        UI2DTriangleCount = v0.IntegerNonNegative, 
        UI3DDrawcallCount = v0.IntegerNonNegative, 
        UI3DTriangleCount = v0.IntegerNonNegative, 
        MemoryUsageMbForTag = v0.Table(v3), 
        TotalMemoryUsageMb = v0.FiniteNonNegative
    }), 
    UserInputService = v0.Table({
        DeviceForm = v0.Optional(v0.Enum(Enum.DeviceForm))
    }), 
    GuiService = v0.Table({
        IsTenFootInterface = v0.Boolean, 
        TouchControlsEnabled = v0.Boolean, 
        GuiInsetTopLeft = v0.Vector2Finite, 
        GuiInsetBotRight = v0.Vector2Finite, 
        IsModalDialog = v0.Boolean, 
        MenuIsOpen = v0.Boolean, 
        PreferredTransparency = v0.Range(0, 1), 
        ReducedMotionEnabled = v0.Boolean, 
        CoreGuiNavigationEnabled = v0.Boolean, 
        GuiNavigationEnabled = v0.Boolean, 
        AutoSelectGuiEnabled = v0.Boolean
    }), 
    CurrentCamera = v0.Table({
        ViewportSize = v0.Vector2Finite
    }), 
    LocalizationService = v0.Table({
        RobloxLocaleId = v0.StringRange(1, 50), 
        SystemLocaleId = v0.StringRange(1, 50)
    }), 
    VoiceChatService = v0.Table({
        VoiceEnabled = v0.Optional(v0.Boolean)
    }), 
    UserSettings = v0.Table({
        GameSettings = v0.Table({
            ControlMode = v0.Enum(Enum.ControlMode), 
            VignetteEnabled = v0.Boolean, 
            ComputerCameraMovementMode = v0.Enum(Enum.ComputerCameraMovementMode), 
            ComputerMovementMode = v0.Enum(Enum.ComputerMovementMode), 
            GamepadCameraSensitivity = v0.FiniteNonNegative, 
            MouseSensitivity = v0.Range(0, 4), 
            RotationType = v0.Enum(Enum.RotationType), 
            SavedQualityLevel = v0.Enum(Enum.SavedQualitySetting), 
            TouchCameraMovementMode = v0.Enum(Enum.TouchCameraMovementMode), 
            TouchMovementMode = v0.Enum(Enum.TouchMovementMode), 
            InFullScreen = v0.Boolean, 
            InStudioMode = v0.Boolean
        })
    })
});
local v7 = {
    AssertGameJoinContext = v1, 
    AssertJoinData = v2, 
    AssertData = v6, 
    AcceptRemote = script:WaitForChild("Accept")
};
return table.freeze(v7);