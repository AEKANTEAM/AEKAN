database = dofile("./File/redis.lua").connect("127.0.0.1", 6379)
serpent = dofile("./File/serpent.lua")
JSON    = dofile("./File/dkjson.lua")
json    = dofile("./File/JSON.lua")
URL     = dofile("./File/url.lua")
http    = require("socket.http")
https   = require("ssl.https")
User = io.popen("whoami"):read('*a')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a')
name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a')
port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a')
Rtime = io.popen("date +'%Y-%m-%d %T'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(port..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(port..":token",token)
end 
else
print('\27[0;35m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua AEKAN.lua')
end
if not database:get(port..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(port..":SUDO:ID",SUDOID)
else
print('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
os.execute('lua AEKAN.lua')
end
if not database:get(port..":SUDO:USERNAME") then
io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(port..":SUDO:USERNAME",'@'..SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua AEKAN.lua')
end
local create_config_auto = function()
config = {
token = database:get(port..":token"),
SUDO = database:get(port..":SUDO:ID"),
UserName = database:get(port..":SUDO:USERNAME"),
 }
create(config, "./Info.lua")   
end 
create_config_auto()
token = database:get(port..":token")
SUDO = database:get(port..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("AEKAN", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/AEKAN
token="]]..database:get(port..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "TG IS NOT FIND IN FILES BOT"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
if [ ! $token ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE INFO.LUA \e[0m"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./AEKAN.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("AK", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/AEKAN
while(true) do
rm -fr ../.telegram-cli
screen -S AEKAN -X kill
screen -S AEKAN ./AEKAN
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(port..":token")
database:del(port..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[
┏━━━┓┏━━━┓┏┓┏━┓┏━━━┓┏━┓━┏┓
┃┏━┓┃┃┏━━┛┃┃┃┏┛┃┏━┓┃┃┃┗┓┃┃
┃┃━┃┃┃┗━━┓┃┗┛┛━┃┃━┃┃┃┏┓┗┛┃
┃┗━┛┃┃┏━━┛┃┏┓┃━┃┗━┛┃┃┃┗┓┃┃
┃┏━┓┃┃┗━━┓┃┃┃┗┓┃┏━┓┃┃┃━┃┃┃
┗┛━┗┛┗━━━┛┗┛┗━┛┗┛━┗┛┗┛━┗━┛

> CH › @SoalfLove
> CH › @A7KAN
~> DEVELOPER › @A3KON
~> DEVELOPER › @Rt_yt
]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,152221858,911105354}
function SudoBot(msg)  
local AEKAN = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
AEKAN = true  
end  
end  
return AEKAN  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or Bot(msg) then   
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or BasicConstructor(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or BasicConstructor(msg) or Constructor(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Bot(msg) then    
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or Bot(msg) then    
return true 
else 
return false 
end 
end
function Bnt(msg)
local hash = database:sismember(bot_id..'Bnt:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or Special(msg) or Bot(msg) then    
return true 
else 
return false 
end 
end
function Mempaam(msg)
local hash = database:sismember(bot_id..'Mempaam:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or CoSu(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or Special(msg) or Bnt(msg) or Bot(msg) then    
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(152221858) then  
var = true 
elseif tonumber(user_id) == tonumber(911105354) then  
var = true  
elseif tonumber(user_id) == tonumber(SUDO) then
var = true 
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true 
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true 
elseif database:sismember(bot_id..'Bnt:User'..chat_id, user_id) then  
var = true
elseif database:sismember(bot_id..'Mempaam:User'..chat_id, user_id) then  
var = true 
else  
var = false  
end  
return var
end 

function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(152221858) then  
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(911105354) then
var = 'مجنونة ايكو'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'المالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ الأساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير'
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'
elseif database:sismember(bot_id..'Bnt:User'..chat_id, user_id) then  
var = database:get(bot_id.."Bnt:Rd"..msg.chat_id_) or 'بنت الكروب'
elseif database:sismember(bot_id..'Mempaam:User'..chat_id, user_id) then  
var = database:get(bot_id.."Mempaam:Rd"..msg.chat_id_) or 'العضو العام'
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function DeleteMessage_(chat,id,func)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},func or dl_cb,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inlin_key(chat_id,text,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function edit_inlin_key(chat_id,text,message_id,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..token.."/editMessageText?chat_id="..chat_id.."&text="..URL.escape(text)..'&message_id='..message_id.."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function send_inline_Media(chat_id,iny,x,cx,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..token.."/"..iny.."?chat_id="..chat_id.."&"..x.."="..cx.."&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
send_api = send_api.."&reply_to_message_id="..reply_id 
end 
return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "SoalfLove")
local NameUser = "♡∶ بواسطه ⤙ ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = "♡∶ اسم المستخدم ⤙ ["..data.first_name_.."](T.me/"..UserName..")"
if status == "lock" then
send(msg.chat_id_, msg.id_,NameUser.."\n"..text)
return false
end
if status == "lockktm" then
send(msg.chat_id_, msg.id_,NameUser.."\n"..text)
return false
end
if status == "lockkick" then
send(msg.chat_id_, msg.id_,NameUser.."\n"..text)
return false
end
if status == "lockkid" then
send(msg.chat_id_, msg.id_,NameUser.."\n"..text)
return false
end
if status == "unlock" then
send(msg.chat_id_, msg.id_,NameUser.."\n"..text)
return false
end
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
if status == "reply_Add" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"♡∶  الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end -- end
function Total_Msg(msgs)  
local AEKAN_Msg = ''  
if msgs < 100 then 
AEKAN_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
AEKAN_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
AEKAN_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
AEKAN_Msg = 'متفاعل' 
elseif msgs < 1200 then 
AEKAN_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
AEKAN_Msg = 'متفاعل جداً' 
elseif msgs < 3500 then 
AEKAN_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
AEKAN_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
AEKAN_Msg = 'قمة التفاعل' 
elseif msgs < 5500 then 
AEKAN_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
AEKAN_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
AEKAN_Msg = 'امبروطور التفاعل' 
elseif msgs < 10000000000 then 
AEKAN_Msg = 'رب التفاعل' 
elseif msgs < 100000000000000 then
AEKAN_Msg = 'رب ملوك التفاعل'
end 
return AEKAN_Msg 
end
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n♡∶ مالك المجموعه')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n♡∶ عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n♡∶ الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔'
else
info = '✘'
end
if Json_Info.result.can_delete_messages == true then
delete = '✔'
else
delete = '✘'
end
if Json_Info.result.can_invite_users == true then
invite = '✔'
else
invite = '✘'
end
if Json_Info.result.can_pin_messages == true then
pin = '✔'
else
pin = '✘'
end
if Json_Info.result.can_restrict_members == true then
restrict = '✔'
else
restrict = '✘'
end
if Json_Info.result.can_promote_members == true then
promote = '✔'
else
promote = '✘'
end
Send(chat,msg.id_,'\n- الرتبة : مشرف  '..'\n- والصلاحيات هي ↓ \nٴ━━━━━━━━━━'..'\n- تغير معلومات الكروب ↞ ❴ '..info..' ❵'..'\n- حذف الرسائل ↞ ❴ '..delete..' ❵'..'\n- حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'AEKAN Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"AEKAN":"'..NAME..'",'
else
t = t..',"'..v..'":{"AEKAN":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '📋| عدد مجموعات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,aek,aaek)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..aek)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,aaek) 
sendAudio(msg.chat_id_,msg.id_,'./'..aaek,"@SoalfLove")  
os.execute('rm -rf ./'..aaek) 
end
function Addsticker(msg,chat,Sd,akk)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,akk) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..akk)
os.execute('rm -rf ./'..akk) 
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"♡∶ ملف نسخه ليس لهاذا البوت")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_,"♡∶ جاري ...\n♡∶ رفع الملف الان")
else
send(chat,msg.id_,"*♡∶ عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")   
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"Lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","Lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n♡∶تم رفع الملف بنجاح وتفعيل المجموعات\n♡∶ ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")   
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n♡∶ العضــو ⤙ '..Name..'\n♡∶ قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n♡∶ العضــو ⤙ '..Name..'\n♡∶ قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n♡∶ العضــو ⤙ '..Name..'\n♡∶ قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_mjnonh(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.mjnonh and msg then
pre_msg = plugin.mjnonh(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end

--------------------------------------------------------------------------------------------------------------
function SourceAEKAN(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_, msg.id_,"♡∶تم الغاء الاذاعه") 
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_,"♡∶تمت الاذاعه الى *~ "..#list.." ~* مجموعه ")     
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if SudoBot(msg) then
local bl = '♡∶ اهلا عزيزي آلمـطـور\n♡∶ آنت آلمـطـور آلآسـآسـي للبوت\n•━━━━━━━━━━━━━•ء\n♡∶ تسـتطـيع‌‏ آلتحگم باوامر البوت\n♡∶ من خلاال الكيبورت خاص بك\n♡∶ قناة سورس البوت [اضغط هنا](t.me/SoalfLove)'
local keyboard = {
{'الاحصائيات 𖡬'},
{'تعطيل التواصل ×','تفعيل التواصل ✆'},
{'ضع اسم للبوت ®','المطورين ☬','قائمه العام ⚕'},
{'المشتركين 𖡮','المجموعات ❡'},
{'ضع كليشه ستارت 𖡲','حذف كليشه ستارت 𖡲'},
{'اذاعه ♃','اذاعه خاص ₪'},
{'اذاعه بالتثبيت ⚚'},
{'تغير رساله الاشتراك','حذف رساله الاشتراك ⊝','تغير الاشتراك'},
{'اذاعه بالتوجيه ж','اذاعه بالتوجيه خاص ₪'},
{'تفعيل الاشتراك الاجباري ☭','تعطيل الاشتراك الاجباري ☭'},
{'الاشتراك الاجباري ♆','وضع قناة الاشتراك 𖤫'},
{'تفعيل البوت المجاني 𖤴','تعطيل البوت المجاني 𖤩'},
{'تنظيف الكروبات ⊝','تنظيف المشتركين ⊝'},
{'جلب نسخه الاحتياطيه ⧪'},
{'تحديث السورس 𖤂','الاصدار ☫'},
{'معلومات السيرفر ⌘'},
{'الغاء ✖'}
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
SourceAEKANr = start
else
SourceAEKANr = '*♡∶ اهلاً عزيزي*\n*♡∶ انا بوت اسمي* '..Namebot..'\n*♡∶ اختصاصي حماية المجموعات*\n*♡∶ من تكرار والسبام والتوجيه والخ…*\n*♡∶ لتفعيلي اتبع الخطوات…↓*\n*♡∶ اضفني الى مجموعتك وقم بترقيتي مشرف واكتب كلمة {تفعيل}*  \n*♡∶ يستطيع ⤙ {المنشئ او المشرفين} بتفعيل فقط*\n\n[♡∶ المطور](t.me/A3KON)\n[♡∶ قناة سورس البوت](t.me/SoalfLove)'
end 
send(msg.chat_id_, msg.id_, SourceAEKANr) 
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not SudoBot(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,'♡∶ تم ارسال رسالتك\n♡∶ سيتم رد في اقرب وقت')
tdcli_function ({ID = "ForwardMessages", chat_id_ = 911105354,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '♡∶ تم ارسال الملصق من ↓\n - '..Name
sendText(911105354,Text,0,'md')
end 
end,nil) 
end,nil)
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '♡∶ تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if SudoBot(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '*♡∶ المستخدم ⤙ *'..Name..'\n*♡∶ تم حظره من التواصل* '
sendText(911105354,Text,msg.id_/2097152/0.5,'md')
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '*♡∶ المستخدم ⤙ *'..Name..'\n*♡∶ تم الغاء حظره من التواصل* '
sendText(911105354,Text,msg.id_/2097152/0.5,'md')
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local AEKAN_Msg = '\n*♡∶ قام الشخص بحظر البوت*'
send(msg.chat_id_, msg.id_,AEKAN_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '*♡∶ المستخدم ⤙ *'..Name..'\n*♡∶ تم ارسال الرساله اليه*'
sendText(911105354,Text,msg.id_/2097152/0.5,'md')
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '*♡∶ المستخدم ⤙ *'..Name..'\n*♡∶ تم ارسال الرساله اليه*'
sendText(911105354,Text,msg.id_/2097152/0.5,'md')
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '*♡∶ المستخدم ⤙ *'..Name..'\n*♡∶ تم ارسال الرساله اليه*'
sendText(911105354,Text,msg.id_/2097152/0.5,'md')
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '*♡∶ المستخدم ⤙ *'..Name..'\n*♡∶ تم ارسال الرساله اليه*'
sendText(911105354,Text,msg.id_/2097152/0.5,'md')
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '*♡∶ المستخدم ⤙ *'..Name..'\n*♡∶ تم ارسال الرساله اليه*'
sendText(911105354,Text,msg.id_/2097152/0.5,'md')
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == 'تفعيل التواصل ✆' and SudoBot(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n*♡∶ تم تفعيل التواصل* ' 
else
Text = '\n*♡∶ تم تفعيل التواصل مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل ×' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n*♡∶ تم تعطيل التواصل*' 
else
Text = '\n*♡∶ تم تعطيل التواصل مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت المجاني 𖤴' and SudoBot(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n*♡∶ تم تفعيل البوت المجاني* ' 
else
Text = '\n*♡∶ تم تفعيل البوت المجاني مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت المجاني 𖤩' and SudoBot(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n*♡∶ تم تعطيل البوت المجاني*' 
else
Text = '\n*♡∶ تم تعطيل البوت المجاني مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,'♡∶ الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,'♡∶ تم حفظ كليشه ستارت') 
database:del(bot_id..'Start:Bots') 
return false
end
if text == 'ضع كليشه ستارت 𖡲' and SudoBot(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,'♡∶ ارسل لي الكليشه الان') 
return false
end
if text == 'حذف كليشه ستارت 𖡲' and SudoBot(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,'♡∶تم حذف كليشه ستارت') 
end

if text == 'معلومات السيرفر ⌘' and SudoBot(msg) then 
local aeko = 'معلومات الاشتراك : \n'
  local Aeko = database:info()
  aeko = aeko..'♡∶ *أيام التشغيل* : `'..Aeko.server.uptime_in_days..'يــوم`\n'
  aeko = aeko..'♡∶ *معالجة الأوامر* : `'..Aeko.stats.total_commands_processed..'`\n'
  aeko = aeko..'♡∶ *مفاتيح منتهية الصلاحية* : `'..Aeko.stats.expired_keys..'`\n'
  aeko = aeko..'♡∶ *عدد الثواني* : `'..Aeko.server.uptime_in_seconds..'ثانيه`\n'
send(msg.chat_id_, msg.id_, aeko)  
end

if text == 'تحديث السورس 𖤂' and SudoBot(msg) then 
os.execute('rm -rf AEKAN.lua')
os.execute('wget https://raw.githubusercontent.com/AEKANTEAM/AEKAN/master/AEKAN.lua')
dofile('AEKAN.lua') 
io.popen("rm -rf ~/.telegram-cli/data/audio/*")
io.popen("rm -rf ~/.telegram-cli/data/document/*")
io.popen("rm -rf ~/.telegram-cli/data/photo/*")
io.popen("rm -rf ~/.telegram-cli/data/sticker/*")
io.popen("rm -rf ~/.telegram-cli/data/temp/*")
io.popen("rm -rf ~/.telegram-cli/data/thumb/*") 
io.popen("rm -rf ~/.telegram-cli/data/video/*")
io.popen("rm -rf ~/.telegram-cli/data/voice/*")
io.popen("rm -rf ~/.telegram-cli/data/profile_photo/*") 
print("\27[31;47m\n          ( تم تحديث السورس )          \n\27[0;34;49m\n")
send(msg.chat_id_, msg.id_,'♡∶ تم تحديث السورس \n♡∶ تم تنزيل اخر اصدار سورس ايكان\n♡∶ الاصدار ← { 1.7v}')
end
if text == 'الاصدار ☫' and SudoBot(msg) then 
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,'♡∶ اصدار سورس ايكان \n♡∶ الاصدار ←{ 1.7v}') 
end
if text == "ضع اسم للبوت ®" and SudoBot(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي الاسم الآن* ")  
return false
end
if text == 'الاحصائيات 𖡬' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '*♡∶ اسم البوت ⤙* '..Namebot..'\n'..'*♡∶ عدد المجموعات ⤙* {'..Groups..'}'..'\n*♡∶ عدد المشتركين ⤙* {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'المشتركين 𖡮' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n♡∶ المشتركين←{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'المجموعات ❡' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n♡∶ المجموعات←{`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين ☬") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
de = "\n*♡∶ قائمة مطورين البوت* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
de = de..""..k.."- ([@"..username.."])\n"
else
de = de..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
de = "*♡∶ لا يوجد مطورين*"
end
send(msg.chat_id_, msg.id_, de)
end
if text == ("قائمه العام ⚕") and SudoBot(msg) then
local list = database:smembers(bot_id..'GBan:User')
Gban = "\n*♡∶ قائمة المحظورين عام في البوت* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
Gban = Gban..""..k.."- ([@"..username.."])\n"
else
Gban = Gban..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
Gban = "*♡∶ لا يوجد محظورين عام*"
end
send(msg.chat_id_, msg.id_, Gban)
return false
end
if text == ("قائمه الكتم العام ⚉") and SudoBot(msg) then
local list = database:smembers(bot_id..'Gmute:User')
Gmute = "\n♡∶ قائمة المكتومين عام في البوت \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
Gmute = Gmute..""..k.."- ([@"..username.."])\n"
else
Gmute = Gmute..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
Gmute = "*♡∶ لا يوجد مكتومين عام*"
end
send(msg.chat_id_, msg.id_, Gmute)
return false
end
if text=="اذاعه خاص ₪" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي سواء ⤙ { ملصق, متحركه, صوره, رساله }*\n*♡∶ للخروج ارسل الغاء* ") 
return false
end 
if text=="اذاعه ♃" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي سواء ⤙ { ملصق, متحركه, صوره, رساله }*\n*♡∶ للخروج ارسل الغاء* ") 
return false
end  
if text=="اذاعه بالتثبيت ⚚" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي سواء ⤙ { ملصق, متحركه, صوره, رساله }*\n*♡∶ للخروج ارسل الغاء* ") 
return false
end 
if text=="اذاعه بالتوجيه ж" and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي التوجيه الان*") 
return false
end 
if text=="اذاعه بالتوجيه خاص ₪" and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي التوجيه الان*") 
return false
end 
if text == 'جلب نسخه الاحتياطيه ⧪' and SudoBot(msg) then 
GetFile_Bot(msg)
end
if text == "تنظيف المشتركين ⊝" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'*♡∶ لا يوجد مشتركين وهميين في البوت* \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*♡∶ عدد المشتركين الان ⤙* ( '..#pv..' )\n*♡∶ تم ازالة ⤙* ( '..sendok..' ) من المشتركين\n*♡∶ عدد المشتركين الحقيقي الآن ⤙* ( '..ok..' ) *مشترك* \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات ⊝" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'*♡∶ لا يوجد مجموعات وهميه في البوت*\n')   
else
local AEKAN = (w + q)
local sendok = #group - AEKAN
if q == 0 then
AEKAN = ''
else
AEKAN = '\n*♡∶ تم ازالة ⤙* { '..q..' } *مجموعات من البوت*'
end
if w == 0 then
AEKANk = ''
else
AEKANk = '\n*♡∶ تم ازالة ⤙* {'..w..'} *مجموعه لان البوت عضو*'
end
send(msg.chat_id_, msg.id_,'*♡∶ عدد المجموعات الان ⤙* { '..#group..' }'..AEKANk..''..AEKAN..'\n*♡∶ الان عدد المجموعات الحقيقي ⤙ { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end
if text and text:match("^رفع مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته مطور في البوت*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المطورين*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙* '..userid..''
status  = '\n*♡∶ تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if text and not Special(msg) then  
local AEKAN1_Msg = database:get(bot_id.."AEKAN1:Add:Filter:Rp2"..text..msg.chat_id_)   
if AEKAN1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*♡∶ العضو ⤙* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SoalfLove')..') \n ♡∶'..AEKAN1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء حفظ اسم البوت*") 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, "*♡∶ تم حفظ اسم البوت*")  
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء الاذاعه للخاص*") 
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"*♡∶ تمت الاذاعه الى ⤙* {"..#list.."} *مشترك في البوت*  ")     
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء الاذاعه*") 
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"*♡∶ تمت الاذاعه الى ⤙* {"..#list.."} مجموعه في البوت ")     
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء الاذاعه*") 
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"*♡∶ تمت الاذاعه الى ⤙* {"..#list.."} مجموعات في البوت ")     
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء الاذاعه*") 
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"*♡∶ تمت الاذاعه الى ⤙* {"..#list.."} *مشترك في البوت*  ")     
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "*♡∶ تم الغاء الامر*  ") 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '*♡∶ المعرف لا يوجد فيه قناة* ')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '*♡∶ عذراً لا يمكنك وضع معرف حسابات في الاشتراك*  ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'*♡∶ عذراً لا يمكنك وضع معرف كروب في الاشتراك*  ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'*♡∶ البوت مشرف في القناة*  \n*♡∶ تم تفعيل الاشتراك الاجباري في*  \n*♡∶ ايدي القناة*  ('..data.id_..')\n*♡∶ معرف القناة*  ([@'..data.type_.channel_.username_..'])') 
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'♡∶ البوت ليس مشرف في القناة يرجى ترقيته مشرف ثم اعادة المحاوله ') 
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "*♡∶ تم الغاء الامر*  ") 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,'*♡∶ تم تغيير رسالة الاشتراك بنجاح*  ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت حبي \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'SoalfLove')) 
send(msg.chat_id_, msg.id_,'['..t..']')
end,nil) 
end 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,'*♡∶ عذراً البوت ليس مشرف يرجى ترقيتي والمحاوله لاحقاً* ') 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية تغيير معلومات المجموعه يرجى تفعيلها*') 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,'*♡∶ تم تغيير صورة المجموعه*') 
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء وضع الوصف*") 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,'*♡∶ تم تغيير وصف الكروب*')   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء حفظ الترحيب*") 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,'*♡∶ تم حفظ ترحيب الكروب*')   
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_,"*♡∶ تم الغاء حفظ الرابط*")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/%S+)") then     
local Link = text:match("(https://telegram.me/%S+)") or text and text:match("(https://t.me/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"*♡∶ تم حفظ الرابط بنجاح*")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if AEKAN_Msg and not Special(msg) then  
local AEKAN_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if AEKAN_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"*♡∶ العضو ⤙* : {["..data.first_name_.."](T.ME/"..data.username_..")}\n♡∶["..AEKAN_Msg.."] \n") 
else
send(msg.chat_id_,0,"*♡∶ العضو ⤙* : {["..data.first_name_.."](T.ME/SoalfLove)}\n♡∶["..AEKAN_Msg.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Mempaam(msg) then 
list_fshar = {"كس","عير","خرا","خرب الله","كحاب","كحوبه","مشتهيه","نيج","كواده","طيز","مناويج","كحبه","فرخ","فروخ","كوسي","بلاع","سالب","موجب","عاهره","بعص","نجتهم","ناجني","ناجونه","خصاوي","ناجوك","عار","ديس","ديوث"}
for k,v in pairs(list_fshar) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
elseif text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) == 'warn' and not Mempaam(msg) then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع التكلم بالفشار هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع التكلم بالفشار هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Iran'..msg.chat_id_) and not Mempaam(msg) then 
list_iran = {"خسته","خسته","ازراه","تو بهتر","اره عزیزم","برم","راحتی","بیام","دوستان","شادی","زیباترین","میخام","خوبم","تو فق","زیباتون","دوستان","خوشکلم","ای","ازش","جانمونی","ریتم","نیاری","ملایم","داداش","بیا","باشم","میخوای","تندتر","ریتمو","زیرت","بکشی","کنی","اومدم","شه","خوب","هست","کسی","دستم","صبجتون","کیر","ذخیرس","شماره","استیکر","زدن","دخترا","زدن","تخماتو","بمالونم","بزنم","بهش","اقا","جذابیتت","خیلی","بالااااس","بهداشتی","مخوام","میخوام","اهلیم","حوصلم","بی","یه","کی","بریم","دوست","شمارتو","خوبی","شبتون","صکصی","رفقا","یکی","بیاد","یوی","یکم","چ","غوغای","قهرمان‌","هاشون‌","هَوَلای‌مآن","ۀ","ژ","ڲ","ڳ","ڴ","ڱ","ڰ","ڮ","ڭ","ڬ","ک","ڪ","ګ","ۋ","ۊ","ٷ","ۅ","ۄ","ۈ","ۆ","پ","ڐ","ډ","ڍ","ڏ","ۮ","ڌ","ڋ","ڈ","ۯ","ڙ","ڗ","ڑ","ږ","ڟ","ڻ","ڽ","ڹ","ں","ٿ","ٽ","ٺ","ٵ","ڸ","ڷ","ڵ","ڀ","ٮ","ۑ","ۍ","ێ","ې","ٸ","ځ","ڿ","څ","ښ","ڛ","ۺ","ښ","ڜ","۶","۵","۴"}
for k,v in pairs(list_iran) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
elseif text and database:get(bot_id..'lock:Iran'..msg.chat_id_) == 'warn' and not Mempaam(msg) then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع التكلم بالفارسيه هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع التكلم بالفارسيه هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Eng'..msg.chat_id_) and not Mempaam(msg) then 
list_eng = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list_eng) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif text and database:get(bot_id..'lock:Eng'..msg.chat_id_) == 'warn' and not Mempaam(msg) then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع التكلم بالانكليزيه هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع التكلم بالانكليزيه هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'Lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "warn" and not Special(msg) then   
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال المعرفات هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال المعرفات هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "warn" and not Special(msg) then   
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال المعرفات هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال المعرفات هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Mempaam(msg) then   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Mempaam(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Mempaam(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Mempaam(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "warn" and not Mempaam(msg) then   
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الهاشتاك هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الهاشتاك هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Mempaam(msg) then   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Mempaam(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Mempaam(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Mempaam(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "warn" and not Mempaam(msg) then   
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الهاشتاك هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الهاشتاك هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "warn" and not Special(msg) then   
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الشارحه هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الشارحه هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "warn" and not Special(msg) then   
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الشارحه هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الشارحه هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."Lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "warn" and not Special(msg) then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الروابط هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الروابط هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."Lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."Lock:Link"..msg.chat_id_) == "warn" and not Special(msg) then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الروابط هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الروابط هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الصور هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الصور هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الفيديو هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الفيديو هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال المتحركات هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال المتحركات هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع الالعاب هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع الالعاب هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الأغاني هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الأغاني هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الصوت هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الصوت هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الكيبورد هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الكيبورد هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الملصقات هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الملصقات هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الهمسات هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الهمسات هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع إعادة التوجيه هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع إعادة التوجيه هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الملفات هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الملفات هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال السيلفي هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال السيلفي هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "warn" then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الجهات هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الجهات هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "warn" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ ممنوع أرسال الكلايش هنا*\n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ ممنوع أرسال الكلايش هنا*\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ الملصق الذي ارسلته تم منعه* \n" ) 
else
send(msg.chat_id_,0, "*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ الملصق الذي ارسلته تم منعه* \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ الصوره التي ارسلتها تم منعها* \n" ) 
else
send(msg.chat_id_,0,"*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ الصوره التي ارسلتها تم منعها* \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"*♡∶ عذرا يا ⤙* {[@"..data.username_.."]}\n*♡∶ المتحركه التي ارسلتها تم منعها* \n") 
else
send(msg.chat_id_,0,"*♡∶ عذرا يا ⤙* {["..data.first_name_.."](T.ME/SoalfLove)}\n*♡∶ المتحركه التي ارسلتها تم منعها* \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if (text == 'تفعيل' or text == 'تفعيل الكروب') and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*♡∶ لا تستطيع استخدام البوت* \n *♡∶ يرجى الاشتراك بالقناة اولاً* \n *♡∶ اشترك هنا* ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ عذراً يرجى ترقيه البوت مشرف !*')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ اهلاً عزيزي*\n*♡∶ لا يمكنك تفعيل البوت*\n*♡∶ يرجى مراسلة مطوريني للاشتراك والتفعيل*\n*♡∶ بأسعار رمزيه شهري-سنوي*\n*ٴ⤙Ⓐ⓷ⓀⓄⓃ ♡ ⓇⓉ⊝ⓎⓉ⤙ٴ*\n\n {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'}')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تفعيل الكروب مسبقاً*')
else
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"*♡∶ حساب المالك محذوف*")
return false  
end
local UserName = (b.username_ or "SoalfLove") 
database:sadd(bot_id..'CoSu'..msg.chat_id_, owner_id)
end,nil)   
end
end
end,nil)
sendText(msg.chat_id_,'\n*♡∶ بواسطة ⤙* ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n*♡∶ تم تفعيل الكروب* {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"*♡∶ لا يوجد ادمنيه ليتم رفعهم فى البوت*") 
else
send(msg.chat_id_, msg.id_,"*♡∶ تمت ترقية* { "..num2.." } *من الادمنيه في البوت*") 
end
end,nil) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = '*لا يوجد*'
end
Text = '♡∶ تم تفعيل كروب جديد\n'..
'\n♡∶ بواسطة {'..Name..'}'..
'\n♡∶ موقعه في الكروب {'..AddPy..'}' ..
'\n♡∶ ايدي الكروب {'..IdChat..'}'..
'\n♡∶ عدد اعضاء الكروب *{'..NumMember..'}*'..
'\n♡∶ اسم الكروب {['..NameChat..']}'..
'\n♡∶ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
sendText(911105354,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*♡∶ لا تستطيع استخدام البوت* \n *♡∶ يرجى الاشتراك بالقناة اولاً* \n *♡∶ اشترك هنا* ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الكروب مسبقاً*')
else
sendText(msg.chat_id_,'\n*♡∶ بواسطة ⤙* ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n*♡∶ تم تعطيل الكروب* {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = '*لا يوجد*'
end
Text = '\nتم تعطيل الكروب ⁞ ♡'..
'\n♡∶ بواسطة {'..Name..'}'..
'\n♡∶ايدي الكروب {`'..IdChat..'`}'..
'\n♡∶اسم الكروب {['..NameChat..']}'..
'\n♡∶ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
sendText(911105354,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if (text == 'تفعيل' or text == 'تفعيل الكروب') and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'*♡∶ لا تستطيع استخدام البوت* \n *♡∶ يرجى الاشتراك بالقناة اولاً* \n *♡∶ اشترك هنا* ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ عذراً يرجى ترقيه البوت مشرف !*')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ اهلاً عزيزي*\n*♡∶ لا يمكنك تفعيل البوت*\n*♡∶ يرجى مراسلة مطوريني للاشتراك والتفعيل*\n*♡∶ بأسعار رمزيه شهري-سنوي*\n*ٴ⤙Ⓐ⓷ⓀⓄⓃ ♡ ⓇⓉ⊝ⓎⓉ⤙ٴ*\n\n {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'}')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تفعيل الكروب*')
else
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"*♡∶ حساب المالك محذوف*")
return false  
end
local UserName = (b.username_ or "SoalfLove") 
database:sadd(bot_id..'CoSu'..msg.chat_id_, owner_id)
end,nil)   
end
end
end,nil)
sendText(msg.chat_id_,'\n*♡∶ بواسطة ⤙* ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n*♡∶ تم تفعيل الكروب* {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"*♡∶ لا يوجد ادمنيه ليتم رفعهم فى البوت*") 
else
send(msg.chat_id_, msg.id_,"*♡∶ تمت ترقية* { "..num2.." } *من الادمنيه في البوت*") 
end
end,nil)   
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = '*لا يوجد*'
end
Text = '♡∶ تم تفعيل كروب جديد\n'..
'\n♡∶ بواسطة {'..Name..'}'..
'\n♡∶ موقعه في الكروب {'..AddPy..'}' ..
'\n♡∶ ايدي الكروب {'..IdChat..'}'..
'\n♡∶ عدد اعضاء الكروب *{'..NumMember..'}*'..
'\n♡∶ اسم الكروب {['..NameChat..']}'..
'\n♡∶ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
sendText(911105354,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end

if text and text:match("^ضع سعر الاشتراك (%d+)$") and SudoBot(msg) then
local Num = text:match("ضع سعر الاشتراك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,'*♡∶ تم تعيين اسعار الاشتراكات لتفعيل البوت* {'..Num..'}')
end
if text == 'تحديث السورس' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
os.execute('rm -rf AEKAN.lua')
os.execute('wget https://raw.githubusercontent.com/AEKANTEAM/AEKAN/master/AEKAN.lua')
dofile('AEKAN.lua') 
io.popen("rm -rf ~/.telegram-cli/data/audio/*")
io.popen("rm -rf ~/.telegram-cli/data/document/*")
io.popen("rm -rf ~/.telegram-cli/data/photo/*")
io.popen("rm -rf ~/.telegram-cli/data/sticker/*")
io.popen("rm -rf ~/.telegram-cli/data/temp/*")
io.popen("rm -rf ~/.telegram-cli/data/thumb/*") 
io.popen("rm -rf ~/.telegram-cli/data/video/*")
io.popen("rm -rf ~/.telegram-cli/data/voice/*")
io.popen("rm -rf ~/.telegram-cli/data/profile_photo/*") 
print("\27[31;47m\n          ( تم تحديث السورس )          \n\27[0;34;49m\n")
send(msg.chat_id_, msg.id_,'♡∶ تم تحديث السورس \n♡∶ تم تنزيل اخر اصدار سورس ايكان\n♡∶ الاصدار ← { 1.7v}')
end



if text and text:match("^تغير الاشتراك$") and SudoBot(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '*♡∶ حسنآ ارسل لي معرف القناة*') 
return false  
end
if text and text:match("^تغير رساله الاشتراك$") and SudoBot(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '*♡∶ حسنآ ارسل لي النص الذي تريده*') 
return false  
end
if text == "حذف رساله الاشتراك ⊝" and SudoBot(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "*♡∶ تم مسح رساله الاشتراك* ") 
return false  
end
if text and text:match("^وضع قناة الاشتراك 𖤫$") and SudoBot(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '*♡∶ حسنآ ارسل لي معرف القناة*') 
return false  
end
if text == "تفعيل الاشتراك الاجباري ☭" and SudoBot(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"♡∶ الاشتراك الاجباري مفعل \n♡∶ على القناة ⤙ ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_,"♡∶ اهلا عزيزي المطور \n♡∶ ارسل معرف قناتك ليتم تفعيل الاشتراك الاجباري")
end
return false  
end
if text == "تعطيل الاشتراك الاجباري ☭" and SudoBot(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "♡∶ تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "الاشتراك الاجباري ♆" and SudoBot(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "♡∶ تم تفعيل الاشتراك الاجباري \n♡∶ على القناة ⤙ ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "♡∶ لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end

if text == 'السورس' or text == 'سورس' or text == 'يا سورس' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يرجى الاشتراك بالقناه اولا \n  ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
♡∶ ⤙ أهلاً بك في سورس ايكان
 
⤙ ⤙  ⤙  ⤙ ♡ ⤙ ⤙ ⤙ ⤙
♡∶⤙AEKAN ♡ TEAM⤙
⤙ ⤙  ⤙  ⤙ ♡ ⤙ ⤙ ⤙ ⤙

♡∶ ⤙[قناة السورس](t.me/SoalfLove) 

♡∶ ⤙[مطور السورس](t.me/A3kon)

♡∶ ⤙[مطورة السورس](t.me/Rt_yt)

♡∶ ⤙[كليشة التنصيب](t.me/yt_hA) 

♡∶ ⤙[لــ تواصل](t.me/A3kon)

♡∶ ⤙[لــ تواصل](t.me/Rt_yt)

⤙Ⓐ⓷ⓀⓄⓃ ♡ ⓇⓉ⊝ⓎⓉ⤙
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع نسخه الاحتياطيه' and SudoBot(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب نسخه الاحتياطيه' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
Ncm = "*♡∶ قائمه الاوامر المضافه*  \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
Ncm = Ncm..""..k..">> ("..v..") ⤙ {"..Cmds.."}\n"
else
Ncm = Ncm..""..k..">> ("..v..") \n"
end
end
if #list == 0 then
Ncm = "*♡∶ لا يوجد اوامر مضافه*"
end
send(msg.chat_id_, msg.id_,'['..Ncm..']')
end
if text == 'حذف الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,'*♡∶ تم ازالة جميع الاوامر المضافه*')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الامر القديم*')  
return false
end
if text == 'حذف امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الامر الذي قمت بوضعه بدلاً عن القديم*')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الامر الجديد*')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'*♡∶ تم حفظ الامر*')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
function sendVoicebot(chat_id,reply_id,voice,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = "",
waveform_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
function sendAudiobot(chat_id,reply_id,audio,title,caption,performer,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = "",
title_ = title or "",
performer_ = performer or "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
function download(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {http.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return './'..file_path 
end
if text == 'تعطيل اليوتيوب' and Constructor(msg) then  
send(msg.chat_id_, msg.id_,'*♡∶ بواسطة ⤙* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SoalfLove')..') \n*♡∶ تم تعطيل اليوتيوب*')
database:set(bot_id.."dl_yt_dl"..msg.chat_id_,"close") 
return false  
end 
if text == 'تفعيل اليوتيوب' and Constructor(msg) then  
send(msg.chat_id_, msg.id_,'*♡∶ بواسطة ⤙* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SoalfLove')..') \n*♡∶ تم تفعيل اليوتيوب*')
database:set(bot_id.."dl_yt_dl"..msg.chat_id_,"open") 
return false  
end
if text and text:match('^بصمه (.*)$')  and database:get(bot_id.."dl_yt_dl"..msg.chat_id_) == "open" then            
local Ttext = text:match('^بصمه (.*)$') 
local InfoSearch = https.request('https://mode-dev.tk/tg/search.php?search='..URL.escape(Ttext))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch.results) do
if k == 1 then
local GetStart = io.popen('downloadsh '..vv.url):read('*all')
if GetStart and GetStart:match('(.*)oksend(.*)') then
print('download Mp3 done ...\nName : '..vv.title..'\nIdLink : '..vv.url)
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil,'./'..vv.url..'.mp3',vv.title,'- '..vv.title..'\n- @SoalfLove','@SoalfLove')  
os.execute('rm -rf ./'..vv.url..'.mp3') 
end
end
end
end
if text and text:match('^صوت (.*)$')  and database:get(bot_id.."dl_yt_dl"..msg.chat_id_) == "open" then            
local Ttext = text:match('^صوت (.*)$') 
local InfoSearch = https.request('https://mode-dev.tk/tg/search.php?search='..URL.escape(Ttext))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch.results) do
if k == 1 then
local GetStart = io.popen('downloadsh '..vv.url):read('*all')
if GetStart and GetStart:match('(.*)oksend(.*)') then
print('download Mp3 done ...\nName : '..vv.title..'\nIdLink : '..vv.url)
sendAudio(msg.chat_id_,msg.id_,'./'..vv.url..'.mp3',vv.title,'- '..vv.title..'\n- @SoalfLove','@SoalfLove')
os.execute('rm -rf ./'..vv.url..'.mp3') 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text == "قفل الدردشه" and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."Lock:text"..msg.chat_id_,true) 
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الدردشه")  
return false
end 
if text == "قفل الاضافه" and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."Lock:AddMempar"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل اضافة الاعضاء")  
return false
end 
if text == "قفل الدخول" and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."Lock:Join"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل دخول الاعضاء")  
return false
end 
if text == "قفل البوتات" and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."Lock:Bot:kick"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل البوتات")  
return false
end 
if text == "قفل البوتات بالطرد" and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."Lock:Bot:kick"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل البوتات")  
return false
end 
if text == "قفل الاشعارات" and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id.."Lock:tagservr"..msg.chat_id_,true)  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الاشعارات")  
return false
end 
if text == "قفل التثبيت" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id.."Lock:pin",msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  database:set(bot_id.."Pin:Id:Msg"..msg.chat_id_,data.pinned_message_id_)  end,nil)
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل التثبيت هنا")  
return false
end 
if text == "قفل التعديل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:set(bot_id.."Lock:edit"..msg.chat_id_,true) 
Reply_Status(msg,msg.sender_user_id_,"lock","♡∶ تم قفـل تعديل")  
return false
end 
if text == "قفل تعديل الميديا" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."Lock:edit"..msg.chat_id_,true) 
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل تعديل")  
return false
end 
if text == "قفل الكل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end  
database:set(bot_id.."Lock:tagservrbot"..msg.chat_id_,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..''..lock..msg.chat_id_,"del")    
end
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل جميع الاوامر")  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" and msg.reply_to_message_id_ == 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:del(bot_id.."Lock:AddMempar"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح اضافة الاعضاء")  
return false
end 
if text == "فتح الدردشه" and msg.reply_to_message_id_ == 0 and Manager(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:del(bot_id.."Lock:text"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الدردشه")  
return false
end 
if text == "فتح الدخول" and msg.reply_to_message_id_ == 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:del(bot_id.."Lock:Join"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح دخول الاعضاء")  
return false
end
if text == "فتح البوتات" and msg.reply_to_message_id_ == 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:del(bot_id.."Lock:Bot:kick"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فـتح البوتات")  
return false
end 
if text == "فتح الاشعارات" and msg.reply_to_message_id_ == 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end  
database:del(bot_id.."Lock:tagservr"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فـتح الاشعارات")  
return false
end 
if text == "فتح التثبيت" and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id.."Lock:pin",msg.chat_id_)
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فـتح التثبيت هنا")  
return false
end 
if text == "فتح التعديل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:del(bot_id.."Lock:edit"..msg.chat_id_) 
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فـتح تعديل")  
return false
end 
if text == "فتح التعديل الميديا" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."Lock:edit"..msg.chat_id_) 
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فـتح تعديل")  
return false
end 
if text == "فتح الكل" and msg.reply_to_message_id_ == 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:del(bot_id.."Lock:tagservrbot"..msg.chat_id_)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..''..lock..msg.chat_id_)    
end
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فـتح جميع الاوامر")  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل الروابط" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:Link"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الروابط")  
return false
end 
if text == "قفل الروابط بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Link"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الروابط")  
return false
end 
if text == "قفل الروابط بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Link"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الروابط")  
return false
end 
if text == "قفل الروابط بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Link"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الروابط")  
return false
end 
if text == "فتح الروابط" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:Link"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الروابط")  
return false
end 
if text == "قفل المعرفات" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:User:Name"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل المعرفات")  
return false
end 
if text == "قفل المعرفات بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:User:Name"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل المعرفات")  
return false
end 
if text == "قفل المعرفات بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:User:Name"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل المعرفات")  
return false
end 
if text == "قفل المعرفات بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:User:Name"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل المعرفات")  
return false
end 
if text == "فتح المعرفات" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:User:Name"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح المعرفات")  
return false
end 
if text == "قفل التاك" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:hashtak"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل التاك")  
return false
end 
if text == "قفل التاك بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:hashtak"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل التاك")  
return false
end 
if text == "قفل التاك بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:hashtak"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل التاك")  
return false
end 
if text == "قفل التاك بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:hashtak"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل التاك")  
return false
end 
if text == "فتح التاك" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:hashtak"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح التاك")  
return false
end 
if text == "قفل الشارحه" and Mod(msg) then
database:set(bot_id.."Lock:Cmd"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الشارحه")  
return false
end 
if text == "قفل الشارحه بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Cmd"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الشارحه")  
return false
end 
if text == "قفل الشارحه بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Cmd"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الشارحه")  
return false
end 
if text == "قفل الشارحه بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Cmd"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الشارحه")  
return false
end 
if text == "فتح الشارحه" and Mod(msg) then
database:del(bot_id.."Lock:Cmd"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الشارحه")  
return false
end 
if text == "قفل الصور"and Mod(msg) then
database:set(bot_id.."Lock:Photo"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الصور")  
return false
end 
if text == "قفل الاباحي"and Mod(msg) then
database:set(bot_id.."Lock:Xn"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الاباحي")  
return false
end 
if text == "قفل الصور بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Photo"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الصور")  
return false
end 
if text == "قفل الصور بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Photo"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الصور")  
return false
end 
if text == "قفل الصور بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Photo"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الصور")  
return false
end 
if text == "فتح الصور" and Mod(msg) then
database:del(bot_id.."Lock:Photo"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الصور")  
return false
end 
if text == "فتح الاباحي" and Mod(msg) then
database:del(bot_id.."Lock:Xn"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الاباحي")  
return false
end 
if text == "قفل الفيديو" and Mod(msg) then
database:set(bot_id.."Lock:Video"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الفيديو")  
return false
end 
if text == "قفل الفيديو بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Video"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الفيديو")  
return false
end 
if text == "قفل الفيديو بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Video"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الفيديو")  
return false
end 
if text == "قفل الفيديو بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Video"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الفيديو")  
return false
end 
if text == "فتح الفيديو" and Mod(msg) then
database:del(bot_id.."Lock:Video"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الفيديو")  
return false
end 
if text == "قفل المتحركه" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:Animation"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل المتحركه")  
return false
end
if text == "قفل المتحركه بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Animation"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل المتحركه")  
return false
end 
if text == "قفل المتحركه بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Animation"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل المتحركه")  
return false
end 
if text == "قفل المتحركه بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Animation"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل المتحركه")  
return false
end 
if text == "فتح المتحركه" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:Animation"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح المتحركه")  
return false
end 
if text == "قفل الالعاب" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:geam"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الالعاب")  
return false
end 
if text == "قفل الالعاب بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:geam"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الالعاب")  
return false
end 
if text == "قفل الالعاب بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:geam"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الالعاب")  
return false
end 
if text == "قفل الالعاب بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:geam"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الالعاب")  
return false
end 
if text == "فتح الالعاب" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:geam"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الالعاب")  
return false
end 
if text == "قفل الاغاني" and Mod(msg) then
database:set(bot_id.."Lock:Audio"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الاغاني")  
return false
end 
if text == "قفل الاغاني بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Audio"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الاغاني")  
return false
end 
if text == "قفل الاغاني بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Audio"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الاغاني")  
return false
end 
if text == "قفل الاغاني بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Audio"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الاغاني")  
return false
end 
if text == "فتح الاغاني" and Mod(msg) then
database:del(bot_id.."Lock:Audio"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الاغاني")  
return false
end 
if text == "قفل الصوت" and Mod(msg) then
database:set(bot_id.."Lock:vico"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الصوت")  
return false
end 
if text == "قفل الصوت بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:vico"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الصوت")  
return false
end 
if text == "قفل الصوت بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:vico"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الصوت")  
return false
end 
if text == "قفل الصوت بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:vico"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الصوت")  
return false
end 
if text == "فتح الصوت" and Mod(msg) then
database:del(bot_id.."Lock:vico"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الصوت")  
return false
end 
if text == "قفل الكيبورد" and Mod(msg) then
database:set(bot_id.."Lock:Keyboard"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الكيبورد")  
return false
end 
if text == "قفل الكيبورد بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Keyboard"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الكيبورد")  
return false
end 
if text == "قفل الكيبورد بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Keyboard"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الكيبورد")  
return false
end 
if text == "قفل الكيبورد بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Keyboard"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الكيبورد")  
return false
end 
if text == "فتح الكيبورد" and Mod(msg) then
database:del(bot_id.."Lock:Keyboard"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الكيبورد")  
return false
end 
if text == "قفل الملصقات" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:Sticker"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الملصقات")  
return false
end 
if text == "قفل الملصقات بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Sticker"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الملصقات")  
return false
end 
if text == "قفل الملصقات بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Sticker"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الملصقات")  
return false
end 
if text == "قفل الملصقات بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Sticker"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الملصقات")  
return false
end 
if text == "فتح الملصقات" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:Sticker"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الملصقات")  
return false
end 
if text == "قفل التوجيه" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:forward"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل التوجيه")  
return false
end 
if text == "قفل التوجيه بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:forward"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل التوجيه")  
return false
end 
if text == "قفل التوجيه بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:forward"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل التوجيه")  
return false
end 
if text == "قفل التوجيه بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:forward"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل التوجيه")  
return false
end 
if text == "فتح التوجيه" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:forward"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح التوجيه")  
return false
end 
if text == "قفل الملفات" and Mod(msg) then
database:set(bot_id.."Lock:Document"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الملفات")  
return false
end 
if text == "قفل الملفات بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Document"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الملفات")  
return false
end 
if text == "قفل الملفات بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Document"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الملفات")  
return false
end 
if text == "قفل الملفات بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Document"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الملفات")  
return false
end 
if text == "فتح الملفات" and Mod(msg) then
database:del(bot_id.."Lock:Document"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الملفات")  
return false
end 
if text == "قفل السيلفي" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Lock:Unsupported"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل السيلفي")  
return false
end 
if text == "قفل السيلفي بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Unsupported"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل السيلفي")  
return false
end 
if text == "قفل السيلفي بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Unsupported"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل السيلفي")  
return false
end 
if text == "قفل السيلفي بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Unsupported"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل السيلفي")  
return false
end 
if text == "فتح السيلفي" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:Unsupported"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح السيلفي")  
return false
end 
if text == "قفل الماركداون" and Mod(msg) then
database:set(bot_id.."Lock:Markdaun"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الماركداون")  
return false
end 
if text == "قفل الماركداون بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Markdaun"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الماركداون")  
return false
end 
if text == "قفل الماركداون بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Markdaun"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الماركداون")  
return false
end 
if text == "قفل الماركداون بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Markdaun"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الماركداون")  
return false
end 
if text == "فتح الماركداون" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:Markdaun"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الماركداون")  
return false
end 
if text == "قفل الجهات" and Mod(msg) then
database:set(bot_id.."Lock:Contact"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الجهات")  
return false
end 
if text == "قفل الجهات بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Contact"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الجهات")  
return false
end 
if text == "قفل الجهات بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Contact"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الجهات")  
return false
end 
if text == "قفل الجهات بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Contact"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الجهات")  
return false
end 
if text == "فتح الجهات" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:Contact"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الجهات")  
return false
end 
if text == "قفل الكلايش" and Mod(msg) then
database:set(bot_id.."Lock:Spam"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الكلايش")  
return false
end 
if text == "قفل الكلايش بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Spam"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الكلايش")  
return false
end 
if text == "قفل الكلايش بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Spam"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الكلايش")  
return false
end 
if text == "قفل الكلايش بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Spam"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الكلايش")  
return false
end 
if text == "فتح الكلايش" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Lock:Spam"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الكلايش")  
return false
end 
if text == "قفل الانلاين" and Mod(msg) then
database:set(bot_id.."Lock:Inlen"..msg.chat_id_,"del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفـل الانلاين")  
return false
end 
if text == "قفل الانلاين بالتقيد" and Mod(msg) then
database:set(bot_id.."Lock:Inlen"..msg.chat_id_,"ked")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفـل الانلاين")  
return false
end 
if text == "قفل الانلاين بالكتم" and Mod(msg) then
database:set(bot_id.."Lock:Inlen"..msg.chat_id_,"ktm")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفـل الانلاين")  
return false
end 
if text == "قفل الانلاين بالطرد" and Mod(msg) then
database:set(bot_id.."Lock:Inlen"..msg.chat_id_,"kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفـل الانلاين")  
return false
end 
if text == "فتح الانلاين" and Mod(msg) then
database:del(bot_id.."Lock:Inlen"..msg.chat_id_)  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح الانلاين")  
return false
end 
if text == "قفل التكرار بالطرد" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood","kick")  
Reply_Status(msg,msg.sender_user_id_,"lockkick","♡️ : تم قفل التكرار")
return false
end 
if text == "قفل التكرار" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood","del")  
Reply_Status(msg,msg.sender_user_id_,"lock","♡️ : تم قفل التكرار بالحذف")
return false
end 
if text == "قفل التكرار بالتقيد" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood","keed")  
Reply_Status(msg,msg.sender_user_id_,"lockkid","♡️ : تم قفل التكرار")
return false
end 
if text == "قفل التكرار بالكتم" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood","mute")  
Reply_Status(msg,msg.sender_user_id_,"lockktm","♡️ : تم قفل التكرار")
return false
end 
if text == "فتح التكرار" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
Reply_Status(msg,msg.sender_user_id_,"unlock","♡️ : تم فتح التكرار")
return false
end 

if text == 'تفعيل نسبه الحب' and Mod(msg) then   
if database:get(bot_id..'Cick:lov'..msg.chat_id_) then
Text = ' *♡∶ تم تفعيل نسبه الحب*'
database:del(bot_id..'Cick:lov'..msg.chat_id_)  
else
Text = ' *♡∶ تم تفعيل نسبه الحب مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الحب' and Mod(msg) then  
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..'Cick:lov'..msg.chat_id_,true)  
Text = '\n *♡∶ تم تعطيل نسبه الحب*'
else
Text = '\n *♡∶ تم تعطيل نسبه الحب مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الرجوله' and Mod(msg) then   
if database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
Text = ' *♡∶ تم تفعيل نسبه الرجوله*'
database:del(bot_id..'Cick:rjo'..msg.chat_id_)  
else
Text = ' *♡∶ تم تفعيل نسبه الرجوله مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الرجوله' and Mod(msg) then  
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..'Cick:rjo'..msg.chat_id_,true)  
Text = '\n *♡∶ تم تعطيل نسبه الرجوله*'
else
Text = '\n *♡∶ تم تعطيل نسبه الرجوله مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الكره' and Mod(msg) then   
if database:get(bot_id..'Cick:krh'..msg.chat_id_) then
Text = ' *♡∶ تم تفعيل نسبه الكره*'
database:del(bot_id..'Cick:krh'..msg.chat_id_)  
else
Text = ' *♡∶ تم تفعيل نسبه الكره مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الكره' and Mod(msg) then  
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..'Cick:krh'..msg.chat_id_,true)  
Text = '\n *♡∶ تم تعطيل نسبه الكره*'
else
Text = '\n *♡∶ تم تعطيل نسبه الكره مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الانوثه' and Mod(msg) then   
if database:get(bot_id..'Cick:ano'..msg.chat_id_) then
Text = ' *♡∶ تم تفعيل نسبه الانوثه*'
database:del(bot_id..'Cick:ano'..msg.chat_id_)  
else
Text = ' *♡∶ تم تفعيل نسبه الانوثه مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الانوثه' and Mod(msg) then  
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..'Cick:ano'..msg.chat_id_,true)  
Text = '\n *♡∶ تم تعطيل نسبه الانوثه*'
else
Text = '\n *♡∶ تم تعطيل نسبه الانوثه مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل all' and Constructor(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = ' *♡∶ تم تفعيل امر @all*'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = ' *♡∶ تم تفعيل امر @all مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and Constructor(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n *♡∶ تم تعطيل امر @all*'
else
Text = '\n *♡∶ تم تعطيل امر @all مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and SudoBot(msg) then    
dofile('AEKAN.lua') 
io.popen("rm -rf ~/.telegram-cli/data/audio/*") 
io.popen("rm -rf ~/.telegram-cli/data/document/*") 
io.popen("rm -rf ~/.telegram-cli/data/photo/*") 
io.popen("rm -rf ~/.telegram-cli/data/sticker/*") 
io.popen("rm -rf ~/.telegram-cli/data/temp/*") 
io.popen("rm -rf ~/.telegram-cli/data/thumb/*") 
io.popen("rm -rf ~/.telegram-cli/data/video/*") 
io.popen("rm -rf ~/.telegram-cli/data/voice/*") 
io.popen("rm -rf ~/.telegram-cli/data/profile_photo/*")
print("\27[31;47m\n        ( ♡∶ تم تحديث ملفات البوت )        \n\27[0;34;49m\n") 
send(msg.chat_id_, msg.id_, '*♡∶ تم تحديث جميع ملفات البوت*') 
end 
if text == ("مسح قائمه العام") and SudoBot(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n*♡∶ تم مسح قائمه العام*')
return false
end
if text == ("قائمه العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'GBan:User')
Gban = "\n*♡∶ قائمة المحظورين عام في البوت* \n━━━━━━━━━━━\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
Gban = Gban..""..k.."- ([@"..username.."])\n"
else
Gban = Gban..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
Gban = "*♡∶ لا يوجد محظورين عام*"
end
send(msg.chat_id_, msg.id_, Gban)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر المطور الاساسي* \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر البوت عام*")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم حظره عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر البوت عام*")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر المطور الاساسي* \n")
return false 
end
usertext = '\n*♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم حظره عام من المجموعات*'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر المطور الاساسي* \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر البوت عام*")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم حظره عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم حظره عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم المطور الاساسي* \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم البوت عام*")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم كتمه عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^كتم عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم البوت عام*")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم المطور الاساسي* \n")
return false 
end
usertext = '\n*♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم كتمه عام من المجموعات*'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم المطور الاساسي* \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم البوت عام*")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)

tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم كتمه عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم كتمه عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء (الحظر-الكتم) عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and SudoBot(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n*♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء (الحظر-الكتم) عام من المجموعات*'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and SudoBot(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء (الحظر-الكتم) عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم حظره عام من المجموعات*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and SudoBot(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n♡∶  تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
de = "\n*♡∶ قائمة مطورين البوت* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
de = de..""..k.."- ([@"..username.."])\n"
else
de = de..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
de = "*♡∶ لا يوجد مطورين*"
end
send(msg.chat_id_, msg.id_, de)
end


if text == 'الملفات' and SudoBot(msg) then
t = '♡∶ ملفات السورس ايكان ↓\n *•━━━━━━━━━━━━━•*ٴ \n'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t..i..'- الملف ← {'..v..'}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "متجر الملفات" or text == 'المتجر' then
if SudoBot(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/AEKANTEAM/Files_AEKAN/master/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n♡∶ اهلا بك في متجر ملفات ايكان\n♡∶ ملفات السورس ↓\n*•━━━━━━━━━━━━━•*\n\n"
local TextE = "\n*•━━━━━━━━━━━━━•*\n♡∶  علامة تعني { ✓ } ملف مفعل\n♡∶ علامة تعني { ✘ } ملف معطل\n♡∶ قناة سورس ايكان ↓\n".."♡∶ [اضغط هنا لدخول](t.me/SoalfLove) \n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("File_Bot/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(✓)"
else
CeckFile = "(✘)"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.."→* {`"..name..'`} ⤙ '..CeckFile..'\n[-Information]('..Info..')\n'
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_,"♡∶ لا يوجد اتصال من ال api \n") 
end
return false
end
end

if text and text:match("^(تعطيل) (.*)(.lua)$") and SudoBot(msg) then
local name_t = {string.match(text, "^(تعطيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = "♡∶ الملف ← "..file.."\n♡∶ تم تعطيل ملف \n"
else
t = "♡∶ بالتاكيد تم تعطيل ملف → "..file.."\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/AEKANTEAM/Files_AEKAN/master/File_Bot/"..file)
if res == 200 then
os.execute("rm -fr File_Bot/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('AEKAN.lua')  
else
send(msg.chat_id_, msg.id_,"♡∶ عذرا هاذا ملف ليس من ملفات سورس ايكان\n") 
end
return false
end
if text and text:match("^(تفعيل) (.*)(.lua)$") and SudoBot(msg) then
local name_t = {string.match(text, "^(تفعيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = "♡∶ بالتاكيد تم تفعيل ملف → "..file.." \n"
else
t = "♡∶ الملف ← "..file.."\n♡∶ تم تفعيل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/AEKANTEAM/Files_AEKAN/master/File_Bot/"..file)
if res == 200 then
local chek = io.open("File_Bot/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('AEKAN.lua')  
else
send(msg.chat_id_, msg.id_,"♡∶  عذرا هاذا ملف ليس من ملفات سورس ايكان\n") 
end
return false
end
if text == "مسح الملفات" and SudoBot(msg) then
os.execute("rm -fr File_Bot/*")
send(msg.chat_id_,msg.id_,"*♡∶ تم مسح الملفات*")
return false
end

if text == ("رفع مطور") and msg.reply_to_message_id_ and SudoBot(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته مطور في البوت*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم ترقيته مطور في البوت*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المطورين*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تنزيله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
------------------------------------------------------------------------
if text == ("مسح المالكين") and Sudo(msg) or text == ("حذف المالكين") and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n *♡∶ تم مسح المالكين*')
return false
end

if text == 'المالكين' and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
malk = "\n *قائمة المالكين* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
malk = malk..""..k.."- {[@"..username.."]}\n"
else
malk = malk..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
malk = "*♡∶ لا يوجد مالكين*"
end
send(msg.chat_id_, msg.id_, malk)
return false
end
if text == ("صيح للمالكين") or text == ("تاك للمالكين") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
malk = "\n *♡∶ وينكم تعالوا يريدوكم بالكروب* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
malk = malk..""..k.."- {[@"..username.."]}\n"
else
malk = malk..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
malk = "*♡∶ لا يوجد مالكين*"
end
send(msg.chat_id_, msg.id_, malk)
end

if text == ("رفع مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ♡∶ لا تستطيع استخدام البوت \n  ♡∶ يرجى الاشتراك بالقناه اولا \n  ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم ترقيته مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك @(.*)$") and Sudo(msg) then
local username = text:match("^رفع مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ♡∶ لا تستطيع استخدام البوت \n  ♡∶ يرجى الاشتراك بالقناه اولا \n  ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ♡∶ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n *♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n *♡∶ تم ترقيته مالك*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^رفع مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ♡∶ لا تستطيع استخدام البوت \n  ♡∶ يرجى الاشتراك بالقناه اولا \n  ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم ترقيته مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *♡∶ العضو ⤙* '..userid..''
status  = '\n *♡∶ تم ترقيته مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم تنزيله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n *♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n *♡∶ تم تنزيله من المالكين*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم تنزيله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *♡∶ العضو ⤙* '..userid..''
status  = '\n *♡∶ تم تنزيله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح الاساسين") and CoSu(msg) or text == ("حذف الاساسيين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n*♡∶ تم مسح قائمه المنشئين الاساسين*')
return false
end
if (msg.content_.sticker_)  and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Xn"..msg.chat_id_)=="del" then      
sticker_id = msg.content_.sticker_.sticker_.persistent_id_
st = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..sticker_id.."&type=sticker")
eker = JSON.decode(st)
if eker.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
a = "*♡∶ المنشئين الاساسين تعالوا مخرب* \n *•━━━━━━━━━━━━━•* \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
a = a..""..k.."- ([@"..username.."])\n"
else
a = a..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
a = "*♡∶ لايوجد منشئين اساسيين*"
end
Reply_Status(msg,msg.sender_user_id_,"reply","*♡∶ قام بنشر ملصق اباحي*\n"..a)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if text == 'ملصق' then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'صوت' then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'بصمه' then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'صوره' then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if (msg.content_.photo_) and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Xn"..msg.chat_id_)=="del" then
photo_id = msg.content_.photo_.sizes_[1].photo_.persistent_id_  
Srrt = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..photo_id.."&type=photo")
Sto = JSON.decode(Srrt)
if Sto.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
a = "*♡∶ المنشئين الاساسين تعالوا مخرب* \n *•━━━━━━━━━━━━━•* \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
a = a..""..k.."- {[@"..username.."]}\n"
else
a = a..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
a = "*♡∶ لايوجد منشئين اساسيين*"
end
Reply_Status(msg,msg.sender_user_id_,"reply","*♡∶ قام بنشر صوره اباحيه*\n"..a)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if text == 'المنشئين الاساسين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
a = "\n*♡∶ قائمة المنشئين الاساسين* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
a = a..""..k.."- ([@"..username.."])\n"
else
a = a..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
a = "*♡∶ لا يوجد منشئين اساسيين*"
end
send(msg.chat_id_, msg.id_, a)
return false
end

if text == ("تاك للمنشئين الاساسين") or text == ("صيح المنشئين الاساسين") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
a = "\n*♡∶ وينكم تعالوا يريدوكم بالكروب* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
a = a..""..k.."- {[@"..username.."]}\n"
else
a = a..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
a = "*♡∶ لا يوجد منشئين اساسيين*"
end
send(msg.chat_id_, msg.id_, a)
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم ترقيته منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته منشئ اساسي*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم ترقيته منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من الاساسيين*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تنزيله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) or text == 'حذف المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = '*♡∶ تم مسح المنشئين* '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
b = "\n*♡∶ قائمة المنشئين* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
b = b..""..k.."- ([@"..username.."])\n"
else
b = b..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
b = "*♡∶ لا يوجد منشئين*"
end
send(msg.chat_id_, msg.id_, b)
end
if text == ("تاك للمنشئين") or text == ("صيح المنشئين") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
b = "\n*♡∶ وينكم تعالوا يريدوكم بالكروب* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
b = b..""..k.."- {[@"..username.."]}\n"
else
b = b..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
b = "*♡∶ لا يوجد منشئين*"
end
send(msg.chat_id_, msg.id_, b)
end
if text ==("المنشئ") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"*♡∶ حساب المالك محذوف*")
return false  
end
local UserName = (b.username_ or "SoalfLove")
send(msg.chat_id_, msg.id_,"*♡∶ مالك الكروب ⤙* ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text ==("رفع المنشئ") and Sudo(msg) or text ==("رفع المالك") and Sudo(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"*♡∶ حساب المالك محذوف*")
return false  
end
local UserName = (b.username_ or "SoalfLove")
send(msg.chat_id_, msg.id_,"*♡∶ تم ترقية مالك الكروب* : ["..b.first_name_.."](T.me/"..UserName..")")  
database:sadd(bot_id.."CoSu"..msg.chat_id_,b.id_)
end,nil)   
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم ترقيته منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته منشئ*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم ترقيته منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المنشئين*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تنزيله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) or text == 'حذف المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = '*♡∶ تم مسح المدراء* '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
cc = "\n*♡∶ قائمة المدراء* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
cc = cc..""..k.."- ([@"..username.."])\n"
else
cc = cc..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
cc = "*♡∶ لا يوجد مدراء*"
end
send(msg.chat_id_, msg.id_, cc)
end
if text == ("تاك للمدراء") or text == ("صيح المدراء") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
cc = "\n*♡∶ وينكم تعالوا يريدوكم بالكروب* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
cc = cc..""..k.."- {[@"..username.."]}\n"
else
cc = cc..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
cc = "*♡∶ لا يوجد مدراء*"
end
send(msg.chat_id_, msg.id_, cc)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم ترقيته مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته مدير*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم ترقيته مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المدراء*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تنزيله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"♡∶ لا توجد ادمنية ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"♡∶ تمت ترقية { "..num2.." } من ادمنية المجموعه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) or text == 'حذف الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح الادمنيه*  ')
end
if text == ("الادمنيه") and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
d = "\n*♡∶ قائمة الادمنيه* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
d = d..""..k.."- ([@"..username.."])\n"
else
d = d..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
d = "*♡∶ لا يوجد ادمنيه*"
end
send(msg.chat_id_, msg.id_, d)
end
if text == ("تاك لادمنيه") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
d = "\n*♡∶ قائمة الادمنيه* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
d = d..""..k.."- {[@"..username.."]}\n"
else
d = d..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
d = "*♡∶ لا يوجد ادمنيه*"
end
send(msg.chat_id_, msg.id_, d)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم ترقيته ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته ادمن*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم ترقيته ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم ترقيته ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من الادمنيه*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تنزيله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == 'مسح المنظفين' and BasicConstructor(msg) or text == 'حذف المنظفين' and BasicConstructor(msg) then
database:del(bot_id..'MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' *♡∶ تم مسح المنظفين*')
end
if text == ("المنظفين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'MN:TF'..msg.chat_id_)
Mntf = "\n *♡∶ قائمة المنظفين* \n*ٴ•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
Mntf = Mntf..""..k.."- {[@"..username.."]}"
else
Mntf = Mntf..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
Mntf = " *♡∶ لا يوجد منظفين*"
end
send(msg.chat_id_, msg.id_, Mntf)
end
if text == ("تاك للمنظفين") or text == ("صيح المنظفين") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id..'MN:TF'..msg.chat_id_)
Mntf = "\n *♡∶ وينكم تعالوا يريدوكم بالكروب* \n*ٴ•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
Mntf = Mntf..""..k.."- {[@"..username.."]}\n"
else
Mntf = Mntf..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
Mntf = " *♡∶ لا يوجد منظفين*"
end
send(msg.chat_id_, msg.id_, Mntf)
end
if text == ("رفع منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' *♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
database:sadd(bot_id..'MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم ترقيته منظف*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منظف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' *♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," *♡∶ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه! *")   
return false 
end      
database:sadd(bot_id..'MN:TF'..msg.chat_id_, result.id_)
usertext = '\n *♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n *♡∶ تم ترقيته منظف*'
texts = usertext..status
else
texts = ' *♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' *♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
database:sadd(bot_id..'MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم ترقيته منظف*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *♡∶ العضو ⤙* '..userid..''
status  = '\n *♡∶ تم ترقيته منظف*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم تنزيله من المنظفين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منظف @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'MN:TF'..msg.chat_id_, result.id_)
usertext = '\n *♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n *♡∶ تم تنزيله من المنظفين*'
texts = usertext..status
else
texts = ' *♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n *♡∶ تم تنزيله من المنظفين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *♡∶ العضو ⤙* '..userid..''
status  = '\n *♡∶ تم تنزيله من المنظفين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الطرد من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك طرد البوت* ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع طرد* ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
statusk  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'` \n*♡∶ تم طرده*'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الطرد من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك طرد البوت* ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع طرد* ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
usertext = '\n*♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
statusk  = '\n*♡∶ تم طرده*'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '*♡∶ لا يوجد حساب بهذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الطرد من قبل المنشئين*') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك طرد البوت* ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع طرد* ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
 statusk  = '\n*♡∶ تم طرده*'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n*♡∶ العضو ⤙*  '..userid..''
 statusk  = '\n*♡∶ تم طرده*'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) or text == 'حذف المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح قائمة المميزين*  ')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
e = "\n*♡∶ قائمة مميزين الكروب* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
e = e..""..k.."- ([@"..username.."])\n"
else
e = e..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
e = "*♡∶ لا يوجد مميزين*"
end
send(msg.chat_id_, msg.id_, e)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم ترقيته مميز هنا* '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ تم ترقيته مميز هنا*'
texts = usertext..statuss
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ تم ترقيته مميز هنا*'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
local  statuss  = '\n*♡∶ تم ترقيته مميز هنا* '
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المميزين*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تنزيله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'مسح البنات' and Mod(msg) or text == 'حذف البنات' and Mod(msg) then
database:del(bot_id..'Bnt:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح اميرات التفاعل*  ')
end
if text == ("تاك للبنات") and Mod(msg) then
local list = database:smembers(bot_id..'Bnt:User'..msg.chat_id_)
g = "\n*♡∶ يا أمورات تعالوا يردوكم* \n*ٴ•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
g = g..""..k.."← أميرة التفاعل [@"..username.."]\n"
else
g = g..""..k.."← أميرة التفاعل `"..v.."`\n"
end
end
if #list == 0 then
g = "*♡∶ لا يوجد أمورات تفاعل في الكروب*"
end
send(msg.chat_id_, msg.id_, g)
end
---------
if text == ("رفع بنت الكروب") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ البنت ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n♡∶ تم رفع البنت في المجموعه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع بنت الكروب @(.*)$") and Mod(msg) then
local username = text:match("^رفع بنت الكروب @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Bnt:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ البنت ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ تم رفع البنت في الكروب*'
texts = usertext..statuss
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع بنت الكروب (%d+)$") and Mod(msg) then
local userid = text:match("^رفع بنت الكروب (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
database:sadd(bot_id..'Bnt:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ البنت ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ تم رفع البنت في الكروب*'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n*♡∶ البنت ⤙* '..userid..''
local  statuss  = '\n*♡∶ تم رفع البنت في الكروب* '
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end
if (text == ("تنزيل بنت الكروب")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ البنت ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيل البنت من الكروب*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل بنت الكروب @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل بنت الكروب @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ البنت ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيل البنت من الكروب*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل بنت الكروب (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل بنت الكروب (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Bnt:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ البنت ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيل البنت من الكروب*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ البنت ⤙* '..userid..''
status  = '\n*♡∶ تم تنزيل البنت من الكروب*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
-----------------------------------------------------
if text == 'مسح الاعضاء العامين' and Mod(msg) or text == 'حذف الاعضاء العامين' and Mod(msg) then
database:del(bot_id..'Mempaam:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '♡∶  تم مسح  قائمة الاعضاء العامين  ')
end
if text == ("الاعضاء العامين") and Mod(msg) then
local list = database:smembers(bot_id..'Mempaam:User'..msg.chat_id_)
f = "\n*♡∶ قائمة الاعضاء العامين في الكروب* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
f = f..""..k.."- ([@"..username.."])\n"
else
f = f..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
f = "*♡∶ لا يوجد اعضاء عامين*"
end
send(msg.chat_id_, msg.id_, f)
end
if text == ("رفع عضو عام") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم ترقيته عضو عام* '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع عضو عام @(.*)$") and Mod(msg) then
local username = text:match("^رفع عضو عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Mempaam:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ تم ترقيته عضو عام*'
texts = usertext..statuss
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع عضو عام (%d+)$") and Mod(msg) then
local userid = text:match("^رفع عضو عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الرفع من قبل المنشئين*') 
return false
end
database:sadd(bot_id..'Mempaam:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
local  statuss  = '\n*♡∶ تم ترقيته عضو عام*'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
local  statuss  = '\n*♡∶ تم ترقيته عضو عام* '
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل عضو عام")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله من الاعضاء العامين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل عضو عام @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل عضو عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من الاعضاء العامين*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل عضو عام (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل عضو عام (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله من الاعضاء العامين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تنزيله من الاعضاء العامين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n♡∶ تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
Bans = "\n♡∶ قائمة المحظورين في المجموعه \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
Bans = Bans..""..k.."- ([@"..username.."])\n"
else
Bans = Bans..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
Bans = "*♡∶ لا يوجد محظورين*"
end
send(msg.chat_id_, msg.id_, Bans)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'♡∶ تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر البوت* ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع حظر* ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'♡∶البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'♡∶  تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع حظر* ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ المستخدم ⤙ *['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم حظره*'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '*♡∶ لا يوجد حساب بهذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'♡∶ تم تعطيل الحظر من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك حظر البوت*")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع حظر* ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '*♡∶ انا لست محظوراً* \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم الغاء حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '*♡∶ انا لست محظوراً* \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء حظره*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '*♡∶ انا لست محظوراً* \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n♡∶لعضو ⤙ '..userid..''
status  = '\n*♡∶ تم الغاء حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '♡∶  تم مسح قائمه المكتومين ')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
Muted = "\n♡∶ قائمة المكتومين في المجموعه \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
Muted = Muted..""..k.."- ([@"..username.."])\n"
else
Muted = Muted..""..k.."- {["..v.."](tg://user?id="..v..")}\n"
end
end
if #list == 0 then
Muted = "*♡∶ لا يوجد مكتومين*"
end
send(msg.chat_id_, msg.id_, Muted)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'lock:ktm'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الكتم من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم البوت* ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع كتم* ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙* ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
if database:get(bot_id..'lock:ktm'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الكتم من قبل المنشئين*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم البوت* ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع كتم* ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم كتمه*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '*♡∶ لا يوجد حساب بهذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n*♡∶ عذراً لا تستطيع كتم* ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n☑| تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n*♡∶ عذراً لا تستطيع كتم* ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n☑| تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'lock:ktm'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل الكتم من قبل المنشئين*') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك كتم البوت* ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع كتم* ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم الغاء كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء كتمه*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم الغاء كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك تقيد البوت* ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع تقيد* ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تقييده في الكروب*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك تقيد البوت* ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع تقيد* ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تقييده في الكروب*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n*♡∶ عذراً لا تستطيع تقيد* ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n☑| تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n*♡∶ عذراً لا تستطيع تقيد* ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n☑| تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*♡∶ لا يمكنك تقيد البوت* ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا تستطيع تقيد* ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم تقييده في الكروب*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم تقييده في الكروب*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم الغاء تقييده*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء تقييده*'
texts = usertext..status
else
texts = '*♡∶ لا يوجد حساب بهذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء تقييده*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n*♡∶ العضو ⤙*  '..userid..''
status  = '\n*♡∶ تم الغاء تقييده*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Mod(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n*♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء القيود عنه*'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n*♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم الغاء القيود عنه*'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '*♡∶ المعرف غلط*'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم الغاء القيود عنه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم الغاء القيود عنه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Mod(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = "♡∶ الحظر العام ⤙ "..GBan.."\n♡∶ الحظر ⤙ "..Ban.."\n♡∶ الكتم ⤙ "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '*♡∶ المعرف غلط*'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = "♡∶ الحظر العام ⤙ "..GBan.."\n♡∶ الكتم العام ⤙ "..Gmute.."\n♡∶ الحظر ⤙ "..Ban.."\n♡∶ الكتم ⤙ "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم رفعه مشرف بالكروب* '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
usertext = '\n*♡∶ العضو ⤙* ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم رفعه مشرف بالكروب* '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '*♡∶ لا يوجد حساب بهذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n♡∶ تم تنزيله مشرف من الكروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n♡∶ تم تنزيله مشرف من الكروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '*♡∶ لا يوجد حساب بهذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع مشرف بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم رفعه مشرف بالكروب بكل الصلاحيات*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع مشرف بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم رفعه مشرف بالكروب بكل الصلاحيات*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '*♡∶ لا يوجد حساب بهذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
status  = '\n*♡∶ الايدي ⤙* `'..result.sender_user_id_..'`\n*♡∶ تم تنزيله مشرف من الكروب بكل الصلاحيات*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل مشرف بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*♡∶ عذراً عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
usertext = '\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(username or 'SoalfLove')..')'
status  = '\n*♡∶ تم تنزيله مشرف من الكروب بكل الصلاحيات*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '*♡∶ لا يوجد حساب بهذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == "الاعدادات" and Mod(msg) then    
if database:get(bot_id.."Lock:text"..msg.chat_id_) == true then
te = "الدردشه ∶ ✘ ∶ بالمسح"
else
te =  "الدردشه ∶ ✔"   
end        
if database:get(bot_id.."Lock:AddMempar"..msg.chat_id_) == "kick" then
AddM = "الاضافه ∶ ✘ ∶ بالطرد"
else
AddM =  "الاضافه ∶ ✔"   
end        
if database:get(bot_id.."Lock:Join"..msg.chat_id_) == "kick" then
Jo = "الدخول ∶ ✘ ∶ بالطرد"
else
Jo =  "الدخول ∶ ✔"   
end        
if database:get(bot_id.."Lock:Bot:kick"..msg.chat_id_) == "del" then
Botki = "البوتات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Bot:kick:"..msg.chat_id_) == "kick" then
Botki = "البوتات ∶ ✘ ∶ بالطرد"
else
Botki =  "البوتات ∶ ✔"   
end        
if database:get(bot_id.."Lock:tagservr"..msg.chat_id_) == "del" then
tag = "الاشعارات ∶ ✘ ∶ بالمسح"
else
tag =  "الاشعارات ∶ ✔"   
end        
if database:get(bot_id.."lockpin"..msg.chat_id_) == true then
pin = "التثبيت ∶ ✘ ∶ بالمسح"
else
pin =  "التثبيت ∶ ✔"   
end        
if database:get(bot_id.."Lock:edit"..msg.chat_id_) == true then
edit = "التعديل ∶ ✘ ∶ بالمسح"
else
edit =  "التعديل ∶ ✔"   
end        
if database:get(bot_id.."Lock:edit"..msg.chat_id_) == true then
edi = "تعديل الميديا ∶ ✘ ∶ بالمسح"
else
edi =  "تعديل الميديا ∶ ✔"   
end        
if database:get(bot_id.."Lock:Link"..msg.chat_id_) == "del" then
Link = "الروابط ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Link:"..msg.chat_id_) == "kick" then
Link = "الروابط ∶ ✘ ∶ بالطرد"
elseif database:get(bot_id.."Lock:Link:"..msg.chat_id_) == "ktm" then
Link = "الروابط ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Link:"..msg.chat_id_) == "ked" then
Link = "الروابط ∶ ✘ ∶ بالتقييد"
else
Link =  "الروابط ∶ ✔"   
end        
if database:get(bot_id.."Lock:User:Name"..msg.chat_id_) == "del" then
usNa = "المعرفات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:User:Name:"..msg.chat_id_) == "kick" then
usNa = "المعرفات ∶ ✘ ∶ بالطرد"
elseif database:get(bot_id.."Lock:User:Name:"..msg.chat_id_) == "ktm" then
usNa = "المعرفات ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:User:Name:"..msg.chat_id_) == "ked" then
usNa = "المعرفات ∶ ✘ ∶ بالتقييد"
else
usNa =  "المعرفات ∶ ✔"   
end        
local Text ="♡∶ اهلا بك في قائمه اعدادات المجموعه .\n♡∶  علامه ( ✘ ) تعني الامر مقفول .\n♡∶  علامه ( ✔ ) تعني الامر مفتوح ."
keyboard = {} 
keyboard.inline_keyboard = {
{{text =te,callback_data=msg.sender_user_id_.."Lock:text"},{text =usNa,callback_data=msg.sender_user_id_.."Lock:User:Name"}},
{{text =AddM,callback_data=msg.sender_user_id_.."Lock:AddMempar"},{text =Link,callback_data=msg.sender_user_id_.."Lock:Link"}},
{{text =Jo,callback_data=msg.sender_user_id_.."Lock:Join"},{text =edi,callback_data=msg.sender_user_id_.."Lock:edit"}},
{{text =Botki,callback_data=msg.sender_user_id_.."Lock:Bot:kick"},{text =edit,callback_data=msg.sender_user_id_.."TR:Lock:pin"}},
{{text =tag,callback_data=msg.sender_user_id_.."Lock:tagservr"},{text =pin,callback_data=msg.sender_user_id_.."TR:Lock:pin"}},
{{text ="التالي ⊁ .",callback_data=msg.sender_user_id_.."LS1"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"*♡∶ التثبيت والغاء التثبيت تم قفله من قبل المنشئين*")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء تثبيت الرساله*")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"*♡∶ انا لست مشرف هنا يرجى ترقيتي مشرف ثم اعد المحاوله*")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"*♡∶ تم تثبيت رسالتك الآن*")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"*♡∶ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات*")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," *♡∶ عذراً تم قفل التثبيت*")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء تثبيت الكل*")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," *♡∶ انا لست مشرف هنا يرجى ترقيتي مشرف ثم اعد المحاوله*")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ♡∶ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"*♡∶ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات*")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,'♡∶ تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,'♡∶ تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_,"*♡∶ ارسل رابط الكروب او رابط قناة الكروب*")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"*♡∶ تم تفعيل الرابط*") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"*♡∶ تم تعطيل الرابط*") 
return false end
end
if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if Mod(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"*♡∶ تم تفعيل الصوره*") 
return false  
end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if Mod(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"*♡∶ تم تعطيل الصوره*") 
return false end
end
if text == "الرابط" then 
local status_Link = database:get(bot_id.."Link_Group:status"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"*♡∶ الرابط معطل*") 
return false  
end
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,'*♡∶ 🅛🅘🅝🅚 🅖🅡🅞🅤🅟*\n*•━━━━━━━━━━━━━•*\n ['..link..']')                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
linkgp = '*♡∶ 🅛🅘🅝🅚 🅖🅡🅞🅤🅟*\n*•━━━━━━━━━━━━━•*\n ['..linkgpp.result..']'
else
linkgp = '*♡∶ لا يوجد رابط ارسل ضع رابط*'
end  
send(msg.chat_id_, msg.id_,linkgp)              
end            
end
if text == 'مسح الرابط' or text == 'حذف الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_,"*♡∶ تم مسح الرابط* ")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,'*♡∶ ارسل لي الصوره*') 
return false
end
if text == "حذف الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'♡∶ تم ازالة صورة المجموعه') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الان الوصف*')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = '*♡∶ ارسل لي الترحيب الان*'
tt = '\n*♡∶ تستطيع اضافة مايلي !*\n*♡∶ دالة عرض الاسم ⤙* {`name`}\n*♡∶ دالة عرض المعرف ⤙* {`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '*♡∶ لم يتم تعيين ترحيب للكروب* '
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'*♡∶ تم تفعيل ترحيب الكروب* ') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'*♡∶ تم تعطيل ترحيب الكروب* ') 
return false  
end
if text == 'مسح الترحيب' or text == 'حذف الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'*♡∶ تم ازالة ترحيب الكروب* ') 
end
end

