redis=dofile("./File/redis.lua").connect("127.0.0.1", 6379)
serpent=dofile("./File/serpent.lua")
JSON=dofile("./File/dkjson.lua")
json=dofile("./File/JSON.lua")
http= require("socket.http")
URL=dofile("./File/url.lua")
https= require("ssl.https")
Server_AEKAN = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_AEKAN = function() 
local Create_Info = function(Token,Sudo,UserName)  
local AEKAN_Info_Sudo = io.open("sudo.lua", 'w')
AEKAN_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
AEKAN_Info_Sudo:close()
end  
if not redis:get(Server_AEKAN.."Token_AEKAN") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
redis:set(Server_AEKAN.."Token_AEKAN",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not redis:get(Server_AEKAN.."UserName_AEKAN") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
redis:set(Server_AEKAN.."UserName_AEKAN",Json.Info.Username)
redis:set(Server_AEKAN.."Id_AEKAN",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_AEKAN_Info()
Create_Info(redis:get(Server_AEKAN.."Token_AEKAN"),redis:get(Server_AEKAN.."Id_AEKAN"),redis:get(Server_AEKAN.."UserName_AEKAN"))   
local RunAEKAN = io.open("AEKAN", 'w')
RunAEKAN:write([[
#!/usr/bin/env bash
cd $HOME/AEKAN
token="]]..redis:get(Server_AEKAN.."Token_AEKAN")..[["
rm -fr AEKAN.lua
wget "https://raw.githubusercontent.com/AEKANTEAM/AEKAN/master/AEKAN.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./AEKAN.lua -p PROFILE --bot=$token
done
]])
RunAEKAN:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/AEKAN
while(true) do
rm -fr ../.telegram-cli
screen -S AEKAN -X kill
screen -S AEKAN ./AK
done
]])
RunTs:close()
end
Files_AEKAN_Info()
redis:del(Server_AEKAN.."Token_AEKAN");redis:del(Server_AEKAN.."Id_AEKAN");redis:del(Server_AEKAN.."UserName_AEKAN")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_AEKAN()  
var = true
else   
f:close()  
redis:del(Server_AEKAN.."Token_AEKAN");redis:del(Server_AEKAN.."Id_AEKAN");redis:del(Server_AEKAN.."UserName_AEKAN")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
