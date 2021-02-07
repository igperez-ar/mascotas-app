import urllib.request
import ssl

iconsIndex = ['265', '266', '268', '270', '272', '274', '276', '277', '278', '279', '280', '281', '282', '283', '284', '285', '286', '287', '288', '289', '290', '291', '292', '293', '294', '295', '296', '297', '298', '299', '300', '301', '302', '303', '304', '305', '306']
urlBase = 'https://image.flaticon.com/icons/svg/3011/3011'

gcontext = ssl.SSLContext()

for item in iconsIndex:
    url = urlBase + item + '.svg'
    name = "pic_" + item + '.svg'
    imagen = urllib.request.urlopen(url, context=gcontext).read()
    
    with open(name, 'wb') as handler:
        handler.write(imagen)
        handler.close()
        print("Image " + url + " saved.")

    