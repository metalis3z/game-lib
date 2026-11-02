local ADMIN_USER_ID = 0
local Players        = game:GetService("Players")
local RS             = game:GetService("ReplicatedStorage")
local TweenService   = game:GetService("TweenService")
local UIS            = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
if LocalPlayer.UserId ~= ADMIN_USER_ID then return end

local Remote = RS:WaitForChild("AdminAnimalPanelRemote", 15)
if not Remote then print("[AdminPanel] Remote introuvable!") return end
print("[AdminPanel] Pret pour", LocalPlayer.Name)

local RARITY_COLOR = {
	OG     = Color3.fromRGB(255, 80,  80),
	Secret = Color3.fromRGB(255, 220, 50),
}
local MUT_COLOR = {
	Gold=Color3.fromRGB(255,195,50), Diamond=Color3.fromRGB(100,220,255),
	Lava=Color3.fromRGB(255,100,50), YinYang=Color3.fromRGB(210,210,210),
	Bloodrot=Color3.fromRGB(200,50,50), Rainbow=Color3.fromRGB(180,100,255),
	Candy=Color3.fromRGB(255,130,200), Galaxy=Color3.fromRGB(100,80,200),
	Radioactive=Color3.fromRGB(150,255,80), Cursed=Color3.fromRGB(150,50,200),
	Divine=Color3.fromRGB(255,220,100), None=Color3.fromRGB(160,160,160),
}
local function mutColor(m) return MUT_COLOR[m] or MUT_COLOR.None end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name="AdminAnimalPanel"; ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; ScreenGui.IgnoreGuiInset=true
ScreenGui.Parent=LocalPlayer.PlayerGui

local Win = Instance.new("Frame")
Win.Name="Win"; Win.Size=UDim2.new(0,860,0,580)
Win.Position=UDim2.new(0.5,-430,0.5,-290); Win.BackgroundColor3=Color3.fromRGB(14,16,22)
Win.BorderSizePixel=0; Win.Visible=false; Win.ZIndex=10; Win.Parent=ScreenGui
Instance.new("UICorner",Win).CornerRadius=UDim.new(0,14)
local ws=Instance.new("UIStroke",Win); ws.Color=Color3.fromRGB(50,55,75); ws.Thickness=1.5

local dragging, dragInput, dragStart, startPos
local function updateDrag(i)
	local d=i.Position-dragStart
	Win.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
end

local Header=Instance.new("Frame"); Header.Size=UDim2.new(1,0,0,52)
Header.BackgroundColor3=Color3.fromRGB(20,23,32); Header.BorderSizePixel=0; Header.ZIndex=11; Header.Parent=Win
Instance.new("UICorner",Header).CornerRadius=UDim.new(0,14)
local hfix=Instance.new("Frame",Header); hfix.Size=UDim2.new(1,0,0.5,0); hfix.Position=UDim2.new(0,0,0.5,0)
hfix.BackgroundColor3=Color3.fromRGB(20,23,32); hfix.BorderSizePixel=0; hfix.ZIndex=11

local TitleLbl=Instance.new("TextLabel",Header)
TitleLbl.Size=UDim2.new(1,-120,1,0); TitleLbl.Position=UDim2.new(0,18,0,0)
TitleLbl.BackgroundTransparency=1; TitleLbl.Text="🔍  ADMIN RARITY SCANNER"
TitleLbl.TextColor3=Color3.fromRGB(60,220,130); TitleLbl.TextSize=18
TitleLbl.Font=Enum.Font.GothamBold; TitleLbl.TextXAlignment=Enum.TextXAlignment.Left; TitleLbl.ZIndex=12

local CloseBtn=Instance.new("TextButton",Header)
CloseBtn.Size=UDim2.new(0,32,0,32); CloseBtn.Position=UDim2.new(1,-42,0.5,-16)
CloseBtn.BackgroundColor3=Color3.fromRGB(200,50,60); CloseBtn.Text="✕"
CloseBtn.TextColor3=Color3.fromRGB(255,255,255); CloseBtn.TextSize=16
CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.BorderSizePixel=0; CloseBtn.ZIndex=12
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,8)

Header.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then
		dragging=true; dragStart=i.Position; startPos=Win.Position
		i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
	end
end)
Header.InputChanged:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseMovement then dragInput=i end
end)
UIS.InputChanged:Connect(function(i) if i==dragInput and dragging then updateDrag(i) end end)

-- PAGE RARITY
local PageRarity=Instance.new("Frame",Win); PageRarity.Name="PageRarity"
PageRarity.Size=UDim2.new(1,0,1,-52); PageRarity.Position=UDim2.new(0,0,0,52)
PageRarity.BackgroundTransparency=1; PageRarity.ZIndex=11; PageRarity.Visible=true

