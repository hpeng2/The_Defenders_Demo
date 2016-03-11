json = require('json')
luanet.load_assembly("UnityEngine")
luanet.load_assembly("Assembly-CSharp")
luanet.load_assembly("Geart3D")
local DateTime=luanet.import_type("System.DateTime")
local String=luanet.import_type("System.String")
local DateTimeKind=luanet.import_type("System.DateTimeKind")
local EventDelegate = luanet.import_type("EventDelegate")
local GTUIEventDispatcher = luanet.import_type("GTUIEventDispatcher")
local GTUIManager = luanet.import_type("GTUIManager")
local DialogType = luanet.import_type("GTUIManager+DialogType")
local DialogButton = luanet.import_type("GTUIManager+DialogButton")
local GTTools = luanet.import_type("GTTools")
local GTDebug = luanet.import_type("GTDebug")
local GTResourceManager = luanet.import_type("GTResourceManager")
local GameObject = luanet.import_type("UnityEngine.GameObject")
local Vector3 = luanet.import_type("UnityEngine.Vector3")
local Shader = luanet.import_type("UnityEngine.Shader")
local AnimationCurve = luanet.import_type("UnityEngine.AnimationCurve")
local InvokeRepeating = luanet.import_type("UnityEngine.AnimationCurve")
local Object = luanet.import_type("UnityEngine.Object")
local GTDataModelManager = luanet.import_type("GTDataModelManager")
local DFModelType = luanet.import_type("DFModelType")
local FunctionClass = luanet.import_type("FunctionClass")
local Localization = luanet.import_type("Localization")
local GTWindow_Layer = luanet.import_type("GTWindow+Layer")
local DFWinCharge = luanet.import_type("DFWinCharge")
local DFWinFubenBag = luanet.import_type("DFWinFubenBag")
local DFModelBag = luanet.import_type("DFModelBag")
local DFWinTranscript = luanet.import_type("DFWinTranscript")
local BagInfo = luanet.import_type("Bag_Info")
local DFWinPopup_no_physical = luanet.import_type("DFWinPopup_no_physical")
local ItemDialog = luanet.import_type("ItemDialog")
local GTItem = luanet.import_type("GTItem")
local UDebug = luanet.import_type("UnityEngine.Debug")
local DFModelPet = luanet.import_type("DFModelPet")
local DFWinMain = luanet.import_type("DFWinMain")
local DFModelPlayer = luanet.import_type("DFModelPlayer")
local FTPlayerLocal = luanet.import_type("FTPlayerLocal")
local PetType = luanet.import_type("PetType")
local DFWinActivitiesSub = luanet.import_type("DFWinActivitiesSub")
local Item = luanet.import_type("DFWinActivitiesSub+Item")
local GTClock = luanet.import_type("GTClock")
local DFWinRegulation = luanet.import_type("DFWinRegulation")
local Quaternion = luanet.import_type("UnityEngine.Quaternion")
local DFWinActivitiesPet = luanet.import_type("DFWinActivitiesPet")
local DFWinPetPiece = luanet.import_type("DFWinPetPiece")
local SpringPanel = luanet.import_type("SpringPanel")

--local UIGrid = luanet.import_type("UnityEngine.UIGrid")


