
--A simple lua script to build all required NZT environment that used to register momo account with qq account
require("TSLib")
local ts = require("ts")


--=============== general lib =====================

--URI code func
function encodeURI(s)
    local s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

--new record
function newRecord()
    local url = "nzt://cmd/newrecord"
    openURL(url)
end

--active one required record
function chooseArecord(recordid)
    local recordId = encodeURI(recordid)
    local url = string.format("nzt://cmd/activerecord?%s",recordId)
    openURL(url)
end

--rename current record
function renameCurrentRecord(recordid)
	local recordId = encodeURI(recordid)
    local url = string.format("nzt://cmd/renamecurrentrecord?%s",recordId)
    openURL(url)
end

--func: get current record name
function getCurrentRecordName()
    -- body
    openURL("nzt://cmd/getcurrentrecordname")
end

--func; get next record
function getNextRecord()
    -- body
    openURL("nzt://cmd/nextrecord")
end

--open NZT
function openNZT()
    local NZT = "NZT"
    runApp(NZT)
    mSleep(3000)
end
--close NZT
function closeNZT()
    local NZT = "NZT"
    closeApp(NZT)
    mSleep(1000)
end

--check if a str inside a table
function inside(table,str)
    if (table == nil)
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

--get current phone_type
function getCurrentPhoneType()
    -- body
    currentPhoneType = ocrText(318,206,516,272,20)
    return currentPhoneType
end

--get current osVersion
function getCurrentOsVersion()
    -- body
    currentOsVersion = ocrText(136,216,276,266,20)
    return currentOsVersion
end

--init Btns
function initNZTBtns() --check if 2 btns is locked or not,if locked then unlock them
    local x1,y1,c1 = 549,233,0x000000
    local x2,y2,c2 = 230,551,0xcccccc
	while(not(isColor(552,235,0x000000) and isColor(229,550,0xcccccc))) do
		if (not(isColor(x1,y1,c1)))
		then
			tap(x1,y1)
			mSleep(1000)
			tap(310,663) --tap noteBtn
			mSleep(1000)
		end

		if (not(isColor(x2,y2,c2)))
		then
			tap(x2,y2)
			mSleep(1000)
			tap(310,663) --tap noteBtn
			mSleep(1000)
		end
	end
end

-- keepRecord
function keepRecord() --lock phone type && keep record
    local x1,y1,c1 = 549,233,0x000000
    local x2,y2,c2 = 230,551,0xcccccc

    if (isColor(x1,y1,c1))
    then
        tap(x1,y1)
        mSleep(1000)
        tap(310,663) --tap noteBtn
        mSleep(1000)
    end

    if (isColor(x2,y2,c2))
    then
        tap(x2,y2)
        mSleep(1000)
        tap(310,663) --tap noteBtn
        mSleep(1000)
    end
end


function goThroughEnv()

    local repo = {}
	local i = 0
    closeNZT()
    openNZT()
    --clearAllRecords() --clear all records
    initNZTBtns()
    newRecord()
    mSleep(1000)
    while (i < 1000) do
        if(inside(repo,getCurrentPhoneType() .. "-" .. getCurrentOsVersion())) then
          newRecord()
          mSleep(1000)
        else
    			if(string.find(currentPhoneType,"iPhone 5") or string.find(currentPhoneType,"iPhone SE") or string.find(currentPhoneType,"iPhone 4"))
          then
            newRecord()
    				mSleep(1000)
    			else
            toast("newType",1)
    				table.insert(repo,currentPhoneType .. "-" .. currentOsVersion)
			    end
        end
		i = i + 1
    end
	writeFile(userPath() .. "/res/allEnv.txt",repo,"w")
	dialog("THE END!")
end




--============= script part =========================
goThroughEnv()
