surface.CreateFont( "panel", {
	font = "HUDNumber1", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})
surface.CreateFont( "panel2", {
	font = "HUDNumber1", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})
hook.Add( "OnPlayerChat", "klansistem.menu", function( ply, strText, bTeam, bDead ) 

  strText = string.lower( strText ) 

  if (strText == "/clansystem") then 
    mainframe()
local label2 = vgui.Create("DLabel",frame)
      label2:SetSize(500,500)
      label2:SetPos(35,-170)
      label2:SetFont("panel2")
      label2:SetText("Aşağıdaki Butonları Kullanarak Menülere Erişim Sağlayabilirsin")
local buton = vgui.Create("DButton",frame)
      buton:SetSize(200,50)
       buton:SetPos(20,100)
       buton:SetText("Lonca Oluşturma Menüsü")
       buton.Paint = function()
         draw.RoundedBox( 8, 0, 0, buton:GetWide(), buton:GetTall(), Color( 0, 0, 0, 150 ) )
      end
      buton.DoClick = function()				
        frame:Close()
        klanolustur()
      end
      local buton2 = vgui.Create("DButton",frame)
      buton2:SetSize(200,50)
       buton2:SetPos(270,100)
       buton2:SetText("Baktığın Kişiyi Davet Et")
       buton2.Paint = function()
         draw.RoundedBox( 8, 0, 0, buton2:GetWide(), buton2:GetTall(), Color( 0, 0, 0, 150 ) )
      end
      buton2.DoClick = function()				
         frame:Close()
         net.Start("klansistem.davet")
         net.SendToServer()
      end
      local buton3 = vgui.Create("DButton",frame)
      buton3:SetSize(200,50)
      buton3:SetPos(150,170)
      buton3:SetText("Klandan Ayrıl")
      buton3.Paint = function()
         draw.RoundedBox( 8, 0, 0, buton3:GetWide(), buton3:GetTall(), Color( 0, 0, 0, 150 ) )
      end
      buton3.DoClick = function()
        net.Start("klansistem.ayril")
        net.SendToServer()
        frame:Close()
      end 
      local buton4 = vgui.Create("DButton",frame)
      buton4:SetSize(200,50)
      buton4:SetPos(150,230)
      buton4:SetText("Klan Yönetim")
      buton4.Paint = function()
         draw.RoundedBox( 8, 0, 0, buton3:GetWide(), buton3:GetTall(), Color( 0, 0, 0, 150 ) )
      end
      buton4.DoClick = function()
        net.Start("klansistem.yonetim")
        net.SendToServer()
        frame:Close()
      end 
end

end )
net.Receive("klansistem.yonetimclient", function(len)
local klanismi = net.ReadString()

mainframe()
local label2 = vgui.Create("DLabel",frame)
      label2:SetSize(500,500)
      label2:SetPos(35,-170)
      label2:SetFont("panel2")
      label2:SetText("Aşağıdan Klandan Şuanda Oyunda Olan Kullanıcıları Atabilirsin")

      local buton2 = vgui.Create("DButton",frame)
      buton2:SetSize(200,50)
       buton2:SetPos(40,100)
       buton2:SetText("Yenile(Oyuncuları Yükler)")
       buton2.Paint = function()
         draw.RoundedBox( 8, 0, 0, buton2:GetWide(), buton2:GetTall(), Color( 0, 0, 0, 150 ) )
      end
      buton2.DoClick = function()				
         net.Start("klansistem.yonetimaktifoyuncu")
         net.SendToServer()
      end
net.Receive("klansistem.yonetimaktifoyuncu", function(len)

   local table = net.ReadTable()
   local AppList = vgui.Create( "DListView", frame)
   AppList:SetSize(300,300)
   AppList:SetPos(100,150)
   AppList:SetMultiSelect( false )
   AppList:AddColumn( "Oyuncu" )
   AppList:AddColumn( "SteamID" )
   for k, v in pairs( table ) do
      AppList:AddLine(player.GetBySteamID64( v ):Name() , v)
   end
   
   AppList.OnRowSelected = function( lst, index, pnl )
      selected = pnl:GetColumnText( 2 )
   end
   local buton23 = vgui.Create("DButton",frame)
   buton23:SetSize(200,50)
   buton23:SetPos(250,100)
   buton23:SetText("Seçilen Oyuncuyu At")
   buton23.Paint = function()
      draw.RoundedBox( 8, 0, 0, buton2:GetWide(), buton2:GetTall(), Color( 0, 0, 0, 150 ) )
   end
   buton23.DoClick = function()				
  --    if(selected == nil) then LocalPlayer():ChatPrint("Oyuncu Seçilmedi!"); return; end
      net.Start("klansistem.yonetimoyuncuat")
      net.WriteString(selected)
      net.SendToServer()
   end
end)
end)
function mainframe()
   frame = vgui.Create("DFrame")
   frame:SetTitle("Last's Clan System")
   frame:MakePopup()
   frame:SetPos(100,200)
   frame:SetSize(500, 500)
   frame.Paint = function()
     draw.RoundedBox( 8, 0, 0, frame:GetWide(), frame:GetTall(), Color( 0, 0, 0, 230 ) )
  end
   

