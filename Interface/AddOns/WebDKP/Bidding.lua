local a={}local b=false;local c=false;WebDKP_bidItem=""WebDKP_bidItemLink=""local d=0;local e=0;WebDKP_lastBidItem=""WebDKP_Rolls={}WebDKP_Roll_Total=1;defaultBIPmsg=WebDKP.translations.defaultBIPmsg;defaultSBIPmsg=WebDKP.translations.defaultSBIPmsg;defaultRIPmsg=WebDKP.translations.defaultRIPmsg;WebDKP_BidSort={["curr"]=2,["way"]=1}do local f={}local g={}for h=1,4 do f[h]=_G["LootButton"..h]g[h]=CreateFrame("Button",nil,f[h])g[h]:SetSize(32,32)g[h]:EnableMouse(true)g[h]:RegisterForClicks("AnyUp")g[h]:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background",edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",tile=true,tileSize=2,edgeSize=2,insets={left=1,right=1,top=1,bottom=1}})g[h]:SetBackdropColor(0.0,0.0,0.0,0.5)g[h]:SetBackdropBorderColor(0.0,0.0,0.0,1.0)g[h]:SetPoint("RIGHT",f[h],"LEFT",-10,0)g[h]:SetScript("OnClick",function(self)local i=self:GetParent().slot;local j=GetLootSlotType(i)if j==1 then local k=GetLootSlotLink(i)local l,l,m=strfind(k,"item:(%d+)")m=tonumber(m)local n,o,p,l,q=GetLootSlotInfo(i)WebDKP_Bid_ToggleUI()WebDKP_BidFrameItem:SetText(k)end end)local r=g[h]:CreateFontString(nil,"OVERLAY")r:SetFont(GameFontNormal:GetFont(),12,"OUTLINE")r:SetPoint("CENTER")r:SetText("[拍]")end end;function WebDKP_Bid_ToggleUI()if WebDKP_BidFrame:IsShown()then WebDKP_BidFrame:Hide()else WebDKP_BidFrame:Show()WebDKP_BidFrameBid:Show()WebDKP_BidFrameDKP:Show()WebDKP_BidFramePost:Show()WebDKP_BidFrameStartingBid:Show()WebDKP_BidFrameTop3Button:Show()WebDKP_BidFrameTitle:Show()WebDKP_BidFrameScrollFrame:Show()local s=WebDKP_BidFrameTime:GetText()if s==nil or s==""then WebDKP_BidFrameTime:SetText("0")end end end;function WebDKP_Bid_ShowUI()WebDKP_BidFrame:Show()local s=WebDKP_BidFrameTime:GetText()if s==nil or s==""then WebDKP_BidFrameTime:SetText("0")end end;function WebDKP_Bid_HideUI()WebDKP_BidFrame:Hide()end;function WebDKP_Bid_HandleMouseOver(self)local t=self;local u=0;local v=getglobal(t:GetName().."Name"):GetText()u=getglobal(t:GetName().."Bid"):GetText()+0;if u==nil then u=0 end;local w=WebDKP_Bid_IsSelected(v,u)if not w then getglobal(t:GetName().."Background"):SetVertexColor(0.2,0.2,0.7,0.5)end end;function WebDKP_Bid_HandleMouseLeave(self)local t=self;local u=0;local v=getglobal(t:GetName().."Name"):GetText()u=getglobal(t:GetName().."Bid"):GetText()+0;if u==nil then u=0 end;local w=WebDKP_Bid_IsSelected(v,u)if not w then getglobal(t:GetName().."Background"):SetVertexColor(0,0,0,0)end end;function WebDKP_Bid_SelectPlayerToggle(self)local t=self;local v=getglobal(t:GetName().."Name"):GetText()local x=0;x=getglobal(t:GetName().."Bid"):GetText()+0;if x==nil then x=0 end;for y,z in pairs(a)do if type(z)=="table"then if z["Name"]~=nil and z["Bid"]~=nil then if z["Name"]==v and WebDKP_ROUND(z["Bid"],2)==x then if z["Selected"]==true then z["Selected"]=false;getglobal(t:GetName().."Background"):SetVertexColor(0.2,0.2,0.7,0.5)else WebDKP_Bid_DeselectAll()z["Selected"]=true;getglobal(t:GetName().."Background"):SetVertexColor(0.1,0.1,0.9,0.8)end end end end end;WebDKP_Bid_UpdateTable()end;function WebDKP_Bid_IsSelected(v,u)u=u+0;playerbidcompare=0;for y,z in pairs(a)do if type(z)=="table"then if z["Name"]~=nil and z["Bid"]~=nil then playerbidcompare=z["Bid"]playerbidcompare=tonumber(playerbidcompare)playerbidcompare=WebDKP_ROUND(playerbidcompare,2)if z["Name"]==v and playerbidcompare==u then return z["Selected"]end end end end;return false end;function WebDKP_Bid_DeselectAll()for y,z in pairs(a)do if type(z)=="table"then if z["Name"]~=nil and z["Bid"]~=nil then z["Selected"]=false end end end end;function WebDKP_Bid_SortBy(m)if WebDKP_BidSort["curr"]==m then WebDKP_BidSort["way"]=abs(WebDKP_BidSort["way"]-1)else WebDKP_BidSort["curr"]=m;if m==1 then WebDKP_BidSort["way"]=0 elseif m==2 then WebDKP_BidSort["way"]=1 elseif m==3 then WebDKP_BidSort["way"]=1 else WebDKP_BidSort["way"]=1 end end;WebDKP_Bid_UpdateTable()end;function WebDKP_Bid_UpdateTable()local A={}for B,z in pairs(a)do if type(z)=="table"then if z["Name"]~=nil and z["Bid"]~=nil and z["DKP"]~=nil and z["Post"]~=nil then tinsert(A,{z["Name"],z["Bid"],z["DKP"],z["Post"],z["Date"],z["Roll"],z["Spec"],z["GuildRank"]})end end end;table.sort(A,function(C,D)if C and D then if C==nil then return 1>0 elseif D==nil then return 1<0 end;if WebDKP_BidSort["way"]==1 then if C[WebDKP_BidSort["curr"]]==D[WebDKP_BidSort["curr"]]then return C[1]>D[1]else return C[WebDKP_BidSort["curr"]]>D[WebDKP_BidSort["curr"]]end else if C[WebDKP_BidSort["curr"]]==D[WebDKP_BidSort["curr"]]then return C[1]<D[1]else return C[WebDKP_BidSort["curr"]]<D[WebDKP_BidSort["curr"]]end end end end)local E=getn(A)local F=FauxScrollFrame_GetOffset(WebDKP_BidFrameScrollFrame)FauxScrollFrame_Update(WebDKP_BidFrameScrollFrame,E,13,13)for h=1,13,1 do local G=getglobal("WebDKP_BidFrameLine"..h)local H=getglobal("WebDKP_BidFrameLine"..h.."Name")local I=getglobal("WebDKP_BidFrameLine"..h.."Bid")local J=getglobal("WebDKP_BidFrameLine"..h.."DKP")local K=getglobal("WebDKP_BidFrameLine"..h.."Post")local L=getglobal("WebDKP_BidFrameLine"..h.."Roll")local M=getglobal("WebDKP_BidFrameLine"..h.."Spec")local N=getglobal("WebDKP_BidFrameLine"..h.."GuildRank")local O=h+FauxScrollFrame_GetOffset(WebDKP_BidFrameScrollFrame)if O<=E then local v=A[O][1]local date=A[O][5]local P=A[O][1]G:Show()H:SetText(P)if WebDKP_DkpTable[P]==nil then WebDKP_DkpTable[P]={}end;if WebDKP_DkpTable[P]["class"]~=nil then local Q=WebDKP_DkpTable[P]["class"]Q=string.upper(Q)Q=string.gsub(Q," ","")local R=WebDKP.translations.CLASS_LOCALIZED_TO_ENG_MAP[Q]if R~=nil then local S,T,U,V=GetClassColor(string.upper(R))H:SetTextColor(S,T,U)end end;I:SetText(WebDKP_ROUND(A[O][2],2))J:SetText(WebDKP_ROUND(A[O][3],2))K:SetText(WebDKP_ROUND(A[O][3],2))L:SetText(A[O][6])M:SetText(A[O][7])N:SetText(A[O][8])if a[v..date]and not a[v..date]["Selected"]then getglobal("WebDKP_BidFrameLine"..h.."Background"):SetVertexColor(0,0,0,0)else getglobal("WebDKP_BidFrameLine"..h.."Background"):SetVertexColor(0.1,0.1,0.9,0.8)end else G:Hide()end end end;function WebDKP_Bid_Event(W,X,Y)local o=X;local Z=0;if b and tonumber(W)~=nil then W=WebDKP.translations.triggerBID..W end;local _=W;local a0=0;if WebDKP_IsBidChat(o,_)then local a1,a2=WebDKP_GetCmd(_)a1,a2=WebDKP_GetCommaCmd(a2)startbiddingcmd=a1;a1=tonumber(a1)if string.find(string.lower(_),WebDKP.translations.triggerBID)==1 then if a1==nil then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper1)else if b==false then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper2)elseif a1==""or a1==nil then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper3)elseif a1<WebDKP_GetStartingBid()then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper4 ..WebDKP_GetStartingBid())elseif WebDKP_Options["BidFixedBidding"]==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper5)elseif WebDKP_Options["DisableBid"]==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper6)else Z=WebDKP_Bid_HandleBid(o,a1,"NA")if Z==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper7 ..a1 ..WebDKP.translations.SendWhisper8)end end end elseif string.find(string.lower(_),WebDKP.translations.triggerSH)==1 then local a0=WebDKP_GetDKP(o)if not Y then WebDKP_SendAnnouncement(o..WebDKP.translations.showhandannounce..a0,WebDKP_GetTellLocation())end;if b==false then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper2)elseif a0<WebDKP_GetStartingBid()then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper9 ..WebDKP_GetStartingBid())elseif WebDKP_Options["BidFixedBidding"]==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper10)else Z=WebDKP_Bid_HandleBid(o,a0,"NA")if Z==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper7 ..a0 ..WebDKP.translations.SendWhisper8)end end elseif string.find(string.lower(_),WebDKP.translations.triggerMAINTLENT)==1 then if b==false then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper2)elseif a1==""or a1==nil then a1=0;Z=WebDKP_Bid_HandleBid(o,a1,"Main")if Z==1 then if WebDKP_Options["BidFixedBidding"]==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper11)else WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper12 ..a1 ..WebDKP.translations.SendWhisper8)end end elseif a1<WebDKP_GetStartingBid()then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper13 ..WebDKP_GetStartingBid())elseif WebDKP_Options["BidFixedBidding"]==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper10)else Z=WebDKP_Bid_HandleBid(o,a1,"Main")if Z==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper12 ..a1 ..WebDKP.translations.SendWhisper8)end end elseif string.find(string.lower(_),WebDKP.translations.triggerOFFTLENT)==1 then if b==false then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper2)elseif a1==""or a1==nil then a1=0;WebDKP_Bid_HandleBid(o,a1,"Off")if WebDKP_Options["BidFixedBidding"]==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper14)else WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper15 ..a1 ..WebDKP.translations.SendWhisper8)end elseif a1<WebDKP_GetStartingBid()then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper9 ..WebDKP_GetStartingBid())elseif WebDKP_Options["BidFixedBidding"]==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper16)else Z=WebDKP_Bid_HandleBid(o,a1,"Off")if Z==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper15 ..a1 ..WebDKP.translations.SendWhisper8)end end elseif string.find(string.lower(_),WebDKP.translations.triggerBIDDINGTOSTART)==1 then if b==true then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper17)elseif startbiddingcmd==""or startbiddingcmd==nil then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper18)else WebDKP_Bid_StartBid(startbiddingcmd,a2)WebDKP_BidFrameBidButton:SetText(WebDKP.translations.framestopbinding)end elseif string.find(string.lower(_),WebDKP.translations.triggerBIDDINGTOSTOP)==1 then if b==false then WebDKP_SendWhisper(o,"There is no bid in progress for you to cancel")else WebDKP_Bid_StopBid()WebDKP_BidFrameBidButton:SetText(WebDKP.translations.framestartbinding)end elseif string.find(string.lower(_),WebDKP.translations.triggerNEED)==1 and WebDKP_Options["BidFixedBidding"]==1 then a0=WebDKP_GetDKP(o)if a0==nil then a0=0 end;if WebDKP_Options["AllNeed"]==1 and WebDKP_Options["TurnBase"]==1 then a0=WebDKP_ROUND(a0*tonumber(WebDKP_Options["NeedDKP"])/100,0)end;Z=WebDKP_Bid_HandleBid(o,a0,"Main")if Z==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper12 ..a0 ..WebDKP.translations.SendWhisper8)end elseif string.find(string.lower(_),WebDKP.translations.triggerGREED)==1 and WebDKP_Options["BidFixedBidding"]==1 then a0=WebDKP_GetDKP(o)if a0==nil then a0=0 end;if WebDKP_Options["FiftyGreed"]==1 and WebDKP_Options["TurnBase"]==1 then a0=WebDKP_ROUND(a0*tonumber(WebDKP_Options["GreedDKP"])/100,0)end;Z=WebDKP_Bid_HandleBid(o,a0,"Off")if Z==1 then WebDKP_SendWhisper(o,WebDKP.translations.SendWhisper15 ..a0 ..WebDKP.translations.SendWhisper8)end end end end;function WebDKP_GetStartingBid()local a3=WebDKP_BidFrameStartingBid:GetText()if a3==nil or a3==""then a3=0 end;return a3+0 end;function WebDKP_IsBidChat(o,_)if string.find(string.lower(_),WebDKP.translations.triggerBID2)==1 or string.find(string.lower(_),WebDKP.translations.triggerSH)==1 or string.find(string.lower(_),WebDKP.translations.triggerMAINTLENT)==1 or string.find(string.lower(_),WebDKP.translations.triggerOFFTLENT)==1 or string.find(string.lower(_),WebDKP.translations.triggerBIDDINGTOSTART)==1 or string.find(string.lower(_),WebDKP.translations.triggerBIDDINGTOSTOP)==1 or string.find(string.lower(_),WebDKP.translations.triggerNEED)==1 or string.find(string.lower(_),WebDKP.translations.triggerGREED)==1 then return true end;return false end;function WebDKP_Bid_StartBid(a4,s)if a4~=""and a4~=nil then WebDKP_BidFrameBidButton:SetText(WebDKP.translations.framestopbinding)a={}if s==""or s==nil or s=="0"or s==" "then s=0 end;local q,a5,a6,a7=WebDKP_GetItemInfo(a4)WebDKP_bidItem=a5;WebDKP_bidItemLink=a6;WebDKP_BidFrameItem:SetText(a5)WebDKP_BidFrameTime:SetText(s)WebDKP_Bid_ItemNameChanged()if WebDKP_Options["BidAnnounceRaid"]==1 then WebDKP_SendAnnouncement(WebDKP.translations.SendAnnouncement,"RAID_WARNING")end;WebDKP_AnnounceBidStart(a6,s,WebDKP_GetStartingBid())b=true;WebDKP_BidFrameItem:SetText(a6)WebDKP_Bid_UpdateTable()WebDKP_Bid_ShowUI()if s~=0 then d=s;WebDKP_Bid_UpdateFrame:Show()else WebDKP_Bid_UpdateFrame:Hide()end else WebDKP_Print(WebDKP.translations.ItemName_Print)end end;function WebDKP_Bid_StopBid()local a8=0;WebDKP_Bid_UpdateFrame:Hide()WebDKP_BidFrame_Countdown:SetText("")WebDKP_BidFrameBidButton:SetText(WebDKP.translations.framestartbinding)local bidder,bid=WebDKP_Bid_GetHighestBid()for B,z in pairs(a)do if type(z)=="table"then a8=a8+1 end end;WebDKP_AnnounceBidEnd(WebDKP_bidItem,bidder,bid,a8)b=false;WebDKP_Bid_ShowUI()end;function WebDKP_Bid_HandleBid(v,a9,aa)local Z=0;local ab=0;if WebDKP_DkpTable[v]==nil then WebDKP_DkpTable[v]={}end;if b then local a0=WebDKP_GetDKP(v)startingBid=WebDKP_GetStartingBid()ab=a0-a9;if startingBid==nil or startingBid==""then startingBid=0 end;local ac=a0-startingBid;a9=a9+0;local date=date("%Y-%m-%d %H:%M:%S")local ad=WebDKP_GetGuildRank(v)if ab<0 and WebDKP_Options["BidAllowNegativeBids"]==0 then WebDKP_SendWhisper(v,WebDKP.translations.SendWhisper19)WebDKP_SendWhisper(v,WebDKP.translations.SendWhisper20 ..a0)elseif ac<0 and WebDKP_Options["BidAllowNegativeBids"]==0 then WebDKP_SendWhisper(v,WebDKP.translations.SendWhisper21 ..startingBid)else Z=1;a[v..date]={["Name"]=v,["Bid"]=a9,["DKP"]=a0,["Post"]=ab,["Date"]=date,["Roll"]="NA",["Spec"]=aa,["GuildRank"]=ad}if a[v..date]["Selected"]==nil then a[v..date]["Selected"]=false end;WebDKP_Bid_UpdateTable()WebDKP_SendWhisper(v,WebDKP.translations.SendWhisper24)local ae,af=WebDKP_Bid_GetHighestBid()if ae==v and WebDKP_Options["BidNotifyLowBids"]==1 then WebDKP_SendWhisper(v,WebDKP.translations.SendWhisper22)elseif ae~=v and WebDKP_Options["BidNotifyLowBids"]==1 then WebDKP_SendWhisper(v,WebDKP.translations.SendWhisper23 ..af.." dkp.")end end;return Z else WebDKP_SendWhisper(v,WebDKP.translations.SendWhisper2)end end;function WebDKP_Bid_GetHighestBid()local ag=nil;local ah=nil;for B,z in pairs(a)do if type(z)=="table"then if z["Bid"]~=nil then if ah==nil then ag=z["Name"]ah=z["Bid"]elseif z["Bid"]>ah then ag=z["Name"]ah=z["Bid"]end end end end;return ag,ah end;function WebDKP_Bid_GetTopThree()local ag=nil;local ai=nil;local aj=nil;local ah=0;local ak=0;local al=0;for B,z in pairs(a)do if type(z)=="table"then if z["Bid"]~=nil then if z["Bid"]>ah then ag=z["Name"]ah=z["Bid"]elseif z["Bid"]>ak and z["Bid"]~=ah then ai=z["Name"]ak=z["Bid"]elseif z["Bid"]>al and z["Bid"]~=ah and z["Bid"]~=ak then aj=z["Name"]al=z["Bid"]end end end end;return ag,ai,aj,ah,ak,al end;function WebDKP_Bid_GetHighestRoll()local am=WebDKP.translations.NOone;local an=0;for B,z in pairs(a)do if type(z)=="table"then if z["Roll"]~=nil and z["Roll"]~="NA"then if z["Roll"]>an then am=z["Name"]an=z["Roll"]end end end end;return am,an end;function WebDKP_Bid_AwardSelected()local ao,bid,aa=WebDKP_Bid_GetSelected()local l,a4,k=WebDKP_GetItemInfo(WebDKP_bidItem)local startingBid=WebDKP_BidFrameStartingBid:GetText()if startingBid~=nil then startingBid=tonumber(startingBid)end;if startingBid~=nil and bid<startingBid then bid=startingBid end;if ao==nil then WebDKP_Print(WebDKP.translations.Nochoice_Print)PlaySound(847)else if b then WebDKP_Bid_StopBid()end;if WebDKP_Options["BidFixedBidding"]==1 and WebDKP_Options["TurnBase"]==0 then if aa=="Main"then bid=WebDKP_GetLootTableCost(WebDKP_bidItem)elseif aa=="Off"and WebDKP_Options["FiftyGreed"]==1 then multval=tonumber(WebDKP_Options["GreedDKP"])/100;tablevalue=WebDKP_GetLootTableCost(WebDKP_bidItem)if tablevalue==nil then tablevalue=WebDKP_GetDKP(ao)end;bid=WebDKP_ROUND(tablevalue*multval,0)else bid=WebDKP_GetLootTableCost(WebDKP_bidItem)end end;if WebDKP_Options["BidConfirmPopup"]==1 or bid==nil then if WebDKP_Options["BidFixedBidding"]==1 and bid==nil then WebDKP_Bid_ShowConfirmFrame(WebDKP.translations.ShowAwardtext..ao.." "..k..WebDKP.translations.ShowAwardtext3,0)elseif WebDKP_Options["BidFixedBidding"]==1 then WebDKP_Bid_ShowConfirmFrame(WebDKP.translations.ShowAwardtext..ao.." "..k..WebDKP.translations.ShowAwardtextfor..bid..WebDKP.translations.ShowAwardtext4,bid)else WebDKP_Bid_ShowConfirmFrame(WebDKP.translations.ShowAwardtext..ao.." "..k..WebDKP.translations.ShowAwardtextfor..bid..WebDKP.translations.ShowAwardtext5,bid)end else WebDKP_Bid_AwardPerson(bid)end end end;function Auto_Assign_Item_Player(ao)local l,a4,k=WebDKP_GetItemInfo(WebDKP_bidItem)for ap=1,GetNumLootItems()do local aq,ar,as,at,au=GetLootSlotInfo(ap)if ar==a4 then for av=1,GetNumGroupMembers()do candidate=GetMasterLootCandidate(ap,av)if candidate==ao then GiveMasterLoot(ap,av)av=GetNumGroupMembers()+1;ap=GetNumLootItems()+1 end end end end end;function WebDKP_Bid_ButtonHandler()c=false;for h=1,WebDKP_Roll_Total,1 do WebDKP_Rolls[h]=nil end;WebDKP_Roll_Total=1;if b then WebDKP_Bid_StopBid()else local a4=WebDKP_BidFrameItem:GetText()local s=WebDKP_BidFrameTime:GetText()WebDKP_Bid_StartBid(a4,s)end end;function WebDKP_Roll_Initiate()if c then WebDKP_Roll_Stop()else local a4=WebDKP_BidFrameItem:GetText()local s=WebDKP_BidFrameTime:GetText()WebDKP_Roll_Start(a4,s)end end;function WebDKP_Bid_GetSelected()for B,z in pairs(a)do if type(z)=="table"then if z["Selected"]==true then return z["Name"],z["Bid"],z["Spec"]end end end;return nil,0 end;function WebDKP_Bid_OnUpdate(self,aw)local t=self;t.TimeSinceLastUpdate=t.TimeSinceLastUpdate+aw;if t.TimeSinceLastUpdate>1.0 then if c==true then highest_roller,high_roll=WebDKP_Bid_GetHighestRoll()end;t.TimeSinceLastUpdate=0;d=d-1;WebDKP_BidFrame_Countdown:SetText(WebDKP.translations.framelefttimetext..d..WebDKP.translations.framelefttimesecondtext)highest_bidder,high_bid=WebDKP_Bid_GetHighestBid()if highest_bidder==nil then highest_bidder=WebDKP.translations.NOone;high_bid=0 end;local l,l,k=WebDKP_GetItemInfo(WebDKP_bidItem)local ax=WebDKP_Options["EditDuringAnnounce"]if b==true and WebDKP_Options["SilentBidding"]==0 then rollmessage=""if ax~=""and ax~=nil then rollmessage=ax else rollmessage=defaultBIPmsg end;rollmessage=string.gsub(rollmessage,"$name",highest_bidder)rollmessage=string.gsub(rollmessage,"$dkp",high_bid)rollmessage=string.gsub(rollmessage,"$item",k)if d==45 then rollmessage=string.gsub(rollmessage,"$time","45")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==30 then rollmessage=string.gsub(rollmessage,"$time","30")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==15 then rollmessage=string.gsub(rollmessage,"$time","15")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==5 then rollmessage=string.gsub(rollmessage,"$time","5")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==4 then rollmessage=string.gsub(rollmessage,"$time","4")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==3 then rollmessage=string.gsub(rollmessage,"$time","3")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==2 then rollmessage=string.gsub(rollmessage,"$time","2")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==1 then rollmessage=string.gsub(rollmessage,"$time","1")WebDKP_SendAnnouncementDefault(rollmessage)elseif d<=0 then WebDKP_Bid_StopBid()end elseif b==true and WebDKP_Options["SilentBidding"]==1 then rollmessage=""if ax~=""and ax~=nil then rollmessage=ax else rollmessage=defaultSBIPmsg end;rollmessage=string.gsub(rollmessage,"$name",highest_bidder)rollmessage=string.gsub(rollmessage,"$dkp",high_bid)rollmessage=string.gsub(rollmessage,"$item",k)if d==45 then rollmessage=string.gsub(rollmessage,"$time","45")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==30 then rollmessage=string.gsub(rollmessage,"$time","30")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==15 then rollmessage=string.gsub(rollmessage,"$time","15")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==5 then rollmessage=string.gsub(rollmessage,"$time","5")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==4 then rollmessage=string.gsub(rollmessage,"$time","4")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==3 then rollmessage=string.gsub(rollmessage,"$time","3")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==2 then rollmessage=string.gsub(rollmessage,"$time","2")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==1 then rollmessage=string.gsub(rollmessage,"$time","1")WebDKP_SendAnnouncementDefault(rollmessage)elseif d<=0 then WebDKP_Bid_StopBid()end else announceRollText=WebDKP_Options["EditRollAnnounce"]rollmessage=""if announceRollText~=""and announceRollText~=nil then rollmessage=announceRollText else rollmessage=defaultRIPmsg end;rollmessage=string.gsub(rollmessage,"$name",highest_roller)rollmessage=string.gsub(rollmessage,"$roll",high_roll)rollmessage=string.gsub(rollmessage,"$item",k)if d==45 then rollmessage=string.gsub(rollmessage,"$time","45")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==30 then rollmessage=string.gsub(rollmessage,"$time","30")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==15 then rollmessage=string.gsub(rollmessage,"$time","15")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==5 then rollmessage=string.gsub(rollmessage,"$time","5")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==4 then rollmessage=string.gsub(rollmessage,"$time","4")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==3 then rollmessage=string.gsub(rollmessage,"$time","3")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==2 then rollmessage=string.gsub(rollmessage,"$time","2")WebDKP_SendAnnouncementDefault(rollmessage)elseif d==1 then rollmessage=string.gsub(rollmessage,"$time","1")WebDKP_SendAnnouncementDefault(rollmessage)elseif d<=0 then WebDKP_Roll_Stop()end end end end;function WebDKP_Bid_ItemChatClick(k,r,ay)if IsControlKeyDown()or IsAltKeyDown()or IsShiftKeyDown()then if WebDKP_BidFrame:IsShown()and b==false then local l,a5,a6=WebDKP_GetItemInfo(k)WebDKP_BidFrameItem:SetText(a6)WebDKP_bidItemLink=a6;startingBid=WebDKP_GetLootTableCost(a5)if startingBid~=nil then WebDKP_BidFrameStartingBid:SetText(startingBid)else end end end end;function WebDKP_Bid_ItemNameChanged()local a5=WebDKP_BidFrameItem:GetText()startingBid=WebDKP_GetLootTableCost(a5)if startingBid~=nil then startingBid=WebDKP_ROUND(startingBid,1)WebDKP_BidFrameStartingBid:SetText(startingBid)else end end;function WebDKP_Bid_ShowConfirmFrame(az,aA)PlaySound(850)WebDKP_BidConfirmFrame:Show()WebDKP_BidConfirmFrameTitle:SetText(az)if aA~=nil then WebDKP_BidConfirmFrameCost:SetText(aA)else WebDKP_BidConfirmFrameCost:SetText(0)end end;function WebDKP_Bid_AwardPerson(aA)local ao,l=WebDKP_Bid_GetSelected()local aB=string.find(aA,"%%")local aC=0;local aD=WebDKP_GetTableid()local aE=0;if aB~=nil then aA=string.gsub(aA,"%%","")aA=tonumber(aA)aC=1 end;if WebDKP_Options["AutoGive"]==1 then Auto_Assign_Item_Player(ao)end;aE=aA*-1;if aC==1 then aA=aA/100*WebDKP_DkpTable[ao]["dkp_"..aD]*-1;aE=WebDKP_ROUND(aA,2)end;local aF={}aF[0]={}aF[0]["name"]=ao;aF[0]["class"]=WebDKP_GetPlayerClass(ao)WebDKP_AddDKP(aE,WebDKP_bidItemLink,"true",aF)WebDKP_AnnounceAwardItem(aE,WebDKP_bidItemLink,ao)WebDKP_UpdateTableToShow()WebDKP_UpdateTable()PlaySound(120)WebDKP_lastBidItem=WebDKP_bidItem end;function WebDKP_ProcessRoll(ao,aG,aH,aI)aG=tonumber(aG)aH=tonumber(aH)aI=tonumber(aI)local aJ=0;local date=date("%Y-%m-%d %H:%M:%S")local a0=WebDKP_GetDKP(ao)local ad=WebDKP_GetGuildRank(ao)if c==true or WebDKP_BidInProgress==True and WebDKP_Options["BidandRoll"]==1 then if aH==1 and aI==100 then for h=1,WebDKP_Roll_Total,1 do if WebDKP_Rolls[h]==ao then aJ=1 end end;if aJ==0 then WebDKP_Roll_Total=WebDKP_Roll_Total+1;WebDKP_Rolls[WebDKP_Roll_Total]=ao;a[ao..date]={["Name"]=ao,["Bid"]=0,["DKP"]=a0,["Post"]=0,["Date"]=date,["Roll"]=aG,["Spec"]="Roll",["GuildRank"]=ad}WebDKP_Bid_UpdateTable()end end end end;function WebDKP_Roll_Start(a4,s)if a4~=""and a4~=nil then WebDKP_BidFrameRollButton:SetText(WebDKP.translations.framestoprolling)a={}if s==""or s==nil or s=="0"or s==" "then s=0 end;local q,a5,a6=WebDKP_GetItemInfo(a4)WebDKP_bidItem=a5;WebDKP_bidItemLink=a6;WebDKP_BidFrameItem:SetText(a5)WebDKP_BidFrameTime:SetText(s)WebDKP_Bid_ItemNameChanged()if WebDKP_Options["BidAnnounceRaid"]==1 then WebDKP_SendAnnouncement(WebDKP.translations.framestartrolling,"RAID_WARNING")end;WebDKP_AnnounceRollStart(a6,s)c=true;WebDKP_BidFrameItem:SetText(a6)WebDKP_Bid_UpdateTable()WebDKP_Bid_ShowUI()if s~=0 then d=s;WebDKP_Bid_UpdateFrame:Show()else WebDKP_Bid_UpdateFrame:Hide()end else WebDKP_Print(WebDKP.translations.startrolling_Print)end end;function WebDKP_Roll_Stop()local aK=0;WebDKP_Bid_UpdateFrame:Hide()WebDKP_BidFrame_Countdown:SetText("")for B,z in pairs(a)do if type(z)=="table"then aK=aK+1 end end;WebDKP_BidFrameRollButton:SetText(WebDKP.translations.framestartrolling)WebDKP_AnnounceRollEnd(WebDKP_bidItem,bidder,bid,aK)c=false;WebDKP_Bid_ShowUI()for h=1,WebDKP_Roll_Total,1 do WebDKP_Rolls[h]=nil end;WebDKP_Roll_Total=1 end;function WebDKP_Turn_Base()WebDKP_Options_ToggleOption("TurnBase")if WebDKP_Options["BidFixedBidding"]==0 then WebDKP_BiddingOptions_FrameToggleBidFixedBidding:SetChecked(true)WebDKP_Options_ToggleOption("BidFixedBidding")end end;function WebDKP_Fixed_Bidding()WebDKP_Options_ToggleOption("BidFixedBidding")if WebDKP_Options["TurnBase"]==1 then WebDKP_BiddingOptions_FrameToggleTurnBase:SetChecked(false)WebDKP_Options_ToggleOption("TurnBase")end end