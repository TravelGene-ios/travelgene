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

def parseHotel(url):
    html = url_open(url)
    soup = BeautifulSoup(html,"html5lib")
    dump_url(url)
    res = {}
    get_title(soup,res)
    get_hotel_address(soup,res)
    get_reviews(soup, res)
    get_ratings(soup, res)
    get_hotel_img(soup, res)
    get_hotel_class(soup, res)
    res['category'] = 'hotel';
    return res

def get_hotel_img(element, res):
    img_url=""
    if element.find("div",attrs={"id":"BC_PHOTOS"}) == None:
        img_div=element.find("div", attrs={"id":"HR_HACKATHON_CONTENT"})
        img_url_obj=img_div.find("img",attrs={"class":"sizedThumb_thumbnail"})
        if img_url_obj:
            img_url = str(img_url_obj["src"])
        else:
            img_url_container=img_div.find("div",attrs={"class":"sizedThumb_container"})
            if img_url_container:
                img_url = str(img_url_container.find("img")["src"])
        print img_url
    else:
        img_div=element.find("div",attrs={"id":"BC_PHOTOS"})
        if img_div.find("span")== None:
            pass
        else:
            img_span=img_div.find("span")
            if img_span.find("img")['src']== None:
                pass
            else:
                img_url=str(img_span.find("img")['src'])
                print img_url
    res['img_url']=str(img_url)

def get_hotel_address(element, res):
    info = element.find("div",attrs={"class":"header_contact_info"})
    if info==None:
        res['address']=None
        return
    address = ""
    for part in info.find_all("span",attrs={"class":"format_address"}):
        address += part.text
    res['address'] = str(address.strip())

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

def getHotel():
    i = 1
    res = []
    for line in open('Hotels_List.json').xreadlines():
        print i,"++++",line
        i = i + 1
        res.append(parseHotel(line))
        writeToFile2(res,"Hotels")

def openFile(catagory):
    filename = catagory+"_out.json"
    print "Open File:" + filename
    f = open(filename, "a")
    return f

def writeToFile(res,f):
    json.dump(res, f)
    f.write("\n")
    print "writeToFileDone"
    
def closeFile(f):
    f.close()

def writeToFile2ß(res,catagory):
    filename = catagory+"_out.json"
    print "WriteToFile" + filename
    f = open(filename, "a")
    json.dump(res, f)
    f.write("\n")
    print "a"
    f.close()


if __name__ == "__main__":
    getHotel()