if text == "قائمه المنع" and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Filter:msg",msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = bot_id},function(arg,data) 
local Text ='♡∶ قائمه الممنوعات'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'صور', url="https://t.me/"..data.username_.."?start=ph"..msg.chat_id_},{text = 'كلمات', url="https://t.me/"..data.username_.."?start=msg"..msg.chat_id_}},
{{text = 'متحركات', url="https://t.me/"..data.username_.."?start=gif"..msg.chat_id_},{text = 'ملصقات', url="https://t.me/"..data.username_.."?start=Sti"..msg.chat_id_}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end
if text == "مسح قائمه المنع" and Mod(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local listtext = database:smembers(bot_id.."List:Filter:text"..msg.chat_id_)  
for k,v in pairs(listtext) do  
database:srem(bot_id.."List:Filter:text"..msg.chat_id_,v)  
end  
local listAnimation = database:smembers(bot_id.."List:Filter:Animation"..msg.chat_id_)  
for k,v in pairs(listAnimation) do  
database:srem(bot_id.."List:Filter:Animation"..msg.chat_id_,v)  
end  
local listSticker = database:smembers(bot_id.."List:Filter:Sticker"..msg.chat_id_)  
for k,v in pairs(listSticker) do  
database:srem(bot_id.."List:Filter:Sticker"..msg.chat_id_,v)  
end  
local listPhoto = database:smembers(bot_id.."List:Filter:Photo"..msg.chat_id_)  
for k,v in pairs(listPhoto) do  
database:srem(bot_id.."List:Filter:Photo"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"♡∶ تم مسح قائمه المنع")  
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Mod(msg) then       
send(msg.chat_id_, msg.id_,"♡∶ الان ارسل { كلمه،صوره،ملصق،متحركه } لمنعه من المجموعه")  
database:set(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"♡∶ تم منع الكلمه بنجاح")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:sadd(bot_id.."List:Filter:text"..msg.chat_id_,text)  
return false 
end  
end
if msg.content_.ID == 'MessageAnimation' then    
local tsssst = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"♡∶ تم منع المتحركه بنجاح")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:sadd(bot_id.."List:Filter:Animation"..msg.chat_id_,msg.content_.animation_.animation_.persistent_id_)  
return false 
end  
end
if msg.content_.ID == 'MessageSticker' then    
local tsssst = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"♡∶ تم منع الملصق بنجاح")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:sadd(bot_id.."List:Filter:Sticker"..msg.chat_id_,msg.content_.sticker_.sticker_.persistent_id_)  
return false 
end  
end
if msg.content_.ID == 'MessagePhoto' then    
local tsssst = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"♡∶ تم منع الصوره بنجاح")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:sadd(bot_id.."List:Filter:Photo"..msg.chat_id_,msg.content_.photo_.sizes_[1].photo_.persistent_id_)  
return false 
end  
end
if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Mod(msg) then    
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ عـليك الاشـتࢪاك في قنـاة البـوت اولآ . \n ♡∶ قنـاة البـوت ←  ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,"♡∶ الان ارسل { كلمه،صوره،ملصق،متحركه } ممنوع لالغاء منعه")  
database:set(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false 
end
if text then 
local test = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_,"♡∶ تم الغاء منعها ")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:srem(bot_id.."List:Filter:text"..msg.chat_id_,text)  
return false
end  
end
if msg.content_.ID == 'MessageAnimation' then    
local onte = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if onte and onte == "reppp" then   
send(msg.chat_id_, msg.id_,"♡∶ تم الغاء منع المتحركه بنجاح ")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:srem(bot_id.."List:Filter:Animation"..msg.chat_id_,msg.content_.animation_.animation_.persistent_id_)  
return false
end  
end
if msg.content_.ID == 'MessageSticker' then    
local Stic = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if Stic and Stic == "reppp" then   
send(msg.chat_id_, msg.id_,"♡∶ تم الغاء منع الملصق بنجاح ")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:srem(bot_id.."List:Filter:Sticker"..msg.chat_id_,msg.content_.sticker_.sticker_.persistent_id_)  
return false
end  
end
if msg.content_.ID == 'MessagePhoto' then    
local hoto = database:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if hoto and hoto == "reppp" then   
send(msg.chat_id_, msg.id_,"♡∶ تم الغاء منع الصوره بنجاح ")  
database:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:srem(bot_id.."List:Filter:Photo"..msg.content_.photo_.sizes_[1].photo_.persistent_id_)  
return false
end  
end

