-- LastPlayer#7913
-- KRİSTO DİSCORDDAN YAZARAK ÇOK DESTEK OLDU , ÖZEL TEŞEKKÜRLERİMİ SUNARIM
print("-----Klan Sistemi-----")
util.AddNetworkString("klansistem.olustur")
util.AddNetworkString("klansistem.ayril")
util.AddNetworkString("klansistem.davet")
util.AddNetworkString("klansistem.yonetim")
util.AddNetworkString("klansistem.yonetimclient")
util.AddNetworkString("klansistem.yonetimaktifoyuncu")
util.AddNetworkString("klansistem.davetgonder")
util.AddNetworkString("klansistem.davetgondercevap")
util.AddNetworkString("klansistem.yonetimoyuncuat")
net.Receive("klansistem.yonetimaktifoyuncu", function(len,ply)
if(timer.Exists(ply:SteamID64() .. "-klansistem.antispam")) then ply:ChatPrint("Anti Spam") return end
if (!klansahibimi(ply)) then ply:ChatPrint("Anti Cheat"); return end
timer.Create(ply:SteamID64() .. "-klansistem.antispam", 5, 1 , function()
timer.Destroy(ply:SteamID64() .. "-klansistem.antispam")
end)
local klanismiz = klanismi(ply)
local aktifoyuncular = {}
for k, v in pairs( player.GetAll() ) do
   if(klanismiz == klanismi(v) ) then 
    table.insert(aktifoyuncular,v:SteamID64()) 
  end
end
net.Start("klansistem.yonetimaktifoyuncu")
net.WriteTable(aktifoyuncular)
net.Send(ply)
net.Receive("klansistem.yonetimoyuncuat", function(len,ply)
  local read = net.ReadString()
  local vic = player.GetBySteamID64(read)
  if(timer.Exists(ply:SteamID64() .. "-klansistem.antispam")) then ply:ChatPrint("Anti Spam") return end
  if (!klansahibimi(ply)) then ply:ChatPrint("Anti Cheat"); return end
  if (klansahibimi(vic)) then ply:ChatPrint("Kendini Atamazsın"); return end
  timer.Create(ply:SteamID64() .. "-klansistem.antispam", 5, 1 , function()
  timer.Destroy(ply:SteamID64() .. "-klansistem.antispam")
  end)
  local klanismiz = klanismi(ply)
  
  file.Delete("loncasystem/players/" .. vic:SteamID64() .. ".txt")
  vic:ChatPrint("Klandan Atıldın!")
  ply:ChatPrint(vic:Name() .. " Klandan Atıldı!")

end)

end)
net.Receive("klansistem.olustur", function(len,ply)
local steamid = ply:SteamID64()
local klanismi = net.ReadString()
print(klanismi)
  if(file.Exists("loncasystem/players/" .. steamid .. ".txt", "DATA")) then 
    if(klansistemchecker(klanismi)) then ply:ChatPrint("Klan İsmi Alınmış!"); return end
    if(klanivarmi(ply)) then ply:ChatPrint("Klanın Zaten Var!"); return end
    ply:ChatPrint("Klanınız Oluşturulacak")
    klanolusturserver(klanismi , ply)
    klanolusturoyuncu(klanismi ,ply)
    return
  else
  ply:ChatPrint("Sunucu İlk Verinizi Oluşturacak")
  oyuncudataolustur(ply)
  if(klansistemchecker(klanismi)) then ply:ChatPrint("Klan İsmi Alınmış!"); return end
  if(klanivarmi(ply)) then ply:ChatPrint("Klanın Zaten Var!"); return end
  ply:ChatPrint("Klanınız Oluşturulacak")
  klanolusturserver(klanismi , ply)
  klanolusturoyuncu(klanismi ,ply)
  return
  end
  ply:Kick("Anti Bug")
end)

net.Receive("klansistem.davet", function(len,ply)
local lookply = ply:GetEyeTrace().Entity
  if (!lookply:IsPlayer()) then ply:ChatPrint("Geçersiz Bir Şeye Bakıyorsun") ; return; end
if(!klanivarmi(ply)) then ply:ChatPrint("Klanın Olmadan Alım Yapamazsın!"); return end
if(!klansahibimi(ply)) then ply:ChatPrint("Klan Sahibi Olmadan Klana Alım Yapamazsın!"); return end
 -- if(klanivarmi(lookply)) then ply:ChatPrint("Baktığın Kişi Zaten Klanda!"); return end
ply:ChatPrint(lookply:Name() .. " Kişinine Klan Daveti Gönderildi!")
lookply:SetPData("davet", klanismi(ply))
lookply:SetPData("daveteden", ply:SteamID64())
net.Start("klansistem.davetgonder")
net.WriteString(klanismi(ply))
net.Send(lookply)
end)
net.Receive("klansistem.davetgondercevap", function(len,ply)
if(net.ReadString() == "red") then ply:RemovePData("davet"); return end
local klanismi = ply:GetPData("davet")
local ply2 = player.GetBySteamID64( ply:GetPData("daveteden") )
ply2:ChatPrint(ply:Name() .. " İsteğini Onayladı!")
klanakatil(klanismi , ply)
ply:ChatPrint(klanismi .. " Klanına Başarıyla Katıldın")
ply:RemovePData("davet")
ply:RemovePData("daveteden")
end)
print("[KLAN] NETWORK YÜKLENDİ")
net.Receive("klansistem.ayril", function(len,ply)
if(klansahibimi(ply)) then 
klansil(ply)
end
file.Delete("loncasystem/players/" .. ply:SteamID64() .. ".txt")
ply:ChatPrint("Verilerin Tamamen Temizlendi!")
ply:ChatPrint("Eğer Klan Sahibiysen Klanın Sunucu Dosyalarıdan Silindi!")
end)
net.Receive("klansistem.yonetim", function(len,ply)
  if(klansahibimi(ply)) then 
    net.Start("klansistem.yonetimclient")
    net.WriteString(klanismi(ply))
    net.Send(ply)
    return
  end
  ply:ChatPrint("Klan Sahibi Değilsin")
end)
function klansil(ply)
  local data = file.Read("loncasystem/loncalar.txt", "DATA")
  if not data then  print("LastPlayer#7913 İle İletişime Geçin"); return; end
  data = string.Split(data, "\n")
  for k, v in pairs( data ) do
    if(v == klanismi(ply)) then table.RemoveByValue( data, v )  end
  end
  file.Delete("loncasystem/loncalar.txt")
  for k, v in pairs( data ) do

    file.Append("loncasystem/loncalar.txt", v .. "\n")
  end