local rarTitle=Instance.new("TextLabel",PageRarity)
rarTitle.Size=UDim2.new(1,0,0,50); rarTitle.Position=UDim2.new(0,0,0,20)
rarTitle.BackgroundTransparency=1; rarTitle.Text="Choisir une rarété"
rarTitle.TextColor3=Color3.fromRGB(200,210,230); rarTitle.TextSize=22
rarTitle.Font=Enum.Font.GothamBold; rarTitle.ZIndex=12

local function makeRarBtn(label, color, xPos)
	local btn=Instance.new("TextButton",PageRarity)
	btn.Size=UDim2.new(0,280,0,140); btn.Position=UDim2.new(0.5,xPos,0.5,-70)
	btn.BackgroundColor3=color; btn.Text=""; btn.BorderSizePixel=0; btn.ZIndex=12
	Instance.new("UICorner",btn).CornerRadius=UDim.new(0,16)
	local s=Instance.new("UIStroke",btn); s.Color=Color3.fromRGB(255,255,255); s.Transparency=0.8; s.Thickness=1.5
	local icon=Instance.new("TextLabel",btn); icon.Size=UDim2.new(1,0,0,60); icon.Position=UDim2.new(0,0,0,18)
	icon.BackgroundTransparency=1; icon.Text=label=="OG" and "👑" or "⭐"; icon.TextSize=48
	icon.Font=Enum.Font.GothamBold; icon.ZIndex=13
	local lbl=Instance.new("TextLabel",btn); lbl.Size=UDim2.new(1,0,0,36); lbl.Position=UDim2.new(0,0,0,80)
	lbl.BackgroundTransparency=1; lbl.Text=label; lbl.TextColor3=Color3.fromRGB(255,255,255)
	lbl.TextSize=26; lbl.Font=Enum.Font.GothamBold; lbl.ZIndex=13
	btn.MouseEnter:Connect(function() TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=color:lerp(Color3.new(1,1,1),0.15)}):Play() end)
	btn.MouseLeave:Connect(function() TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=color}):Play() end)
	return btn
end
local BtnOG=makeRarBtn("OG",RARITY_COLOR.OG,-300)
local BtnSecret=makeRarBtn("Secret",RARITY_COLOR.Secret,20)

-- PAGE LIST
local PageList=Instance.new("Frame",Win); PageList.Name="PageList"
PageList.Size=UDim2.new(1,0,1,-52); PageList.Position=UDim2.new(0,0,0,52)
PageList.BackgroundTransparency=1; PageList.ZIndex=11; PageList.Visible=false

local BackBtn=Instance.new("TextButton",PageList)
BackBtn.Size=UDim2.new(0,90,0,32); BackBtn.Position=UDim2.new(0,14,0,10)
BackBtn.BackgroundColor3=Color3.fromRGB(40,45,60); BackBtn.Text="← Retour"
BackBtn.TextColor3=Color3.fromRGB(180,190,210); BackBtn.TextSize=13
BackBtn.Font=Enum.Font.GothamBold; BackBtn.BorderSizePixel=0; BackBtn.ZIndex=12
Instance.new("UICorner",BackBtn).CornerRadius=UDim.new(0,8)

local ListTitle=Instance.new("TextLabel",PageList)
ListTitle.Size=UDim2.new(1,-200,0,32); ListTitle.Position=UDim2.new(0,114,0,10)
ListTitle.BackgroundTransparency=1; ListTitle.Text="..."
ListTitle.TextColor3=Color3.fromRGB(230,235,245); ListTitle.TextSize=16
ListTitle.Font=Enum.Font.GothamBold; ListTitle.TextXAlignment=Enum.TextXAlignment.Left; ListTitle.ZIndex=12

local RefreshBtn=Instance.new("TextButton",PageList)
RefreshBtn.Size=UDim2.new(0,90,0,32); RefreshBtn.Position=UDim2.new(1,-108,0,10)
RefreshBtn.BackgroundColor3=Color3.fromRGB(40,160,90); RefreshBtn.Text="↻ Refresh"
RefreshBtn.TextColor3=Color3.fromRGB(255,255,255); RefreshBtn.TextSize=13
RefreshBtn.Font=Enum.Font.GothamBold; RefreshBtn.BorderSizePixel=0; RefreshBtn.ZIndex=12
Instance.new("UICorner",RefreshBtn).CornerRadius=UDim.new(0,8)

local ListScroll=Instance.new("ScrollingFrame",PageList)
ListScroll.Size=UDim2.new(1,-20,1,-58); ListScroll.Position=UDim2.new(0,10,0,52)
ListScroll.BackgroundTransparency=1; ListScroll.ScrollBarThickness=4
ListScroll.ScrollBarImageColor3=Color3.fromRGB(60,200,120); ListScroll.ZIndex=12; ListScroll.BorderSizePixel=0
local ListLayout=Instance.new("UIListLayout",ListScroll)
ListLayout.SortOrder=Enum.SortOrder.LayoutOrder; ListLayout.Padding=UDim.new(0,6)
local ListPadding=Instance.new("UIPadding",ListScroll)
ListPadding.PaddingLeft=UDim.new(0,4); ListPadding.PaddingRight=UDim.new(0,4); ListPadding.PaddingTop=UDim.new(0,4)