if text == 'المطور' or text == 'مطور' or text == 'المطوره' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Text_Dev = database:get(bot_id..'Text:Dev:Bot')
if Text_Dev then 
send(msg.chat_id_, msg.id_,Text_Dev)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end

if text == 'نقل الاحصائيات' and SudoBot(msg) then
local Users = database:smembers('AEKAN:'..bot_id.."userss")
local Groups = database:smembers('AEKAN:'..bot_id..'groups') 
for i = 1, #Groups do
database:sadd(bot_id..'AEKAN:Chek:Groups',Groups[i])  
local list1 = database:smembers('AEKAN:'..bot_id..'creatorbasic:'..Groups[i])
for k,v in pairs(list1) do
database:sadd(bot_id.."AEKAN:Basic:Constructor"..Groups[i], v)
end
local list2 = database:smembers('AEKAN:'..bot_id..'creator:'..Groups[i])
for k,v in pairs(list2) do
database:sadd(bot_id.."AEKAN:Constructor"..Groups[i], v)
end
local list3 = database:smembers('AEKAN:'..bot_id..'owners:'..Groups[i])
for k,v in pairs(list3) do
database:sadd(bot_id.."AEKAN:Manager"..Groups[i], v)
end
local list4 = database:smembers('AEKAN:'..bot_id..'mods:'..Groups[i])
for k,v in pairs(list4) do
database:sadd(bot_id.."AEKAN:Mod:User"..Groups[i], v)
end
database:set(bot_id.."AEKAN:Lock:tagservrbot"..Groups[i],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..'AEKAN:'..lock..Groups[i],"del")    
end
end
for i = 1, #Users do
database:sadd(bot_id..'AEKAN:User_Bot',Users[i])  
end
send(msg.chat_id_, msg.id_,'♡∶ تم نقل : '..#Groups..' كروب\n♡∶ تم نقل : '..#Users..' مشترك \n♡∶ من التحديث القديم الى التحديث الجديد')
end

if text and text:match("^/start ph(.*)$") then
Sf = database:get(bot_id.."Filter:msg")
local list = database:smembers(bot_id.."List:Filter:Photo"..Sf)  
for k,v in pairs(list) do
if v then
inline = {
{{text = '- الغاء المنع .',callback_data="pito"..v}},
}
send_inline_Media(msg.chat_id_,"sendPhoto","photo",v,inline) 
end
end
if #list == 0 then
send(msg.chat_id_, msg.id_,"♡∶ لا يوجد صور ممنوعه"  )  
end
Zs = {
{{text = '- اضغط هنا .',callback_data="delallph"..Sf}},
}
send_inlin_key(msg.chat_id_,"♡∶ هل تريد الغاء منع كل الصور؟",Zs,msg.id_)
end  
if text and text:match("^/start msg(.*)$") then
sl = text:match("^/start msg(.*)$")
local list = database:smembers(bot_id.."List:Filter:text"..sl)
t = "\n♡∶ قائمة الكلمات الممنوعه \n ﹊﹊﹊﹊﹊﹊﹊﹊﹊\n"
for k,v in pairs(list) do
if v then
t = t..""..k.."- ["..v.."]\n"
end
end
if #list == 0 then
t = "♡∶ لا يوجد كلمات ممنوعه"  
end
send(msg.chat_id_, msg.id_,t)  
end  
if text and text:match("^/start gif(.*)$") then
Sf = text:match("^/start gif(.*)$")
local list = database:smembers(bot_id.."List:Filter:Animation"..Sf)
for k,v in pairs(list) do
if v then
inline = {
{{text = '- الغاء المنع .',callback_data="animation"..v.."chatid"..Sf}},
}
send_inline_Media(msg.chat_id_,"sendanimation","animation",v,inline) 
end
end
if #list == 0 then
t = "♡∶ لا يوجد متحركات ممنوعه"  
send(msg.chat_id_, msg.id_,t)  
end
ZsText = "♡∶ هل تريد الغاء منع كل المتحركات؟"
Zs = {
{{text = '- اضغط هنا .',callback_data="delallanimation"..Sf}},
}
send_inlin_key(msg.chat_id_,ZsText,Zs,msg.id_)
end  
if text and text:match("^/start Sti(.*)$") then
Sf = text:match("^/start Sti(.*)$")
local list = database:smembers(bot_id.."List:Filter:Sticker"..Sf)
for k,v in pairs(list) do
if v then
inline = {
{{text = '- الغاء المنع .',callback_data="Sticker"..v.."chatid"..Sf}},
}
send_inline_Media(msg.chat_id_,"sendSticker","sticker",v,inline) 
end
end
if #list == 0 then
t = "♡∶ لا يوجد ملصقات ممنوعه"  
send(msg.chat_id_, msg.id_,t)  
end
ZsText = "♡∶ هل تريد الغاء منع كل  الملصقات؟"
Zs = {
{{text = '- اضغط هنا .',callback_data="delallSticker"..Sf}},
}
send_inlin_key(msg.chat_id_,ZsText,Zs,msg.id_)
end

if text == 'حذف كليشه المطور' and SudoBot(msg) then
database:del(bot_id..'Text:Dev:Bot')
send(msg.chat_id_, msg.id_,'*♡∶ تم حذف كليشه المطور* ')
end
if text == 'ضع كليشه المطور' and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الكليشه الان* ')
return false
end
if text and database:get(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'*♡∶ تم الغاء حفظ كليشة المطور* ')
return false
end
database:set(bot_id..'Text:Dev:Bot',text)
database:del(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'*♡∶ تم حفظ كليشه المطور* ')
return false
end
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
♡∶ ارسل الان النص
♡∶ يمكنك اضافه :
- #rdphoto > تعليق الصوره
- #username > اسم المستخدم
- #msgs > عدد رسائل المستخدم
- #photos > عدد صور المستخدم
- #id > ايدي المستخدم
- #auto > تفاعل المستخدم
- #stast > موقع المستخدم 
- #edit > عدد السحكات
- #game > النقود
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم ازالة كليشة الايدي*  ')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء تعين الايدي* ") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'*♡∶ تم تعين الايدي بنجاح* ')    
end

if text == 'مسح البوتات' and Mod(msg) or text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,aeko)  
local admins = aeko.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if aeko.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "*♡∶ لا توجد بوتات في المجموعه* ")
else
local t = '*♡∶ عدد البوتات هنا ⤙* {'..c..'}\n*♡∶ عدد البوتات التي هي مشرف ⤙* {'..x..'}\n*♡∶ تم طرد ⤙* {'..(c - x)..'} *من البوتات*'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n*♡∶ قائمة البوتات الموجوده* \n*•━━━━━━━━━━━━━•*\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "*♡∶ لا توجد بوتات في المجموعه* ")
return false 
end
if #admins == i then 
local a = '\n*•━━━━━━━━━━━━━•*\n*♡∶ عدد البوتات التي هنا ⤙* {'..n..'} *بوت*\n'
local f = '*♡∶ عدد البوتات التي هي مشرف ⤙* {'..t..'}\n*♡∶ ملاحضه علامة ال (✯) تعني ان البوت مشرف* \n'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Ashtrak:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, "*♡∶ تم الغاء حفظ الاشتراك*") 
database:del(bot_id.."Set:Ashtrak:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Ashtrak:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"*♡∶ تم حفظ اشتراك الكروب*") 
database:del(bot_id.."Set:Ashtrak:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  


if text == 'ضع اشتراك' or text == 'وضع الاشتراك' then 
if Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Set:Ashtrak:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"*♡∶ ارسل معلومات الاشتراك الان*")  
end
end
if text == 'مسح الاشتراك' or text == 'حذف الاشتراك' then  
if Sudo(msg) then
send(msg.chat_id_, msg.id_,"*♡∶ تم ازالة اشتراك الكروب*")  
database:del(bot_id.."Set:Ashtrak:Group"..msg.chat_id_) 
end
end
if text == 'الاشتراك' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Set_Ashtrak = database:get(bot_id.."Set:Ashtrak:Group" .. msg.chat_id_)   
if Set_Ashtrak then     
send(msg.chat_id_,msg.id_, Set_Ashtrak)   
else      
send(msg.chat_id_, msg.id_,"*♡∶ لم يتم وضع الاشتراك راسل مطوريني*")   
end    
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, "*♡∶ تم الغاء حفظ القوانين*") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"*♡∶ تم حفظ قوانين الكروب*") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"*♡∶ ارسل لي القوانين الان*")  
end
end
if text == 'مسح القوانين' or text == 'حذف القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_,"*♡∶ تم ازالة قوانين الكروب*")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"*♡∶ لا توجد قوانين هنا*")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list_tflesh ={"Lock:Bot:kick","lock:user:name","Lock:Link","lock:forward","lock:Photo","lock:Sticker","lock:Animation","lock:Video","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam",'lock:edit','lock_edit_med'}
for i,lock in pairs(list_tflesh) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*♡∶ بواسطة ⤙* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SoalfLove')..') \n*♡∶ تـم تفعيل الحمايه القصوى*\nٴ⫷━━━━━━━𝘼𝙆━━━━━━━⫸ٴ\n*♡∶ تم قفل البوتات*\n*♡∶ تم قفل المعرفات* \n*♡∶ تم قفل الروابط*\n*♡∶ تم قفل التوجيه*\n*♡∶ تم قفل الصور*\n*♡∶ تم قفل المتحركه*\n*♡∶ تم قفل الملصقات*\n*♡∶ تم قفل الفيديو*\n*♡∶ تم تعطيل الايدي بالصوره*\n*♡∶ تم قفل الصوت*\n*♡∶ تم قفل الاغاني*\n*♡∶ تم قفل الملفات*\n*♡∶ تم قفل السيلفي*\n*♡∶ تم قفل الماركداون*\n*♡∶ تم قفل الجهات*\n*♡∶ تم قفل الكلايش*\n*♡∶ تم قفل التعديل*\n*♡∶ تم قفل تعديل الميديا*\n\nٴ⤙Ⓐ⓷ⓀⓄⓃ ♡ ⓇⓉ⊝ⓎⓉ⤙ٴ')
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list_tflesh ={"Lock:Bot:kick","lock:user:name","Lock:Link","lock:forward","lock:Photo","lock:Sticker","lock:Animation","lock:Video","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam",'lock:edit','lock_edit_med'}
for i,lock in pairs(list_tflesh) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*♡∶ بواسطة ⤙* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SoalfLove')..') \n*♡∶ تـم تعطيل الحمايه القصوى*\nٴ⫷━━━━━━━𝘼??━━━━━━━⫸ٴ\n*♡∶ تم فتح البوتات*\n*♡∶ تم فتح المعرفات* \n*♡∶ تم فتح الروابط*\n*♡∶ تم فتح التوجيه*\n*♡∶ تم فتح الصور*\n*♡∶ تم فتح المتحركه*\n*♡∶ تم فتح الملصقات*\n*♡∶ تم فتح الفيديو*\n*♡∶ تم تفعيل الايدي بالصوره*\n*♡∶ تم فتح الصوت*\n*♡∶ تم فتح الاغاني*\n*♡∶ تم فتح الملفات*\n*♡∶ تم فتح السيلفي*\n*♡∶ تم فتح الماركداون*\n*♡∶ تم فتح الجهات*\n*♡∶ تم فتح الكلايش*\n*♡∶ تم فتح التعديل*\n*♡∶ تم فتح تعديل الميديا*\n\nٴ⤙Ⓐ⓷ⓀⓄⓃ ♡ ⓇⓉ⊝ⓎⓉ⤙ٴ')
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,'*♡∶ تم فحص الحسابات المحذوفه وتم طردها*')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,'*♡∶ لا توجد صلاحيات مضافه*')
return false
end
t = "\n*♡∶ قائمة الصلاحيات المضافه* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' ⤙ ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "مسح الصلاحيات" and Mod(msg) or text == "حذف الصلاحيات" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."Coomds"..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
database:del(bot_id.."Coomds"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"*♡∶ تم مسح قائمة الصلاحيات*")
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "*♡∶ ارسل نـوع الرتـبـه ?*\n*♡∶ {عـضـو -- ممـيـز -- ادمـن -- مـديـر}*") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "*♡∶ تم مسح الصلاحيه*") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"*♡∶ تم الغاء الامر *\n✓") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"*♡∶ تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n♡∶ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"*♡∶ تستطيع اضافه صلاحيات {مميز - عضو} \n♡∶ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"*♡∶ تستطيع اضافه صلاحيات {عضو} \n♡∶ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "*♡∶ تـم اضـافـه الصلاحيه*") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..RTPA..' *هنا*\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..RTPA..' *هنا*\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..RTPA..' *هنا*\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..RTPA..' *هنا*\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..RTPA..' *هنا*\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..RTPA..' *هنا*\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..RTPA..' *هنا*\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..RTPA..' *هنا*\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..text1[2]..' *هنا*')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..text1[2]..' *هنا*')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..text1[2]..' *هنا*')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم رفعه* '..text1[2]..' *هنا*')   
end
else
info = '*♡∶ المعرف غلط*'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..text1[2]..' *هنا*')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..text1[2]..' *هنا*')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..text1[2]..' *هنا*')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n*♡∶ العضو ⤙*  ['..result.title_..'](t.me/'..(text1[3] or 'SoalfLove')..')'..'\n*♡∶ تم تنريله من* '..text1[2]..' *هنا*')   
end
else
info = '*♡∶ المعرف غلط*'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "حذف رسايلي" or text == "حذف رسائلي" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'♡∶ تم مسح رسائلك جميعها'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'♡∶  عدد رسائلك هنا ⤙ { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
if text == 'تفعيل الاذاعه' and SudoBot(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n*♡∶ تم تفعيل الاذاعه* ' 
else
Text = '\n*♡∶ تم تفعيل الاذاعه مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and SudoBot(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n*♡∶ تم تعطيل الاذاعه*' 
else
Text = '\n*♡∶ تم تعطيل الاذاعه مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and SudoBot(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n*♡∶ تم تفعيل التواصل* ' 
else
Text = '\n*♡∶ تم تفعيل التواصل مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n*♡∶ تم تعطيل التواصل*' 
else
Text = '\n*♡∶ تم تعطيل التواصل مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت المجاني' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n*♡∶ تم تفعيل البوت المجاني* ' 
else
Text = '\n*♡∶ تم تفعيل البوت المجاني مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت المجاني' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n*♡∶ تم تعطيل البوت المجاني*' 
else
Text = '\n*♡∶ تم تعطيل البوت المجاني مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التنظيف' and Constructor(msg) then   
if database:get(bot_id..'Lock:delmsg'..msg.chat_id_)  then
database:del(bot_id..'Lock:delmsg'..msg.chat_id_) 
Text = '\n♡∶ تم تعطيل التنظيف' 
else
Text = '\n♡∶ بالتاكيد تم تعطيل التنظيف'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التنظيف' and Constructor(msg) then  
if not database:get(bot_id..'Lock:delmsg'..msg.chat_id_)  then
database:set(bot_id..'Lock:delmsg'..msg.chat_id_,true) 
Text = '\n♡∶ تم تفعيل التنظيف' 
else
Text = '\n♡∶ بالتاكيد تم تفعيل التنظيف'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^تنظيف (%d+)$') and Mod(msg) or text and text:match('^حذف (%d+)$') and Mod(msg) or text and text:match('^مسح (%d+)$') and Mod(msg) and database:get(bot_id..'Lock:delmsg'..msg.chat_id_) then                
if not database:get(bot_id..'AEKAN:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local Number = tonumber(text:match('^تنظيف (%d+)$')) or tonumber(text:match('^حذف (%d+)$')) or tonumber(text:match('^مسح (%d+)$'))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if Number > 1000 then 
send(msg.chat_id_, msg.id_,'*♡∶ لا يمكنك تنظيف اكثر من 1000 رساله*') 
return false  
end  
local Message = msg.id_
for i=1,tonumber(Number) do
DeleteMessage(msg.chat_id_,{[0]=Message})
Message = Message - 1048576
end
send(msg.chat_id_, msg.id_,'*♡∶ تم حذف*'..Number..'*رساله .*')  
database:setex(bot_id..'AEKAN:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text == "تنظيف التعديل" and Mod(msg) or text == "حذف التعديل" and Mod(msg) then
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,500 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,'*♡∶ تم حذف جميع الرسائل المعدله* ')
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي الاسم الآن* ")  
end
return false
end

if text and text == 'تفعيل وضع حسابي' and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'bot:pubgacuount'..msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n*♡∶ تم تفعيل وضع حسابي مسبقاً*')  
else
send(msg.chat_id_, msg.id_, '\n*♡∶ تم تفعيل وضع حسابي*')
database:del(bot_id..'bot:pubgacuount'..msg.chat_id_)
end end
if text and text == 'تعطيل وضع حسابي' and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'bot:pubgacuount'..msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n*♡∶ تم تعطيل وضع حسابي مسبقاً*') 
else
send(msg.chat_id_, msg.id_, '\n*♡∶ تم تعطيل وضع حسابي*')
database:set(bot_id..'bot:pubgacuount'..msg.chat_id_,true)
end end

if not database:get(bot_id..'bot:pubgacuount'..msg.chat_id_) then
if (text and text == 'وضع حسابي') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_, '\n*♡∶ ارسل لي اسم حسابك*')
database:set(bot_id..'bot:n1'..msg.sender_user_id_..'','yes')
return false end 
local pubg = database:get(bot_id..'bot:n1'..msg.sender_user_id_)
if pubg == 'yes' then
if text:match("^(.*)$") then
send(msg.chat_id_, msg.id_, '\n*♡∶ تم حفظ اسمك* \n*♡∶ ارسل ايدي حسابك* ')
database:set(bot_id..'bot:n1'..msg.sender_user_id_..'','no')
database:set(bot_id..'bot:name_acount'..msg.sender_user_id_, text)
database:set(bot_id..'bot:n2'..msg.sender_user_id_ ,'yes')
return false end
end 
local pubg = database:get(bot_id..'bot:n2'..msg.sender_user_id_)
if pubg == 'yes' then
if text:match("^(%d+)$") then
database:set(bot_id..'bot:idacount'..msg.sender_user_id_, text)
database:set(bot_id..'bot:n2'..msg.sender_user_id_, 'no')
local aa = [[
*♡∶ تم حفظ ايديك
♡∶ ارسل لي تقييمك كمثال :-

- برونز 1
- كولد 2
- بلاتينيوم 3
- دايموند 4
- كراون 5
- ايس
- كونكر*
]]
send(msg.chat_id_, msg.id_,aa)
database:set(bot_id..'bot:n3'..msg.sender_user_id_, 'yes')
return false 
else 
return false end
end 
local pubg = database:get(bot_id..'bot:n3'..msg.sender_user_id_)
if pubg == 'yes' then
if text:match("^برونز (%d+)$") or text:match("^كولد (%d+)$") or text:match("^بلاتينيوم (%d+)$") or text:match("^دايموند (%d+)$") or text:match("^كراون (%d+)$") or text:match("^ايس$") or text:match("^كونكر$") then
database:set(bot_id..'bot:n3'..msg.sender_user_id_, 'no')
send(msg.chat_id_, msg.id_, '\n*♡∶ تم حفظ تقييمك* \n*♡∶ تم حفظ حسابك في* '..Namebot..' ')
database:set(bot_id..'bot:acctear'..msg.sender_user_id_, text)
return false 
else 
send(msg.chat_id_, msg.id_, '*♡∶ لم يتم حفظ تقييمك* \n *♡∶ إرسل تقييمك بشكل صحيح* ')
return false end
end

if (text and text == 'مسح حسابي') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'bot:idacount'..msg.sender_user_id_)
database:del(bot_id..'bot:acctear'..msg.sender_user_id_)
database:del(bot_id..'bot:name_acount'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_, '\n*♡∶ تم مسح حسابك من* '..Namebot..' ')
end

