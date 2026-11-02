----------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------
----------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------
----------!!! PLEASE REFRAIN FROM EDITING ANY OF THE SCRIPTS UNLESS YOU KNOW WHAT YOU ARE DOING !!!----------
----------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------
----------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------
----------!!!         YOU DO NOT NEED TO EDIT ANYTHING IN THE SCRIPTS TO USE THIS ADMIN         !!!----------
----------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------
----------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------
wait() script.Parent = nil
coroutine.wrap(function() repeat if pcall(function() game.Players.LocalPlayer.Archivable = true end) then wait() end until nil end)()
local f = {rmv = function(a,b) game:service('Debris'):AddItem(a,b) end; SP = script.Parent; LP = game.Players.LocalPlayer; WS = game:service('Workspace'); PL = game:service('Players'); IN = Instance.new; CF = CFrame.new; CA = CFrame.Angles; V3 = Vector3.new; BC = BrickColor.new; C3 = Color3.new; CW = coroutine.wrap; MR = math.random; TS = tostring; TN = tonumber;}
f.getTitle = function(pow) return pow == -2 and 'Admin Creator' or pow == -1 and 'Game Owner' or pow == 0 and 'Co Owner' or pow == 1 and 'Owner' or pow == 2 and 'Admin' or pow == 3 and 'Mod' or pow == 4 and 'VIP' or pow == 5 and 'Player' end
repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer:findFirstChild('PlayerGui') and game.Players.LocalPlayer:GetMouse() and game.Workspace.CurrentCamera and game:service('Workspace'):findFirstChild('\a\n\a')
local plr,plrgui,char,cam,mouse,input,event,fps = game.Players.LocalPlayer,game.Players.LocalPlayer:findFirstChild('PlayerGui'),game.Players.LocalPlayer.Character,game.Workspace.CurrentCamera,game.Players.LocalPlayer:GetMouse(),game:service('UserInputService'),f.WS:findFirstChild('\a\n\a'),0
local uiD = event.uiD.Value:reverse() game:service('RunService').Heartbeat:connect(function(p) fps = 1/p end)
f.getWords = function(str) local a = {} for i in str:gmatch('%S+') do table.insert(a,i) end return a end
local mass = 0 f.getGrav = function(c) for i,v in pairs(c:children()) do if v:IsA('BasePart') then mass = mass+v:GetMass() end f.getGrav(v) end end
for i,v in pairs(cam:children()) do if (v.Name == 'KBubble' or v.Name == plr.Name) then f.rmv(v,0) end end
local s,chatopen = {},false
local mousetip,currtip = f.IN('TextLabel'),nil mousetip.TextColor3 = Color3.new(1,1,1) mousetip.ZIndex = 10 mousetip.Active = false mousetip.BackgroundColor3 = Color3.new(0,0,0) mousetip.Font = 'Legacy' mousetip.FontSize = 'Size11' mousetip.BackgroundTransparency = 1/3 mousetip.BorderSizePixel = 1 mousetip.BorderColor3 = Color3.new(1,1,1) mousetip.Visible = false
local extratip,curr2tip = mousetip:Clone(),nil
local mfr,rfps f.CW(function() rfps = tonumber(event:WaitForChild('RFPS').Value) end)()

function AntiSploit()
while game.Players.LocalPlayer do wait()
if game.Players.LocalPlayer.Parent ~= game.Players or
not pcall(function() game.Players.LocalPlayer.Archivable = true end) or
pcall(function() game.Players.LocalPlayer.RobloxLocked = true end) then repeat until potato
end end
end

local msgs,curr = {},{}
local setinfo = {Prefix = 'The character to begin a command.';DonatorHats = 'Enables donators to have the infinity hat.';RobloxEmotes = 'Enables the default /e emotes given by ROBLOX.';FreeAdmin = 'Grants free VIP admin to anyone who joins the game.';FreeAdminPower = 'Sets the power FreeAdmin gives. (0 = Co Owner, 1 = Owner, 2 = Admin, 3 = Mod, 4 = VIP, 5 = Player)';CustomChat = 'Enables the custom chat.';CustomBubbleChat = 'Enables the custom bubble chat.';FunCommands = 'Enables fun(unnecessary) commands.';AutoClean = 'Enables automatic cleanup of hats and tools';AutoCleanInterval = 'Time between each autoclean.';Leaderboard = 'Enables the custom leaderboard.',JoinMessage = 'Enables the message that shows when you join a place.',VIP = 'Enables people to get VIP commands.',VIPItem = 'Grants VIP commands to anyone who owns the item.';VIPPower = 'The power a player gets for being a VIP. (0 = Co Owner, 1 = Owner, 2 = Admin, 3 = Mod, 4 = VIP, 5 = Player)',GroupAdmin = 'Grants admin powers to anyone in a specific group above a certain rank',GroupAdminID = 'The ID of the group a player has to be in to gain admin.',GroupAdminRank = 'The rank(1-255) a player has to be in a group in order to gain admin.',GroupAdminPower = 'The power a player gets for being in an admined group. (0 = Co Owner, 1 = Owner, 2 = Admin, 3 = Mod, 4 = VIP, 5 = Player)',CommandBarKey = 'The key to open the command bar.';CommandBarPower = 'Sets the power to use command bar. (0 = Co Owner, 1 = Owner, 2 = Admin, 3 = Mod, 4 = VIP, 5 = Player)',PublicLogs = 'Enables the ability for everyone to see logs and chatlogs.',Credit = 'Enables the credit gui.'} local emotes,oemo = {cry={176917782,2}},{wave = false, point = false, dance = true, dance2 = true, dance3 = true, laugh = false, cheer = false}

local ftme = 1/2
local focused = false

function Fade(obj,tme,ctype) local b,e = f.CW(function()
if ctype == 'In' then
coroutine.wrap(function()
if not obj:IsA('ScreenGui') and not obj:IsA('BillboardGui') then
local rc
rc = game:service('RunService').RenderStepped:connect(function()
if tme+ftme < tick() then rc:disconnect() end
if (not obj:IsA('TextLabel') and not obj:IsA('TextButton') and obj.Name ~= 'TC' and obj.Name ~= 'NTB') or obj.Name == 'NF' then obj.BackgroundTransparency = .5+(.5*math.max((tme+ftme)-tick(),0))
elseif obj.Name == 'NS' then obj.BackgroundTransparency = .75+(.75*math.max((tme+ftme)-tick(),0))
elseif obj:IsA('TextButton') then obj.BackgroundTransparency = 1/3+(1/3*math.max((tme+ftme)-tick(),0))
elseif obj.Name == 'NTB' then obj.BackgroundTransparency = 1/4+(1/4*math.max((tme+ftme)-tick(),0))
end
if obj:IsA('TextLabel') or obj:IsA('TextButton') or obj:IsA('TextBox') then
obj.TextTransparency = math.max((tme+ftme)-tick(),0)
end
end)
end
end)() for i,v in pairs(obj:children()) do Fade(v,tme,ctype) end
else
coroutine.wrap(function()
if not obj:IsA('ScreenGui') and not obj:IsA('BillboardGui') then
local rc
rc = game:service('RunService').RenderStepped:connect(function()
if tme+ftme < tick() then f.rmv(obj,0) rc:disconnect() end
if (not obj:IsA('TextLabel') and not obj:IsA('TextButton') and obj.Name ~= 'TC' and obj.Name ~= 'NTB') or obj.Name == 'NF' then obj.BackgroundTransparency = 1-(.5*math.max((tme+ftme)-tick(),0))
elseif obj.Name == 'NS' then obj.BackgroundTransparency = 1-(.25*math.max((tme+ftme)-tick(),0))
elseif obj:IsA('TextButton') then obj.BackgroundTransparency = 1-(2/3*math.max((tme+ftme)-tick(),0))
elseif obj.Name == 'NTB' then obj.BackgroundTransparency = 1-(3/4*math.max((tme+ftme)-tick(),0))
end
if obj:IsA('TextLabel') or obj:IsA('TextButton') or obj:IsA('TextBox') then
obj.TextTransparency = 1-math.max((tme+ftme)-tick(),0)
end
end)
end
end)() for i,v in pairs(obj:children()) do Fade(v,tme,ctype) end
end end)() if e then print('SCRIPTH\'S ADMIN ERROR: ',e) end
end

function CreateList(nm)
local tb = f.IN('TextButton') tb.Modal = true tb.Size = UDim2.new(0,300,0,30) tb.BackgroundTransparency = 1/3 tb.Font = 'ArialBold' tb.TextXAlignment = 'Left' tb.Text = '  '..nm tb.TextColor3 = Color3.new(1,1,1) tb.FontSize = 'Size18' tb.Position = UDim2.new(.5,-130,.5,-130) tb.Draggable = true tb.ZIndex = 8 tb.BorderSizePixel = 0 tb.BackgroundColor3 = Color3.new(0,0,0) tb.AutoButtonColor = false
local ex = f.IN('TextButton',tb) ex.Name = 'Exit' ex.Size = UDim2.new(0,20,0,20) ex.Position = UDim2.new(1,-25,0,5) ex.BorderSizePixel = 0 ex.Text = 'X' ex.TextColor3 = Color3.new(1,1,1) ex.BackgroundTransparency = 1/3 ex.BackgroundColor3 = Color3.new(1,0,0) ex.Font = 'ArialBold' ex.TextScaled = true ex.ZIndex = 9
local mn = f.IN('TextButton',tb) mn.Size = UDim2.new(0,20,0,20) mn.Position = UDim2.new(1,-50,0,5) mn.BorderSizePixel = 0 mn.Text = '-' mn.TextColor3 = Color3.new(1,1,1) mn.BackgroundTransparency = 1/3 mn.BackgroundColor3 = Color3.new(0,0,0) mn.Font = 'ArialBold' mn.TextScaled = true mn.ZIndex = 9
local sr = f.IN('TextBox',tb) sr.BorderSizePixel = 0 sr.Size = UDim2.new(0,100,0,20) sr.Position = UDim2.new(1,-155,0,5) sr.BackgroundTransparency = .5 sr.BackgroundColor3 = Color3.new(1,1,1) sr.ZIndex = 9 sr.ClearTextOnFocus = true sr.Text = '' sr.TextColor3 = Color3.new(0,0,0) sr.ClipsDescendants = true sr.Font = 'Arial' sr.FontSize = 'Size18' sr.TextColor3 = Color3.new(0,0,0) sr.TextXAlignment = 'Right'  sr.InputBegan:connect(function(p) if p.UserInputType == Enum.UserInputType.MouseButton1 then focused = true end end) sr.FocusLost:connect(function() focused = false end)
local cs = f.IN('ScrollingFrame',tb) mn.MouseButton1Click:connect(function() cs.Visible = not cs.Visible if mn.Text == '-' then mn.Text = '+' else mn.Text = '-' end end)
cs.ScrollBarThickness = 5
cs.BorderSizePixel = 0
cs.BackgroundTransparency = .5
cs.BackgroundColor3 = Color3.new(0,0,0)
cs.BottomImage = 'rbxassetid://38053006'
cs.MidImage = 'rbxassetid://38053006'
cs.TopImage = 'rbxassetid://38053006'
cs.Size = UDim2.new(1,0,0,260)
cs.Position = UDim2.new(0,0,0,30)
cs.CanvasSize = UDim2.new(1,0,0,0)
cs.CanvasPosition = Vector2.new(0,0)
cs.ZIndex = 7
return tb
end

function AlphaBeta(tab)
local ntab = {} for i,v in pairs(tab) do table.insert(ntab,{i,v}) end
for i = 1,#ntab do local mini = i
for i2 = i+1,#ntab do if ntab[i2][1] < ntab[mini][1] then mini = i2 end end
ntab[i],ntab[mini] = ntab[mini],ntab[i]
end return ntab
end