-- PAGE DETAIL
local PageDetail=Instance.new("Frame",Win); PageDetail.Name="PageDetail"
PageDetail.Size=UDim2.new(1,0,1,-52); PageDetail.Position=UDim2.new(0,0,0,52)
PageDetail.BackgroundTransparency=1; PageDetail.ZIndex=11; PageDetail.Visible=false

local BackBtn2=Instance.new("TextButton",PageDetail)
BackBtn2.Size=UDim2.new(0,90,0,32); BackBtn2.Position=UDim2.new(0,14,0,10)
BackBtn2.BackgroundColor3=Color3.fromRGB(40,45,60); BackBtn2.Text="← Retour"
BackBtn2.TextColor3=Color3.fromRGB(180,190,210); BackBtn2.TextSize=13
BackBtn2.Font=Enum.Font.GothamBold; BackBtn2.BorderSizePixel=0; BackBtn2.ZIndex=12
Instance.new("UICorner",BackBtn2).CornerRadius=UDim.new(0,8)

local DetailTitle=Instance.new("TextLabel",PageDetail)
DetailTitle.Size=UDim2.new(1,-130,0,32); DetailTitle.Position=UDim2.new(0,114,0,10)
DetailTitle.BackgroundTransparency=1; DetailTitle.Text="..."
DetailTitle.TextColor3=Color3.fromRGB(255,220,60); DetailTitle.TextSize=17
DetailTitle.Font=Enum.Font.GothamBold; DetailTitle.TextXAlignment=Enum.TextXAlignment.Left; DetailTitle.ZIndex=12

local DetailScroll=Instance.new("ScrollingFrame",PageDetail)
DetailScroll.Size=UDim2.new(1,-20,1,-58); DetailScroll.Position=UDim2.new(0,10,0,52)
DetailScroll.BackgroundTransparency=1; DetailScroll.ScrollBarThickness=4
DetailScroll.ScrollBarImageColor3=Color3.fromRGB(60,200,120); DetailScroll.ZIndex=12; DetailScroll.BorderSizePixel=0
local DetailLayout=Instance.new("UIListLayout",DetailScroll)
DetailLayout.SortOrder=Enum.SortOrder.LayoutOrder; DetailLayout.Padding=UDim.new(0,6)
local DetailPadding=Instance.new("UIPadding",DetailScroll)
DetailPadding.PaddingLeft=UDim.new(0,4); DetailPadding.PaddingRight=UDim.new(0,4); DetailPadding.PaddingTop=UDim.new(0,4)

local currentRarity=nil; local currentBrainrot=nil; local cachedData=nil
local lastPartialData=nil
local savedData=nil

local function persistSave(data)
	savedData=data
	Remote:FireServer("SaveScan", data)
end

local function showPage(name)
	PageRarity.Visible=(name=="rarity"); PageList.Visible=(name=="list"); PageDetail.Visible=(name=="detail")
end

local function clearFrame(f)
	for _,c in ipairs(f:GetChildren()) do
		if c:IsA("Frame") or c:IsA("TextLabel") or c:IsA("TextButton") then c:Destroy() end
	end
end

local function makeCard(parent, idx, bgColor)
	local card=Instance.new("Frame",parent)
	card.Size=UDim2.new(1,0,0,52); card.BackgroundColor3=bgColor or Color3.fromRGB(22,26,38)
	card.BorderSizePixel=0; card.LayoutOrder=idx; card.ZIndex=13
	Instance.new("UICorner",card).CornerRadius=UDim.new(0,10)
	return card
end

local statusLbl=Instance.new("TextLabel",Win)
statusLbl.Size=UDim2.new(1,-20,0,18); statusLbl.Position=UDim2.new(0,10,1,-22)
statusLbl.BackgroundTransparency=1; statusLbl.Text=""
statusLbl.TextColor3=Color3.fromRGB(100,110,130); statusLbl.TextSize=11
statusLbl.Font=Enum.Font.Gotham; statusLbl.TextXAlignment=Enum.TextXAlignment.Left; statusLbl.ZIndex=12

-- Bouton Sauvegarder dans le header
local SaveBtn=Instance.new("TextButton",Header)
SaveBtn.Size=UDim2.new(0,100,0,28); SaveBtn.Position=UDim2.new(1,-148,0.5,-14)
SaveBtn.BackgroundColor3=Color3.fromRGB(40,45,60); SaveBtn.Text="💾 Sauvegarder"
SaveBtn.TextColor3=Color3.fromRGB(140,150,180); SaveBtn.TextSize=11
SaveBtn.Font=Enum.Font.GothamBold; SaveBtn.BorderSizePixel=0; SaveBtn.ZIndex=13
Instance.new("UICorner",SaveBtn).CornerRadius=UDim.new(0,7)