if (text and text == 'حسابي') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'bot:idacount'..msg.sender_user_id_)then
local n = database:get(bot_id..'bot:idacount'..msg.sender_user_id_)
local nn = database:get(bot_id..'bot:acctear'..msg.sender_user_id_)
local nnn = database:get(bot_id..'bot:name_acount'..msg.sender_user_id_)
local Texting = {
'كفووو وربي 😌🤞',
"تقييمك مصعده كمبره ؟ 😉💞",
"تقيمك هذا وحدك جبته لْـۆ هكر وياك 🥱!",
"طفي الهاك اخي طفي 🤥",
"ليش متمسح ببجي مو احسلك 🤧",
"شكبرك شكدك وهذا تقيمك مقتنع بي انته!!!",
}
local pubg_send = Texting[math.random(#Texting)]
send(msg.chat_id_, msg.id_,'[\n♡∶ حسابك على الببجي\n♡∶ اسم حسابك ⤙ {'..nnn..'}\n♡∶ ايدي حسابك ⤙ {'..n..'}\n♡∶ تقييمك ⤙ {'..nn..'}\n\n♡∶ {' ..pubg_send..'}]\n')
else 
send(msg.chat_id_, msg.id_, '\n*♡∶ لم يتم حفظ حسابك في* '..Namebot..' \n*♡∶ ارسل { وضع حسابي } حته احفظه*')
end end end


if text == ""..(database:get(bot_id..'Name:Bot') or 'ايكان').."" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Namebot = (database:get(bot_id..'Name:Bot') or 'ايكان')
local AEKAN_Msg = {
'ها حياتي اني '..Namebot..'',
'دا اشرب اركيله تعال غير وقت',
'ماكو غيري بالكروب تصيح عليه',
'نعم يعطري اني '..Namebot..'',
'شتريد حبي اني '..Namebot..'',
'ها يعمري وياك '..Namebot..'',
'احتركوا أهل '..Namebot..' شتريد',
'هياتني قلبي',
'عمري فداك '..Namebot..' حب '
}
send(msg.chat_id_, msg.id_,'['..AEKAN_Msg[math.random(#AEKAN_Msg)]..']') 
return false
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'*♡∶ الاذاعه معطله من قبل المطور الاساسي*')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي سواء ⤙ { ملصق, متحركه, صوره, رساله }*\n*♡∶ للخروج ارسل الغاء* ") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'*♡∶ الاذاعه معطله من قبل المطور الاساسي*')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي سواء ⤙ { ملصق, متحركه, صوره, رساله }*\n*♡∶ للخروج ارسل الغاء* ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'*♡∶ الاذاعه معطله من قبل المطور الاساسي*')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي التوجيه الان*") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'*♡∶ الاذاعه معطله من قبل المطور الاساسي*')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"*♡∶ ارسل لي التوجيه الان*") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^وضع اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"*♡∶ البوت ليس مشرف يرجى ترقيتي !*")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"*♡∶ ليست لدي صلاحية تغير اسم الكروب*")  
else
sebd(msg.chat_id_,msg.id_,'*♡∶ تم تغيير اسم الكروب الى* {['..Name..']}')  
end
end,nil) 
end
if text == "تاك للمشرفين" and Special(msg) or text == "صيح المشرفين" and Special(msg) or text == "#admin" and Special(msg) or text == "@admin" and Special(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id.."AEKAN:admin:Time"..msg.chat_id_) then 
return
 send(msg.chat_id_, msg.id_,"*♡∶ انتظر دقيقه من فضلك*")
