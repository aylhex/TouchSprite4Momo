--README:A simple lua script used2 signup momo account with qq account (limited to android)
--protosomatic Lib supported by TS
require("TSLib")
local ts = require("ts")
local sz = require("sz")


-- ======================================    inheritance    ==================================

function clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
          return object
        elseif lookup_table[object] then
          return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--Create an class.
function class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
      superType = nil
      super = nil
    end

    if superType == "function" or (super and super.__ctype == 1) then
        -- inherited from native C++ Object
        cls = {}

        if superType == "table" then
            -- copy fields from super
            for k,v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super    = super
        else
            cls.__create = super
        end

        cls.ctor    = function() end
        cls.__cname = classname
        cls.__ctype = 1

        function cls.new(...)
            local instance = cls.__create(...)
            -- copy fields from class to native object
            for k,v in pairs(cls) do instance[k] = v end
            instance.class = cls
            instance:ctor(...)
            return instance
        end

    else
        -- inherited from Lua Object
        if super then
            cls = clone(super)
            cls.super = super
        else
            cls = {ctor = function() end}
        end

        cls.__cname = classname
        cls.__ctype = 2 -- lua
        cls.__index = cls

        function cls.new(...)
            local instance = setmetatable({}, cls)
            instance.class = cls
            instance:ctor(...)
            return instance
        end
    end

    return cls
end