-- Au demarrage, tente de charger le dernier scan sauvegarde
task.delay(1, function()
	Remote:FireServer("LoadScan")
end)

local isScanning=false
local scanTimeout=nil
local function requestData()
	if isScanning then return end
	isScanning=true
	-- Timeout de securite: si le serveur repond pas en 5min, on debloque
	if scanTimeout then task.cancel(scanTimeout) end
	scanTimeout = task.delay(300, function() isScanning=false end)
	statusLbl.Text="⏳ Scan en cours..."; statusLbl.TextColor3=Color3.fromRGB(100,180,255)
	Remote:FireServer("GetData")
end

SaveBtn.MouseButton1Click:Connect(function()
	local dataToSave = cachedData or lastPartialData
	if not dataToSave then
		statusLbl.Text="❌ Aucune donnée à sauvegarder"; statusLbl.TextColor3=Color3.fromRGB(255,80,80); return
	end
	persistSave(dataToSave)
	local nb = #dataToSave.PlayerAnimals
	local tot = dataToSave.TotalExists or 0
	SaveBtn.Text="✅ Sauvegardé!"
	SaveBtn.BackgroundColor3=Color3.fromRGB(30,80,50)
	SaveBtn.TextColor3=Color3.fromRGB(80,220,120)
	task.delay(2, function()
		SaveBtn.Text="💾 Sauvegarder"
		SaveBtn.BackgroundColor3=Color3.fromRGB(40,45,60)
		SaveBtn.TextColor3=Color3.fromRGB(140,150,180)
	end)
	statusLbl.Text="💾 Sauvegardé — "..nb.." joueurs • "..tot.." brainrots"
	statusLbl.TextColor3=Color3.fromRGB(100,200,150)
end)
-- Restaure l'affichage si une sauvegarde existe deja
if savedData then
	statusLbl.Text="📂 Données restaurées — "..#savedData.PlayerAnimals.." joueurs • "..(savedData.TotalExists or 0).." brainrots"
	statusLbl.TextColor3=Color3.fromRGB(100,180,150)
	SaveBtn.Text="💾 Sauvegarder"
	SaveBtn.BackgroundColor3=Color3.fromRGB(40,45,60)
	SaveBtn.TextColor3=Color3.fromRGB(140,150,180)
end