end
database:setex(bot_id..'AEKAN:admin:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100 },function(extra,result,success)
m = 0
tgad = 0
local ans = result.members_  
for k, v in pairs(ans) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if m == 1 or m == tgad or k == 0 then
tgad = m + 5
t = "#Admin"
end
m = m + 1
Adminame = data.first_name_
Adminame = Adminame:gsub("]","")
Adminame = Adminame:gsub("[[]","")
t = t..", ["..Adminame.."](tg://user?id="..v.user_id_..")"
if m == 1 or m == tgad or k == 0 then
local Text = t:gsub('#Admin,','#Admin\n')
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end
end,nil)
end
end,nil)
end
if text == "all" and Special(msg) or text == "@all" and Special(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."AEKAN:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"*♡∶ انتظر دقيقه من فضلك*")
end
database:setex(bot_id..'AEKAN:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,AEKAN)
x = 0
tags = 0
local list = AEKAN.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end
if text == "تاك للكل" and Mod(msg) or text == "تاك" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,AEKAN)
local t = "\n*♡∶ قائمة الاعضاء* \n*•━━━━━━━━━━━━━•*\n"
x = 0
local list = AEKAN.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
x = x + 1
if data.username_ then
t = t..""..x.."→ {[@"..data.username_.."]} \n"
else
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..""..x.."→ {["..tagname.."](tg://user?id="..v.user_id_..")} \n"
end
if k == 0 then
send(msg.chat_id_,msg.id_,t)
end
end,nil)
end
end,nil)
end