return {
	tt = {},             --活动条目
	posx = {},			 --活动条目x坐标
	posxold = {},
	activityid = {},
	activitysubid = {},
	open_status = {},
	activitylist = {},
	rewardlist= {},
	timerange = {},  --豪华美食时间列表
	getime,
	touzibuystatus,
	stop = 0,
	--position_time,
	position_stop =0,
	rotagetlist,
	rotarestime, --转盘剩余次数
	fubecount,--副本集字剩余次数
	firstcharge,
	--close_open_status=false,
	--scale_open_status = false,
	close_open_sender,
	scrollview_flag = false,
	playerinfo,
	pre_item ,
	cur_item ,
	changing_activity_tab = false, --防止切换活动过快
	bagsubitem_id,	
	m_model_charge,
	m_model_bag,
	m_model_player,
	player_diamond,
	player_tired,
	totleitem,
	rotation_bonus = {},
	press_status,
	mark = false,
	last,
	lastsub,
	lastsubarray = {},
	acti_bagid = {},
	acti_hasbuy_array = {},
	acti_max_array = {},
	acti_status_array = {},
	bagid = {},
	click,
	already = {false,false},
	name = {},
	secretid,
	can_click = false,
	cur_buy,
	cur_max,
	cur_index,
	hasbuy_array = {},
	max_array = {},
	discount_save = {},
	count = {},
	panel_depth,
	count_down,--限时神宠倒计时
	count_mark,--限时神宠倒计时标志
	count_ostime,--限时神宠系统时间记录
	cur_pet, --限时神宠当前宠物
	freshtime_mark,--限时神宠刷新计时标志
	fresh_time,--限时神宠刷新计时
	cur_bar,
	cur_cost,
	rank, --1015 竞技场荣耀特惠 排名
	price_list = {}, --1015 竞技场荣耀特惠 价格表
	rank_array = {}, --1015 竞技场荣耀特惠 排名列表
	hasbuy_array_1015 = {},
	max_array_1015 = {},
	singleprice_list = {},
	login_day = {}, --1017 登录送礼 登录天数
	loginday,
	day_array = {},--1017 登录送礼 登录天数矩阵
	status_array ={}, --1017 登录送礼 礼包状态矩阵
	subid = {},
	lvlunlock_list = {},
	refresh_list = {},
	testcharge = 300,
	player_charge, --1018 累充送礼 玩家累计充值数值
	cur_day,     --1011开服嘉年华倒计时的当前天数
	max_day,     --1011开服嘉年华总天数
	left_time,   --1011开服嘉年华倒计时
	begin_count,
	count_mark1,
	rotate_mark,
	count_table = {},
	revDays = {["January"] = 1, ["February"] = 2, 
				["March"] = 3, ["April"] = 4,
				["May"] = 5, ["June"] = 6,  
				["July"] = 7,["August"] = 8,
				["September"] = 9,["October"] = 10,
				["November"] = 11,["December"] = 12} ,

    				
	--显示时间	
	pos5offset,
	NextShowTime = function(self)
		local tt = os.time()
		local start1 = self.timerange[1].starttime
		local end1 = self.timerange[1].endtime
		local start2 = self.timerange[2].starttime
		local end2 = self.timerange[2].endtime
		local nextimeshow = {}
		if tt < start1  or tt > start2 then
			nextimeshow[1] = start1
			nextimeshow[2] = end1
		elseif tt > start1 and tt < start2 then
			nextimeshow[1] = start2
			nextimeshow[2] = end2
		end
		
		local H1=os.date("%H",nextimeshow[1]) 
		local M1=os.date("%M",nextimeshow[1])
		local H2=os.date("%H",nextimeshow[2]) 
		local M2=os.date("%M",nextimeshow[2])
		
		local pp = Localization.Get("activities taocantime")
		return String.Format(pp,H1,M1,H2,M2)
	end,
			
		
	ShowTime = function(self,starttime,endtime,str)
	
		local y1=os.date("%Y",starttime) 
		local b1=os.date("%B",starttime) 
		local d1=os.date("%d",starttime) 		
		local H1=os.date("%H",endtime) 
		local M1=os.date("%M",endtime)
		local x1=H1..":"..M1
		
		endtime = endtime -1
		local y2=os.date("%Y",endtime) 
		local b2=os.date("%B",endtime) 
		local d2=os.date("%d",endtime)
		local H2=os.date("%H",endtime) 
		local M2=os.date("%M",endtime) 
		local S2=os.date("%S",endtime) 
		if H2=="23" and M2=="59" and S2=="59" then
			H2 = "24"
			M2 = "00"	
		else
			endtime = endtime +1
			H2=os.date("%H",endtime) 
			M2=os.date("%M",endtime) 
		end
		local x2=H2..":"..M2			
 
		
		local pp = Localization.Get(str)
		return String.Format(pp,y1,self.revDays[b1],d1,x1,y2,self.revDays[b2],d2,x2)
	end,

	ShowEndTime = function(self,endtime,str)			
		endtime = endtime -1
		local y2=os.date("%Y",endtime) 
		local b2=os.date("%B",endtime) 
		local d2=os.date("%d",endtime)
		local H2=os.date("%H",endtime) 
		local M2=os.date("%M",endtime) 
		local S2=os.date("%S",endtime) 
		if H2=="23" and M2=="59" and S2=="59" then
			H2 = "24"
			M2 = "00"	
		else
			endtime = endtime +1
			H2=os.date("%H",endtime) 
			M2=os.date("%M",endtime) 
		end
		local x2=H2..":"..M2			
		
		local pp = Localization.Get(str)
		return String.Format(pp,y2,self.revDays[b2],d2,x2)
	end,
	
	ShowEndTime1 = function(self,endtime,str)
		local shi = Localization.Get("activities hour")
		endtime = endtime -1
		local y2=os.date("%Y",endtime) 
		local b2=os.date("%B",endtime) 
		local d2=os.date("%d",endtime)
		local H2=os.date("%H",endtime) 
		local M2=os.date("%M",endtime) 
		local S2=os.date("%S",endtime) 
		if H2=="23" and M2=="59" and S2=="59" then
			H2 = "24"
			M2 = "00"	
		else
			endtime = endtime +1
			H2=os.date("%H",endtime) 
			M2=os.date("%M",endtime) 
		end
		local x2=H2..tostring(shi)			
		
		local pp = Localization.Get(str)
		return String.Format(pp,y2,self.revDays[b2],d2,x2)
	end,
	
				
	--物品蓝紫粉框显示
	Item_BG = function(self,root,count,id)
		local item_temp = GTTools.GetTransformComponent(root, "GTItem")
		if item_temp == nil then
			item_temp = GTTools.AddGameObjectComponent(root.gameObject, "GTItem")
		end	
		item_temp.typeId = id
		item_temp.count = count
		item_temp:show()														
	
	end,
	--转盘转完回调
	tweenRfinish = function(self)
		self.getime = os.time()
		self.stop = 1
		self:lightshow(true)
	end,
	Update = function(self)
		--GTDebug.LogError("1")
		if (0 ==self.stop) then--and (0 == self.position_stop) then
			--return			
		else
			local time1 = os.time()			
			if 0.001 <= (time1 - self.getime) then
				self.stop = 0
				self:rotashow()
				self:lightshow(false)
			end
		end
		--GTDebug.LogError("0")
		if 0 == self.count_mark then
			--GTDebug.LogError("1")
			--return
		else
			--GTDebug.LogError(os.difftime(self.count_ostime, time2))
			local time2 = os.time()
			if ( os.difftime(time2, self.count_ostime) >= 1) then
			    --GTDebug.LogError("1")
		        self.count_ostime = time2
		        self.count_down = self.count_down-1				
				if 0 == self.count_down then
					self:CowntTime(self.count_down)
					self.count_mark = 0
				else
					self:CowntTime(self.count_down)
				end		
			end
		end
		
		if self.count_mark1 == true then
			--GTDebug.LogError("1")
			if self.left_time ~= 0 then
				local time3 = os.time()	
				if 1 <= (time3 - self.begin_count) then
					self.left_time = self.left_time -1
					self.begin_count = time3
					self:ShowTimeCount(self.left_time)
				end
			else
				if self.cur_day < self.max_day then
					self.window.transform:Find("1011/scroll/Table/"..self.cur_day.."/get").gameObject:SetActive(true)
					self.window.transform:Find("1011/scroll/Table/"..self.cur_day.."/nextday").gameObject:SetActive(false)
					self.window.transform:Find("1011/scroll/Table/"..self.cur_day.."/count_time").gameObject:SetActive(false)
					
					self.cur_day = self.cur_day + 1
					self.left_time = 24*3600
					self.window.transform:Find("1011/scroll/Table/"..self.cur_day.."/gettext").gameObject:SetActive(false)
					self.window.transform:Find("1011/scroll/Table/"..self.cur_day.."/nextday").gameObject:SetActive(true)
					self.window.transform:Find("1011/scroll/Table/"..self.cur_day.."/count_time").gameObject:SetActive(true)
					self:ShowTimeCount(self.left_time)
				else
					self.count_mark1 = false
				end
			end
		end
	end,
	
	ShowTimeCount = function(self,lefttime)
		local win = self.window.transform:Find("1011")
		if (nil ~=win) then
			local text = win:Find("scroll/Table/"..self.cur_day)			
			local h = tonumber(self:DoubleToInt(lefttime/3600))
			local m = tonumber(self:DoubleToInt(lefttime%3600/60))
			local s = tonumber(self:DoubleToInt(lefttime%3600%60))
			local h_str = tostring(h)
			local m_str = tostring(m)
			local s_str = tostring(s)
			
			--GTDebug.LogError(h)
			--GTDebug.LogError(m)
			--GTDebug.LogError(s)
			
			if(h<10) then
				h_str = "0"..h_str
			end
			if(m<10) then
				m_str = "0"..m_str
			end
			if(s<10) then
				s_str = "0"..s_str
			end
			local str = h_str..":"..m_str..":"..s_str..Localization.Get("activities 1011 nextdayget")
			GTTools.ChangeLabeText(text,"count_time",str)
		end
	end,
	
	--转盘
	TweenRotation = function(self,rotation)
		--local _path = self.window.transform:Find(tostring(self.cur_item))
		local obj = self.window.transform:Find("1006/arrowbb")
		
		local tweenR = GTTools.GetTransformComponent(obj, "TweenRotation")
		local from = obj.transform.localRotation.z
		local to = rotation
		if tweenR then
			Object.Destroy(tweenR)	
		end

		tweenR = GTTools.AddGameObjectComponent(obj.gameObject, "TweenRotation")
		tweenR.from = Vector3(0, 0, from)
		tweenR.to = Vector3(0, 0, to)
		tweenR.duration = 3

		tweenR.animationCurve = AnimationCurve()
		tweenR.animationCurve:AddKey(0,0)
		tweenR.animationCurve:AddKey(0.3,0.55)
		tweenR.animationCurve:AddKey(0.5,0.78)
		tweenR.animationCurve:AddKey(0.7,0.92)
		tweenR.animationCurve:AddKey(0.8,0.97)
		tweenR.animationCurve:AddKey(0.9,0.99)
		tweenR.animationCurve:AddKey(1,1)
		self.stop = 0
		
		local del = EventDelegate() 
		del:Set(self.window,"OnTweenFinished")
		del.parameters[0].value = "tweenRfinish"
		tweenR:AddOnFinished(del)
		self:Setrotabutton(false)
	end,
	--设置转盘开始按钮状态
	Setrotabutton = function(self,stat)
			local obj = self.window.transform:Find("1006/buy")
			
			GTTools.GetTransformComponent(obj, "UIButton").isEnabled = stat
	end,
	--转完之后亮灯/灭灯
	lightshow = function(self,show)
		--local tt = 
		self.window.transform:Find("1006/light/"..tostring(self.rotagetlist.operateresult+1)).gameObject:SetActive(show)
		--[[if true == show then
		
			GTTools.GetTransformComponent(obj, "UISprite").spriteName = "light_enable"
		else
			GTTools.GetTransformComponent(obj, "UISprite").spriteName = "light"
		end--]]
		--GTTools.GetTransformComponent(obj, "UISprite"):MakePixelPerfect()
	end,
	
	--转盘转完显示获取到的物品
	rotashow  = function(self)
		local id = {}
		local count = {}
		for i= 1,#(self.rotagetlist.rewardlist) do
			id[i] = self.rotagetlist.rewardlist[i].itemid
			count[i] = self.rotagetlist.rewardlist[i].count
		end 
		ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(self.rotagetlist.rewardlist),id,count)
		self:Setrotabutton(true)
	end,
	
	--[[Tweendel = function(self)
		--if self.close_open_status then
		
		--	GTTools.GetTransformComponent(self.tt[self.close_open_sender], "BoxCollider").enabled=true
		--	GTTools.GetTransformComponent(self.tt[self.close_open_sender+1], "BoxCollider").enabled=true
		--else
			GTTools.GetTransformComponent(self.window.transform:Find("middle"), "UIScrollView").enabled=true	
			for i = 1,self.totleitem do
				GTTools.GetTransformComponent(self.tt[i], "BoxCollider").enabled=true	
			end	
			--if 1 == self.position_stop 	then
				local openstatus = self.open_status[tonumber(self.cur_item)]
				if 0 ==openstatus then 
					local actid=self.activityid[tonumber(self.cur_item)]
					local ss = {activityid=actid}	
					local jsonstr = json.encode(ss)
					self.m_model:UpdateModel("SendDetailRequest",jsonstr)								
				--else
					--self:Tweenpos(tonumber(self.cur_item),true)								
				end
			end	
		--end
		
		GTTools.GetTransformComponent(self.tt[self.totleitem], "BoxCollider").enabled=false
		self.press_status = false	
			
		--打开详细信息界面	
		
		if self.close_open_status then   		
			local _path = tostring(self.activityid[tonumber(self.cur_item)])
			local obj = self.window.transform:Find(_path)
			obj.gameObject:SetActive(true)
		end			
					
	end,]]--
	
	--角色信息获取
	RecvPlayerInfo= function(self, rr)
	self.playerinfo = rr.obj
	end,
	--服务器登陆请求返回
	RecvActiLogin= function(self, rr)
        --GTDebug.LogError("1")	
		self.press_status = false	
		local list = json.decode(rr.obj)
		print(rr.obj)
		local num = #(list.activitylist)
		local _table = self.window.transform:Find("middle")
		local _grid = _table:Find("Grid")
		local base = _grid:Find("a")
		local chose = _table:Find("chose")
		local paths = base.gameobject
		local infos = "null"
		local count = 0;
		for i = 1,num do
		    table.sort(list.activitylist,function(a,b) return a.sequence<b.sequence end)
		end
		--for i = 1,num do
		--    GTDebug.LogError(list.activitylist[i].sequence)
		--end
		
		for i = 1, num do
			if 	1 == list.activitylist[i].isactivity then 
				
				count=count+1				
				self.activityid[count] = list.activitylist[i].activityid
				self.activitysubid[count] = list.activitylist[i].subid
				self.refresh_list[count] = true
				self.open_status[count] = 0
				self.activitylist[count] = list.activitylist[i]
				
				self.subid[count] = list.activitylist[i].subid
				local clone = GTTools.Clone(base,tostring(count)).transform
				self.tt[count] = clone
				infos = tostring(list.activitylist[count].activityid)
				paths = clone:Find("off/icon").gameobject
				
				infos = infos.."s"
				GTTools.ChangeSprite(paths,infos)
				
				paths = clone:Find("titlebg")
				infos = list.activitylist[count].name
				GTTools.ChangeLabeText(paths,"info",infos)
				GTTools.ChangeLabeText(paths,"info1",infos)
				GTTools.ChangeLabeText(paths,"info2",infos)
				GTTools.ChangeLabeText(paths,"info3",infos)
				GTTools.ChangeLabeText(paths,"info4",infos)
                if 1 == count	then			
				clone:Find("titlebg/info1").gameObject:SetActive(true)
				clone:Find("titlebg/info2").gameObject:SetActive(false)
				clone:Find("titlebg/info3").gameObject:SetActive(false)
				clone:Find("titlebg/info4").gameObject:SetActive(false)
				clone:Find("titlebg/info").gameObject:SetActive(false)
				else
				clone:Find("titlebg/info1").gameObject:SetActive(false)
				clone:Find("titlebg/info2").gameObject:SetActive(false)
				clone:Find("titlebg/info3").gameObject:SetActive(false)
				clone:Find("titlebg/info4").gameObject:SetActive(false)
				clone:Find("titlebg/info").gameObject:SetActive(true)
				end
				
				if 1014 == list.activitylist[i].activityid and list.activitylist[i].subid == 1 then
					if self.m_model.discount_mark == false then 
						list.activitylist[i].hasred = false
					end
				end
				
				if 1014 == list.activitylist[i].activityid and list.activitylist[i].subid == 2 then
					if self.m_model.discount_mark1 == false then 
						list.activitylist[i].hasred = false
					end
				end
				
				if 1015 == list.activitylist[i].activityid then
					if self.m_model.arena_sale_login_mark == false then 
						list.activitylist[i].hasred = false
					end
				end
				clone:Find("redpoint").gameobject:SetActive(list.activitylist[i].hasred)
				clone:Find("new").gameobject:SetActive(list.activitylist[i].isnew)
				if 1012 == list.activitylist[i].activityid then
					clone:Find("daily").gameobject:SetActive(true)
				else
					clone:Find("daily").gameobject:SetActive(false)
				end
			end
		end		
		self.totleitem = count
		GTTools.GetTransformComponent(_grid, "UIGrid").repositionNow = true
		
		local ss = {activityid=list.activitylist[1].activityid}	
		local jsonstr = json.encode(ss)
		
		local wordcolor = {["yellow"]=1,["blue"]=2,["pink"]=3,["orange"]=4}
		
        chose.transform.Position = base.transform.Position
		paths = _grid:Find("1/titlebg").gameObject
		infos = "yellow"
		GTTools.ChangeSprite(paths,infos)
		self.cur_item = 1
		--self.m_model:UpdateModel("SendDetailRequest",jsonstr)
		self:LoadScene(list.activitylist[self.cur_item].activityid)

	end,
	
	OnActiveLoadCom = function(self,task)
		local obj = task.objs[0]
		local scene_id = task.param
		obj.gameObject:SetActive(false)
		
		--发送活动细节请求
		local actid=self.activityid[tonumber(self.cur_item)]
		local sid=self.activitysubid[tonumber(self.cur_item)]
		local ss = {activityid=actid,subid=sid}	
		local jsonstr = json.encode(ss)
		self.m_model:UpdateModel("SendDetailRequest",jsonstr)
		
		obj.name = tostring(scene_id)
		obj.transform.parent = self.window.transform
		obj.transform.localPosition = Vector3(-110,-36,0)
		obj.transform.localScale = Vector3(1,1,1)
		GTUIEventDispatcher.SetAllEventTargetToWindow(self.window,obj.gameObject)
	end,
	
	--代替Tweenpos 传入活动预设id，将从UI/activities/读取预设并加载到活动预设
	LoadScene = function(self, scene_id)
		if  self.window.transform:Find(tostring(scene_id)) == nil then 
				--回调函数：设置活动预设初始化内容			
			GTResourceManager.LoadAsyncForLua("ui/activities/"..tostring(scene_id)..".prefab","OnActiveLoadCom",self,scene_id,true)
		else 
			
				
		
			if self.refresh_list[tonumber(self.cur_item)] == false or lastsub ~= self.activitysubid[tonumber(self.cur_item)] then 
				local obj = self.window.transform:Find(tostring(scene_id))
				obj.transform.localPosition = Vector3(-110,-36,0)
				local actid=self.activityid[tonumber(self.cur_item)]
				local sid=self.activitysubid[tonumber(self.cur_item)]
				local ss = {activityid=actid,subid=sid}
				local jsonstr = json.encode(ss)
				self.m_model:UpdateModel("SendDetailRequest",jsonstr)
			elseif scene_id == 1003 and self.m_model.diamond_change_flag == true then -- 如果玩家钻石变动，重刷界面
				local obj = self.window.transform:Find(tostring(scene_id))
				obj.transform.localPosition = Vector3(-110,-36,0)
				local actid=self.activityid[tonumber(self.cur_item)]
				local sid=self.activitysubid[tonumber(self.cur_item)]
				local ss = {activityid=actid,subid=sid}
				local jsonstr = json.encode(ss)
				self.m_model:UpdateModel("SendDetailRequest",jsonstr)
				self.m_model.diamond_change_flag = false
			else 
				self.window.transform:Find(tostring(scene_id)).gameObject:SetActive(true)
				last = self.activityid[tonumber(self.cur_item)]
				lastsub = self.activitysubid[tonumber(self.cur_item)]
				self.changing_activity_tab = false
			end
			
			--local obj = self.window.transform:Find(tostring(scene_id))
			--obj.transform.localPosition = Vector3(-110,-36,0)
			--local actid=self.activityid[tonumber(self.cur_item)]
			--local sid=self.activitysubid[tonumber(self.cur_item)]
			--local ss = {activityid=actid,subid=sid}
			--local jsonstr = json.encode(ss)
			--self.m_model:UpdateModel("SendDetailRequest",jsonstr)
			
			--GTDebug.LogError("send"..tostring(scene_id).."request~~~~~~~~")
		end
	end,
	
	LoadTextureCom = function(self,task)
		local obj = task.objs[0]
		FunctionClass.ChangeTextureFromResource(task.param,obj)
	end,
	
	LoadTexture = function(self,transform,name)
		GTResourceManager.LoadAsyncForLua("icon/"..name..".png","LoadTextureCom",self,transform,false)
	end,
	
	--服务器返回活动内容
	RecvDetailRequest= function(self, rr)
		local actinfo = json.decode(rr.obj)
		print(rr.obj)
		local t = self.cur_item
		last = actinfo.activityid
		lastsub = actinfo.subid
		local openstatus = self.open_status[tonumber(self.cur_item)]
		local _path = self.window.transform:Find(tostring(actinfo.activityid))
		_path.gameObject:SetActive(false)
		
		--添加标题
		--local _name = actinfo.bonusinfo.name
		--GTTools.ChangeLabeText(_path:Find("title"),"name",_name)
		
		--活动子类型
		--self.sub_type = actinfo.bonusinfo.type				
		--GTDebug.LogError(_path)
		
		--对服务器传入的表进行加载和排序，最后整合到reward以便后续使用
		local reward_got = {}
		local reward = {}
		local reward_cantbuy ={}
		
		if (actinfo.bonusinfo ~= nuil) then
			if (actinfo.bonusinfo.rewardlist == nil) then
				if (actinfo.activityid ~= 1006 and actinfo.activityid ~= 1021) then 
					GTDebug.LogError("[IMPORTANT] "..tostring(actinfo.activityid).." rewardlist is null")
					return
				end
			end
		end
		
		if 1001==actinfo.activityid or 1003==actinfo.activityid or 1012==actinfo.activityid or 1013==actinfo.activityid then
		    local listnum = #(actinfo.bonusinfo.rewardlist)
		    for i=1,listnum,1 do
			    local item_temp  = actinfo.bonusinfo.rewardlist[i]
		        if  2 == item_temp.status then
			        table.insert(reward_got,item_temp)
				else
                   	table.insert(reward,item_temp)			
				end 
			end
			local gotnum = #(reward_got)
			for i = 1,gotnum,1 do
			    table.insert(reward,reward_got[i])
			end			
		elseif 1011==actinfo.activityid then
		
			self.bagid = {}
			self.lvlunlock_list = {}
			self.status_array ={}
		    local listnum = #(actinfo.bonusinfo.rewardlist)
		    for i=1,listnum,1 do
			    local item_temp  = actinfo.bonusinfo.rewardlist[i]
		        if  item_temp.status == 1 then
			        table.insert(reward,item_temp)
				elseif item_temp.status == 2 then 
					table.insert(reward_got,item_temp)
				else 
					table.insert(reward_cantbuy,item_temp)
				end 
			end
			local gotnum = #(reward_cantbuy)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_cantbuy[i])
			end

			gotnum = #(reward_got)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_got[i])
			end 
			
			for i = 1,listnum,1 do
				table.insert(self.bagid,reward[i].giftbagid)
				table.insert(self.lvlunlock_list,reward[i].charge)
				table.insert(self.status_array,reward[i].status)
			end
			self.acti_bagid[tonumber(self.cur_item)] = self.bagid 
			self.acti_status_array[tonumber(self.cur_item)] = self.status_array
			
		elseif 1014==actinfo.activityid then
		    local listnum = #(actinfo.bonusinfo.rewardlist)
		    for i=1,listnum,1 do
			    local item_temp  = actinfo.bonusinfo.rewardlist[i]
		        if  item_temp.maxbuy == item_temp.hasbuy then
			        table.insert(reward_got,item_temp)
				else
                   	table.insert(reward,item_temp)			
				end 
			end
			local gotnum = #(reward_got)
			for i = 1,gotnum,1 do
			    table.insert(reward,reward_got[i])
			end			

		elseif 1015==actinfo.activityid then
			local listnum = #(actinfo.bonusinfo.rewardlist)
			self.rank = actinfo.bonusinfo.myrank
			for i=1,listnum,1 do
				local item_temp = actinfo.bonusinfo.rewardlist[i]
				if  item_temp.maxbuy == item_temp.hasbuy  then 
					table.insert(reward_got, item_temp)
				elseif self.rank > item_temp.rank then
					table.insert(reward_cantbuy,item_temp)
				else
					table.insert(reward,item_temp)
				end
			end
			local gotnum = #(reward_cantbuy)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_cantbuy[i])
			end

			gotnum = #(reward_got)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_got[i])
			end 
			
			local total = #(reward)
			for i = 1,total,1 do
				table.insert(self.price_list,reward[i].price)
				table.insert(self.rank_array,reward[i].rank)
			end
		
		
		elseif 1016==actinfo.activityid then
			self.bagid = {}
			self.singleprice_list = {}
			self.status_array ={}
		    local listnum = #(actinfo.bonusinfo.rewardlist)
		    for i=1,listnum,1 do
			    local item_temp  = actinfo.bonusinfo.rewardlist[i]
		        if  item_temp.status == 1 then
			        table.insert(reward,item_temp)
				elseif item_temp.status == 2 then 
					table.insert(reward_got,item_temp)
				else 
					table.insert(reward_cantbuy,item_temp)
				end 
			end
			local gotnum = #(reward_cantbuy)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_cantbuy[i])
			end

			gotnum = #(reward_got)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_got[i])
			end 
			
			for i = 1,listnum,1 do
				
				table.insert(self.bagid,reward[i].giftbagid)
				table.insert(self.singleprice_list,reward[i].charge)
				table.insert(self.status_array,reward[i].status)
			end
			self.acti_bagid[tonumber(self.cur_item)] = self.bagid 
			self.acti_status_array[tonumber(self.cur_item)] = self.status_array
		elseif 1017==actinfo.activityid then
			self.bagid = {}
			self.status_array ={}
		    local listnum = #(actinfo.bonusinfo.rewardlist)
		    for i=1,listnum,1 do
			    local item_temp  = actinfo.bonusinfo.rewardlist[i]
		        if  item_temp.status == 1 then
			        table.insert(reward,item_temp)
				elseif item_temp.status == 2 then 
					table.insert(reward_got,item_temp)
				else 
					table.insert(reward_cantbuy,item_temp)
				end 
			end
			local gotnum = #(reward_cantbuy)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_cantbuy[i])
			end

			gotnum = #(reward_got)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_got[i])
			end

			for i = 1,listnum,1 do
				table.insert(self.bagid,reward[i].giftbagid)
				table.insert(self.status_array,reward[i].status)
			end
			self.acti_bagid[tonumber(self.cur_item)] = self.bagid 
			self.acti_status_array[tonumber(self.cur_item)] = self.status_array

		elseif 1018 ==actinfo.activityid then
			self.bagid = {}
			self.status_array ={}
		    local listnum = #(actinfo.bonusinfo.rewardlist)
			self.player_charge = actinfo.bonusinfo.totalcharge
		    for i=1,listnum,1 do
			    local item_temp  = actinfo.bonusinfo.rewardlist[i]
		        if  item_temp.status == 1 then
			        table.insert(reward,item_temp)
				elseif item_temp.status == 2 then 
					table.insert(reward_got,item_temp)
				else 
					table.insert(reward_cantbuy,item_temp)
				end 
			end
			local gotnum = #(reward_cantbuy)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_cantbuy[i])
			end

			gotnum = #(reward_got)
			for i = 1,gotnum,1 do 
				table.insert(reward,reward_got[i])
			end

			for i = 1,listnum,1 do
				table.insert(self.bagid,reward[i].giftbagid)
				table.insert(self.status_array,reward[i].status)
			end
			self.acti_bagid[tonumber(self.cur_item)] = self.bagid 
			self.acti_status_array[tonumber(self.cur_item)] = self.status_array
			
			
		elseif 1019 == actinfo.activityid then 
			local listnum = #(actinfo.bonusinfo.rewardlist)
			for i = 1, listnum,1 do
				local item_temp = actinfo.bonusinfo.rewardlist[i]
				table.insert(reward,item_temp)
			end
		
		end
										
		--理财基金
		if 1001==actinfo.activityid then
			--self:LoadTexture(_path:Find("bg"),"activity_bg1")
			self.rewardlist[t] = reward
			local title = actinfo.name	
			local _grid = _path:Find("scroll/Table")
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			local str = "VIP"..tostring(self.playerinfo.viplevel);
			GTTools.ChangeLabeText(_path:Find("title"), "cur_vip", str)			
			local array = {}
			local childnum = _path:Find("scroll/Table").childCount
			if childnum > 1 then
				for i = 1,childnum,1 do
					if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
						array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					end
				end
				local num = #(array)
				for i = 1,num,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end
				
			if 1 == actinfo.bonusinfo.buystatus then
				GTTools.SetVisible(_path:Find("buytext").gameobject,true)
				GTTools.SetVisible(_path:Find("buy").gameobject,false)
				
			else
				GTTools.SetVisible(_path:Find("buy").gameobject,true)
				GTTools.SetVisible(_path:Find("buytext").gameobject,false)
			end

			local num = #(actinfo.bonusinfo.rewardlist)
			for i=1,num do
				local bas=_path:Find("scroll/Table/a")	
				
				local describe  = self.rewardlist[t][i].describe
				local title  = self.rewardlist[t][i].title
				local count = self.rewardlist[t][i].rewarditem[1].count
				local itemid    = self.rewardlist[t][i].rewarditem[1].itemid
				local stats=self.rewardlist[t][i].status
				local clone = GTTools.Clone(bas,tostring(i)).transform
				self:Item_BG(clone:Find("a"),count,itemid)
				GTTools.ChangeLabeText(clone:Find("title"), "disc", describe)
				GTTools.ChangeLabeText(clone:Find("title"), "name", title)
				GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
				if stats == 0 then
					clone:Find("gettext").gameobject:SetActive(true)
				elseif stats == 1 then 
					clone:Find("get").gameobject:SetActive(true)
				elseif stats == 2 then
					clone:Find("got").gameobject:SetActive(true)
				end
			end
			
		
			local num = #(actinfo.bonusinfo.rewardlist)
			for i=1,num do
				local bas=_path:Find("scroll/Table/"..tostring(i))	
				local stats=self.rewardlist[t][i].status
				
				bas:Find("get").gameobject:SetActive(false)
				bas:Find("gettext").gameobject:SetActive(false)
				bas:Find("got").gameobject:SetActive(false)

				if stats == 0 then
					bas:Find("gettext").gameobject:SetActive(true)
				elseif stats == 1 then 
					bas:Find("get").gameobject:SetActive(true)
				elseif stats == 2 then
					bas:Find("got").gameobject:SetActive(true)
				end
			end
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(_grid, "UIGrid"):RepositionForLua()
			
			if self.touzibuystatus then			
				self.touzibuystatus = nil
			else
				local _path = self.activityid[tonumber(self.cur_item)]
		        local obj = self.window.transform:Find(_path)			
	            obj.gameObject:SetActive(true)
				self.can_click = false
			end
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIScrollView"):ResetPosition()	
		
		--豪华美食
		elseif 1002 == actinfo.activityid then 
		
			--self:LoadTexture(_path:Find("role"),"activity_tili")
		
			--FunctionClass.ChangeTextureFromResource(_path:Find("role"),)
			self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			self.timerange = actinfo.timelist
			local title = actinfo.name
			
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)		 
			if self.rewardlist[t] then
				local temp = self.rewardlist[t][1].rewarditem
				if temp then 
					local itemid = temp[1].itemid
					local count =  temp[1].count
					self:Item_BG(_path:Find("item/a"),count,itemid)
				end 				
					local stats=self.rewardlist[t][1].status
					if 1 == stats then
						_path:Find("get").gameobject:SetActive(true)
						_path:Find("buytext").gameobject:SetActive(false)
					else 
						_path:Find("get").gameobject:SetActive(false)
						_path:Find("buytext").gameobject:SetActive(true)
						GTTools.ChangeLabeText(_path, "buytext", self:NextShowTime())					
					end
			end
			
			local _path = self.activityid[tonumber(self.cur_item)]
		    local obj = self.window.transform:Find(_path)			
	        obj.gameObject:SetActive(true)
			self.can_click = false	
		--钻石消费
		elseif 1003 == actinfo.activityid then 
			self.rewardlist[t] = reward
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			local _grid = _path:Find("scroll/Table")
			local costcount = actinfo.bonusinfo.dailycostcount 
			GTTools.ChangeLabeText(_path:Find("title"), "info2",costcount)
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			
			local childnum = _path:Find("scroll/Table").childCount
		    local array = {}
			if childnum>1 then
			    for i = 0,childnum-1,1 do
				    if _path:Find("scroll/Table"):GetChild(i).name~="a" then					     
					     array[i] = _path:Find("scroll/Table"):GetChild(i).gameObject
					     
				    end
			    end
				for i=1,childnum-1,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
				     Object.Destroy(array[i])
				end				  				  
			end	
			
			local num = #(actinfo.bonusinfo.rewardlist)
			for i=1,num do
				local bas=_path:Find("scroll/Table/a")	
				local title  = self.rewardlist[t][i].title
				local stats=self.rewardlist[t][i].status
				local clone = GTTools.Clone(bas,tostring(i)).transform
				GTTools.ChangeLabeText(clone:Find("title"), "name", title)					
				local temp = self.rewardlist[t][i].rewarditem
				if temp then 
										
					local itemnum = #temp
					local basic = clone:Find("grid/a")
					local _grid1 = clone:Find("grid")
					for j=1,itemnum do
						local clones = GTTools.Clone(basic,tostring(j)).transform
						self:Item_BG(clones,temp[j].count,temp[j].itemid)
					end
					GTTools.GetTransformComponent(_grid1, "UIGrid").repositionNow = true
					
					if stats == 0 then
						clone:Find("get").gameobject:SetActive(false)
						clone:Find("gettext").gameobject:SetActive(true)
						clone:Find("got").gameobject:SetActive(false)
					elseif stats == 1 then 
						clone:Find("get").gameobject:SetActive(true)
						clone:Find("gettext").gameobject:SetActive(false)
						clone:Find("got").gameobject:SetActive(false)
					elseif stats == 2 then
						clone:Find("get").gameobject:SetActive(false)
						clone:Find("gettext").gameobject:SetActive(false)
						clone:Find("got").gameobject:SetActive(true)
					end
				end
			end
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(_grid, "UIGrid"):RepositionForLua()
			local scrollview = _path:Find("scroll")
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition()				
			self.can_click = false
			
		--单日充值好礼
		elseif 1004 == actinfo.activityid then 
			local danrichongzhi = self.window.transform:Find("middle/"..tostring(self.cur_item).."/detail")
			self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)		
			 
			local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities time3")
			GTTools.ChangeLabeText(_path:Find("title"), "info", str)
							
			local num = #(actinfo.bonusinfo.rewardlist)
			for i=1,num do
				local bas=_path:Find("scroll/Table/a")	
				local stats=self.rewardlist[t][i].status
				local clone = GTTools.Clone(bas,tostring(i)).transform
				clone.transform.localPosition=Vector3(bas.transform.localPosition.x, bas.transform.localPosition.y-145*(i-1), bas.transform.localPosition.z)				
				local temp = self.rewardlist[t][i].rewarditem
				if temp then
					local itemnum = #temp
					local basic = clone:Find("a")
					for j=1,itemnum do
						local clones = GTTools.Clone(basic,tostring(j)).transform
						clones.transform.localPosition=Vector3(basic.transform.localPosition.x+92*(j-1), basic.transform.localPosition.y, basic.transform.localPosition.z)
						self:Item_BG(clones,temp[j].count,temp[j].itemid)
					end
							
					if stats == 0 then
						clone:Find("gettext").gameobject:SetActive(true)
					elseif stats == 1 then 
						clone:Find("get").gameobject:SetActive(true)
					elseif stats == 2 then
						clone:Find("got").gameobject:SetActive(true)
					end
				end
			end
			self.can_click = false	

		--命运转盘
		elseif 1006 == actinfo.activityid then 
			local zhuanpan = self.window.transform:Find("middle/"..tostring(self.cur_item).."/detail")
			self.rewardlist[t] = actinfo.bonusinfo.wheelitem
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)		
			if 0 == openstatus then 
				self.rotarestime = actinfo.bonusinfo.leftcount
				GTTools.ChangeLabeText(_path,"resnum",tostring(self.rotarestime))	
				local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities time2")
				GTTools.ChangeLabeText(_path:Find("title"), "info",str)
				_path:Find("title/info").gameObject:SetActive(false)
				
				local listnum = #(self.rewardlist[t])
				for i =1,listnum do
					local pt = _path:Find("giftbg/"..tostring(i))
					local itemid = self.rewardlist[t][i].itemid
					local count = self.rewardlist[t][i].count
					self:Item_BG(pt,count,itemid)				
					FunctionClass.ChangeTexture(pt,itemid)
				end
			end

			self.can_click = false
				
		--元旦击杀---竞技场宝箱奖励
		elseif 1007 == actinfo.activityid then 
			self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)		
			if 0==openstatus then 
				local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities time0")
				GTTools.ChangeLabeText(_path:Find("title"), "info",str)	
				_path:Find("title/info").gameObject:SetActive(false)
				local temp1 = self.rewardlist[t][1].rewarditem
				local temp2 = self.rewardlist[t][2].rewarditem
				local basic1 = _path:Find("1")				
				local basic2 = _path:Find("2")
				local effect1 = basic1:Find("jingji_huodongbaoxiang")
				local effect2 = basic2:Find("jingji_huodongbaoxiang")
				if(1==self.rewardlist[t][1].type) then
                    local tran1 = basic1:Find("0")	
					local tran2 = basic1:Find("1")
				    local count1 = temp1[1].count
				    local itemid1 = temp1[1].itemid
					local count2 = temp1[2].count
				    local itemid2 = temp1[2].itemid
				    self:Item_BG(tran1,count1,itemid1)
					self:Item_BG(tran2,count2,itemid2)
					local stats1=self.rewardlist[t][1].status
					self.bagid[1] = self.rewardlist[t][1].giftbagid
					self.bagid[2] = self.rewardlist[t][2].giftbagid
					self.acti_bagid[self.cur_item] = self.bagid
					GTTools.ChangeLabeText(basic1,"name",self.rewardlist[t][1].giftname)	
					GTTools.ChangeLabeText(basic2,"name",self.rewardlist[t][2].giftname)	
					if 0 == stats1 then
						basic1:Find("buytext").gameobject:SetActive(true)
						effect1.gameObject:SetActive(false)
                        self.already[1] = true						
					elseif 1 == stats1 then
						basic1:Find("get").gameobject:SetActive(true)
						effect1.gameObject:SetActive(true)
						self.already[1] = false	
					elseif 2 == stats1 then
						basic1:Find("got").gameobject:SetActive(true)
						effect1.gameObject:SetActive(false)
						self.already[1] = true	
					end
					
					local tran3 = basic2:Find("0")	
					local tran4 = basic2:Find("1")
				    local count3 = temp2[1].count
				    local itemid3 = temp2[1].itemid
					local count4 = temp2[2].count
				    local itemid4 = temp2[2].itemid
				    self:Item_BG(tran3,count3,itemid3)
					self:Item_BG(tran4,count4,itemid4)
					local stats2=self.rewardlist[t][2].status
					if 0 == stats2 then
						basic2:Find("buytext").gameobject:SetActive(true)
						effect2.gameObject:SetActive(false)
                        self.already[2] = true							
					elseif 1 == stats2 then
						basic2:Find("get").gameobject:SetActive(true)
						effect2.gameObject:SetActive(true)
						self.already[2] = false	
					elseif 2 == stats2 then
						basic2:Find("got").gameobject:SetActive(true)
						effect2.gameObject:SetActive(false)
						self.already[2] = true	
					end				
				else
                    local tran1 = basic1:Find("0")	
					local tran2 = basic1:Find("1")
				    local count1 = temp2[1].count
				    local itemid1 = temp2[1].itemid
					local count2 = temp2[2].count
				    local itemid2 = temp2[2].itemid
				    self:Item_BG(tran1,count1,itemid1)
					self:Item_BG(tran2,count2,itemid2)
					local stats1=self.rewardlist[t][2].status

					if 0 == stats1 then
						basic1:Find("buytext").gameobject:SetActive(true)
						effect1.gameObject:SetActive(false)
                        self.already[1] = true							
					elseif 1 == stats1 then
						basic1:Find("get").gameobject:SetActive(true)
						effect1.gameObject:SetActive(true)
						self.already[1] = false	
					elseif 2 == stats1 then
						basic1:Find("got").gameobject:SetActive(true)
						effect1.gameObject:SetActive(false)
						self.already[1] = true	
					end
					self.bagid[1] = self.rewardlist[t][2].giftbagid
					self.bagid[2] = self.rewardlist[t][1].giftbagid
					GTTools.ChangeLabeText(basic1,"name",self.rewardlist[t][2].giftname)	
					GTTools.ChangeLabeText(basic2,"name",self.rewardlist[t][1].giftname)
					local tran3 = basic2:Find("0")	
					local tran4 = basic2:Find("1")
				    local count3 = temp1[1].count
				    local itemid3 = temp1[1].itemid
					local count4 = temp1[2].count
				    local itemid4 = temp1[2].itemid
				    self:Item_BG(tran3,count3,itemid3)
					self:Item_BG(tran4,count4,itemid4)
					local stats2=self.rewardlist[t][1].status
					if 0 == stats2 then
						basic2:Find("buytext").gameobject:SetActive(true)
						effect2.gameObject:SetActive(false)
						self.already[2] = true	
					elseif 1 == stats2 then
						basic2:Find("get").gameobject:SetActive(true)
						effect2.gameObject:SetActive(true)
						self.already[2] = false	
					elseif 2 == stats2 then
						basic2:Find("got").gameobject:SetActive(true)
						effect2.gameObject:SetActive(false)
						self.already[2] = true	
					end			
				end
				
			end
			self.can_click = false
		
		--双倍副本		
		elseif 1008 == actinfo.activityid then
            local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)			
			if 0 == openstatus then 
				local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities time3")
				GTTools.ChangeLabeText(_path:Find("title"), "info",str)
					
			end

				self.can_click = false
		--副本集字	
		elseif 1009 == actinfo.activityid then 
			self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)	
			if 0== openstatus then 
				local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities time0")
				GTTools.ChangeLabeText(_path:Find("title"), "info", str)
				_path:Find("title/info").gameObject:SetActive(false) 
				local pp = self.rewardlist[t][1].wordlist
				if pp then
					local ppnum = #pp
					self.fubecount = pp[1].objectnum
					for m=1,ppnum do
						local tt = _path:Find("title/"..tostring(m))
						local objectid = pp[m].objectid											
						local objectnum = pp[m].objectnum
						if 0 == objectnum then
							local stpath = tostring(objectid).."_gray.png"
							FunctionClass.ChangeTextureForLua(tt,stpath)
						else
							local stpath1 = tostring(objectid)..".png"
							FunctionClass.ChangeTextureForLua(tt,stpath1)
							if self.fubecount >= objectnum then
								self.fubecount = objectnum						
							end
						end

						if objectnum > 1 then 
							local cc = _path:Find("title/"..tostring(m).."/count")
							GTTools.ChangeLabeText(cc, "", tostring(objectnum))
							cc.gameObject:SetActive(true)
						end
							
					end
									
				end
				local temp = self.rewardlist[t][1].rewarditem
				if temp then
					local itemnum = #temp
					local basic = _path:Find("item/a")
					for j=1,itemnum do
						local clones = GTTools.Clone(basic,tostring(j)).transform
						clones.transform.localPosition=Vector3(basic.transform.localPosition.x+80*(j-1), basic.transform.localPosition.y, basic.transform.localPosition.z)
						local count = temp[j].count
						local itemid    = temp[j].itemid
						self:Item_BG(clones,count,itemid)

						local stats=self.rewardlist[t][1].status
						if 0 == stats then
							GTTools.SetVisible(_path:Find("buytext").gameObject,true)
			
						elseif 1 == stats then
							GTTools.SetVisible(_path:Find("get").gameObject,true)
						elseif 2 == stats then
							GTTools.SetVisible(_path:Find("got").gameObject,true)
						end
					end
				end
				
				
			end

			self.can_click = false
		elseif 1010 == actinfo.activityid then 
		    self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			GTTools.GetTransformComponent(_path:Find("item_bg/Scroll"), "UIPanel").depth = self.panel_depth + 1;
			local curfloor = actinfo.bonusinfo.rewardlist[1].currentfloor
			local nextfloor = actinfo.bonusinfo.rewardlist[1].nextfloor
			local giftfloor = actinfo.bonusinfo.rewardlist[1].giftfloor	

			local base = _path:Find("item_bg/Scroll/Grid/a")
			local pp = Localization.Get("activities 1010 info1")
		    local str = String.Format(pp,curfloor,nextfloor)
			GTTools.ChangeLabeText(_path, "buytext", str)
		    GTTools.ChangeLabeText(_path:Find("role"),"cur",tostring(giftfloor))
		    pp = Localization.Get("activities 1010 info2")
		    str = String.Format(pp,giftfloor)
		    GTTools.ChangeLabeText(_path, "item_bg/title/Label", str)
		    local childnum = _path:Find("item_bg/Scroll/Grid").childCount
		    local array = {}
		   
		    if childnum>1 then
			    for i = 0,childnum-1,1 do
					if _path:Find("item_bg/Scroll/Grid"):GetChild(i).name~="a" then					     
					 array[i] = _path:Find("item_bg/Scroll/Grid"):GetChild(i).gameObject
					 
					end
				end
				for i=1,childnum-1,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end			   			   			   
			   		   
            local count  = #(self.rewardlist[t][1].rewarditem)
			for i = 1,count,1 do
			       
			    local clone = GTTools.Clone(base,tostring(i))
			    local num = actinfo.bonusinfo.rewardlist[1].rewarditem[i].count
			    local id = actinfo.bonusinfo.rewardlist[1].rewarditem[i].itemid
			    local name = actinfo.bonusinfo.rewardlist[1].rewarditem[i].name
			    self:Item_BG(clone.transform,num,id) 
			    GTTools.ChangeLabeText(clone.transform,"name",name)

			end
			_path.gameObject:SetActive(true)
			--GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			GTTools.GetTransformComponent(_path:Find("item_bg/Scroll/Grid"), "UIGrid"):RepositionForLua()
			local substatus = false
            if 0==self.rewardlist[t][1].status	then
			    _path:Find("get").gameObject:SetActive(false)
				_path:Find("unget").gameObject:SetActive(true)
				self.activitylist[tonumber(self.cur_item)].hasred = false
				substatus = false
			elseif 1==self.rewardlist[t][1].status	then
			    _path:Find("get").gameObject:SetActive(true)
				_path:Find("unget").gameObject:SetActive(false)
				self.activitylist[tonumber(self.cur_item)].hasred = true
				substatus = true
			elseif  2==self.rewardlist[t][1].status	then
				self.activitylist[tonumber(self.cur_item)].hasred = false
				substatus = false
			    _path:Find("item_bg").gameObject:SetActive(false)
			    _path:Find("bg").gameObject:SetActive(false)
			    _path:Find("role").gameObject:SetActive(false)
			    _path:Find("buytext").gameObject:SetActive(false)
			    _path:Find("get").gameObject:SetActive(false)
			    _path:Find("unget").gameObject:SetActive(false)
			    _path:Find("full").gameObject:SetActive(true)
            end	
		    self:judgeredpoint(substatus)
		    self.secretid = self.rewardlist[t][1].giftbagid
			self.can_click = false
		
		elseif 1011 == actinfo.activityid then
			self.rewardlist[t] = reward
			local title = actinfo.name
			local base = _path:Find("scroll/Table/a")
			local grid = _path:Find("scroll/Table")
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/Scroll"), "UIPanel").depth = self.panel_depth + 5;	
			local itemlist = self.rewardlist[t]
			local num = #(itemlist)
			local childnum = _path:Find("scroll/Table").childCount
			local array = {}
			   
			if childnum>1 then
			    for i = 0,childnum-1,1 do
				    if _path:Find("scroll/Table"):GetChild(i).name~="a" then					     
					     array[i] = _path:Find("scroll/Table"):GetChild(i).gameObject
					     
				    end
			    end
				for i=1,childnum-1,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
				     Object.Destroy(array[i])
				end				  				  
			end	
			
			local gift_id = self.rewardlist[t][1].giftbagid
			local cost_num = self.rewardlist[t][1].level
			local hasbuy = self.rewardlist[t][1].status
			local leftsec = 0
			local n = #(self.rewardlist[t][1].rewarditem)
			local item_id = 0;
			local item_num = 0;
		
			self.cur_day = 0
			self.max_day = num
			for i = 1,num,1 do 
				local clone = GTTools.Clone(base,i).transform	
				local get = clone:Find("get")
				local gettext = clone:Find("gettext")
				local got = clone:Find("got")
				local next_get = clone:Find("nextday")
				local time_text = clone:Find("count_time")
				
				gift_id = self.rewardlist[t][i].giftbagid
				cost_num = self.rewardlist[t][i].level
				hasbuy = self.rewardlist[t][i].status
				
				if(self.rewardlist[t][i].leftsec~=nil) then
					leftsec = self.rewardlist[t][i].leftsec
				end
				
				local str = self.rewardlist[t][i].describe
				GTTools.ChangeLabeText(clone:Find("banner"), "1", str)
				
				if (hasbuy == 0) then 	
					if(leftsec == -1) then
						gettext.gameObject:SetActive(true)
						time_text.gameObject:SetActive(false)
						next_get.gameObject:SetActive(false)
					elseif (leftsec ~= 0) then
						gettext.gameObject:SetActive(false)
						time_text.gameObject:SetActive(true)
						next_get.gameObject:SetActive(true)
						self.left_time = leftsec
						self.begin_count = os.time()
						self.count_mark1 = true
						self.cur_day = i						
						local h = tonumber(self:DoubleToInt(leftsec/3600))
						local m = tonumber(self:DoubleToInt(leftsec%3600/60))
						local s = tonumber(self:DoubleToInt(leftsec%3600%60))
						local h_str = tostring(h)
						local m_str = tostring(m)
						local s_str = tostring(s)
						--GTDebug.LogError(h)
						--GTDebug.LogError(m)
						--GTDebug.LogError(s)
						if(h<10) then
							h_str = "0"..h_str
						end
						if(m<10) then
							m_str = "0"..m_str
						end
						if(s<10) then
							s_str = "0"..s_str
						end
						local str = h_str..":"..m_str..":"..s_str..Localization.Get("activities 1011 nextdayget")
						GTTools.ChangeLabeText(clone,"count_time",str)
					else
						gettext.gameObject:SetActive(true)
					end
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(false) 
				elseif (hasbuy == 1) then 
					gettext.gameObject:SetActive(false)
					get.gameObject:SetActive(true)
					got.gameObject:SetActive(false)
					time_text.gameObject:SetActive(false)
					next_get.gameObject:SetActive(false)
				else
					gettext.gameObject:SetActive(false)
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(true)
					time_text.gameObject:SetActive(false)
					next_get.gameObject:SetActive(false)
				end 
					
				--table.insert(self.hasbuy_array,hasbuy)
				
				local base1 = clone:Find("Scroll/Grid/a")
				local grid1 = clone:Find("Scoll/Grid")	
				n = #(self.rewardlist[t][i].rewarditem)	
				--GTDebug.LogError(n)
				for j = 1,n do
					--GTDebug.LogError("____________")
					--GTDebug.LogError(j)
					--GTDebug.LogError(self.rewardlist[t][i].rewarditem[j])
					local tempt = clone:Find("Scroll/Grid/"..tostring(j))										
					--GTDebug.LogError(self.rewardlist[t][i].rewarditem[j].itemid)
					item_id = self.rewardlist[t][i].rewarditem[j].itemid	
					item_num = self.rewardlist[t][i].rewarditem[j].count				   
					self:Item_BG(tempt,item_num,item_id)
					if 0 == item_id then
						tempt.gameObject:SetActive(false)
					else
						tempt.gameObject:SetActive(true)
					end  
				end
			end
			local scrollview = _path:Find("scroll")
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			self.can_click = false
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition()
			
			---------------------------------------------------------

		elseif 1012 == actinfo.activityid then
			self.rewardlist[t] = reward
			local title = actinfo.name
			local base = _path:Find("scroll/Table/a")
			local grid = _path:Find("scroll/Table")
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			--local str = self:ShowEndTime(actinfo.timelist[1].endtime,"activities 1012 time")
			local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities 1012 time1")
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.ChangeLabeText(_path:Find("title"), "time", str)
			local itemlist = self.rewardlist[t]
			local num = #(itemlist)
			local childnum = _path:Find("scroll/Table").childCount
			local array = {}
				
			    if childnum>1 then
			        for i = 0,childnum-1,1 do

						if _path:Find("scroll/Table"):GetChild(i).name~="a" then					     
							array[i] = _path:Find("scroll/Table"):GetChild(i).gameObject 
						end
					end
					for i=1,childnum-1,1 do
						if array[i] ~= nil then 
							array[i]:SetActive(false)
						end 
						Object.Destroy(array[i])
					end				  				  
				end	
			
			for i=1,num,1 do
				local clone = GTTools.Clone(base,i).transform
				local win = actinfo.bonusinfo.winnum
				local maxwin = self.rewardlist[t][i].win
				local title = self.rewardlist[t][i].describe
				local title2 = Localization.Get("activities 1012 progress")
				title2 = String.Format(title2,win,maxwin)
				GTTools.ChangeLabeText(clone, "title/Label", title)
				GTTools.ChangeLabeText(clone, "progress", title2)
				if 0 == itemlist[i].status then
					clone:Find("goto").gameObject:SetActive(true)
					clone:Find("get").gameObject:SetActive(false)
					clone:Find("got").gameObject:SetActive(false)
				elseif 1 == itemlist[i].status then 
					clone:Find("goto").gameObject:SetActive(false)
					clone:Find("get").gameObject:SetActive(true)
					clone:Find("got").gameObject:SetActive(false)
				elseif 2 == itemlist[i].status then
					clone:Find("goto").gameObject:SetActive(false)
					clone:Find("get").gameObject:SetActive(false)
					clone:Find("got").gameObject:SetActive(true)
				end
				local n = #(self.rewardlist[t][i].rewarditem)
				local base1 = clone:Find("Grid/a")
				local grid1 = clone:Find("Grid")
				for j = 1,n,1 do
					local clone1 = GTTools.Clone(base1,tostring(j)).transform
					local num = self.rewardlist[t][i].rewarditem[j].count
					local id = self.rewardlist[t][i].rewarditem[j].itemid
					self:Item_BG(clone1,num,id)
				end
				GTTools.GetTransformComponent(grid1, "UIGrid").repositionNow = true 
			end   
			local scrollview = _path:Find("scroll")
		    _path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			self.can_click = false 
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition()
		elseif 1016 == actinfo.activityid then
			GTTools.ChangeLabeText(_path:Find("title"),"name",actinfo.name)
			local info1016 = Localization.Get("activities 1016 info1")..actinfo.describe
			GTTools.ChangeLabeText(_path:Find("title"),"info1",info1016)
			self.rewardlist[t] = reward 
			local temp = _path:Find("scroll/Table/a")
			local grid = _path:FInd("scroll/Table")
			local num = #(self.rewardlist[t])
			local array = {}
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/Scroll"), "UIPanel").depth = self.panel_depth + 5;	
			local childnum = _path:Find("scroll/Table").childCount
			if childnum > 1 then
				for i = 1,childnum,1 do
					if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
						array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					end
				end
				local num = #(array)
				for i = 1,num,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end	
			local gift_id = self.rewardlist[t][1].giftbagid
			local cost_num = self.rewardlist[t][1].charge
			local hasbuy = self.rewardlist[t][1].status
			local n = #(self.rewardlist[t][1].rewarditem)
			local item_id = 0;
			local item_num = 0;
		
			local str = self:ShowEndTime1(actinfo.timelist[1].endtime,"activities 1016 time")
			local endtime = _path:Find("title/time")
			GTTools.ChangeLabeText(endtime, "", str)
			
			for i = 1,num,1 do 
				local clone = GTTools.Clone(temp,i).transform	
				local get = clone:Find("get")
				local buy = clone:Find("buy1")
				local got = clone:Find("got")
				
				gift_id = self.rewardlist[t][i].giftbagid
				cost_num = self.rewardlist[t][i].charge
				hasbuy = self.rewardlist[t][i].status
				
				if (hasbuy == 0) then 
					GTTools.ChangeLabeText(clone, "banner/remain","1")
					buy.gameObject:SetActive(true)
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(false) 
				elseif (hasbuy == 1) then 
					GTTools.ChangeLabeText(clone, "banner/remain","1")
					buy.gameObject:SetActive(false)
					get.gameObject:SetActive(true)
					got.gameObject:SetActive(false)
				else
					GTTools.ChangeLabeText(clone, "banner/remain","0")
					buy.gameObject:SetActive(false)
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(true)
				end 
				
				GTTools.ChangeLabeText(clone, "banner/p", tostring(cost_num))
					
				--table.insert(self.hasbuy_array,hasbuy)
				
				n = #(self.rewardlist[t][i].rewarditem)
				local base1 = clone:Find("Scroll/Grid/a")
				local grid1 = clone:Find("Scoll/Grid")
				--table.insert(self.count,n)
				
				for j = 1,n,1 do				       
					local tempt = clone:Find("Scroll/Grid/"..tostring(j))					   
					item_id = self.rewardlist[t][i].rewarditem[j].itemid	
					item_num = self.rewardlist[t][i].rewarditem[j].count				   
					self:Item_BG(tempt,item_num,item_id)
					if 0 == item_id then
						tempt.gameObject:SetActive(false)
					else
						tempt.gameObject:SetActive(true)
					end  
				end
			end
			local scrollview = _path:Find("scroll")
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			local _path = self.activityid[tonumber(self.cur_item)]
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition() 
			
		elseif 1017 == actinfo.activityid then
			GTTools.ChangeLabeText(_path:Find("title"),"name",actinfo.name)
			local info1017 = Localization.Get("activities 1017 info1")..actinfo.describe
			GTTools.ChangeLabeText(_path:Find("title"),"info1",info1017)
			self.rewardlist[t] = reward 
			self.loginday = actinfo.bonusinfo.loginday
			local temp = _path:Find("scroll/Table/a")
			local grid = _path:FInd("scroll/Table")
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/Scroll"), "UIPanel").depth = self.panel_depth + 5;	
			local num = #(self.rewardlist[t])
			local array = {}
			local childnum = _path:Find("scroll/Table").childCount
			if childnum > 1 then
				for i = 1,childnum,1 do
					if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
						array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					end
				end
				local num = #(array)
				for i = 1,num,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end
				
			local gift_id = self.rewardlist[t][1].giftbagid
			local day = self.rewardlist[t][1].day
			local status = self.rewardlist[t][1].status
			local n = #(self.rewardlist[t][1].rewarditem)
			local item_id = 0;
			local item_num = 0;
			
			--local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities 1016 time")
			local str = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities 1016 time1")
			GTTools.ChangeLabeText(_path:Find("title"), "timelabel", str)
			
			for i = 1,num,1 do 
				local clone = GTTools.Clone(temp,i).transform	
				local get = clone:Find("get")
				local cantget = clone:Find("cantget")
				local got = clone:Find("got")
				
				gift_id = self.rewardlist[t][i].giftbagid
				day = self.rewardlist[t][i].day
				status = self.rewardlist[t][i].status
				
				if (status == 0) then 
					cantget.gameObject:SetActive(true)
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(false) 
				elseif (status == 1) then 
					cantget.gameObject:SetActive(false)
					get.gameObject:SetActive(true)
					got.gameObject:SetActive(false)
				else
					cantget.gameObject:SetActive(false)
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(true)
				end 
				
				GTTools.ChangeLabeText(clone, "banner/p", tostring(day))
				GTTools.ChangeLabeText(clone, "banner/rank", tostring(self.loginday).."/"..tostring(day))
					
				table.insert(self.day_array,day)
				
				n = #(self.rewardlist[t][i].rewarditem)
				local base1 = clone:Find("Scroll/Grid/a")
				local grid1 = clone:Find("Scoll/Grid")
				--table.insert(self.count,n)
				
				for j = 1,n,1 do				       
				   local tempt = clone:Find("Scroll/Grid/"..tostring(j))					   
				   local item_id = self.rewardlist[t][i].rewarditem[j].itemid	
				   local item_num = self.rewardlist[t][i].rewarditem[j].count				   
				   self:Item_BG(tempt,item_num,item_id)
					if 0 == item_id then
						tempt.gameObject:SetActive(false)
					else
						tempt.gameObject:SetActive(true)
					end  
				end
			end
			local scrollview = _path:Find("scroll")
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			--local _path = self.activityid[tonumber(self.cur_item)]
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition() 
			
		elseif 1018 == actinfo.activityid then
			GTTools.ChangeLabeText(_path:Find("title"),"name",actinfo.name)
			local info1018 = Localization.Get("activities 1018 info1")..actinfo.describe
			GTTools.ChangeLabeText(_path:Find("title"),"info1",info1018)
			self.rewardlist[t] = reward 
			local temp = _path:Find("scroll/Table/a")
			local grid = _path:FInd("scroll/Table")
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/Scroll"), "UIPanel").depth = self.panel_depth + 5;	
			local num = #(self.rewardlist[t])
			local array = {}
			local childnum = _path:Find("scroll/Table").childCount
			if childnum > 1 then
				for i = 1,childnum,1 do
					if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
						array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					end
				end
				local num = #(array)
				for i = 1,num,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end
			local gift_id = self.rewardlist[t][1].giftbagid
			local cost_num = self.rewardlist[t][1].charge
			local hasbuy = self.rewardlist[t][1].status
			local maxcharge = self.rewardlist[t][1].charge
			local n = #(self.rewardlist[t][1].rewarditem)
			local item_id = 0;
			local item_num = 0;
			
			local str = self:ShowEndTime1(actinfo.timelist[1].endtime,"activities 1016 time")
			GTTools.ChangeLabeText(_path:Find("title"), "time", str)
			
			for i = 1,num,1 do 
				local clone = GTTools.Clone(temp,i).transform	
				local get = clone:Find("get")
				local buy = clone:Find("buy1")
				local got = clone:Find("got")
				
				gift_id = self.rewardlist[t][i].giftbagid
				cost_num = self.rewardlist[t][i].charge
				hasbuy = self.rewardlist[t][i].status
				maxcharge = self.rewardlist[t][i].charge
				
				if (hasbuy == 0) then 
					buy.gameObject:SetActive(true)
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(false) 
				elseif (hasbuy == 1) then 
					buy.gameObject:SetActive(false)
					get.gameObject:SetActive(true)
					got.gameObject:SetActive(false)
				else
					buy.gameObject:SetActive(false)
					get.gameObject:SetActive(false)
					got.gameObject:SetActive(true)
				end 
				
				GTTools.ChangeLabeText(clone, "banner/p", tostring(cost_num))
				GTTools.ChangeLabeText(clone, "banner/chargemax",tostring(self.player_charge).. "/"..tostring(cost_num))
					
				--table.insert(self.hasbuy_array,hasbuy)
				
				n = #(self.rewardlist[t][i].rewarditem)
				local base1 = clone:Find("Scroll/Grid/a")
				local grid1 = clone:Find("Scoll/Grid")
				--table.insert(self.count,n)
				
				for j = 1,n,1 do				       
				   local tempt = clone:Find("Scroll/Grid/"..tostring(j))					   
				   local item_id = self.rewardlist[t][i].rewarditem[j].itemid	
				   local item_num = self.rewardlist[t][i].rewarditem[j].count				   
				   self:Item_BG(tempt,item_num,item_id)
					if 0 == item_id then
						tempt.gameObject:SetActive(false)
					else
						tempt.gameObject:SetActive(true)
					end  
				end
			end
			local scrollview = _path:Find("scroll")
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			self.can_click = false
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition() 
			
		elseif 1019 == actinfo.activityid then
			GTTools.ChangeLabeText(_path:Find("title"),"name",actinfo.name)
			self.rewardlist[t] = reward 
			local temp = _path:Find("scroll/Table/a")
			local grid = _path:FInd("scroll/Table")
			local time1 = _path:Find("time1")
			local time2 = _path:Find("time2")
			local myrank = _path:Find("rank")
			local potency = _path:Find("potency")
			local fightrank = actinfo.bonusinfo.myrank
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/Scroll"), "UIPanel").depth = self.panel_depth + 5;	
			
			local num = #(self.rewardlist[t])
			local array = {}
			local childnum = _path:Find("scroll/Table").childCount
			if childnum > 1 then
				for i = 1,childnum,1 do
					if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
						array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					end
				end
				local num = #(array)
				for i = 1,num,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end
			local gift_id = self.rewardlist[t][1].giftbagid
			local rankmin = self.rewardlist[t][1].rankmin
			local rankmax = self.rewardlist[t][1].rankmax
			
			local n = #(self.rewardlist[t][1].rewarditem)
			local item_id = 0;
			local item_num = 0;
			
			local str = self:ShowEndTime1(actinfo.timelist[1].endtime,"activities 1016 time")
			GTTools.ChangeLabeText(time1, "", str)
			GTTools.ChangeLabeText(time2, "", str)
			GTTools.ChangeLabeText(potency, "", tostring(self.playerinfo.fightvalue))
			GTTools.ChangeLabeText(myrank,"",tostring(fightrank))
			for i = 1,num,1 do 
			
				
				
				local clone = GTTools.Clone(temp,i).transform	
				
				gift_id = self.rewardlist[t][i].giftbagid
				rankmin = self.rewardlist[t][i].rankmin
				rankmax = self.rewardlist[t][i].rankmax
				
				if rankmax == rankmin then 
					GTTools.ChangeLabeText(clone, "banner/p", tostring(rankmax))
				else
					GTTools.ChangeLabeText(clone,"banner/p",tostring(rankmin).."-"..tostring(rankmax))
				end
				
				GTTools.ChangeSprite(clone:Find("banner/rankicon").gameObject,"c"..tostring(i),52,44)
				local banner = clone:Find("banner/bg")
				if i == 1 then 
					GTTools.ChangeSprite(banner.gameObject,"discount3")
				elseif i == 2 then
					GTTools.ChangeSprite(banner.gameObject,"discount5")
				elseif i == 3 then 
					GTTools.ChangeSprite(banner.gameObject,"discount2")
				else
					GTTools.ChangeSprite(banner.gameObject,"item_bg")
				end
				

				n = #(self.rewardlist[t][i].rewarditem)
				local base1 = clone:Find("Scroll/Grid/a")
				local grid1 = clone:Find("Scoll/Grid")
				
				for j = 1,n,1 do				       
					local tempt = clone:Find("Scroll/Grid/"..tostring(j))					   
					item_id = self.rewardlist[t][i].rewarditem[j].itemid	
					item_num = self.rewardlist[t][i].rewarditem[j].count				   
					self:Item_BG(tempt,item_num,item_id)
					if 0 == item_id then
						tempt.gameObject:SetActive(false)
					else
						tempt.gameObject:SetActive(true)
					end  
				end
			end
			local scrollview = _path:Find("scroll")
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			self.can_click = false 
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition()
		
		
		elseif 1015 == actinfo.activityid then
			self.rewardlist[t] = reward
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/Scroll"), "UIPanel").depth = self.panel_depth + 5;
			 
			local temp = _path:Find("scroll/Table/a")
			local grid = _path:FInd("scroll/Table")
			local rank_label = _path:Find("cur_rank")
			local no_rank_label = _path:Find("norank")
			local num = #(self.rewardlist[t])
			local array = {}
			local childnum = _path:Find("scroll/Table").childCount
			if childnum > 1 then
				for i = 1,childnum,1 do
					if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
						array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					 
					end
				end
				local num = #(array)
				for i = 1,num,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end

			local cost_id = self.rewardlist[t][1].costid
			local cost_num = self.rewardlist[t][1].price
			local hasbuy = self.rewardlist[t][1].hasbuy
			local maxbuy = self.rewardlist[t][1].maxbuy
			local required_rank = self.rewardlist[t][1].rank
			local n = #(self.rewardlist[t][1].rewarditem)
			local item_id = 0;
			local item_num = 0;
			
			if self.rank == 0 then
				no_rank_label.gameObject:SetActive(true)
				rank_label.gameObject:SetActive(false)
			else
				no_rank_label.gameObject:SetActive(false)
				rank_label.gameObject:SetActive(true)
				GTTools.ChangeLabeText(rank_label,"",tostring(self.rank))
			end
			
			for i = 1,num,1 do 
				local clone = GTTools.Clone(temp,i).transform	
				local cantbuy = clone:Find("cantbuy")
				local buy = clone:Find("buy1")
				local got = clone:Find("got")
				
				cost_id = self.rewardlist[t][i].costid
				cost_num = self.rewardlist[t][i].price
				required_rank = self.rewardlist[t][i].rank
				hasbuy = self.rewardlist[t][i].hasbuy
				maxbuy = self.rewardlist[t][i].maxbuy
				
				GTTools.ChangeLabeText(clone, "banner/rank", tostring(required_rank))
				GTTools.ChangeLabeText(clone, "banner/p", tostring(cost_num))
					
				table.insert(self.max_array_1015,maxbuy)
				table.insert(self.hasbuy_array_1015,hasbuy)
				table.insert(self.rank_array,required_rank)
				
				if hasbuy == maxbuy then 
					got.gameObject:SetActive(true)
					buy.gameObject:SetActive(false)
					cantbuy.gameObject:SetActive(false)
				elseif self.rank == 0 or self.rank > required_rank then 
					cantbuy.gameObject:SetActive(true)
					buy.gameObject:SetActive(false)
					got.gameObject:SetActive(false)
				else 
					cantbuy.gameObject:SetActive(false)
					buy.gameObject:SetActive(true)
					got.gameObject:SetActive(false)
				end
				
				n = #(self.rewardlist[t][i].rewarditem)
				local base1 = clone:Find("Scroll/Grid/a")
				local grid1 = clone:Find("Scoll/Grid")
				--table.insert(self.count,n)
				
				for j = 1,n,1 do				       
				   local tempt = clone:Find("Scroll/Grid/"..tostring(j))					   
				   item_id = self.rewardlist[t][i].rewarditem[j].itemid	
				   item_num = self.rewardlist[t][i].rewarditem[j].count				   
				   self:Item_BG(tempt,item_num,item_id)
					if 0 == item_id then
						tempt.gameObject:SetActive(false)
					else
						tempt.gameObject:SetActive(true)
					end  
				end
			end
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			local scrollview = _path:Find("scroll")
			self.can_click = false
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition()
		elseif 1014 == actinfo.activityid then
			self.discount_save = {}
			self.count = {}
			self.max_array = {}
			self.hasbuy_array = {}
			self.rewardlist[t] = reward
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			local describe = actinfo.describe
			describe = Localization.Get("activities describe").."  "..describe
			GTTools.ChangeLabeText(_path:Find("title"), "info1", describe)
			local str2 = self:ShowEndTime(actinfo.timelist[1].endtime,"activities 1014 info2")
			GTTools.ChangeLabeText(_path:Find("title"), "time", str2)	
			
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/Scroll"), "UIPanel").depth = self.panel_depth + 5;	 
			GTTools.GetTransformComponent(_path:Find("scroll/Table/a/title"), "UIPanel").depth = self.panel_depth + 10;
			local  temp = _path:Find("scroll/Table/a")
			local  grid = _path:Find("scroll/Table")
			local num = #(self.rewardlist[t])
			local array = {}
			local childnum = _path:Find("scroll/Table").childCount
			
			if childnum >1 then
			  for i = 1,childnum,1 do
				 if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
					 array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					 
				 end
			  end
			  local num = (#array)
			  for i=1,num,1 do
				if array[i] ~= nil then 
					array[i]:SetActive(false)
				end 
				Object.Destroy(array[i])
			  end				  				  
			end									
			
			local cost_id = self.rewardlist[t][1].costid
			local cost_num = self.rewardlist[t][1].price
			local discount = self.rewardlist[t][1].discount
			local hasbuy = self.rewardlist[t][1].hasbuy
			local maxbuy = self.rewardlist[t][1].maxbuy
			local n = #(self.rewardlist[t][1].rewarditem) 
			local item_id = 0
			local item_num = 0
			for i = 1,num,1 do				 
				local clone = GTTools.Clone(temp,i).transform
				local cost = clone:Find("Scroll/0")
				local title1 = clone:Find("title/1")
				local title2 = clone:Find("title/2")
				local title3 = clone:Find("title/3")
				local title = clone:Find("title")
				local titlebg = clone:Find("title/bg")
				cost_id = self.rewardlist[t][i].costid
				cost_num = self.rewardlist[t][i].price
				discount = self.rewardlist[t][i].discount/1000.0
				local str = tostring(discount)..Localization.Get("activities 1014 discount")				   
				if discount <= 2 then
					GTTools.ChangeSprite(titlebg.gameObject,"discount3")
					GTTools.ChangeLabeText(title, "1", str)
					title1.gameObject:SetActive(true)
				elseif discount <= 5 and discount >2 then
					GTTools.ChangeSprite(titlebg.gameObject,"discount4")
					GTTools.ChangeLabeText(title, "2", str)
					title2.gameObject:SetActive(true)
				elseif discount <= 10 and discount >5 then  
					GTTools.ChangeLabeText(title, "3", str)
					title3.gameObject:SetActive(true)
					GTTools.ChangeSprite(titlebg.gameObject,"discount6")
				end
			   
				hasbuy = self.rewardlist[t][i].hasbuy
				maxbuy = self.rewardlist[t][i].maxbuy
				table.insert(self.max_array,maxbuy)
				table.insert(self.hasbuy_array,hasbuy)
				local str1 = String.Format(Localization.Get("activities 1014 time"),(maxbuy-hasbuy),maxbuy)
				if hasbuy == maxbuy then
					clone:Find("got").gameObject:SetActive(true)
					clone:Find("exchange").gameObject:SetActive(false)
				else
					clone:Find("got").gameObject:SetActive(false)
					clone:Find("exchange").gameObject:SetActive(true)
				end  
				GTTools.ChangeLabeText(clone, "info", str1)
			   
				n = #(self.rewardlist[t][i].rewarditem) 				   
				self:Item_BG(cost,cost_num,cost_id)
				local disc = {}	
				table.insert(self.count,n)				  
				for j = 1,n,1 do				       
					local tempt = clone:Find("Scroll/Grid/"..tostring(j))					   
					item_id = self.rewardlist[t][i].rewarditem[j].itemid	
					item_num = self.rewardlist[t][i].rewarditem[j].count
					--woha
					local ss = {activityid=self.activityid[tonumber(self.cur_item)],operatetype=4,operatepram=self.rewardlist[t][i].shelfid,operatepram1=self.rewardlist[t][i].rewarditem[j].index,subid=self.activitysubid[tonumber(self.cur_item)]}	
					local jsonstr = json.encode(ss)
					local str = 	tostring(item_id).."_"..tostring(item_num).."_"..tostring(self.rewardlist[t][i].rewarditem[j].index).."_"..tostring(self.rewardlist[t][i].shelfid).."_"..jsonstr				   
					table.insert(disc,str)					   
					self:Item_BG(tempt,item_num,item_id)
					if 0 == item_id then
						tempt.gameObject:SetActive(false)
					else
						tempt.gameObject:SetActive(true)
					end  
				end
				table.insert(self.discount_save,disc)				   
			end			
			local scrollview = _path:Find("scroll")			
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			self.can_click = false
			self.activitylist[tonumber(self.cur_item)].hasred = false
			self:judgeredpoint(false)
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition()
			
		elseif 1013 == actinfo.activityid then
		    self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			local joinnum = actinfo.bonusinfo.hasjoin
			local chl_name = actinfo.bonusinfo.describe
			local chl_color = actinfo.bonusinfo.color
			local title = actinfo.name
			local detail = Localization.Get("activities 1013 info1")..actinfo.bonusinfo.describe_detail
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			GTTools.ChangeLabeText(_path:Find("title"), "info1", detail)
			--local str2 = self:ShowEndTime(actinfo.timelist[1].endtime,"activities 1013 time")
			local str2 = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities 1013 time1")
			GTTools.ChangeLabeText(_path:Find("title"), "time", str2)
            GTTools.ChangeLabeText(_path:Find("title/bg"), "Label", chl_name)
			if 0 == chl_color then
			   GTTools.ChangeSprite(_path:Find("title/bg/Sprite").gameObject,"shua_small_yellow")
			   GTTools.ChangeSprite(_path:Find("scroll/Table/a/title").gameObject,"shuashua_yellow")
			else
			   GTTools.ChangeSprite(_path:Find("title/bg/Sprite").gameObject,"shua_small_red")
			   GTTools.ChangeSprite(_path:Find("scroll/Table/a/title").gameObject,"shuashua_red")
			end
			local base = _path:Find("scroll/Table/a")
			
			local  temp = _path:Find("scroll/Table/a")
			local  grid = _path:Find("scroll/Table")
			local num = #(self.rewardlist[t])
			local array = {}
			local childnum = _path:Find("scroll/Table").childCount				
			
			if childnum >1 then
			  for i = 1,childnum,1 do
				 if _path:Find("scroll/Table"):GetChild(i-1).name~="a" then					     
					 array[i] = _path:Find("scroll/Table"):GetChild(i-1).gameObject
					 
				 end
			  end
			  local num = #(array)
			  for i=1,num,1 do
				if array[i] ~= nil then 
					array[i]:SetActive(false)
				end 
				 Object.Destroy(array[i])
			  end				  				  
			end	
			for i=1,num,1 do			
				local clone = GTTools.Clone(base,i).transform
				local joinmax = self.rewardlist[t][i].joincount					
				str3 = self.rewardlist[t][i].title
				local str1 = String.Format(Localization.Get("activities 1013 progress"),joinnum,joinmax)
				local stats = self.rewardlist[t][i].status
				GTTools.ChangeLabeText(clone:Find("title"), "Label",str3)
				GTTools.ChangeLabeText(clone,"progress",str1)					
				if 0 == stats then
				   clone:Find("got").gameObject:SetActive(false)
				   clone:Find("get").gameObject:SetActive(false)
				   clone:Find("noget").gameObject:SetActive(true)
				elseif 1 == stats then
				   clone:Find("got").gameObject:SetActive(false)
				   clone:Find("get").gameObject:SetActive(true)
				   clone:Find("noget").gameObject:SetActive(false)
				elseif 2 == stats then
				   clone:Find("got").gameObject:SetActive(true)
				   clone:Find("get").gameObject:SetActive(false)
				   clone:Find("noget").gameObject:SetActive(false)   
				end
				local n = #(self.rewardlist[t][i].rewarditem)
				local base1 = clone:Find("Grid/a")
				local grid1 = clone:Find("Grid")
				for j = 1,n,1 do
					local clone1 = GTTools.Clone(base1,tostring(j)).transform
					local num = self.rewardlist[t][i].rewarditem[j].count
					local id = actinfo.bonusinfo.rewardlist[1].rewarditem[j].itemid
					self:Item_BG(clone1,num,id)
				end
				GTTools.GetTransformComponent(grid1, "UIGrid").repositionNow = true					
			end
			local scrollview = _path:Find("scroll")
			_path.gameObject:SetActive(true)
			GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			self.can_click = false	
			GTTools.GetTransformComponent(scrollview, "UIScrollView"):ResetPosition()
		elseif 1021 == actinfo.activityid then
		    self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			GTTools.GetTransformComponent(_path:Find("info/reward"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("info/panel"), "UIPanel").depth = self.panel_depth + 3;
			GTTools.GetTransformComponent(_path:Find("info/panel/rank/ranklist"), "UIPanel").depth = self.panel_depth + 5;
			local grid1 = _path:Find("info/reward/Grid")
			local grid2 = _path:FInd("info/panel/rank/ranklist/Grid")
			local base1 = grid1:Find("a")
			local base2 = grid2:FInd("a")
			local my_rank = actinfo.bonusinfo.myrank
			local grade = actinfo.bonusinfo.grade			
			local info = actinfo.title
			local str1 = Localization.Get("activities 1021 rank")..tostring(my_rank)
			local str2 = Localization.Get("activities 1021 grade")..tostring(grade)
			local pet = self:Split(info,"$")
			local pet_grade = pet[2]
			local pet_name = pet[4]			
			local str3 = pet[1].."            "..pet[3]
			local str = self:ShowEndTime(actinfo.timelist[1].endtime,"activities 1021 time")
			self.cur_pet = actinfo.bonusinfo.interface_pet
			GTTools.ChangeLabeText(_path:Find("title"), "name", tostring(actinfo.name))
			GTTools.ChangeLabeText(_path:Find("title"), "info", str3)
			GTTools.ChangeLabeText(_path:Find("title"), "pet_grade", tostring(pet_grade))
			GTTools.ChangeLabeText(_path:Find("title"), "pet_name", tostring(pet_name))
			GTTools.ChangeLabeText(_path:Find("title"), "time", str)
			GTTools.ChangeLabeText(_path:Find("title"), "rank", str1)
			GTTools.ChangeLabeText(_path:Find("title"), "grade", str2)
			GTTools.ChangeLabeText(_path:Find("get"), "diamond/price/Label",actinfo.bonusinfo.costdiamond)
			self.cur_cost = actinfo.bonusinfo.costdiamond
			self.count_down = tonumber(actinfo.bonusinfo.countdown)
			if 0 == actinfo.bonusinfo.freecount then
				self:CowntTime(0)
				self.count_mark = 0
			else
				self:CowntTime(self.count_down)
				self.count_mark = 1
				self.count_ostime = os.time()
			end
			--_path.gameObject:SetActive(true)
			
			if(nil ~= actinfo.bonusinfo.rewadlist) then
				--GTDebug.LogError(actinfo.bonusinfo.rewadlist)
				local reward_num = #(actinfo.bonusinfo.rewadlist)				
				for i=1,reward_num do
					local temp = grid1:Find(tostring(i))
					if(nil == temp) then					
						local clone1 = GTTools.Clone(base1,tostring(i)).transform
					end					
					local str = actinfo.bonusinfo.rewadlist[i].rankdetails
					local itemid = actinfo.bonusinfo.rewadlist[i].rewarditem[1].itemname
					local num = actinfo.bonusinfo.rewadlist[i].rewarditem[1].count	
                    str = "[99531e]"..str.."[346e17]"..itemid.."*"..num					
					GTTools.ChangeLabeText(grid1,i, str)
				end
			end	
			GTTools.GetTransformComponent(grid1, "UIGrid"):RepositionForLua()
			
			if(nil ~= actinfo.bonusinfo.rankdata) then
				local rank_num = #(actinfo.bonusinfo.rankdata)	
				for i=1,rank_num do
					local temp = grid2:Find(tostring(i))
					if(nil == temp) then
						local clone2 = GTTools.Clone(base2,tostring(i)).transform
					end
					local grade = actinfo.bonusinfo.rankdata[i].rolegrade
					local name = actinfo.bonusinfo.rankdata[i].rolename
					local str = String.Format(Localization.Get("activities 1021 ranklist"),tostring(i),tostring(name))
					if(i <= 3) then
						str = "[8dec39]"..str
					else
						str = "[ffd084]"..str
					end
					GTTools.ChangeLabeText(grid2,i,str)
				end
			end
			GTTools.GetTransformComponent(grid2, "UIGrid"):RepositionForLua()
		
		elseif 1022 == actinfo.activityid then
			self.rewardlist[t] = actinfo.bonusinfo.rewardlist
			local title = actinfo.name
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			GTTools.GetTransformComponent(_path:Find("item_bg/Scroll"), "UIPanel").depth = self.panel_depth + 1;
			local base = _path:Find("item_bg/Scroll/Grid/a")
			local cur_fight = actinfo.bonusinfo.rewardlist[1].currentchapter   	--挑战的关卡
			local cur_re = actinfo.bonusinfo.rewardlist[1].rewardchapter     --领取的关卡
			local bar_pro = actinfo.bonusinfo.rewardlist[1].challengeprogress   --领取章节通关进度
			local get_pro = actinfo.bonusinfo.rewardlist[1].rewardprogress    	--领取进度
			local fbcount = actinfo.bonusinfo.rewardlist[1].fbcount
			local challengeprogress = actinfo.bonusinfo.rewardlist[1].challengeprogress
			local cur_cp_name = actinfo.bonusinfo.rewardlist[1].fbname
			local t = Localization.Get("activities 1022 chapter1")
			local t1 = Localization.Get("activities 1022 chapter2")
			local str = t..cur_re..t1
			local str1
			if 0 == cur_fight then
				str1 = String.Format(Localization.Get("activities 1022 current1"),cur_cp_name,actinfo.bonusinfo.rewardlist[1].giftbagname)
			else
				str1 = String.Format(Localization.Get("activities 1022 current"),tostring(cur_fight),cur_cp_name,actinfo.bonusinfo.rewardlist[1].giftbagname)
			end
			local eff = _path:Find("zhuangbeijihuo")
			
			GTTools.ChangeLabeText(_path, "buytext", str1)
		    GTTools.ChangeLabeText(_path:Find("role"),"cur",str)
		    
			local rew_title = actinfo.bonusinfo.rewardlist[1].giftbagname..Localization.Get("activities 1022 reward")
		    GTTools.ChangeLabeText(_path, "item_bg/title/Label",rew_title)
		    
			local pro = _path:Find("progress")
		    local n = pro.childCount
			local base1 = _path:Find("progress/slot")
			--GTDebug.LogError("1:"..pro.childCount)
			local array1 = {}
			local j = 1
			if n>1 then			    
			    for i = 1,n do					
					--GTDebug.LogError("n_index:"..i)
					--GTDebug.LogError(_path:Find("progress"):GetChild(i-1).name)
					if _path:Find("progress"):GetChild(i-1).name ~= "slot" then					     
						array1[j] = _path:Find("progress"):GetChild(i-1).gameObject	
						j =j+1
					end
				end
				local n1 = #(array1)
				--GTDebug.LogError(n1)
				for i=1,n1 do
					--GTDebug.LogError("n1_index:"..i)
					--GTDebug.LogError(array1[i])
					--if array1[i] ~= nil then 
					--	array1[i]:SetActive(false)
					--end 
					Object.DestroyImmediate(array1[i])
				end				  				  
			end	
			--GTDebug.LogError("2:"..pro.childCount)
			
			for i = 1,fbcount do
				local clone = GTTools.Clone(base1,tostring(i))
				if (i<=challengeprogress) then
					clone.transform:Find("bar").gameObject:SetActive(true)
				end				
			end			
			GTTools.GetTransformComponent(pro, "UIGrid").repositionNow = true
			
			local pos = actinfo.bonusinfo.rewardlist[1].rewardprogress
			cur_bar = actinfo.bonusinfo.rewardlist[1].rewardprogress
			local eff_base = _path:Find("zhuangbeijihuo")
			local eff = GTTools.Clone(eff_base,"eff").transform
			if actinfo.bonusinfo.rewardlist[1].status ==1 then
				eff.parent = _path:Find("progress/"..actinfo.bonusinfo.rewardlist[1].rewardprogress)
				eff.localPosition = Vector3(0,0,0)
				eff.gameObject:SetActive(true)
			else
				eff.gameObject:SetActive(false)
			end
			
			local childnum = _path:Find("item_bg/Scroll/Grid").childCount
		    local array = {}
		    if childnum>1 then
				local array = {}
			    for i = 0,childnum-1,1 do
					if _path:Find("item_bg/Scroll/Grid"):GetChild(i).name~="a" then					     
					 array[i] = _path:Find("item_bg/Scroll/Grid"):GetChild(i).gameObject
					 
					end
				end
				for i=1,childnum-1,1 do
					if array[i] ~= nil then 
						array[i]:SetActive(false)
					end 
					Object.Destroy(array[i])
				end				  				  
			end			   			   			   
			 
            local count  = #(actinfo.bonusinfo.rewardlist[1].rewarditem)
			for i = 1,count,1 do
			       
			    local clone = GTTools.Clone(base,tostring(i))
			    local num = actinfo.bonusinfo.rewardlist[1].rewarditem[i].count
			    local id = actinfo.bonusinfo.rewardlist[1].rewarditem[i].itemid
			    local name = actinfo.bonusinfo.rewardlist[1].rewarditem[i].name
			    self:Item_BG(clone.transform,num,id) 
			    GTTools.ChangeLabeText(clone.transform,"name",name)
			end
			_path.gameObject:SetActive(true)
			--GTTools.GetTransformComponent(grid, "UIGrid"):RepositionForLua()
			GTTools.GetTransformComponent(_path:Find("item_bg/Scroll/Grid"), "UIGrid"):RepositionForLua()
			local substatus = false
            if 0==actinfo.bonusinfo.rewardlist[1].status	then
			    _path:Find("get").gameObject:SetActive(false)
				_path:Find("unget").gameObject:SetActive(true)
				_path:Find("got").gameObject:SetActive(false)
				self.activitylist[tonumber(self.cur_item)].hasred = false
				substatus = false
			elseif 1==actinfo.bonusinfo.rewardlist[1].status	then
			    _path:Find("get").gameObject:SetActive(true)
				_path:Find("unget").gameObject:SetActive(false)
				_path:Find("got").gameObject:SetActive(false)
				self.activitylist[tonumber(self.cur_item)].hasred = true
				substatus = true
			elseif  2==actinfo.bonusinfo.rewardlist[1].status	then
				self.activitylist[tonumber(self.cur_item)].hasred = false
				substatus = false
			    --_path:Find("item_bg").gameObject:SetActive(false)
			    --_path:Find("bg").gameObject:SetActive(false)
			    --_path:Find("role").gameObject:SetActive(false)
			    --_path:Find("buytext").gameObject:SetActive(false)
			    _path:Find("get").gameObject:SetActive(false)
			    _path:Find("unget").gameObject:SetActive(false)
				_path:Find("got").gameObject:SetActive(true)
            end	
		    self:judgeredpoint(substatus)
		    self.secretid = actinfo.bonusinfo.rewardlist[1].giftbagid
			self.can_click = false
		elseif 1023 == actinfo.activityid then
			GTTools.GetTransformComponent(_path:Find("grid/0/Scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("grid/1/Scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("grid/2/Scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("grid/3/Scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("grid/4/Scroll"), "UIPanel").depth = self.panel_depth + 1;
			GTTools.GetTransformComponent(_path:Find("grid/0/empty"), "UIPanel").depth = self.panel_depth + 2;
			GTTools.GetTransformComponent(_path:Find("grid/1/empty"), "UIPanel").depth = self.panel_depth + 2;
			GTTools.GetTransformComponent(_path:Find("grid/2/empty"), "UIPanel").depth = self.panel_depth + 2;
			GTTools.GetTransformComponent(_path:Find("grid/3/empty"), "UIPanel").depth = self.panel_depth + 2;
			GTTools.GetTransformComponent(_path:Find("grid/4/empty"), "UIPanel").depth = self.panel_depth + 2;
			local title = actinfo.name
			local info = actinfo.describe
			local cur_max =  actinfo.maxget
			local cur_get = actinfo.curcost
			local cur_have = self.m_model_player.getDiamond
			local str1 = Localization.Get("activities 1023 curcost")..tostring(cur_get)			
			local str2 = self:ShowTime(actinfo.timelist[1].starttime,actinfo.timelist[1].endtime,"activities 1023 time")
			local str3 = Localization.Get("activities 1023 have")..tostring(cur_have)
			GTTools.ChangeLabeText(_path:Find("title"), "name", title)
			GTTools.ChangeLabeText(_path:Find("title"), "info", info)
			GTTools.ChangeLabeText(_path:Find("title"), "info1",str2)
			GTTools.ChangeLabeText(_path:Find("title"), "info1",str2)
			GTTools.ChangeLabeText(_path:Find("diamond/consume"), "Label",str1)
			GTTools.ChangeLabeText(_path:Find("diamond/curmax"), "num",cur_max)
			GTTools.ChangeLabeText(_path:Find("diamond/cur"), "Label",str3)
			_path.gameObject:SetActive(true)
		end
		
        self.can_click = false
		self.open_status[tonumber(self.cur_item)] = 1
		_path.gameObject:SetActive(true)
		local scrolltrans = _path:Find("scroll")
		if scrolltrans ~= nil then 
			GTTools.GetTransformComponent(_path:Find("scroll"), "UIScrollView"):ResetPosition()	
		end
		self.refresh_list[self.cur_item] = true
        if self.mark == false then
		   self.mark = true
		   last = self.activitylist[1].activityid
		   lastsub = self.activitylist[1].subid
		   local _path = self.activityid[tonumber(self.cur_item)]
		   local obj = self.window.transform:Find(_path.."/scroll")			   
		   self.window:OpenTweenScale()
		   self.window:LoadComplete()
		end
		self.changing_activity_tab = false
	end,
	
	--倒计时函数
	CowntTime = function(self,time3)
		if 0 ~=time3 then
			local hour = time3/3600
			local hour_str = self:DoubleToInt(hour)
			local minute = time3%3600/60
			local minute_str = self:DoubleToInt(minute)
			local second = time3%3600%60
			local second_str = self:DoubleToInt(second)		
			
			if hour<10 then
				hour_str = "0"..hour_str
			end		
			if minute<10 then
				minute_str = "0"..minute_str
			end	
			if second<10 then
				second_str = "0"..second_str
			end				
			local time_str = hour_str..":"..minute_str..":"..second_str
			local _path = self.window.transform:Find("1021")
			GTTools.ChangeLabeText(_path:Find("get"), "free/time/Label", time_str)
			_path:Find("get/free/time/Label").gameObject:SetActive(true)
			_path:Find("get/free/time/free").gameObject:SetActive(false)
		else
			local _path = self.window.transform:Find("1021")
			_path:Find("get/free/time/Label").gameObject:SetActive(false)
			_path:Find("get/free/time/free").gameObject:SetActive(true)
		end
	end,
	
	--将double类型转成int字符串
	DoubleToInt = function(self,number)
		local number_str = tostring(number)
		local start_index = 1
		local index = string.find(number_str,".",start_index,true)
		local result_str
		if nil == index then
			result_str = number_str
		else
			result_str = string.sub(number_str,start_index,tonumber(index) - 1)
		end
		return result_str
	end,
	
	Split = function(self,szFullString, szSeparator)	
		local nFindStartIndex = 1  
		local nSplitIndex = 1  
		local nSplitArray = {}  
		while true do  
			local nFindLastIndex = string.find(szFullString,szSeparator,nFindStartIndex,true) 			
			local nFindLastIndex = string.find(szFullString,szSeparator,nFindStartIndex,true) 			
			if not nFindLastIndex then  
				nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex,string.len(szFullString))  
				break
			end  
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
			nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
			nSplitIndex = nSplitIndex + 1  
		end  
		return nSplitArray  
	end,
		
	--设置红点函数
    judgeredpoint= function(self,substatus)
        local red =self.window.transform:Find("middle/Grid/"..self.cur_item.."/redpoint").gameobject
		red:SetActive(substatus)
		local num = #(self.activitylist)
		local mainsta = false
		for i=1,num do
			if true == self.activitylist[i].hasred then
				mainsta = true
				break
			end
		end
		if false == mainsta then					
			self.m_model:UpdateModel("SendDisableRedpoint",nil)
		end
						
	end,
	
	--接收界面操作
	RecvActiOperate = function(self, rr)
		self.press_status = false	
		local operateinfo = json.decode(rr.obj)
		print(rr.obj)
		local id = operateinfo.activityid
		local retype = operateinfo.operatetype
		local substatus = false;
		
		local obj = tostring(self.activityid[tonumber(self.cur_item)])
		local _path = self.window.transform:Find(obj)
		local t = self.cur_item
		if 1 == retype then 
			if 1001 == id then
				if 0 == operateinfo.result then
					GTTools.SetVisible(_path:Find("buytext").gameObject,true)
					GTTools.SetVisible(_path:Find("buy").gameObject,false)
					self.touzibuystatus = true
					
					local tws = GTTools.GetTransformComponent(_path:Find("buytext"), "TweenScale")
					if tws then
						Object.Destroy(tws)	
					end

					tws = GTTools.AddGameObjectComponent(_path:Find("buytext").gameObject, "TweenScale")
					tws.from = Vector3(2, 2, 2)
					tws.to = Vector3(1, 1, 1)
					tws.duration = 0.3	
					
					--tws = GTTools.GetTransformComponent(_path:Find("buytext"), "TweenPosition")
					--if tws then
						--Object.Destroy(tws)	
					--end

					--tws = GTTools.AddGameObjectComponent(_path:Find("buytext").gameObject, "TweenPosition")
					--tws.from = Vector3(409, 113, -53)
					--tws.to = Vector3(409, 102, 0)
					--tws.duration = 0.3	
					
					local actid=self.activityid[tonumber(self.cur_item)]
					local sid=self.activitysubid[tonumber(self.cur_item)]
					local ss = {activityid=actid,subid=sid}	
					local jsonstr = json.encode(ss)
					self.m_model:UpdateModel("SendDetailRequest",jsonstr)
				end	
			end						
		elseif 2 == retype then
			if 0 == operateinfo.result then
				self.rotagetlist = operateinfo
				self.rotarestime = self.rotarestime-1
				if 0 == self.rotarestime then				
					substatus = false
					self.activitylist[tonumber(self.cur_item)].hasred = false
				else
					substatus = true
				end
				self:judgeredpoint(substatus)								
				GTTools.ChangeLabeText(_path,"resnum",tostring(self.rotarestime))	
				local num = #(self.rewardlist[t])
				local rot = (operateinfo.operateresult+1)*(360/num)
				self:TweenRotation(0-rot-3600+(360/16))
			elseif 2 == operateinfo.result then
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities bagfull"), DialogType.AutoClose, "", self)				
			
			end
		
		elseif 3 == retype then
			GTUIManager.GetInstance():CloseWaitWindow()		
			if 1 == operateinfo.result then 
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities nobonus"), DialogType.AutoClose, "", self)				 
			elseif 2 == operateinfo.result then 
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities havegotbonus"), DialogType.AutoClose, "", self)				 
			elseif 3 == operateinfo.result then
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities bagfull"), DialogType.AutoClose, "", self)	
			elseif 10 == operateinfo.result then 
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities equipbagfull"), DialogType.AutoClose, "", self)
			elseif 12 == operateinfo.result then 
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities gembagfull"), DialogType.AutoClose, "", self)
		    elseif 0 == operateinfo.result then 
			--理财基金
				if 1001 == id then
					local p = _path:Find("scroll/Table/"..self.bagsubitem_id)
					GTTools.SetVisible(p:Find("got").gameObject,true)
					GTTools.SetVisible(p:Find("gettext").gameObject,false)
					GTTools.SetVisible(p:Find("get").gameObject,false)
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					self.rewardlist[t][tonumber(self.bagsubitem_id)].status = 2
					local listnum = #(self.rewardlist[t])
					for  i=1,listnum do
						if 1 == self.rewardlist[t][i].status then
							substatus = true
							break
						end
					end
					if false == substatus then					
						self.activitylist[tonumber(self.cur_item)].hasred = false
					end	
				--钻石消费	
				elseif 1003 == id then
					local p = _path:Find("scroll/Table/"..self.bagsubitem_id)
					GTTools.SetVisible(p:Find("got").gameObject,true)
					GTTools.SetVisible(p:Find("gettext").gameObject,false)
					GTTools.SetVisible(p:Find("get").gameObject,false)
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					self.rewardlist[t][tonumber(self.bagsubitem_id)].status = 2
					local listnum = #(self.rewardlist[t])
					for  i=1,listnum do
						if 1 == self.rewardlist[t][i].status then
							substatus = true
							break
						end
					end
					if false == substatus then					
						self.activitylist[tonumber(self.cur_item)].hasred = false
					end
				--单日充值
				elseif 1004 == id then
					local p = _path:Find("scroll/Table/"..self.bagsubitem_id)
					GTTools.SetVisible(p:Find("got").gameObject,true)
					GTTools.SetVisible(p:Find("gettext").gameObject,false)
					GTTools.SetVisible(p:Find("get").gameObject,false)
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					self.rewardlist[t][tonumber(self.bagsubitem_id)].status = 2
					local listnum = #(self.rewardlist[t])
					for  i=1,listnum do
						if 1 == self.rewardlist[t][i].status then
							substatus = true
							break
						end
					end
					if false == substatus then					
						self.activitylist[tonumber(self.cur_item)].hasred = false
					end	
				--竞技场击杀	
				elseif 1007 == id then
					local basic1 = _path:Find("1")
					local basic2 = _path:Find("2")
					local effect1 = basic1:Find("jingji_huodongbaoxiang")
					local effect2 = basic2:Find("jingji_huodongbaoxiang")
					if(1==self.click) then
						GTTools.SetVisible(basic1:Find("buytext").gameObject,false)
						GTTools.SetVisible(basic1:Find("get").gameObject,false)
						GTTools.SetVisible(basic1:Find("got").gameObject,true)
						effect1.gameObject:SetActive(false)
						self.already[1] = true
						self.rewardlist[t][1].status = 2
					else 
						GTTools.SetVisible(basic2:Find("buytext").gameObject,false)
						GTTools.SetVisible(basic2:Find("get").gameObject,false)
						GTTools.SetVisible(basic2:Find("got").gameObject,true)
						effect2.gameObject:SetActive(false)
						self.already[2] = true
						self.rewardlist[t][2].status = 2
					end
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					if true == self.already[1] and true == self.already[2] then
						substatus = false
						self.activitylist[tonumber(self.cur_item)].hasred = false
					end
	
				elseif 1009 == id then
					self.fubecount = self.fubecount -1
					local pp = self.rewardlist[t][1].wordlist
					local ppnum = #pp
					for m=1,ppnum do
						local tt = _path:Find("title/"..tostring(m))
						local objectid = pp[m].objectid
						pp[m].objectnum = pp[m].objectnum-1
						local objectnum = pp[m].objectnum
						if 0 == objectnum then
							local stpath = tostring(objectid).."_gray.png"
							FunctionClass.ChangeTexture(tt,stpath)
						elseif 1 == objectnum then 
							_path:Find("title/"..tostring(m).."/count").gameObject:SetActive(false)
						elseif 1 < objectnum then 
							GTTools.ChangeLabeText(tt,"count",tostring(objectnum))
						end	
						
					end
					if self.fubecount == 0 then
						GTTools.SetVisible(_path:Find("got").gameObject,true)
						GTTools.SetVisible(_path:Find("buytext").gameObject,false)
						GTTools.SetVisible(_path:Find("get").gameObject,false)
						substatus = false
						self.activitylist[tonumber(self.cur_item)].hasred = false
						
					end
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)	
				--豪华美食
				elseif 1002 == id then
					GTTools.ChangeLabeText(_path, "buytext", self:NextShowTime())			
					GTTools.SetVisible(_path:Find("buytext").gameObject,true)
					GTTools.SetVisible(_path:Find("get").gameObject,false)
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					self.rewardlist[t][1].status = 2
					substatus = false
					self.activitylist[tonumber(self.cur_item)].hasred = false	
				elseif 1010 == id then	
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					openstatus = 0						
					local actid=self.activityid[tonumber(self.cur_item)]
					local sid=self.activitysubid[tonumber(self.cur_item)]
					local ss = {activityid=actid,subid=sid}	
					local jsonstr = json.encode(ss)
					self.m_model:UpdateModel("SendDetailRequest",jsonstr)	
				elseif 1011 == id then	
					self.can_click = false
					local num = #(operateinfo.rewardlist)
					local id = {}
					local count = {}
					for i = 1,num,1 do
						table.insert(id,operateinfo.rewardlist[i].itemid)
						table.insert(count,operateinfo.rewardlist[i].count)
					end
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,num,id,count) 
					_path:Find("scroll/Table/"..self.cur_index.."/get").gameObject:SetActive(false);
					_path:Find("scroll/Table/"..self.cur_index.."/got").gameObject:SetActive(true);
					self.acti_status_array[self.cur_item][self.cur_index] = self.acti_status_array[self.cur_item][self.cur_index]+1
					local listnum = #(self.rewardlist[t])
				    substatus = false
				    for i=1,listnum do
					    if self.acti_status_array[self.cur_item][i] == 1 then
					       substatus = true
					       break
					    end
				    end
					if false == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = false
				    elseif true == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = true
				    end
                elseif 1012 == id then	
					local p = _path:Find("scroll/Table/"..self.bagsubitem_id)
					GTTools.SetVisible(p:Find("got").gameObject,true)
					GTTools.SetVisible(p:Find("goto").gameObject,false)
					GTTools.SetVisible(p:Find("get").gameObject,false)
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					self.rewardlist[t][tonumber(self.bagsubitem_id)].status = 2
					local listnum = #(self.rewardlist[t])
					for  i=1,listnum do
						if 1 == self.rewardlist[t][i].status then
							substatus = true
							break
						end
					end
					if false == substatus then					
						self.activitylist[tonumber(self.cur_item)].hasred = false
					end	
				elseif 1013 == id then	
					local p = _path:Find("scroll/Table/"..self.bagsubitem_id)
					GTTools.SetVisible(p:Find("got").gameObject,true)
					GTTools.SetVisible(p:Find("noget").gameObject,false)
					GTTools.SetVisible(p:Find("get").gameObject,false)
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					self.rewardlist[t][tonumber(self.bagsubitem_id)].status = 2
					local listnum = #(self.rewardlist[t])
					for  i=1,listnum do
						if 1 == self.rewardlist[t][i].status then
							substatus = true
							break
						end
					end
					if false == substatus then					
						self.activitylist[tonumber(self.cur_item)].hasred = false
					end
				elseif 1016 == id then 
					self.can_click = false
					local num = #(operateinfo.rewardlist)
					local id = {}
					local count = {}
					for i = 1,num,1 do
						table.insert(id,operateinfo.rewardlist[i].itemid)
						table.insert(count,operateinfo.rewardlist[i].count)
					end
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,num,id,count) 
					_path:Find("scroll/Table/"..self.cur_index.."/get").gameObject:SetActive(false);
					_path:Find("scroll/Table/"..self.cur_index.."/got").gameObject:SetActive(true);
					self.acti_status_array[self.cur_item][self.cur_index] = self.acti_status_array[self.cur_item][self.cur_index]+1
					local listnum = #(self.rewardlist[t])
				    substatus = false
				    for i=1,listnum do
					    if self.acti_status_array[self.cur_item][i] == 1 then
					       substatus = true
					       break
					    end
				    end
					if false == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = false
				    elseif true == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = true
				    end
					
				elseif 1017 == id then
					self.can_click = false
					local num = #(operateinfo.rewardlist)
					local id = {}
					local count = {}
					for i = 1,num,1 do
						table.insert(id,operateinfo.rewardlist[i].itemid)
						table.insert(count,operateinfo.rewardlist[i].count)
					end
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,num,id,count)
					
					_path:Find("scroll/Table/"..self.cur_index.."/get").gameObject:SetActive(false);
					_path:Find("scroll/Table/"..self.cur_index.."/got").gameObject:SetActive(true);
					self.acti_status_array[self.cur_item][self.cur_index] = self.acti_status_array[self.cur_item][self.cur_index]+1
					local listnum = #(self.rewardlist[t])
				    substatus = false
				    for i=1,listnum do
					    if self.acti_status_array[self.cur_item][i] == 1 then
					       substatus = true
					       break
					    end
				     end
					if false == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = false
				    elseif true == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = true
				    end
				

				elseif 1018 == id then 
					self.can_click = false
					local num = #(operateinfo.rewardlist)
					local id = {}
					local count = {}
					for i = 1,num,1 do
						table.insert(id,operateinfo.rewardlist[i].itemid)
						table.insert(count,operateinfo.rewardlist[i].count)
					end
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,num,id,count) 
					_path:Find("scroll/Table/"..self.cur_index.."/get").gameObject:SetActive(false);
					_path:Find("scroll/Table/"..self.cur_index.."/got").gameObject:SetActive(true);
					self.acti_status_array[self.cur_item][self.cur_index] = self.acti_status_array[self.cur_item][self.cur_index]+1
					local listnum = #(self.rewardlist[t])
				    substatus = false
				    for i=1,listnum do
					    if self.acti_status_array[self.cur_item][i] == 1 then
					       substatus = true
					       break
					    end
				    end
					if false == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = false
				    elseif true == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = true
				    end
				elseif 1022 == id then	
					local id = {}
					local count = {}
					for i= 1,#(operateinfo.rewardlist) do
						id[i] = operateinfo.rewardlist[i].itemid
						count[i] = operateinfo.rewardlist[i].count
					end 
					local temp = self.window.transform:Find("1022/progress/"..cur_bar.."/eff").gameObject
					Object.Destroy(temp)
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,#(operateinfo.rewardlist),id,count)
					openstatus = 0						
					local actid=self.activityid[tonumber(self.cur_item)]
					local sid=self.activitysubid[tonumber(self.cur_item)]
					local ss = {activityid=actid,subid=sid}	
					local jsonstr = json.encode(ss)
					self.m_model:UpdateModel("SendDetailRequest",jsonstr)
				end
				self:judgeredpoint(substatus)
			end
	    elseif 4 == retype then			
			if 1014 == id then
                if 0 == operateinfo.result then
			         self.can_click = false
					 local id = {}
					 local count = {}
					 table.insert(id,tonumber(operateinfo.itemget.itemid))
					 table.insert(count,tonumber(operateinfo.itemget.count))
					 local n = #(operateinfo.itemget)+1
					 ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,n,id,count)
			         self.cur_buy = self.cur_buy+1
					 self.hasbuy_array[self.cur_index] = self.hasbuy_array[self.cur_index]+1
					 local str1 = String.Format(Localization.Get("activities 1014 time"),(self.cur_max-self.cur_buy),self.cur_max)
			         GTTools.ChangeLabeText(_path:Find("scroll/Table/"..self.cur_index),"info",str1)
			         if self.cur_buy == self.cur_max then
					    _path:Find("scroll/Table/"..self.cur_index.."/got").gameObject:SetActive(true)
						_path:Find("scroll/Table/"..self.cur_index.."/exchange").gameObject:SetActive(false)					    
					 end
					 local listnum = #(self.rewardlist[t])
				     substatus = false
				     for i=1,listnum do
					     if self.hasbuy_array[i] ~= self.max_array[i] then
					        substatus = true
					        break
					     end
				     end
				     if false == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = false
				     elseif true == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = false
				     end
			         self:judgeredpoint(false)
				elseif 	2 == operateinfo.result then
				    GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities not enough money"), DialogType.AutoClose, "",self)
				elseif  3 == operateinfo.result then
				    GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1014 bagfull"), DialogType.AutoClose, "",self)
					
				elseif 10 == operateinfo.result then 
					GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities equipbagfull"), DialogType.AutoClose, "", self)
				elseif 12 == operateinfo.result then 
					GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities gembagfull"), DialogType.AutoClose, "", self)
                end
			elseif 1015 == id then 
				if 0 == operateinfo.result then
					self.can_click = false
					local num = #(operateinfo.rewardlist)
					local id = {}
					local count = {}
					for i = 1,num,1 do
						table.insert(id,operateinfo.rewardlist[i].itemid)
						table.insert(count,operateinfo.rewardlist[i].count)
					end
					self.cur_buy = self.cur_buy+1
					self.hasbuy_array_1015[self.cur_index] = self.hasbuy_array_1015[self.cur_index]+1
					ItemDialog.GetInstance():openRecvDialogForLua(self.window.scene,num,id,count)
					if self.cur_buy == self.cur_max then
						_path:Find("scroll/Table/"..self.cur_index.."/buy1").gameObject:SetActive(false);
						_path:Find("scroll/Table/"..self.cur_index.."/got").gameObject:SetActive(true);
					end	
					local listnum = #(self.rewardlist[t])
				    substatus = false
				    for i=1,listnum do
					    if self.hasbuy_array_1015[i] ~= self.max_array_1015[i] and self.rank <= self.rank_array[i] then
					       substatus = true
					       break
					    end
				     end
					if false == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = false
				    elseif true == substatus then					
					    self.activitylist[tonumber(self.cur_item)].hasred = true
				    end
					self:judgeredpoint(substatus)
				elseif 2 == operateinfo.result then
					GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities not enough money"), DialogType.AutoClose, "",self)
				elseif 3 == operateinfo.result then 
					GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1014 bagfull"), DialogType.AutoClose, "",self)
					
				elseif 10 == operateinfo.result then 
					GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities equipbagfull"), DialogType.AutoClose, "", self)
				elseif 12 == operateinfo.result then 
					GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities gembagfull"), DialogType.AutoClose, "", self)
				end 
			end
		elseif 5 == retype then
			if 0 == operateinfo.result then
				local actid=self.activityid[tonumber(self.cur_item)]
				local sid=self.activitysubid[tonumber(self.cur_item)]
				local ss = {activityid=actid,subid=sid}	
				local jsonstr = json.encode(ss)				
				self.m_model:UpdateModel("SendDetailRequest",jsonstr)	
				local addgrade = operateinfo.bonusinfo.addgrade
				local id = operateinfo.bonusinfo.reward[1].itemid
				local count = operateinfo.bonusinfo.reward[1].count
				local s = id.."_"..addgrade.."_"..sid.."_"..actid.."_"..retype.."_"..count.."_"..self.cur_cost
				GTDebug.LogError(s)
				local str ={}
				table.insert(str,s)
				GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinActivitiesPet), "ui/activities/activityPet",nil,str)
			elseif 2 == operateinfo.result then
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1021 nofree"), DialogType.AutoClose, "", self)
			else
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1021 fail"), DialogType.AutoClose, "", self)
			end
		elseif 6 == retype then
			if 0 == operateinfo.result then
				local actid=self.activityid[tonumber(self.cur_item)]
				local sid=self.activitysubid[tonumber(self.cur_item)]
				local ss = {activityid=actid,subid=sid}	
				local jsonstr = json.encode(ss)
				self.m_model:UpdateModel("SendDetailRequest",jsonstr)
				local addgrade = operateinfo.bonusinfo.addgrade
				local id = operateinfo.bonusinfo.reward[1].itemid
				local count = operateinfo.bonusinfo.reward[1].count
				local s = id.."_"..addgrade.."_"..sid.."_"..actid.."_"..retype.."_"..count.."_"..self.cur_cost
				GTDebug.LogError(s)
				local str ={}
				table.insert(str,s)
				GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinActivitiesPet), "ui/activities/activityPet",nil,str)
				
			elseif 3 == operateinfo.result then
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1021 nodiamond"), DialogType.AutoClose, "", self)
			else
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1021 fail"), DialogType.AutoClose, "", self)
			end
		elseif 7 == retype then
			if 0 == operateinfo.result then
				local num = operateinfo.diamondget
				local str1 = Localization.Get("activities 1023 curcost")..tostring(operateinfo.curcost)			
				local str3 = Localization.Get("activities 1023 have")..tostring(self.m_model_player.getDiamond)
				GTTools.ChangeLabeText(self.window.transform:Find("1023/diamond/consume"), "Label",str1)
				GTTools.ChangeLabeText(self.window.transform:Find("1023/diamond/curmax"), "num",operateinfo.maxget)
				GTTools.ChangeLabeText(self.window.transform:Find("1023/diamond/cur"), "Label",str3)
				local num_table = {}
				local count = 0
				GTDebug.LogError("-----")
				while (num ~=0) do
					local i = tonumber(num%10)
					num = tonumber(self:DoubleToInt(num/10))
					table.insert(num_table,i)
					count = count + 1				
				end
				GTDebug.LogError(count)
				if (count>0) then
					self.count_table = 	num_table
				end
				for j = 1,count do
					local n = tonumber(j)-1
					GTDebug.LogError(n)
					self.window.transform:Find("1023/grid/"..n.."/Scroll").gameObject:SetActive(true)
					self.window.transform:Find("1023/grid/"..n.."/empty").gameObject:SetActive(false)
										
					local go = self.window.transform:Find("1023/grid/"..n.."/Scroll").gameObject
					local temp = GTTools.GetTransformComponent(go.transform,"SpringPanel")	
					local pos = Vector3(0, 660*5+66*num_table[j], 0)
					SpringPanel.Begin(go,pos,3)
					--temp.onFinished = OnFinish1										
					--local del = EventDelegate() 
					--del:Set(self.window,"OnTweenFinished")
					--del.parameters[0].value = "tweenRfinish"
					--tweenR:AddOnFinished(del)
				end
				for j = count,4 do					
					self.window.transform:Find("1023/grid/"..j.."/Scroll").gameObject:SetActive(false)
					self.window.transform:Find("1023/grid/"..j.."/empty").gameObject:SetActive(true)
				end
			elseif 1 == operateinfo.result then	
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1023 times"), DialogType.AutoClose, "", self)
			elseif 2 == operateinfo.result then	
				GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities 1023 nodiamond"), DialogType.AutoClose, "", self)	
			end
		end			
		self.can_click = false
	end,
	
	OnDestroy = function(self)
		print("lua--OnDestroy")
		
	end,
	LuaonDragFinished = function(self)
		self.scrollview_flag = false
		for i = 1,self.totleitem do
			GTTools.GetTransformComponent(self.tt[i], "BoxCollider").enabled=true	
		end	

		
		GTTools.GetTransformComponent(self.tt[self.totleitem], "BoxCollider").enabled=true	
	end,
	LuaonDragStarted = function(self)
		--self.scrollview_flag = true
		--for i = 1,self.totleitem do
			
		--	GTTools.GetTransformComponent(self.tt[i], "BoxCollider").enabled=false	
		--end	
	end,
	
	Recvcharge = function(self,rr)
		local dic = rr.obj
		local status = dic["status"]
		local diamond = dic["diamond"]
		local chargermb = dic["chargermb"]
		local actid=self.activityid[tonumber(self.cur_item)]
		local sid=self.activitysubid[tonumber(self.cur_item)]
		local ss = {activityid=actid,subid=sid}	
		local jsonstr = json.encode(ss)
		self.m_model:UpdateModel("SendDetailRequest",jsonstr)
		
		local number = #(self.refresh_list)
		local act_id = self.activityid[tonumber(self.cur_item)]
		local sub_act_id = self.activitysubid[tonumber(self.cur_item)]
		for i = 1, number do 
			if (self.activityid[i] ~= act_id or self.activitysubid[i] ~= sub_act_id) then 
				if (self.activityid[i] == 1014 or self.activityid[i] == 1016 or self.activityid[i] == 1018) then 
					self.refresh_list[i] = false
				end
			end
		end
	end,
	

	
	
	--window 开始
	Start = function(self)
		self.press_status = true
		GTUIEventDispatcher.SetAllEventTargetToWindow(self.window)	
		self.m_model = GTDataModelManager.GetInstance():GetModel(DFModelType.DFModelActivities)
		self.m_model_charge = GTDataModelManager.GetInstance():GetModel(DFModelType.DFModelCharge)
		--self.m_model_pet = GTDataModelManager.GetInstance():GetModel(DFModelType.DFModelPet)
		self.m_model_bag= GTDataModelManager.GetInstance():GetModel(DFModelType.DFModelBag)
		self.m_model_player= GTDataModelManager.GetInstance():GetModel(DFModelType.DFModelPlayer)
		self.m_model:AddView("OnModelEvent", self.window.gameObject)		
		mark = false
		self.count_mark = 0
		self.count_mark1 = false
		local LuaScrollView = GTTools.GetTransformComponent(self.window.transform:Find("middle"), "UIScrollView")
		self.window:SetScrollViewOnDragFinished(LuaScrollView,"LuaonDragFinished")
		self.window:SetScrollViewOnDragStarted(LuaScrollView,"LuaonDragStarted")
		self.m_model:UpdateModel("SendActiLogin",nil)
		local panel = GTTools.GetTransformComponent(self.window.transform:Find(""), "UIPanel")
		self.panel_depth = panel.depth
	end,

	BuyVip1Callback = function(self, win, button)
		if button == DialogButton.OK then
			self.press_status = true
			self.window:CloseTweenScale()
			GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinCharge), "ui/charge/ChargeWin", nil)				
		end		
	end,
	
	BuyDiamondNotenoughCallback = function(self, win, button)
		if button == DialogButton.OK then
			self.press_status = true
			self.window:CloseTweenScale()
			GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinCharge), "ui/charge/ChargeWin", nil)				
		end
	end,
	
	BuyRechargeSureCallback = function(self, win, button)
		if button == DialogButton.OK then
			self.press_status = true
			local ss = {activityid=self.activityid[self.cur_item],operatetype=1,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
			local jsonstr = json.encode(ss)
			--print(jsonstr)
			self.m_model:UpdateModel("SendActiOperate",jsonstr)
			self.can_click = true
		end
	end,
	
	JJCDiamondNotenoughCallback = function(self_callback, win, button)
		if button == DialogButton.OK then
			self.press_status = true
			self.window:CloseTweenScale()
			GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinCharge), "ui/charge/ChargeWin", nil)				
		end
	end,

	OnPressUIEvent = function(self,event)
		local send_name = event.sender.name
		if send_name== "game" then
			local temp = event.sender.transform			
			if event.press_is_down then
				GTTools.ChangeSprite(temp.gameObject,"reward_press")
				temp:Find("text").gameObject:SetActive(false)
				temp:Find("text1").gameObject:SetActive(true)
			else
				GTTools.ChangeSprite(temp.gameObject,"reward_normal")
				temp:Find("text").gameObject:SetActive(true)
				temp:Find("text1").gameObject:SetActive(false)
			end
		end
	end,
	
	OnUIEvent = function(self, event)		
		
		if self.scrollview_flag then
			return		
		end
		local wordcolor = {"yellow","blue","pink","orange"}
		
		if true==self.can_click then
		   return
		end
		--UDebug.Break()
		local send_name = event.sender.name
		local send_parent_name = event.sender.transform.parent.name
		local send_parent_item = event.sender.transform.parent.parent.name
		--GTDebug.LogError("send_parent_name:"..tostring(send_parent_name).."send_name: "..tostring(send_name).."send_parent_item:"..tostring(send_parent_item))
		if send_name== "more" then
		   return
		end
		
		if send_name ~= "close" and send_name ~= "buy" and send_name ~= "get" and send_name ~= "goto" and send_name ~="exchange" and send_name ~= "buy1" and send_name ~= "property" and send_name ~= "arrow" and send_name ~= "extract" and send_name ~= "reg" and send_name ~= "game" then
		   self.cur_item = tonumber(send_name)
		   local chose = event.sender.transform.parent.parent:Find("chose")
		   chose.transform.Position = event.sender.transform.Position
		   local grid = event.sender.transform.parent	   
		   local count = grid.childCount-1
		   for i =1,count,1 do 
		       local item = grid:Find(i)
			   local infos = "unselected"
			   local paths = item:Find("titlebg").gameObject
			   --GTDebug.LogError(item.name)
			   --GTDebug.LogError(send_name)
			   if item.name ~= send_name then
			    GTTools.ChangeSprite(paths,infos)
			    item:Find("titlebg/info").gameObject:SetActive(true)
				item:Find("titlebg/info1").gameObject:SetActive(false)
				item:Find("titlebg/info2").gameObject:SetActive(false)
				item:Find("titlebg/info3").gameObject:SetActive(false)
				item:Find("titlebg/info4").gameObject:SetActive(false)
			   else
			    local n = math.fmod(i,5)
				if 0==n then
				   n=1
				end
				--GTDebug.LogError(n)
				infos = wordcolor[n]
				GTTools.ChangeSprite(paths,infos)
				item:Find("titlebg/info").gameObject:SetActive(false)
				--GTDebug.LogError("hello")
				for i = 1,4,1 do
				--GTDebug.LogError(i)
				    if i~=n then
					   item:Find("titlebg/info" .. i).gameObject:SetActive(false)
					   --GTDebug.LogError(i)
					else
					   item:Find("titlebg/info" .. i).gameObject:SetActive(true)
					   --GTDebug.LogError(i)
					end
			    end
		       end
		    end
				
		end
		--local n =tonumber(event.sender.name)
		--n = math.fmod(n,5)
		--for i=1,4,1 do  
		--   if n==i then
		--       event.sender.transform:Find("titlebg/info"+i).gameObject:SetActive(true)
		--	else
		--	   event.sender.transform:Find("titlebg/info"+i).gameObject:SetActive(false)
		--	end
        --end	
		--event.sender.transform:Find("titlebg/info").gameObject:SetActive(false)
		
		--关闭活动window
		if send_name == "close" then
			self.window:Close()			
		--充值button 一类
		elseif send_name == "goto" then		    		    
			self.window:Close()
			GTUIManager.OpenWindowWithCoverBlur(self.window.scene, luanet.ctype(DFWinTranscript), "ui/transcript/transcript-main", nil)
		elseif send_name =="exchange" then
		    local str = self.discount_save[tonumber(send_parent_name)]
			self.cur_buy = self.hasbuy_array[tonumber(send_parent_name)]
			self.cur_max= self.max_array[tonumber(send_parent_name)]
			self.cur_index = tonumber(send_parent_name)
			
			if 1 == self.count[tonumber(send_parent_name)] then
				local ss = {activityid=self.activityid[tonumber(self.cur_item)],operatetype=4,operatepram = self.rewardlist[tonumber(self.cur_item)][self.cur_index].shelfid,operatepram1=self.rewardlist[tonumber(self.cur_item)][self.cur_index].rewarditem[1].index, subid = self.activitysubid[tonumber(self.cur_item)]}	
				local jsonstr = json.encode(ss)
				self.m_model:UpdateModel("SendActiOperate",jsonstr)
				self.can_click = true
			else
				GTDebug.LogError(str)
		       GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinActivitiesSub), "ui/activities/activitiesSub",nil,str)
			end
		elseif send_name == "buy" then		    
			if true == self.press_status then
				return		
			end
			
			local id = tonumber(event.sender.transform.parent.name)
			
			if 1001 == id then 
				if self.playerinfo.viplevel<2 then	
					GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities vip1"), DialogType.OKCancel, "BuyVip1Callback",self)
				else
					if self.playerinfo.dimondvalue<1000 then				
						GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities diamond notenough"), DialogType.OKCancel, "BuyDiamondNotenoughCallback",self)
					else				
						GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities recharge sure"), DialogType.OKCancel, "BuyRechargeSureCallback",self)				
					end			
				end			
			elseif 1004 == id then 
				self.press_status = true
				self.window:CloseTweenScale()
				GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinCharge), "ui/charge/ChargeWin", nil)				
			elseif 1008 == id then 
				self.press_status = true
				self.window:CloseTweenScale()
				GTUIManager.OpenWindowWithCoverBlur(self.window.scene, luanet.ctype(DFWinTranscript), "ui/transcript/transcript-main", self)			
			--转盘
			elseif 1006 == id then 
				if self.rotarestime <= 0 then
						GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities notired"), DialogType.AutoClose, "",self)					
				else
					if true ==self.m_model_bag.fuben_bag_is_full then
						
						GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinFubenBag), "ui/bag/fuben_bag", nil);
						return			
					end
					self.press_status = true
					local ss = {activityid=id,operatetype=2,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
					local jsonstr = json.encode(ss)
					self.m_model:UpdateModel("SendActiOperate",jsonstr)
					self.can_click = true
				end			
			end
		--竞技场荣耀特惠 购买按钮功能
		elseif send_name == "buy1" then
			local id = self.activityid[self.cur_item]
			if 1015 == id then 
			
				local item_index = tonumber(event.sender.transform.parent.name)
				self.cur_index = item_index
					
				if self.playerinfo.dimondvalue >= self.price_list[item_index] then 
					if true ==self.m_model_bag.fuben_bag_is_full then
						GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinFubenBag), "ui/bag/fuben_bag", nil);
						return			
					end
					self.cur_buy = self.hasbuy_array_1015[item_index]
					self.cur_max = self.max_array_1015[item_index]
					local ss = {activityid=self.activityid[self.cur_item],operatetype=4,operatepram = self.rewardlist[tonumber(self.cur_item)][item_index].shelfid,subid = self.activitysubid[tonumber(self.cur_item)]}	
					local jsonstr = json.encode(ss)
					self.m_model:UpdateModel("SendActiOperate",jsonstr)
					self.can_click = true
				else 
				
						GTUIManager.OpenDialogForLua(self.window.scene,Localization.Get("activities diamond notenough"), DialogType.OKCancel, "JJCDiamondNotenoughCallback",self)
				end
			elseif 1016 == id then 
				local item_index = tonumber(event.sender.transform.parent.name)
				self.cur_index = item_index
				GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinCharge), "ui/charge/ChargeWin", nil)
				
			elseif 1018 == id then 
				local item_index = tonumber(event.sender.transform.parent.name)
				self.cur_index = item_index
				GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinCharge), "ui/charge/ChargeWin", nil)
			end
		
		
		--活动详细信息button
		elseif send_parent_name == "middle" then
			
			if true == self.press_status then
				return		
			end
			
			self.pre_item = self.cur_item
			self.cur_item = send_name
									
			if tonumber(self.cur_item) >= self.totleitem then				
				--print("----this has no activityid---open")
				return
			end	
			
			if self.pre_item then 
				--pre == cur 关闭当前打开的条目
				if self.pre_item == self.cur_item then	
						self.press_status = true
						self.position_stop = 0
						--self:TweenScale(self.cur_item,false,"detail")
						self.pre_item = nil
						self.cur_item = nil
						print("---lua-------------------------------close")
				else
					--关闭之前打开的弹框
					self.press_status = true
					--self:TweenScale(self.pre_item,false,"detail")
					--self.position_time = os.time()
					self.position_stop = 1
					print("---lua-------------------------------close pre_item")
				end
				
			else
				--self:TweenScale(self.cur_item,true)
				self.position_stop = 0
				print("---lua-------------------------------open")
					local openstatus = self.open_status[tonumber(self.cur_item)]
					if 0 ==openstatus then 
						local actid=self.activityid[tonumber(self.cur_item)]
						local sid=self.activitysubid[tonumber(self.cur_item)]
						local ss = {activityid=actid,subid=sid}	
						local jsonstr = json.encode(ss)
						self.m_model:UpdateModel("SendDetailRequest",jsonstr)
						self.can_click = true
					else							
					end
					self.press_status = true
			end
						
		elseif send_name == "reg" then 
		    --GTDebug.LogError("reg")
			local str ={}
			local element = Localization.Get("activities 1021 reg0").."_"..Localization.Get("activities 1021 reg1").."_"..Localization.Get("activities 1021 reg2").."_"..Localization.Get("activities 1021 reg3")
			table.insert(str,element)
			--GTDebug.LogError(str)
			GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinRegulation), "ui/regulation/PublicRegulation",nil,str)
		elseif send_name == "property" then
		    local petid = {}
			local cur = tostring(self.cur_pet)
			table.insert(petid,cur)
			GTUIManager.OpenWindowWithCoverBlackForLua(self.window.scene, luanet.ctype(DFWinPetPiece), "ui/newpet/pet_piece", nil,petid);
			--等待宠物接口
		elseif send_name == "arrow" then
			local arrow_trans = event.sender.transform
			local id = tostring(self.activityid[tonumber(self.cur_item)])
			local rank = self.window.transform:Find(id.."/info/panel/rank").gameObject
			if(arrow_trans.localRotation.z == 0) then
				rank:SetActive(true)
				arrow_trans.localEulerAngles = Vector3(0,0,270)
			else
				rank:SetActive(false)
				arrow_trans.localEulerAngles = Vector3(0,0,0)
			end
		elseif send_name == "extract" then
			if send_parent_name =="free" then
				local ss = {activityid=self.activityid[self.cur_item],operatetype=5,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
				local jsonstr = json.encode(ss)
				self.m_model:UpdateModel("SendActiOperate",jsonstr)
			elseif send_parent_name == "diamond" then
				local ss = {activityid=self.activityid[self.cur_item],operatetype=6,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
				local jsonstr = json.encode(ss)
				self.m_model:UpdateModel("SendActiOperate",jsonstr)
			end
		elseif send_name == "game" then	
			local ss = {activityid=self.activityid[self.cur_item],operatetype=7,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
			local jsonstr = json.encode(ss)
			self.m_model:UpdateModel("SendActiOperate",jsonstr)
		--领取物品	
		elseif 	send_name == "get" then
			if true == self.press_status then
				return		
			end
			if true ==self.m_model_bag.fuben_bag_is_full then
				
				GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinFubenBag), "ui/bag/fuben_bag", nil);
				return			
			end
			
			GTUIManager.GetInstance():OpenWaitWindow()			
			--self.bagitem_id =   event.sender.transform.parent.parent.parent.parent.parent.name
			self.bagsubitem_id = event.sender.transform.parent.name
			local id = self.activityid[tonumber(self.cur_item)]
			self.cur_index = tonumber(send_parent_name)
			local t = self.cur_item
			--print("--id------subidx-----")
			--GTDebug.LogError(id)
			--GTDebug.LogError(self.bagsubitem_id)
			--首充一类
			if 1009 == id or 1002 == id  then			--[[1005 == id or--]] 	
				 local bagid = self.rewardlist[t][1].giftbagid
				 local ss = {activityid=id,operatetype=3,giftbagid=bagid,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
				 local jsonstr = json.encode(ss)
				 self.m_model:UpdateModel("SendActiOperate",jsonstr)
				 self.can_click = true
            elseif 1007 == id or 1016 == id or 1017 == id or 1018== id or 1011 == id then
			     self.click = tonumber(send_parent_name)
                 local bagid = self.acti_bagid[self.cur_item][tonumber(send_parent_name)]
				 --GTDebug.LogError(tostring(bagid))
                 local ss = {activityid=id,operatetype=3,giftbagid=bagid,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
				 local jsonstr = json.encode(ss)
				 self.m_model:UpdateModel("SendActiOperate",jsonstr)
                 self.can_click = true				 
			--end
			--理财一类
			elseif 1001 == id or 1003 == id or 1004 == id or 1012 == id or 1013 == id then	
				 local id2 = tonumber(self.bagsubitem_id)
				 --GTDebug.LogError(id2)
				 local bagid2 = self.rewardlist[t][id2].giftbagid
				 local ss = {activityid=id,operatetype=3,giftbagid=bagid2,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
				 local jsonstr = json.encode(ss)
				 self.m_model:UpdateModel("SendActiOperate",jsonstr)
				 self.can_click = true
            elseif 	1010 == id then
                 local ss = {activityid=id,operatetype=3,giftbagid=self.secretid,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}	
				 
				 local jsonstr = json.encode(ss)
				 self.m_model:UpdateModel("SendActiOperate",jsonstr)
                 self.can_click = true	
			elseif 	1022 == id then
                 local ss = {activityid=id,operatetype=3,giftbagid=self.secretid,operatepram=0,subid = self.activitysubid[tonumber(self.cur_item)]}					 
				 local jsonstr = json.encode(ss)
				 self.m_model:UpdateModel("SendActiOperate",jsonstr)
                 self.can_click = true	 
			end
			
			--type 3 集字/每日豪华套餐
			self.press_status = true		
        end
		--GTDebug.LogError(self.activityid[tonumber(send_name)])
        if send_name ~="close" and send_name~="buy1" and send_name~="buy" and send_name~="get" and send_name~="goto" and send_name ~="exchange"  and send_name ~= "property" and send_name ~= "arrow" and send_name ~= "extract" and send_name ~= "reg" and send_name ~= "game" and (last ~= self.activityid[tonumber(send_name)] or lastsub ~= self.activitysubid[tonumber(send_name)]) then

				if 1014 == self.activitylist[tonumber(send_name)].activityid  and 1 == self.activitylist[tonumber(send_name)].subid then
					   if true == self.m_model.discount_mark and self.activitylist[tonumber(send_name)].hasred == true then
						  self.activitylist[tonumber(send_name)].hasred = false
						  self.m_model.discount_mark = false
						  local red =self.window.transform:Find("middle/Grid/"..self.cur_item.."/redpoint").gameobject
						  red:SetActive(false)
					   end
				
				elseif 1014 == self.activitylist[tonumber(send_name)].activityid  and 2 == self.activitylist[tonumber(send_name)].subid then
					   if true == self.m_model.discount_mark1 and self.activitylist[tonumber(send_name)].hasred == true then
						  self.activitylist[tonumber(send_name)].hasred = false
						  self.m_model.discount_mark1 = false
						  local red =self.window.transform:Find("middle/Grid/"..self.cur_item.."/redpoint").gameobject
						  red:SetActive(false)
					   end
				end
				
				if 1015 == self.activitylist[tonumber(send_name)].activityid then
					   if true == self.m_model.arena_sale_login_mark and self.activitylist[tonumber(send_name)].hasred == true then
						  self.activitylist[tonumber(send_name)].hasred = false
						  self:judgeredpoint(false)
						  self.m_model.arena_sale_login_mark = false
						  local red =self.window.transform:Find("middle/Grid/"..self.cur_item.."/redpoint").gameobject
						  red:SetActive(false)
					   end
				end
				
			  if self.changing_activity_tab == false then
				  --GTDebug.LogError(self.activityid[tonumber(send_name)])
				  self.changing_activity_tab = true
				  local obj = self.window.transform:Find(last)
				  obj.gameObject:SetActive(false)
				  --GTDebug.LogError("self.cur_item:"..tostring(self.cur_item))
				  --GTDebug.LogError("current activity id: "..tostring(self.activitylist[self.cur_item].activityid))
				  self:LoadScene(self.activitylist[tonumber(send_name)].activityid)
			  end 
			  
		end		

	end,
	
	RunFinish = function(self,mark)
		   GTUIManager.OpenWindow(self.window.scene, luanet.ctype(DFWinTranscript), "ui/transcript/transcript-main", true, nill);
		   --GTUIManager.OpenWindowWithCoverBlack(self.window.scene, luanet.ctype(DFWinCharge), "ui/charge/ChargeWin", nil)			
    end,
	--物品显示
	OnItemShowEventt = function(self,event)
		local send_name = event.sender.name
		local send_parent_name = event.sender.transform.parent.name
		local send_parent_info = event.sender.transform.parent.parent.name
		local id = self.activityid[tonumber(self.cur_item)]
		local itemid = 0
		local index = 1
		local t = self.cur_item
		--首充大礼
	--[[	if 1005 == id then
			index = tonumber(send_parent_name)
			itemid = self.rewardlist[1].rewarditem[index].itemid
		
		else--]]
		
		--理财基金
		if 1001 == id then
			local item = tonumber(send_parent_name)
			itemid = self.rewardlist[t][item].rewarditem[1].itemid
		--副本集字--体力补给	
		elseif 1009 == id or 1002 == id then
			index = 1
			itemid = self.rewardlist[t][1].rewarditem[index].itemid
        --感恩回馈			
		elseif 1003 == id then
			local index = tonumber(send_name)
			local item = tonumber(send_parent_info)
			itemid = self.rewardlist[t][item].rewarditem[index].itemid
		--竞技场宝箱奖励
		elseif 1007 == id then
			   index = tonumber(send_name+1)
			   local item = tonumber(send_parent_name)
			   itemid = self.rewardlist[t][item].rewarditem[index].itemid
		--秘境闯关	
		elseif 1010 == id then		    
			local index = tonumber(send_name)
			itemid = self.rewardlist[t][1].rewarditem[index].itemid	
			
		elseif 1011 == id then 
			local index = tonumber(event.sender.transform.parent.parent.parent.name)
			local item_index = tonumber(send_name)
			itemid = self.rewardlist[t][index].rewarditem[item_index].itemid
		--主线闯关
		elseif 1012 == id then		    
			local index = tonumber(send_name)
			itemid = self.rewardlist[t][1].rewarditem[index].itemid
		elseif 1013 == id then		    
			local index = tonumber(send_parent_info)
			itemid = self.rewardlist[t][index].rewarditem[tonumber(send_name)].itemid	
        elseif 1014 == id then
            if "0" == send_name	then
			   local index = tonumber(send_parent_info)
			   itemid = self.rewardlist[t][index].costid
			else
			   local index = tonumber(event.sender.transform.parent.parent.parent.name)
			   local item_index = tonumber(send_name)
			   itemid = self.rewardlist[t][index].rewarditem[item_index].itemid			
            end		
		elseif 1015 == id then 
			local index = tonumber(event.sender.transform.parent.parent.parent.name)
			local item_index = tonumber(send_name)
			--GTDebug.LogError("index "..tostring(index)..":: item_index"..tostring(item_index))
			itemid = self.rewardlist[t][index].rewarditem[item_index].itemid
			
		elseif 1016 == id then 
			local index = tonumber(event.sender.transform.parent.parent.parent.name)
			local item_index = tonumber(send_name)
			itemid = self.rewardlist[t][index].rewarditem[item_index].itemid
		
		elseif 1017 == id then 
			local index = tonumber(event.sender.transform.parent.parent.parent.name)
			local item_index = tonumber(send_name)
			itemid = self.rewardlist[t][index].rewarditem[item_index].itemid
			
		elseif 1018 == id then 
			local index = tonumber(event.sender.transform.parent.parent.parent.name)
			local item_index = tonumber(send_name)
			itemid = self.rewardlist[t][index].rewarditem[item_index].itemid
		
		elseif 1019 == id then 
			local index = tonumber(event.sender.transform.parent.parent.parent.name)
			local item_index = tonumber(send_name)
			itemid = self.rewardlist[t][index].rewarditem[item_index].itemid
			
		end		
		
		--if itemid==1440600000 or itemid==1440700000 then
			--print("not show di & gold")		
		--else
		ItemDialog.GetInstance():openPreviewDialog(self.window.scene,itemid)
		--end
	end,
}