local function buildDetail(brainrotName)
	clearFrame(DetailScroll)
	DetailTitle.Text="🔎 "..brainrotName
	-- Pendant le scan on utilise lastPartialData si dispo, sinon savedData
	local dataToUse = cachedData or lastPartialData or savedData
	if not dataToUse then
		local lbl=Instance.new("TextLabel",DetailScroll)
		lbl.Size=UDim2.new(1,0,0,40); lbl.BackgroundTransparency=1
		lbl.Text="⏳ Scan en cours, patiente..."; lbl.TextColor3=Color3.fromRGB(150,160,180)
		lbl.TextSize=14; lbl.Font=Enum.Font.Gotham; lbl.ZIndex=13; lbl.LayoutOrder=1
		return
	end
	local mutCounts={}; local owners={}; local total=0
	for _,pdata in ipairs(dataToUse.PlayerAnimals) do
		for _,animal in ipairs(pdata.Animals) do
			if animal.AnimalName==brainrotName then
				total+=1
				local m=animal.Mutation or "None"
				mutCounts[m]=(mutCounts[m] or 0)+1
				table.insert(owners,{playerName=pdata.PlayerName,userId=pdata.UserId,mutation=m,traits=animal.Traits or {},podiumIndex=animal.PodiumIndex,isOnline=pdata.IsOnline})
			end
		end
	end
	local idx=0
	idx+=1
	local totalCard=makeCard(DetailScroll,idx,Color3.fromRGB(18,22,34))
	local tot=Instance.new("TextLabel",totalCard)
	tot.Size=UDim2.new(1,-20,1,0); tot.Position=UDim2.new(0,14,0,0)
	tot.BackgroundTransparency=1; tot.Text="📦 Total en existence : "..total
	tot.TextColor3=Color3.fromRGB(255,255,255); tot.TextSize=15
	tot.Font=Enum.Font.GothamBold; tot.TextXAlignment=Enum.TextXAlignment.Left; tot.ZIndex=14
	idx+=1
	local mutHeader=makeCard(DetailScroll,idx,Color3.fromRGB(20,24,36))
	local mh=Instance.new("TextLabel",mutHeader)
	mh.Size=UDim2.new(1,-20,1,0); mh.Position=UDim2.new(0,14,0,0)
	mh.BackgroundTransparency=1; mh.Text="✨ Mutations"
	mh.TextColor3=Color3.fromRGB(200,210,230); mh.TextSize=14
	mh.Font=Enum.Font.GothamBold; mh.TextXAlignment=Enum.TextXAlignment.Left; mh.ZIndex=14
	local mutList={}
	for m,c in pairs(mutCounts) do table.insert(mutList,{m=m,c=c}) end
	table.sort(mutList,function(a,b) return a.c>b.c end)
	for _,mc in ipairs(mutList) do
		idx+=1
		local mcard=makeCard(DetailScroll,idx,Color3.fromRGB(24,28,42)); mcard.Size=UDim2.new(1,0,0,40)
		local dot=Instance.new("Frame",mcard); dot.Size=UDim2.new(0,10,0,10); dot.Position=UDim2.new(0,12,0.5,-5)
		dot.BackgroundColor3=mutColor(mc.m); dot.BorderSizePixel=0; dot.ZIndex=15
		Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
		local ml=Instance.new("TextLabel",mcard); ml.Size=UDim2.new(0.6,0,1,0); ml.Position=UDim2.new(0,30,0,0)
		ml.BackgroundTransparency=1; ml.Text=mc.m; ml.TextColor3=mutColor(mc.m); ml.TextSize=13
		ml.Font=Enum.Font.GothamBold; ml.TextXAlignment=Enum.TextXAlignment.Left; ml.ZIndex=14
		local cnt=Instance.new("TextLabel",mcard); cnt.Size=UDim2.new(0.4,-14,1,0); cnt.Position=UDim2.new(0.6,0,0,0)
		cnt.BackgroundTransparency=1; cnt.Text=mc.c.." exist."; cnt.TextColor3=Color3.fromRGB(150,160,180)
		cnt.TextSize=13; cnt.Font=Enum.Font.Gotham; cnt.TextXAlignment=Enum.TextXAlignment.Right; cnt.ZIndex=14
	end
	idx+=1
	local ownerHeader=makeCard(DetailScroll,idx,Color3.fromRGB(20,24,36)); ownerHeader.Size=UDim2.new(1,0,0,40)
	local oh=Instance.new("TextLabel",ownerHeader)
	oh.Size=UDim2.new(1,-20,1,0); oh.Position=UDim2.new(0,14,0,0)
	oh.BackgroundTransparency=1; oh.Text="👤 Propriétaires ("..#owners..")"
	oh.TextColor3=Color3.fromRGB(200,210,230); oh.TextSize=14
	oh.Font=Enum.Font.GothamBold; oh.TextXAlignment=Enum.TextXAlignment.Left; oh.ZIndex=14
	table.sort(owners,function(a,b) return a.playerName<b.playerName end)
	for _,owner in ipairs(owners) do
		idx+=1
		local ocard=makeCard(DetailScroll,idx,Color3.fromRGB(22,27,40)); ocard.Size=UDim2.new(1,0,0,58)
		local onlineDot=Instance.new("Frame",ocard); onlineDot.Size=UDim2.new(0,8,0,8); onlineDot.Position=UDim2.new(0,10,0,10)
		onlineDot.BackgroundColor3=owner.isOnline and Color3.fromRGB(80,220,100) or Color3.fromRGB(120,120,140)
		onlineDot.BorderSizePixel=0; onlineDot.ZIndex=15
		Instance.new("UICorner",onlineDot).CornerRadius=UDim.new(1,0)
		local pname=Instance.new("TextLabel",ocard); pname.Size=UDim2.new(0.55,-10,0,26); pname.Position=UDim2.new(0,24,0,4)
		pname.BackgroundTransparency=1; pname.Text=owner.playerName; pname.TextColor3=Color3.fromRGB(60,220,130)
		pname.TextSize=14; pname.Font=Enum.Font.GothamBold; pname.TextXAlignment=Enum.TextXAlignment.Left
		pname.TextTruncate=Enum.TextTruncate.AtEnd; pname.ZIndex=14
		local mutBadge=Instance.new("TextLabel",ocard); mutBadge.Size=UDim2.new(0,90,0,22); mutBadge.Position=UDim2.new(0,24,0,30)
		mutBadge.BackgroundColor3=Color3.fromRGB(28,33,50); mutBadge.BorderSizePixel=0
		mutBadge.Text=owner.mutation; mutBadge.TextColor3=mutColor(owner.mutation)
		mutBadge.TextSize=11; mutBadge.Font=Enum.Font.GothamBold; mutBadge.ZIndex=15
		Instance.new("UICorner",mutBadge).CornerRadius=UDim.new(0,5)
		local traitsStr=#owner.traits>0 and table.concat(owner.traits," • ") or "Aucun trait"
		local traitLbl=Instance.new("TextLabel",ocard); traitLbl.Size=UDim2.new(0.5,-10,0,20); traitLbl.Position=UDim2.new(0.5,0,0,4)
		traitLbl.BackgroundTransparency=1; traitLbl.Text="🏷 "..traitsStr; traitLbl.TextColor3=Color3.fromRGB(140,150,175)
		traitLbl.TextSize=11; traitLbl.Font=Enum.Font.Gotham; traitLbl.TextXAlignment=Enum.TextXAlignment.Left
		traitLbl.TextTruncate=Enum.TextTruncate.AtEnd; traitLbl.ZIndex=14
		local delBtn=Instance.new("TextButton",ocard); delBtn.Size=UDim2.new(0,72,0,26); delBtn.Position=UDim2.new(1,-82,0.5,-13)
		delBtn.BackgroundColor3=Color3.fromRGB(180,40,50); delBtn.Text="🗑 Delete"
		delBtn.TextColor3=Color3.fromRGB(255,255,255); delBtn.TextSize=11
		delBtn.Font=Enum.Font.GothamBold; delBtn.BorderSizePixel=0; delBtn.ZIndex=15
		Instance.new("UICorner",delBtn).CornerRadius=UDim.new(0,7)
		local deleted=false
		delBtn.MouseButton1Click:Connect(function()
			if deleted then return end; deleted=true; delBtn.Text="..."
			delBtn.BackgroundColor3=Color3.fromRGB(100,100,100)
			Remote:FireServer("DeleteAnimal",owner.userId,owner.podiumIndex)
		end)
		delBtn.MouseEnter:Connect(function() if not deleted then TweenService:Create(delBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(220,50,60)}):Play() end end)
		delBtn.MouseLeave:Connect(function() if not deleted then TweenService:Create(delBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(180,40,50)}):Play() end end)
	end
	idx+=1
	-- Webhook: carte plus grande, layout fixe, un seul bouton cree une seule fois
	local whCard=makeCard(DetailScroll,idx,Color3.fromRGB(18,22,34)); whCard.Size=UDim2.new(1,0,0,90)
	local whLabel=Instance.new("TextLabel",whCard); whLabel.Size=UDim2.new(1,-20,0,20); whLabel.Position=UDim2.new(0,10,0,8)
	whLabel.BackgroundTransparency=1; whLabel.Text="📨 Envoyer au webhook Discord"
	whLabel.TextColor3=Color3.fromRGB(160,170,200); whLabel.TextSize=12
	whLabel.Font=Enum.Font.GothamBold; whLabel.TextXAlignment=Enum.TextXAlignment.Left; whLabel.ZIndex=14
	local whInput=Instance.new("TextBox",whCard); whInput.Size=UDim2.new(1,-110,0,30); whInput.Position=UDim2.new(0,10,0,32)
	whInput.BackgroundColor3=Color3.fromRGB(28,33,50); whInput.BorderSizePixel=0
	whInput.Text="https://discord.com/api/webhooks/REDACTED"
	whInput.PlaceholderText="https://discord.com/api/webhooks/..."
	whInput.TextColor3=Color3.fromRGB(200,210,230); whInput.PlaceholderColor3=Color3.fromRGB(80,90,110)
	whInput.TextSize=11; whInput.Font=Enum.Font.Gotham; whInput.ZIndex=14; whInput.ClearTextOnFocus=false
	whInput.TextTruncate=Enum.TextTruncate.AtEnd
	Instance.new("UICorner",whInput).CornerRadius=UDim.new(0,6)
	local whBtn=Instance.new("TextButton",whCard); whBtn.Size=UDim2.new(0,90,0,30); whBtn.Position=UDim2.new(1,-100,0,32)
	whBtn.BackgroundColor3=Color3.fromRGB(88,101,242); whBtn.Text="📨 Envoyer"
	whBtn.TextColor3=Color3.fromRGB(255,255,255); whBtn.TextSize=12
	whBtn.Font=Enum.Font.GothamBold; whBtn.BorderSizePixel=0; whBtn.ZIndex=14
	Instance.new("UICorner",whBtn).CornerRadius=UDim.new(0,6)
	local whSent=false -- garde-fou: un seul envoi par instance du bouton
	whBtn.MouseButton1Click:Connect(function()
		if whSent then return end
		local url=whInput.Text
		if url=="" or not url:find("webhooks") then statusLbl.Text="❌ URL webhook invalide"; statusLbl.TextColor3=Color3.fromRGB(255,80,80); return end
		whSent=true; whBtn.Text="..."; whBtn.BackgroundColor3=Color3.fromRGB(60,60,80)
		local mc={}
		local d=cachedData or lastPartialData or savedData
		if d then
			for _,pdata in ipairs(d.PlayerAnimals) do
				for _,animal in ipairs(pdata.Animals) do
					if animal.AnimalName==brainrotName then local m=animal.Mutation or "None"; mc[m]=(mc[m] or 0)+1 end
				end
			end
		end
		local tot2=0; for _,c in pairs(mc) do tot2+=c end
		Remote:FireServer("SendWebhook",url,brainrotName,mc,tot2,"")
	end)
	DetailScroll.CanvasSize=UDim2.new(0,0,0,DetailLayout.AbsoluteContentSize.Y+20)
