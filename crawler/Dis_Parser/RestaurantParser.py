'''
Web crawler for TripAdvisor
'''


from bs4 import BeautifulSoup
import re
import json
import sys
import time
import random
import urllib2
import httplib
import html5lib
def url_open(pageUrl):
    headers = {  'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'  , 'Referer':'https://itunes.apple.com'} 
    req = urllib2.Request(  url = pageUrl,   headers = headers  )
    contents=""
    try:
        response = urllib2.urlopen(req)
        contents= response.read()
    except (httplib.BadStatusLine, urllib2.HTTPError, Exception):
        print str(Exception) + '---OpenUrlError---'
    return contents

def dump_url(url):
    content = url_open(url)
    fname = "html/" + url.split("/")[-1]
    f = open(fname, "w+")
    f.write(content)
    f.close()
    return BeautifulSoup(content)

def get_title(element, res):
    title = element.find("h1")
    if title:
        res["title"] = str(title.text.strip().encode('utf-8'))
    else:
        res["title"] = "Unknown"

def get_reviews(element, res):
    try:
        reviewlist=[]
        review=element.find("div",attrs={"id":"REVIEWS"})     
        reviews=review.find_all("div",attrs={"class":"reviewSelector"})      
        for r in reviews:
            ret = r.find("p",attrs={"class":"partial_entry"})
            if ret != None:
                d = str(ret.text.encode('utf-8'))
                reviewlist.append(d)
        res['review_list']=reviewlist
    except (AttributeError):
        res['review_list']=[]

def get_ratings(element, res):
    try:    
        rating_div=element.find("div",attrs={"class":"rs rating"})
        cnt=rating_div.find("a")
        rate=rating_div.find("img")
        if 'content' in cnt.attrs:
            res['review_count']=str(cnt["content"])
        else:
            res['review_count']=0

        if 'content' in rate.attrs:
            res['rating_string']=str(rate["content"])
        else:
            res['rating_string']=0

    except (KeyError, AttributeError):
        res['review_count']="Unknown"
        res['rating_string']="Unknown"
def get_restaurant_openhour(element, res):
    open_div=""
    if element.find("div",attrs={"class":"time"})==None:
        pass
    else:
        open_div=element.find("div",attrs={"class":"time"}).text
    print open_div
    res["open_hour"]=open_div

def get_restaurant_address(element,res):
    address = ""
    address = element.find("address").find("span").text
    res['address'] = str(address.strip())

def get_restuarant_img(element, res):
    img_url=""
    img_div=element.find("div",attrs={"class":"flexible_photos"})
    img_url=img_div.find("img",attrs={"id":"HERO_PHOTO"})['src']
    print img_url
    res['img_url']=str(img_url)

def get_restaurant_price_range(element, res):
    try:
        price_range_div=element.find("div",attrs={"class":"detail first price_rating separator"})
        if price_range_div:
            dollar = price_range_div.text
            range = dollar.count('$')
            res['price_range'] = range
        else:
            res['price_range'] = 0
    except (AttributeError):
        res['price_range']="Unknown"

def parseRestaurant(url):
    html = url_open(url)
    time.sleep(1)
    soup = BeautifulSoup(html, "html5lib")
    dump_url(url)
    print url
    res = {}
    get_title(soup,res)
    get_restaurant_address(soup,res)
    get_ratings(soup,res)
    get_reviews(soup,res)
    get_restaurant_openhour(soup, res)
    get_restaurant_price_range(soup, res)
    res['category'] = 'restaurant'
    get_restuarant_img(soup, res)
    return res

def getRest(jsonName):
    i = 1
    res = []
    j = 1
    var f = openFile("Restaurant",j)
    for line in open(jsonName).xreadlines():
        print i,"++++",line
        i = i + 1
        if i % 200 == 0:
            closeFile(f)
            j = j + 1
            f = openFile("Restaurant",j)
        res.append(parseRestaurant(line))
        writeToFile(res,f)
    closeFile(f)

def openFile(catagory, j):
    filename = catagory+str(j)+"_out.json"
    print "Open File:" + filename
    f = open(filename, "a")
    return f

def writeToFile(res,f):
    json.dump(res, f)
    f.write("\n")
    print "writing ToFile"
    
def closeFile(f):
    f.close()

if __name__ == "__main__":
    #parameter is the name of file part of the restaurant list
    name = sys.argv[1]
    getRest(name)