end
function klansistemchecker(klanismi)

  local data = file.Read("loncasystem/loncalar.txt", "DATA")
  if not data then  print("LastPlayer#7913 İle İletişime Geçin"); return; end
  data = string.Split(data, "\n")
  for k, v in pairs( data ) do
	  if(v == klanismi) then return true end
  end
  return false
end
function klanolusturserver(klanismi , ply)

local data = file.Read("loncasystem/loncalar.txt", "DATA")
file.Append("loncasystem/loncalar.txt", klanismi .. "\n")
ply:ChatPrint("Klanınız Oluşturuldu")
end
function oyuncudatasivarmi(ply)
  if(file.Exists("loncasystem/players/" .. ply:SteamID64() .. ".txt", "DATA")) then 

    return true
  else

  return false
  end
end
function klanolusturoyuncu(klanismi , ply)
  file.Write("loncasystem/players/" .. ply:SteamID64() .. ".txt", klanismi ..";true;")
end
function klanakatil(klanismi , ply)
  file.Write("loncasystem/players/" .. ply:SteamID64() .. ".txt", klanismi ..";false;")
end
function klanivarmi(ply)
  if(!oyuncudatasivarmi(ply)) then return false end
local data = file.Read("loncasystem/players/" .. ply:SteamID64() .. ".txt" , "DATA")
data = string.Split(data, ";")
print(data[1])
if (data[1 ] == "false") then return false end
return true
end
function klanismi(ply)
  if(!oyuncudatasivarmi(ply)) then return "Klan Yok" end
  local data = file.Read("loncasystem/players/" .. ply:SteamID64() .. ".txt" , "DATA")
  data = string.Split(data, ";")
  if (data[1] == "false") then return "Klan Yok" end
  return data[1]
end
function klansahibimi(ply)
  if(!oyuncudatasivarmi(ply)) then return false end
  local data = file.Read("loncasystem/players/" .. ply:SteamID64() .. ".txt" , "DATA")
  data = string.Split(data, ";")
  if (data[2] == "false") then return false end
  print(data[2])
  return true
  end
function oyuncudataolustur(ply)
  
file.Write("loncasystem/players/" .. ply:SteamID64() .. ".txt", "false;false;")
ply:ChatPrint("Sunucu İlk Verinizi Oluşturdu")
end
print("[KLAN] Fonksiyonlar Yüklendi")
-- SOMETHING BUT ILLEGAL
-- PVP SİSTEMİ ENTEGRASYON
local pvplanguage = {}
pvplanguage.pvpdisabled = "PVP Devre Dışı"
pvplanguage.pvpmod = "PVP Moduna Geçiriliyorsunuz, Bu İşlem 1 Dakika Sürer"
pvplanguage.pvpmodactive = "PVP Modu Aktifleşti"
pvplanguage.pvemodactive = "PVE Modu Aktifleşti"
pvplanguage.pvemod = "PVE Moduna Geçiriliyorsunuz, Bu İşlem 1 Dakika Sürer"



hook.Add("PlayerSay", "pvpsystem_chatchecker", function( ply, text )
    if string.lower(text) == "!pvp" then
        if timer.Exists( "pvp_" .. ply:SteamID64() ) then ply:ChatPrint(pvplanguage.pvpmod); return end
        if timer.Exists( "pve_" .. ply:SteamID64() ) then ply:ChatPrint(pvplanguage.pvemod); return end
        timer.Create( "pvp_" ..ply:SteamID64() , 60, 1, function()  
          pvpaktif(ply)
        end)
        ply:ChatPrint(pvplanguage.pvpmod)
    end
    if string.lower(text) == "!pve" then
        if timer.Exists( "pvp_" .. ply:SteamID64() ) then ply:ChatPrint(pvplanguage.pvpmod); return end
        if timer.Exists( "pve_" .. ply:SteamID64() ) then ply:ChatPrint(pvplanguage.pvemod); return end
        timer.Create( "pve_" ..ply:SteamID64() , 60, 1, function()
        pveaktif(ply)  
      end)
        ply:ChatPrint(pvplanguage.pvemod)
    end

end)
function pvpaktif(ply)
    ply:SetNWString( "pvpenable", 1 )
    ply:ChatPrint(pvplanguage.pvpmodactive)

end
function pveaktif(ply)
    ply:SetNWString( "pvpenable", 0 )
    ply:ChatPrint(pvplanguage.pvemodactive)

end

 
function pvp_shouldtakedamage(vic, att)
  return true
end
 
hook.Add( "PlayerShouldTakeDamage", "pvp_shouldtakedamage", pvp_shouldtakedamage)
print("[KLAN] Pvp Modülü Yüklendi")

print("[KLAN] Created By LastPlayer")
print("-----Klan Sistemi-----")