end

-- buildList: met a jour uniquement les cartes qui ont change (upsert), sans tout reconstruire
local listCardsByName = {} -- { [name] = {card, cntLbl} }
local function buildList(rarity, data)
	data = data or cachedData
	if not data then
		clearFrame(ListScroll); listCardsByName={}
		local lbl=Instance.new("TextLabel",ListScroll); lbl.Size=UDim2.new(1,0,0,40); lbl.BackgroundTransparency=1
		lbl.Text="⏳ Récupération des données en cours..."; lbl.TextColor3=Color3.fromRGB(150,160,180)
		lbl.TextSize=14; lbl.Font=Enum.Font.Gotham; lbl.ZIndex=13; lbl.LayoutOrder=1; return
	end
	local brainrotCounts={}
	for _,pdata in ipairs(data.PlayerAnimals) do
		for _,animal in ipairs(pdata.Animals) do
			if animal.Rarity==rarity then local n=animal.AnimalName; brainrotCounts[n]=(brainrotCounts[n] or 0)+1 end
		end
	end
	local allNames={}
	for n in pairs(data.AllAnimalsOfRarity or {}) do if (data.AllAnimalsOfRarity[n]==rarity) then allNames[n]=true end end
	for n in pairs(brainrotCounts) do allNames[n]=true end
	local sorted={}
	for n in pairs(allNames) do table.insert(sorted,n) end
	table.sort(sorted)
	local total=0; for _,c in pairs(brainrotCounts) do total+=c end
	ListTitle.Text=(rarity=="OG" and "👑 OG" or "⭐ Secret").." — "..#sorted.." brainrots • "..total.." exist."
	for i,name in ipairs(sorted) do
		local count=brainrotCounts[name] or 0
		if count==0 then
			-- Supprimer la carte si elle existe et que count=0
			if listCardsByName[name] then listCardsByName[name].card:Destroy(); listCardsByName[name]=nil end
			continue
		end
		if listCardsByName[name] then
			-- Mettre a jour le compteur uniquement
			listCardsByName[name].cntLbl.Text=count.." exist."
			listCardsByName[name].card.LayoutOrder=i
		else
			-- Creer la carte
			local card=Instance.new("TextButton",ListScroll)
			card.Size=UDim2.new(1,0,0,48); card.BackgroundColor3=Color3.fromRGB(20,24,36)
			card.BorderSizePixel=0; card.LayoutOrder=i; card.Text=""; card.ZIndex=12
			Instance.new("UICorner",card).CornerRadius=UDim.new(0,10)
			local dot=Instance.new("Frame",card); dot.Size=UDim2.new(0,5,0.7,0); dot.Position=UDim2.new(0,0,0.15,0)
			dot.BackgroundColor3=RARITY_COLOR[rarity]; dot.BorderSizePixel=0; dot.ZIndex=13
			Instance.new("UICorner",dot).CornerRadius=UDim.new(0,3)
			local nameLbl=Instance.new("TextLabel",card); nameLbl.Size=UDim2.new(0.7,0,1,0); nameLbl.Position=UDim2.new(0,14,0,0)
			nameLbl.BackgroundTransparency=1; nameLbl.Text=name; nameLbl.TextColor3=Color3.fromRGB(220,225,240)
			nameLbl.TextSize=14; nameLbl.Font=Enum.Font.GothamBold; nameLbl.TextXAlignment=Enum.TextXAlignment.Left
			nameLbl.TextTruncate=Enum.TextTruncate.AtEnd; nameLbl.ZIndex=13
			local cntLbl=Instance.new("TextLabel",card); cntLbl.Size=UDim2.new(0.3,-14,1,0); cntLbl.Position=UDim2.new(0.7,0,0,0)
			cntLbl.BackgroundTransparency=1; cntLbl.Text=count.." exist."; cntLbl.TextColor3=Color3.fromRGB(80,210,120)
			cntLbl.TextSize=13; cntLbl.Font=Enum.Font.GothamBold; cntLbl.TextXAlignment=Enum.TextXAlignment.Right; cntLbl.ZIndex=13
			card.MouseEnter:Connect(function() TweenService:Create(card,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(30,35,52)}):Play() end)
			card.MouseLeave:Connect(function() TweenService:Create(card,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(20,24,36)}):Play() end)
			card.MouseButton1Click:Connect(function() currentBrainrot=name; buildDetail(name); showPage("detail") end)
			listCardsByName[name]={card=card, cntLbl=cntLbl}
		end
	end
	ListScroll.CanvasSize=UDim2.new(0,0,0,ListLayout.AbsoluteContentSize.Y+20)
