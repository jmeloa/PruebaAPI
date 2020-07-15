require 'json'
require 'uri'
require 'net/http'
def request(url_requested)
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    return JSON.parse(response.body)
end

def build_web_page(data)
    html=""
    new_hash={}
    new_hash=data["photos"]
    new_hash.each do |k,v| 
        html=  "\n>\t<li><img src=\"#{k["img_src"]}\"></li>"  + html
    end
    encabezado="<html>\n<head>\n</head>\n<body>\n<ul>"
    footer="\n</ul>\n</body>\n</html>"
    File.write('output.html', encabezado + html+footer)
end    

def photos_count(data)
#Crear un método photos_count que reciba el hash de respuesta y devuelva
#un nuevo hash con el nombre de la camara y la cantidad de fotos.
    new_hash={}
    nh2={}
    ctd=0
    new_hash=data["photos"]
    new_hash.each do |k,v| 
        nh2[ctd] = k["camera"]["full_name"]
        ctd=ctd+1
    end
    #puts nh2[0]
    nh3={}
    nh4={}
    nh3= nh2.keys.group_by { |k| nh2[k] }
    #puts nh3
    ctd=0
    nh3.each do |k,v|
        puts k + " " + nh3[k].count.to_s 
    end

end

web="https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key="
key="OOEYkgTiuw6p6GNNQCuLYei8BFmxXYBL3y06wo8W"
data = request(web+key) # Limitamos los resultados a 10

build_web_page (data)
photos_count (data)

