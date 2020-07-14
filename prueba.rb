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
    
    #new_hash={}
    i=0
    html=""
    
    for i in (0..24) 
        html=  "\n>\t<li><img src=\"#{data["photos"][i]["img_src"]}\"></li>"  + html
    end    
    
   encabezado="<html>\n<head>\n</head>\n<body>\n<ul>"
   footer="\n</ul>\n</body>\n</html>"
   File.write('output.html', encabezado + html+footer)
end    


data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=OOEYkgTiuw6p6GNNQCuLYei8BFmxXYBL3y06wo8W') # Limitamos los resultados a 10

build_web_page (data)
