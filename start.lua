GithubUser = "AEKANTEAM"
redis=dofile("./File/redis.lua").connect("127.0.0.1", 6379)
serpent=dofile("./File/serpent.lua")
JSON=dofile("./File/dkjson.lua")
json=dofile("./File/JSON.lua")
http= require("socket.http")
URL=dofile("./File/url.lua")
https= require("ssl.https")
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
User = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
local AutoFiles_Write = function() 
local Create_Info = function(Token,Sudo)  
local Write_Info_Sudo = io.open("sudo.lua", 'w')
Write_Info_Sudo:write([[

s = "AEKANTEAM"

q = "AEKAN"

token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
Write_Info_Sudo:close()
end  
if not redis:get(Server_Done.."Token_Write") then
print('\n\27[1;41m ارسل توكن البوت الان : \n\27[0;39;49m')
local token = io.read()
if token ~= '' then
if res == 200 then
tr = json:decode(data)
if tr.Info.info == 'Is_Spam' then
io.write('\n\27[1;31m'..tr.Info.info..'\n\27[0;39;49m')
os.execute('lua start.lua')
end ---ifBn
if tr.Info.info == 'Ok' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;35m عذرا التوكن خطأ  : \n\27[0;39;49m')
else
io.write('\n\27[1;45m تم حفظ التوكن : \n\27[0;39;49m') 
redis:set(Server_Done.."Token_Write",token)
end ---ifok
end ---ifok
else
io.write('\n\27[1;31m لم يتم حفظ التوكن حاول وقت اخر : \n\27[0;39;49m')
end  ---ifid
os.execute('lua start.lua')
end ---ifnot
end
if not redis:get(Server_Done.."UserSudo_Write") then
print('\n\27[1;41m ارسل ايدي مطور البوت الان : \n\27[0;39;49m')
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
if res == 200 then
aekan = json:decode(data)
if aekan.Info.info == 'Is_Spam' then
io.write('\n\27[1;35m عذرا الايدي محظور من السورس \n\27[0;39;49m') 
os.execute('lua start.lua')
end ---ifBn
if aekan.Info.info == 'Ok' then
io.write('\n\27[1;39m تم حفظ الايدي بنجاح \n\27[0;39;49m') 
redis:set(Server_Done.."UserSudo_Write",Id)
end ---ifok
else
io.write('\n\27[1;31m تم حفظ الايدي يوجد خطأ : \n\27[0;39;49m')
end  ---ifid
os.execute('lua start.lua')
end ---ifnot
end
local function Files_Info_Get()
Create_Info(redis:get(Server_Done.."Token_Write"),redis:get(Server_Done.."UserSudo_Write"))   
local t = json:decode
local RunBot = io.open("Run", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/AEKAN
token="]]..redis:get(Server_Done.."Token_Write")..[["
rm -fr AEKAN.lua
wget "https://raw.githubusercontent.com/AEKANTEAM/AEKAN/AEKAN.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./AEKAN.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("AK", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/AEKAN
while(true) do
rm -fr ../.telegram-cli
screen -S AEKAN -X kill
screen -S AEKAN ./Run
done
]])
RunTs:close()
end
Files_Info_Get()
redis:del(Server_Done.."Token_Write");redis:del(Server_Done.."UserSudo_Write")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
redis:del(Server_Done.."Token_Write");redis:del(Server_Done.."UserSudo_Write")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()