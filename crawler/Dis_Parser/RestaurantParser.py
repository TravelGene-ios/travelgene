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
        print str(Exception) + ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

    return contents

def dump_url(url):
    # print "xxxxx", url
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

def get_hotel_class(element, res):
    try:
        class_img_div = element.find("img",attrs={"class":"sprite-rating_cl_gry_fill rating_cl_gry_fill cl_gry30"})
        if class_img_div:
            score_alt = class_img_div['alt']
            hotel_class = score_alt.split(" ")[0]
            if hotel_class:
                res['class'] = str(hotel_class)
    except (AttributeError):
        res['class'] = "Unknown"
#using scrapy could crawl the description data
def get_description(element, res):
    descp = element.find("div",attrs={"id":"BODYCON"}).find("div",attrs={"class":"answers_in_head"})
    print descp
    print "@@@@@@@@@@@@@1"


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
            # print reviewlist
    except (AttributeError):
        res['review_list']=[]

def get_ratings(element, res):
    try:    
        rating_div=element.find("div",attrs={"class":"rs rating"})
        cnt=rating_div.find("a")
        rate=rating_div.find("img")
        if 'content' in cnt.attrs:
            res['review_count']=str(cnt["content"])
            # cnt.attrs.get('content', 'Unknown')
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
    # print img_div
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
    for line in open(jsonName).xreadlines():
        print i,"++++",line
        i = i + 1
        res.append(parseRestaurant(line))
        writeToFile2(res,jsonName+"out")



def writeList(li,catagory):
    filename = catagory+"_List.json"
    print filename + "       is a list"
    f = open(filename, "w")
    for item in li:
       f.write(str(item)+'\n')
    f.close()

def openFile(catagory):
    filename = catagory+"_out.json"
    print filename + "       &&&&&&&&&&&&&&&&&"
    f = open(filename, "a")
    return f
def writeToFile(res,f):
    json.dump(res, f)
    f.write("\n")
    print "a"

def closeFile(f):
    f.close()
def writeToFile2(res,catagory):
    filename = catagory+"_out.json"
    print filename + "       &&&&&&&&&&&&&&&&&"
    f = open(filename, "a")

    json.dump(res, f)
    f.write("\n")
    print "a"

    f.close()

if __name__ == "__main__":
    name = sys.argv[1]
    getRest(name)