end

Remote.OnClientEvent:Connect(function(action,...)
	local args={...}; local data=args[1]
	if action=="ScanProgress" then
		local brainrots, joueurs, partialAnimals, remaining = args[1], args[2], args[3], args[4]
		local txt = "⏳ Scan... "..brainrots.." brainrots • "..joueurs.." joueurs"
		if remaining and remaining > 0 then txt = txt.." | "..remaining.." restants" end
		statusLbl.Text=txt
		statusLbl.TextColor3=Color3.fromRGB(100,180,255)
		-- Garde une copie partielle pour le bouton Sauvegarder
		if partialAnimals then
			local allRar = (cachedData and cachedData.AllAnimalsOfRarity) or (savedData and savedData.AllAnimalsOfRarity) or {}
			lastPartialData = {PlayerAnimals=partialAnimals, TotalExists=brainrots, AllAnimalsOfRarity=allRar}
			if PageList.Visible and currentRarity then
				buildList(currentRarity, lastPartialData)
			end
		end
	elseif action=="DataUpdate" then
		cachedData=data
		isScanning=false
		if scanTimeout then task.cancel(scanTimeout); scanTimeout=nil end
		if not savedData then
			SaveBtn.BackgroundColor3=Color3.fromRGB(60,100,50)
			SaveBtn.TextColor3=Color3.fromRGB(120,230,140)
		end
		listCardsByName={}
		clearFrame(ListScroll)
		statusLbl.Text="✅ "..(data.TotalExists or 0).." brainrots scannés • "..#(data.PlayerAnimals or {}).." joueurs"
		statusLbl.TextColor3=Color3.fromRGB(60,200,120)
		if PageList.Visible and currentRarity then buildList(currentRarity) end
		-- Rafraichit le detail seulement quand le scan est TERMINE
		if PageDetail.Visible and currentBrainrot then buildDetail(currentBrainrot) end
	elseif action=="SaveScanResult" then
		local ok, nbJoueurs, nbBrainrots = args[2], args[3], args[4]
		if ok then
			statusLbl.Text="💾 Sauvegardé dans le cloud — "..tostring(nbJoueurs).." joueurs • "..tostring(nbBrainrots).." brainrots"
			statusLbl.TextColor3=Color3.fromRGB(100,200,150)
		else
			statusLbl.Text="❌ Erreur sauvegarde: "..tostring(nbJoueurs)
			statusLbl.TextColor3=Color3.fromRGB(255,80,80)
		end
	elseif action=="LoadScanResult" then
		local ok, data = args[2], args[3]
		if ok and type(data)=="table" then
			savedData=data
			local nb = #(data.PlayerAnimals or {})
			local tot = data.TotalExists or 0
			local savedAt = data.SavedAt
			local dateStr = savedAt and os.date("%d/%m %H:%M", savedAt) or "?"
			statusLbl.Text="📂 Dernier scan: "..nb.." joueurs • "..tot.." brainrots ("..dateStr..") — appuie sur OG/Secret"
			statusLbl.TextColor3=Color3.fromRGB(100,180,150)
		else
			statusLbl.Text="Aucun scan sauvegardé — appuie sur Refresh pour scanner"
			statusLbl.TextColor3=Color3.fromRGB(100,110,130)
		end
	elseif action=="DeleteResult" then
		local ok,msg=args[2],args[3]
		statusLbl.Text=ok and ("✅ "..tostring(msg)) or ("❌ "..tostring(msg))
		statusLbl.TextColor3=ok and Color3.fromRGB(60,200,120) or Color3.fromRGB(255,80,80)
		if currentBrainrot then task.wait(0.5); requestData() end
	elseif action=="WebhookResult" then
		local ok2,msg2=args[2],args[3]
		statusLbl.Text=tostring(msg2); statusLbl.TextColor3=ok2 and Color3.fromRGB(60,200,120) or Color3.fromRGB(255,80,80)
	end
end)