if text and text:match("^تاك ل (%d+)$") and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
taglimit = text:match("^تاك ل (%d+)$"):gsub('تاك ل ','')
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = taglimit
},function(ta,AEKAN)
local t = "\n*♡∶ قائمة الاعضاء* \n*•━━━━━━━━━━━━━•*\n"
x = 0
local list = AEKAN.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
x = x + 1
if data.username_ then
t = t..""..x.."→ {[@"..data.username_.."]} \n"
else
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..""..x.."→ {["..tagname.."](tg://user?id="..v.user_id_..")} \n"
end
if k == 0 then
send(msg.chat_id_,msg.id_,t)
end
end,nil)
end
end,nil)
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_,"*♡∶ لا تستطيع تنزيل المطور الاساسي*")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'المالك ،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = '' end
if database:sismember(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_) then
bnt = 'بنت الكروب ،' else bnt = '' end
if database:sismember(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_) then
mep = 'عضو عام ،' else mep = '' end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n*♡∶ تم تنزيل الشخص من الرتب التاليه* \n*♡∶* { "..dev..''..cu..''..crr..''..cr..''..own..''..mod..''..vip.."..bnt.."..mep.." } \n")
else
send(msg.chat_id_, msg.id_,"\n*♡∶ ليس لديه رتب* \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Mod'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Bnt:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mempaam:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_,"*♡∶ تم مسح ردود المطور*")
end

if text == ("ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n♡∶ قائمة ردود المطور \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه'
end
text = text..""..k.." >> ("..v..") ⤙ {"..db.."}\n"
end
if #list == 0 then
text = "*♡∶ لا يوجد ردود للمطور*"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'*♡∶ تم حفظ الرد بنجاح*')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الرد الذي تريده سواء كان {صوره,فيديو,متحركه,ملصق,بصمه,صوت}*')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'*♡∶ تم ازالة الرد من قائمه ردود المطور*')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == 'اضف رد للكل' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الكلمه التي تريد اضافتها*')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد للكل' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الكلمه التي تريد حذفها*')
database:set(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text and not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local text1 = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح ردود المدير") and Constructor(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id..'List:Manager'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"*♡∶ تم مسح ردود المدير*")
end

if text == ("ردود المدير") and Mod(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
text = "*♡∶ قائمه ردود المدير* \n*•━━━━━━━━━━━━━•*\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = 'اغنيه'
end
text = text..""..k..">> ("..v..") ⤙ {"..db.."}\n"
end
if #list == 0 then
text = "*♡∶ لا يوجد ردود للمدير*"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_..'')
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'*♡∶ تم حفظ الرد بنجاح*')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الرد الذي تريده سواء كان {صوره,فيديو,متحركه,ملصق,بصمه,صوت}*')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,'*♡∶ تم ازالة الرد* ')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == 'اضف رد' and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الكلمه التي تريد اضافتها*')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد' and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ ارسل الكلمه التي تريد حذفها*')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true2')
return false 
end
if text and not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local text1 = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
-------------------------------
if text == ""..(database:get(bot_id..'Name:Bot') or 'ايكان').." غادر" or text == 'غادري' or text == 'غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'*♡∶ تم مغادرة المجموعه*') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end
if text and text:match("^غادر (-%d+)$") then
local GP_ID = {string.match(text, "^(غادر) (-%d+)$")}
if Sudo(msg) and not database:get(bot_id.."AEKAN:Left:Bot"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=GP_ID[2],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"*♡∶ تم مغادرة المجموعه*") 
send(GP_ID[2], 0,"*♡∶ تم مغادرة الكروب بأمر من مطور البوت* ") 
database:srem(bot_id.."AEKAN:Chek:Groups",GP_ID[2])  
return false 
end
end
if text == 'بوت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Namebot = (database:get(bot_id..'Name:Bot') or 'ايكان')
send(msg.chat_id_, msg.id_,'*اسمي* ['..Namebot..'] 🤞😌') 
end
if text == 'الاحصائيات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '*♡∶ اسم البوت ⤙* '..Namebot..'\n'..'*♡∶ عدد المجموعات ⤙* {'..Groups..'}'..'\n*♡∶ عدد المشتركين ⤙* {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المجموعات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '*♡∶ عدد المجموعات ⤙* {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '*♡∶ عدد المشتركين ⤙* {`'..Users..'|}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' and SudoBot(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '*♡∶ تم تفعيل مغادرة البوت*'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = '*♡∶ تم تفعيل مغادرة البوت مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and SudoBot(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '*♡∶ تم تعطيل مغادرة البوت*'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = '*♡∶ تم تعطيل مغادرة البوت مسبقاً*'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل ردود المدير' and Mod(msg) then  
 if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = '*♡∶ تم تفعيل ردود المدير*'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = '*♡∶ تم تفعيل ردود المدير مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المدير' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n*♡∶ تم تعطيل ردود المدير*' 
else
Text = '\n*♡∶ تم تعطيل ردود المدير مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل ردود المطور' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n*♡∶ تم تفعيل ردود المطور*' 
else
Text = '\n*♡∶ تم تفعيل ردود المطور مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المطور' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n*♡∶ تم تعطيل ردود المطور*' 
else
Text = '\n*♡∶ تم تعطيل ردود المطور مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'تفعيل الايدي' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n*♡∶ تم تفعيل الايدي*' 
else
Text = '\n*♡∶ تم تفعيل الايدي مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n*♡∶ تم تعطيل الايدي*' 
else
Text = '\n*♡∶ تم تعطيل الايدي مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'السيرفر' and SudoBot(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '܁༯┆مدة تشغيل السيرفر ▾ .\n*▸  '"$linux_version"'*' 
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆الذاكره العشوائية ▾ .\n*▸ '"$memUsedPrc"'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆وحدة التخزين ▾ .\n*▸ '"$HardDisk"'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆المعالج ▾ .\n*▸ '"`grep -c processor /proc/cpuinfo`""Core ▸ $CPUPer% "'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆الدخول ▾ . \n*▸ '`whoami`'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆مدة تشغيل السيرفر ▾ .\n*▸ '"$uptime"'*'
]]):read('*all'))  
end

if text == 'تفعيل الايدي بالصوره' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n*♡∶ تم تفعيل الايدي بالصوره* ' 
else
Text = '\n*♡∶ تم تفعيل الايدي بالصوره مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n*♡∶ تم تعطيل الايدي بالصوره*' 
else
Text = '\n*♡∶ تم تعطيل الايدي بالصوره مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n*♡∶ تم تفعيل الحظر* ' 
else
Text = '\n*♡∶ تم تفعيل الحظر مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n*♡∶ تم تعطيل الحظر*' 
else
Text = '\n*♡∶ تم تعطيل الحظر مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الكتم' and Constructor(msg) then   
if database:get(bot_id..'lock:ktm'..msg.chat_id_)  then
database:del(bot_id..'lock:ktm'..msg.chat_id_) 
Text = '\n*♡∶ تم تفعيل الكتم* ' 
else
Text = '\n*♡∶ تم تفعيل الكتم مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الكتم' and Constructor(msg) then  
if not database:get(bot_id..'lock:ktm'..msg.chat_id_)  then
database:set(bot_id..'lock:ktm'..msg.chat_id_,true) 
Text = '\n*♡∶ تم تعطيل الكتم*' 
else
Text = '\n*♡∶ تم تعطيل الكتم مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n*♡∶ تم تفعيل الرفع* ' 
else
Text = '\n*♡∶ تم تفعيل الرفع مسبقاً* '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n*♡∶ تم تعطيل الرفع*' 
else
Text = '\n*♡∶ تم تعطيل الرفع مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Add_Mem = tonumber(database:get(bot_id..'Add:Memp'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*♡∶ ايديه ⤙*(`'..iduser..'`)\n*♡∶ معرفه ⤙*('..username..')\n*♡∶ رتبته ⤙*('..rtp..')\n*♡∶ تعديلاته ⤙*('..edit..')\n*♡∶ النقود ⤙*('..NUMPGAME..')\n*♡∶ جهاته ⤙*('..Add_Mem..')\n*♡∶ رسائله ⤙*('..Msguser..')')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Add_Mem = tonumber(database:get(bot_id..'Add:Memp'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*♡∶ ايديه ⤙*(`'..iduser..'`)\n*♡∶ معرفه ⤙*('..username..')\n*♡∶ رتبته ⤙*('..rtp..')\n*♡∶ تعديلاته ⤙*('..edit..')\n*♡∶ النقود ⤙*('..NUMPGAME..')\n*♡∶ جهاته ⤙*('..Contact..')\n*♡∶ رسائله ⤙*('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,'*♡∶ المعرف غير صحيح* ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'*♡∶ رتبتك في البوت ⤙* '..rtp)
end
if text == "اسمي"  then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = '*♡∶ اسمك الاول ⤙* {`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = '*♡∶ اسمك الثاني ⤙* {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ ايديك ⤙* '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'SoalfLove')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*♡∶ العضو ⤙ (*'..username..'*)\n♡∶ الرتبه ⤙ ('..rtp..')*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*♡∶ العضو ⤙ (*'..username..'*)\n♡∶ الرتبه ⤙ ('..rtp..')*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'*♡∶ المعرف غير صحيح* ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*♡∶ الايدي ⤙* ('..iduser..')\n*♡∶ المعرف ⤙* ('..username..')\n*♡∶ الرتبه ⤙* ('..rtp..')\n*♡∶ نوع الكشف ⤙ بالرد*')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*♡∶ الايدي ⤙* ('..iduser..')\n*♡∶ المعرف ⤙* ('..username..')\n*♡∶ الرتبه ⤙* ('..rtp..')\n*♡∶ نوع الكشف ⤙ بالمعرف*')
end,nil)
else
send(msg.chat_id_, msg.id_,'♡∶ المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text==('عدد الكروب') and Mod(msg) or text==('معلومات الكروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"*♡∶ البوت ليس مشرف هنا* \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local aek = '*♡∶ عدد الادمنيه ⤙* '..data.administrator_count_..
'\n\n*♡∶ عدد المطرودين ⤙* '..data.kicked_count_..
'\n\n*♡∶ عدد الاعضاء ⤙* '..data.member_count_..
'\n\n*♡∶ عدد رسائل الكروب ⤙* '..(msg.id_/2097152/0.5)..
'\n\n*♡∶ اسم المجموعه ⤙* ['..ta.title_..']'
send(msg.chat_id_, msg.id_, aek) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n*♡∶ عذراً لا استطيع طرد* ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*♡∶ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,'*♡∶ البوت ليس مشرف يرجى ترقيتي !*') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,'*♡∶ عذراً لا استطيع طرد ادمنية الكروب*') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'*♡∶ تم طردك من المجموعه* ') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'*♡∶ امر اطردني تم تعطيله* ') 
end
end
if text and text:match("^صيح (.*)$") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'*♡∶ المعرف غلط* ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'*♡∶ لا استطيع صيح معرفات القنوات*') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'*♡∶ لا استطيع صيح معرفات البوتات*') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'*♡∶ لا استطيع صيح معرفات الكروبات*') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'*♡∶ تعال حبي يصيحونك بل كروب* [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,'*♡∶ امر صيح تم تعطيله* ') 
end
return false
end

if text == 'منو ضافني' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'*♡∶ انت مالك الكروب* ') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '♡∶ الشخص الذي قام باضافتك هو ⤙ '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'*♡∶ انت دخلت عبر الرابط*') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'*♡∶ امر منو ضافني تم تعطيله* ') 
end
end

