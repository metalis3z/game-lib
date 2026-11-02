local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
print('[ClientBootstrap] Script started')

local ok1, Knit_upvr = pcall(require, ReplicatedStorage.Packages.Knit)
if not ok1 then warn('[ClientBootstrap] Failed to require Knit:', Knit_upvr) return end
print('[ClientBootstrap] Knit required OK')

local ok2, Signal = pcall(require, Knit_upvr.Util.Signal)
if not ok2 then warn('[ClientBootstrap] Failed to require Signal:', Signal) return end
print('[ClientBootstrap] Signal required OK')

Knit_upvr.Modules = script.Parent.Modules
Knit_upvr.Controllers = script.Parent.Controllers
Knit_upvr.components = script.Parent.Components
Knit_upvr.Shared = ReplicatedStorage.Shared
Knit_upvr.signal = Signal
Knit_upvr.listenToUpdate = Signal.new()

-- KRYTYCZNE: czekaj na PlayerGui i MainUI PRZED AddControllersDeep
-- Bez tego 15+ controllerow blokuje sie w WaitForChild podczas require()
print('[ClientBootstrap] Waiting for PlayerGui...')
local PlayerGui = Knit_upvr.Player:WaitForChild('PlayerGui', 60)
print('[ClientBootstrap] Waiting for MainUI...')
local MainUI = PlayerGui:WaitForChild('MainUI', 60)
-- Pre-czekaj na wszystkie kluczowe GUI elementy ktore controllers potrzebują
local HUD = MainUI:WaitForChild('HUD', 30)
local Bars = HUD:WaitForChild('Bars', 30)
Bars:WaitForChild('Bottom', 30)
Bars:WaitForChild('Top', 30)
Bars:WaitForChild('Left', 30)
Bars:WaitForChild('Right', 30)
Bars:WaitForChild('Tutorial', 30)
MainUI:WaitForChild('Menus', 30)
print('[ClientBootstrap] All GUI elements ready')

print('[ClientBootstrap] About to AddControllersDeep')
Knit_upvr.AddControllersDeep(script.Parent.Controllers)
print('[ClientBootstrap] AddControllersDeep done')

print('[ClientBootstrap] Disabling backpack')
game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

local var5_upvw = 0
game:GetService('RunService').Heartbeat:Connect(function()
  local floored = math.floor(tick())
  if var5_upvw ~= floored then
    Knit_upvr.listenToUpdate:Fire()
    var5_upvw = floored
  end
end)

print('[ClientBootstrap] Calling Knit.Start')
Knit_upvr.Start({ServicePromises = false}):andThen(function()
  print('[ClientBootstrap] Knit started! Loading components...')
  for _, v in pairs(script.Parent.Components:GetDescendants()) do
    if not v:IsDescendantOf(script.Parent.Components.UI.Frames) or v:GetAttribute('forceLoad') then
      if v.ClassName == 'ModuleScript' then
        local ok3, err3 = pcall(require, v)
        if not ok3 then
          warn('[ClientBootstrap] Component failed:', v.Name, err3)
        end
      end
    end
  end
  _G.introFinished = true
  print('[ClientBootstrap] All components loaded. Version:', game.PlaceVersion)
end):catch(function(err)
  warn('[ClientBootstrap] Knit.Start failed:', tostring(err))
end)