-- Script by XcorrectTheDev (DO NOT STOLE! If I found someone delete this line and put it on sell i will offsale this model forever)

wait(0.5) -- Wait for everything to load
local PlrChr = game.Players.LocalPlayer.Character
local ChracterHumanoid = PlrChr:FindFirstChildOfClass("Humanoid")
local CharacterRoot = PlrChr:FindFirstChild("HumanoidRootPart")
local RakeTheme = script.Parent.Theme
local NearTheme = script.Parent.GetNear
local Found = script.Parent.Found
local FlashEffect = script.Parent.FlashEffect
local ScreenShake = script.Parent.ScreenShake
local NightTheme = script.Parent.NightTheme
local Rake -- Leave it empty
local Camera = workspace.CurrentCamera
local Debounce1 = false
local Debounce2 = false
local StunDebounce = false
local ReplayDebounce = false
local RangeMagnitude -- Leave it empty
local NightThemeIDS = {"142219239", "206166604"} -- Night theme sound ids if you have more put it in here do (, "soundID"})

Rake = workspace:FindFirstChild("The_Rake") -- Rake location

--[[ 
 Better don't change anything. This script is WIP v.0.4
 This thing still glitchy and still needs an improvement

 Don't edit pass this line you may break the whole script ]]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
function StartSound()
NightTheme:Pause()
Found:Play()
FlashEffect.BackgroundTransparency = 0.6
wait(0.4)
ScreenShake.Disabled = false
FlashEffect.BackgroundTransparency = 1
RakeTheme:Play()	
end

function StopSound()
ScreenShake.Disabled = true
FlashEffect.BackgroundTransparency = 1
RakeTheme:Stop()
NightTheme:Play()
Camera.FieldOfView = 70
end

function UpdateNightThemeID()
local RandomNTIDS = math.random(1,#NightThemeIDS)
local ChosenNTID = NightThemeIDS[RandomNTIDS]
--print(ChosenNTID)
NightTheme.SoundId = "rbxassetid://" .. ChosenNTID
NightTheme.Ended:Connect(function()
UpdateNightThemeID()
end)
end

NightTheme:Play()
UpdateNightThemeID()

game:GetService("RunService").RenderStepped:Connect(function()
if Rake ~= nil and Rake:FindFirstChild("HumanoidRootPart") ~= nil then
if CharacterRoot ~= nil and ChracterHumanoid ~= nil then -- Check if The rake, Player character, Player character humanoid still exist
RangeMagnitude = (Rake.HumanoidRootPart.Position - CharacterRoot.Position).magnitude
if Rake.Stunning.Value == true then
StunDebounce = true
if RangeMagnitude < 70 then
ReplayDebounce = true
end
StopSound()
elseif Rake.Stunning.Value == false or ChracterHumanoid.Health > 0 then
StunDebounce = false
if ReplayDebounce == true and RangeMagnitude < 70 then
ReplayDebounce = false
StartSound()
end
end
if RangeMagnitude < 70 and Debounce1 == false and StunDebounce == false then
Debounce1 = true
StartSound()
elseif RangeMagnitude > 70 and StunDebounce == false and Debounce1 == true then
Debounce1 = false
ReplayDebounce = false
StopSound()
end
if RangeMagnitude < 90 and RangeMagnitude > 70 and StunDebounce == false and not Debounce2 then
Debounce2 = true			
StopSound()
NearTheme:Play()	
elseif Debounce2 and Debounce1 or StunDebounce or RangeMagnitude > 90 then
NearTheme:Stop()	
Debounce2 = false	
end
if RakeTheme.IsPlaying then
if RangeMagnitude > 70 then
Debounce1 = false
ReplayDebounce = false
StopSound()
end
if Rake.NPC.Health <= 0 then
script.Parent:Destroy()
end
if ChracterHumanoid.Health <= 0 then
StopSound()
end
if RangeMagnitude < 70 and RangeMagnitude > 35 then
RakeTheme.PlaybackSpeed = 0.95
end
if RangeMagnitude < 35 and RangeMagnitude > 20 then
RakeTheme.PlaybackSpeed = 1
end
if RangeMagnitude < 20 then
RakeTheme.PlaybackSpeed = 1.05
end
end
end
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