if text == 'تفعيل ضافني' and Mod(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = '*♡∶ تم تفعيل امر منو ضافني*'
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = '*♡∶ تم تفعيل امر منو ضافني مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and Mod(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n*♡∶ تم تعطيل امر منو ضافني*'
else
Text = '\n*♡∶ تم تعطيل امر منو ضافني مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and Mod(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = '*♡∶ تم تفعيل امر صيح*'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = '*♡∶ تم تفعيل امر صيح مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تنزيل جميع الرتب' and CoSu(msg) or text == 'تنزيل الرتب' and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
database:del(bot_id..'Bnt:User'..msg.chat_id_)
database:del(bot_id..'Mempaam:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n*♡∶ تم تنزيل الكل من الرتب الاتيه* \n*♡∶ المميزين ، الادمنيه ، المدراء ، المنشئين* \n')
end
if text == 'تعطيل صيح' and Mod(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n*♡∶ تم تعطيل امر صيح*'
else
Text = '\n*♡∶ تم تعطيل امر صيح مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل اطردني' and Mod(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = '*♡∶ تم تفعيل امر اطردني*'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = '*♡∶ تم تفعيل امر اطردني مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and Mod(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n*♡∶ تم تعطيل امر اطردني*'
else
Text = '\n*♡∶ تم تعطيل امر اطردني مسبقاً*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "صورتي"  then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"*♡∶ الصوره معطله*") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_,"♡∶ عدد صورك   ←  "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'*لا تمتلك صوره في حسابك*', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == 'تغير الايدي' and Manager(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠𝙼𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠𝙸𝙳 𖨈 #id 𖥲 .
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 ?? #id 𓍯. 💕
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 ??𝒐 𝑮𝒓𝒐𝒖𝒑 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
]],
[[
┌ 𝐔𝐒𝐄𝐑 𖤱 #username 𖦴 .
├ 𝐌𝐒𝐆 𖤱 #msgs 𖦴 .
├ 𝐒𝐓𝐀 𖤱 #stast 𖦴 .
└ 𝐈𝐃 𖤱 #id 𖦴 .
]],
[[
𓄼🇮🇶 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 :#username 
𓄼🇮🇶 𝑺𝒕𝒂𝒔𝒕 :#stast 
𓄼🇮🇶 𝒊𝒅 :#id 
𓄼🇮🇶 𝑮𝒂𝒎𝒆𝑺 :#game 
𓄼🇮🇶 𝑴𝒔𝒈𝒔 :#msgs
]],
[[
❤️|-وف اتفاعل يحلو😍🙈
👨‍👧|- ☆يوزرك #username 🎫
💌|- ☆رسائلك #msgs 💌
🎫|- ☆ايديك #id   🥇
🎟|- ☆موقعك #stast 🌐 
🤸‍♂|- ☆جفصاتك #edit  🌬
🥉|- ☆تفاعلك #auto 🚀
🏆|- ☆مجوهراتك #game 🕹
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬𝐭𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔??𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨?? , #stast  
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game 
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'*♡∶ تم تغير الايدي ارسل ايدي لرؤيته*')
end
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,aek,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Add_Mem = tonumber(database:get(bot_id..'Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (aek.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local aekan = {
"♡∶ اروح فـدوه للـحلـويـن",
"♡∶ لا قيمه للقمر امام وجهك",
"♡∶ مارتاحلك تلش تلش",
"♡∶ شهل الصوره تخمبش",
"♡∶ منور اليوم فطيتك",
"♡∶ فديت الحلو",
"♡∶ شهل العسل",
"♡∶ شاعل الدنيا بحلاتك",
"♡∶ شهل الگيمر",
"♡∶ ببكن نكبل",
"♡∶ خليني احبك",
"♡∶ شهل الجمال",
"♡∶ فديت الصاك",
"♡∶ فـدشـي عمـي",
"♡∶ جمالك ماخذ الأول",
"♡∶ بـبكن حـلك",
}
local rdphoto = aekan[math.random(#aekan)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp)
get_id_text = get_id_text:gsub('#rtpa',rtpa)
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME)
get_id_text = get_id_text:gsub('#nspatfa',nspatfa)
get_id_text = get_id_text:gsub('#AddMem',Add_Mem) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, aek.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n♡∶ ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, aek.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n♡∶ ايديك ⤙ '..msg.sender_user_id_..'\n♡∶ معرفك ⤙ '..username..'\n♡∶ رتبتك ⤙ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n♡∶ موقعك ⤙ '..rtpa..'\n♡∶ تفاعلك ⤙ '..Total_Msg(Msguser)..'\n♡∶ رسائلك ⤙ '..Msguser..'\n♡∶ نسبة تفاعلك ⤙ '..string.sub(nspatfa, 1,5)..' %\n♡∶ السحكات ⤙ '..edit..'\n♡∶ نقودك ⤙ '..NUMPGAME..'\n')   
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n♡∶ ايديك ⤙ '..msg.sender_user_id_..'\n♡∶ معرفك ⤙ '..username..'\n♡∶ رتبتك ⤙ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n♡∶ موقعك ⤙ '..rtpa..'\n♡∶ تفاعلك ⤙ '..Total_Msg(Msguser)..'\n♡∶ رسائلك ⤙ '..Msguser..'\n♡∶ نسبة تفاعلك ⤙ '..string.sub(nspatfa, 1,5)..' %\n♡∶ السحكات ⤙ '..edit..'\n♡∶ نقودك ⤙ '..NUMPGAME..']\n')   
else
send(msg.chat_id_, msg.id_, '\n♡∶ الصوره ⤙ ليس لديك صور في حسابك'..'[\n♡∶ ايديك ⤙ '..msg.sender_user_id_..'\n♡∶ معرفك ⤙ '..username..'\n♡∶ رتبتك ⤙ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n♡∶ موقعك ⤙ '..rtpa..'\n♡∶ تفاعلك ⤙ '..Total_Msg(Msguser)..'\n♡∶ رسائلك ⤙ '..Msguser..'\n♡∶ نسبة تفاعلك ⤙ '..string.sub(nspatfa, 1,5)..' %\n♡∶ السحكات ⤙ '..edit..'\n♡∶ نقودك ⤙ '..NUMPGAME..']\n')   
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp)
get_id_text = get_id_text:gsub('#rtpa',rtpa)
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME)
get_id_text = get_id_text:gsub('#nspatfa',nspatfa)
get_id_text = get_id_text:gsub('#AddMem',Add_Mem) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n♡∶ ايديك ⤙ '..msg.sender_user_id_..'\n♡∶ معرفك ⤙ '..username..'\n♡∶ رتبتك ⤙ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n♡∶ موقعك ⤙ '..rtpa..'\n♡∶ تفاعلك ⤙ '..Total_Msg(Msguser)..'\n♡∶ رسائلك ⤙ '..Msguser..'\n♡∶ نسبة تفاعلك ⤙ '..string.sub(nspatfa, 1,5)..' %\n♡∶ السحكات ⤙ '..edit..'\n♡∶ نقودك ⤙ '..NUMPGAME..']\n')   
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' or text == 'تعديلاتي' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = '*♡∶ لم تقم بالسحك في الكتابه*'
else
Text = '*♡∶ عدد سحكاتك ⤙* { '..Num..' } '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "حذف سحكاتي" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ تم مسح سحكاتك*'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "حذف جهاتي" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ تم مسح جهاتك*'  )  
database:del(bot_id..'Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Add_Mem = tonumber(database:get(bot_id..'Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Add_Mem == 0 then 
Text = '*♡∶ لم تقم بأضافة احد*'
else
Text = '♡∶ عدد جهاتك *⤙ { '..Add_Mem..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "تنظيف المشتركين" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'*♡∶ لا يوجد مشتركين وهميين في البوت* \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*♡∶ عدد المشتركين الان ⤙* ( '..#pv..' )\n*♡∶ تم ازالة ⤙* ( '..sendok..' ) *من المشتركين*\n*♡∶ عدد المشتركين الحقيقي الآن ⤙* ( '..ok..' ) *مشترك* \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'*♡∶ لا يوجد مجموعات وهميه في البوت*\n')   
else
local AEKAN = (w + q)
local sendok = #group - AEKAN
if q == 0 then
AEKAN = ''
else
AEKAN = '\n*♡∶ تم ازالة ⤙* { '..q..' } *مجموعات من البوت*'
end
if w == 0 then
AEKANk = ''
else
AEKANk = '\n*♡∶ تم ازالة ⤙* {'..w..'} *مجموعه لان البوت عضو*'
end
send(msg.chat_id_, msg.id_,'*♡∶ عدد المجموعات الان ⤙* { '..#group..' }'..AEKANk..''..AEKAN..'\n*♡∶ الان عدد المجموعات الحقيقي ⤙ { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end

if text:match("^ايدي المجموعه$") and Sudo(msg) or text:match("^ايدي الكروب$") and Sudo(msg) then
send(msg.chat_id_, msg.id_, '*♡∶ ايدي المجموعه ⤙* '..msg.chat_id_..'')
end
if text:match("^(time)$") and Mod(msg) or text:match("^(الوقت)$") and Mod(msg) or text:match("^(الساعه)$") and Mod(msg) or text:match("^(التاريخ)$") and Mod(msg) then
send(msg.chat_id_, msg.id_, '*♡∶ الساعه ⤙* '..os.date("%I:%M%p")..' \n*♡∶ التاريخ ⤙* '..os.date("%Y/%m/%d")..' \n')
end
-----------
if text ==("مسح") and Mod(msg) or text ==("حذف") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "*♡∶ تم الغاء الامر*  ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_,"*♡∶ تم اضافة له* {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "*♡∶ تم الغاء الامر*  ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "*♡∶ تم اضافة له* {"..numadded..'} *من النقود*', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
aek = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,aek)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '*♡∶ ارسل لي عدد الرسائل الآن*') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقود (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
aek = text:match("^اضف نقود (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,aek)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '*♡∶ ارسل لي عدد النقود التي تريد اضافتها*') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقود (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقود (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_,"*♡∶ تم اضافة له* {"..Num..'} *من النقود*')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n*♡∶ تم اضافة له* {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقود' or text == 'نقودي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '*♡∶ لم تلعب اي لعبه للحصول على نقود*'
else
Text = '*♡∶ عدد نقودك التي ربحتها هي ⤙* { '..Num..' } *نقودك*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقودي (%d+)$") or text and text:match("^بيع نقود (%d+)$") then
local NUMPY = text:match("^بيع نقودي (%d+)$") or text:match("^بيع نقود (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*♡∶ لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'♡∶ ليس لديك نقود في الالعاب\n♡∶ اذا كنت تريد ربح نقود \n♡∶ ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n♡∶ ليس لديك نقود بهاذ العبه \n♡∶ لزيادة نقودك في اللعبه \n♡∶ ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'♡∶ تم خصم *⤙ { '..NUMPY..' }* من نقودك \n♡∶ وتم اضافة* ⤙ { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end
if text == 'فحص البوت' and Mod(msg) or text == 'فحص' and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔' else info = '✘' end
if Json_Info.result.can_delete_messages == true then
delete = '✔' else delete = '✘' end
if Json_Info.result.can_invite_users == true then
invite = '✔' else invite = '✘' end
if Json_Info.result.can_pin_messages == true then
pin = '✔' else pin = '✘' end
if Json_Info.result.can_restrict_members == true then
restrict = '✔' else restrict = '✘' end
if Json_Info.result.can_promote_members == true then
promote = '✔' else promote = '✘' end 
send(msg.chat_id_,msg.id_,'\n*♡∶ اهلاً عزيزي البوت هنا مشرف*'..'\n*♡∶  وصلاحياته هي ↓* \nٴ━━━━━━━━━━'..'\n*♡∶  تغير معلومات المجموعه ⤙* ❴ '..info..' ❵'..'\n*♡∶  حذف الرسائل ⤙* ❴ '..delete..' ❵'..'\n*♡∶  حظر المستخدمين ⤙* ❴ '..restrict..' ❵'..'\n*♡∶  دعوة المستخدمين ⤙* ❴ '..invite..' ❵'..'\n*♡∶  تثبيت الرسائل ⤙* ❴ '..pin..' ❵'..'\n*♡∶  اضافة مشرفين جدد ⤙* ❴ '..promote..' ❵')   
end
end
end

if text and text:match("^كول (.*)$") and Special(msg) then
local txt = {string.match(text, "^(كول) (.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, 0, txt[2], "md")
local id = msg.id_
local msgs = {
[0] = id
}
local chat = msg.chat_id_
delete_msg(chat, msgs)
end

if text and text:match("^تغير رد المطور (.*)$") and Sudo(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد المطور الى ⤙* "..Teext)
end
if text and text:match("^تغير رد المالك (.*)$") and CoSu(msg) then
local Teext = text:match("^تغير رد المالك (.*)$") 
database:set(bot_id.."CoSu:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد المالك الى ⤙* "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and BasicConstructor(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد المنشئ الاساسي الى ⤙* "..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Constructor(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد المنشئ الى ⤙* "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد المدير الى ⤙* "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Mod(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد الادمن الى ⤙* "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Mod(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد المميز الى ⤙* "..Teext)
end
if text and text:match("^تغير رد بنت الكروب (.*)$") and Mod(msg) then
local Teext = text:match("^تغير رد بنت الكروب (.*)$") 
database:set(bot_id.."Bnt:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد بنت الكروب الى ⤙* "..Teext)
end
if text and text:match("^تغير رد عضو عام (.*)$") and Mod(msg) then
local Teext = text:match("^تغير رد عضو عام (.*)$") 
database:set(bot_id.."Mempaam:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد العضو العام الى ⤙* "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and Mod(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"*♡∶ تم تغير رد العضو الى ⤙* "..Teext)
end

if text == 'مسح رد المطور' and Sudo(msg) or text == 'حذف رد المطور' and Sudo(msg) then
database:del(bot_id..'Sudo:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد المطور*')
end
if text == 'مسح رد المالك' and CoSu(msg) or text == 'حذف رد المالك' and CoSu(msg) then
database:del(bot_id..'CoSu:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد المالك*')
end
if text == 'مسح رد منشئ الاساسي' and BasicConstructor(msg) or text == 'حذف رد المنشئ الاساسي' and BasicConstructor(msg) then
database:del(bot_id..'BasicConstructor:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد المنشئ الاساسي*')
end
if text == 'مسح رد المنشئ' and Constructor(msg) or text == 'حذف رد المنشئ' and Constructor(msg) then
database:del(bot_id..'Constructor:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد المنشئ*')
end
if text == 'مسح رد المدير' and Manager(msg) or text == 'حذف رد المدير' and Manager(msg) then
database:del(bot_id..'Manager:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد المدير*')
end
if text == 'مسح رد الادمن' and Mod(msg) or text == 'حذف رد الادمن' and Mod(msg) then
database:del(bot_id..'Mod:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد الادمن*')
end
if text == 'مسح رد المميز' and Mod(msg) or text == 'حذف رد المميز' and Mod(msg) then
database:del(bot_id..'Special:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد المميز*')
end
if text == 'مسح رد بنت الكروب' and Mod(msg) or text == 'حذف رد بنت الكروب' and Mod(msg) then
database:del(bot_id..'Bnt:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد بنت الكروب*')
end
if text == 'مسح رد عضو عام' and Mod(msg) or text == 'حذف رد عضو عام' and Mod(msg) then
database:del(bot_id..'Mempaam:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد العضو العام*')
end
if text == 'مسح رد العضو' and Mod(msg) or text == 'حذف رد العضو' and Mod(msg) then
database:del(bot_id..'Memp:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*♡∶ تم مسح رد العضو*')
end 

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help8'..msg.sender_user_id_)
database:set(bot_id..'help8_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help9'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help9'..msg.sender_user_id_)
database:set(bot_id..'help9_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help10'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '♡∶ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help10'..msg.sender_user_id_)
database:set(bot_id..'help10_text',text)
return false
end
end

if text == 'استعاده الاوامر' and SudoBot(msg) then
database:del(bot_id..'help_text')
database:del(bot_id..'help1_text')
database:del(bot_id..'help2_text')
database:del(bot_id..'help3_text')
database:del(bot_id..'help4_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help7_text')
database:del(bot_id..'help8_text')
database:del(bot_id..'help9_text')
database:del(bot_id..'help10_text')
send(msg.chat_id_, msg.id_, '♡∶ تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه الاوامر')
database:set(bot_id..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر م1' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م1')
database:set(bot_id..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م2' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م2')
database:set(bot_id..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م3' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م3')
database:set(bot_id..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م4' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م4')
database:set(bot_id..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م5' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م5')
database:set(bot_id..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م6' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م6')
database:set(bot_id..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م7' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م7')
database:set(bot_id..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م8' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م8')
database:set(bot_id..'help8'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م9' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م9')
database:set(bot_id..'help9'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م10' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '♡∶ الان يمكنك ارسال الكليشه م10')
database:set(bot_id..'help10'..msg.sender_user_id_,'true')
return false 
end


if text == 'م1' or text == 'م2' or text == 'م3' or text == 'م4' or text == 'م5' then
send(msg.chat_id_, msg.id_,"مرحبا . اكتب `الاوامر` وتحكم في الكيبورد الكلايش")
return false
end
if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'♡ عذرا الاوامر هذا لا تخصك ') 
return false
end
local Text =[[
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶  1 ⤙ لعرض اوامر الحمايه
♡∶  2 ⤙ لعرض اوامر الادمنيه
♡∶  3 ⤙ لعرض اوامر المدراء
♡∶  4 ⤙ لعرض اوامر المنشئين
♡∶  5 ⤙ لعرض اوامر المطورين
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
[♡ ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ](t.me/SoalfLove)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '1', callback_data="/help1"},{text = '2', callback_data="/help2"},{text = '3', callback_data="/help3"}},
{{text = '4', callback_data="/help4"},{text = '5', callback_data="/help5"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end



if text == "تعطيل الزخرفه" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_, '*♡∶ تم تعطيل الزخرفه*')
database:set(bot_id.." amir:zhrf_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الزخرفه" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ تم تفعيل الزخرفه*')
database:set(bot_id.." amir:zhrf_Bots"..msg.chat_id_,"open")
end
if text and text:match("^زخرفه (.*)$") and database:get(bot_id.." amir:zhrf_Bots"..msg.chat_id_) == "open" then
local TextZhrfa = text:match("^زخرفه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
zh = https.request('https://mode-dev.tk/api3/nigga.php?en='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n*♡∶ قائمه الزخرفه* \nٴ♡∶⫷━━━━━━━𝘼𝙆━━━━━━━⫸♡∶○ٴ \n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  "..v.." \n"
end
send(msg.chat_id_, msg.id_, t..'ٴ♡∶⫷━━━━━━━𝘼𝙆━━━━━━━⫸♡∶○ٴ\n♡∶ て [𝘈𝘌𝘒𝘈𝘕 𝘊𝘩𝘢𝘯𝘯𝘦𝘭](t.me/SoalfLove)➤ ')
end

if text == "تعطيل حساب العمر" and Mod(msg) then
send(msg.chat_id_, msg.id_, '*♡∶ تم تعطيل حساب العمر*')
database:set(bot_id.." amir:age_Bots"..msg.chat_id_,"close")
end
if text == "تعطيل حساب العمر" and Mod(msg) then
send(msg.chat_id_, msg.id_, '*♡∶ تم تعطيل حساب العمر*')
database:set(bot_id.." amir:age_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل حساب العمر" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ تم تفعيل حساب العمر*')
database:set(bot_id.." amir:age_Bots"..msg.chat_id_,"open")
end
if text and text:match("^احسب (.*)$") and database:get(bot_id.." amir:age_Bots"..msg.chat_id_) == "open" then
local Textage = text:match("^احسب (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
ge = https.request('https://mode-dev.tk/Api1/niggaapi.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل الافلام" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_, '*♡∶ تم تعطيل الافلام*')
database:set(bot_id.."AEKAN:movie_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الافلام" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'*♡∶ تم تفعيل الافلام*')
database:set(bot_id.."AEKAN:movie_bot"..msg.chat_id_,"open")
end
if text and text:match("^فلم (.*)$") and database:get(bot_id.."AEKAN:movie_bot"..msg.chat_id_) == "open" then
local Textm = text:match("^فلم (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
data,res = https.request('https://forhassan.ml/Black/movie.php?serch='..URL.escape(Textm)..'')
if res == 200 then
getmo = json:decode(data)
if getmo.Info == true then
local Text ='قصه الفلم'..getmo.info
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مشاهده الفلم بجوده 240',url=getmo.sd}},
{{text = 'مشاهده الفلم بجوده 480', url=getmo.Web},{text = 'مشاهده الفلم بجوده 1080', url=getmo.hd}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
------------------------------------------------------------
if text and text:match('^الحساب (%d+)$') then
local id = text:match('^الحساب (%d+)$')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local text = 'اضغط لمشاهده الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
local function oChat(chat_id,cb)
tdcli_function ({
ID = "OpenChat",
chat_id_ = chat_id
}, cb, nil)
end
if text == "صلاحياته" and tonumber(msg.reply_to_message_id_) > 0 then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
------------------------------------------------------------------------
if text == "صلاحياتي" then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
------------------------------------------------------------------------
if text and text:match('^صلاحياته @(.*)') then  
local username = text:match('صلاحياته @(.*)')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"*♡∶ المعرف غير صحيح*")   
return false  end   

Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if text == "شنو رئيك بهذا" or text == "شنو رئيك بيه" then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ادب سز يباوع على البنات 😂🥺"," مو خوش ولد 😶","زاحف وما احبه 😾😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "شنو رئيك بهاي" or text == "شنو رئيك بيها" then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دور حلوين 🤕😹","جكمه وصخه عوفها ☹️😾","حقيره ومتكبره 😶😂"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" or text == "رزله" then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ولك هيو لتندك بسيادك لو بهاي 👞👈","ميستاهل اتعب روحي وياه لانه عار","عوفه يروحي لاتنزل لمستواه🤣"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مصه" or text == "بوسه" then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح💋😘","مابوس ولي😌😹","خدك/ج نضيف 😂","البوسه بالف حمبي 🌝💋","خلي يزحفلي وابوسه 🙊😻","كل شويه ابوسه كافي 😏","ماابوسه والله هذا زاحف🦎","محح هاي لحاته صاكه💋"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == 'تفعيل الردود' and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'lock:reply'..msg.chat_id_)  
Text = '*♡∶ تم تفعيل الردود*'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هناا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'lock:reply'..msg.chat_id_,true)  
Text = '\n*♡∶ تم تعطيل الردود*'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'رابط الحذف' or text == 'رابط حذف' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
t =[[
*♡∶ رابط الحذف في جميع مواقع التواصل
♡∶ فكر قبل لا تتسرع*
ٴ⫷━━━━━━━𝘼𝙆━━━━━━━⫸ٴ
 *♡∶ رابط حذف*  [Telegram](https://my.telegram.org/auth?to=delete) ܁
 *♡∶ رابط حذف* [instagram](https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/) ܁
 *♡∶ رابط حذف* [Facebook](https://www.facebook.com/help/deleteaccount) ܁
 *♡∶ رابط حذف* [Snspchat](https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount) ܁
]]
send(msg.chat_id_, msg.id_,t) 
return false
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end


if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local From_id = data.id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local DAata = data.payload_.data_
if Mod(data) then  
sender_id  = DAata:match("(%d+)")  
ta = DAata:gsub(data.sender_user_id_,'')
if ta == "LS0" then   ---LS0
if tonumber(data.sender_user_id_) == tonumber(sender_id) then
if database:get(bot_id.."Lock:text"..Chat_id) == true then
te = "الدردشه ∶ ✘ ∶ بالمسح"
else
te =  "الدردشه ∶ ✔"   
end        
if database:get(bot_id.."Lock:AddMempar"..Chat_id) == "kick" then
AddM = "الاضافه ∶ ✘ ∶ بالطرد"
else
AddM =  "الاضافه ∶ ✔"   
end        
if database:get(bot_id.."Lock:Join"..Chat_id) == "kick" then
Jo = "الدخول ∶ ✘ ∶ بالطرد"
else
Jo =  "الدخول ∶ ✔"   
end        
if database:get(bot_id.."Lock:Bot:kick"..Chat_id) == "del" then
Botki = "البوتات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Bot:kick:"..Chat_id) == "kick" then
Botki = "البوتات ∶ ✘ ∶ بالطرد"
else
Botki =  "البوتات ∶ ✔"   
end        
if database:get(bot_id.."Lock:tagservr"..Chat_id) == "del" then
tag = "الاشعارات ∶ ✘ ∶ بالمسح"
else
tag =  "الاشعارات ∶ ✔"   
end        
if database:get(bot_id.."lockpin"..Chat_id) == true then
pin = "التثبيت ∶ ✘ ∶ بالمسح"
else
pin =  "التثبيت ∶ ✔"   
end        
if database:get(bot_id.."Lock:edit"..Chat_id) == true then
edit = "التعديل ∶ ✘ ∶ بالمسح"
else
edit =  "التعديل ∶ ✔"   
end        
if database:get(bot_id.."Lock:edit"..Chat_id) == true then
edi = "تعديل الميديا ∶ ✘ ∶ بالمسح"
else
edi =  "تعديل الميديا ∶ ✔"   
end        
if database:get(bot_id.."Lock:Link"..Chat_id) == "del" then
Link = "الروابط ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Link:"..Chat_id) == "kick" then
Link = "الروابط ∶ ✘ ∶ بالطرد"
elseif database:get(bot_id.."Lock:Link:"..Chat_id) == "ktm" then
Link = "الروابط ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Link:"..Chat_id) == "ked" then
Link = "الروابط ∶ ✘ ∶ بالتقييد"
else
Link =  "الروابط ∶ ✔"   
end        
if database:get(bot_id.."Lock:User:Name"..Chat_id) == "del" then
usNa = "المعرفات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:User:Name:"..Chat_id) == "kick" then
usNa = "المعرفات ∶ ✘ ∶ بالطرد"
elseif database:get(bot_id.."Lock:User:Name:"..Chat_id) == "ktm" then
usNa = "المعرفات ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:User:Name:"..Chat_id) == "ked" then
usNa = "المعرفات ∶ ✘ ∶ بالتقييد"
else
usNa =  "المعرفات ∶ ✔"   
end        
keyboard = {} 
keyboard.inline_keyboard = {
{{text =te,callback_data=data.sender_user_id_.."TR:Lock:text"},{text =usNa,callback_data=data.sender_user_id_.."Lock:User:Name"}},
{{text =AddM,callback_data=data.sender_user_id_.."Lock:AddMempar"},{text =Link,callback_data=data.sender_user_id_.."Lock:Link"}},
{{text =Jo,callback_data=data.sender_user_id_.."Lock:Join"},{text =edi,callback_data=data.sender_user_id_.."Lock:edit"}},
{{text =Botki,callback_data=data.sender_user_id_.."Lock:Bot:kick"},{text =edit,callback_data=data.sender_user_id_.."TR:Lock:pin"}},
{{text =tag,callback_data=data.sender_user_id_.."Lock:tagservr"},{text =pin,callback_data=data.sender_user_id_.."TR:Lock:pin"}},
{{text ="التالي ⊁ .",callback_data=data.sender_user_id_.."LS1"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageReplyMarkup?chat_id='..Chat_id..'&message_id='..msg_idd..'&reply_markup='..JSON.encode(keyboard)) 
else 
return https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape('♡∶ عذرا الامر ليس لك .').."&show_alert=true")
end
end
sender_id  = DAata:match("(%d+)")  
ta = DAata:gsub(data.sender_user_id_,'')
if ta == "LS1" then   ---LS1
if tonumber(data.sender_user_id_) == tonumber(sender_id) then
if database:get(bot_id.."lock:Fshar"..Chat_id) == true then
ar = "الفارسيه ∶ ✘ ∶ بالمسح"
else
ar =  "الفارسيه ∶ ✔"   
end        
if database:get(bot_id.."lock:Fshar"..Chat_id) == true then
arw = "الفشار ∶ ✘ ∶ بالمسح"
else
arw =  "الفشار ∶ ✔"   
end        
if database:hget(bot_id.."flooding:settings:"..Chat_id, "flood") == "kick" then     
flood = "التكرار ∶ ✘ ∶ بالطرد"
elseif database:hget(bot_id.."flooding:settings:"..Chat_id,"flood") == "keed" then     
flood = "التكرار ∶ ✘ ∶ بالتقييد"
elseif database:hget(bot_id.."flooding:settings:"..Chat_id,"flood") == "mute" then     
flood = "التكرار ∶ ✘ ∶ بالكتم"
elseif database:hget(bot_id.."flooding:settings:"..Chat_id,"flood") == "del" then     
flood = "التكرار ∶ ✘ ∶ بالمسح"
else     
flood =  "التكرار ∶ ✔"   
end
if database:get(bot_id.."Lock:hashtak"..Chat_id) == "del" then
ash = "التاك ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:hashtak"..Chat_id) == "ked" then 
ash = "التاك ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:hashtak"..Chat_id) == "ktm" then 
ash = "التاك ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:hashtak"..Chat_id) == "kick" then 
ash = "التاك ∶ ✘ ∶ بالطرد"
else
ash =  "التاك ∶ ✔"   
end    
if database:get(bot_id.."Lock:Cmd"..Chat_id) == "del" then
Cmd = "الشارحه ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Cmd"..Chat_id) == "ked" then 
Cmd = "الشارحه ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Cmd"..Chat_id) == "ktm" then 
Cmd = "الشارحه ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Cmd"..Chat_id) == "kick" then 
Cmd = "الشارحه ∶ ✘ ∶ بالطرد"
else
Cmd =  "الشارحه ∶ ✔"   
end    
if database:get(bot_id.."Lock:Photo"..Chat_id) == "del" then
hot = "الصور ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Photo"..Chat_id) == "ked" then 
hot = "الصور ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Photo"..Chat_id) == "ktm" then 
hot = "الصور ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Photo"..Chat_id) == "kick" then 
hot = "الصور ∶ ✘ ∶ بالطرد"
else
hot =  "الصور ∶ ✔"   
end    
if database:get(bot_id.."Lock:Video"..Chat_id) == "del" then
de = "الفيديو ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Video"..Chat_id) == "ked" then 
de = "الفيديو ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Video"..Chat_id) == "ktm" then 
de = "الفيديو ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Video"..Chat_id) == "kick" then 
de = "الفيديو ∶ ✘ ∶ بالطرد"
else
de =  "الفيديو ∶ ✔"   
end    
if database:get(bot_id.."Lock:Animation"..Chat_id) == "del" then
Anima = "المتحركه ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Animation"..Chat_id) == "ked" then 
Anima = "المتحركه ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Animation"..Chat_id) == "ktm" then 
Anima = "المتحركه ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Animation"..Chat_id) == "kick" then 
Anima = "المتحركه ∶ ✘ ∶ بالطرد"
else
Anima =  "المتحركه ∶ ✔"   
end    
if database:get(bot_id.."Lock:Audio"..Chat_id) == "del" then
Audi = "الاغاني ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Audio"..Chat_id) == "ked" then 
Audi = "الاغاني ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Audio"..Chat_id) == "ktm" then 
Audi = "الاغاني ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Audio"..Chat_id) == "kick" then 
Audi = "الاغاني ∶ ✘ ∶ بالطرد"
else
Audi =  "الاغاني ∶ ✔"   
end    
if database:get(bot_id.."Lock:vico"..Chat_id) == "del" then
vico = "الاغاني ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:vico"..Chat_id) == "ked" then 
vico = "الاغاني ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:vico"..Chat_id) == "ktm" then 
vico = "الاغاني ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:vico"..Chat_id) == "kick" then 
vico = "الاغاني ∶ ✘ ∶ بالطرد"
else
vico =  "الاغاني ∶ ✔"   
end    
if database:get(bot_id.."Lock:Keyboard"..Chat_id) == "del" then
Keyboard = "الكيبورد ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Keyboard"..Chat_id) == "ked" then 
Keyboard = "الكيبورد ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Keyboard"..Chat_id) == "ktm" then 
Keyboard = "الكيبورد ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Keyboard"..Chat_id) == "kick" then 
Keyboard = "الكيبورد ∶ ✘ ∶ بالطرد"
else
Keyboard =  "الكيبورد ∶ ✔"   
end    
if database:get(bot_id.."Lock:Sticker"..Chat_id) == "del" then
Sti = "الملصقات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Sticker"..Chat_id) == "ked" then 
Sti = "الملصقات ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Sticker"..Chat_id) == "ktm" then 
Sti = "الملصقات ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Sticker"..Chat_id) == "kick" then 
Sti = "الملصقات ∶ ✘ ∶ بالطرد"
else
Sti =  "الملصقات ∶ ✔"   
end    
if database:get(bot_id.."Lock:forward"..Chat_id) == "del" then
orwa = "التوجيه ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:forward"..Chat_id) == "ked" then 
orwa = "التوجيه ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:forward"..Chat_id) == "ktm" then 
orwa = "التوجيه ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:forward"..Chat_id) == "kick" then 
orwa = "التوجيه ∶ ✘ ∶ بالطرد"
else
orwa =  "التوجيه ∶ ✔"   
end    
if database:get(bot_id.."Lock:Document"..Chat_id) == "del" then
Docu = "الملفات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Document"..Chat_id) == "ked" then 
Docu = "الملفات ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Document"..Chat_id) == "ktm" then 
Docu = "الملفات ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Document"..Chat_id) == "kick" then 
Docu = "الملفات ∶ ✘ ∶ بالطرد"
else
Docu =  "الملفات ∶ ✔"   
end    
keyboard = {} 
keyboard.inline_keyboard = {
{{text =Sti,callback_data=data.sender_user_id_.."Lock:Sticker"},{text =Keyboard,callback_data=data.sender_user_id_.."Lock:Keyboard"}},
{{text =Docu,callback_data=data.sender_user_id_.."Lock:Document"},{text =orwa,callback_data=data.sender_user_id_.."Lock:forward"}},
{{text =ar,callback_data=data.sender_user_id_.."TR:lock:Fshar"},{text =arw,callback_data=data.sender_user_id_.."TR:lock:Fshar"}},
{{text =flood,callback_data=data.sender_user_id_.."flooding:settings"},{text =ash,callback_data=data.sender_user_id_.."Lock:hashtak"}},
{{text =Cmd,callback_data=data.sender_user_id_.."Lock:Cmd"},{text =vico,callback_data=data.sender_user_id_.."Lock:vico"}},
{{text =hot,callback_data=data.sender_user_id_.."Lock:Photo"},{text =de,callback_data=data.sender_user_id_.."Lock:Video"}},
{{text =Anima,callback_data=data.sender_user_id_.."Lock:Animation"},{text =Audi,callback_data=data.sender_user_id_.."Lock:Audio"}},
{{text ="التالي ⊁ .",callback_data=data.sender_user_id_.."LS2"},{text ="السابق ⊀ .",callback_data=data.sender_user_id_.."LS0"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageReplyMarkup?chat_id='..Chat_id..'&message_id='..msg_idd..'&reply_markup='..JSON.encode(keyboard)) 
else 
return https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape('♡∶ عذرا الامر ليس لك .').."&show_alert=true")
end
end
sender_id  = DAata:match("(%d+)")  
ta = DAata:gsub(data.sender_user_id_,'')
if ta == "LS2" then   ---LS2
if tonumber(data.sender_user_id_) == tonumber(sender_id) then
if database:get(bot_id.."Lock:Unsupported"..Chat_id) == "del" then
rted = "السيلفي ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Unsupported"..Chat_id) == "ked" then 
rted = "السيلفي ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Unsupported"..Chat_id) == "ktm" then 
rted = "السيلفي ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Unsupported"..Chat_id) == "kick" then 
rted = "السيلفي ∶ ✘ ∶ بالطرد"
else
rted =  "السيلفي ∶ ✔"   
end    
if database:get(bot_id.."Lock:Markdaun"..Chat_id) == "del" then
daun = "الماركداون ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Markdaun"..Chat_id) == "ked" then 
daun = "الماركداون ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Markdaun"..Chat_id) == "ktm" then 
daun = "الماركداون ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Markdaun"..Chat_id) == "kick" then 
daun = "الماركداون ∶ ✘ ∶ بالطرد"
else
daun =  "الماركداون ∶ ✔"   
end   
if database:get(bot_id.."Lock:geam"..Chat_id) == "del" then
eam = "الالعاب ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:geam"..Chat_id) == "ked" then 
eam = "الالعاب ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:geam"..Chat_id) == "ktm" then 
eam = "الالعاب ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:geam"..Chat_id) == "kick" then 
eam = "الالعاب ∶ ✘ ∶ بالطرد"
else
eam =  "الالعاب ∶ ✔"   
end    
if database:get(bot_id.."Lock:Spam"..Chat_id) == "del" then
pam = "الكلايش ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Spam"..Chat_id) == "ked" then 
pam = "الكلايش ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Spam"..Chat_id) == "ktm" then 
pam = "الكلايش ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Spam"..Chat_id) == "kick" then 
pam = "الكلايش ∶ ✘ ∶ بالطرد"
else
pam =  "الكلايش ∶ ✔"   
end    
if database:get(bot_id.."Lock:Contact"..Chat_id) == "del" then
tact = "الجهات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Contact"..Chat_id) == "ked" then 
tact = "الجهات ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Contact"..Chat_id) == "ktm" then 
tact = "الجهات ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Contact"..Chat_id) == "kick" then 
tact = "الجهات ∶ ✘ ∶ بالطرد"
else
tact =  "الجهات ∶ ✔"   
end    
if database:get(bot_id.."Lock:Inlen"..Chat_id) == "del" then
len = "الانلاين ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Inlen"..Chat_id) == "ked" then 
len = "الانلاين ∶ ✘ ∶ بالتقييد"
elseif database:get(bot_id.."Lock:Inlen"..Chat_id) == "ktm" then 
len = "الانلاين ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Inlen"..Chat_id) == "kick" then 
len = "الانلاين ∶ ✘ ∶ بالطرد"
else
len =  "الانلاين ∶ ✔"   
end   
if database:get(bot_id.."Lock:Xn"..Chat_id) == "del" then
Xn = "الاباحي ∶ ✘ ∶ بالمسح"
else
Xn =  "الاباحي ∶ ✔"   
end    
keyboard = {} 
keyboard.inline_keyboard = {
{{text =rted,callback_data=data.sender_user_id_.."Lock:Unsupported"},{text =Xn,callback_data=data.sender_user_id_.."Lock:Xn"}},
{{text =daun,callback_data=data.sender_user_id_.."Lock:Markdaun"},{text =len,callback_data=data.sender_user_id_.."Lock:Inlen"}},
{{text =eam,callback_data=data.sender_user_id_.."Lock:geam"},{text =tact,callback_data=data.sender_user_id_.."Lock:Contact"}},
{{text =pam,callback_data=data.sender_user_id_.."Lock:Spam"}},
{{text ="السابق ⊀ .",callback_data=data.sender_user_id_.."LS1"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageReplyMarkup?chat_id='..Chat_id..'&message_id='..msg_idd..'&reply_markup='..JSON.encode(keyboard)) 
else 
return https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape('♡∶ عذرا الامر ليس لك .').."&show_alert=true")
end
end
end
if Mod(data) then  
sender_match  = DAata:match("(%d+)")  
get_r = DAata:gsub(sender_match,''):gsub("TR:",'')
get_database = DAata:gsub(sender_match,'')
if DAata and get_database:match("^Lock:(.*)$") then   
if tonumber(data.sender_user_id_) == tonumber(sender_match) then
if not database:get(bot_id..""..get_database..""..Chat_id) then ---not
database:set(bot_id..""..get_database..""..Chat_id,"del") 
elseif database:get(bot_id..""..get_database..""..Chat_id)== "del" then
database:set(bot_id..""..get_database..""..Chat_id,"ktm") 
elseif database:get(bot_id..""..get_database..""..Chat_id)== "ktm" then
database:set(bot_id..""..get_database..""..Chat_id,"kick") 
elseif database:get(bot_id..""..get_database..""..Chat_id)== "kick" then
database:set(bot_id..""..get_database..""..Chat_id,"ked") 
elseif database:get(bot_id..""..get_database..""..Chat_id)== "ked" then
database:del(bot_id..""..get_database..""..Chat_id)  
end ---notget
if get_database == "flooding:settings" then
if not database:hget(bot_id.."flooding:settings:"..Chat_id,"flood") then    
database:hset(bot_id.."flooding:settings:"..Chat_id ,"flood","del")  
elseif database:hget(bot_id.."flooding:settings:"..Chat_id,"flood") == "del" then     
database:hset(bot_id.."flooding:settings:"..Chat_id ,"flood","ktm") 
elseif database:hget(bot_id.."flooding:settings:"..Chat_id,"flood") == "ktm" then     
database:hset(bot_id.."flooding:settings:"..Chat_id ,"flood","ked") 
elseif database:hget(bot_id.."flooding:settings:"..Chat_id,"flood") == "ked" then     
database:hset(bot_id.."flooding:settings:"..Chat_id ,"flood","ked") 
elseif database:hget(bot_id.."flooding:settings:"..Chat_id,"kick") == "kick" then     
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
end ---notget
end ---get_database
if DAata and get_database:match("^TR:(.*)$") then   
if not database:get(bot_id..""..get_r..""..Chat_id) then ---not
database:set(bot_id..""..get_r..""..Chat_id,true) 
elseif database:get(bot_id..""..get_r..""..Chat_id)== true then
database:del(bot_id..""..get_r..""..Chat_id) 
end ---TR
end ---get_r
if database:get(bot_id.."Lock:text"..Chat_id) == true then
te = "الدردشه ∶ ✘ ∶ بالمسح"
else
te =  "الدردشه ∶ ✔"   
end        
if database:get(bot_id.."Lock:AddMempar"..Chat_id) == "kick" then
AddM = "الاضافه ∶ ✘ ∶ بالطرد"
else
AddM =  "الاضافه ∶ ✔"   
end        
if database:get(bot_id.."Lock:Join"..Chat_id) == "kick" then
Jo = "الدخول ∶ ✘ ∶ بالطرد"
else
Jo =  "الدخول ∶ ✔"   
end        
if database:get(bot_id.."Lock:Bot:kick"..Chat_id) == "del" then
Botki = "البوتات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Bot:kick:"..Chat_id) == "kick" then
Botki = "البوتات ∶ ✘ ∶ بالطرد"
else
Botki =  "البوتات ∶ ✔"   
end        
if database:get(bot_id.."Lock:tagservr"..Chat_id) == "del" then
tag = "الاشعارات ∶ ✘ ∶ بالمسح"
else
tag =  "الاشعارات ∶ ✔"   
end        
if database:get(bot_id.."lockpin"..Chat_id) == true then
pin = "التثبيت ∶ ✘ ∶ بالمسح"
else
pin =  "التثبيت ∶ ✔"   
end        
if database:get(bot_id.."Lock:edit"..Chat_id) == true then
edit = "التعديل ∶ ✘ ∶ بالمسح"
else
edit =  "التعديل ∶ ✔"   
end        
if database:get(bot_id.."Lock:edit"..Chat_id) == true then
edi = "تعديل الميديا ∶ ✘ ∶ بالمسح"
else
edi =  "تعديل الميديا ∶ ✔"   
end        
if database:get(bot_id.."Lock:Link"..Chat_id) == "del" then
Link = "الروابط ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:Link:"..Chat_id) == "kick" then
Link = "الروابط ∶ ✘ ∶ بالطرد"
elseif database:get(bot_id.."Lock:Link:"..Chat_id) == "ktm" then
Link = "الروابط ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:Link:"..Chat_id) == "ked" then
Link = "الروابط ∶ ✘ ∶ بالتقييد"
else
Link =  "الروابط ∶ ✔"   
end        
if database:get(bot_id.."Lock:User:Name"..Chat_id) == "del" then
usNa = "المعرفات ∶ ✘ ∶ بالمسح"
elseif database:get(bot_id.."Lock:User:Name:"..Chat_id) == "kick" then
usNa = "المعرفات ∶ ✘ ∶ بالطرد"
elseif database:get(bot_id.."Lock:User:Name:"..Chat_id) == "ktm" then
usNa = "المعرفات ∶ ✘ ∶ بالكتم"
elseif database:get(bot_id.."Lock:User:Name:"..Chat_id) == "ked" then
usNa = "المعرفات ∶ ✘ ∶ بالتقييد"
else
usNa =  "المعرفات ∶ ✔"   
end        
keyboard = {} 
keyboard.inline_keyboard = {
{{text =te,callback_data=data.sender_user_id_.."TR:Lock:text"},{text =usNa,callback_data=data.sender_user_id_.."Lock:User:Name"}},
{{text =AddM,callback_data=data.sender_user_id_.."Lock:AddMempar"},{text =Link,callback_data=data.sender_user_id_.."Lock:Link"}},
{{text =Jo,callback_data=data.sender_user_id_.."Lock:Join"},{text =edi,callback_data=data.sender_user_id_.."Lock:edit"}},
{{text =Botki,callback_data=data.sender_user_id_.."Lock:pin"},{text =edit,callback_data=data.sender_user_id_.."Lock:edit"}},
{{text =tag,callback_data=data.sender_user_id_.."Lock:tagservr"},{text =pin,callback_data=data.sender_user_id_.."lockpin"}},
{{text ="التالي ⊁ .",callback_data=data.sender_user_id_.."LS1"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageReplyMarkup?chat_id='..Chat_id..'&message_id='..msg_idd..'&reply_markup='..JSON.encode(keyboard)) 
else 
return https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape('♡∶ عذرا الامر ليس لك .').."&show_alert=true")
end
end
end
if DAata == '/help1' then
if not Mod(data) then
local notText = '♡ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
♡∶اوامر حمايه المجموعه
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶قفل/فتح + الاوامر الادناه 
♡∶قفل/فتح + الامر بالتقيد • بالطرد • بالكتم
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶الروابط
♡∶المعرف
♡∶التاك
♡∶الشارحه
♡∶التعديل
♡∶التثبيت
♡∶المتحركه
♡∶الملفات
♡∶الصور
﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶الملصقات
♡∶الفيديو
♡∶الانلاين
♡∶الدردشه
♡∶التوجيه
♡∶الاغاني
♡∶الصوت
♡∶الجهات
♡∶الاشعارات
﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶الماركداون
♡∶البوتات
♡∶التكرار
♡∶الكلايش
♡∶السيلفي
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
[♡ ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ](t.me/SoalfLove)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1', callback_data="/help1"},{text = '2', callback_data="/help2"},{text = '3', callback_data="/help3"},
},
{
{text = '4', callback_data="/help4"},{text = '5', callback_data="/help5"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if DAata == '/help2' then
if not Mod(data) then
local notText = '♡ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
♡∶اوامر الادمنيه
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊ 
 - تفعيل/تعطيل الترحيب
 - اضف /مسح صلاحيه
♡∶وضع تكرار + العدد
♡∶رفع/تنزيل مميز
♡∶عدد الكروب
♡∶تاك للكل
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶كتم
♡∶حظر
♡∶طرد
♡∶منع
♡∶تقيد
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
 - المكتومين
♡∶المحظورين
♡∶المميزين
♡∶الصلاحيات
♡∶قائمه المنع
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶الغاء كتم
♡∶الغاء حظر
♡∶الغاء منع
♡∶الغاء تقيد
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶الغاء تثبيت
♡∶الاعدادات
♡∶تثبيت
♡∶الرابط
♡∶القوانين
♡∶الترحيب
♡∶ايدي
♡∶جهاتي
♡∶سحكاتي
♡∶رسائلي
♡∶كشف البوتات
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶وضع اسم
♡∶وضع رابط
♡∶وضع صوره
♡∶وضع وصف
♡∶وضع قوانين
♡∶وضع ترحيب
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶مسح قائمه المنع
♡∶مسح المحظورين
♡∶مسح المميزين
♡∶مسح المكتومين
♡∶مسح المطرودين
♡∶مسح القوانين
♡∶مسح البوتات
♡∶مسح الصوره
♡∶مسح الصلاحيات
♡∶مسح الرابط
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
[♡ ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ](t.me/SoalfLove)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1', callback_data="/help1"},{text = '2', callback_data="/help2"},{text = '3', callback_data="/help3"},
},
{
{text = '4', callback_data="/help4"},{text = '5', callback_data="/help5"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if DAata == '/help3' then
if not Mod(data) then
local notText = '♡ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
♡∶اوامر المدير
﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶رفع القيود
♡∶كشف القيود
♡∶تنزيل الكل
♡∶رفع ادمن
♡∶ تنزيل ادمن
♡∶رفع الادمنيه
♡∶مسح الادمنيه
♡∶الادمنيه
♡∶ صلاحياته
♡∶ صلاحياتي
♡∶تعين الايدي
♡∶تغير الايدي
♡∶مسح الايدي
♡∶ردود المدير
♡∶اضف رد
♡∶حذف رد
♡∶تنظيف + عدد
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶تفعيل/تعطيل الرفع
♡∶تفعيل/تعطيل الايدي
♡∶تفعيل/تعطيل الابراج
♡∶تفعيل/تعطيل اطردني
♡∶تفعيل/تعطيل الزخرفه
♡∶تفعيل/تعطيل ردود المدير
♡∶تفعيل/تعطيل حساب العمر
♡∶تفعيل/تعطيل ردود المطور
♡∶تفعيل/تعطيل الحظر/الطرد
♡∶تفعيل/تعطيل اللعبه/الالعاب
♡∶تفعيل/تعطيل الايدي بالصوره
♡∶تفعيل/تعطيل الرابط/جلب الرابط
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
[♡ ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ](t.me/SoalfLove)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1', callback_data="/help1"},{text = '2', callback_data="/help2"},{text = '3', callback_data="/help3"},
},
{
{text = '4', callback_data="/help4"},{text = '5', callback_data="/help5"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if DAata == '/help4' then
if not Mod(data) then
local notText = '♡ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
♡∶اوامر المنشئين الاساسين 
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶رفع/تنزيل منشئ اساسي
♡∶رفع/تنزيل منشئ
♡∶المنشئين
♡∶مسح المنشئين
♡∶مسح ردود المدير
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶اوامر المنشئين
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶رفع/تنزيل مدير
♡∶المدراء
♡∶مسح المدراء
♡∶تعين/مسح الايدي
♡∶اضف/حذف امر
♡∶الاوامر المضافه
♡∶حذف/مسح الاوامر المضافه
♡∶اضف رسائل + العدد بالرد
♡∶اضف مجوهرات + العدد بالرد
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
[♡ ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ](t.me/SoalfLove)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1', callback_data="/help1"},{text = '2', callback_data="/help2"},{text = '3', callback_data="/help3"},
},
{
{text = '4', callback_data="/help4"},{text = '5', callback_data="/help5"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if DAata == '/help5' then
if not Sudo(data) then
local notText = '♡ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
♡∶اوامر المطور الاساسي  
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶تحديث
♡∶الملفات
♡∶المتجر
♡∶حظر عام
♡∶الغاء العام
♡∶ الثانويين
♡∶ اضف مطور ثانوي
♡∶ حذف مطور ثانوي
♡∶المطورين
♡∶ردود المطور
♡∶اوامر المطور
♡∶اضف رد للكل
♡∶حذف رد للكل
♡∶ مسح الثانويين
♡∶مسح المطورين
♡∶مسح قائمه العام
♡∶تعطيل الاذاعه
♡∶تفعيل الاذاعه
♡∶تعطيل الاذاعه
♡∶تفعيل المغادرة
♡∶ تحديث السورس
♡∶مسح ردود المطور
♡∶مسح جميع الملفات
♡∶اضف /حذف مطور
♡∶وضع كليشه المطور
♡∶حذف كليشه المطور
♡∶تفعيل البوت الخدمي
♡∶تعطيل البوت الخدمي
♡∶تفعيل ملف + اسم الملف
♡∶تعطيل ملف + اسم الملف
♡∶ تعين عدد الاعضاء + العدد
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
♡∶غادر 
♡∶اذاعه 
♡∶رفع منشئ 
♡∶اذاعه خاص 
♡∶الاحصائيات 
♡∶غادر + الايدي
♡∶تفعيل /تعطيل
♡∶اذاعه بالتوجيه
♡∶اذاعه بالتثبيت 
♡∶المنشئين الاساسين 
♡∶رفع/تنزيل منشئ اساسي
♡∶مسح المنشئين الاساسين
 ﹊﹊﹊﹊﹊﹊﹊﹊﹊
[♡ ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ](t.me/SoalfLove)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '1', callback_data="/help1"},{text = '2', callback_data="/help2"},{text = '3', callback_data="/help3"},
},
{
{text = '4', callback_data="/help4"},{text = '5', callback_data="/help5"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if DAata == '/help' then
if not Mod(data) then
local notText = '♡ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
♡∶  1 ⤙ لعرض اوامر الحمايه
♡∶  2 ⤙ لعرض اوامر الادمنيه
♡∶  3 ⤙ لعرض اوامر المدراء
♡∶  4 ⤙ لعرض اوامر المنشئين
♡∶  5 ⤙ لعرض اوامر المطورين
[♡ ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ](t.me/SoalfLove)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '1', callback_data="/help1"},{text = '2', callback_data="/help2"},{text = '3', callback_data="/help3"}},
{{text = '4', callback_data="/help4"},{text = '5', callback_data="/help5"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if DAata and DAata:match("^animation(.*)$") and Mod(data) then  
idch = DAata:match("-100(%d+)")
local idchci = "-100"..idch
local animation = DAata:match("^animation(.*)$"):gsub('chatid',''):gsub('chatid',''):gsub(idch,''):gsub('-100','')
local Text ="♡∶ تم الغاء منعها بنجاح"
inline = {
{{text = '♡∶  ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ  .',url='http://t.me/SoalfLove'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inlin_key(Chat_id,Text,inline)
database:srem(bot_id.."List:Filter:Animation"..idchci,animation)  
end
if DAata and DAata:match("^pito(.*)$") and Mod(data) then  
local idchci = database:get(bot_id.."Filter:msg")
local photo = DAata:match("^pito(.*)$")
local Text ="♡∶ تم الغاء منعها بنجاح"
inline = {
{{text = '♡∶  ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ  .',url='http://t.me/SoalfLove'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inlin_key(Chat_id,Text,inline)
database:srem(bot_id.."List:Filter:Photo"..idchci,photo)  
end
if DAata and DAata:match("^Sticker(.*)$") and Mod(data) then  
idch = DAata:match("-100(%d+)")
local idchci = "-100"..idch
local Sticker = DAata:match("^Sticker(.*)$"):gsub('chatid',''):gsub('chatid',''):gsub(idch,''):gsub('-100','')
local Text ="♡∶ تم الغاء منعه بنجاح"
inline = {
{{text = '♡∶  ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ  .',url='http://t.me/SoalfLove'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inlin_key(Chat_id,Text,inline)
database:srem(bot_id.."List:Filter:Sticker"..idchci,Sticker)  
end
if DAata and DAata:match("^delallSticker(.*)$") and Mod(data) then  
local delallSticker = DAata:match("^delallSticker(.*)$")
local Text ="♡∶ تم الغاء منع كل المتحركات"
inline = {
{{text = '♡∶  ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ  .',url='http://t.me/SoalfLove'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inlin_key(Chat_id,Text,inline)
local listSticker = database:smembers(bot_id.."List:Filter:Sticker"..delallSticker)  
for k,v in pairs(listSticker) do  
database:srem(bot_id.."List:Filter:Sticker"..delallSticker,v)  
end  
end
if DAata and DAata:match("^delallanimation(.*)$") and Mod(data) then  
local delallmation = DAata:match("^delallanimation(.*)$")
local Text ="♡∶ تم الغاء منع كل المتحركات"
inline = {
{{text = '♡∶  ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ  .',url='http://t.me/SoalfLove'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inlin_key(Chat_id,Text,inline)
local listAnimation = database:smembers(bot_id.."List:Filter:Animation"..delallmation)  
for k,v in pairs(listAnimation) do  
database:srem(bot_id.."List:Filter:Animation"..delallmation,v)  
end  
end
if DAata and DAata:match("^delallph(.*)$") and Mod(data) then  
local delallph = DAata:match("^delallph(.*)$")
local Text ="♡∶ تم الغاء منع كل الصور"
inline = {
{{text = '♡∶  ϨⲞⴑꞄⲤⲈ ⲀⲈⲔⲀⲚ  .',url='http://t.me/SoalfLove'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inlin_key(Chat_id,Text,inline)
local listPhoto = database:smembers(bot_id.."List:Filter:Photo"..delallph)  
for k,v in pairs(listPhoto) do  
database:srem(bot_id.."List:Filter:Photo"..delallph,v)  
end  
end

if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'*♡∶ تم حذف الامر*')  
else
send(msg.chat_id_, msg.id_,'*♡∶ لا يوجد امر بهذا الاسم*')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التحشيش") then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_, '*♡∶ تم تعطيل اوامر التحشيش*')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التحشيش") then
 if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_, ' *♡∶ تم تفعيل اوامر التحشيش*')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (database:get(bot_id..'Name:Bot') or 'ايكان')
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيك بهاذا' and tonumber(msg.reply_to_message_id_) > 0 then    
 if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 💋🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير الحب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' تحب هذا' and tonumber(msg.reply_to_message_id_) > 0 then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'♡∶ يروح '..Namebot..' يرجى الاشتراك بقناتي \n ♡∶ حتى انفذ اوامرك حبيبي \n ♡∶ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني ','يولي ماحبه ',' لٱ ايع ','بس لو الكفها اله اعضها 💔','ماخب مطايه اسف','اكلك ۿذﭑ يكلي احبكك لولا ﭑݩٺ شتكول  ','ئووووووووف اموت ع ربه ','ايععععععععع','بلعباس اعشكك','ماحب مخابيل','احبب ميدو وبس','لٱ ماحبه','بله هاي جهره تكلي تحبهه ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئلني احبهم لولا','افبس حبيبي هذا' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = '*ارسل اسمك واسم الشخص الثاني،*  \n *مثال اسد و لبوى*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
sl = '*نسبه حب* '..text..' *هي :* '..sendnum..'*%*'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = '*ارسل اسمك واسم الشخص الثاني،*  \n *مثال اسد و لبوى*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
sl = '*نسبه كره* '..text..' *هي :* '..sendnum..'*%*'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = '*ارسل اسم الشخص الذي تريد قياس نسبه رجولته* \n *مثال ايكان*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = '*نسبه رجوله* '..text..' *هي :* \n '..sendnuj..'*%*'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = '*ارسل اسم الشخص الذي تريد قياس نسبه انوثتها* \n *مثال نونه*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = '*نسبه الانوثه* '..text..' *هي :* \n '..sendnuj..'*%*'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
AEKAN = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(AEKAN)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,aeko) local admins = aeko.members_ for i=0 , #admins do if aeko.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
AEKAN = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(AEKAN)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,aeko) local admins = aeko.members_ for i=0 , #admins do if aeko.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceAEKAN(data.message_,data)
plugin_mjnonh(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n*♡∶ شخص ما يحاول تعديل الميديا* \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*♡∶ لا يوجد ادمنيه*"
end
send(msg.chat_id_,0,''..t..'\n*•━━━━━━━━━━━━━•*ٴ\n♡∶ تم التعديل على الميديا\n♡∶ الشخص الي قام بالتعديل\n♡∶ ايدي الشخص ← `'..result.sender_user_id_..'`\n♡∶ معرف الشخص←{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."Lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."Lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."Lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."Lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("[hH][tT][tT][pP][sT]") or text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."Lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("#") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local AEKANAbot = database:get(bot_id.."AEKAN1:Add:Filter:Rp2"..text..result.chat_id_)   
if AEKANAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"*♡∶ العضو ⤙* : {["..data.first_name_.."](T.ME/"..data.username_..")}\n♡∶["..AEKANAbot.."] \n") 
else
send(msg.chat_id_,0,"*♡∶ العضو ⤙* : {["..data.first_name_.."](T.ME/SoalfLove)}\n♡∶["..AEKANAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local AEKAN1_Msg = database:get(bot_id.."AEKAN1:Add:Filter:Rp2"..text..result.chat_id_)   
if AEKAN1_Msg then    
send(msg.chat_id_, msg.id_,"♡∶"..AEKAN1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------

elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg
end -- end callback
