local label = vgui.Create("DLabel",frame)
   label:SetSize(500,500)
   label:SetPos(50,-200)
   label:SetFont("panel")
   label:SetText("Yonca Menüsüne Hoşgeldin")
end
function adminmenusu()


end

net.Receive("klansistem", callback)
function klanolustur()
mainframe()

local label = vgui.Create("DLabel",frame)
   label:SetSize(500,500)
   label:SetPos(20,-170)
   label:SetFont("panel2")
   label:SetText("Lonca Oluşturmak İçin Lonca Adını Girin")

local giris = vgui.Create("DTextEntry",frame)
   giris:SetPos(20,140)
   giris:SetSize(200,50)
   giris.OnEnter = function(self) self:SetValue(self:GetValue()) end
  
local buton = vgui.Create("DButton",frame)
   buton:SetSize(200,50)
   buton:SetPos(20,210)
   buton:SetText("Lonca Oluştur")
   buton.Paint = function()
      draw.RoundedBox( 8, 0, 0, buton:GetWide(), buton:GetTall(), Color( 0, 0, 0, 150 ) )
   end
   buton.DoClick = function()
     local klanadi = giris:GetValue()  
     net.Start("klansistem.olustur")
     net.WriteString(klanadi)
     net.SendToServer()
     frame:Close()
   end 
end



net.Receive("klansistem.davetgonder",function(len,ply)
local klanismi = net.ReadString()
mainframe()
local label2 = vgui.Create("DLabel",frame)
      label2:SetSize(500,500)
      label2:SetPos(35,-170)
      label2:SetFont("panel2")
      label2:SetText(klanismi .. " Klanına Davet Edildin!")
local buton = vgui.Create("DButton",frame)
      buton:SetSize(200,50)
       buton:SetPos(20,100)
       buton:SetText("Daveti Kabul Et")
       buton.Paint = function()
         draw.RoundedBox( 8, 0, 0, buton:GetWide(), buton:GetTall(), Color( 0, 0, 0, 150 ) )
      end
      buton.DoClick = function()	
         net.Start("klansistem.davetgondercevap")
         net.WriteString("onay")
         net.SendToServer()
         frame:Close()			
      end
      local buton2 = vgui.Create("DButton",frame)
      buton2:SetSize(200,50)
       buton2:SetPos(270,100)
       buton2:SetText("Daveti Reddet")
       buton2.Paint = function()
         draw.RoundedBox( 8, 0, 0, buton2:GetWide(), buton2:GetTall(), Color( 0, 0, 0, 150 ) )
      end
      buton2.DoClick = function()
         net.Start("klansistem.davetgondercevap")
         net.WriteString("red")
         net.SendToServer()				
         frame:Close()
      end
end)