-- =====================================    general lib    ===================================
  -- un lock device
  function unLock()
    flag = deviceIsLock()
    if flag ~= 0 then
      unlockDevice()
    end
  end

  --airplaneModeSwitch //
  function airplaneModeSwitch()
      setAirplaneMode(true)
      mSleep(4000)
      setAirplaneMode(false)
      mSleep(3000)
  end

  --click
  function click()
    touchDown(x,y)
    mSleep(300)
    touchUp(x,y)
  end

  --open momo
  function openMomo()
    local momo = "com.immomo.momo"
    runApp(momo)
    mSleep(2000)
  end

  -- close MOmo
  function closeMomo()
    local momo = "com.immomo.momo"
    closeApp(momo)
    mSleep(1000)
  end

  --flip a --> b
  function flip(x1,y1,x2,y2)
    touchDown(x1,y1)
    mSleep(30)
    touchMove(x2,y2)
    mSleep(500)
    touchUp(x2,y2)
    mSleep(2000)
  end

  -- clear string
  function clearString()
      inputText("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b")
  end

  -- check if an element(value) inside a table
  function inside(table,str)
    if (table == nil or table == false)
    then
        return false
    else
        local index = 0
        for key,value in pairs(table) do
            if value == str then
                index = index + 1
            end
        end

        if(index > 0)
        then
          return true
        else
          return false
        end
    end
  end

  --write a string to a file
  function writeContent(fileName,content,pattern)
    local file = io.open(fileName,pattern)
    file:write(content)
    file:close()
  end

  -- write a table to a file
  function writeContentTable(fileName,tbl,pattern)
    local file = io.open(fileName,pattern)
    if(#tbl > 0)
    then
      for i = 1,#tbl do
        file:write(tbl[i],"\n")
      end
    end
      file:close()
  end

  -- remove element by value
  function removeElementByValue(tbl,str)
    for key,val in pairs(tbl) do
      if(val == str)
      then
          table.remove(tbl,key)
      end
    end
    return tbl
  end

  -- flip up continuously
  function flipContinuously(style,num1,num2)
    if style == "up" then
      for i = 1,math.random(num1,num2),1 do
    		local x,y = getScreenSize()
    		touchDown(x/2, 3*y/4)
    		for i = 0, 500,5 do
    			touchMove(x/2 ,y/2 - i);
    			mSleep(10)
    		end
    		mSleep(1000)
    		touchUp(x/2, 3*y/4 - 500)
    		mSleep(1000)
    	end
    elseif style == "down" then
      for i = 1,math.random(num1,num2),1 do
    		local x,y = getScreenSize()
    		touchDown(x/2, y/2)
    		for i = 0, 500,5 do
    			touchMove(x/2 ,y/2 + i);
    			mSleep(10)
    		end
    		mSleep(1000)
    		touchUp(x/2, y/2 + 500)
    		mSleep(1000)
    	end
    else
      return false
    end
  	mSleep(1000)
  end

  -- function: get a string of required capacity   //very debased method .. to be optimized(string.format )
  function getRandomStrings(pattern,len)
    local str = ''
  	if(type(len) ~= "number")
  	then
  		toast("number expected,got " .. type(len) .. ",stupid!!!",3)
  		return false
  	else
      if(pattern == "mix")                              -- get mix strings
      then
        local var = {{97,122},{65,90},3}
        for i = 1,len,1 do
          local index = math.random(1,3)
          if(index == 3)
          then
            str = str .. math.random(0,9)
          else
            str = str .. string.char(math.random(var[index][1],var[index][2]))
          end
        end
        return str
      elseif(pattern == "number")
      then
        str = str .. math.random(1,9)
    		for i = 2,len,1 do
    			str = str .. math.random(0,9)
    		end
    		return str
      elseif(pattern == "letter")
      then
        for i = 1,len,1 do
          str = str .. string.char(math.random(97,122))
        end
        return str
      elseif(pattern == "capital")
      then
        for i = 1,len,1 do
          str = str .. string.char(math.random(65,90))
        end
        return str
      elseif(pattern == "strings")
      then
        for i = 1,len,1 do
          local index = math.random(0,1)
          str = str .. string.char(index*math.random(65,90) + (1-index)*math.random(97,122))
        end
        return str
      else
        toast("Invalid pattern,only number|letter|capital|strings|mix are activated!")
        return false
      end
  	end
  end

-- holdon if stuck in some page
Page = {}
function Page:holdon(pageName,seconds)
  local i = 0
  repeat
    if(multiColor(pageName)) then
      break
    end
    mSleep(1000)
    i = i + 1
  until (i == seconds)

  if(i == seconds) then
    self.isRequired = false
  else
    self.isRequired = true
  end
end

function Page:wait(pageName,seconds)
  local i = 0
  repeat
    if(not multiColor(pageName)) then
      break
    end
    mSleep(1000)
    i = i + 1
  until (i == seconds)

  if (i == seconds) then
    self.isStuck = true
  else
    self.isStuck = false
  end
end

-- concat a table to a string in which follows k,v pattern // original intention: limited to http://....?args[]=val& .....
function mergeTable(tbl,sep1,sep2)
	if tbl then 
		if type(tbl) == 'table' then 
			local var = {} 
			local sep1 = sep1 or "="
			local sep2 = sep2 or "&"
			
			for k,v in pairs(tbl) do
				table.insert(var,string.format("%s%s%s",k,sep1,v))
			end 
			
			return table.concat(var,sep2)
		else 
			return false 
		end 
		
	else 
		return false 
	end 
end 
-- ====================================        data        ========================================
Data = {}
function Data:getFirstQQ()
  local var = {}
  local qqInfo = readFile(userPath() .. "/res/data/Idata/qqInfo.txt")
  if (qqInfo == false or qqInfo == nil or (string.len(qqInfo[1]) < 10)) then
    return false
  else
    var.qqAccount = strSplit(qqInfo[1],"----")[1]
    var.qqPwd = strSplit(qqInfo[1],"----")[2]
    return var
  end
end

function Data:getNickName()
  local nickName = readFile(userPath() .. "/res/data/Idata/nickName.txt")
  if (#nickName > 0) then
    return nickName[1]
  else
    return false
  end
end

function Data:getHeadsInfo()
  writeFileString(userPath().."/res/data/Idata/headInfo.txt","","w")
  local allFileName = io.popen("ls " .. userPath() .. "/res/photos/")
  local f = assert(io.open(userPath().."/res/data/Idata/headInfo.txt", "a"))
  for fileName in allFileName:lines() do
    f:write(fileName .. "\n")
  end
  f:close()
  allFileName:close()
end

function Data:delFirstElement(...)
  arg = { ... }
  for i = 1,#arg do
    if(arg[i] == "qqInfo") then
      local qqInfo = readFile(userPath() .. "/res/data/Idata/qqInfo.txt")
      if(table.remove(qqInfo,1)) then
        writeContentTable(userPath() .. "/res/data/Idata/qqInfo.txt",qqInfo,"w")
        toast(string.format("1st element of %s has been removed ..",arg[i]),0.5)
      end
    elseif(arg[i] == "nickName") then
      local nickName = readFile(userPath() .. "/res/data/Idata/nickName.txt")
      if(table.remove(nickName,1)) then
        writeContentTable(userPath() .. "/res/data/Idata/nickName.txt",nickName,"w")
        toast(string.format("1st element of %s has been removed ..",arg[i]),0.5)
      end
    end
  end
end

-- get register log
function Data:getRegisterLog()
  local var = {}
  var.momoId = self.momoId
  var.momoPwd = self.momoPwd
  var.qqAccount = self:getFirstQQ().qqAccount
  var.qqPwd = self:getFirstQQ().qqPwd
  var.status = self.status
  var.ip = getNetIP()
  var.location = "hangzhou"
  var.SIMSerial = "unknown"
  return var
end

function Data:oRegisterLog()
  local var = self:getRegisterLog()
  writeContent(userPath() .. "/res/data/Odata/RegisterLog.txt",os.date("%Y/%m/%d  %H:%M:%S",ts.ms()) .. "----" .. var.momoId .. "----" .. var.momoPwd .. "----" .. var.qqAccount .. "----" .. var.qqPwd .. "----" .. var.status .. "\n","a")
end

function Data:keepDefectiveQQ()
	local qqInfo = readFile(userPath() .. "/res/data/Idata/qqInfo.txt")
	local allFileName = ts.hlfs.getFileList(userPath() .. "/res/data/Odata")
	if(inside(allFileName,"exception"))
	then
		writeContent(userPath() .. "/res/data/Odata/exception/deprecatedQQaccount.txt",qqInfo[1] .. "\n","a")
	else
		ts.hlfs.makeDir(userPath() .. "/res/data/Odata/exception")
		writeContent(userPath() .. "/res/data/Odata/exception/deprecatedQQaccount.txt",qqInfo[1] .. "\n","a")
	end
end

function Data:getHeadsInfo()
  local headsInfo = {}
  local allFileName = io.popen("ls "..userPath().."/res/PhotosRepo/")
  for fileName in allFileName:lines() do
    table.insert(headsInfo,fileName)
  end
  allFileName:close()
  return headsInfo
end

function Data:initPhotos()                                                        -- to be optimized
  --local photoBid = "com.android.gallery3d"
  local fileNames = ts.hlfs.getFileList("/sdcard/Alarms")
  for i,v in pairs(fileNames) do
    if not(v == "." or v == "..") then
      os.remove(string.format("/sdcard/Alarms/%s",v))
    end
  end

  self.headsInfo = self:getHeadsInfo()
  self.photoIndex = math.random(1,#self.headsInfo)
  local status = ts.hlfs.copyFile(string.format("%s/res/PhotosRepo/%s",userPath(),self.headsInfo[self.photoIndex]),string.format("/sdcard/Alarms/%s",self.headsInfo[self.photoIndex]))
  saveImageToAlbum(string.format("/sdcard/Alarms/%s",self.headsInfo[self.photoIndex]))
end

function Data:delTouchedPhoto()
  os.remove(userPath() .. "/res/PhotosRepo/" .. self.headsInfo[self.photoIndex])
end

-- data transfer
function Data:httpSendRegisterLog(url)
  local i = 0
	local header_send = {typeget = "android"}
	local body_send = {}
  local var = self:getRegisterLog()
  local site = string.format("http://172.21.1.111:8080/yh/momo/%s?momo=%s&momoPwd=%s&qq=%s&qqPwd=%s&status=%s&simCard=%s&ip=%s&location=%s",url,var.momoId,var.momoPwd,var.qqAccount,var.qqPwd,var.status,var.SIMSerial,var.ip,var.location)
  repeat
    local status_resp,header_resp,body_resp = ts.httpPost(site,header_send, body_send)
    i = i + 1
  until (status_resp == 0 or i >= 5)
  if i >= 5 then
    toast("failed 2 post data to the server!",30)
    mSleep(30000)
  end
end






-- ==================================    UI    ==============================================
local DEVICE = {}
DEVICE.width,DEVICE.height = getScreenSize()
UINew({num=2,titles="MOMOREGISTER,CHECK",okname="确认",cancelname="取消",config="momoRegister_uiconfig_android.dat",orient=0,timer=600,width=DEVICE.width,height=DEVICE.height,pagenumtype="dot"})

-- first page title : register config
UILabel({num=1,text="Register Config",align="center",size="20",color="100,100,100"})
UILabel("")
-- register count of a sigle loop
UILabel({num=1,text="Count: ",color="100,100,100",width="340",nowrap=1})
UIEdit({num=1,id="ui_count",prompt="? account",text="5",color="50,50,50",width="630"})
-- momo gender
UILabel({num=1,text="MomoGender: ",color="100,100,100",width="350",nowrap=1})
UICombo({num=1,id="ui_momoGender",list="male,female",width="640",sel="1"})
-- moomo pwd
UILabel({num=1,text="MomoPwd: ",color="100,100,100",width="350",nowrap=1})
UIComboRlt(1,"ui_momoPwdType,ui_momoPwd","constant,arbitrary","kd123456,123456#len(pwd)=8,len(pwd)=6","momopwd","0",320,1)
UIComboRlts("ui_momoPwd","momopwd","0",320,0)

UILabel({num=1,text="OcrInfo: ",color="100,100,100",width="340",nowrap=1})
UIEdit({num=1,id="ui_ocrInfo",prompt="haoai Pkey ..",text="",color="50,50,50",width="630"})
-- second page
UILabel({num=2,text="Check Config",align="center",size="20",color="100,100,100"})
UILabel(2,"")
UILabel({num=2,text="CheckImmediately: ",color="100,100,100",width="400",nowrap=1})
UICombo({num=2,id="ui_checkImmediately",list="yes,nope",width="580",sel="1"})
UILabel({num=2,text="CheckTime: ",color="100,100,100",width="390",nowrap=1})
UIEdit({num=2,id="ui_checkTime",prompt="2018/01/01 12:01:01",text="2018/01/01 12:01:01",color="50,50,60",width="580"})

--UIShow()



local configInfo = {}
function configInfo:get()
  self.count = ui_count*1
  self.momoGender = ui_momoGender
  self.momoPwdType = ui_momoPwdType
  self.momoPwd = ui_momoPwd
  self.checkImmediately = ui_checkImmediately
  self.checkTime = ui_checkTime
  self.ocrInfo = ui_ocrInfo
end

function configInfo:check()

  local a,b = string.find(self.checkTime,"%d%d%d%d/(%d+)/(%d+)%s(%d+):(%d+):(%d+)")

  if (self.count == "") then
    toast("\'count\' gots nil,reset plz")
    lua_exit()
  elseif(self.count*1 == 0) then
    toast("\'count\' need to be greater than 0 !")
    lua_exit()
  elseif(not(a and b)) then
    toast("invalid checkTime,reset plz")
    lua_exit()
  elseif(a ~= 1 or string.len(self.checkTime) ~= b) then
    toast("CheckTime got redundant characters,reset plz")
    lua_exit()
  elseif(self.ocrInfo == "") then
    toast("ocrInfo got nil .")
    lua_exit()
  end

end

-- ================================================    zhiye    =============================================
-- local foo = "com.zhiye.cellphoneinformation"
local Zhiye = {}
Zhiye.bid = "com.zhiye.cellphoneinformation"
function Zhiye:open()
  runApp(self.bid)
  mSleep(2000)
end

function Zhiye:close()
  closeApp(self.bid)
  mSleep(2000)
end

function Zhiye:newRecord()
  local homePage = {
  	{  169,  792, 0x208ae3},
  	{  816,  797, 0x208ae3},
  	{  179, 1088, 0x208ae3},
  	{  875, 1086, 0x208ae3},
  }
  local secondPage = {
  	{  187,  140, 0x3f51b5},
  	{  995,  148, 0x3f51b5},
  	{  179,  858, 0x208ae3},
  	{  893,  855, 0x208ae3},
  	{  184, 1145, 0x208ae3},
  	{  909, 1146, 0x208ae3},
  }
  local appListPage = {
  	{  182,  146, 0x3f51b5},
  	{  252,  153, 0xffffff},
  	{  284,  151, 0x3f51b5},
  	{  323,  151, 0xffffff},
  	{  368,  151, 0xffffff},
  	{  374,  151, 0x3f51b5},
  	{  398,  152, 0xffffff},
  }
  local momoIcon = {
  	{  147, 1411, 0x5040f7},
  	{   78, 1426, 0x477cfd},
  	{   96, 1412, 0xffffff},
  	{  116, 1411, 0x5140f7},
  	{  166, 1409, 0xffffff},
  	{  191, 1409, 0xff733d},
  	{  152, 1470, 0x2f4ef6},
  }
  local appListPopup = {
  	{  235, 1181, 0x5a595b},
  	{  800, 1179, 0x5a595b},
  }
  local saveDeviceInfoPage = {
  	{  482,  150, 0xffffff},
  	{  403,  150, 0xffffff},
  	{  410,  150, 0xffffff},
  	{  420,  150, 0xffffff},
  	{  428,  150, 0x3f51b5},
  	{  435,  150, 0xffffff},
  	{  442,  150, 0x3f51b5},
  	{  452,  150, 0xffffff},
  	{  475,  150, 0x3f51b5},
  	{  252,  153, 0x3f51b5},
  }
  local  currentEquipmentListPage = {
  	{  215,  143, 0x3f51b5},
  	{  233,  143, 0xffffff},
  	{  250,  144, 0x3f51b5},
  	{  269,  145, 0xffffff},
  	{  278,  145, 0x3f51b5},
  	{  286,  145, 0xffffff},
  	{  293,  145, 0x3f51b5},
  }

  if appIsRunning(self.bid) == 1  then
    self:close()
  end
  self:open()
  Page:holdon(homePage,7)
  if (Page.isRequired) then
    randomTap(534, 1085,20)
    Page:holdon(secondPage,30)
    if (Page.isRequired) then
      randomTap(537, 1140, 20)
      Page:holdon(appListPage,30)
      if (Page.isRequired) then
        local i = 0
        repeat
          mSleep(3000)
          local X,Y = findMultiColorInRegionFuzzyByTable(momoIcon, 90, 22, 226, 227, 1767)
          if X ~= -1 then
            tap(X,Y)
            Page:holdon(appListPopup,5)
            if (Page.isRequired) then
              tap(246,  847)                          -- tap select
              mSleep(2000)
              tap(973,  144)                          -- tap setDeviceInfo
              Page:holdon(saveDeviceInfoPage,9)
              if Page.isRequired then
                tap(1007,  143)                       -- tap save
                Page:holdon(currentEquipmentListPage,30)
                if Page.isRequired then
                  pressHomeKey()
                else
                  self:newRecord()
                end
              else
                self:newRecord()
              end
            else
              self:newRecord()
            end
          else
            flipContinuously("up",1,1)
          end
        until ((X ~= -1) or (i >= 5))
      else
        self:newRecord()
      end
    else
      self:newRecord()
    end
  else
    self:newRecord()
  end
end


-- ===================================    register       ======================================

Register = {}
function Register:flow()
  --local LOGGED = false
  --local CHECKED = false
  self:init()
  self:loginWithqq()
  self:fillUpInfo()
  self:dropHomePopup()
  self:getMomoId()
  self:ifWarningIcon()
  Data:oRegisterLog()
  --Data:httpSendRegisterLog()
  Data:delFirstElement("qqInfo","nickName")
  Data:delTouchedPhoto()
  self:go2Nearby()

end







function Register:init()

  local deviceIsLock = deviceIsLock()             -- unlock device
  if deviceIsLock == 1 then
    unlockDevice()
  end

  local battery = batteryStatus()                 -- low power exception
  if(battery.charging == 0 and battery.level <= 20)then
    toast("low power,charge plz",3)
    mSleep(3000)
    lua_exit()
  end
  setAutoLockTime(30*60*1000)
  switchTSInputMethod(true)

  local qqBid = "com.tencent.mobileqq"
  local momoBid = "com.immomo.momo"
  local momoIsRunning = appIsRunning(momoBid)
  if(momoIsRunning == 1) then
    closeMomo()
  end
  cleanApp(qqBid)                                 -- clear cache data of qq         // to be confirmed depend on zhiye
  self:momoAuthorization()
end

function Register:momoAuthorization()
  airplaneModeSwitch()
  airplaneModeSwitch()
  openMomo()
  local momoAuthorization = {
  	{  134,  732, 0x1e1e1e},
  	{  270,  740, 0x1e1e1e},
  	{  313, 1170, 0x3462ff},
  	{  922, 1170, 0x3462ff},
  }
  local subMomoAuthoriazation = {
  	{  200,  859, 0x009688},
  	{  254,  911, 0x009688},
  	{  250, 1002, 0xffffff},
  	{  588, 1003, 0xffffff},
  }
  Page:holdon(momoAuthorization,5)
  if (Page.isRequired) then
    randomTap(541, 1162, 50)                    -- tap "start authorize"
    mSleep(2000)
    Page:holdon(subMomoAuthoriazation,5)
    if (Page.isRequired) then
      randomTap(826, 1076,5)
      -- to be confirmed ..
    else
      toast("subMomoAuthoriazation was not detected!",2)
    end
  else
    toast("no momoAuthorization!")
  end
end



function Register:loginWithqq()
  local momoBid = "com.immomo.momo"
  local momoLoginPage1 = {
  	{  436,  437, 0xffffff},
  	{  507,  436, 0xffffff},
  	{  557,  436, 0xffffff},
  	{  269, 1430, 0x3462ff},
  	{  906, 1437, 0x3462ff},
  }

  local momoLoginPage2 = {
  	{   62,  155, 0x969696},
  	{   99,  970, 0xc8c8c8},
  	{  913,  970, 0xc8c8c8},
  }

  local momoLoginPage3 = {
  	{  245,  300, 0x000000},
  	{  259,  300, 0xffffff},
  	{  272,  300, 0x000000},
  	{  284,  300, 0xffffff},
  	{  142,  857, 0x1eb9f2},
  	{  896,  854, 0x1eb9f2},
  }

  Page:holdon(momoLoginPage1,15)
  if(Page.isRequired) then
    randomTap(538, 1605, 40)                        -- tap signup
    mSleep(1000)
    Page:holdon(momoLoginPage2,15)
    if (Page.isRequired) then
      local loginWithQQBtn = {
      	{  540, 1759, 0xffffff},
      	{  540, 1739, 0xffffff},
      	{  481, 1765, 0x36b6ff},
      	{  542, 1824, 0x36b6ff},
      	{  598, 1765, 0x36b6ff},
      	{  537, 1702, 0x36b6ff},
      }
      mSleep(1000)
      local X,Y = findMultiColorInRegionFuzzyByTable(loginWithQQBtn,95, 267, 1669, 790, 1887)
      if(X ~= -1) then
        randomTap(X,Y,40)
        mSleep(5000)
        Page:holdon(momoLoginPage3,15)
        if(Page.isRequired) then
          self:inputQQAccount()
          self:handleLoginExceptions()
        else
          closeMomo()
          openMomo()
          self:loginWithqq()
        end
      else
        closeMomo()
        openMomo()
        self:loginWithqq()
      end
    else
      closeMomo()
      openMomo()
      self:loginWithqq()
    end
  else
    closeMomo()
    openMomo()
    self:loginWithqq()
  end
end

function Register:fillUpInfo()
  local fillUpInfoPage = {
  	{  315,  131, 0xfafafa},
  	{  315,  137, 0x1e1e1e},
  	{  315,  141, 0xfafafa},
  	{  315,  144, 0x1e1e1e},
  	{  315,  148, 0xfafafa},
  	{  315,  151, 0x1e1e1e},
  	{  315,  177, 0x1e1e1e},
  }
  local chooseAlbumPage = {
  	{  325,  130, 0x1a1b1d},
  	{  325,  136, 0xffffff},
  	{  325,  143, 0x1a1b1d},
  	{  325,  149, 0xffffff},
  	{  325,  155, 0x1a1b1d},
  	{  325,  162, 0xffffff},
  	{  325,  168, 0x1a1b1d},
  	{ 1045, 1891, 0x1780d2},
  }
  local editPhotoPage = {
  	{  363,  141, 0x1a1b1d},
  	{  363,  147, 0xffffff},
  	{  363,  154, 0x1a1b1d},
  	{  363,  160, 0xffffff},
  	{  373,  169, 0x1a1b1d},
  	{  380,  169, 0xffffff},
  	{  386,  169, 0x1a1b1d},
  }
  local photosPath = {
  	{  322,  942, 0x1a1b1d},
  	{  328,  942, 0xaaaaaa},
  	{  334,  942, 0x1a1b1d},
  	{  341,  942, 0xaaaaaa},
  	{  348,  942, 0x1a1b1d},
  	{  356,  942, 0xaaaaaa},
  	{  361,  953, 0x1a1b1d},
  	{  367,  953, 0xaaaaaa},
  	{  374,  952, 0x1a1b1d},
  	{  382,  951, 0xaaaaaa},
  }
  local genderNotePopUp = {
  	{  184,  824, 0xfafafa},
  	{  184,  830, 0x1e1e1e},
  	{  184,  835, 0xfafafa},
  	{  184,  839, 0x1e1e1e},
  	{  185,  843, 0xfafafa},
  	{  857, 1147, 0x3462ff},
  }
  local nickName = Data:getNickName()
  local var = {310,555,770}

  Page:holdon(fillUpInfoPage,9)
  if (Page.isRequired) then
    toast("got the fillUpinfoPage!..",0.5)
    Data:initPhotos()
    mSleep(1000)
    -- change head
    randomTap(548,  534, 100)                            -- tap head
    Page:holdon(chooseAlbumPage,7)
    if (Page.isRequired) then
      toast("got the AlbumPage!",1)
      mSleep(1000)
      randomTap(617,  139, 10)                            -- tap margin
      mSleep(1000)
      local i = 0
      -- find Path:/res/photos position
      while(i < 4) do
        local x,y = findMultiColorInRegionFuzzyByTable(photosPath, 90, 294,  837, 527, 1771)
        if (x ~= -1) then
          randomTap(x,y,50)
          mSleep(1500)
          break
        else
          flipContinuously("up",1,1)
        end
        i = i + 1
      end

      if i < 4 then
        randomTap(133,  373, 80)                           -- tap the 1st picture
        Page:holdon(editPhotoPage,7)
        if (Page.isRequired) then
          mSleep(1000)
          randomTap(808, 1856, 5)                            -- tap confirm
        else
          toast("error with getting editPhotoPage .. ")
          randomTap(77,  151, 5)                           -- tap back
          Page:holdon(fillUpInfoPage)
          if Page.isRequired then
            self:fillUpInfo()
          end
        end
      else
        toast("error with finding \"/sdcard/Alarms/..\"",3)
        randomTap(84,  155, 5)
        Page:holdon(fillUpInfoPage)
        if Page.isRequired then
          self:fillUpInfo()
        end
      end
    else
      self:fillUpInfo()
    end

    Page:holdon(fillUpInfoPage,7)
    if (Page.isRequired) then
      -- input nickName
      randomTap(627,  845, 10)                             -- get nickName cursor
      mSleep(1000)
      clearString()
      inputText(nickName)

      -- get random birthday
      randomTap(660,  963, 10)                            -- tap birthday
      mSleep(1000)
      for k,v in pairs(var) do
        for i = 1,math.random(2,6),1 do
          tap(v,math.random(600,1190))
          mSleep(500)
        end
      end
      randomTap(805, 1319, 10)                            -- tap confirmed
      mSleep(1000)

      -- get required gender
      while(not isColor(927, 1157, 0x3462ff)) do
        tap(925, 1138)
        mSleep(1000)
        if multiColor(genderNotePopUp) then
          randomTap(860, 1069, 10)                      -- tap configm
          mSleep(1000)
        end
      end

      -- tap next step
      randomTap(555, 1402, 20)

      self:setMomoPwd()
    end

  else
    toast("oops this currence shouldn't pop up  ! -- error with getting fillUpInfoPage",20)
  end
end

function Register:setMomoPwd()
  local setMomoPwdPage = {
  	{  101,  638, 0xc8c8c8},
  	{  342,  642, 0xc8c8c8},
  	{  857,  644, 0xc8c8c8},
  }
  local fillUpInfoPage = {
  	{  315,  131, 0xfafafa},
  	{  315,  137, 0x1e1e1e},
  	{  315,  141, 0xfafafa},
  	{  315,  144, 0x1e1e1e},
  	{  315,  148, 0xfafafa},
  	{  315,  151, 0x1e1e1e},
  	{  315,  177, 0x1e1e1e},
  }
  Page:holdon(setMomoPwdPage,10)
  if(Page.isRequired) then
    randomTap(812,  397, 20)                -- tap momo pwd field to get cursor
    mSleep(1000)
    if (configInfo.momoPwdType == "constant") then
      inputText(configInfo.momoPwd)
      Data.momoPwd = configInfo.momoPwd
    else
      if (configInfo.momoPwd == "len(pwd)=8") then
        Data.momoPwd = getRandomStrings("mix",8)
        inputText(Data.momoPwd)
      elseif(configInfo.momoPwd == "len(pwd)=6") then
        Data.momoPwd = getRandomStrings("mix",6)
        inputText(Data.momoPwd)
      end
    end

    mSleep(2000)
    randomTap(535,  622, 30)                -- tap complete registeration
    mSleep(1000)
  else
    if (multiColor(fillUpInfoPage)) then
      if (isColor(237, 1404, 0xc8c8c8)) then
        self:fillUpInfo()
      else
        randomTap(555, 1402, 20)
        self:setMomoPwd()
      end
    else
      toast("this toast shoudn't pop up , fatal error with set momo pwd section ..",20)
    end
  end
end

function Register:getMomoId()
  local momoUserDataPath = "/storage/emulated/0/immomo/users"
  local var = ts.hlfs.getFileList(momoUserDataPath)
  if (var) then
    local momoIDs = {}
    for k,v in pairs(var) do
      if(string.len(v) == 9) then
        table.insert(momoIDs,v)
      end
    end
    local momoId = momoIDs[#momoIDs]
    Data.momoId = momoId
    -- get momo pwd
    if (configInfo.momoPwdType == "constant") then
      Data.momoPwd = configInfo.momoPwd
    end
  end
end

function Register:ifWarningIcon()
  local momoIcon = {
    {   69,  667, 0x8c2dff},
    {   69,  684, 0x4281ff},
    {   85,  672, 0xffffff},
    {   98,  672, 0x4a31ff},
    {  112,  672, 0xffffff},
    {  124,  672, 0x4a31ff},
    {  160,  672, 0xff753a},
    {  130,  721, 0x294df7},
  }
  local warningIcon = {
  	{  280, 1119, 0xffffff},
  	{  202, 1058, 0xf75552},
  	{  207, 1204, 0xf75552},
  	{  357, 1055, 0xf75552},
  	{  359, 1207, 0xf75552},
  	{  278, 1154, 0xffffff},
  }
  local newsPage = {
  	{  136,  127, 0xfafafa},
  	{  136,  137, 0x1e1e1e},
  	{  136,  141, 0xfafafa},
  	{  136,  145, 0x1e1e1e},
  	{  136,  149, 0xfafafa},
  	{  136,  152, 0x1e1e1e},
  	{  136,  156, 0xfafafa},
  	{  136,  160, 0x1e1e1e},
  }
  local conversationsWithMomoPage = {
  	{   63,  155, 0x969696},
  	{  232,  160, 0xfafafa},
  	{  240,  165, 0x1e1e1e},
  	{  246,  165, 0xfafafa},
  	{  273,  165, 0x1e1e1e},
  	{  279,  165, 0xfafafa},
  	{  286,  158, 0x1e1e1e},
  	{  299,  158, 0xfafafa},
  	{  312,  158, 0x1e1e1e},
  }
  local talk2MomoPeakPos = {
  	{   30,  462, 0x4186ff},
  	{   42,  462, 0xffffff},
  	{   54,  461, 0x3e34f8},
  	{   75,  461, 0x4232f7},
  	{   88,  461, 0xffffff},
  }

  if (not isColor(540, 1831, 0x323333)) then
    randomTap(540, 1831, 10)
    mSleep(1000)
    self:ifWarningIcon()
  else
    Page:holdon(newsPage,5)
    if (Page.isRequired) then
      mSleep(1000)
      local x1,y1 = findMultiColorInRegionFuzzyByTable(momoIcon, 90, 22, 375, 198, 1613)
      if (x1 ~= -1) then
        mSleep(1000)
        randomTap(x1 + math.random(300,400), y1, 10)
        mSleep(1000)
        Page:holdon(conversationsWithMomoPage,7)
        if (Page.isRequired) then
          local i = 0
          repeat
            local a,b = findMultiColorInRegionFuzzyByTable(warningIcon, 90, 163,  245, 389, 1493)
            if (a ~= -1) then
              Data.status = "0"
              break
            else
              if(multiColor(talk2MomoPeakPos)) then
                Data.status = "1"
                break
              else
                flipContinuously("down",1,1)
              end
            end
            i = i + 1
          until (i == 3)
          if (i == 3) then
            Data.status = "1"
          end
          randomTap(74,  154, 10)
          mSleep(1000)
        else
          --toast("this shouldn't be pop up error with tap momoIncon",2)
          self:ifWarningIcon()
        end
      else
        toast("trying to find momoIcon ..",1)
        mSleep(1000)
        self:ifWarningIcon()
      end
    else
      toast("error with finding newsPage , to be debuged ..",10)
      mSleep(10000)
    end
  end
end

function Register:go2Nearby()
  local momoHomePage = {
  	{   86, 1845, 0x323333},
  	{   92, 1825, 0x323333},
  	{  105, 1817, 0x323333},
  	{  126, 1842, 0x323333},
  }
  randomTap(108, 1834, 10)              --tap hoem
  Page:holdon(momoHomePage,5)
  if (Page.isRequired) then
    local width,height = getScreenSize()
    flip(width/2,3*height/4,width/2,height/4)
    flip(width/2,3*height/4,width/2,height/4)
    randomTap(750,  138, 10)            -- tap people nearby
    mSleep(2000)
    flip(width/2,height/4,width/2,3*height/4)
    flip(width/2,height/4,width/2,3*height/4)
    flipContinuously("up",7,9)
  else
    self:go2Nearby()
  end
end

function Register:handleLoginExceptions()

  local fillUpInfoPage = {
  	{  315,  131, 0xfafafa},
  	{  315,  137, 0x1e1e1e},
  	{  315,  141, 0xfafafa},
  	{  315,  144, 0x1e1e1e},
  	{  315,  148, 0xfafafa},
  	{  315,  151, 0x1e1e1e},
  	{  315,  177, 0x1e1e1e},
  	{   86, 1407, 0xc8c8c8},
  	{  959, 1410, 0xc8c8c8},
  }
  local decodePage = {
  	{   24,  136, 0x4e8efe},
  	{   57,  128, 0xffffff},
  	{   63,  128, 0x4d91fe},
  	{   70,  128, 0xffffff},
  	{   88,  132, 0x4b92fe},
  	{  418,  147, 0xffffff},
  	{  434,  148, 0x39aafe},
  }
  local bindPhonePopup = {
  	{  157,  512, 0x3463ff},
  	{  154,  839, 0x3463ff},
  	{  165, 1314, 0x3463ff},
  	{  173, 1463, 0x2a4ecc},
  	{  919,  624, 0x3463ff},
  	{  921, 1042, 0x3463ff},
  	{  918, 1453, 0x2a4ecc},
  }
  local loginFailed1001 = {
  	{  161,  669, 0x11b7f5},
  	{  653,  668, 0x11b7f5},
  	{  450,  763, 0xffffff},
  	{  450,  770, 0x000000},
  	{  450,  774, 0xffffff},
  	{  450,  778, 0x000000},
  	{  450,  784, 0xffffff},
  	{  450,  790, 0x000000},
  }
  local loginFailed1001_1 = {
  	{  157,  705, 0x11b7f5},
  	{  625,  704, 0x11b7f5},
  	{  289,  992, 0xffffff},
  	{  303,  992, 0x000000},
  	{  313,  992, 0xffffff},
  	{  320,  992, 0x000000},
  	{  328,  992, 0xffffff},
  	{  336,  992, 0x000000},
  	{  342,  992, 0xffffff},
  	{  347,  992, 0x000000},
  }

  local loginFailed3103 = {
  	{  236,  741, 0x11b7f5},
  	{  843,  741, 0x11b7f5},
  	{  681,  958, 0x000000},
  	{  690,  958, 0xffffff},
  	{  699,  955, 0x000000},
  	{  707,  955, 0xffffff},
  	{  716,  955, 0x000000},
  	{  522, 1118, 0x000000},
  }
  local authorizationAndLoginPage = {
  	{  427,  146, 0x3aaafd},
  	{  454,  147, 0xffffff},
  	{  467,  147, 0x38adfe},
  	{  480,  147, 0xffffff},
  	{  300, 1840, 0x1eb9f2},
  	{  549, 1840, 0xffffff},
  	{  969, 1833, 0x1eb9f2},
  }
  local levelPopup ={
  	{  205,  636, 0xffffff},
  	{  310,  795, 0xffc74a},
  	{  464,  755, 0xeed7ca},
  	{  776,  792, 0x4db5fe},
  	{  767,  682, 0xffb91d},
  }
  local phoneContactsPage = {
  	{  622,  559, 0x007aff},
  	{  622,  595, 0x50ffdd},
  	{  622,  608, 0x007aff},
  	{  622,  622, 0x50ffdd},
  	{  622,  635, 0x007aff},
  	{  622,  649, 0x50ffdd},
  	{  622,  672, 0x007aff},
  	{  168, 1273, 0x3462ff},
  }
  local loginFailed = {
  	{   62,  155, 0x969696},
  	{   99,  970, 0xc8c8c8},
  	{  913,  970, 0xc8c8c8},
    {  481, 1765, 0x36b6ff},
    {  542, 1824, 0x36b6ff},
    {  598, 1765, 0x36b6ff},
    {  537, 1702, 0x36b6ff},
  }
  local momoLoginPage3 = {
  	{  245,  300, 0x000000},
  	{  259,  300, 0xffffff},
  	{  272,  300, 0x000000},
  	{  284,  300, 0xffffff},
  	{  142,  857, 0x1eb9f2},
  	{  896,  854, 0x1eb9f2},
  }
  local waitingPage = {
  	{   54,  207, 0x292929},
  	{   61,  252, 0x292929},
  	{  436,  202, 0x292929},
  	{  829,  229, 0x292929},
  	{  937,  246, 0x292929},
  }
  local loginFailed3104 = {
    {  222,  741, 0x11b7f5},
    {  657,  741, 0x11b7f5},
    {  633,  955, 0x000000},
    {  641,  955, 0xffffff},
    {  651,  955, 0x000000},
    {  659,  955, 0xffffff},
    {  668,  955, 0x000000},
  }
  local i = 0
  local j = 0
  local k = 0
  self.failedIndex1 = 0
  repeat
    if multiColor(decodePage) then
      self:ocrDecode()
      Page:wait(decodePage,10)
      if Page.isStuck then
        randomTap(874,  623, 10)
        clearString()
        self:ocrDecode()
      end
    elseif(multiColor(waitingPage)) then
      Page:wait(waitingPage,15)
    elseif(multiColor(loginFailed1001)) then
      if (i < 2) then
        randomTap(522, 1154, 10)                    -- tap confirm
        mSleep(1000)
        randomTap(538,  850, 20)
        i = i + 1
      else
        Data:keepDefectiveQQ()
        Data:delFirstElement("qqInfo")
        randomTap(522, 1154, 10)
        toast("defective qq account,trying another ..",1)
        mSleep(1000)
        self:inputQQAccount()
        self:handleLoginExceptions()
        break
      end
    elseif(multiColor(loginFailed1001_1)) then
      if (j < 2) then
        randomTap(541, 1152, 10)                    -- tap confirm
        mSleep(1000)
        randomTap(538,  850, 20)
        j = j + 1
      else
        Data:keepDefectiveQQ()
        Data:delFirstElement("qqInfo")
        randomTap(541, 1152, 10)
        toast("defective qq account,trying another ..",1)
        mSleep(1000)
        self:inputQQAccount()
        self:handleLoginExceptions()
        break
      end
    elseif(multiColor(loginFailed3103)) then
      -- to be optimized
      Data:keepDefectiveQQ()
      Data:delFirstElement("qqInfo")
      tap(542, 1118)
      mSleep(1000)
      self:inputQQAccount()
    elseif(multiColor(loginFailed3104)) then
      Data:keepDefectiveQQ()
      Data:delFirstElement("qqInfo")
      tap(542, 1118)
      mSleep(1000)
      self:inputQQAccount()
    elseif(multiColor(authorizationAndLoginPage)) then
      randomTap(530, 1838, 30)                          -- tap authorizationAndLogin
      Page:wait(authorizationAndLoginPage,5)
      if (multiColor(loginFailed)) then
        if (self.failedIndex1 < 2) then
          randomTap(540, 1759, 30)
          Page:holdon(momoLoginPage3,7)
          if (Page.isRequired) then
            self:inputQQAccount()
          end
          self.failedIndex1 = self.failedIndex1 + 1
        end
      end
    elseif(multiColor(loginFailed)) then
      mSleep(1000)
      randomTap(540, 1759, 20)
      Page:holdon(authorizationAndLoginPage,9)
      if Page.isRequired then
        randomTap(500,1840,10)
      end
      Page:holdon(momoLoginPage3,9)
      if (Page.isRequired) then
        self:inputQQAccount()
      end
    elseif(multiColor(bindPhonePopup) or multiColor(phoneContactsPage) or multiColor(levelPopup)) then
      toast("registerd qq ,trying another ..")
      Data:keepDefectiveQQ()
      Data:delFirstElement("qqInfo")
      Zhiye:newRecord()
      self:init()
      self:loginWithqq()
      break
    --elseif(multiColor(******)) then

    end
  until (multiColor(fillUpInfoPage))
end

function Register:ocrDecode()
  toast("decoding ..",2)
  ocrInfo("haoi23"," ",configInfo.ocrInfo)
  local text,tid = ocrScreen(345,258,732,415,2004,80,1)
  if (text) then
    inputText(text)
    mSleep(1000)
    randomTap(991,142,15)
  else
    local bool,bal=ocrBalance()
    if bool then
        if (bal*1 < 20) then
          dialog("Insufficient account balance,refill@www.haoi23.com")
          lua_exit()
        else
          self:ocrDecode()
        end
    else
        dialog("error with haoai Pkey,check it carefully",0)
        lua_exit()
    end
  end
end

function Register:inputQQAccount()
  toast("trying2 input qqInfo ..",1)
  local firstQQ = Data:getFirstQQ()
  if (firstQQ) then
    randomTap(783,  544, 20)                   -- get qq account cursor
    mSleep(2000)
    clearString()
    inputText(firstQQ.qqAccount)
    mSleep(1000)
    randomTap(818,  667, 20)                   -- get qq pwd cursor
    mSleep(2000)
    inputText(firstQQ.qqPwd)
    mSleep(1000)
    randomTap(539,  855, 40)                  -- tap login
  else
    toast("Run out of QQ accounts,initializing check part ..",3)
    mSleep(2000)
    Check.CHECKED = true
    Check:checkTimer()                 -- to be confirmed
  end
end

function Register:dropHomePopup()
  local bindPhonePopup = {
  	{  157,  512, 0x3463ff},
  	{  154,  839, 0x3463ff},
  	{  165, 1314, 0x3463ff},
  	{  173, 1463, 0x2a4ecc},
  	{  919,  624, 0x3463ff},
  	{  921, 1042, 0x3463ff},
  	{  918, 1453, 0x2a4ecc},
  }
  local levelPopup ={
  	{  205,  636, 0xffffff},
  	{  310,  795, 0xffc74a},
  	{  464,  755, 0xeed7ca},
  	{  776,  792, 0x4db5fe},
  	{  767,  682, 0xffb91d},
  }
  local phoneContactsPage = {
  	{  622,  559, 0x007aff},
  	{  622,  595, 0x50ffdd},
  	{  622,  608, 0x007aff},
  	{  622,  622, 0x50ffdd},
  	{  622,  635, 0x007aff},
  	{  622,  649, 0x50ffdd},
  	{  622,  672, 0x007aff},
  	{  168, 1273, 0x3462ff},
  }
  Page:holdon(bindPhonePopup,30)
  if (Page.isRequired) then
    randomTap(912,  527, 10)
    Page:holdon(phoneContactsPage,5)
    if (Page.isRequired) then
      randomTap(989,  160, 10)
    end
  else
    Page:holdon(levelPopup,5)
    if(Page.isRequired) then
      randomTap(912,  516, 7)
      mSleep(2000)
    else
      toast("couldn't find Home pop up,there must be an bug to be fix, trying to get momoId ..",2)
    end
  end
end

-- ===================================    check          ========================================
Check = {}
function Check.checkTimer()
  -- pass
  toast("checking part .. to be optimized")
end

function Check.checkMomoIdStatus()
  -- pass
end


--====================================    scripts    ==============================

UIShow()
configInfo:get()
configInfo:check()

for i = 1,configInfo.count,1 do
  Zhiye:newRecord()
  local foo = class("foo",Register)
  foo:flow()
end