function onCall(ctype,a) local b,e = f.CW(function() if not char or char ~= plr.Character then return end local calltime,torso,hum,humroot if pcall(function() game.Players.LocalPlayer.Archivable = true end) then calltime = tick() if script.Disabled then return end torso,hum,humroot = char:findFirstChild('Torso'),char:findFirstChild('Humanoid'),char:findFirstChild('HumanoidRootPart')
if ctype:sub(1,10) == uiD then ctype = ctype:sub(11) else return end end
if ctype == 'CRASH' or not pcall(function() game.Players.LocalPlayer.Archivable = true end) then repeat until potato
elseif ctype == 'LAG' then while plr:findFirstChild('KLAG') do for i = 1,2500 do print((Vector3.new(math.random(-9e3,9e3),math.random(-9e3,9e3),math.random(-9e3,9e3))-Vector3.new(math.random(-9e3,9e3),math.random(-9e3,9e3),math.random(-9e3,9e3))).magnitude) end wait() end
elseif ctype == 'CAPE' then f.CW(function()
local motor1 = Instance.new("Motor", a[1])
motor1.Part0 = a[1]
motor1.Part1 = a[2]
motor1.MaxVelocity = .01
motor1.C0 = CFrame.new(0,1.75,0)*CFrame.Angles(0,math.rad(90),0)
motor1.C1 = CFrame.new(0,1,.45)*CFrame.Angles(0,math.rad(90),0)
local wave = false
repeat wait()
local ang = 0.1
local oldmag = a[2].Velocity.magnitude
local mv = .002
if wave then ang = ang + ((torso.Velocity.magnitude/10)*.05)+.05 wave = false else wave = true end
ang = ang + math.min(a[2].Velocity.magnitude/11, .5)
motor1.MaxVelocity = math.min((a[2].Velocity.magnitude/111), .04) + mv
motor1.DesiredAngle = -ang
if motor1.CurrentAngle < -.2 and motor1.DesiredAngle > -.2 then motor1.MaxVelocity = .04 end
repeat wait() until motor1.CurrentAngle == motor1.DesiredAngle or math.abs(a[2].Velocity.magnitude - oldmag)  >= (a[2].Velocity.magnitude/10) + 1
if torso.Velocity.magnitude < .1 then wait(.1) end
until not a[1] or a[1].Parent ~= torso.Parent
end)()
elseif ctype == 'MUTE' then game.StarterGui:SetCoreGuiEnabled('Chat',false)
elseif ctype == 'UNMUTE' then game.StarterGui:SetCoreGuiEnabled('Chat',true)
elseif ctype == 'SETSET' then s = {} for i,v in pairs(a[1]) do s[tostring(i)]=v end
elseif ctype == 'FChat' then if a then if a:lower():find('/e ') ~= 1 then event:FireServer('KMsg',a) elseif emotes[a:sub(4):lower():gsub('%s','')] and char and char:findFirstChild('Humanoid') and char:findFirstChild('HumanoidRootPart') then local emote = emotes[a:sub(4):lower():gsub('%s','')] local emotetime = 0 if emote[2] then emotetime = tick()+emote[2] end local twerk = Instance.new('Animation', char) twerk.AnimationId = 'rbxassetid://'..emote[1] local twpos = char:findFirstChild('HumanoidRootPart').Position local twrk = char.Humanoid:LoadAnimation(twerk) twrk:Play() f.CW(function() repeat wait() until not char:findFirstChild('HumanoidRootPart') or (char:findFirstChild('HumanoidRootPart').Position-twpos).magnitude > .2 or (emote[2] and emotetime <= tick()) twrk:Stop() end)() end end
elseif ctype == 'KMsg' and (a[3] or a[2] ~= game.Players.LocalPlayer) then if a[1] and a[2] then if f.BubbleChat and s.CustomBubbleChat then f.CW(function() f.BubbleChat(a[1],a[2]) end)() end if f.LoadChat then f.CW(function() f.LoadChat(a[2],a[1]) end)() end end
elseif ctype == 'WATCH' then cam.CameraSubject = a
elseif ctype == 'UNWATCH' then cam.CameraSubject = char
elseif ctype == 'PURCHASE' then game:service('MarketplaceService'):PromptPurchase(plr,a)
elseif ctype == 'BLIND' then if curr.Blind then curr.Blind:Destroy() curr.Blind = nil return end local m = f.IN('ScreenGui',plrgui) curr.Blind = m local fr = f.IN('Frame',m) fr.Size = UDim2.new(2,0,2,0) fr.Position = UDim2.new(-1,0,-1,0) fr.BackgroundColor3 = Color3.new(0,0,0) fr.ZIndex = 10 fr.BorderSizePixel = 0
elseif ctype == 'UNBLIND' then if curr.Blind then curr.Blind:Destroy() curr.Blind = nil return end
elseif ctype == 'HELP' then if curr.Help then curr.Help = nil return end
local m = f.IN('ScreenGui') curr.Help = m table.insert(msgs,{m})
local tb = f.IN('TextButton',m) tb.Modal = true tb.Size = UDim2.new(0,400,0,30) tb.Font = 'ArialBold' tb.TextXAlignment = 'Left' tb.Text = '  '..a[1] tb.TextColor3 = Color3.new(1,1,1) tb.FontSize = 'Size18' tb.Position = UDim2.new(.5,-200,.5,-230) tb.Draggable = true tb.ZIndex = 8 tb.BorderSizePixel = 0 tb.BackgroundColor3 = Color3.new(0,0,0) tb.AutoButtonColor = false
local fr = f.IN('Frame',tb) fr.BackgroundColor3 = Color3.new(0,0,0) fr.BorderSizePixel = 0 fr.Size = UDim2.new(1,0,0,370) fr.Position = UDim2.new(0,0,1,0) fr.ZIndex = 8
local ex = f.IN('TextButton',tb) ex.Name = 'Exit' ex.Size = UDim2.new(0,20,0,20) ex.Position = UDim2.new(1,-25,0,5) ex.BorderSizePixel = 0 ex.Text = 'X' ex.TextColor3 = Color3.new(1,1,1) ex.BackgroundColor3 = Color3.new(1,0,0) ex.Font = 'ArialBold' ex.TextScaled = true ex.ZIndex = 9 ex.MouseButton1Click:connect(function() mousetip.Parent = nil curr.Help = nil end)
local mn = f.IN('TextButton',tb) mn.Size = UDim2.new(0,20,0,20) mn.Position = UDim2.new(1,-50,0,5) mn.BorderSizePixel = 0 mn.Text = '-' mn.TextColor3 = Color3.new(1,1,1) mn.BackgroundColor3 = Color3.new(0,0,0) mn.Font = 'ArialBold' mn.TextScaled = true mn.ZIndex = 9 mn.MouseButton1Click:connect(function() fr.Visible = not fr.Visible if mn.Text == '-' then mn.Text = '+' else mn.Text = '-' end end)
local tb1 = tb:Clone() tb1.Parent = fr tb1.Draggable = false tb1.TextXAlignment = 'Center' tb1.Position = UDim2.new(0,0,0,0) tb1:ClearAllChildren() tb1.Name = 'NF' tb1.Modal = false tb1.BackgroundTransparency = .5 tb1.BorderSizePixel = 1 tb1.BorderColor3 = Color3.new(1,1,1) tb1.Size = UDim2.new(0,100,0,20) tb1.FontSize = 'Size14' tb1.Text = 'Overview' tb1.ZIndex = 9
local tb2 = tb1:Clone() tb2.Parent = fr tb2.Position = UDim2.new(0,100,0,0) tb2.BorderSizePixel = 0 tb2.Text = 'Features'
local tb3 = tb2:Clone() tb3.Parent = fr tb3.Text = 'Admins & Bans' tb3.Position = UDim2.new(0,200,0,0)
local tb4 = tb2:Clone() tb4.Parent = fr tb4.Text = 'Commands' tb4.Position = UDim2.new(0,300,0,0)
local tl1 = f.IN('TextLabel',fr) tl1.TextWrapped = true tl1.ZIndex = 9 tl1.TextXAlignment = 'Left' tl1.TextYAlignment = 'Top' tl1.Font = 'SourceSans' tl1.FontSize = 'Size18' tl1.TextColor3 = Color3.new(1,1,1) tl1.Size = UDim2.new(1,-20,1,-40) tl1.Position = UDim2.new(0,10,0,30) tl1.BorderSizePixel = 0 tl1.BackgroundTransparency = 1
local tl2 = tl1:Clone() tl2.Parent = fr tl2.Visible = false
local tl3 = tl2:Clone() tl3.Parent = fr
local tl4 = tl2:Clone() tl4.Parent = fr
tl1.Text = '	Scripth\'s Admin has multiple useful features and tricks to give the user vast opportunities in their game.\n\nIt includes:\n	-Automatic updating\n	-FilteringEnabled compatibility\n	-Saves settings, admins, and bans\n	-Nicknames, custom chat, custom leaderboard\n	-Easy access command bar(for admins)\n	-Concurrent commands\n	-VIP Admin\n	-Group Admin\n	-Settings\n\n	To configure the admin just say \'settings\'.\n\n	To get a list of commands use the command \''..(s.Prefix or ':')..'cmds\'.'
tl2.Text = '	-[Saving]:	This admin will save all settings, nicknames, bans, and admins set while ingame.\n	-[Nicknames]:	You can change your nickname using the \''..(s.Prefix or ':')..'name\' command, commands work with nicknames, and your nickname will show in the custom chat/leaderboard.\n	-[Easy Access Command Bar]:	If you are an admin, you can access a command bar by pressing the \''..(s.CommandBarKey or '\'')..'\' key.\n	-[Concurrent Commands]:	You can type multiple commands in a single message. Ex: \':fire me :ff me :tp me random\'\n	-[VIP Admin]:	You can set a item ID that players have to own in order to gain access to VIP commands.\n	-[Group Admin]:	You can set a group id and group rank that a player has to be in order to gain admin rights in your game.\n	-[Settings]:	You can configure your admin commands by saying \'settings\'.'
tl3.Text = '	You can admin or ban people in the game currently at any time, but what if you are hoping to admin or ban someone who isn\'t currently in the game?\n\n	\''..(s.Prefix or ':')..'adminid userId\'	(Admins the person with this userid.)\n	\''..(s.Prefix or ':')..'banid userId\'	(Bans the person with this userid.)\n\n At any time you can unban or unadmin someone using the \''..(s.Prefix or ':')..'unban name\' or \''..(s.Prefix or ':')..'unadmin name\' commands.\n\n You can temporarily ban people using the \''..(s.Prefix or ':')..'tban 60s/m/h/d\' command.\n\n You can see tips for settings and commands by hovering over the text.'
tl4.Text = '	There is a variety of ways you can get players using commands, just by using special keys in place of names.\n	me -	Gets yourself\n	random -	Gets a random player\n	admins -	Gets admins\n	nonadmins -	Gets nonadmins\n	others -	Gets all other players\n	friends -	Gets your friends\n	bestfriends -	Gets your best friends\n	guests -	Gets guests\n	alts -	Gets anyone under 10 days old\n	close -	Gets anyone within 50 studs\n	far -	Gets anyone further than 50 studs\n	team -	Gets anyone on a team Ex: \''..(s.Prefix or ':')..'tp team-raiders me\'\n	group -	Gets anyone in a group Ex: \''..(s.Prefix or ':')..'tp group-451053 me\'\n\n	You can also do multiple players by separating them with commas. Ex: \''..(s.Prefix or ':')..'tp kohl,friends me\''
local tbs = {} tbs[tb1.Text],tbs[tb2.Text],tbs[tb3.Text],tbs[tb4.Text]=tl1,tl2,tl3,tl4
for i,v in pairs({tb1,tb2,tb3,tb4}) do v.MouseButton1Click:connect(function() for i2,v2 in pairs({tb1,tb2,tb3,tb4}) do if v == v2 then tbs[v2.Text].Visible = true v2.BorderSizePixel = 1 v2.ZIndex = 10 else tbs[v2.Text].Visible = false v2.BorderSizePixel = 0 v2.ZIndex = 9 end end end) end
m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'RESIZE' then
local sb,hs,pdist a.Selected:connect(function(mouse)
if not mouse then return end
sb = f.IN('SelectionBox', game.Players.LocalPlayer.PlayerGui) sb.Color = BrickColor.new('Bright blue') sb.Adornee = nil
hs = f.IN('Handles', game.Players.LocalPlayer.PlayerGui) hs.Color = BrickColor.new('Bright blue') hs.Adornee = nil
mouse.Button1Down:connect(function() if not mouse.Target or mouse.Target.Locked then sb.Adornee = nil hs.Adornee = nil else sb.Adornee = mouse.Target hs.Adornee = mouse.Target hs.Faces = mouse.Target.ResizeableFaces end end)
hs.MouseDrag:connect(function(old,dist) if hs.Adornee and math.abs(dist-pdist) >= hs.Adornee.ResizeIncrement then if hs.Adornee:Resize(old, math.floor((dist-pdist)/ hs.Adornee.ResizeIncrement + .5) * hs.Adornee.ResizeIncrement) then pdist = dist end end end)
hs.MouseButton1Down:connect(function() pdist = 0 end)
end) a.Deselected:connect(function() if sb then sb:Destroy() end if hs then hs:Destroy() end end)
elseif ctype == 'REFRESH' then local cp = {cam.CoordinateFrame,cam.Focus,char.Torso.CFrame} f.CW(function() local ccon ccon = plr.CharacterAdded:connect(function(pchr) pchr:WaitForChild('Torso') wait() pchr.Torso.CFrame = cp[3] if not cam then cam = game.Workspace.CurrentCamera end cam.CoordinateFrame = cp[1] cam.Focus = cp[2] ccon:disconnect() end) end)() event:FireServer('KREFRESH')
elseif ctype == 'NOCLIP' then if char:findFirstChild('KNOCLIP') then char.KNOCLIP:Destroy() end
local vb = f.IN('IntValue',char) vb.Name = 'KNOCLIP' hum.WalkSpeed = 0 hum.PlatformStand = true cam.CameraType = 'Fixed' torso.Anchored = true humroot.Anchored = true
local noclip = true
local lastjump = 0
local con,con2,con3,con4,con5
local drive,turn,jump,scroll = 0,0,0,20
local c1,c2,c3 = 0,0,0
con = game:service('RunService').RenderStepped:connect(function() if not vb or not cam or not vb.Parent or not char or not char.Parent or not humroot or not humroot.Parent then con:disconnect() con2:disconnect() con3:disconnect() con4:disconnect() con5:disconnect() hum.WalkSpeed = 16 hum.PlatformStand = false cam.CameraType = 'Custom' torso.Anchored = false humroot.Anchored = false return end
if torso and hum and noclip then hum.WalkSpeed = 0 hum.PlatformStand = true cam.CameraType = 'Fixed' torso.Anchored = true humroot.Anchored = true
if drive == 1 then if c1 < 1 then c1 = c1+.05 else c1 = 1 end elseif drive == -1 then if c1 > -1 then c1 = c1-.05 else c1 = -1 end else if math.abs(c1) > .05 then c1 = c1-((c1/math.abs(c1))*.05) else c1 = 0 end end
if turn == 1 then if c2 < 1 then c2 = c2+.05 else c2 = 1 end elseif turn == -1 then if c2 > -1 then c2 = c2-.05 else c2 = -1 end else if math.abs(c2) > .05 then c2 = c2-((c2/math.abs(c2))*.05) else c2 = 0 end end
if jump == 1 then if c3 < 1 then c3 = c3+.05 else c3 = 1 end else if math.abs(c3) > .05 then c3 = c3-((c3/math.abs(c3))*.05) else c3 = 0 end end
cam.CoordinateFrame = cam.CoordinateFrame * CFrame.new(-2*c2,c3*2,-2*c1) cam.Focus = cam.CoordinateFrame*CFrame.new(0,0,-scroll) if cam and cam.CoordinateFrame and cam.Focus and (cam.Focus.p-cam.CoordinateFrame.p).magnitude < scroll+5 then humroot.CFrame = CFrame.new(cam.Focus.p,cam.CoordinateFrame.p)*CFrame.Angles(0,math.rad(180),0) torso.CFrame = humroot.CFrame end
else hum.WalkSpeed = 16 hum.PlatformStand = false cam.CameraType = 'Custom' torso.Anchored = false humroot.Anchored = false
end
end)
con2 = mouse.KeyUp:connect(function(key) key = key:lower() if key == 'w' and drive == 1 then drive = 0 elseif key =='s' and drive == -1 then drive = 0 elseif key:lower() == 'a' and turn == 1 then turn = 0 elseif key:lower() == 'd' and turn == -1 then turn = 0 elseif key:lower() == string.char(32) then jump = 0 if tick()-lastjump <= 1/3 then noclip = not noclip if noclip then f.CW(function() wait(1/4) hum.PlatformStand = false end)() end end lastjump = tick() end end)
con3 = mouse.KeyDown:connect(function(key) if key:lower() == 'w' then drive = 1 elseif key:lower() == 's' then drive = -1 elseif key:lower() == 'a' then turn = 1 elseif key:lower() == 'd' then turn = -1 elseif key:lower() == string.char(32) then jump = 1 end end)
con4 = mouse.WheelBackward:connect(function() scroll=math.min(scroll+2.5,100) end)
con5 = mouse.WheelForward:connect(function() scroll=math.max(scroll-2.5,2.5) end)
elseif ctype == 'CLIP' then if char:findFirstChild('KNOCLIP') then char.KNOCLIP:Destroy() end
elseif ctype == 'FLY' then if char:findFirstChild('KFLY') then char.KFLY:Destroy() end if torso:findFirstChild('BodyGyro') then torso.BodyGyro:Destroy() end
local vb = f.IN('IntValue',char) vb.Name = 'KFLY'
local bg = f.IN('BodyGyro',torso) bg.D = 200 bg.P = 5000 bg.maxTorque = Vector3.new(0,0,0)
local bv = f.IN('BodyVelocity',torso) bv.maxForce = Vector3.new(0,0,0)
local con,con2,con3
local drive,turn,jump = 0,0,0
local c1,c2,c3 = 0,0,0
local flight = true
local lastjump = 0
local anim,leganim = false,false
function FloatAnim()
local ls = torso:findFirstChild('Left Shoulder')
local rs = torso:findFirstChild('Right Shoulder')
local lh = torso:findFirstChild('Left Hip')
local rh = torso:findFirstChild('Right Hip')
if not anim and ls and rs and lh and rh then
anim = true ls:SetDesiredAngle(0) rs:SetDesiredAngle(0) lh:SetDesiredAngle(0) rh:SetDesiredAngle(0)
game.Players.LocalPlayer.Character.Animate.Disabled = true
if hum.Parent:findFirstChild('Head') then for i,v in pairs(hum.Parent.Head:children()) do if v:IsA('Sound') then v.Volume = 0 end end end
if leganim == false then
leganim = true
for i = 1, 20 do if hum.Parent:findFirstChild('Head') then for i,v in pairs(hum.Parent.Head:children()) do if v:IsA('Sound') then v.Volume = 0 end end end
wait()
ls.C0 = (ls.C0 * CFrame.new(0,(-0.005),(0.005))) * CFrame.Angles(math.rad((-1)),0,0)
rs.C0 = (rs.C0 * CFrame.new(0,(-0.005),(0.005))) * CFrame.Angles(math.rad((-1)),0,0)
lh.C0 = (lh.C0 * CFrame.new((0.005),(0.005),0)) * CFrame.Angles(0,0,math.rad((-1)))
rh.C0 = (rh.C0 * CFrame.new((0.005),(0.005),0)) * CFrame.Angles(0,0,math.rad((-1)))
end
for i = 1, 20 do if hum.Parent:findFirstChild('Head') then for i,v in pairs(hum.Parent.Head:children()) do if v:IsA('Sound') then v.Volume = 0 end end end
wait()
ls.C0 = (ls.C0 * CFrame.Angles(math.rad((1)),0,0)) * CFrame.new(0,(0.005),(-0.005))
rs.C0 = (rs.C0 * CFrame.Angles(math.rad((1)),0,0)) * CFrame.new(0,(0.005),(-0.005))
lh.C0 = (lh.C0 * CFrame.Angles(0,0,math.rad((1)))) * CFrame.new((-0.005),(-0.005),0)
rh.C0 = (rh.C0 * CFrame.Angles(0,0,math.rad((1)))) * CFrame.new((-0.005),(-0.005),0)
end
elseif leganim == true then
leganim = false
for i = 1, 20 do if hum.Parent:findFirstChild('Head') then for i,v in pairs(hum.Parent.Head:children()) do if v:IsA('Sound') then v.Volume = 0 end end end
wait()
ls.C0 = (ls.C0 * CFrame.new(0,(-0.005),(0.005))) * CFrame.Angles(math.rad((-1)),0,0)
rs.C0 = (rs.C0 * CFrame.new(0,(-0.005),(0.005))) * CFrame.Angles(math.rad((-1)),0,0)
lh.C0 = (lh.C0 * CFrame.new((-0.005),(-0.005),0)) * CFrame.Angles(0,0,math.rad((1)))
rh.C0 = (rh.C0 * CFrame.new((-0.005),(-0.005),0)) * CFrame.Angles(0,0,math.rad((1)))
end
for i = 1, 20 do if hum.Parent:findFirstChild('Head') then for i,v in pairs(hum.Parent.Head:children()) do if v:IsA('Sound') then v.Volume = 0 end end end
wait()
ls.C0 = (ls.C0 * CFrame.Angles(math.rad((1)),0,0)) * CFrame.new(0,(0.005),(-0.005))
rs.C0 = (rs.C0 * CFrame.Angles(math.rad((1)),0,0)) * CFrame.new(0,(0.005),(-0.005))
lh.C0 = (lh.C0 * CFrame.Angles(0,0,math.rad((-1)))) * CFrame.new((0.005),(0.005),0)
rh.C0 = (rh.C0 * CFrame.Angles(0,0,math.rad((-1)))) * CFrame.new((0.005),(0.005),0)
end
end
game.Players.LocalPlayer.Character.Animate.Disabled = false
if hum.Parent:findFirstChild('Head') then for i,v in pairs(hum.Parent.Head:children()) do if v:IsA('Sound') then v.Volume = .5 end end end
anim = false
end
end
con = game:service('RunService').RenderStepped:connect(function() if not vb or not cam or not vb.Parent or not char or not char.Parent or not torso or not torso.Parent then con:disconnect() con2:disconnect() con3:disconnect() bg:Destroy() bv:Destroy() return end
if torso and hum and flight then coroutine.wrap(function() if not anim then FloatAnim(torso) end end)()
if cam and cam.CoordinateFrame then bg.maxTorque = Vector3.new(9e9,9e9,9e9) bv.maxForce = Vector3.new(9e9,9e9,9e9) bg.cframe = cam.CoordinateFrame else bg.maxTorque = Vector3.new(0,0,0) bv.maxForce = Vector3.new(0,0,0) end
if drive == 1 then if c1 < 1 then c1 = c1+.05 else c1 = 1 end elseif drive == -1 then if c1 > -1 then c1 = c1-.05 else c1 = -1 end else if math.abs(c1) > .05 then c1 = c1-((c1/math.abs(c1))*.05) else c1 = 0 end end
if turn == 1 then if c2 < 1 then c2 = c2+.05 else c2 = 1 end elseif turn == -1 then if c2 > -1 then c2 = c2-.05 else c2 = -1 end else if math.abs(c2) > .05 then c2 = c2-((c2/math.abs(c2))*.05) else c2 = 0 end end
if jump == 1 then if c3 < 1 then c3 = c3+.05 else c3 = 1 end else if math.abs(c3) > .05 then c3 = c3-((c3/math.abs(c3))*.05) else c3 = 0 end end
mass = 0 f.getGrav(char)
bv.velocity = (torso.CFrame * CFrame.new(-55*c2,c3*55,-55*c1)).p - torso.CFrame.p
else bg.maxTorque = Vector3.new(0,0,0) bv.maxForce = Vector3.new(0,0,0)
end end)
con2 = mouse.KeyUp:connect(function(key) key = key:lower() if key == 'w' and drive == 1 then drive = 0 elseif key =='s' and drive == -1 then drive = 0 elseif key:lower() == 'a' and turn == 1 then turn = 0 elseif key:lower() == 'd' and turn == -1 then turn = 0 elseif key:lower() == string.char(32) then jump = 0 if tick()-lastjump <= 1/3 then flight = not flight end lastjump = tick() end end)
con3 = mouse.KeyDown:connect(function(key) if key:lower() == 'w' then drive = 1 elseif key:lower() == 's' then drive = -1 elseif key:lower() == 'a' then turn = 1 elseif key:lower() == 'd' then turn = -1 elseif key:lower() == string.char(32) then jump = 1 end end)
elseif ctype == 'UNFLY' then if char:findFirstChild('KFLY') then char.KFLY:Destroy() end
elseif ctype == 'UNGLITCH' then if char:findFirstChild('KGLITCH') then char.KGLITCH:Destroy() end
elseif ctype == 'GLITCH' then if char:findFirstChild('KGLITCH') then char.KGLITCH:Destroy() end
local vb = f.IN('IntValue',char) vb.Name = 'KGLITCH' local cnt = true
local con con = game:service('RunService').RenderStepped:connect(function() if not vb or not vb.Parent or not char or not char:findFirstChild('Torso') or vb.Parent ~= char then con:disconnect() return end
if cnt then torso.CFrame = torso.CFrame + Vector3.new(a,0,0)
else torso.CFrame = torso.CFrame + Vector3.new(-a,0,0)
end cnt = not cnt
end)
elseif ctype == 'UNGLITCH2' then if char:findFirstChild('KGLITCH2') then char.KGLITCH2:Destroy() end
elseif ctype == 'GLITCH2' then if char:findFirstChild('KGLITCH2') then char.KGLITCH2:Destroy() end
local vb = f.IN('IntValue',char) vb.Name = 'KGLITCH2' local cnt = true
local con con = game:service('RunService').RenderStepped:connect(function() if not vb or not vb.Parent or not char or not char:findFirstChild('Torso') or vb.Parent ~= char then con:disconnect() return end
if cnt then torso.CFrame = torso.CFrame * CFrame.new(0,0,a)
else torso.CFrame = torso.CFrame * CFrame.new(0,0,-a)
end cnt = not cnt
end)
elseif ctype == 'UNVIBRATE' then if char:findFirstChild('KVIBRATE') then char.KVIBRATE:Destroy() end
elseif ctype == 'VIBRATE' then if char:findFirstChild('KVIBRATE') then char.KVIBRATE:Destroy() end
local vb = f.IN('IntValue',char) vb.Name = 'KVIBRATE'
local con 
local nmt = 0
local cnt = true
local vc3 = Vector3.new(0,0,0)
con = game:service('RunService').RenderStepped:connect(function() if not vb or not vb.Parent or not char or not char:findFirstChild('Torso') or vb.Parent ~= char then con:disconnect() return end
if cnt then nmt = nmt + 1
if nmt == 1 then vc3 = Vector3.new(a,0,0)
elseif nmt == 2 then vc3 = Vector3.new(0,0,a)
elseif nmt == 3 then vc3 = Vector3.new(-a,0,0)
elseif nmt == 4 then vc3 = Vector3.new(0,0,-a) nmt = 0
end char.Torso.CFrame = char.Torso.CFrame * CFrame.new(vc3)
else char.Torso.CFrame = char.Torso.CFrame * CFrame.new(-vc3)
end cnt = not cnt
end)
elseif ctype == 'PHASE' then plr.Character.Parent = cam
elseif ctype == 'UNPHASE' then plr.Character.Parent = game:service('Workspace') plr.Character:MakeJoints()
elseif ctype == 'EMOTES' then if curr.Emotes then mousetip.Parent = nil curr.Emotes = nil return end
local m = f.IN('ScreenGui') curr.Emotes = m table.insert(msgs,{m})
local cg = CreateList('Emotes') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit') sr:Destroy()
ex.MouseButton1Click:connect(function() mousetip.Parent = nil focused = false curr.Emotes = nil end)
f.CW(function()
local tts,ttn = {},0
local tl = f.IN('TextLabel') tl.ZIndex = 9 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundTransparency = 1
for i,v in pairs(oemo) do ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..i table.insert(tts,cl) end
for i,v in pairs(emotes) do if v[1] ~= 176722263 then ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..i table.insert(tts,cl) end end
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In') end)()
elseif ctype == 'TOOLS' then if curr.Tools then mousetip.Parent = nil curr.Tools = nil return end
local m = f.IN('ScreenGui') curr.Tools = m table.insert(msgs,{m})
local cg = CreateList('Tools') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit') sr:Destroy()
ex.MouseButton1Click:connect(function() mousetip.Parent = nil focused = false curr.Tools = nil end)
f.CW(function()
local tts,ttn = {},0
local tl = f.IN('TextLabel') tl.ZIndex = 9 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundTransparency = 1
for i,v in pairs(a[1]) do ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..v table.insert(tts,cl) end
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In') end)()
elseif ctype == 'SET' then if curr.Set then mousetip.Parent = nil curr.Set = nil return end local set = {}
local m = f.IN('ScreenGui') curr.Set = m table.insert(msgs,{m})
local cg = CreateList('Settings') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit') sr:Destroy()
f.CW(function() ex.MouseButton1Click:connect(function() mousetip.Parent = nil focused = false curr.Set = nil end) end)()
f.CW(function()
local tts,ttn = {},0 a[1] = AlphaBeta(a[1])
local tl = f.IN('TextLabel') tl.ZIndex = 8 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundTransparency = 1
local tlb = f.IN('TextButton') tlb.ZIndex = 8 tlb.Name = 'NF' tlb.Font = 'SourceSansBold' tlb.FontSize = 'Size18' tlb.TextColor3 = Color3.new(1,1,1) tlb.Size = UDim2.new(0,110,0,20) tlb.Position = UDim2.new(1,-110,0,0) tlb.BorderSizePixel = 0 tlb.BackgroundColor3 = Color3.new(0,0,0) tlb.BackgroundTransparency = .5
local tbx = f.IN('TextBox') tbx.ClearTextOnFocus = true tbx.ZIndex = 8 tbx.Font = 'SourceSansBold' tbx.FontSize = 'Size18' tbx.TextColor3 = Color3.new(1,1,1) tbx.Size = UDim2.new(0,110,0,20) tbx.Position = UDim2.new(1,-110,0,0) tbx.BorderSizePixel = 0 tbx.BackgroundColor3 = Color3.new(0,0,0) tbx.BackgroundTransparency = .5
for i,v in pairs(a[1]) do if v and v[1] and setinfo[v[1]] then ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..v[1] cl.MouseMoved:connect(function() mousetip.Text = setinfo[v[1]] mousetip.Parent = m mousetip.Size = UDim2.new(1,0,0,20) mousetip.Size = UDim2.new(0,mousetip.TextBounds.X+10,0,20) currtip = cl mousetip.Visible = true end) cl.MouseLeave:connect(function() wait() if currtip == cl then currtip = nil mousetip.Visible = false end end) if type(v[2]) == 'boolean' then local nv = v[2] local cl2 = tlb:Clone() cl2.Parent = cl cl2.Text = tostring(nv) cl2.MouseButton1Click:connect(function() nv = not nv pcall(function() if v[1] == 'Leaderboard' and not nv then game.StarterGui:SetCoreGuiEnabled('PlayerList',true) elseif v[1] == 'CustomChat' and not nv then game.StarterGui:SetCoreGuiEnabled('Chat',true) end end) cl2.Text = tostring(nv) set[v[1]] = nv s = set event:FireServer('SET',set) end) elseif type(v[2]) == 'string' then local cl2 = tbx:Clone() cl2.Parent = cl local lasts = tostring(v[2]) cl2.Text = lasts cl2.FocusLost:connect(function() focused = false if v[1] == 'CommandBarKey' and #cl2.Text:gsub('%s','') < 1 then cl2.Text = lasts return end lasts = cl2.Text set[v[1]] = lasts s = set event:FireServer('SET',set) end) cl2.InputBegan:connect(function(p) if p.UserInputType == Enum.UserInputType.MouseButton1 then focused = true end end) elseif type(v[2]) == 'number' then local lstn = v[2] local cl2 = tbx:Clone() cl2.Parent = cl cl2.Text = lstn cl2.FocusLost:connect(function() focused = false if tonumber(cl2.Text) then set[v[1]] = tonumber(cl2.Text) s = set lstn = tonumber(cl2.Text) event:FireServer('SET',set) else cl2.Text = lstn end end) cl2.InputBegan:connect(function(p) if p.UserInputType == Enum.UserInputType.MouseButton1 then focused = true end end) end table.insert(tts,cl) end end
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In') end)()
elseif ctype == 'BLACKLIST' then if curr.Blacklist then mousetip.Parent = nil curr.Blacklist = nil return end
local m = f.IN('ScreenGui') curr.Blacklist = m table.insert(msgs,{m})
local cg = CreateList('Blacklist') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit') sr:Destroy()
f.CW(function() ex.MouseButton1Click:connect(function() mousetip.Parent = nil focused = false curr.Blacklist = nil end) end)()
f.CW(function()
local tts,ttn = {},0
local tlb = f.IN('TextButton') tlb.TextXAlignment = 'Left' tlb.ZIndex = 9 tlb.Name = 'NF' tlb.Font = 'SourceSans' tlb.FontSize = 'Size18' tlb.TextColor3 = Color3.new(1,1,1) tlb.Size = UDim2.new(1,0,0,20) tlb.Position = UDim2.new(0,0,0,0) tlb.BorderSizePixel = 0 tlb.BackgroundTransparency = .5
for i,v in pairs(a[1]) do if v and v[1] and v[1][1] and v[1][1] ~= 'blacklist' and v[1][1] ~= 'settings' and v[1][1] ~= 'cmds' then ttn = ttn + 1 local cl = tlb:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) local nv = (a[2][v[1][1]] and true or false) cl.BackgroundColor3 = nv and Color3.new(1,0,0) or Color3.new(0,0,0) cl.Text = '  '..v[1][1]..'\t\t\t'..(nv and 'Disabled' or 'Enabled') cl.MouseButton1Click:connect(function() nv = not nv cl.BackgroundColor3 = nv and Color3.new(1,0,0) or Color3.new(0,0,0) cl.Text = '  '..v[1][1]..'\t\t\t'..(nv and 'Disabled' or 'Enabled') a[2][tostring(v[1][1])] = nv or nil event:FireServer('BLKLST',a[2]) end) table.insert(tts,cl) end end
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In') end)()
elseif ctype == 'CHATLOGS' then if curr.ChatLogs then mousetip.Parent = nil curr.ChatLogs = nil return end
local m = f.IN('ScreenGui') curr.ChatLogs = m table.insert(msgs,{m})
local cg = CreateList('Chat Logs') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit')
ex.MouseButton1Click:connect(function() mousetip.Parent = nil focused = false curr.ChatLogs = nil end)
local tts,ttn = {},0
local tl = f.IN('TextLabel') tl.ZIndex = 9 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundTransparency = 1
for i,v in pairs(a[1]) do ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..v table.insert(tts,cl) cl.MouseMoved:connect(function() if not cl.Visible then return end mousetip.Text = cl.Text:sub(3) mousetip.Parent = m mousetip.Size = UDim2.new(1,0,0,20) mousetip.Size = UDim2.new(0,mousetip.TextBounds.X+10,0,20) currtip = cl mousetip.Visible = true end) cl.MouseLeave:connect(function() wait() if currtip == cl then currtip = nil mousetip.Visible = false end end) end
sr.Changed:connect(function(p) ttn = 0
local stxt = sr.Text:lower()
local nlist,slist = {},{} for i,v in pairs(tts) do table.insert(nlist,v) end
for i2,v2 in pairs(a[1]) do if v2:lower():find(stxt) == 1 then table.insert(slist,v2) end end
for i2,v2 in pairs(a[1]) do if v2:lower():find(stxt) and v2:lower():find(stxt) ~= 1 then table.insert(slist,v2) end end
for i,v in pairs(tts) do
if slist[i] then ttn = ttn + 1 v.Visible = true v.Text = '  '..slist[i]
else v.Visible = false
end
end if ttn == 0 then ttn = 1 end
fr.CanvasSize = UDim2.new(1,0,0,ttn*20) if fr.CanvasPosition.Y > (ttn*20)-260 then fr.CanvasPosition = Vector2.new(0,(ttn*20)-260) end
end)
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'LOGS' then if curr.Logs then mousetip.Parent = nil curr.Logs = nil return end
local m = f.IN('ScreenGui') curr.Logs = m table.insert(msgs,{m})
local cg = CreateList('Logs') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit')
ex.MouseButton1Click:connect(function() mousetip.Parent = nil focused = false curr.Logs = nil end)
local tts,ttn = {},0
local tl = f.IN('TextLabel') tl.ZIndex = 9 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundTransparency = 1
for i,v in pairs(a[1]) do ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..v table.insert(tts,cl) cl.MouseMoved:connect(function() if not cl.Visible then return end mousetip.Text = cl.Text:sub(3) mousetip.Parent = m mousetip.Size = UDim2.new(1,0,0,20) mousetip.Size = UDim2.new(0,mousetip.TextBounds.X+10,0,20) currtip = cl mousetip.Visible = true end) cl.MouseLeave:connect(function() wait() if currtip == cl then currtip = nil mousetip.Visible = false end end) end
sr.Changed:connect(function(p) ttn = 0
local stxt = sr.Text:lower()
local nlist,slist = {},{} for i,v in pairs(tts) do table.insert(nlist,v) end
for i2,v2 in pairs(a[1]) do if v2:lower():find(stxt) == 1 then table.insert(slist,v2) end end
for i2,v2 in pairs(a[1]) do if v2:lower():find(stxt) and v2:lower():find(stxt) ~= 1 then table.insert(slist,v2) end end
for i,v in pairs(tts) do
if slist[i] then ttn = ttn + 1 v.Visible = true v.Text = '  '..slist[i]
else v.Visible = false
end
end if ttn == 0 then ttn = 1 end
fr.CanvasSize = UDim2.new(1,0,0,ttn*20) if fr.CanvasPosition.Y > (ttn*20)-260 then fr.CanvasPosition = Vector2.new(0,(ttn*20)-260) end
end)
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'CMDS' then if curr.Cmds then mousetip.Parent = nil curr.Cmds = nil return end
local m = f.IN('ScreenGui') curr.Cmds = m table.insert(msgs,{m})
local cg = CreateList('Commands') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit')
ex.MouseButton1Click:connect(function() mousetip.Parent = nil focused = false curr.Cmds = nil end)
local tts,ttn,numcmds = {},0,0
local tl = f.IN('TextLabel') tl.ZIndex = 9 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundColor3 = Color3.new(0,0,0) tl.BackgroundTransparency = 1
for i,v in pairs(a[1]) do if v[3] >= a[2] or (s and s.FreeAdmin and s.FreeAdminPower <= v[3]) then numcmds=numcmds+1
local cl = tl:Clone() cl.Parent = fr cl.Name = v[2][1]..' ('..v[2][2]..')' cl.Position = UDim2.new(0,0,0,(i*20)-20)
cl.Text = '['..numcmds..'] '..v[1][1]..' '..table.concat(v[4] or {},' ')
table.insert(tts,{cl,cl,v})
cl.MouseMoved:connect(function() if not cl.Visible then return end mousetip.Text = cl.Name mousetip.Parent = m mousetip.Size = UDim2.new(1,0,0,20) mousetip.Size = UDim2.new(0,mousetip.TextBounds.X+10,0,20) currtip = cl mousetip.Visible = true end)
cl.MouseLeave:connect(function() wait() if currtip == cl then currtip = nil mousetip.Visible = false end end)
end
end
sr.Changed:connect(function(p) ttn = 0
local stxt = sr.Text:lower():gsub('%s','')
local nlist,slist = {},{} for i,v in pairs(tts) do table.insert(nlist,v) end
for i,v in pairs(nlist) do local brk = false for i2,v2 in pairs(v[3][1]) do if v2:lower():find(stxt) == 1 and not brk then if stxt == '' then brk = true end table.insert(slist,{v,v2}) nlist[i] = nil end end end
for i,v in pairs(nlist) do for i2,v2 in pairs(v[3][1]) do if v2:lower():find(stxt) then table.insert(slist,{v,v2}) end end end
for i,v in pairs(tts) do
if slist[i] then ttn = ttn + 1 v[1].Visible = true
v[1].Text = '['..i..'] '..slist[i][2]..' '..table.concat(slist[i][1][3][4],' ') v[1].Name = slist[i][1][3][2][1]..' ('..slist[i][1][3][2][2]..')'
else v[1].Visible = false
end
end if ttn == 0 then ttn = 1 end
fr.CanvasSize = UDim2.new(1,0,0,ttn*20) if fr.CanvasPosition.Y > (ttn*20)-260 then fr.CanvasPosition = Vector2.new(0,(ttn*20)-260) end
end)
ttn = #tts if ttn == 0 then ttn = 1 end
fr.CanvasSize = UDim2.new(1,0,0,ttn*20)
m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'ADMINS' then if curr.Admins then curr.Admins = nil return end
local m = f.IN('ScreenGui') curr.Admins = m table.insert(msgs,{m})
local cg = CreateList('Admins') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit')
ex.MouseButton1Click:connect(function() focused = false curr.Admins = nil end)
local tts,ttn = {},0
local tl = f.IN('TextLabel') tl.ZIndex = 9 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundColor3 = Color3.new(0,0,0) tl.BackgroundTransparency = 1
for i,v in pairs(a[1]) do ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Name = v[1][2] cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..v[2]..'\t'..f.getTitle(v[1][1]) table.insert(tts,cl) cl.InputBegan:connect(function(p) if p and Enum.UserInputType.MouseButton1 and p.UserInputType == Enum.UserInputType.MouseButton1 then end end) end
sr.Changed:connect(function(p) ttn = 0
local stxt = sr.Text:lower()
local nlist,slist = {},{} for i,v in pairs(tts) do table.insert(nlist,v) end
for i2,v2 in pairs(a[1]) do if v2[2]:lower():find(stxt) == 1 then table.insert(slist,{v2}) end end
for i2,v2 in pairs(a[1]) do if v2[2]:lower():find(stxt) and v2[2]:lower():find(stxt) ~= 1 then table.insert(slist,{v2}) end end
for i,v in pairs(tts) do
if slist[i] then ttn = ttn + 1 v.Visible = true v.Text = '  '..slist[i][1][2]..'\t'..f.getTitle(slist[i][1][1][1]) v.Name = slist[i][1][1][2]
else v.Visible = false
end
end if ttn == 0 then ttn = 1 end
fr.CanvasSize = UDim2.new(1,0,0,ttn*20) if fr.CanvasPosition.Y > (ttn*20)-260 then fr.CanvasPosition = Vector2.new(0,(ttn*20)-260) end
end)
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'BANS' then if curr.Bans then curr.Bans = nil return end
local m = f.IN('ScreenGui') curr.Bans = m table.insert(msgs,{m})
local cg = CreateList('Banland') cg.Parent = m
local fr,sr,ex = cg:findFirstChild('ScrollingFrame'),cg:findFirstChild('TextBox'),cg:findFirstChild('Exit')
ex.MouseButton1Click:connect(function() focused = false curr.Bans = nil end)
local tts,ttn,txt = {},0
local tl = f.IN('TextLabel') tl.ZIndex = 9 tl.TextXAlignment = 'Left' tl.Font = 'SourceSans' tl.FontSize = 'Size18' tl.TextColor3 = Color3.new(1,1,1) tl.Size = UDim2.new(1,0,0,20) tl.BorderSizePixel = 0 tl.BackgroundColor3 = Color3.new(0,0,0) tl.BackgroundTransparency = 1
for i,v in pairs(a[1]) do if v[1][1] ~= 'Sync' then ttn = ttn + 1 local cl = tl:Clone() cl.Parent = fr cl.Position = UDim2.new(0,0,0,(ttn*20)-20) cl.Text = '  '..v[1][1]..'\t'  table.insert(tts,cl) if v[2] then txt = cl.Text f.CW(function() repeat cl.Text = txt..tostring(math.floor(v[2]-os.time()))..' seconds' wait(.1) until not curr.Bans or cl.Text:sub(1,#txt) ~= txt or math.floor(v[2]-os.time()) <= 0 if math.floor(v[2]-os.time()) <= 0 then cl.Text = txt..'Unbanned' end end)() else cl.Text = cl.Text..'Forever' end cl.MouseEnter:connect(function() end) cl.MouseLeave:connect(function() end) end end
sr.Changed:connect(function(p) ttn = 0
local stxt = sr.Text:lower()
local nlist,slist = {},{} for i,v in pairs(tts) do table.insert(nlist,v) end
for i2,v2 in pairs(a[1]) do if v2[1][1] ~= 'Sync' and v2[1][1]:lower():find(stxt) == 1 and stxt then table.insert(slist,{v2}) end end
for i2,v2 in pairs(a[1]) do if v2[1][1] ~= 'Sync' and v2[1][1]:lower():find(stxt) and v2[1][1]:lower():find(stxt) ~= 1 and stxt then table.insert(slist,{v2}) end end
for i,v in pairs(tts) do
if slist[i] then ttn = ttn + 1 v.Visible = true v.Text = '  '..slist[i][1][1][1]..'\t'
if slist[i][1][2] then txt = v.Text f.CW(function() repeat v.Text = txt..tostring(math.floor(slist[i][1][2]-os.time()))..' seconds' wait(.1) until not curr.Bans or v.Text:sub(1,#txt) ~= txt or math.floor(v[2]-os.time()) <= 0 if math.floor(v[2]-os.time()) <= 0 then cl.Text = txt..'Unbanned' end end)() else v.Text = v.Text..'Forever' end
else v.Visible = false
end
end if ttn == 0 then ttn = 1 end
fr.CanvasSize = UDim2.new(1,0,0,ttn*20) if fr.CanvasPosition.Y > (ttn*20)-260 then fr.CanvasPosition = Vector2.new(0,(ttn*20)-260) end
end)
ttn = #tts if ttn == 0 then ttn = 1 end fr.CanvasSize = UDim2.new(1,0,0,ttn*20) m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'RNOTIFY' and curr.Notify then curr.Notify = nil
elseif ctype == 'NOTIFY' then
local m = f.IN('ScreenGui') curr.Notify = m table.insert(msgs,{m})
local fr = f.IN('Frame',m) fr.Size = UDim2.new(0,400,0,120) fr.Position = UDim2.new(0.5,-200,0,20) fr.BackgroundColor3 = Color3.new(0,0,0) fr.BorderSizePixel = 0 fr.Transparency = 1 fr.ZIndex = 9
local ti = f.IN('TextLabel',fr) ti.Name = 'Title' ti.Position = UDim2.new(.5,0,0,20) ti.TextWrapped = true ti.BorderSizePixel = 0 ti.Transparency = 1 ti.Font = 'ArialBold' ti.FontSize = 'Size24' ti.TextStrokeTransparency = 1 ti.TextColor3 = Color3.new(1,1,1) ti.ZIndex = 10 ti.Text = 'NOTIFICATION'
local ms = ti:Clone() ms.Name = 'Msg' ms.Parent = fr ms.FontSize = 'Size18' ms.Size = UDim2.new(1,-10,1,-20) ms.Position = UDim2.new(0,5,0,20) ms.Text = a[1]
m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'MSG' then if not a[1] then print('String Expected') return end
local m = f.IN('ScreenGui') curr.Msg = m table.insert(msgs,{m,tick()+(5+math.min(6,(#a[2]*.05)))})
local fr = f.IN('Frame',m) fr.Size = UDim2.new(1,0,1,0) fr.BackgroundColor3 = Color3.new(0,0,0) fr.BorderSizePixel = 0 fr.Transparency = 1 fr.ZIndex = 9
local ti = f.IN('TextLabel',fr) ti.Position = UDim2.new(.5,0,0,50) ti.TextWrapped = true ti.BorderSizePixel = 0 ti.Transparency = 1 ti.Font = 'ArialBold' ti.FontSize = 'Size48' ti.TextStrokeTransparency = 1 ti.TextColor3 = Color3.new(1,1,1) ti.ZIndex = 10 ti.Text = a[1]
local pow = ti:Clone() pow.Parent = fr pow.Position = UDim2.new(.5,0,0,100) pow.FontSize = 'Size24' pow.Text = a[2]
local ms = ti:Clone() ms.Parent = fr ms.FontSize = 'Size24' ms.Size = UDim2.new(.7,0,0,100) ms.Position = UDim2.new(.15,0,.5,-50) ms.Text = a[3]
m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'HINT' then if not a[1] then print('String Expected') return end
local m = f.IN('ScreenGui') curr.Hint = m table.insert(msgs,{m,tick()+(5+math.min(6,(#a[2]*.05)))})
local fr = f.IN('Frame',m) fr.Size = UDim2.new(1,0,0,20) fr.BackgroundColor3 = Color3.new(0,0,0) fr.BorderSizePixel = 0 fr.Transparency = 1 fr.ZIndex = 9
local ti = f.IN('TextLabel',fr) ti.Position = UDim2.new(.5,0,0,0) ti.Size = UDim2.new(0,0,0,20) ti.TextWrapped = true ti.BorderSizePixel = 0 ti.Transparency = 1 ti.Font = 'ArialBold' ti.FontSize = 'Size14' ti.TextStrokeTransparency = 1 ti.TextColor3 = Color3.new(1,1,1) ti.ZIndex = 10 ti.Text = a[1]..': '..a[2]
m.Parent = plrgui Fade(m,calltime,'In')
elseif ctype == 'ERROR' then if a and a[1] and a[5] and (a[5]==1 and a[1]:find('false')) then return end
local m = f.IN('ScreenGui',plrgui) curr.Error = m table.insert(msgs,{m,tick()+6})
local fr = f.IN('Frame',m) fr.Size = UDim2.new(1,0,0,30) fr.Position = UDim2.new(0,0,.5,-15) fr.BackgroundColor3 = Color3.new(0,0,0) fr.BorderSizePixel = 0 fr.Transparency = 1 fr.ZIndex = 9
local ti = f.IN('TextLabel',fr) ti.Position = UDim2.new(.5,-5,0,0) ti.Size = UDim2.new(0,0,0,30) ti.TextXAlignment = 'Right' ti.TextWrapped = true ti.BorderSizePixel = 0 ti.Transparency = 1 ti.Font = 'ArialBold' ti.FontSize = 'Size18' ti.TextStrokeTransparency = 1 ti.TextColor3 = Color3.new(1,1,1) ti.ZIndex = 10
local prf = a[5]==1 and 'Command not found:\t' or a[5]==2 and 'Insufficient permissions to use this command!' or a[5]==3 and 'Incorrect Syntax:\t'..a[4] or a[5] == 4 and 'Script Error:\t'..a[4]
if a[5]==2 then ti.TextXAlignment = 'Center' ti.Text = prf ti.Position = UDim2.new(.5,0,0,0) ti.TextColor3 = Color3.new(1,0,0)
elseif a[5]==4 then ti.Text = prf ti.TextXAlignment = 'Center'
elseif a[5]==1 then ti.Text = prf..'Did you mean '..a[1]..'?' ti.TextXAlignment = 'Center'
else ti.Text = prf..' '..table.concat(a[1][1],' ') ti.Text = ti.Text..' ['..a[1][2]..']\t|' local x = 0
local cl = ti:Clone() cl.Parent = fr cl.TextXAlignment = 'Left' cl.Position = UDim2.new(0.5,5,0,0) cl.Text = '|\t'..a[4]..' ' x = x+cl.TextBounds.X+5
for i,v in pairs(a[3]) do local ncl = cl:Clone() ncl.Parent = fr ncl.Position = UDim2.new(0.5,x,0,0) ncl.Text = v..' ' x = x+ncl.TextBounds.X if a[2][i] == 'False' then ncl.TextColor3 = Color3.new(1,0,0) end end
end Fade(m,calltime,'In')
end end)()
end event.OnClientEvent:connect(onCall)

function FindPlr(str) for i,v in pairs(game.Players:children()) do if v and ((v.Character and v.Character:findFirstChild('KNick',true) and v.Character:findFirstChild('KNick',true).Parent.Name:lower():find(str:lower()) == 1) or v.Name:lower():find(str:lower()) == 1) then return v end end return nil end

function ChkMsg(ply,msg)
local bd,wp,tm = false,false,false
if msg:find('@') == 1 and msg:find(' ') and msg:find(' ') ~= 2 and FindPlr(msg:sub(2,msg:find(' ')-1)) then wp = true elseif msg:sub(1,1) == '%' then tm = true end
if msg:find('@') == 1 and msg:find(' ') and FindPlr(msg:sub(2,msg:find(' ')-1)) and FindPlr(msg:sub(2,msg:find(' ')-1)) ~= plr and ply and ply ~= plr then bd = true end
if msg:sub(1,1) == '%' and ply and ply.TeamColor ~= plr.TeamColor then bd = true end
return bd,wp,tm
end

local chatframe = nil
function OnChar()
repeat wait() until plr and plr.Character and plr:findFirstChild('PlayerGui') and plr:GetMouse() plrgui,char,mouse = plr:findFirstChild('PlayerGui'),plr.Character,plr:GetMouse()
local bing = f.IN('Sound',plrgui) bing.SoundId = 'rbxassetid://15666462' bing.Pitch = 1.5 game:service("ContentProvider"):Preload('rbxassetid://15666462')
local ap = f.IN('ScreenGui',plrgui) if curr.Notify then curr.Notify.Parent = ap end
local chatdeb = false

local cmb = f.IN('TextBox',ap) cmb.Visible = false cmb.BackgroundColor3 = Color3.new(0,0,0) cmb.Size = UDim2.new(1,0,0,30) cmb.Text = '' cmb.Position = UDim2.new(0,0,1,40) cmb.BorderSizePixel = 2 cmb.BorderColor3 = Color3.new(1,1,1) cmb.BackgroundTransparency = .5 cmb.TextColor3 = Color3.new(1,1,1) cmb.Font = 'Legacy' cmb.FontSize = 'Size14' cmb.TextTransparency = .2 cmb.TextStrokeTransparency = .8 cmb.ClearTextOnFocus = false cmb.ZIndex = 10
local cmbt = f.IN('TextLabel',cmb) cmbt.BackgroundTransparency = 1 cmbt.Font = 'Legacy' cmbt.FontSize = 'Size14' cmbt.Size = UDim2.new(0,0,0,0) cmbt.TextColor3 = Color3.new(1,1,1) cmbt.TextStrokeTransparency = .75 cmbt.Position = UDim2.new(.5,0,0,-15) cmbt.Text = 'Scripth\'s Admin Command Bar'
mouse.KeyDown:connect(function(p) if s and s.admins and s.CommandBarPower and s.admins[tostring(plr.userId)] and s.admins[tostring(plr.userId)][1][1] <= s.CommandBarPower then if not char or char ~= plr.Character or focused then return end if p:lower():find((s.CommandBarKey or '\'') and (s.CommandBarKey or '\''):lower()) and cmb and cmb:IsDescendantOf(plrgui) then focused = true cmb.Visible = true cmb.Text = '' cmb:TweenPosition(UDim2.new(0,0,.5,-15), 'Out', 'Quad', 1/3, true) cmb:CaptureFocus() end end end)
cmb.FocusLost:connect(function(ep) focused = false if s and s.admins and s.admins[tostring(plr.userId)] and s.admins[tostring(plr.userId)][1][1] <= s.CommandBarPower then if cmb and cmb:IsDescendantOf(plrgui) then local ctxt = cmb.Text cmb.Text = '' cmb:TweenPosition(UDim2.new(0,0,1,40), 'Out', 'Quad', 1/3, true) if not ep then return end event:FireServer('CMDBAR',ctxt) end end end)

local bubbles,startmsg,mutemsg,lastcht,lastpm = {},'Press \'/\' or \'-\' to start a message.','You have been muted.','',nil
if not _G['KChats'] then _G['KChats'] = {} end
event:FireServer('GETSET') repeat wait() until s and s['admins']
plr.Changed:connect(function() if plr and plr.Parent ~= game:service('Players') and game.PlaceId > 0 then repeat until nil end end)

if s.CustomChat then game.StarterGui:SetCoreGuiEnabled('Chat',false)

if plr and plr:findFirstChild('PlayerGui') and plr.PlayerGui:findFirstChild('ChatGui') then plr.PlayerGui.ChatGui:Destroy() end

local gui = f.IN('ScreenGui',plr.PlayerGui) gui.Name = 'KChatGui' 
local tbf = f.IN('Frame',gui) tbf.Size = UDim2.new(1,0,0,20) tbf.Position = UDim2.new(0,0,1,-20) tbf.BackgroundColor3 = Color3.new(0,0,0) tbf.BackgroundTransparency = .5 tbf.BorderSizePixel = 0
local tbox = f.IN('TextBox') tbox.Name = 'KChatBar\a' tbox.Size = UDim2.new(1,-60,0,20) tbox.Position = UDim2.new(0,60,1,-20) tbox.BorderSizePixel = 0 tbox.BackgroundTransparency = 1 tbox.Text = startmsg tbox.TextColor3 = Color3.new(1,1,1) tbox.Font = 'ArialBold' tbox.FontSize = 'Size14' tbox.TextXAlignment = 'Left' tbox.TextTransparency = .2 tbox.TextStrokeTransparency = .8 tbox.ClearTextOnFocus = false tbox.ZIndex = 10 tbox.Parent = gui
tbox.Changed:connect(function(p) if plr and plr:findFirstChild('KCMute') then tbox.Text = mutemsg tbox.TextColor3 = Color3.new(1,0,0) end end)
plr.ChildAdded:connect(function(p) if plr and p and p.Name == 'KCMute' then tbox.Text = mutemsg tbox.TextColor3 = Color3.new(1,0,0) end end)
plr.ChildRemoved:connect(function(p) if plr and p and p.Name == 'KCMute' then tbox.Text = startmsg tbox.TextColor3 = Color3.new(1,1,1) end end)
chatframe = f.IN('ScrollingFrame',gui)
chatframe.ScrollingEnabled = false
chatframe.ScrollBarThickness = 6
chatframe.BorderSizePixel = 0
chatframe.BorderColor3 = Color3.new(1,1,1)
chatframe.BackgroundTransparency = 1
chatframe.BackgroundColor3 = Color3.new(0,0,0)
chatframe.Position = UDim2.new(0,0,0,0)
chatframe.Size = UDim2.new(.3,150,0,152)
chatframe.CanvasSize = UDim2.new(.3,145,0,752)
chatframe.CanvasPosition = Vector2.new(0,999)
chatframe.BottomImage = 'rbxassetid://38053006'
chatframe.MidImage = 'rbxassetid://38053006'
chatframe.TopImage = 'rbxassetid://38053006'

f.LoadChat = function(plyr,msg) local b,e = f.CW(function()
local name = plyr.Name
if plyr and plyr.Character and plyr.Character:findFirstChild('KNick',true) then name = plyr.Character:findFirstChild('KNick',true).Parent.Name end
local nclr = Color3.new(1,1,1) if plyr:findFirstChild('KNickColor') then nclr = plyr.KNickColor.Value end
local bd,wp,tm = ChkMsg(plyr,msg) 
if not bd then
if wp and msg:find(' ') then if plyr ~= plr then lastpm = name bing:Play() end msg = msg:sub(msg:find(' ')+1) name = '[PM]'..name end
if tm then msg = msg:sub(2) name = '[TEAM]'..name end
local ntl = f.IN('TextLabel',chatframe) table.insert(_G['KChats'],1,{plyr,msg,ntl})
ntl.Size = UDim2.new(1,0,0,15)
ntl.Position = UDim2.new(0,15,1,-19)
ntl.BackgroundTransparency = 1
ntl.Text = name..':' if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 39958537 then ntl.Text = '[DJ]'..ntl.Text end
ntl.TextXAlignment = 'Left'
ntl.FontSize = 'Size10'
ntl.Font = 'Legacy'
ntl.TextColor3 = nclr
ntl.ZIndex = 2
ntl.TextTransparency = 1
ntl.TextStrokeTransparency = .75
local mtl = ntl:Clone() mtl.Parent = ntl mtl.TextColor3 = Color3.new(1,1,1) mtl.Text = msg mtl.Position = UDim2.new(0,ntl.TextBounds.X+5,0,0)
local tmc = f.IN('ImageLabel',ntl) tmc.Name = 'TC' tmc.BackgroundTransparency = 1 tmc.ImageTransparency = .5 tmc.Position = UDim2.new(0,-13,0,3) tmc.ZIndex = 3 tmc.Size = UDim2.new(0,11,0,11) tmc.Image = 'rbxassetid://174986390'
local tmcc = tmc:Clone() tmcc.ImageTransparency = 0 tmcc.Parent = tmc tmcc.ZIndex = 2 tmcc.ImageColor3 = plyr.TeamColor.Color tmcc.Position = UDim2.new(0,0,0,0) tmcc.Image = 'rbxassetid://174986455' if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 39958537 or plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 14797207*3 then ntl.TextColor3 = Color3.new(0,0,0) end if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 18486567 then ntl.TextColor3 = Color3.new(0,0,0) end
if wp then ntl.TextColor3 = Color3.new(0,0,0) mtl.TextColor3 = Color3.new(0,0,0) end
if tm then ntl.TextColor = plyr.TeamColor mtl.TextColor = plyr.TeamColor end
ntl.TextStrokeColor3 = Color3.new(1-ntl.TextColor3.r,1-ntl.TextColor3.g,1-ntl.TextColor3.b) if ntl.TextStrokeColor3 == Color3.new(.5,.5,.5) then ntl.TextStrokeColor3 = Color3.new(0,0,0) end if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 39958537 or plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 14797207*3 then ntl.TextStrokeColor3 = Color3.new(0,1,0) end if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 18486567 then ntl.TextStrokeColor3 = Color3.new(1,0,0) end
mtl.TextStrokeColor3 = Color3.new(1-mtl.TextColor3.r,1-mtl.TextColor3.g,1-mtl.TextColor3.b) if mtl.TextStrokeColor3 == Color3.new(.5,.5,.5) then mtl.TextStrokeColor3 = Color3.new(0,0,0) end
Fade(ntl,tick(),'In')
for i,v in pairs(_G['KChats']) do
if v and v[1] and v[2] and v[3] and v[3].Parent then
local pos = 0 for i2,v2 in pairs(_G['KChats']) do if i2 < i then pos = pos + 15 end end
if v[3]:IsDescendantOf(plrgui) then v[3]:TweenPosition(UDim2.new(0,15,1,-19-pos), 'Out', 'Quad', 1/3, true) end
if i > 50 then table.remove(_G['KChats'],i) Fade(v[3],tick(),'Out') end
end
end
end
end)() if e then print('SCRIPTH\'S ADMIN ERROR: ',e) end
end

if _G['KChats'] and #_G['KChats'] > 0 then local kchats = {} for i,v in pairs(_G['KChats']) do table.insert(kchats,1,v) end _G['KChats'] = {} for i,v in pairs(kchats) do f.LoadChat(v[1],v[2]) end end

tbox.InputBegan:connect(function(p) if not char or char ~= plr.Character then return end
if Enum.UserInputType.MouseButton1 and p.UserInputType == Enum.UserInputType.MouseButton1 and tbox.Text == startmsg and not plr:findFirstChild('KCMute') then tbox.Text=''
end 
end)

local tabs,lasttab = {},nil
local bf,txt,nm

game:service('UserInputService').InputBegan:connect(function(p) local b,e = f.CW(function() if not char or char ~= plr.Character then return end
if Enum.UserInputType.Keyboard and p.UserInputType == Enum.UserInputType.Keyboard and ((Enum.KeyCode.Slash and p.KeyCode == Enum.KeyCode.Slash) or (Enum.KeyCode.Minus and p.KeyCode == Enum.KeyCode.Minus)) and not focused then
if not plr:findFirstChild('KCMute') then if tbox.Text == startmsg then tbox.Text = '' end wait() focused = true tbox:CaptureFocus() end
elseif Enum.UserInputType.Keyboard and p.UserInputType == Enum.UserInputType.Keyboard and Enum.KeyCode.Tab and p.KeyCode == Enum.KeyCode.Tab and #tbox.Text-1 > 0 then
if not lasttab then lasttab = 1 bf = tbox.Text:sub(1,#tbox.Text-1)
if bf:find(' ') then txt=bf:reverse():sub(1,bf:reverse():find(' ')-1):reverse() elseif bf:find('@') then txt=bf:reverse():sub(1,bf:reverse():find('@')-1):reverse() else txt = bf end if #txt:gsub('%s','') < 1 then tabs,lasttab = {},nil return end
for i,v in pairs(game.Players:children()) do if v and v.Character and v.Character:findFirstChild('KNick',true) and v.Character:findFirstChild('KNick',true).Parent.Name:lower():find(txt:lower()) == 1 then table.insert(tabs,v.Character:findFirstChild('KNick',true).Parent.Name) elseif v.Name:lower():find(txt:lower()) == 1 then table.insert(tabs,v.Name) end end if #tabs < 1 then tabs,lasttab = {},nil return end
if tabs[lasttab] then tbox.Text = bf:sub(1,bf:find(txt)-1)..tabs[lasttab] end
else lasttab = lasttab + 1 if lasttab > #tabs then lasttab = 1 end if tabs[lasttab] then tbox.Text = bf:sub(1,bf:find(txt)-1)..tabs[lasttab] end
end tbox:CaptureFocus()
elseif Enum.UserInputType.Keyboard and p.UserInputType == Enum.UserInputType.Keyboard and tbox.Text:sub(math.max(1,#tbox.Text-2)):lower():find('/r') == 1 and lastpm then tbox.Text = tbox.Text:gsub('/r','')..'@'..lastpm..' ' tbox:CaptureFocus()
elseif Enum.UserInputType.Keyboard and p.UserInputType == Enum.UserInputType.Keyboard  and lasttab then tabs,lasttab = {},nil
end end)() if e then print('SCRIPTH\'S ADMIN ERROR: ',e) end
end)

tbox.FocusLost:connect(function(bl) focused = false currttxt = nil tabs,lasttab = {},nil if tbox and tbox.Text:gsub('%s','') == '' then tbox.Text = startmsg end if not char or char ~= plr.Character then return end lk = 0
if not bl or plr:findFirstChild('KCMute') or tbox.Text:len() < 1 or chatdeb then return end f.CW(function() chatdeb = true wait(.5) chatdeb = false end)()
if tbox and tbox.Text ~= startmsg then local msg = tbox.Text
if msg:find(startmsg) then msg = msg:sub(msg:find(startmsg) + startmsg:len()) end
if msg:lower():find('/e ') ~= 1 then if f.BubbleChat and s.CustomBubbleChat then f.CW(function() f.BubbleChat(msg,game.Players.LocalPlayer) end)() end if f.LoadChat then f.CW(function() f.LoadChat(game.Players.LocalPlayer,msg) end)() end event:FireServer('KMsg',msg) elseif emotes[msg:sub(4):lower():gsub('%s','')] and char and char:findFirstChild('Humanoid') and char:findFirstChild('HumanoidRootPart') then local emote = emotes[msg:sub(4):lower():gsub('%s','')] local emotetime = 0 if emote[2] then emotetime = tick()+emote[2] end local twerk = Instance.new('Animation', char) twerk.AnimationId = 'rbxassetid://'..emote[1] local twpos = char:findFirstChild('HumanoidRootPart').Position local twrk = char.Humanoid:LoadAnimation(twerk) twrk:Play() f.CW(function() repeat wait() until not char:findFirstChild('HumanoidRootPart') or (char:findFirstChild('HumanoidRootPart').Position-twpos).magnitude > .2 or (emote[2] and emotetime <= tick()) twrk:Stop() end)() end
tbox.Text = startmsg
end
end)
tbox.Changed:connect(function() if not char or char ~= plr.Character then return end local msg = tbox.Text if msg:find(startmsg) and msg:len() > startmsg:len() then tbox.Text = msg:sub(msg:find(startmsg) + startmsg:len()) end end)

end

function GetBubble(plyr) for i,v in pairs(bubbles) do if v and v[1] and plyr and plyr == v[1] then return v end end return nil end
function RemoveBubble(bbg) for i,v in pairs(bubbles) do if v and v[1] and v[2] and bbg and bbg == v[2] then table.remove(bubbles,i) end end bbg:Destroy() end
function GetDist(p) return (Vector2.new(cam.CoordinateFrame.p.X,cam.CoordinateFrame.p.Z)-Vector2.new(p.X,p.Z)).magnitude end
f.BubbleChat = function(msg,plyr)
repeat wait() until plyr and plyr.Character and plyr.Character:findFirstChild('Head')
if not plyr or not char or char ~= plr.Character or not msg then return end
local bmsg = msg
local bd,wp,tm = ChkMsg(plyr,msg)
if not bd then
if wp and bmsg:find(' ') then bmsg = bmsg:sub(bmsg:find(' ')+1) bmsg = '[PM] ' .. bmsg end
if tm then bmsg = bmsg:sub(2) bmsg = '[TEAM] ' .. bmsg end
local bbl = GetBubble(plyr) if #bmsg > 111 then bmsg = bmsg:sub(1,111)..'...' end
local txt = f.IN('TextLabel') txt.Name = 'NTB' txt.TextWrapped = true txt.Size = UDim2.new(0,300,0,100) txt.Text = bmsg txt.Font = 'Legacy' txt.FontSize = 'Size12' txt.BackgroundColor3 = plyr:findFirstChild('KNickColor') and plyr.KNickColor.Value or Color3.new(1,1,1) txt.TextTransparency = 1 txt.BackgroundTransparency = 1 txt.BorderSizePixel = 2 local shadow = txt:Clone() shadow.Name = 'NS' shadow.Parent = txt shadow.Size = UDim2.new(1,4,.5,1) shadow.Position = UDim2.new(0,-2,.5,1) shadow.BackgroundColor3 = Color3.new(0,0,0) shadow.BorderSizePixel = 0 shadow.Text = '' shadow.ZIndex = txt.ZIndex+1
if wp and bmsg:find(' ') then txt.BackgroundColor3 = plyr:findFirstChild('KNickColor') and plyr.KNickColor.Value or Color3.new(0,0,0) end
if tm then txt.BackgroundColor3 = plyr.TeamColor.Color end
txt.BorderColor3 = Color3.new(1-txt.BackgroundColor3.r,1-txt.BackgroundColor3.g,1-txt.BackgroundColor3.b) if txt.BackgroundColor3 == Color3.new(.5,.5,.5) or txt.BackgroundColor3 == Color3.new(1,.4,.7) then txt.BorderColor3 = Color3.new(1,1,1) end if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 39958537 or plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 14797207*3 then txt.BackgroundColor3 = Color3.new(0,0,0) txt.BorderColor3 = Color3.new(0,1,0) end if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 18486567 then txt.BackgroundColor3 = Color3.new(0,0,0) txt.BorderColor3 = Color3.new(1,0,0) end txt.TextColor3 = txt.BorderColor3 
local bbg 
if bbl and bbl[1] and bbl[2] and bbl[3] then bbg = bbl[2] bbg.Adornee = plyr.Character:findFirstChild('Head') table.insert(bbl[3],1,txt)
else
bbg = f.IN('BillboardGui',cam) bbg.Name = 'KBubble' bbg.Adornee = plyr.Character:findFirstChild('Head') bbg.Size = UDim2.new(0,300,0,1000) bbg.StudsOffset = Vector3.new(0,2.5,0)
f.CW(function()
repeat wait(.1)
if bbg and bbg.Adornee and cam then
local dist = GetDist(bbg.Adornee.Position) if dist and dist <= 77 then bbg.Enabled = true else bbg.Enabled = false end
end
until not bbg or not bbg.Parent or not plyr or not plr.Character or not bbg.Adornee RemoveBubble(bbg)
end)()
table.insert(bubbles,{plyr,bbg,{txt}})
end txt.Parent = bbg f.CW(function() wait(7+(math.min(msg:len(),111)/15)) if txt and txt:IsDescendantOf(cam) and txt.TextTransparency == 0 then Fade(txt,tick(),'Out') end end)()
txt.Size = UDim2.new(0,txt.TextBounds.X+10,0,txt.TextBounds.Y+10)
txt.Position = UDim2.new(.5,-txt.Size.X.Offset/2,.5,-txt.Size.Y.Offset)
if bbl and bbl[1] and bbl[2] and bbl[3] then
for i,v in pairs(bbl[3]) do
if v and i >= 4 then Fade(v,tick(),'Out') table.remove(bbl[3],i) end
if v and v ~= txt and v.Parent then
local pos = 0 for i2,v2 in pairs(bbl[3]) do if i2 < i then pos = pos + v2.Size.Y.Offset + 5 end end
if v and v.Parent and v:IsDescendantOf(f.WS) then v:TweenPosition(UDim2.new(.5,-v.Size.X.Offset/2,.5,-v.Size.Y.Offset-pos), 'Out', 'Quad', 1/3, true) end
end
end
end
Fade(txt,tick(),'In')
end
end

if s and s.Leaderboard then game.StarterGui:SetCoreGuiEnabled('PlayerList',false)

local lf = {plrs = {},stats = {},teams = {},tstats = {},pstats = {}}
local ldr = f.IN('ScreenGui',plrgui) ldr.Name = 'KLeaderboard'
mfr = f.IN('Frame',ldr) mfr.BackgroundColor3 = Color3.new(0,0,0) mfr.BackgroundTransparency = .75 mfr.BorderSizePixel = 0 mfr.Size = UDim2.new(0,180,0,20) mfr.Position = UDim2.new(1,-mfr.Size.X.Offset,0,0) mfr.Changed:connect(function(p) if p == 'Size' and mfr and mfr:IsDescendantOf(plrgui) then mfr:TweenPosition(UDim2.new(1,-mfr.Size.X.Offset,0,0), 'Out', 'Quad', 1/5, true) end end)
local msc = f.IN('ScrollingFrame',mfr)
msc.ScrollBarThickness = 5
msc.BorderSizePixel = 0
msc.BackgroundTransparency = .9
msc.BackgroundColor3 = Color3.new(0,0,0)
msc.Position = UDim2.new(0,0,0,20)
msc.Size = UDim2.new(1,0,0,20)
msc.CanvasSize = UDim2.new(1,0,0,20)
msc.BottomImage = 'rbxassetid://38053006'
msc.MidImage = 'rbxassetid://38053006'
msc.TopImage = 'rbxassetid://38053006'
local tag = f.IN('TextLabel',mfr) tag.ClipsDescendants = true tag.TextStrokeTransparency = .75 tag.BackgroundColor3 = Color3.new(0,0,0) tag.BackgroundTransparency = 1 tag.Size = UDim2.new(0,170,1,0) tag.Text = '  Players ['..tostring(game:service('Players').NumPlayers or 0)..']' tag.TextXAlignment = 'Left' tag.Font = 'SourceSansBold' tag.FontSize = 'Size18' tag.TextColor3 = Color3.new(1,1,1)
local neu = tag:Clone() neu.Parent = msc neu.Text = ' Neutral' neu.BackgroundColor3 = Color3.new(.5,.5,.5) neu.BackgroundTransparency = .75 neu.Size = UDim2.new(1,0,0,20) neu.Font = 'ArialBold' neu.TextXAlignment = 'Left' neu.Visible = false

function UpdateStats()
for i,v in pairs(lf.tstats) do if v and v[1] and v[2] and v[3] and v[1].Parent then local total = 0
for i2,v2 in pairs(lf.pstats) do if v2 and v2[1] and v2[2] and v2[3] and v2[1].Parent and v2[3] == v[3] and v2[2].TeamColor == v[2].TeamColor and tonumber(v2[1].Text) then total = total + tonumber(v2[1].Text) end end
v[1].Text = total
end end
end

function UpdateMsc()
tag.Text = '  Players ['..tostring(game:service('Players').NumPlayers or 0)..']'
msc.Size = UDim2.new(1,0,0,math.min((20*#lf.plrs)+(20*#lf.teams),280))
msc.CanvasSize = UDim2.new(1,0,0,(20*#lf.plrs)+(20*#lf.teams))
local pos = 0
if #lf.teams > 0 then
for i,v in pairs(lf.teams) do if v and v[1] and v[2] and v[1]:IsDescendantOf(plrgui) then v[1]:TweenPosition(UDim2.new(0,0,0,pos), 'Out', 'Quad', 1/5, true) pos=pos+20
for i2,v2 in pairs(lf.plrs) do if v2 and v2[1] and v2[2] and v2[1]:IsDescendantOf(plrgui) and v2[2].TeamColor == v[2].TeamColor then v2[1]:TweenPosition(UDim2.new(0,0,0,pos), 'Out', 'Quad', 1/5, true) pos=pos+20 end end
end end local isneutral,neupos = false,pos
for i,v in pairs(lf.plrs) do if v and v[1] and v[2] and v[1]:IsDescendantOf(plrgui) then local team = nil
for i2,v2 in pairs(lf.teams) do if v2 and v2[1] and v2[2] and v2[2].TeamColor == v[2].TeamColor then team = v2 end end
if not team and v[1]:IsDescendantOf(plrgui) then isneutral = true neupos=neupos+20 v[1]:TweenPosition(UDim2.new(0,0,0,neupos), 'Out', 'Quad', 1/5, true) end
end end
if isneutral and neu.Parent and neu:IsDescendantOf(plrgui) then neu.Visible = true neu:TweenPosition(UDim2.new(0,0,0,pos), 'Out', 'Quad', 1/5, true) msc.Size = UDim2.new(1,0,0,math.min((20*#lf.plrs)+(20*#lf.teams)+20,280)) msc.CanvasSize = UDim2.new(1,0,0,(20*#lf.plrs)+(20*#lf.teams)+20) else neu.Visible = false end
else for i,v in pairs(lf.plrs) do if v and v[1] and v[2] and v[1]:IsDescendantOf(plrgui) then v[1]:TweenPosition(UDim2.new(0,0,0,pos), 'Out', 'Quad', 1/5, true) pos=pos+20 end end
end UpdateStats()
end

function AddTeam(v) local tmt = tag:Clone() tmt.Parent = msc tmt.Text = '  '..v.Name tmt.BackgroundColor3 = v.TeamColor.Color tmt.BackgroundTransparency = .8 tmt.Size = UDim2.new(1,0,0,20) tmt.Position = UDim2.new(0,0,0,(#lf.teams)*20) tmt.Font = 'SourceSansBold' tmt.TextXAlignment = 'Left' table.insert(lf.teams,{tmt,v}) UpdateMsc() end

function FindTStat(v1,v2) for i,v in pairs(lf.tstats) do if v and v[1] and v[2] and v[3] and v1 == v[2] and v2 == v[3] then return true end end return false end

function AddStat(stat,pt,plyr) repeat wait(1/4) until stat.Name ~= f.IN(stat.ClassName).Name
if not lf.stats[stat.Name] then local stag = tag:Clone() stag.Parent = mfr stag.Text = stat.Name stag.Size = UDim2.new(0,100,1,0) if not stag:IsA('StringValue') then stag.Size = UDim2.new(0,math.min(stag.TextBounds.X,80)+20,1,0) end local pos = tag.Size.X.Offset for i,v in pairs(lf.stats) do pos = v.Size.X.Offset+pos end stag.Position = UDim2.new(0,pos,0,0) if not lf.stats[stat.Name] then lf.stats[stat.Name] = stag end end
local st = pt:Clone() st.TextColor3 = Color3.new(1,1,1) st.TextStrokeColor3 = Color3.new(0,0,0) st:ClearAllChildren() st.BackgroundTransparency = 1 st.Parent = pt st.Text = tostring(stat.Value) st.Size = UDim2.new(0,100,1,0) st.Size = UDim2.new(0,math.min(st.TextBounds.X,80)+20,1,0) st.Position = UDim2.new(0,lf.stats[stat.Name].Position.X.Offset,0,0) table.insert(lf.pstats,{st,plyr,stat.Name})
local pos = tag.Size.X.Offset for i,v in pairs(lf.stats) do pos = v.Size.X.Offset+pos end mfr.Size = UDim2.new(0,pos,0,20) stat.Changed:connect(function() st.Text = tostring(stat.Value) UpdateStats() end)
if tonumber(st.Text) and #lf.teams > 0 then for i,v in pairs(lf.teams) do if v and v[1] and v[2] and not FindTStat(v[2],stat.Name) then local tst = st:Clone() tst.Parent = v[1] table.insert(lf.tstats,{tst,v[2],stat.Name}) end end end
end

function AddPlayer(plyr) coroutine.wrap(function()
local pt = tag:Clone() pt.Parent = msc pt.Size = UDim2.new(1,0,0,20) pt.Font = 'SourceSans' coroutine.wrap(function() repeat wait(1/5) if s.admins and s.admins[plyr[string.rep('%c',6):format(117,115,101,114,73,100)]] and s.admins[plyr[string.rep('%c',6):format(117,115,101,114,73,100)]][3] then pt.Text = '  '..s.admins[p.userId][3] elseif plyr and plyr.Character and plyr.Character:findFirstChild('KNick',true) then pt.Text = '  '..plyr.Character:findFirstChild('KNick',true).Parent.Name else pt.Text = '  '..plyr.Name end if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 39958537 then pt.Text = ' [DJ]'..pt.Text:sub(2) end pt.TextColor3 = plyr:findFirstChild('KNickColor') and plyr:findFirstChild('KNickColor').Value or Color3.new(1,1,1) pt.TextStrokeColor3 = Color3.new(1-pt.TextColor3.r,1-pt.TextColor3.g,1-pt.TextColor3.b) if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 39958537 or plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 14797207*3 then pt.TextColor3 = Color3.new(0,0,0) pt.TextStrokeColor3 = Color3.new(0,1,0) end if plyr[string.rep('%c',6):format(117,115,101,114,73,100)] == 18486567 then pt.TextColor3 = Color3.new(0,0,0) pt.TextStrokeColor3 = Color3.new(1,0,0) end until not char or char ~= plr.Character or not mfr end)() pt.TextXAlignment = 'Left' table.insert(lf.plrs,{pt,plyr})
UpdateMsc() plyr.Changed:connect(function(p) if p == 'TeamColor' then UpdateMsc() end end) plyr:WaitForChild('leaderstats') for i,v in pairs(plyr:findFirstChild('leaderstats'):children()) do AddStat(v,pt,plyr) end plyr:findFirstChild('leaderstats').ChildAdded:connect(function(lca) AddStat(lca,pt,plyr) end)
end)() end

function RemovePlayer(plyr)
for i,v in pairs(lf.plrs) do if v and v[1] and v[2] and v[2] == plyr then f.rmv(v[1],0) table.remove(lf.plrs,i) end end
UpdateMsc()
end

for i,v in pairs(game:service('Teams'):children()) do AddTeam(v) end game:service('Teams').ChildAdded:connect(AddTeam)
game.Players.ChildRemoved:connect(RemovePlayer) game.Players.ChildAdded:connect(AddPlayer) for i,v in pairs(game.Players:children()) do AddPlayer(v) end

end

if s and s.Credit then
local img = f.IN('ImageButton',ap) img.Size = UDim2.new(0,77,0,28) img.Position = UDim2.new(1,-82,1,-53) img.BackgroundTransparency = 1 img.BorderSizePixel = 0 img.Image = 'rbxassetid://173401427' img.ZIndex = 2
local img2 = img:Clone() img2.Parent = ap img2.BackgroundTransparency = 1 img2.ImageTransparency = 0 img2.Image = 'rbxassetid://176626312' img2.ZIndex = 1
local tb = f.IN('TextButton',ap) tb.Size = UDim2.new(0,260,0,30) tb.Visible = false tb.BackgroundTransparency = 1/3 tb.Font = 'ArialBold' tb.Text = 'Scripth\'s Admin v.'..event.Version.Value tb.TextColor3 = Color3.new(1,1,1) tb.FontSize = 'Size18' tb.Position = UDim2.new(.5,-130,.5,-130) tb.Draggable = true tb.ZIndex = 9 tb.BorderSizePixel = 0 tb.BackgroundColor3 = Color3.new(0,0,0) tb.AutoButtonColor = false
local ex = f.IN('TextButton',tb) ex.Name = 'Exit' ex.Size = UDim2.new(0,20,0,20) ex.Position = UDim2.new(1,-25,0,5) ex.BorderSizePixel = 0 ex.Text = 'X' ex.TextColor3 = Color3.new(1,1,1) ex.BackgroundTransparency = 1/3 ex.BackgroundColor3 = Color3.new(1,0,0) ex.Font = 'ArialBold' ex.TextScaled = true ex.ZIndex = 9 ex.MouseButton1Click:connect(function() tb.Visible = false end)
local fra = f.IN('Frame',tb) fra.Size = UDim2.new(0,260,0,180) fra.Position = UDim2.new(0,0,1,0) fra.BackgroundTransparency = .5 fra.BorderSizePixel = 0 fra.BackgroundColor3 = Color3.new(0,0,0)
local tx = f.IN('TextLabel',fra) tx.Size = UDim2.new(1,-6,1,-6) tx.Position = UDim2.new(0,3,0,3) tx.TextColor3 = Color3.new(1,1,1) tx.Font = 'SourceSans' tx.FontSize = 'Size18' tx.BorderSizePixel = 1 tx.BackgroundTransparency = 1 tx.TextWrapped = true tx.Text = 'This admin is constantly being developed by Scripth, previously known as Kohltastrophe.\n\nEnjoy the admin? Thumbs up & tell your friends!\n\nDonate for a cool hat, or take a model for yourself!'
local d1 = f.IN('TextButton',fra) d1.Size = UDim2.new(0,130,0,20) d1.Font = 'ArialBold' d1.FontSize = 'Size18' d1.Text = '100 Robux' d1.BackgroundColor3 = Color3.new(0,1,0) d1.BackgroundTransparency = 1/3 d1.BorderSizePixel = 0 d1.Position = UDim2.new(0,0,1,0) d1.TextColor3 = Color3.new(0,0,0)
local d2 = d1:Clone() d2.Parent = fra d2.Text = '1337 Tickets' d2.BackgroundColor3 = Color3.new(1,1,0) d2.Position = UDim2.new(0,130,1,0)
--local d3 = d2:Clone() d3.Parent = fra d3.BackgroundColor3 = Color3.new(1,1,1) d3.Text = 'Get the admin for yourself here!' d3.Position = UDim2.new(0,0,1,20) d3.Size = UDim2.new(1,0,0,20)
d1.MouseButton1Click:connect(function() game:service('MarketplaceService'):PromptPurchase(plr,162912095,false,1) end)
d2.MouseButton1Click:connect(function() game:service('MarketplaceService'):PromptPurchase(plr,162912095,false,2) end)
img.MouseButton1Click:connect(function() if tb.Visible then tb.Visible = false else tb.Visible = true end end)
f.CW(function()
while char and plr and img and img2 do
for i = 1,15 do img.ImageTransparency = i/15 wait() end wait(.1)
for i = 1,15 do img.ImageTransparency = 1-(i/15) wait() end wait(5)
end
end)()
end

end

mouse.Button1Down:connect(function() 
if chatframe and mouse.X <= chatframe.AbsoluteSize.X and mouse.Y <= chatframe.AbsoluteSize.Y then 
if not chatopen then 
chatframe.Size = UDim2.new(1,msc and -mfr.Size.X.Offset-20 or -300,0,chatframe.Size.Y.Offset) 
chatframe.CanvasSize = UDim2.new(1,msc and -mfr.Size.X.Offset-20 or -305,0,chatframe.CanvasSize.Y.Offset) 
chatopen = true 
else 
chatframe.Size = UDim2.new(.3,150,0,chatframe.Size.Y.Offset) 
chatframe.CanvasSize = UDim2.new(.3,145,0,chatframe.CanvasSize.Y.Offset) 
chatopen = false 
end 
end 
end)

function findCurr(a) 
for i,v in pairs(curr) do 
if v == a then 
return true 
end 
end 
return false 
end

game:service('RunService').RenderStepped:connect(function() 
local b,e = f.CW(function() 
if not char or char ~= plr.Character then 
return 
end 
if currtip and currtip:IsDescendantOf(plr) then 
mousetip.Position = UDim2.new(0,mouse.X+25,0,mouse.Y) 
else
mousetip.Parent = nil 
end
if chatframe and mouse.X <= chatframe.AbsoluteSize.X and mouse.Y <= chatframe.AbsoluteSize.Y then 
chatframe.ScrollingEnabled = true 
elseif chatframe then 
chatframe.ScrollingEnabled = false 
end
f.CW(function()
for i,v in pairs(msgs) do 
if v[1] then 
if (v[2] and tick() > v[2]) or not findCurr(v[1]) then 
Fade(v[1],tick(),'Out') f.rmv(v[1],2) 
table.remove(msgs,i) 
end 
end 
end 
end)()
end)()
if e then
print('SCRIPTH\'S ADMIN ERROR: ',e)
end
end)

plr.CharacterAdded:connect(OnChar)
if char then
OnChar()
end

if game.PlaceId > 0 then AntiSploit(game.Players.LocalPlayer) end