BtnOG.MouseButton1Click:Connect(function()
	currentRarity="OG"
	listCardsByName={}; clearFrame(ListScroll)
	showPage("list")
	local d = cachedData or savedData
	if d then buildList("OG", d)
	else requestData() end
end)
BtnSecret.MouseButton1Click:Connect(function()
	currentRarity="Secret"
	listCardsByName={}; clearFrame(ListScroll)
	showPage("list")
	local d = cachedData or savedData
	if d then buildList("Secret", d)
	else requestData() end
end)
BackBtn.MouseButton1Click:Connect(function() showPage("rarity") end)
BackBtn2.MouseButton1Click:Connect(function() showPage("list") end)
RefreshBtn.MouseButton1Click:Connect(function() requestData() end)
CloseBtn.MouseButton1Click:Connect(function() Win.Visible=false end)

local isOpen=false
UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	if input.KeyCode==Enum.KeyCode.G then
		isOpen=not isOpen; Win.Visible=isOpen
		if isOpen then
			-- Toujours revenir a la page de choix et ne pas auto-scanner
			showPage("rarity")
			if savedData then
				statusLbl.Text="📂 "..#savedData.PlayerAnimals.." joueurs • "..(savedData.TotalExists or 0).." brainrots en mémoire"
				statusLbl.TextColor3=Color3.fromRGB(100,180,150)
			else
				statusLbl.Text="Choisis OG ou Secret pour lancer le scan"
				statusLbl.TextColor3=Color3.fromRGB(100,110,130)
			end
		end
	end
end)

print("[AdminPanel] GUI prete ✅")
