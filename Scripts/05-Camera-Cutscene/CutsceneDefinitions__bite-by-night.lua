-- Reference copy for study. Game: bite-by-night
-- Original: ReplicatedStorage/Modules/Cutscenes.lua  (ModuleScript, 269 lines)
-- What it does: Data table describing every intro, outro, kill cam and grab cam: which camera rig, which animation, which FOV curve, easing.


local Cutscenes = {}
 
 
local RigFolder = script:WaitForChild("Rigs")
local FOVFolder = script:WaitForChild("FOV")
local AnimsFolder = script:WaitForChild("Animations")

Cutscenes.HoaxOutro = {
	CameraRig = RigFolder:WaitForChild("OutroCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("HoaxOutro")),
	Animation = AnimsFolder:WaitForChild("HoaxOutro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.MimicOutro = {
	CameraRig = RigFolder:WaitForChild("OutroCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("MimicOutro")),
	Animation = AnimsFolder:WaitForChild("MimicOutro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.SpringtrapOutro = {
	CameraRig = RigFolder:WaitForChild("OutroCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("SpringtrapOutro")),
	Animation = AnimsFolder:WaitForChild("SpringtrapOutro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["KillLMS-Cam-Mimic"] = {
	CameraRig = RigFolder:WaitForChild("KillCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("MimicLMSKill")),
	Animation = AnimsFolder:WaitForChild("MimicLMSKill"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["KillLMS-Cam-Ennard"] = {
	CameraRig = RigFolder:WaitForChild("KillCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("EnnardKillLMS")),
	Animation = AnimsFolder:WaitForChild("EnnardKillLMS"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["KillCam-Ennard"] = {
	CameraRig = RigFolder:WaitForChild("KillCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("EnnardKill")),
	Animation = AnimsFolder:WaitForChild("EnnardKill"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["KillCam-Mimic"] = {
	CameraRig = RigFolder:WaitForChild("KillCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("MimicKill")),
	Animation = AnimsFolder:WaitForChild("MimicKill"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["KillCam-Springtrap-Axeless"] = {
	CameraRig = RigFolder:WaitForChild("KillCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("KillCamSpringtrap Axeless")),
	Animation = AnimsFolder:WaitForChild("SpringtrapKillCam Axeless"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["Grab-Cam-Springtrap-Victim"] = {
	CameraRig = RigFolder:WaitForChild("GrabCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("GrabSpringtrap")),
	Animation = AnimsFolder:WaitForChild("GrabSpringtrapVictim"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["Grab-Cam-Springtrap"] = {
	CameraRig = RigFolder:WaitForChild("GrabCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("GrabSpringtrap")),
	Animation = AnimsFolder:WaitForChild("GrabSpringtrap"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["KillLMS-Cam-Springtrap"] = {
	CameraRig = RigFolder:WaitForChild("KillCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("SpringtrapKillCamLMS")),
	Animation = AnimsFolder:WaitForChild("SpringtrapKillCamLMS"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes["KillCam-Springtrap"] = {
	CameraRig = RigFolder:WaitForChild("KillCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("KillCamSpringtrap")),
	Animation = AnimsFolder:WaitForChild("KillCamSpringtrap"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Linear,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.MimicIntro = {
	CameraRig = RigFolder:WaitForChild("IntroCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("MimicIntro")),
	Animation = AnimsFolder:WaitForChild("MimicIntro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.Bear5Intro = {
	CameraRig = RigFolder:WaitForChild("IntroCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("Bear5Intro")),
	Animation = AnimsFolder:WaitForChild("Bear5Intro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.EnnardIntro = {
	CameraRig = RigFolder:WaitForChild("IntroCamWithLight"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("EnnardIntro")),
	Animation = AnimsFolder:WaitForChild("EnnardIntro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.EnnardOutro = {
	CameraRig = RigFolder:WaitForChild("IntroCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("EnnardOutro")),
	Animation = AnimsFolder:WaitForChild("EnnardOutro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.SpringtrapIntro = {
	CameraRig = RigFolder:WaitForChild("IntroCam"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("SpringtrapIntro")),
	Animation = AnimsFolder:WaitForChild("SpringtrapIntro"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.ElevatorAlone = {
	CameraRig = RigFolder:WaitForChild("Elevator"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("ElevatorAlone")),
	Animation = AnimsFolder:WaitForChild("ElevatorAlone"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.ElevatorAloneWin = {
	CameraRig = RigFolder:WaitForChild("Elevator"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("ElevatorAlone")),
	Animation = AnimsFolder:WaitForChild("ElevatorAlone"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
Cutscenes.ElevatorFullWin = {
	CameraRig = RigFolder:WaitForChild("Elevator"),
	RootPart = "HumanoidRootPart",
	CameraPart = "camera",
	FOV = require(FOVFolder:WaitForChild("ElevatorFullWin")),
	Animation = AnimsFolder:WaitForChild("ElevatorFullWin"),
	CamOffset = CFrame.identity,
	TransitionTime = 0,
	EasingStyle = Enum.EasingStyle.Sine,
	EasingDirection = Enum.EasingDirection.In
}
 
 
return Cutscenes
